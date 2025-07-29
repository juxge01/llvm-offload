# ── 1) LLVM 빌드 디렉터리 지정 ───────────────────────────
LLVM_BUILD=/home/jueun/park/IREE/llvm-project/mlir-build

# ── 2) 도구 절대 경로 잡기 ──────────────────────────────
MLIR_TRANSLATE=$LLVM_BUILD/bin/mlir-translate
OPT=$LLVM_BUILD/bin/opt
LLVM_AS=$LLVM_BUILD/bin/llvm-as

# ── 3) custom‑offload 플러그인 경로 ─────────────────────
PLUGIN=$LLVM_BUILD/lib/CustomOffloadPass.so

# ── 4) 실제 파이프라인 문자열 만들기 ───────────────────
PIPELINE="/home/you/llvm-build/bin/opt \
            -load-pass-plugin=/home/you/llvm-build/lib/CustomOffloadPass.so \
            -passes=custom-offload -S | \
         /home/you/llvm-build/bin/mlir-translate --import-llvm"
