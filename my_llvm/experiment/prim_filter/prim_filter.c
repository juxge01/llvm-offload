/* prime_filter.c : read ints → keep primes → sort → write result */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

/* ---------- 유틸 ---------- */
static bool isPrime(int n) {                /* 재귀 이용 (√n 이하만 검사) */
    if (n < 2) return false;
    for (int i = 2; i * i <= n; ++i)
        if (n % i == 0) return false;
    return true;
}

/* 정렬용 비교 함수 포인터 */
static int intCmp(const void *a, const void *b) {
    return (*(const int *)a) - (*(const int *)b);
}

/* ---------- 데이터 구조 ---------- */
typedef struct {
    int *data;
    size_t size;
    size_t cap;
} IntVec;

static void vecInit(IntVec *v) { memset(v, 0, sizeof *v); }

static void vecPush(IntVec *v, int x) {
    if (v->size == v->cap) {
        v->cap = v->cap ? v->cap * 2 : 8;
        int *tmp = realloc(v->data, v->cap * sizeof *v->data);
        if (!tmp) { perror("realloc"); exit(EXIT_FAILURE); }
        v->data = tmp;
    }
    v->data[v->size++] = x;
}

static void vecFree(IntVec *v) { free(v->data); }

/* ---------- 입출력 ---------- */
static void readInput(const char *path, IntVec *out) {
    FILE *fp = fopen(path, "r");
    if (!fp) { perror(path); exit(EXIT_FAILURE); }

    int x;
    while (fscanf(fp, "%d", &x) == 1)
        if (isPrime(x)) vecPush(out, x);

    fclose(fp);
}

static void writeOutput(const char *path, const IntVec *v) {
    FILE *fp = fopen(path, "w");
    if (!fp) { perror(path); exit(EXIT_FAILURE); }

    for (size_t i = 0; i < v->size; ++i)
        fprintf(fp, "%d\n", v->data[i]);

    fclose(fp);
}

/* ---------- 메인 ---------- */
int main(void) {
    IntVec primes;
    vecInit(&primes);

    readInput("input.txt", &primes);

    qsort(primes.data, primes.size, sizeof(int), intCmp);

    long long sum = 0;
    for (size_t i = 0; i < primes.size; ++i)
        sum += primes.data[i];

    writeOutput("output.txt", &primes);

    if (primes.size) {
        printf("count = %zu, sum = %lld, avg = %.2f\n",
               primes.size, sum, (double)sum / primes.size);
    } else {
        puts("no primes found");
    }

    vecFree(&primes);
    return 0;
}

