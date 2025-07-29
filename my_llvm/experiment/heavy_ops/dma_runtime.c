#include "dma_runtime.h"

/* ───── DMA 컨트롤러 MMIO 주소 (예시) ────────── */
#define DMA_BASE        0x50000000u
#define DMA_SRC_OFF     0x00
#define DMA_DST_OFF     0x04
#define DMA_SIZE_OFF    0x08
#define DMA_CTRL_OFF    0x0C

#define DMA_CTRL_START  (1u << 0)
#define DMA_CTRL_DIR    (1u << 1)   /* 0 = dev→mem, 1 = mem→dev */
#define DMA_CTRL_BUSY   (1u << 31)
/* ───────────────────────────────────────────── */

static volatile uint32_t * const dma_mmio = (uint32_t *)DMA_BASE;

static inline void mmio_write(uint32_t off, uint32_t val) {
  dma_mmio[off / 4] = val;
}

static inline uint32_t mmio_read(uint32_t off) {
  return dma_mmio[off / 4];
}

void dma_kick(uintptr_t src, uintptr_t dst, uint32_t bytes, int dir)
{
  mmio_write(DMA_SRC_OFF,  (uint32_t)src);
  mmio_write(DMA_DST_OFF,  (uint32_t)dst);
  mmio_write(DMA_SIZE_OFF, bytes);
  mmio_write(DMA_CTRL_OFF, DMA_CTRL_START |
                           (dir ? DMA_CTRL_DIR : 0));
}

void dma_wait(void)
{
  while (mmio_read(DMA_CTRL_OFF) & DMA_CTRL_BUSY)
    ; /* busy‑wait */
}

