import kagglehub

# Download latest version
path = kagglehub.model_download("tensorflow/mobilenet-v2/tfLite/1-0-224")

print("Path to model files:", path)
