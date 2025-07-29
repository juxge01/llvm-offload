### prepare:

mobilenetv3-l.tflite

### progress:

python ../../tflite_tools.py -i mobilenetv3-l.tflite --plot mobilenetv3-l.png
python ../../tflite_tools.py -i mobilenetv3-l.tflite --calc-macs --csv=mobilenetv3-l.csv

python -m tflite_flops mobilenetv3-l.tflite

## IREE

### MLIR

cd mlir/
iree-import-tflite ../mobilenetv3-l.tflite -o mobilenetv3-l.mlir
iree-compile mobilenetv3-l.mlir --iree-input-type=tosa --compile-to=flow -o mobilenetv3-l-flow.mlir
iree-compile mobilenetv3-l.mlir --iree-input-type=tosa --compile-to=stream -o mobilenetv3-l-stream.mlir

### VMFB

./vmfb.sh
./benckmark_perf.sh

```
Benchmark                                      Time             CPU           Iterations UserCounters...

BM_main/process_time/real_time_mean         20.4 ms         41.0 ms           10 items_per_second=49.2451/s
BM_main/process_time/real_time_median       20.6 ms         41.0 ms           10 items_per_second=48.5719/s
BM_main/process_time/real_time_stddev       1.19 ms        0.139 ms           10 items_per_second=2.89926/s
BM_main/process_time/real_time_cv           5.84 %          0.34 %            10 items_per_second=5.89%
```
