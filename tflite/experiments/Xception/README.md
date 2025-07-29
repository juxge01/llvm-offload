### prepare:

xception.tflite

### progress:

python ../../tflite_tools.py -i xception.tflite --plot xception.png
python ../../tflite_tools.py -i xception.tflite --calc-macs --csv=xception.csv

python -m tflite_flops xception.tflite

## IREE

### MLIR

cd mlir/
iree-import-tflite ../xception.tflite -o xception.mlir
iree-compile xception.mlir --iree-input-type=tosa --compile-to=flow -o xception-flow.mlir
iree-compile xception.mlir --iree-input-type=tosa --compile-to=stream -o xception-stream.mlir

### VMFB

./vmfb.sh
./benckmark_perf.sh

```
Benchmark                                      Time             CPU   Iterations UserCounters...

BM_main/process_time/real_time_mean          248 ms         1144 ms           10 items_per_second=4.05479/s
BM_main/process_time/real_time_median        246 ms         1144 ms           10 items_per_second=4.06517/s
BM_main/process_time/real_time_stddev       20.7 ms        0.753 ms           10 items_per_second=0.331258/s
BM_main/process_time/real_time_cv           8.33 %          0.07 %            10 items_per_second=8.17%
```
