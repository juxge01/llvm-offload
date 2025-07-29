import tensorflow as tf

model = tf.keras.applications.Xception(weights="imagenet")
converter = tf.lite.TFLiteConverter.from_keras_model(model)
tflite_model = converter.convert()

with open("xception.tflite", "wb") as f:
    f.write(tflite_model)
print("xception.tflite 저장 완료")
