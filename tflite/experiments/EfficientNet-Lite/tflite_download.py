import tensorflow as tf

model = tf.keras.applications.EfficientNetV2S(weights="imagenet")
converter = tf.lite.TFLiteConverter.from_keras_model(model)
tflite_model = converter.convert()

with open("efficientnet-v2-s.tflite", "wb") as f:
    f.write(tflite_model)
print("efficientnet-v2-s.tflite 저장 완료")
