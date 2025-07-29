#ifndef DMA_RUNTIME_H
#define DMA_RUNTIME_H

#include <stdint.h>

/* dir = 0 : device→memory  (read)
 * dir = 1 : memory→device  (write)
 */
void dma_kick(uintptr_t src, uintptr_t dst, uint32_t bytes, int dir);
void dma_wait(void);

#endif /* DMA_RUNTIME_H */
