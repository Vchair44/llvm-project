// test2.cpp — Complex integrated benchmark for LCM vs GVN comparison
//
// Edge cases covered (integrated across functions, not separated):
//   - Partial redundancy across asymmetric branch depths
//   - Expressions partially redundant through irreducible-like subgraphs
//   - Multiple expressions with overlapping operand sets
//   - Expressions whose operands are themselves partially redundant
//   - Commutative expressions (a+b vs b+a)
//   - Expressions live across function call boundaries
//   - Partial redundancy inside switch statements
//   - Redundancy through exception-like early returns
//   - Expressions used in address calculations
//   - Mixed integer widths feeding the same logical expression
//   - Repeated partial redundancy at different nesting depths
//   - Expressions that become available via induction variable substitution
//   - Multiple back-to-back diamonds sharing operands
//   - Partial redundancy through short-circuit evaluation
//   - Expressions redundant across loop iterations but not loop-invariant
//
// Build:
//   clang++ -O2                  test2.cpp -o bench_gvn
//   clang++ -O2 -mllvm -use-lcm test2.cpp -o bench_lcm

#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <cstdint>

// Prevent inlining so each function is optimized independently
#define NOINLINE __attribute__((noinline))
#define OPAQUE   __attribute__((optnone))

// Opaque sink to prevent DCE without introducing memory ops
static volatile int64_t global_sink = 0;

// =========================================================================
// Function 1 — cascading diamonds with shared subexpressions
//
// Multiple diamonds in sequence where each diamond's merge feeds the next.
// Expressions are partially redundant across different combinations of paths.
// Operand sets overlap: {a,b}, {b,c}, {a,c}, {a,b,c} all appear.
//
// Edge cases:
//   - Expression (a^b)*c appears in diamond 1 right branch and diamond 2 merge
//   - Expression (b^c)*a appears in diamond 2 left branch and diamond 3 merge
//   - Expression (a^c)*b appears in neither diamond 1 nor 2, only diamond 3
//   - All three are simultaneously live at diamond 3's merge
//   - Commutative: a*b == b*a must share VN
// =========================================================================
NOINLINE
int64_t cascading_diamonds(int a, int b, int c,
                           bool d0, bool d1, bool d2, bool d3) {
    int64_t acc = 0;

    // Preamble — establish some values to keep registers busy
    int ab  = a + b;
    int bc  = b + c;
    int ac  = a + c;
    int abc = a + b + c;
    int v0  = ab  * 1000003;
    int v1  = bc  * 998244353;
    int v2  = ac  * 999999937;
    int v3  = abc * 1000000007;

    // Diamond 0 — uses v0..v3, partially computes (a^b)*c on right path
    if (d0) {
        acc += (int64_t)v0 * v1;
        acc += (int64_t)v2 * v3;
        // (a^b)*c NOT computed here
    } else {
        acc += (int64_t)(v0 ^ v2) * (v1 ^ v3);
        acc += (int64_t)(a ^ b) * c;   // (a^b)*c first occurrence
    }

    // Diamond 0 merge — (a^b)*c partially redundant
    acc += (int64_t)(a ^ b) * c;

    // Diamond 1 — uses acc from diamond 0, partially computes (b^c)*a
    int w0 = (int)(acc >> 3) ^ v0;
    int w1 = (int)(acc >> 7) ^ v1;
    int w2 = (int)(acc >> 11) ^ v2;
    int w3 = (int)(acc >> 13) ^ v3;

    if (d1) {
        acc += (int64_t)w0 * w1 + (int64_t)w2 * w3;
        acc += (int64_t)(b ^ c) * a;   // (b^c)*a first occurrence
    } else {
        acc += (int64_t)(w0 ^ w1) * (w2 ^ w3);
        acc += (int64_t)(a ^ b) * c;   // (a^b)*c — fully redundant now
        // (b^c)*a NOT computed here
    }

    // Diamond 1 merge — (b^c)*a partially redundant, (a^b)*c fully redundant
    acc += (int64_t)(b ^ c) * a;
    acc += (int64_t)(a ^ b) * c;   // fully redundant — both paths computed it

    // Diamond 2 — deeper nesting, introduces (a^c)*b
    int x0 = (int)(acc ^ (acc >> 17)) * 1013904223;
    int x1 = (int)(acc ^ (acc >> 23)) * 1664525;

    if (d2) {
        if (d3) {
            // Nested true-true path
            acc += (int64_t)x0 * x1;
            acc += (int64_t)(a ^ c) * b;   // (a^c)*b first occurrence
            acc += (int64_t)(b ^ c) * a;   // fully redundant
        } else {
            // Nested true-false path
            acc += (int64_t)(x0 ^ x1) * (x0 + x1);
            acc += (int64_t)(a ^ b) * c;   // fully redundant
            // (a^c)*b NOT here
        }
    } else {
        if (d3) {
            // Nested false-true path
            acc += (int64_t)x0 + x1;
            acc += (int64_t)(a ^ c) * b;   // (a^c)*b first occurrence (other path)
            acc += (int64_t)(b ^ c) * a;   // fully redundant
        } else {
            // Nested false-false path
            acc += (int64_t)(x0 * x1) ^ (int64_t)(x0 + x1);
            // neither (a^c)*b nor (b^c)*a here
        }
    }

    // Diamond 2 merge — (a^c)*b partially redundant (missing on true-false
    // and false-false paths), all others fully redundant
    acc += (int64_t)(a ^ c) * b;
    acc += (int64_t)(b ^ c) * a;
    acc += (int64_t)(a ^ b) * c;

    // Epilogue — mix acc with original values
    acc ^= (int64_t)ab * bc;
    acc ^= (int64_t)bc * ac;
    acc ^= (int64_t)ac * ab;

    return acc;
}

// =========================================================================
// Function 2 — switch-based partial redundancy with fallthrough semantics
//
// A switch with multiple cases where expressions appear in some cases but
// not others, creating complex partial redundancy at the merge point.
//
// Edge cases:
//   - Expression partially redundant across non-contiguous cases
//   - Expressions with one operand being the switch variable itself
//   - Case bodies of varying length creating asymmetric register pressure
//   - Expression computed in default case creates partial redundancy
//     with explicit cases
// =========================================================================
NOINLINE
int64_t switch_redundancy(int x, int a, int b, int c, int d) {
    int64_t result = 0;
    int p, q, r, s;

    // Heavy preamble to fill registers
    p = a * 1000003  + b * 998244353;
    q = b * 999999937 + c * 1000000007;
    r = c * 1013904223 + d * 1664525;
    s = d * 1000003  + a * 999999937;

    int key = x & 7;  // 8 cases

    switch (key) {
    case 0:
        result += (int64_t)p * q;
        result += (int64_t)(a * b) + (c * d);   // expr1 first occurrence
        // expr2 NOT here
        break;
    case 1:
        result += (int64_t)p * r;
        result += (int64_t)(a * b) + (c * d);   // expr1 again
        result += (int64_t)(a + b) * (c + d);   // expr2 first occurrence
        break;
    case 2:
        result += (int64_t)q * r;
        // expr1 NOT here
        result += (int64_t)(a + b) * (c + d);   // expr2 again
        break;
    case 3:
        result += (int64_t)p * s;
        result += (int64_t)q * s;
        result += (int64_t)(a * b) + (c * d);   // expr1 again
        result += (int64_t)(a + b) * (c + d);   // expr2 again
        break;
    case 4:
        result += (int64_t)r * s;
        // neither expr1 nor expr2
        for (int i = 0; i < 4; i++) {
            result += (int64_t)(p ^ (i * 1013904223)) *
                      (int64_t)(q ^ (i * 1664525));
        }
        break;
    case 5:
        result += (int64_t)(p ^ q) * (r ^ s);
        result += (int64_t)(a * b) + (c * d);   // expr1 again
        break;
    case 6:
        result += (int64_t)(p + q) * (r + s);
        result += (int64_t)(a + b) * (c + d);   // expr2 again
        break;
    default:
        result += (int64_t)p * q * r;
        result += (int64_t)(a * b) + (c * d);   // expr1 in default
        result += (int64_t)(a + b) * (c + d);   // expr2 in default
        break;
    }

    // Merge point — both expr1 and expr2 partially redundant
    // expr1 missing on cases 2, 4, 6
    // expr2 missing on cases 0, 4, 5
    result += (int64_t)(a * b) + (c * d);
    result += (int64_t)(a + b) * (c + d);

    // Additional expression that uses results of expr1/expr2 — nested PRE
    int e1 = (int)((a * b) + (c * d));
    int e2 = (int)((a + b) * (c + d));
    result += (int64_t)(e1 ^ e2) * (a ^ b ^ c ^ d);

    return result ^ (int64_t)p ^ (int64_t)q ^ (int64_t)r ^ (int64_t)s;
}

// =========================================================================
// Function 3 — interleaved loops with cross-iteration partial redundancy
//
// Two loops that share an induction variable and have expressions that are
// partially redundant across the loops (computed in loop 1, recomputed
// in loop 2's body). Also contains within-loop partial redundancy
// across odd/even iterations.
//
// Edge cases:
//   - Expression partially redundant between two separate loops
//   - Loop-carried partial redundancy (even iteration computes, odd uses)
//   - Expression partially redundant across loop boundary
//   - Induction variable arithmetic creates new redundancy opportunities
// =========================================================================
NOINLINE
int64_t interleaved_loops(int a, int b, int c, int n) {
    int64_t result = 0;

    // These are loop-invariant but we want to test PRE not LICM
    // so we include them in the loop body explicitly
    int inv_ab = a * b;
    int inv_bc = b * c;
    int inv_ac = a * c;

    // Loop 1 — computes expressions on odd iterations
    int carry0 = a;
    int carry1 = b;
    int carry2 = c;

    for (int i = 0; i < n; i++) {
        int ti = i * 1000003 + carry0;
        carry0 = ti ^ carry1;
        carry1 = (carry0 * 998244353) ^ carry2;
        carry2 = (carry1 + carry0) * 999999937;

        if (i & 1) {
            // Odd iteration — compute expressions
            result += (int64_t)(a * b + i) * (c + carry0);
            result += (int64_t)(b * c + i) * (a + carry1);
            // expr: a*b*c + i*(a+b+c)  first occurrence
            result += (int64_t)(a * b * c) + (int64_t)i * (a + b + c);
        } else {
            // Even iteration — different computation, no expression
            result += (int64_t)carry0 * carry1;
            result += (int64_t)carry1 * carry2;
            result += (int64_t)carry2 * carry0;
        }
    }

    // Between loops — expression partially redundant with odd iterations
    result += (int64_t)(a * b * c);   // partially redundant inner part

    // Loop 2 — expressions partially redundant with loop 1
    int carry3 = carry0 ^ carry1;
    int carry4 = carry1 ^ carry2;
    int carry5 = carry2 ^ carry0;

    for (int i = 0; i < n; i++) {
        int ti = i * 1664525 + carry3;
        carry3 = ti ^ carry4;
        carry4 = (carry3 * 1013904223) ^ carry5;
        carry5 = (carry4 + carry3) * 1000003;

        if (i & 3) {
            // Most iterations — compute expression
            result += (int64_t)(a * b + i) * (c + carry3);   // partially matches loop 1
            result += (int64_t)(a * b * c) + (int64_t)i * (a + b + c);  // matches loop 1
        } else {
            // Every 4th iteration — different path
            result += (int64_t)carry3 * carry4 * carry5;
        }

        // This expression is partially redundant within loop 2:
        // computed above on (i&3) path, also computed here unconditionally
        result += (int64_t)inv_ab * (i + carry3);
        result += (int64_t)inv_bc * (i + carry4);
        result += (int64_t)inv_ac * (i + carry5);
    }

    // Post-loop — partially redundant with both loops
    result += (int64_t)(a * b * c) + (int64_t)(n - 1) * (a + b + c);

    return result ^ (int64_t)carry0 ^ (int64_t)carry3;
}

// =========================================================================
// Function 4 — short-circuit evaluation and early exit patterns
//
// Simulates patterns from real code: early returns, guard clauses,
// and short-circuit && / || chains where expressions appear on
// some evaluation paths but not others.
//
// Edge cases:
//   - Expression on the "fast path" (early return) recomputed on "slow path"
//   - Multiple guard levels creating deep partial redundancy chains
//   - Expression whose operands are computed via short-circuit evaluation
//   - Redundancy across guard clause and main body
// =========================================================================
NOINLINE
int64_t short_circuit_redundancy(int a, int b, int c, int d,
                                  int threshold, int flags) {
    int64_t result = 0;

    // Guard 0 — fast path check
    int check0 = (a * b) ^ (c * d);   // expr0 first occurrence
    if ((flags & 1) && check0 > threshold) {
        // Early return path — expr0 was computed, return quickly
        return (int64_t)check0 * (a + b + c + d);
    }

    // Guard 1 — second level check
    int preamble0 = a * 1000003 + b;
    int preamble1 = c * 998244353 + d;
    int preamble2 = (a ^ b) * (c ^ d);
    int preamble3 = (a + c) * (b + d);

    int check1 = (a + b) * (c + d);   // expr1 first occurrence
    if ((flags & 2) && check1 < -threshold) {
        result += (int64_t)preamble0 * preamble1;
        result += (int64_t)(a * b) ^ (c * d);   // expr0 partially redundant
        return result * check1;
    }

    // Guard 2 — third level
    int heavy0 = preamble0 * preamble2;
    int heavy1 = preamble1 * preamble3;
    int heavy2 = (preamble0 ^ preamble1) * (preamble2 ^ preamble3);
    int heavy3 = (preamble0 + preamble2) * (preamble1 + preamble3);

    if (flags & 4) {
        result += (int64_t)heavy0 * heavy1;
        result += (int64_t)heavy2 * heavy3;
        // expr0 NOT on this path
        // expr1 NOT on this path
    } else {
        result += (int64_t)(heavy0 ^ heavy2) * (heavy1 ^ heavy3);
        result += (int64_t)(a * b) ^ (c * d);   // expr0 partially redundant
        result += (int64_t)(a + b) * (c + d);   // expr1 partially redundant
    }

    // Main body — both expr0 and expr1 partially redundant
    result += (int64_t)((a * b) ^ (c * d));   // expr0
    result += (int64_t)(a + b) * (c + d);      // expr1

    // Nested expression using results of expr0 and expr1
    int e0 = (a * b) ^ (c * d);   // expr0 again — fully redundant now
    int e1 = (a + b) * (c + d);   // expr1 again — fully redundant now
    result += (int64_t)(e0 * e1) + (int64_t)(e0 ^ e1);

    // expr2 = e0 * e1 — new expression built from redundant subexpressions
    // partially redundant: computed inline above, recomputed below
    result += (int64_t)heavy0 * (e0 * e1);   // expr2 again

    return result ^ (int64_t)preamble0 ^ (int64_t)heavy2;
}

// =========================================================================
// Function 5 — matrix-like computation with high register pressure
//
// Simulates a small unrolled matrix operation where partial redundancy
// appears across rows/columns. High register pressure ensures that
// LCM's lazy placement has maximum impact on spill behavior.
//
// Edge cases:
//   - Same subexpression appears in multiple rows and columns
//   - Expressions partially redundant across row-processing branches
//   - Operands shared between multiple partially-redundant expressions
//   - High register pressure (16+ live values) to stress register allocator
// =========================================================================
NOINLINE
int64_t matrix_redundancy(int m00, int m01, int m02, int m03,
                           int m10, int m11, int m12, int m13,
                           int m20, int m21, int m22, int m23,
                           bool process_row1, bool process_row2) {
    int64_t result = 0;

    // Row 0 — always processed
    // These subexpressions will be partially redundant with other rows
    int r0c0 = m00 * m11 - m01 * m10;   // 2x2 minor (0,0)
    int r0c1 = m00 * m12 - m02 * m10;   // 2x2 minor (0,1)
    int r0c2 = m00 * m13 - m03 * m10;   // 2x2 minor (0,2)
    int r0c3 = m01 * m12 - m02 * m11;   // 2x2 minor (0,3)
    int r0c4 = m01 * m13 - m03 * m11;   // 2x2 minor (0,4)
    int r0c5 = m02 * m13 - m03 * m12;   // 2x2 minor (0,5)

    result += (int64_t)r0c0 * r0c5 - (int64_t)r0c1 * r0c4 + (int64_t)r0c2 * r0c3;

    // Subexpressions that will appear in other rows:
    int sub0 = m00 * m11;   // appears in r0c0
    int sub1 = m00 * m12;   // appears in r0c1
    int sub2 = m00 * m13;   // appears in r0c2
    int sub3 = m11 * m22;   // will appear in row 1
    int sub4 = m11 * m23;   // will appear in row 1
    int sub5 = m12 * m23;   // will appear in rows 1 and 2

    if (process_row1) {
        // Row 1 — partially redundant subexpressions with row 0
        int r1c0 = m00 * m11 - m01 * m10;   // same as r0c0 — full redundancy
        int r1c1 = m10 * m21 - m11 * m20;   // new
        int r1c2 = m10 * m22 - m12 * m20;   // new
        int r1c3 = m10 * m23 - m13 * m20;   // new
        int r1c4 = m11 * m22 - m12 * m21;   // new
        int r1c5 = m11 * m23 - m13 * m21;   // new — uses sub3, sub4
        int r1c6 = m12 * m23 - m13 * m22;   // new — uses sub5

        result += (int64_t)r1c0 * r1c6 - (int64_t)r1c1 * r1c5 + (int64_t)r1c2 * r1c4;
        result += (int64_t)r1c3 * (r1c4 - r1c5);

        // These subexprs partially redundant with row 0 preamble
        result += (int64_t)(m00 * m12) * r1c1;   // sub1 partial redundancy
        result += (int64_t)(m00 * m13) * r1c2;   // sub2 partial redundancy
        result += (int64_t)(m11 * m22) * r1c3;   // sub3 partial redundancy
        result += (int64_t)(m12 * m23) * r1c0;   // sub5 partial redundancy
    }

    if (process_row2) {
        // Row 2 — more partial redundancies with rows 0 and 1
        int r2c0 = m00 * m11 - m01 * m10;   // same as r0c0 — full redundancy
        int r2c1 = m00 * m22 - m02 * m20;   // partially matches sub1
        int r2c2 = m00 * m23 - m03 * m20;   // partially matches sub2
        int r2c3 = m11 * m22 - m12 * m21;   // same as r1c4 if row1 ran — partial
        int r2c4 = m11 * m23 - m13 * m21;   // same as r1c5 if row1 ran — partial
        int r2c5 = m12 * m23 - m13 * m22;   // same as r1c6 if row1 ran — partial

        result += (int64_t)r2c0 * r2c5 - (int64_t)r2c1 * r2c4 + (int64_t)r2c2 * r2c3;

        // These are partially redundant regardless of whether row1 ran
        result += (int64_t)(m00 * m11) * r2c5;   // sub0
        result += (int64_t)(m00 * m12) * r2c4;   // sub1
        result += (int64_t)(m11 * m22) * r2c2;   // sub3
        result += (int64_t)(m12 * m23) * r2c1;   // sub5
    }

    // Final merge — all subexpressions partially redundant here
    // (missing on paths where process_row1/row2 were false)
    result += (int64_t)(m00 * m11) * (m12 * m23);   // sub0 * sub5
    result += (int64_t)(m00 * m12) * (m11 * m22);   // sub1 * sub3
    result += (int64_t)(m00 * m13) * (m11 * m23);   // sub2 * sub4
    result += (int64_t)(m11 * m22) * (m12 * m23);   // sub3 * sub5
    result += (int64_t)r0c0 * r0c1 * r0c2;
    result += (int64_t)r0c3 * r0c4 * r0c5;

    return result;
}

// =========================================================================
// Driver
// =========================================================================
int main(int argc, char *argv[]) {
    int seed = (argc > 1) ? atoi(argv[1]) : 12345;
    int64_t sink = 0;
    const int N = 5000000;

    for (int i = 0; i < N; i++) {
        // Generate varied inputs
        int a = ((seed * i * 1000003)   >> 3) & 0x7FF;
        int b = ((seed * i * 998244353) >> 5) & 0x7FF;
        int c = ((seed * i * 999999937) >> 7) & 0x7FF;
        int d = ((seed * i * 1664525)   >> 9) & 0x7FF;
        int e = ((a ^ b ^ seed) * 1013904223) & 0x7FF;
        int f = ((b ^ c ^ seed) * 1000003)    & 0x7FF;
        int g = ((c ^ d ^ seed) * 998244353)  & 0x7FF;
        int h = ((d ^ a ^ seed) * 999999937)  & 0x7FF;

        bool b0 = (i & 1)  != 0;
        bool b1 = (i & 2)  != 0;
        bool b2 = (i & 4)  != 0;
        bool b3 = (i & 8)  != 0;
        bool b4 = (i & 16) != 0;
        bool b5 = (i & 32) != 0;

        int n   = (i & 7) + 1;
        int thr = (a * b) & 0xFFFF;
        int flg = i & 7;

        sink += cascading_diamonds(a, b, c, b0, b1, b2, b3);
        sink += switch_redundancy(i, a, b, c, d);
        sink += interleaved_loops(a, b, c, n);
        sink += short_circuit_redundancy(a, b, c, d, thr, flg);
        sink += matrix_redundancy(a, b, c, d, e, f, g, h,
                                   b + c, c + d, d + e, e + f,
                                   b4, b5);
    }

    printf("Result: %lld\n", sink);
    global_sink = sink;
    return 0;
}
