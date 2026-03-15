#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
验证 DecisionEngine 优化后的功能。

测试场景：
1. 堆栈签名提取
2. 批量预加载
3. 相似度计算
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent.parent / "src"))

from modules.decision_engine import (
    _extract_stack_signature,
    DecisionEngine,
    DecisionResult,
)


def test_stack_signature_extraction():
    """测试堆栈签名提取"""
    print("=== 测试堆栈签名提取 ===")
    
    test_cases = [
        # (原始堆栈, 期望移除行号和内存地址)
        (
            "at com.example.MyClass.method(MyClass.java:123)",
            "at com.example.MyClass.method(MyClass.java)",
        ),
        (
            "java.lang.NullPointerException at 0x7fff5fbff8c0",
            "java.lang.NullPointerException at",
        ),
        (
            "Thread-123: Error in module",
            ": Error in module",
        ),
        (
            "",
            "",
        ),
    ]
    
    all_passed = True
    for original, expected_pattern in test_cases:
        result = _extract_stack_signature(original)
        # 检查是否移除了行号和内存地址
        has_line_number = ":123" in result
        has_memory_addr = "0x7fff" in result
        
        if has_line_number or has_memory_addr:
            print(f"  ✗ 签名提取失败: '{original[:50]}...' -> '{result[:50]}...'")
            all_passed = False
        else:
            print(f"  ✓ 签名提取成功: '{original[:30]}...' -> 已移除噪声")
    
    return all_passed


def test_similarity_calculation():
    """测试相似度计算"""
    print("\n=== 测试相似度计算 ===")
    
    test_cases = [
        # (字符串A, 字符串B, 期望结果描述)
        ("hello world", "hello world", "完全相同应为 1.0"),
        ("hello", "world", "完全不同应较低"),
        ("", "", "空字符串应为 0.0"),
        ("abc", "", "一个为空应为 0.0"),
    ]
    
    all_passed = True
    for str_a, str_b, desc in test_cases:
        result = DecisionEngine._similarity(str_a, str_b)
        
        if str_a == str_b and str_a:
            expected = 1.0
            passed = result == expected
        elif not str_a or not str_b:
            expected = 0.0
            passed = result == expected
        else:
            expected = "< 1.0"
            passed = result < 1.0
        
        status = "✓" if passed else "✗"
        if not passed:
            all_passed = False
        print(f"  {status} similarity('{str_a}', '{str_b}') = {result:.2f} ({desc})")
    
    return all_passed


def test_decision_result_dataclass():
    """测试 DecisionResult 数据类"""
    print("\n=== 测试 DecisionResult 数据类 ===")
    
    result = DecisionResult(
        action="CREATE",
        matched_key=None,
        similarity_score=0.5,
        environment_similarity=0.8,
        cause_similarity=0.6,
        reason="test",
    )
    
    all_passed = True
    
    # 测试字段访问
    if result.action != "CREATE":
        print("  ✗ action 字段错误")
        all_passed = False
    else:
        print("  ✓ action 字段正确")
    
    if result.matched_key is not None:
        print("  ✗ matched_key 字段错误")
        all_passed = False
    else:
        print("  ✓ matched_key 字段正确")
    
    if result.similarity_score != 0.5:
        print("  ✗ similarity_score 字段错误")
        all_passed = False
    else:
        print("  ✓ similarity_score 字段正确")
    
    return all_passed


def main():
    print("DecisionEngine 优化验证\n")
    
    results = [
        test_stack_signature_extraction(),
        test_similarity_calculation(),
        test_decision_result_dataclass(),
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
