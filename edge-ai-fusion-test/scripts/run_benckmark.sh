#!/bin/bash

MODELS_DIR="./compiled_models"
REPEAT=10
SHAPE="1x224x224x3xf32"
INPUT="=1"
FUNC="main"
DEVICE="local-task"

MODELS=("mobilenetv2.vmfb" "mobilenetv2_fused.vmfb")

echo "[+] Benchmarking models in $MODELS_DIR"

for model in "${MODELS[@]}"; do
  echo ""
  echo ">> Testing $model"
  MODEL_PATH="${MODELS_DIR}/${model}"

  if [[ ! -f "$MODEL_PATH" ]]; then
    echo "[!] $MODEL_PATH not found. Skipping."
    continue
  fi

  for i in $(seq 1 $REPEAT); do
    /usr/bin/time -f "Run $i: %e sec" \
    iree-run-module \
      --device=$DEVICE \
      --module=$MODEL_PATH \
      --function=$FUNC \
      --input="${SHAPE}${INPUT}" \
      >/dev/null
  done
done

