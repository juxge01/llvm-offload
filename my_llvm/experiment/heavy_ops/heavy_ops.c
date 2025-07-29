/* heavy_ops.c
   ──────────────────────────────────────────────────────────────
   1) 64×64×64 텐서-행렬 곱 (Batched GEMM)
   2) 32×32 입력에 5×5 커널 16채널 2-D Convolution
   3) 4096-pt FFT (Cooley-Tukey radix-2, 실수부만)
   4) GELU + LayerNorm 파이프라인
   5) Blelloch prefix-sum 스캔
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <complex.h>
#include "dma_runtime.h"

#define BS 64
#define N  64
#define C_IN  16
#define H  32
#define W  32
#define K  5
#define VLEN 4096
#define LOG2_N 12            /* 2^12 = 4096 */

/* 1 ───── Batched GEMM (B, N, N) */
void batched_gemm(float A[BS][N][N], float B[BS][N][N], float C[BS][N][N]) {
  for (int b=0;b<BS;++b)
    for (int i=0;i<N;++i)
      for (int j=0;j<N;++j) {
        float s=0.0f;
        for (int k=0;k<N;++k)
          s += A[b][i][k]*B[b][k][j];
        C[b][i][j]=s;
      }
}

/* 1 ───── Batched GEMM (B, N, N) */
void batched_gemm_accel(float A[BS][N][N],
  float B[BS][N][N],
  float C[BS][N][N])
{
  const unsigned long DEV_A = 0x40000000;
  const unsigned long DEV_B = 0x40040000;
  const unsigned long DEV_C = 0x40080000;
  size_t sz_mat = BS*N*N*sizeof(float);

  /* 1‑A : 입력 DMA */
  dma_kick((uintptr_t)A, DEV_A, sz_mat, 0);
  dma_kick((uintptr_t)B, DEV_B, sz_mat, 0);
  dma_wait();

  /* 1‑B : 커스텀 연산 트리거 */
  asm volatile (".insn r 0x7b, 0, 0, x0, %0, %1"
                :
                : "r"(DEV_A), "r"(DEV_B)
                : "memory");

  /* 1‑C : 출력 DMA */
  dma_kick((uintptr_t)C, DEV_C, sz_mat, 1);
  dma_wait();
}

/* 2 ───── 2-D convolution, 1 batch */
void conv2d(const float in[C_IN][H+K-1][W+K-1],
            const float w[C_IN][K][K],
            float out[H][W]) {
  for(int h=0;h<H;++h)
    for(int w2=0;w2<W;++w2){
      float acc=0.0f;
      for(int c=0;c<C_IN;++c)
        for(int kh=0;kh<K;++kh)
          for(int kw=0;kw<K;++kw)
            acc += in[c][h+kh][w2+kw]*w[c][kh][kw];
      out[h][w2]=acc;
    }
}

/* 3 ───── iterative in-place radix-2 FFT (real→complex) */
void fft_4096(float complex *x){
  for(int s=1;s<=LOG2_N;++s){
    int m=1<<s;
    int m2=m>>1;
    float complex wm=cexp(-I*M_PI/m2);
    for(int k=0;k<4096;k+=m){
      float complex w=1;
      for(int j=0;j<m2;++j){
        float complex t=w*x[k+j+m2];
        float complex u=x[k+j];
        x[k+j]=u+t;
        x[k+j+m2]=u-t;
        w*=wm;
      }
    }
  }
}

/* 4 ───── GELU + LayerNorm */
void gelu_layernorm(float *v, int n){
  double sum=0, sq=0;
  for(int i=0;i<n;++i){
    /* GELU approximation */
    float x=v[i];
    float y=0.5f*x*(1.0f+tanhf(0.79788456f*(x+0.044715f*x*x*x)));
    v[i]=y;
    sum+=y; sq+=y*y;
  }
  double mean=sum/n;
  double var=sq/n-mean*mean+1e-5;
  double inv_std=1.0/sqrt(var);
  for(int i=0;i<n;++i)
    v[i]=(v[i]-mean)*inv_std;
}

/* 5 ───── Blelloch scan (prefix-sum) */
void prefix_sum(int *v,int n){
  /* upsweep */
  for(int d=1;d<n;d<<=1)
    for(int i=0;i<n;i+=2*d)
      v[i+2*d-1]+=v[i+d-1];
  v[n-1]=0; /* set last to 0 */
  /* downsweep */
  for(int d=n>>1;d>=1;d>>=1)
    for(int i=0;i<n;i+=2*d){
      int t=v[i+d-1];
      v[i+d-1]=v[i+2*d-1];
      v[i+2*d-1]+=t;
    }
}

/* ───── main ───────────────────────────────────────────── */
int main(void){
  /* 1) GEMM */
  static float A[BS][N][N],B[BS][N][N],C[BS][N][N];
  for(int b=0;b<BS;++b)for(int i=0;i<N;++i)for(int j=0;j<N;++j){
    A[b][i][j]=((b+i+j)&7)*0.01f;
    B[b][i][j]=((b-i+j)&3)*0.02f;
  }
  batched_gemm(A,B,C);
  batched_gemm_accel(A,B,C); 

  printf("C[0][0][0]=%f\n",C[0][0][0]);

  /* 2) Conv */ 
  static float IN[C_IN][H+K-1][W+K-1]={0}, Wt[C_IN][K][K]={0}, O[H][W];
  for(int c=0;c<C_IN;++c)for(int i=0;i<K;++i)for(int j=0;j<K;++j)
    Wt[c][i][j]=(c+i+j)*0.01f;
  conv2d(IN,Wt,O);
  printf("O[0][0]=%f\n",O[0][0]);

  /* 3) FFT */
  static float complex sig[4096];
  for(int i=0;i<4096;++i) sig[i]=sin(2*M_PI*50*i/4096);
  fft_4096(sig);
  printf("FFT[1]=%f%+fi\n",(float)creal(sig[1]),(float)cimag(sig[1]));

  /* 4) GELU+LN */
  float *vec=malloc(VLEN*sizeof(float));
  for(int i=0;i<VLEN;++i) vec[i]=(float)i/2048.0f-1.0f;
  gelu_layernorm(vec,VLEN);
  printf("vec[0]=%f\n",vec[0]);

  /* 5) Scan */
  int *arr=malloc(VLEN*sizeof(int));
  for(int i=0;i<VLEN;++i) arr[i]=1;
  prefix_sum(arr,VLEN);
  printf("scan[%d]=%d\n",VLEN-1,arr[VLEN-1]);

  free(vec); free(arr);
  return 0;
}

