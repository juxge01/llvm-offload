# import kagglehub
# import tensorflow as tf
# import os

# # 모델 다운로드
# model_dir = kagglehub.model_download("tensorflow/resnet-50/TensorFlow2/classification/1")

# # 🔥 경로 수정: model_dir 자체가 saved_model.pb 포함
# saved_model_dir = model_dir  # 기존: os.path.join(model_dir, "1")

# # TensorFlow Lite 변환
# converter = tf.lite.TFLiteConverter.from_saved_model(saved_model_dir)
# tflite_model = converter.convert()

# # TFLite 모델 저장
# tflite_model_path = os.path.join(model_dir, "resnet50.tflite")
# with open(tflite_model_path, "wb") as f:
#     f.write(tflite_model)

# print("TFLite 모델 저장 완료:", tflite_model_path)

import tensorflow as tf

model = tf.keras.applications.ResNet50(weights="imagenet")
converter = tf.lite.TFLiteConverter.from_keras_model(model)
tflite_model = converter.convert()

with open("resnet-50.tflite", "wb") as f:
    f.write(tflite_model)
print("ResNet‑50.tflite 저장 완료")
