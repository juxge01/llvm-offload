// opt -load-pass-plugin=AutoOffloadPass.so \
//        -passes='function(mem-access)' -disable-output test.ll

#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Module.h"

using namespace llvm;

namespace {
struct AutoOffloadPass : public PassInfoMixin<AutoOffloadPass> {
  static bool isRequired() { return true; }

  PreservedAnalyses run(Module &M, ModuleAnalysisManager &) {
    std::vector<std::pair<Function*, unsigned>> functionArithCounts;
    unsigned totalArith = 0;
    unsigned numFuncs = 0;

    // 먼저 모든 함수에서 산술 연산 개수 측정
    for (Function &F : M) {
      if (F.isDeclaration())
        continue;

      unsigned arithCnt = 0;
      for (BasicBlock &BB : F) {
        for (Instruction &I : BB) {
          if (isa<BinaryOperator>(I))
            ++arithCnt;
        }
      }

      functionArithCounts.emplace_back(&F, arithCnt);
      totalArith += arithCnt;
      ++numFuncs;
    }

    if (numFuncs == 0)
      return PreservedAnalyses::all();

    double average = static_cast<double>(totalArith) / numFuncs;

    // 평균 이상인 함수만 offload 속성 추가
    for (auto &[F, arithCnt] : functionArithCounts) {
      if (arithCnt >= average) {
        F->addFnAttr("offload.target", "custom-accel");
        F->addFnAttr("offload.work", std::to_string(arithCnt));
        errs() << " '" << F->getName() << "' (" << arithCnt << " arith >= avg " << average << ") : offloading target *\n";
      } else {
        errs() << " '" << F->getName() << "' (" << arithCnt << " arith < avg " << average << ") : not offloading target\n";
      }
    }

    return PreservedAnalyses::none();
  }
};
} // namespace

extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return {
    LLVM_PLUGIN_API_VERSION, "AutoOffloadPass", LLVM_VERSION_STRING,
    [](PassBuilder &PB) {
      PB.registerPipelineParsingCallback(
        [](StringRef Name, ModulePassManager &MPM,
           ArrayRef<PassBuilder::PipelineElement>) {
          if (Name == "auto-offload") {
            MPM.addPass(AutoOffloadPass());
            return true;
          }
          return false;
        });
    }
  };
}
