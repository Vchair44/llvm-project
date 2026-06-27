#!/usr/bin/env python3
"""
block_dump.py — Print the FULL instruction list for named blocks in a .ll file,
and flag any instruction whose (opcode, operand-text) signature appears more
than once within the same block (a same-path duplicate computation).

Usage:
    python3 block_dump.py file.ll func_name block1 [block2 block3 ...]
"""

import re
import sys
from collections import OrderedDict, defaultdict


def parse_functions(path):
    funcs = OrderedDict()
    cur_func = None
    cur_block = None

    func_re = re.compile(r'^define .*@([\w.]+)\s*\(')
    block_re = re.compile(r'^([\w.$-]+):')
    end_re = re.compile(r'^}')

    with open(path) as f:
        for line in f:
            raw = line.rstrip('\n')
            line = raw

            m = func_re.match(line)
            if m:
                cur_func = m.group(1)
                funcs[cur_func] = OrderedDict()
                cur_block = "entry_implicit"
                funcs[cur_func][cur_block] = []
                continue

            if cur_func is None:
                continue

            if end_re.match(line):
                cur_func = None
                cur_block = None
                continue

            m = block_re.match(line)
            if m and not line.strip().startswith(';'):
                cur_block = m.group(1)
                funcs[cur_func][cur_block] = []
                continue

            stripped = line.strip()
            if stripped and not stripped.startswith(';') and cur_block is not None:
                funcs[cur_func][cur_block].append(stripped)

    for fn, blocks in funcs.items():
        if "entry_implicit" in blocks and not blocks["entry_implicit"]:
            del blocks["entry_implicit"]

    return funcs


def normalize_rhs(instr):
    """Extract opcode + operand signature from an instruction, ignoring the
    destination register name, so syntactically-identical recomputations
    (under different %names) are caught."""
    m = re.match(r'^(%[\w.$-]+)\s*=\s*(.+)$', instr)
    if m:
        return m.group(2).strip()
    return instr.strip()  # no destination (br, ret, store, etc.)


def main():
    if len(sys.argv) < 4:
        print("Usage: python3 block_dump.py file.ll func_name block1 [block2 ...]")
        sys.exit(1)

    path = sys.argv[1]
    func_name = sys.argv[2]
    block_names = sys.argv[3:]

    funcs = parse_functions(path)

    matches = [f for f in funcs if func_name in f]
    if not matches:
        print(f"No function matching '{func_name}' found in {path}")
        print("Available functions:")
        for f in funcs:
            print(f"  {f}")
        sys.exit(1)

    fn = matches[0]
    blocks = funcs[fn]

    print(f"=== Function: {fn} ===\n")

    for bname in block_names:
        bmatches = [b for b in blocks if b == bname or bname in b]
        if not bmatches:
            print(f"--- Block '{bname}' not found. Available blocks: ---")
            for b in blocks:
                print(f"    {b}")
            print()
            continue

        for b in bmatches:
            instrs = blocks[b]
            print(f"--- Block: {b}  ({len(instrs)} instructions) ---")

            seen = defaultdict(list)
            for i, instr in enumerate(instrs):
                sig = normalize_rhs(instr)
                seen[sig].append((i, instr))

            for i, instr in enumerate(instrs):
                sig = normalize_rhs(instr)
                dup_marker = ""
                if len(seen[sig]) > 1:
                    dup_marker = f"   <-- DUPLICATE COMPUTATION (same RHS appears {len(seen[sig])}x in this block)"
                print(f"    [{i:3d}] {instr}{dup_marker}")

            print()

            # Summary of duplicates found in this block
            dups = {sig: occ for sig, occ in seen.items() if len(occ) > 1}
            if dups:
                print(f"    >>> {len(dups)} distinct RHS signature(s) computed more than once in '{b}':")
                for sig, occ in dups.items():
                    names = [instr.split('=')[0].strip() for _, instr in occ]
                    print(f"        RHS: {sig}")
                    print(f"        Computed as: {', '.join(names)}")
                print()
            else:
                print(f"    >>> No same-block duplicate RHS computations found in '{b}'.\n")


if __name__ == "__main__":
    main()
