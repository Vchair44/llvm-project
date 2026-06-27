// register_pressure.cpp — Forces genuine register pressure to expose the
// difference between LCM's lazy (late) placement and GVN's earliest placement.
//
// Strategy: keep 20-30+ values simultaneously live across a partial-redundancy
// branch, so that ANY value hoisted earlier than strictly necessary increases
// the live-range overlap and forces the register allocator to spill something.
//
// x86-64 has 16 general purpose registers (minus rsp/rbp typically unusable,
// so ~14 usable). We deliberately exceed that by a wide margin in the "hot"
// region surrounding the partially-redundant expression.
//
// Build:
//   clang++ -O2                  register_pressure.cpp -o bench_gvn
//   clang++ -O2 -mllvm -use-lcm register_pressure.cpp -o bench_lcm
//
// Inspect spills directly (most reliable signal, not just IR instr count):
//   clang++ -O2 -S register_pressure.cpp -o gvn.s
//   clang++ -O2 -mllvm -use-lcm -S register_pressure.cpp -o lcm.s
//   grep -c "(%rsp)\|(%rbp)" gvn.s   # stack-relative accesses ~ spill proxy
//   grep -c "(%rsp)\|(%rbp)" lcm.s

#include <cstdio>
#include <cstdlib>

__attribute__((noinline))
long long heavy_register_pressure(
    int a, int b, int c, int d, int e, int f, int g, int h,
    int i, int j, int k, int l, int m, int n, int o, int p,
    bool cond) {

    // 16 independent live values just from parameters. Now derive 16 more,
    // all of which must stay live across the branch below because they're
    // used again after it. This alone is double the GPR count on x86-64.
    int v0  = a ^ b;
    int v1  = b ^ c;
    int v2  = c ^ d;
    int v3  = d ^ e;
    int v4  = e ^ f;
    int v5  = f ^ g;
    int v6  = g ^ h;
    int v7  = h ^ i;
    int v8  = i ^ j;
    int v9  = j ^ k;
    int v10 = k ^ l;
    int v11 = l ^ m;
    int v12 = m ^ n;
    int v13 = n ^ o;
    int v14 = o ^ p;
    int v15 = p ^ a;

    long long acc = 0;

    if (cond) {
        // True branch: every one of v0..v15 plus a..p must stay live through
        // here (they're all used again after the branch). The partially
        // redundant expression (a*b + c*d) is NOT computed on this path.
        acc += (long long)v0 * v1;
        acc += (long long)v2 * v3;
        acc += (long long)v4 * v5;
        acc += (long long)v6 * v7;
        acc += (long long)v8 * v9;
        acc += (long long)v10 * v11;
        acc += (long long)v12 * v13;
        acc += (long long)v14 * v15;
        acc += (long long)a * e + (long long)b * f;
        acc += (long long)c * g + (long long)d * h;
        acc += (long long)i * m + (long long)j * n;
        acc += (long long)k * o + (long long)l * p;
        // expression NOT computed here
    } else {
        // False branch: same heavy live set, PLUS the partially redundant
        // expression IS computed here.
        acc += (long long)v0 ^ v8;
        acc += (long long)v1 ^ v9;
        acc += (long long)v2 ^ v10;
        acc += (long long)v3 ^ v11;
        acc += (long long)v4 ^ v12;
        acc += (long long)v5 ^ v13;
        acc += (long long)v6 ^ v14;
        acc += (long long)v7 ^ v15;
        acc += (long long)a + b + c + d;
        acc += (long long)e + f + g + h;
        acc += (long long)i + j + k + l;
        acc += (long long)m + n + o + p;
        acc += (long long)(a * b) + (c * d);   // partial redundancy source
    }

    // Merge point: ALL 16 v-values AND all 16 parameters are still live here
    // (used below), maximizing pressure exactly where the partially-redundant
    // expression needs to be resolved.
    //
    //   GVN-PRE: tends to hoist (a*b + c*d) to the earliest legal point,
    //            extending its live range across the ENTIRE branch above,
    //            competing with all 32 already-live values for registers.
    //   LCM:     places it as late as possible — right here, at the merge,
    //            minimizing how long the new temporary needs to stay live
    //            before being consumed.
    acc += (long long)(a * b) + (c * d);

    // Heavy consumption of everything to prevent DCE and to keep all
    // 32 values genuinely live across the entire function body.
    acc += (long long)v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7;
    acc += (long long)v8 + v9 + v10 + v11 + v12 + v13 + v14 + v15;
    acc += (long long)a + b + c + d + e + f + g + h;
    acc += (long long)i + j + k + l + m + n + o + p;

    return acc;
}

// Second, deeper variant: three-way partial redundancy under the same
// register pressure conditions, to see if the effect compounds.
__attribute__((noinline))
long long heavy_register_pressure_3way(
    int a, int b, int c, int d, int e, int f, int g, int h,
    int i, int j, int k, int l, int m, int n, int o, int p,
    int selector) {

    int v0  = a ^ b ^ c;
    int v1  = b ^ c ^ d;
    int v2  = c ^ d ^ e;
    int v3  = d ^ e ^ f;
    int v4  = e ^ f ^ g;
    int v5  = f ^ g ^ h;
    int v6  = g ^ h ^ i;
    int v7  = h ^ i ^ j;
    int v8  = i ^ j ^ k;
    int v9  = j ^ k ^ l;
    int v10 = k ^ l ^ m;
    int v11 = l ^ m ^ n;
    int v12 = m ^ n ^ o;
    int v13 = n ^ o ^ p;
    int v14 = o ^ p ^ a;
    int v15 = p ^ a ^ b;

    long long acc = 0;

    if (selector == 0) {
        acc += (long long)v0 * v15 + (long long)v1 * v14;
        acc += (long long)v2 * v13 + (long long)v3 * v12;
        acc += (long long)v4 * v11 + (long long)v5 * v10;
        acc += (long long)v6 * v9  + (long long)v7 * v8;
        // expr NOT here
    } else if (selector == 1) {
        acc += (long long)v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7;
        acc += (long long)(a * b) + (c * d);   // expr here
    } else {
        acc += (long long)v8 + v9 + v10 + v11 + v12 + v13 + v14 + v15;
        acc += (long long)(a * b) + (c * d);   // expr here
    }

    // partially redundant at merge (missing on selector==0 path)
    acc += (long long)(a * b) + (c * d);

    acc += (long long)v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7;
    acc += (long long)v8 + v9 + v10 + v11 + v12 + v13 + v14 + v15;
    acc += (long long)a + b + c + d + e + f + g + h;
    acc += (long long)i + j + k + l + m + n + o + p;

    return acc;
}

int main(int argc, char *argv[]) {
    int seed = (argc > 1) ? atoi(argv[1]) : 7;
    volatile long long sink = 0;
    const int N = 30000000;

    for (int idx = 0; idx < N; idx++) {
        int a = (seed * idx * 1000003)   & 0xFF;
        int b = (seed * idx * 998244353) & 0xFF;
        int c = (seed * idx * 999999937) & 0xFF;
        int d = (seed * idx * 1664525)   & 0xFF;
        int e = (a ^ seed) & 0xFF;
        int f = (b ^ seed) & 0xFF;
        int g = (c ^ seed) & 0xFF;
        int h = (d ^ seed) & 0xFF;
        int i = (a + b) & 0xFF;
        int j = (c + d) & 0xFF;
        int k = (e + f) & 0xFF;
        int l = (g + h) & 0xFF;
        int m = (a ^ c) & 0xFF;
        int n = (b ^ d) & 0xFF;
        int o = (e ^ g) & 0xFF;
        int p = (f ^ h) & 0xFF;
        bool cond = (idx & 1) != 0;
        int sel = idx % 3;

        sink += heavy_register_pressure(a, b, c, d, e, f, g, h,
                                        i, j, k, l, m, n, o, p, cond);
        sink += heavy_register_pressure_3way(a, b, c, d, e, f, g, h,
                                             i, j, k, l, m, n, o, p, sel);
    }

    printf("Result: %lld\n", sink);
    return 0;
}
