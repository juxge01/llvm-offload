import time
import tensorflow as tf
import numpy as np

interpreter = tf.lite.Interpreter(model_path="mobilenetv2.tflite")
interpreter.allocate_tensors()

input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

# 예를 들어, 입력 크기에 맞는 임의 입력 생성
input_shape = input_details[0]['shape']
input_data = np.random.rand(*input_shape).astype(np.float32)

NUM_RUNS = 100
times = []
for _ in range(NUM_RUNS):
    interpreter.set_tensor(input_details[0]['index'], input_data)
    start = time.time()
    interpreter.invoke()
    end = time.time()
    times.append(end - start)

avg_inference_time = sum(times) / NUM_RUNS
print(f"Average inference time: {avg_inference_time:.6f} seconds")

