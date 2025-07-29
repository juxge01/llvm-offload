#include "mlir/IR/BuiltinOps.h"
#include "mlir/Pass/Pass.h"
using namespace mlir;

namespace {
struct HelloWorldPass
    : PassWrapper<HelloWorldPass, OperationPass<mlir::ModuleOp>> {
  MLIR_DEFINE_EXPLICIT_INTERNAL_INLINE_TYPE_ID(HelloWorldPass)

  void runOnOperation() override {
    llvm::outs() << "[HelloWorld] pass ran!\n";
  }
};
} // namespace

// Pass registration (name·desc 자동)
namespace {
static PassRegistration<HelloWorldPass> pass;
} // namespace

