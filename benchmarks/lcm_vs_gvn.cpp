// lcm_vs_gvn.cpp — Benchmark designed to expose the key difference between
// LCM (lazy placement) and GVN-PRE (earliest placement).
//
// The core difference: LCM inserts expressions as LATE as possible,
// minimizing the live range of temporaries and reducing register pressure.
// GVN-PRE inserts at the EARLIEST safe point, extending live ranges.
//
// This benchmark constructs scenarios where:
//   1. An expression is partially redundant across branches
//   2. The insertion point chosen by LCM vs GVN differs
//   3. The extended live range from GVN causes more register spills
//      on register-constrained code paths
//
// Build:
//   clang++ -O2                    lcm_vs_gvn.cpp -o bench_gvn
//   clang++ -O2 -mllvm -use-lcm   lcm_vs_gvn.cpp -o bench_lcm
//
// Run:
//   time ./bench_gvn
//   time ./bench_lcm

#include <cstdio>
#include <cstdlib>
#include <cstring>

// -------------------------------------------------------------------------
// Scenario 1 — Deep diamond with partial redundancy
//
// expr (a*b + c*d) is computed on the right branch and at the merge point.
// LCM: inserts on the left critical edge only, keeps expr at merge.
// GVN: hoists expr to entry (earliest point where both a,b,c,d are live).
//
// With many live variables, GVN's early hoist extends the live range of
// the temporary across the entire branch structure, increasing register
// pressure through the left and right branch bodies.
// -------------------------------------------------------------------------
__attribute__((noinline))
int deep_diamond(int a, int b, int c, int d,
                 int e, int f, int g, int h,
                 bool cond) {
    // Many live variables to fill registers
    int v0 = a ^ b;
    int v1 = c ^ d;
    int v2 = e ^ f;
    int v3 = g ^ h;
    int v4 = a + e;
    int v5 = b + f;
    int v6 = c + g;
    int v7 = d + h;

    int result = 0;

    if (cond) {
        // Long computation on true path — uses many registers
        result += v0 * v1;
        result += v2 * v3;
        result += v4 * v5;
        result += v6 * v7;
        result += v0 ^ v4;
        result += v1 ^ v5;
        result += v2 ^ v6;
        result += v3 ^ v7;
        // expression NOT computed here
    } else {
        // Long computation on false path
        result += v0 + v2;
        result += v1 + v3;
        result += v4 + v6;
        result += v5 + v7;
        // expression computed here
        result += a * b + c * d;   // partial redundancy source
    }

    // Merge point — expression partially redundant
    // LCM inserts on left (true) critical edge, keeps here
    // GVN hoists to entry
    result += a * b + c * d;

    return result;
}

// -------------------------------------------------------------------------
// Scenario 2 — Multi-path partial redundancy with heavy register usage
//
// Three paths converge at merge. Expression computed on two of three paths.
// LCM inserts on the missing path only (one critical edge).
// GVN hoists to entry.
// -------------------------------------------------------------------------
__attribute__((noinline))
int three_path(int a, int b, int c, int d, int selector) {
    int r0 = a * 3 + b * 7;
    int r1 = c * 5 + d * 11;
    int r2 = a * b + c;
    int r3 = b * c + d;
    int r4 = a * c + b * d;
    int r5 = (a ^ b) * (c ^ d);

    int result = 0;

    if (selector == 0) {
        // path 0 — expression NOT computed
        result = r0 * r1 + r2 * r3 + r4 * r5;
    } else if (selector == 1) {
        // path 1 — expression computed
        result = r0 + r1 + r2 + r3;
        result += a * b + c * d;   // source
    } else {
        // path 2 — expression computed
        result = r4 + r5 + r0 + r1;
        result += a * b + c * d;   // source
    }

    // Merge — partially redundant (missing on path 0)
    result += a * b + c * d;

    return result ^ r2 ^ r3;
}

// -------------------------------------------------------------------------
// Scenario 3 — Loop with partial redundancy on back edge
//
// Expression computed in loop body and also at the point after the loop.
// LCM keeps the expression in the loop body and at the post-loop use.
// GVN may hoist to loop preheader extending live range across entire loop.
// -------------------------------------------------------------------------
__attribute__((noinline))
int loop_partial(int a, int b, int c, int n) {
    int result = 0;

    // Heavy register usage inside loop
    int acc0 = a;
    int acc1 = b;
    int acc2 = c;
    int acc3 = a ^ b;
    int acc4 = b ^ c;
    int acc5 = a ^ c;

    for (int i = 0; i < n; i++) {
        // These update accumulators — keep registers busy
        acc0 = acc0 * 1000003 + i;
        acc1 = acc1 * 998244353 + acc0;
        acc2 = acc2 * 1000000007 + acc1;
        acc3 ^= acc0 * acc2;
        acc4 ^= acc1 * acc3;
        acc5 ^= acc2 * acc4;

        if (i & 1) {
            // expression computed on odd iterations
            result += a * b + b * c;
        }
    }

    // Post-loop — partially redundant with odd iterations
    result += a * b + b * c;

    return result ^ acc0 ^ acc1 ^ acc2 ^ acc3 ^ acc4 ^ acc5;
}

// -------------------------------------------------------------------------
// Scenario 4 — Nested partial redundancy
// Tests that LCM correctly handles dependent expressions lazily
// while GVN PRE places them earlier
// -------------------------------------------------------------------------
__attribute__((noinline))
int nested_partial(int a, int b, int c, bool cond0, bool cond1) {
    int result = 0;

    // Inner: a+b
    // Outer: (a+b)*c
    // Both partially redundant across two diamond levels

    if (cond0) {
        result += a * 3;
        if (cond1) {
            result += b * 7;
        } else {
            result += (a + b) * c;   // inner+outer on one path
        }
    } else {
        result += c * 11;
    }

    // First merge — (a+b) partially redundant
    int inner = a + b;
    result += inner;

    if (cond1) {
        result += inner * 2;
    } else {
        result += inner * c;   // outer partially redundant
    }

    // Second merge — (a+b)*c partially redundant
    result += (a + b) * c;

    return result;
}

// -------------------------------------------------------------------------
// Driver
// -------------------------------------------------------------------------
int main(int argc, char *argv[]) {
    // Use argc to prevent DCE of the functions
    int seed = (argc > 1) ? atoi(argv[1]) : 42;

    volatile long long sink = 0;
    const int N = 20000000;

    for (int i = 0; i < N; i++) {
        int a = (seed * i * 1000003) & 0x3FF;
        int b = (seed * i * 998244353) & 0x3FF;
        int c = (seed * i * 1000000007) & 0x3FF;
        int d = (seed * i * 999999937) & 0x3FF;
        int e = (a ^ b ^ seed) & 0x3FF;
        int f = (b ^ c ^ seed) & 0x3FF;
        int g = (c ^ d ^ seed) & 0x3FF;
        int h = (d ^ a ^ seed) & 0x3FF;
        bool cond  = (i & 1) != 0;
        bool cond2 = (i & 2) != 0;
        int  sel   = i % 3;

        sink += deep_diamond(a, b, c, d, e, f, g, h, cond);
        sink += three_path(a, b, c, d, sel);
        sink += loop_partial(a, b, c, 8);
        sink += nested_partial(a, b, c, cond, cond2);
    }

    printf("Result: %lld\n", sink);
    return 0;
}
