#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace {
struct CountInstPass : public PassInfoMixin<CountInstPass> {
  // optnone 속성이 있는 함수에서도 실행되도록 설정
  static bool isRequired() { return true; }

  PreservedAnalyses run(Function &F, FunctionAnalysisManager &) {
	  unsigned instCountInstPass = 0;

	  for (BasicBlock &BB : F) {
		  instCountInstPass += BB.size();
	  }

	  errs() << "=== Instruction Count for : " << F.getName() << " : " << instCountInstPass << "\n";

	  return PreservedAnalyses::all();
  }
};
}

extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return {
    LLVM_PLUGIN_API_VERSION, "CountInstPass", LLVM_VERSION_STRING,
    [](PassBuilder &PB) {
      PB.registerPipelineParsingCallback(
        [](StringRef Name, FunctionPassManager &FPM,
           ArrayRef<PassBuilder::PipelineElement>) {
          if (Name == "countinst") {
            FPM.addPass(CountInstPass());
            return true;
          }
          return false;
        });
    }
  };
}
