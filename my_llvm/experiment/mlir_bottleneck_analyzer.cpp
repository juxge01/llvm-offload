// mlir_bottleneck_analyzer.cpp  (LLVM/MLIR 17 이상 대응)
// 빌드:
//   clang++ mlir_bottleneck_analyzer.cpp \
//     $(llvm-config --cxxflags --ldflags --system-libs --libs all) \
//     -std=c++17 -O2 -o analyze_mlir
//
// 내부 CMake 타깃으로 넣을 땐
//   add_mlir_tool(analyze_mlir …)  LINK_LIBS  MLIRFuncDialect;MLIRLinalgDialect 등 추가

#include "mlir/IR/MLIRContext.h"
// #include "mlir/IR/BuiltinOps.h"
// #include "mlir/Parser/Parser.h"
// #include "mlir/Pass/Pass.h"
// #include "mlir/Pass/PassManager.h"
#include "mlir/Support/FileUtilities.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"

#include "llvm/Support/CommandLine.h"
#include "llvm/Support/FileSystem.h"
#include "llvm/Support/Path.h"
#include "llvm/Support/raw_ostream.h"

using namespace mlir;
namespace cl = llvm::cl;

namespace bottleneck {

struct FlopByteInfo {
  double flops = 0.0;
  double bytes = 0.0;
};

// ────────────────────────────────────────────────────────────
//  간단한 정적 비용 추정기(예시 수준)
//  실제 계산식은 Op 의 tensor shape 를 읽어 채워 넣으이소!
// ────────────────────────────────────────────────────────────
static FlopByteInfo estimateCost(Operation *op) {
  StringRef name = op->getName().getStringRef();

  if (name.starts_with("linalg.matmul") ||
      name.starts_with("mhlo.dot_general")) {
    return {2.0, 0.0};                 // TODO: M·N·K 기반으로 계산
  } else if (name.starts_with("linalg.conv")) {
    return {10.0, 0.0};                // TODO: H·W·C·K 기반으로 계산
  } else {
    return {0.0, 0.0};
  }
}

// ────────────────────────────────────────────────────────────
//  Pass #1 : Op 단위 Flops / Bytes Attribute 삽입
// ────────────────────────────────────────────────────────────
struct CostModelPass
    : public PassWrapper<CostModelPass, OperationPass<ModuleOp>> {
  void runOnOperation() override {
    getOperation()->walk([&](Operation *op) {
      auto cost = estimateCost(op);
      op->setAttr("cost.flops",
                  FloatAttr::get(F64Type::get(op->getContext()), cost.flops));
      op->setAttr("cost.bytes",
                  FloatAttr::get(F64Type::get(op->getContext()), cost.bytes));
    });
  }
};

// ────────────────────────────────────────────────────────────
//  Pass #2 : 상위 K개 병목 Op 집계 → CSV 출력
// ────────────────────────────────────────────────────────────
struct AggregatorPass
    : public PassWrapper<AggregatorPass, OperationPass<ModuleOp>> {
  AggregatorPass(unsigned k = 5, std::string out = {})
      : topK(k), csvPath(std::move(out)) {}

  unsigned    topK;
  std::string csvPath;

  void runOnOperation() override {
    std::vector<std::pair<Operation *, double>> ops;

    getOperation()->walk([&](Operation *op) {
      if (auto fAttr = op->getAttrOfType<FloatAttr>("cost.flops"))
        ops.emplace_back(op, fAttr.getValueAsDouble());
    });
    llvm::sort(ops, [](auto a, auto b) { return a.second > b.second; });

    if (csvPath.empty())
      return;

    std::error_code ec;
    llvm::raw_fd_ostream csv(csvPath, ec,
                             llvm::sys::fs::OpenFlags::OF_Text);
    csv << "op,flops\n";
    for (unsigned i = 0; i < std::min(topK, (unsigned)ops.size()); ++i)
      csv << ops[i].first->getName() << "," << ops[i].second << "\n";
  }
};

// Pass 등록 (최신 API: 인자 없는 정적 객체)
static PassRegistration<CostModelPass> regCost("cost-model-pass",
                                               "Annotate ops with flop/byte");
static PassRegistration<AggregatorPass> regAgg("aggregate-pass",
                                               "Aggregate cost & emit CSV");

} // namespace bottleneck

// ────────────────────────────────────────────────────────────
//  메인: MLIR 파일 로드 → PassManager 실행
// ────────────────────────────────────────────────────────────
int main(int argc, char **argv) {
  cl::opt<std::string> inputFile(cl::Positional, cl::Required,
                                 cl::desc("<input .mlir file>"));
  cl::opt<std::string> csvFile("csv", cl::desc("CSV output path"));
  cl::opt<unsigned>    topK("topk", cl::init(5), cl::desc("Top-K ops"));

  cl::ParseCommandLineOptions(argc, argv, "MLIR Bottleneck Analyzer\n");

  MLIRContext ctx;
  ctx.loadDialect<mlir::func::FuncDialect>();   // 필요한 Dialect preload

  auto module = parseSourceFile<ModuleOp>(inputFile, &ctx);
  if (!module) {
    llvm::errs() << "❌  MLIR 파싱 실패: " << inputFile << "\n";
    return 1;
  }

  PassManager pm(&ctx);
  pm.addPass(std::make_unique<bottleneck::CostModelPass>());
  pm.addPass(
      std::make_unique<bottleneck::AggregatorPass>(topK, csvFile));

  if (failed(pm.run(*module))) {
    llvm::errs() << "❌  Pass 실행 실패\n";
    return 1;
  }
  llvm::outs() << "✅  분석 완료!\n";
  return 0;
}

