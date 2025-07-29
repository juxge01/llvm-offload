### prepare:

efficientnet-v2-s.tflite

### progress:

python ../../tflite_tools.py -i efficientnet-v2-s.tflite --plot efficientnet-v2-s.png
python ../../tflite_tools.py -i efficientnet-v2-s.tflite --calc-macs --csv=efficientnet-v2-s.csv

python -m tflite_flops efficientnet-v2-s.tflite

## IREE

### MLIR

iree-import-tflite ../efficientnet-v2-s.tflite -o efficientnet-v2-s.mlir
iree-compile efficientnet-v2-s.mlir --iree-input-type=tosa --compile-to=flow -o efficientnet-v2-s-flow.mlir
iree-compile efficientnet-v2-s.mlir --iree-input-type=tosa --compile-to=stream -o efficientnet-v2-s-stream.mlir

### VMFB

cd mlir/
./vmfb.sh
./benckmark_perf.sh

## '''

- iteration = 10
  Benckmark | Time | CPU | Iterations UserCounters...
  BM_main/process_time/real_time_mean | 325 ms | 1335 ms | 10 items_per_second=3.08135/s
  BM_main/process_time/real_time_median | 325 ms | 1335 ms | 10 items_per_second=3.08073/s
  BM_main/process_time/real_time_stddev | 11.9 ms | 1.00 ms | 10 items_per_second=0.112842/s
  BM_main/process_time/real_time_cv | 3.66 % | 0.08 % | 10 items_per_second=3.66%
  '''
