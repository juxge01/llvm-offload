### prepare:

resnet-50.tflite

### progress:

python ../../tflite_tools.py -i resnet-50.tflite --plot resnet-50.png
python ../../tflite_tools.py -i resnet-50.tflite --calc-macs --csv=resnet-50.csv

python -m tflite_flops resnet-50.tflite
