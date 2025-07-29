#ifndef DMA_H
#define DMA_H

#include <stdint.h>
#include <stddef.h>

/* 아주 단순한 MMIO DMA 컨트롤러 예시 (DST, SRC, LEN, CTRL) */
#define DMA_BASE 0x40000000UL

static inline void dma_start(void *dst, const void *src, uint32_t size_bytes)
{
    volatile uint32_t *ctrl = (uint32_t *)DMA_BASE;
    ctrl[0] = (uint32_t)dst;        /* DST_ADDR */
    ctrl[1] = (uint32_t)src;        /* SRC_ADDR */
    ctrl[2] = size_bytes;           /* LEN      */
    ctrl[3] = 1;                    /* KICK=1   */
}

static inline void dma_wait_done(void)
{
    volatile uint32_t *ctrl = (uint32_t *)DMA_BASE;
    while (ctrl[3] & 1) { }         /* busy‑wait */
}

#endif /* DMA_H */
