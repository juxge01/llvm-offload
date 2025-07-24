// opt -load-pass-plugin=MemAccessPass.so \
//        -passes='function(mem-access)' -disable-output test.ll

#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace {
struct MemAccessPass : public PassInfoMixin<MemAccessPass> {
  // optnone 속성이 있는 함수에서도 실행되도록 설정
  static bool isRequired() { return true; }

  static constexpr unsigned kThres = 10;

  PreservedAnalyses run(Function &F, FunctionAnalysisManager &) {
	  unsigned loadCnt = 0;
	  unsigned storeCnt = 0;
	  // unsigned instMemAccessPass = 0;

	  for (BasicBlock &BB : F) {
		  for (Instruction &I : BB) {
			  if (isa<LoadInst>(I))
				  ++loadCnt;
			  else if (isa<StoreInst>(I))
				  ++storeCnt;
		  }
	  }
    
    unsigned total = loadCnt + storeCnt;

    if (total >= kThres) {
      F.addFnAttr("offload.target", "custom-accel");
      errs() << "[MemAccessOffload] mark '" << F.getName()
             << "' (" << total << " mem) → custom-accel\n";
      return PreservedAnalyses::none();          // IR 변경됨
    }
	  errs() << "=== Memory-Access Count for " << F.getName() << " : " << loadCnt << " loads, " << storeCnt << " stores\n";

	  return PreservedAnalyses::all();
  }
};
}

extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return {
    LLVM_PLUGIN_API_VERSION, "MemAccessPass", LLVM_VERSION_STRING,
    [](PassBuilder &PB) {
      PB.registerPipelineParsingCallback(
        [](StringRef Name, FunctionPassManager &FPM,
           ArrayRef<PassBuilder::PipelineElement>) {
          if (Name == "mem-access") {
            FPM.addPass(MemAccessPass());
            return true;
          }
          return false;
        });
    }
  };
}
