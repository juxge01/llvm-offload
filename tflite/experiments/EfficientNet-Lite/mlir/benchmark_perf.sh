#!/bin/bash
VMFB_BASE=./efficientnet-v2-s.vmfb

sudo cpupower frequency-set --governor performance

# -----------------------------------------------------------------------------
# 1. 순수 타이밍 벤치마크
# -----------------------------------------------------------------------------

echo "\n▶ Running timing benchmark: efficientnet-v2-s.vmfb"
BENCH_ARGS=(
  --device=local-task
  --function=main
  --input="1x384x384x3xf32=0"
  --benchmark_repetitions=10
  --benchmark_min_time=5.0
  -o /dev/null
)

iree-benchmark-module --module="${VMFB_BASE}" "${BENCH_ARGS[@]}" \
  | tee "efficientnet-v2-s.timing.txt"
echo "↳ wrote efficientnet-v2-s.timing.txt"
echo

# -----------------------------------------------------------------------------
# 2. perf record
# -----------------------------------------------------------------------------

echo "▶ Running perf sampling"
export PERF_JITDUMP=1
PERF_ARGS=(--call-graph dwarf -g)

perf record "${PERF_ARGS[@]}" -o "efficientnet-v2-s.data" \
  iree-benchmark-module --module="${VMFB_BASE}" "${BENCH_ARGS[@]}"

echo "↳ Use: perf report -i efficientnet-v2-s.data"
echo

sudo cpupower frequency-set --governor powersave
echo "✅ Done. Results: efficientnet-v2-s.timing.txt, efficientnet-v2-s.data"
