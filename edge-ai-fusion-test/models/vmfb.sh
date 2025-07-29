INPUT_FILE_NAME=mnv2_fuse
IREE_INPUT_TYPE=tosa
IREE_TARGET_BACKEND=llvm-cpu
IREE_TARGET_TRIPLE=x86_64-pc-linux-gnu

OUTPUT_FILE_NAME=mobilenetv2

rm ./${OUTPUT_FILE_NAME}.vmfb

iree-compile \
 --iree-input-type=${IREE_INPUT_TYPE} \
 --iree-hal-target-backends=${IREE_TARGET_BACKEND} \
 --iree-llvm-target-triple=${IREE_TARGET_TRIPLE} \
 --iree-llvm-debug-symbols=true \
 ./${INPUT_FILE_NAME}.mlir \
 -o ./${OUTPUT_FILE_NAME}.vmfb

