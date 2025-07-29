import re
import argparse
from pathlib import Path

def parse_tensor_shape_safe(tensor_type):
    match = re.match(r"tensor<\?x(\d+)x(\d+)x(\d+)xf32>", tensor_type)
    if not match:
        return None
    return [int(x) for x in match.groups()]

def estimate_memory_bytes(tensor_type):
    shape = parse_tensor_shape_safe(tensor_type)
    if not shape:
        return 0
    return 4 * shape[0] * shape[1] * shape[2]  # float32 = 4B

def analyze_mlir(mlir_text):
    # Match linalg.generic ops
    generic_ops = re.findall(
        r"%[\w\d]+ = linalg\.generic\s*{.*?\^bb0\(.*?\):.*?linalg\.yield.*?}\s*->\s*(tensor<.*?>)",
        mlir_text,
        re.DOTALL,
    )

    # Match tensor loads/stores
    tensor_io_ops = re.findall(r"flow\.dispatch\.tensor\.(load|store).*?:\s*(tensor<.*?>)", mlir_text)

    total_flops = 0
    fused_flops = 0
    for tensor_type in generic_ops:
        shape = parse_tensor_shape_safe(tensor_type)
        if shape:
            # flops = 7 * shape[0] * shape[1] * shape[2]  # mul + add + clamp
            flops = shape[0] * shape[1] * shape[2]  # mul + add + clamp
            total_flops += flops
            if "mulf" in tensor_type and "addf" in tensor_type and "select" in tensor_type:
                fused_flops += flops

    load_count = sum(1 for op, _ in tensor_io_ops if op == "load")
    store_count = sum(1 for op, _ in tensor_io_ops if op == "store")
    total_mem_bytes = sum(estimate_memory_bytes(t) for _, t in tensor_io_ops)

    print("\n [[ MLIR Bottleneck Summary ]]")
    print("===========================")
    print(f"- Total FLOPs          : {total_flops:,}")
    # print(f"🔁 Fused FLOPs          : {fused_flops:,}")
    # print(f"📉 Fused FLOP %         : {(fused_flops / max(total_flops, 1)) * 100:.2f}%")
    print(f"- I/O Load Count       : {load_count}")
    print(f"- I/O Store Count      : {store_count}")
    print(f"- Estimated Mem Usage  : {total_mem_bytes / 1024 / 1024:.2f} MB\n")

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", type=str, required=True, help="Path to MLIR file")
    args = parser.parse_args()

    mlir_text = Path(args.input).read_text()
    analyze_mlir(mlir_text)
