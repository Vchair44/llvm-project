#!/bin/bash
LLVM_BUILD=../build/bin
CLANG=$LLVM_BUILD/clang++    # clang++ for C++
OPT=$LLVM_BUILD/opt
INPUT=$1
NUM_RUNS=${2:-5}
if [ -z "$INPUT" ]; then
  echo "Usage: ./benchmark.sh <input.cpp> [num_runs]"
  exit 1
fi
BASE=$(basename $INPUT .cpp)
echo "=== Compiling ==="
$CLANG -O2 $INPUT -o ${BASE}_gvn
$CLANG -O2 -mllvm -use-lcm $INPUT -o ${BASE}_lcm
echo ""
echo "=== IR Instruction Counts ==="
GVN_IR=$(mktemp).ll
LCM_IR=$(mktemp).ll
$CLANG -O2 -emit-llvm -S $INPUT -o $GVN_IR 2>/dev/null
$CLANG -O2 -mllvm -use-lcm -emit-llvm -S $INPUT -o $LCM_IR 2>/dev/null
GVN_COUNT=$(grep -c "^\s*%" $GVN_IR)
LCM_COUNT=$(grep -c "^\s*%" $LCM_IR)
echo "GVN instruction count: $GVN_COUNT"
echo "LCM instruction count: $LCM_COUNT"
rm -f $GVN_IR $LCM_IR
echo ""
echo "=== Runtime ($NUM_RUNS runs each) ==="
echo "GVN timings:"
for i in $(seq 1 $NUM_RUNS); do
  { time ./${BASE}_gvn; } 2>&1 | grep real
done
echo "LCM timings:"
for i in $(seq 1 $NUM_RUNS); do
  { time ./${BASE}_lcm; } 2>&1 | grep real
done
echo ""
echo "=== Binary Sizes ==="
echo "GVN: $(wc -c < ${BASE}_gvn) bytes"
echo "LCM: $(wc -c < ${BASE}_lcm) bytes"
