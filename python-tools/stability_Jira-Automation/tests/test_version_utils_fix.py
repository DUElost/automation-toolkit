#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
验证 version_utils.py 修复后的版本比较逻辑。

测试场景：
- V551A-15-250730V29 vs V551A-15-250811V35 → 250730 < 250811 → 返回 -1
- V551A-15-250812V36 vs V551A-15-250811V35 → 250812 > 250811 → 返回 1
"""

import sys
from pathlib import Path

# 添加项目路径
sys.path.insert(0, str(Path(__file__).parent.parent / "src"))

from modules.version_utils import (
    compare_versions,
    _extract_version_timestamp,
    VersionComparator,
    VersionOutcome,
)


def test_extract_timestamp():
    """测试时间戳提取"""
    test_cases = [
        ("V551A-15-250730V29", 250730),
        ("V551A-15-250811V35", 250811),
        ("V551A-15-250812V36", 250812),
        ("V551A-15-250809V33", 250809),
        ("V551A-15-250810V34", 250810),
        (None, None),
        ("", None),
    ]
    
    print("=== 测试时间戳提取 ===")
    all_passed = True
    for version, expected in test_cases:
        result = _extract_version_timestamp(version)
        status = "✓" if result == expected else "✗"
        if result != expected:
            all_passed = False
        print(f"  {status} _extract_version_timestamp('{version}') = {result}, 期望 {expected}")
    
    return all_passed


def test_compare_versions():
    """测试版本比较"""
    test_cases = [
        # (版本A, 版本B, 期望结果, 说明)
        ("V551A-15-250812V36", "V551A-15-250811V35", 1, "问题出现版本 > 修复版本 → 复现"),
        ("V551A-15-250811V35", "V551A-15-250811V35", 0, "版本相同"),
        ("V551A-15-250810V34", "V551A-15-250811V35", -1, "问题出现版本 < 修复版本 → 历史版本"),
        ("V551A-15-250809V33", "V551A-15-250811V35", -1, "问题出现版本 < 修复版本 → 历史版本"),
        ("V551A-15-250730V29", "V551A-15-250811V35", -1, "问题出现版本 < 修复版本 → 历史版本"),
    ]
    
    print("\n=== 测试版本比较 ===")
    all_passed = True
    for version_a, version_b, expected, desc in test_cases:
        result = compare_versions(version_a, version_b)
        status = "✓" if result == expected else "✗"
        if result != expected:
            all_passed = False
        print(f"  {status} compare_versions('{version_a}', '{version_b}') = {result}, 期望 {expected} ({desc})")
    
    return all_passed


def test_version_comparator():
    """测试 VersionComparator 类"""
    comparator = VersionComparator()
    
    test_cases = [
        # (当前版本, 修复版本, 期望结果, 说明)
        ("V551A-15-250812V36", "V551A-15-250811V35", VersionOutcome.IS_NEWER_OR_EQUAL, "复现"),
        ("V551A-15-250811V35", "V551A-15-250811V35", VersionOutcome.IS_NEWER_OR_EQUAL, "相同版本视为复现"),
        ("V551A-15-250810V34", "V551A-15-250811V35", VersionOutcome.IS_OLDER, "历史版本"),
    ]
    
    print("\n=== 测试 VersionComparator ===")
    all_passed = True
    for current, fix, expected, desc in test_cases:
        result = comparator.compare(current, fix)
        status = "✓" if result.outcome == expected else "✗"
        if result.outcome != expected:
            all_passed = False
        print(f"  {status} compare('{current}', '{fix}').outcome = {result.outcome}, 期望 {expected} ({desc})")
        print(f"      current_ts={result.current_timestamp}, fix_ts={result.fix_timestamp}, reason={result.reason}")
    
    return all_passed


def main():
    print("版本比较逻辑修复验证\n")
    
    results = [
        test_extract_timestamp(),
        test_compare_versions(),
        test_version_comparator(),
    ]
    
    print("\n" + "=" * 50)
    if all(results):
        print("✓ 所有测试通过！")
        return 0
    else:
        print("✗ 部分测试失败")
        return 1


if __name__ == "__main__":
    sys.exit(main())
