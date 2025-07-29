### prepare:

mobilenetv3-s.tflite

### progress:

python ../../tflite_tools.py -i mobilenetv3-s.tflite --plot mobilenetv3-s.png
python ../../tflite_tools.py -i mobilenetv3-s.tflite --calc-macs --csv=mobilenetv3-s.csv

python -m tflite_flops mobilenetv3-s.tflite

## IREE

### MLIR

cd mlir/
iree-import-tflite ../mobilenetv3-s.tflite -o mobilenetv3-s.mlir
iree-compile mobilenetv3-s.mlir --iree-input-type=tosa --compile-to=flow -o mobilenetv3-s-flow.mlir
iree-compile mobilenetv3-s.mlir --iree-input-type=tosa --compile-to=stream -o mobilenetv3-s-stream.mlir

### VMFB

./vmfb.sh
./benckmark_perf.sh

```
Benchmark                                      Time             CPU   Iterations UserCounters...

BM_main/process_time/real_time_mean         9.13 ms         14.3 ms           10 items_per_second=110.224/s
BM_main/process_time/real_time_median       8.93 ms         14.4 ms           10 items_per_second=111.977/s
BM_main/process_time/real_time_stddev      0.773 ms        0.071 ms           10 items_per_second=8.977/s
BM_main/process_time/real_time_cv           8.47 %          0.50 %            10 items_per_second=8.14%
```
