#!/bin/bash
VMFB_BASE=./sample.vmfb

sudo cpupower frequency-set --governor performance

# -----------------------------------------------------------------------------
# 1. 순수 타이밍 벤치마크
# -----------------------------------------------------------------------------

echo "\n▶ Running timing benchmark: sample.vmfb"
BENCH_ARGS=(
  --device=local-task
  --function=main
  --input="1x224x224x3xf32=0"
  --benchmark_repetitions=10
  --benchmark_min_time=5.0
  -o /dev/null
)

iree-benchmark-module --module="${VMFB_BASE}" "${BENCH_ARGS[@]}" \
  | tee "sample.timing.txt"
echo "↳ wrote sample.timing.txt"
echo

# -----------------------------------------------------------------------------
# 2. perf record
# -----------------------------------------------------------------------------

echo "▶ Running perf sampling"
export PERF_JITDUMP=1
PERF_ARGS=(--call-graph dwarf -g)

perf record "${PERF_ARGS[@]}" -o "sample.data" \
  iree-benchmark-module --module="${VMFB_BASE}" "${BENCH_ARGS[@]}"

echo "↳ Use: perf report -i sample.data"
echo

sudo cpupower frequency-set --governor powersave
echo "✅ Done. Results: sample.timing.txt, sample.data"
