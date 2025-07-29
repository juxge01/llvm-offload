/* dense_ops.c
   - 산술 연산량이 많은 세 가지 커널:
     1) 64×64 행렬 곱(matmul)
     2) 1차원 5-tap FIR 필터(conv)
     3) 실수형 벡터 + 스칼라 혼합(exp-sum)
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define N 64
#define VLEN 4096
#define TAP 5

/* ── 1. 행렬 곱 ───────────────────────────────────────── */
void matmul(const float A[N][N], const float B[N][N], float C[N][N]) {
  for (int i = 0; i < N; ++i)
    for (int j = 0; j < N; ++j) {
      float sum = 0.0f;
      for (int k = 0; k < N; ++k)
        sum += A[i][k] * B[k][j];               /* mul + add → 산술 2N² */
      C[i][j] = sum;
    }
}

/* ── 2. 1-D FIR 필터 ─────────────────────────────────── */
void conv5(const float *in, float *out, const float *coef, int n) {
  for (int i = 0; i < n - TAP + 1; ++i) {
    float acc = 0.0f;
    for (int k = 0; k < TAP; ++k)
      acc += in[i + k] * coef[k];               /* mul + add × TAP */
    out[i] = acc;
  }
}

/* ── 3. exp + sum 벡터 커널 ─────────────────────────── */
float exp_sum(float *v, int n) {
  float total = 0.0f;
  for (int i = 0; i < n; ++i) {
    v[i] = expf(v[i]) + 1.0f;                   /* exp + add */
    total += v[i];
  }
  return total;
}

/* ── 테스트 드라이버(main) ──────────────────────────── */
int main(void) {
  /* 1. matmul */
  static float A[N][N], B[N][N], C[N][N];
  for (int i = 0; i < N; ++i)
    for (int j = 0; j < N; ++j) {
      A[i][j] = (i + j) * 0.01f;
      B[i][j] = (i - j) * 0.02f;
    }
  matmul(A, B, C);
  printf("C[0][0] = %f\n", C[0][0]);

  /* 2. FIR */
  float *in = malloc(VLEN * sizeof(float));
  float *out = malloc(VLEN * sizeof(float));
  float coef[TAP] = {0.1f, 0.15f, 0.5f, 0.15f, 0.1f};
  for (int i = 0; i < VLEN; ++i) in[i] = (float)i / 10.0f;
  conv5(in, out, coef, VLEN);
  printf("out[0] = %f\n", out[0]);

  /* 3. exp + sum */
  float total = exp_sum(out, VLEN);
  printf("total = %f\n", total);

  free(in);
  free(out);
  return 0;
}

