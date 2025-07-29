#include <stdint.h>
#include <stdio.h>
#include "cycle.h"
#include "dma.h"

/* MLIR→LLVM에서 내려올 fused 커널 시그니처 (포인터 4개 예시) */
extern void fused_kernel(float *restrict input,
                         float *restrict weight,
                         float *restrict bias,
                         float *restrict output);

/* 간단한 텐서 크기 정의 (1×64×64×32) */
#define BATCH 1
#define H     64
#define W     64
#define CIN   32
#define COUT  32

#define INPUT_SIZE   (BATCH * H * W * CIN)
#define WEIGHT_SIZE  (CIN * COUT)
#define BIAS_SIZE    (COUT)
#define OUTPUT_SIZE  (BATCH * H * W * COUT)

/* .data 섹션에 고정 – QSPI·SDRAM 없을 때 편하게 쓰려고 */
static float input[INPUT_SIZE];
static float weight[WEIGHT_SIZE];
static float bias[BIAS_SIZE];
static float output[OUTPUT_SIZE];

static void init_tensors(void)
{
    for (unsigned i = 0; i < INPUT_SIZE;  ++i) input[i]  = (float)(i & 0xF);
    for (unsigned i = 0; i < WEIGHT_SIZE; ++i) weight[i] = 0.01f * (float)i;
    for (unsigned i = 0; i < BIAS_SIZE;   ++i) bias[i]   = 0.1f;
}

int main(void)
{
    init_tensors();

    uint64_t start = rdcycle();
    fused_kernel(input, weight, bias, output);   /* 가속 커널 호출 */
    uint64_t stop  = rdcycle();

    printf("elapsed cycles = %llu\n", (unsigned long long)(stop - start));

    /* sanity check – 출력 앞 네 개만 찍어 봄 */
    for (int i = 0; i < 4; ++i)
        printf("output[%d] = %f\n", i, output[i]);

    /* (옵션) 결과 256바이트를 외부 메모리/UART 등으로 DMA 전송 */
    /* dma_start((void *)0x80000000, output, 256); */
    /* dma_wait_done(); */

    while (1) { asm volatile ("wfi"); }          /* 프로그램 정지 */
    return 0;
}
