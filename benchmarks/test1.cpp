// test1.cpp — Benchmark for LCM vs GVN comparison
// Exercises partial redundancy elimination across several patterns:
//   - Full redundancy (CSE)
//   - Partial redundancy across branches
//   - Loop with repeated computation
//   - Nested expressions
//
// Build and run via benchmark.sh

#include <cstdint>
#include <cstdio>

// -------------------------------------------------------------------------
// T1 — Full redundancy
// a+b computed twice on all paths — one should be eliminated
// -------------------------------------------------------------------------
int full_redundancy(int a, int b, bool cond) {
    int x = a + b;
    int y;
    if (cond)
        y = a + b;  // redundant — x dominates
    else
        y = a + b;  // redundant — x dominates
    return x + y;
}

// -------------------------------------------------------------------------
// T2 — Partial redundancy
// a+b computed on one branch only, recomputed at merge
// -------------------------------------------------------------------------
int partial_redundancy(int a, int b, bool cond) {
    int x = 0;
    if (cond)
        x = a + b;  // computed on true branch only
    int y = a + b;  // partially redundant — missing on false path
    return x + y;
}

// -------------------------------------------------------------------------
// T3 — Loop with repeated computation of loop-invariant-like expression
// a+b is computed every iteration but operands don't change
// -------------------------------------------------------------------------
int loop_repeated(int a, int b, int n) {
    int sum = 0;
    for (int i = 0; i < n; i++) {
        sum += a + b;   // same value every iteration
        sum += a * b;   // same value every iteration
    }
    return sum;
}

// -------------------------------------------------------------------------
// T4 — Nested expressions
// Inner expression (a+b) feeds outer ((a+b)*c)
// Both are partially redundant
// -------------------------------------------------------------------------
int nested_exprs(int a, int b, int c, bool cond) {
    int x = 0;
    if (cond) {
        int inner = a + b;
        x = inner * c;
    }
    int inner2 = a + b;       // partially redundant inner
    int result = inner2 * c;  // partially redundant outer
    return x + result;
}

// -------------------------------------------------------------------------
// T5 — Multiple independent expressions
// Tests that bitvectors for different expressions don't interfere
// -------------------------------------------------------------------------
int multi_expr(int a, int b, int c, int d, bool cond) {
    int ab = a + b;
    int cd = c + d;
    int y = 0;
    if (cond)
        y = c + d;  // cd partially redundant
    int ab2 = a + b;  // ab fully redundant
    int cd2 = c + d;  // cd partially redundant
    return ab + cd + y + ab2 + cd2;
}

// -------------------------------------------------------------------------
// T6 — Chain redundancy
// Expression computed multiple times in straight-line code
// -------------------------------------------------------------------------
int chain_redundancy(int a, int b) {
    int v1 = a + b;
    int v2 = a + b;  // redundant
    int v3 = a + b;  // redundant
    int v4 = a + b;  // redundant
    return v1 + v2 + v3 + v4;
}

// -------------------------------------------------------------------------
// Driver — calls all functions with varying inputs to prevent DCE
// and produces output to prevent the compiler eliminating everything
// -------------------------------------------------------------------------
int main() {
    volatile int sink = 0;

    // Vary inputs to exercise different code paths
    for (int i = 0; i < 10000000; i++) {
        int a = i & 0xFF;
        int b = (i >> 8) & 0xFF;
        int c = (i >> 16) & 0xFF;
        int d = (i >> 24) & 0xFF;
        bool cond = (i & 1) != 0;

        sink ^= full_redundancy(a, b, cond);
        sink ^= partial_redundancy(a, b, cond);
        sink ^= loop_repeated(a, b, 10);
        sink ^= nested_exprs(a, b, c, cond);
        sink ^= multi_expr(a, b, c, d, cond);
        sink ^= chain_redundancy(a, b);
    }

    printf("Result: %d\n", (int)sink);
    return 0;
}
