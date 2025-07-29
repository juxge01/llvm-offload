#!/bin/bash
VMFB_BASE=./mobilenetv3-s.vmfb

sudo cpupower frequency-set --governor performance

# -----------------------------------------------------------------------------
# 1. 순수 타이밍 벤치마크
# -----------------------------------------------------------------------------

echo "\n▶ Running timing benchmark: mobilenetv3-s.vmfb"
BENCH_ARGS=(
  --device=local-task
  --function=main
  --input="1x224x224x3xf32=0"
  --benchmark_repetitions=10
  --benchmark_min_time=5.0
  -o /dev/null
)

iree-benchmark-module --module="${VMFB_BASE}" "${BENCH_ARGS[@]}" \
  | tee "mobilenetv3-s.timing.txt"
echo "↳ wrote mobilenetv3-s.timing.txt"
echo

# -----------------------------------------------------------------------------
# 2. perf record
# -----------------------------------------------------------------------------

echo "▶ Running perf sampling"
export PERF_JITDUMP=1
PERF_ARGS=(--call-graph dwarf -g)

perf record "${PERF_ARGS[@]}" -o "mobilenetv3-s.data" \
  iree-benchmark-module --module="${VMFB_BASE}" "${BENCH_ARGS[@]}"

echo "↳ Use: perf report -i mobilenetv3-s.data"
echo

sudo cpupower frequency-set --governor powersave
echo "✅ Done. Results: mobilenetv3-s.timing.txt, mobilenetv3-s.data"
