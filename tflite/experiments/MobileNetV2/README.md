### prepare:

mobilenetv2.tflite

### progress:

python ../../tflite_tools.py -i mobilenetv2.tflite --plot mobilenetv2.png
python ../../tflite_tools.py -i mobilenetv2.tflite --calc-macs --csv=mobilenetv2.csv

python -m tflite_flops mobilenetv2.tflite

### MLIR

cd mlir/

iree-import-tflite ../mobilenetv2.tflite -o mobilenetv2.mlir
iree-compile mobilenetv2.mlir --iree-input-type=tosa --compile-to=flow -o mobilenetv2-flow.mlir
iree-compile mobilenetv2.mlir --iree-input-type=tosa --compile-to=stream -o mobilenetv2-stream.mlir

### VMFB

./vmfb.sh
./benckmark_perf.sh

```
iteration = 50
BM_main/process_time/real_time_mean         9.23 ms         41.6 ms           50 items_per_second=108.583/s
BM_main/process_time/real_time_median       9.37 ms         41.5 ms           50 items_per_second=106.741/s
BM_main/process_time/real_time_stddev      0.440 ms        0.212 ms           50 items_per_second=5.33537/s
BM_main/process_time/real_time_cv           4.77 %          0.51 %            50 items_per_second=4.91%
```
