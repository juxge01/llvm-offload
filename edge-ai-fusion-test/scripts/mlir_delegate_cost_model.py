# mlir_delegate_cost_model.py
"""MLIR Delegate – Dispatch & Op‑level Candidate Finder (v2.1)
=============================================================
*Robust* version that correctly handles nested braces inside `flow.executable`
blocks and produces non‑zero FLOPs.

Key fixes
---------
1. **Dispatch slicing** – instead of regexing up to the next solitary `}`
   (which broke on nested `}`), we now locate every `flow.executable` header
   and slice the text up to the next header (or EOF). This guarantees we
   capture the full body regardless of inner braces.
2. **Supported op set** unchanged (Conv/DWConv/MatMul) but FLOPs now show
   because the ops are actually parsed.
3. Tidier CLI help text.
"""
from __future__ import annotations

import argparse
import json
import math
import re
import sys
from pathlib import Path
from typing import Any, Dict, List, Sequence, Tuple
import csv

###############################################################################
# Regex helpers
###############################################################################

DISPATCH_HDR_RE = re.compile(r"flow\.executable[^@]*@([A-Za-z0-9_]+)")
OP_RE = re.compile(
    r"%[\w\d_]+\s*=\s*\"?([\w\.]+)\"?[\s\S]*?"
    r"(?:->\s*(tensor<[^>]+>)|outs?\s*\([^:]+:\s*(tensor<[^>]+>))",
    re.S,
)
TENSOR_RE = re.compile(r"tensor<([^>]+)>")
SHAPE_DTYPE_RE = re.compile(r"([0-9x\?]+)x([A-Za-z0-9]+)")

DTYPE_SIZE = {"f32": 4, "f16": 2, "bf16": 2, "i8": 1, "i32": 4, "i64": 8}

SUPPORTED_CONV_OPS = {
    "tf.Conv2D",
    "tosa.conv2d",
    "mhlo.convolution",
    "linalg.conv_2d_nhwc_hwcf",
}
SUPPORTED_DWCONV_OPS = {
    "tf.DepthwiseConv2dNative",
    "tosa.depthwise_conv2d",
    "linalg.depthwise_conv_2d_nhwc_hwc",
}
SUPPORTED_MATMUL_OPS = {"linalg.matmul", "mhlo.dot_general"}
ALL_SUPPORTED = SUPPORTED_CONV_OPS | SUPPORTED_DWCONV_OPS | SUPPORTED_MATMUL_OPS

###############################################################################
# IO helpers
###############################################################################

def read_text(path: Path, enc: str | None) -> str:
    if enc:
        return path.read_text(encoding=enc, errors="replace")
    try:
        return path.read_text(encoding="utf-8")
    except UnicodeDecodeError:
        return path.read_text(encoding="latin-1")


def parse_tensor(spec: str, unknown_dim: int) -> Tuple[List[int], str]:
    m = SHAPE_DTYPE_RE.match(spec)
    if not m:
        return [], "f32"
    shape_str, dtype = m.groups()
    shape = [int(x) if x.isdigit() else unknown_dim for x in shape_str.split("x") if x]
    return shape, dtype

###############################################################################
# FLOPs helpers
###############################################################################

def tensor_bytes(shape: Sequence[int], dtype: str) -> int:
    return math.prod(shape) * DTYPE_SIZE.get(dtype, 4) if shape else 0


def op_flops(op_name: str, shape: Sequence[int]) -> int:
    if not shape:
        return 0
    if op_name in SUPPORTED_CONV_OPS:
        n, h, w, o = shape
        kh = kw = 3
        i = max(o // 4, 1)
        return n * h * w * o * i * kh * kw * 2
    if op_name in SUPPORTED_DWCONV_OPS:
        n, h, w, c = shape
        kh = kw = 3
        return n * h * w * c * kh * kw * 2
    if op_name in SUPPORTED_MATMUL_OPS:
        *batch, m, k = shape
        n = k  # rough
        return (math.prod(batch) or 1) * m * n * k * 2
    return 0

###############################################################################
# Parsing MLIR
###############################################################################

def slice_dispatch_bodies(text: str) -> List[Tuple[str, str]]:
    """Return list of (dispatch_name, body_text)"""
    matches = list(DISPATCH_HDR_RE.finditer(text))
    bodies = []
    for idx, m in enumerate(matches):
        name = m.group(1)
        start = m.end()
        end = matches[idx + 1].start() if idx + 1 < len(matches) else len(text)
        bodies.append((name, text[start:end]))
    return bodies


def parse_mlir(path: Path, enc: str | None, unknown_dim: int):
    dct: Dict[str, List[Dict[str, Any]]] = {}
    text = read_text(path, enc)
    for name, body in slice_dispatch_bodies(text):
        ops: List[Dict[str, Any]] = []
        for m in OP_RE.finditer(body):
            op_name = m.group(1)
            tensor_spec = m.group(2) or m.group(3)
            if not tensor_spec:
                continue
            t_match = TENSOR_RE.search(tensor_spec)
            if not t_match:
                continue
            shape, dtype = parse_tensor(t_match.group(1), unknown_dim)
            ops.append({
                "op_name": op_name,
                "shape": shape,
                "dtype": dtype,
                "flops": op_flops(op_name, shape),
                "bytes": tensor_bytes(shape, dtype),
            })
        dct[name] = ops
    return dct

###############################################################################
# Fusion enumeration (unchanged)
###############################################################################

def fusion_candidates(ops, flops_th, bytes_th, alpha, beta, max_group):
    out = []
    N = len(ops)
    for s in range(N):
        f = b = 0
        for e in range(s, min(s + max_group, N)):
            f += ops[e]["flops"]
            b += ops[e]["bytes"]
            if f >= flops_th and b >= bytes_th:
                out.append({
                    "ops": (s, e),
                    "total_flops": f,
                    "gain": alpha * f - beta * b,
                })
    return sorted(out, key=lambda x: x["gain"], reverse=True)

###############################################################################
# CLI
###############################################################################

def build_parser() -> argparse.ArgumentParser:
    p = argparse.ArgumentParser(
        prog="mlir_delegate_cost_model.py",
        description="Analyse .mlir dispatch blocks and suggest fusion/offload candidates.",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    p.add_argument("--mlir", required=True, help="Path to textual .mlir module")

    thr = p.add_argument_group("Thresholds")
    thr.add_argument("--flops-threshold", type=float, default=1e8, help="Min cumulative FLOPs for a fusion block to be kept")
    thr.add_argument("--bytes-threshold", type=float, default=1e7, help="Min cumulative tensor‑bytes for a fusion block")

    gain = p.add_argument_group("Gain weights")
    gain.add_argument("--alpha", type=float, default=1.0, help="Gain weight for FLOPs term")
    gain.add_argument("--beta", type=float, default=1e-3, help="Gain penalty for Bytes term (use train_beta.py result)")

    win = p.add_argument_group("Window/Fusion")
    win.add_argument("--max-group-size", type=int, default=4, help="Max ops in one fusion window")
    win.add_argument("--fusion-top-k", type=int, default=5, help="How many fusion ranges to show per dispatch")

    disp = p.add_argument_group("Dispatch report")
    disp.add_argument("--dispatch-top-k", type=int, default=5, help="Max #dispatches to print, ranked by FLOPs")
    disp.add_argument("--op-top-k", type=int, default=3, help="#heavy ops to list per dispatch")
    disp.add_argument("--print-ops", action="store_true", help="Also print op names in each fusion range")
    disp.add_argument("--with-op-names", action="store_true", help="Include `op_names` field in JSON/CSV output")
    p.add_argument("--unknown-dim", type=int, default=1, help="Fallback for unknown tensor dimensions ('?')")
    p.add_argument("--encoding", type=str, help="Force file encoding if auto‑detect fails")

    io = p.add_argument_group("I/O")
    io.add_argument("--out", type=str, help="Save CSV/JSON summarising dispatch stats")

    return p

def main():
    args = build_parser().parse_args()

    dispatches = parse_mlir(Path(args.mlir), args.encoding, args.unknown_dim)
    if not dispatches:
        print("[ERR] No dispatches parsed – check MLIR file/encoding.")
        return 1

    summary = []
    for name, ops in dispatches.items():
        summary.append((name, sum(o["flops"] for o in ops), sum(o["bytes"] for o in ops), ops))
    summary.sort(key=lambda x: x[1], reverse=True)

    print(f"=== Top {args.dispatch_top_k} dispatches by FLOPs ===")
    for idx, (dname, dflops, dbytes, ops) in enumerate(summary[: args.dispatch_top_k]):
        print(f"\n[{idx}] {dname}  FLOPs {dflops:.1e}")
        top_ops = sorted(ops, key=lambda o: o["flops"], reverse=True)[: args.op_top_k]

        # for o in sorted(ops, key=lambda o: o["flops"], reverse=True)[: args.op_top_k]:
        for o in top_ops:
            print(f"  {o['op_name']:<28} {o['flops']:.1e}")
        fusions = fusion_candidates(
            ops,
            args.flops_threshold,
            args.bytes_threshold,
            args.alpha,
            args.beta,
            args.max_group_size,
        )[: args.fusion_top_k]
        if fusions:
            print("  Fusion candidates:")
            for fc in fusions:
                s, e = fc["ops"]
                print(f"    ops {s}-{e} | FLOPs {fc['total_flops']:.1e} | gain {fc['gain']:.2e}")
                if args.print_ops:
                    names = ", ".join(o["op_name"] for o in ops[s : e + 1])
                    print(f"      {names}")

    # ---------------- CSV / JSON export ----------------
    if args.out:
        out_path = Path(args.out)
        out_path.parent.mkdir(parents=True, exist_ok=True)
        if out_path.suffix == ".csv":
            with open(out_path, "w", newline="") as f:
                w = csv.writer(f)
                header = ["dispatch", "flops", "bytes", "num_ops"]
                if args.with_op_names:
                    header.append("op_names")
                w.writerow(header)
                for name, fl, by, ops in summary:
                    # w.writerow([name, fl, by, len(ops)])
                    row = [name, fl, by, len(ops)]
                    if args.with_op_names:
                        row.append(";".join(o["op_name"] for o in sorted(ops, key=lambda x: x["flops"], reverse=True)[: args.op_top_k]))                    
                    w.writerow(row)
            print("Saved CSV →", out_path)
        else:  # default json
            data = {
                "dispatches": [
                    {
                        "name": n,
                        "total_flops": fl,
                        "total_bytes": by,
                        "num_ops": len(ops),
                    }
                    for n, fl, by, ops in summary
                ]
            }
            with open(out_path, "w") as f:
                json.dump(data, f, indent=2)
            print("Saved JSON →", out_path)


if __name__ == "__main__":
    sys.exit(main())
