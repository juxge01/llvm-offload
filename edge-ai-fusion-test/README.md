### MobileNetV2 VMFB Test

```
$ ./scripts/run_benchmark.sh
```

```
[+] Benchmarking models in ./compiled_models

>> Testing mobilenetv2.vmfb
Run 1: 0.14 sec
Run 2: 0.17 sec
Run 3: 0.17 sec
Run 4: 0.14 sec
Run 5: 0.17 sec
Run 6: 0.17 sec
Run 7: 0.13 sec
Run 8: 0.13 sec
Run 9: 0.16 sec
Run 10: 0.14 sec

>> Testing mobilenetv2_fused.vmfb
Run 1: 0.21 sec
Run 2: 0.20 sec
Run 3: 0.21 sec
Run 4: 0.21 sec
Run 5: 0.23 sec
Run 6: 0.21 sec
Run 7: 0.20 sec
Run 8: 0.20 sec
Run 9: 0.22 sec
Run 10: 0.21 sec
```

## OFFLOAD Target Candidate - Automation

$ conda activate tflite-env

### TFLite Ver.

```
$ python scripts/tflite_delegate_cost_model.py  \
	--model models/mobilenetv2.tflite \
    --flops-threshold 1e7 \
	--bytes-threshold 5e6 \
	--alpha 1 \
	--beta 1e-3 \
	--top-k 10 \
	--print-ops \
	--out result/json/cand10.json \
	--with-op-names
```

```
$ python scripts/plot_candidates.py \
 	--input results/json/candi_top10.json \
	--save results/png/scatter.png
```

### MLIR Ver.

```
$ python scripts/mlir_delegate_cost_model.py \
	--mlir models/mnv2_basic.mlir \
	--flops-threshold 5e7 \
	--bytes-threshold 5e6 \
	--dispatch-top-k 5 \
	--op-top-k 5 \
	--fusion-top-k 5 \
	--print-ops
```
