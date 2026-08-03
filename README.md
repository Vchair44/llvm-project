
##FOR GRADING: Where to find and run unittests

**Primary mechanism demonstration** - `llvm-project/benchmarks/benchmark.sh`
compares baseline GVN-PRE against LCM on a given C++ source file: IR
instruction counts, PHI counts, binary size, and runtime, side by side.

    cd /work/llvm-project/benchmarks
        ./benchmark.sh register_pressure.cpp

`register_pressure.cpp` is the primary file evidence it's built
specifically to expose register-pressure effects, and is the source of
the paper's headline PHI-count finding (GVN-PRE: 55 PHIs vs. LCM: 8 PHIs
on this file, demonstrating LCM's value-numbering does substantially
less PRE work than baseline GVN-PRE, not a placement difference).

**Hand-written CFG suite** test `llvm-project/benchmarks/ll_tests/`
contains `test_mixed.ll`, a 14-case suite (T1PRE scenarios (full redundancy, partial redundancy, loop invariance,
nested expressions, commutativity, PHI-kill transparency, etc.), plus
`test_mixed_mod.ll` showing LCM's actual output on that suite. Run
directly against the pass:

    cd /work/llvm-project/benchmarks/ll_tests
        opt -passes=lcm -S test_mixed.ll -o /tmp/out.ll
	    diff /tmp/out.ll test_mixed_mod.ll   # should be empty/cosmetic-only

**Embench-IoT real results** hardware see the top-level Quick Start
below; `scripts/summarize_embench_results.py` reproduces the paper's
Embench geomean directly from real, already-collected Pi 5 data.





# The LLVM Compiler Infrastructure

[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/llvm/llvm-project/badge)](https://securityscorecards.dev/viewer/?uri=github.com/llvm/llvm-project)
[![OpenSSF Best Practices](https://www.bestpractices.dev/projects/8273/badge)](https://www.bestpractices.dev/projects/8273)
[![libc++](https://github.com/llvm/llvm-project/actions/workflows/libcxx-build-and-test.yaml/badge.svg?branch=main&event=schedule)](https://github.com/llvm/llvm-project/actions/workflows/libcxx-build-and-test.yaml?query=event%3Aschedule)

Welcome to the LLVM project!

This repository contains the source code for LLVM, a toolkit for the
construction of highly optimized compilers, optimizers, and run-time
environments.

The LLVM project has multiple components. The core of the project is
itself called "LLVM". This contains all of the tools, libraries, and header
files needed to process intermediate representations and convert them into
object files. Tools include an assembler, disassembler, bitcode analyzer, and
bitcode optimizer.

C-like languages use the [Clang](https://clang.llvm.org/) frontend. This
component compiles C, C++, Objective-C, and Objective-C++ code into LLVM bitcode
-- and from there into object files, using LLVM.

Other components include:
the [libc++ C++ standard library](https://libcxx.llvm.org),
the [LLD linker](https://lld.llvm.org), and more.

## Getting the Source Code and Building LLVM

Consult the
[Getting Started with LLVM](https://llvm.org/docs/GettingStarted.html#getting-the-source-code-and-building-llvm)
page for information on building and running LLVM.

For information on how to contribute to the LLVM project, please take a look at
the [Contributing to LLVM](https://llvm.org/docs/Contributing.html) guide.

## Getting in touch

Join the [LLVM Discourse forums](https://discourse.llvm.org/), [Discord
chat](https://discord.gg/xS7Z362),
[LLVM Office Hours](https://llvm.org/docs/GettingInvolved.html#office-hours) or
[Regular sync-ups](https://llvm.org/docs/GettingInvolved.html#online-sync-ups).

The LLVM project has adopted a [code of conduct](https://llvm.org/docs/CodeOfConduct.html) for
participants to all modes of communication within the project.
