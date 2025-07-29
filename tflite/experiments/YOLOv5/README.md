### prepare:

yolov5n-fp16.tflite

### progress:

python ../../tflite_tools.py -i yolov5n-fp16.tflite --plot yolov5n-fp16.png
python ../../tflite_tools.py -i yolov5n-fp16.tflite --calc-macs --csv=yolov5n-fp16.csv

python -m tflite_flops yolov5n-fp16.tflite

## IREE

### MLIR

cd mlir/
iree-import-tflite ../yolov5n-fp16.tflite -o yolov5n-fp16.mlir
iree-compile yolov5n-fp16.mlir --iree-input-type=tosa --compile-to=flow -o yolov5n-fp16-flow.mlir
iree-compile yolov5n-fp16.mlir --iree-input-type=tosa --compile-to=stream -o yolov5n-fp16-stream.mlir

### VMFB

./vmfb.sh
./benchmark_perf.sh

```
BM_main/process_time/real_time_mean         83.6 ms          406 ms           10 items_per_second=11.9766/s
BM_main/process_time/real_time_median       83.9 ms          407 ms           10 items_per_second=11.9177/s
BM_main/process_time/real_time_stddev       2.71 ms         1.60 ms           10 items_per_second=0.383519/s
BM_main/process_time/real_time_cv           3.24 %          0.39 %            10 items_per_second=3.20%

```
