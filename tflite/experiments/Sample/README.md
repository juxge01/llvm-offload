### prepare:

sample.tflite

### progress:

python ../../tflite_tools.py -i sample.tflite --plot sample.png
python ../../tflite_tools.py -i sample.tflite --calc-macs --csv=sample.csv

python -m tflite_flops sample.tflite

## IREE

### MLIR

cd mlir/
iree-import-tflite ../sample.tflite -o sample.mlir
iree-compile sample.mlir --iree-input-type=tosa --compile-to=flow -o sample-flow.mlir
iree-compile sample.mlir --iree-input-type=tosa --compile-to=stream -o sample-stream.mlir

### VMFB

./vmfb.sh
./benckmark_perf.sh
