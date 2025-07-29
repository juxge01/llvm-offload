import tensorflow as tf

model = tf.keras.applications.MobileNetV3Small(weights="imagenet")
converter = tf.lite.TFLiteConverter.from_keras_model(model)
tflite_model = converter.convert()

with open("mobilenetv3-s.tflite", "wb") as f:
    f.write(tflite_model)
print("mobilenetv3-s.tflite 저장 완료")
