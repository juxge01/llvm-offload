# tflite_delegate_cost_model.py
"""TFLite Delegate – Candidate Finder (v1.2)
===========================================

"""
from __future__ import annotations

import argparse
import json
import os
import sys
from pathlib import Path
from typing import Any, Dict, List, Sequence

import numpy as np

try:
    import tflite_runtime.interpreter as tflite  # type: ignore
except ImportError:  # fallback to full TF if present
    from tensorflow.lite.python import interpreter as tflite  # type: ignore

###############################################################################
# Utilities
###############################################################################

DTYPE_SIZE = {
    np.float32: 4,
    np.float16: 2,
    np.int8: 1,
    np.uint8: 1,
    np.int32: 4,
    np.int64: 8,
}

def _to_list(arr_or_seq):
    if arr_or_seq is None:
        return []
    if isinstance(arr_or_seq, np.ndarray):
        return arr_or_seq.tolist()
    return list(arr_or_seq)


def _tensor_bytes(tensor: Dict[str, Any] | None, default_dtype=np.float32) -> int:
    if tensor is None:
        return 0
    shape = _to_list(tensor.get("shape"))
    numel = int(np.prod(shape)) if len(shape) > 0 else 1
    dtype = tensor.get("dtype", default_dtype)
    return numel * DTYPE_SIZE.get(dtype, np.dtype(dtype).itemsize)


def io_bytes(op: Dict[str, Any], tensors: Dict[int, Dict[str, Any]], default_dtype) -> int:
    idxs: Sequence[int] = _to_list(op.get("inputs")) + _to_list(op.get("outputs"))
    return sum(_tensor_bytes(tensors.get(i), default_dtype) for i in idxs)

###############################################################################
# Candidate enumeration & gain
###############################################################################

def enumerate_fusion_sets(
    interpreter: "tflite.Interpreter",
    flops_th: float,
    bytes_th: float,
    alpha: float,
    beta: float,
    max_group: int,
    default_dtype,
) -> List[Dict[str, Any]]:
    op_details = interpreter._get_ops_details()
    tensor_details = {d["index"]: d for d in interpreter.get_tensor_details()}

    def flops(op):
        name = op.get("op_name", "")
        if name == "CONV_2D":
            n, h, w, o = _to_list(tensor_details[op["outputs"][0]]["shape"])
            i = _to_list(tensor_details[op["inputs"][0]]["shape"])[-1]
            kh, kw = _to_list(tensor_details[op["inputs"][1]]["shape"])[0:2]
            return n * h * w * o * i * kh * kw * 2
        if name == "DEPTHWISE_CONV_2D":
            n, h, w, c_mul = _to_list(tensor_details[op["outputs"][0]]["shape"])
            kh, kw = _to_list(tensor_details[op["inputs"][1]]["shape"])[0:2]
            return n * h * w * c_mul * kh * kw * 2
        if name == "FULLY_CONNECTED":
            out_dim = _to_list(tensor_details[op["outputs"][0]]["shape"])[-1]
            in_shape = _to_list(tensor_details[op["inputs"][0]]["shape"])
            in_dim = in_shape[-1]
            batch = int(np.prod(in_shape[:-1]))
            return batch * in_dim * out_dim * 2
        return 0

    def gain(f, b):
        return alpha * f - beta * b

    cands: List[Dict[str, Any]] = []
    N = len(op_details)
    for start in range(N):
        cum_flops = cum_bytes = 0
        for end in range(start, min(start + max_group, N)):
            op = op_details[end]
            cum_flops += flops(op)
            cum_bytes += io_bytes(op, tensor_details, default_dtype)
            if cum_flops >= flops_th and cum_bytes >= bytes_th:
                cands.append(
                    {
                        "ops": list(range(start, end + 1)),
                        "total_flops": float(cum_flops),
                        "total_bytes": float(cum_bytes),
                        "gain": float(gain(cum_flops, cum_bytes)),
                    }
                )
    cands.sort(key=lambda x: x["gain"], reverse=True)
    return cands

###############################################################################
# CLI
###############################################################################

def main() -> int:
    p = argparse.ArgumentParser(description="Fusion‑candidate discovery tool")
    p.add_argument("--model", required=True)
    p.add_argument("--flops-threshold", type=float, default=1e7)
    p.add_argument("--bytes-threshold", type=float, default=5e6)
    p.add_argument("--alpha", type=float, default=1.0)
    p.add_argument("--beta", type=float, default=1e-3)
    p.add_argument("--max-group-size", type=int, default=4)
    p.add_argument("--top-k", type=int, default=20)
    p.add_argument("--out", type=str)
    p.add_argument("--dtype-default", choices=["f32", "f16", "int8"], default="f32")
    p.add_argument("--debug", action="store_true")
    p.add_argument("--print-ops", action="store_true", help="print op names for each candidate")
    p.add_argument("--with-op-names", action="store_true", help="embed op_names field into output file")
    args = p.parse_args()

    default_dtype = {"f32": np.float32, "f16": np.float16, "int8": np.int8}[args.dtype_default]

    inte = tflite.Interpreter(model_path=args.model)
    inte.allocate_tensors()

    if args.debug:
        print("[DBG] Gathering candidates …")

    cands = enumerate_fusion_sets(
        inte,
        args.flops_threshold,
        args.bytes_threshold,
        args.alpha,
        args.beta,
        args.max_group_size,
        default_dtype,
    )

    top = cands[: args.top_k]
    print(f"\nTop‑{len(top)} candidates:")

    # fetch op details once for print‑ops / with‑op‑names
    op_details = inte._get_ops_details() if (args.print_ops or args.with_op_names) else None

    def names_for(c):
        if op_details is None:
            return []
        s, e = c["ops"][0], c["ops"][-1]
        return [op_details[i]["op_name"] for i in range(s, e + 1)]

    for c in top:
        msg = "ops {}‑{} | FLOPs {:.1e} | Bytes {:.1e} | gain {:.2e}".format(
            c["ops"][0], c["ops"][-1], c["total_flops"], c["total_bytes"], c["gain"]
        )
        
        if args.print_ops:
            msg += " | " + ", ".join(names_for(c))
        print(msg)
        if args.with_op_names:
            c["op_names"] = names_for(c)

    if args.out:
        out_path = Path(args.out)
        if not out_path.parent.exists():
            os.makedirs(out_path.parent, exist_ok=True)
        if out_path.suffix == ".csv":
            import csv

            with open(out_path, "w", newline="") as f:
                w = csv.DictWriter(f, fieldnames=top[0].keys())
                w.writeheader()
                w.writerows(top)
        else:
            with open(out_path, "w") as f:
                json.dump(top, f, indent=2)
        print(f"Saved → {out_path}")

    return 0


if __name__ == "__main__":
    sys.exit(main())
