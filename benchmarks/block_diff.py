#!/usr/bin/env python3
"""
block_diff.py — Compare per-block instruction counts between two .ll files
for the same function, to find exactly where instruction count differs.

Usage:
    python3 block_diff.py gvn.ll lcm.ll [function_name]

If function_name is omitted, compares all functions found in both files.

This does NOT rely on block names matching (LCM and GVN create different
synthetic block names for critical edges), so blocks are matched by
position within each function's RPO-ish textual order, with a fallback
note when block counts differ between the two versions.
"""

import re
import sys
from collections import OrderedDict


def parse_functions(path):
    """Returns OrderedDict[func_name] -> OrderedDict[block_name] -> list[instr_text]"""
    funcs = OrderedDict()
    cur_func = None
    cur_block = None

    func_re = re.compile(r'^define .*@([\w.]+)\s*\(')
    block_re = re.compile(r'^([\w.$-]+):')
    end_re = re.compile(r'^}')

    with open(path) as f:
        for line in f:
            line = line.rstrip('\n')

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
            if stripped.startswith('%') or stripped.startswith('br ') \
               or stripped.startswith('ret ') or stripped.startswith('switch ') \
               or stripped.startswith('call ') or stripped.startswith('store '):
                if cur_block is not None:
                    funcs[cur_func][cur_block].append(stripped)

    # drop the synthetic placeholder if it ended up empty and unused
    for fn, blocks in funcs.items():
        if "entry_implicit" in blocks and not blocks["entry_implicit"]:
            del blocks["entry_implicit"]

    return funcs


def demangle_hint(name):
    """Very small best-effort hint for common Itanium-mangled C++ names."""
    m = re.match(r'_Z(\d+)(\w+)', name)
    if m:
        n = int(m.group(1))
        return m.group(2)[:n]
    return name


def main():
    if len(sys.argv) < 3:
        print("Usage: python3 block_diff.py gvn.ll lcm.ll [function_name]")
        sys.exit(1)

    gvn_path, lcm_path = sys.argv[1], sys.argv[2]
    target = sys.argv[3] if len(sys.argv) > 3 else None

    gvn_funcs = parse_functions(gvn_path)
    lcm_funcs = parse_functions(lcm_path)

    all_names = list(gvn_funcs.keys())
    if target:
        all_names = [n for n in all_names if target in n or target in demangle_hint(n)]

    grand_total_gvn = 0
    grand_total_lcm = 0

    for fn in all_names:
        if fn not in lcm_funcs:
            print(f"=== {fn}  (demangled hint: {demangle_hint(fn)}) ===")
            print("  [present in GVN output, missing in LCM output]\n")
            continue

        gvn_blocks = gvn_funcs[fn]
        lcm_blocks = lcm_funcs[fn]

        gvn_total = sum(len(v) for v in gvn_blocks.values())
        lcm_total = sum(len(v) for v in lcm_blocks.values())
        grand_total_gvn += gvn_total
        grand_total_lcm += lcm_total

        if gvn_total == lcm_total:
            continue  # only show functions that actually differ

        print(f"=== {fn}  (demangled hint: {demangle_hint(fn)}) ===")
        print(f"  GVN total instrs: {gvn_total}   LCM total instrs: {lcm_total}   "
              f"delta: {lcm_total - gvn_total:+d}")
        print(f"  GVN block count:  {len(gvn_blocks)}   LCM block count:  {len(lcm_blocks)}")
        print()

        print(f"  {'GVN block':35s} {'#i':>4s}   {'LCM block':35s} {'#i':>4s}   delta")
        print(f"  {'-'*35} {'-'*4}   {'-'*35} {'-'*4}   -----")

        gvn_items = list(gvn_blocks.items())
        lcm_items = list(lcm_blocks.items())
        max_len = max(len(gvn_items), len(lcm_items))

        for i in range(max_len):
            gname, gcount = (gvn_items[i][0], len(gvn_items[i][1])) if i < len(gvn_items) else ("<none>", 0)
            lname, lcount = (lcm_items[i][0], len(lcm_items[i][1])) if i < len(lcm_items) else ("<none>", 0)
            marker = "" if gcount == lcount else "  <-- DIFFERS"
            print(f"  {gname[:35]:35s} {gcount:>4d}   {lname[:35]:35s} {lcount:>4d}   "
                  f"{lcount-gcount:+d}{marker}")

        print()
        print("  Blocks present in LCM but not in GVN (by name, likely new critical-edge blocks):")
        new_blocks = [b for b in lcm_blocks if b not in gvn_blocks]
        for b in new_blocks:
            print(f"    {b}  ({len(lcm_blocks[b])} instrs)")
        if not new_blocks:
            print("    (none)")
        print()

    print(f"\n=== GRAND TOTAL (all matched functions) ===")
    print(f"GVN: {grand_total_gvn}   LCM: {grand_total_lcm}   delta: {grand_total_lcm - grand_total_gvn:+d}")


if __name__ == "__main__":
    main()
