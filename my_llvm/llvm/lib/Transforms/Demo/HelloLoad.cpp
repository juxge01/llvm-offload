#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
using namespace llvm;

namespace {
struct HelloLoadPass : PassInfoMixin<HelloLoadPass> {
	static bool isRequired() { return true; }

  PreservedAnalyses run(Function &F, FunctionAnalysisManager &) {
    unsigned loads = 0;
    for (auto &BB : F)
      for (auto &I : BB)
        if (isa<LoadInst>(I))
          ++loads;
    errs() << "[HelloLoad] " << F.getName() << " : " << loads << " loads\n";
    return PreservedAnalyses::all();
  }
};
} // namespace

extern "C" LLVM_ATTRIBUTE_WEAK PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "HelloLoad", LLVM_VERSION_STRING,
          [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager &FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "hello-load") {
                    FPM.addPass(HelloLoadPass());
                    return true;
                  }
                  return false;
                });
          }};
}

