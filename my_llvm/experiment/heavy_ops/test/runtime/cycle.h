#ifndef CYCLE_H
#define CYCLE_H

#include <stdint.h>

/* 64‑bit mcycle 읽기 (RV32) – hi→lo→hi 방식으로 overflow 오류 방지 */
static inline uint64_t rdcycle(void)
{
    uint32_t hi1, lo, hi2;
    asm volatile ("csrr %0, mcycleh" : "=r"(hi1));
    asm volatile ("csrr %0, mcycle"  : "=r"(lo));
    asm volatile ("csrr %0, mcycleh" : "=r"(hi2));
    if (hi1 != hi2)
        asm volatile ("csrr %0, mcycle" : "=r"(lo));   /* overflow 보정 */
    return ((uint64_t)hi2 << 32) | lo;
}

#endif /* CYCLE_H */
