#!/bin/bash
VMFB_BASE=./yolov5n-fp16.vmfb

sudo cpupower frequency-set --governor performance

# -----------------------------------------------------------------------------
# 1. 순수 타이밍 벤치마크
# -----------------------------------------------------------------------------

echo "\n▶ Running timing benchmark: yolov5n-fp16.vmfb"
BENCH_ARGS=(
  --device=local-task
  --function=main
  --input="1x640x640x3xf32=0"
  --benchmark_repetitions=10
  --benchmark_min_time=5.0
  -o /dev/null
)

iree-benchmark-module --module="${VMFB_BASE}" "${BENCH_ARGS[@]}" \
  | tee "yolov5n-fp16.timing.txt"
echo "↳ wrote yolov5n-fp16.timing.txt"
echo

# -----------------------------------------------------------------------------
# 2. perf record
# -----------------------------------------------------------------------------

echo "▶ Running perf sampling"
export PERF_JITDUMP=1
PERF_ARGS=(--call-graph dwarf -g)

perf record "${PERF_ARGS[@]}" -o "yolov5n-fp16.data" \
  iree-benchmark-module --module="${VMFB_BASE}" "${BENCH_ARGS[@]}"

echo "↳ Use: perf report -i yolov5n-fp16.data"
echo

sudo cpupower frequency-set --governor powersave
echo "✅ Done. Results: yolov5n-fp16.timing.txt, yolov5n-fp16.data"
