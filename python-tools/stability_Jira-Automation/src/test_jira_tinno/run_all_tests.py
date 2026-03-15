#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
运行所有测试
------------

统一入口，运行本地数据库测试和集成测试。
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path

# 添加项目路径
sys.path.insert(0, str(Path(__file__).parent.parent))


def run_local_db_tests() -> bool:
    """运行本地数据库测试"""
    print("\n" + "=" * 70)
    print("【第一部分】本地数据库测试")
    print("=" * 70)
    
    from test_jira_tinno.local_db_test import LocalDBTester, test_version_comparison
    
    # 版本比较测试
    version_ok = test_version_comparison()
    
    # 场景测试
    tester = LocalDBTester()
    tester.run_all_scenarios()
    scenarios_ok = tester.print_summary()
    
    return version_ok and scenarios_ok


def run_integration_tests(use_mock: bool = True) -> bool:
    """运行集成测试"""
    print("\n" + "=" * 70)
    print("【第二部分】集成测试")
    print("=" * 70)
    
    from test_jira_tinno.integration_test import IntegrationTester
    
    tester = IntegrationTester(use_mock=use_mock)
    return tester.run_all_tests()


def run_main_pipeline_test(dry_run: bool = True) -> bool:
    """
    使用 src/main.py 运行完整流程测试
    
    Args:
        dry_run: 是否使用 dry-run 模式
    """
    print("\n" + "=" * 70)
    print("【第三部分】主流程测试 (src/main.py)")
    print("=" * 70)
    
    import subprocess
    from test_jira_tinno.test_data_generator import TestDataGenerator
    import pandas as pd
    
    # 生成测试数据
    generator = TestDataGenerator()
    test_data = generator.generate_batch(5)
    
    # 保存为 Excel
    test_dir = Path(__file__).parent
    excel_path = test_dir / "main_pipeline_test.xlsx"
    
    rows = []
    for item in test_data:
        rows.append({
            "Id": len(rows) + 1,
            "Path": item.get("path", ""),
            "Version": item.get("version", ""),
            "AffectProject": "VCAME",
            "ExpTime": "",
            "ExpClass": item.get("exp_class", ""),
            "ExpType": item.get("exp_type", ""),
            "CurProcess": item.get("cur_process", ""),
            "Package": item.get("package", ""),
            "Detail": item.get("detail", ""),
            "CausedBy": item.get("caused_by", ""),
            "extraTag": "",
            "Count": item.get("count", 1),
            "DeviceCount": item.get("device_count", 1),
        })
    
    df = pd.DataFrame(rows)
    df.to_excel(str(excel_path), index=False)
    print(f"生成测试 Excel: {excel_path}")
    
    # 构建命令
    main_py = Path(__file__).parent.parent / "main.py"
    cmd = [
        sys.executable,
        str(main_py),
        "--excel", str(excel_path),
        "--action", "process",
        "--log-level", "INFO",
    ]
    
    if dry_run:
        cmd.append("--dry-run")
    
    print(f"执行命令: {' '.join(cmd)}")
    
    try:
        result = subprocess.run(cmd, capture_output=True, text=True, timeout=120)
        
        print("\n--- stdout ---")
        print(result.stdout[-2000:] if len(result.stdout) > 2000 else result.stdout)
        
        if result.stderr:
            print("\n--- stderr ---")
            print(result.stderr[-1000:] if len(result.stderr) > 1000 else result.stderr)
        
        if result.returncode == 0:
            print("\n✓ 主流程测试通过")
            return True
        else:
            print(f"\n✗ 主流程测试失败 (exit code: {result.returncode})")
            return False
            
    except subprocess.TimeoutExpired:
        print("\n✗ 主流程测试超时")
        return False
    except Exception as e:
        print(f"\n✗ 主流程测试异常: {e}")
        return False


def main():
    """主函数"""
    parser = argparse.ArgumentParser(description="JIRA Tinno 测试套件")
    parser.add_argument("--local-only", action="store_true", help="仅运行本地数据库测试")
    parser.add_argument("--integration-only", action="store_true", help="仅运行集成测试")
    parser.add_argument("--main-only", action="store_true", help="仅运行主流程测试")
    parser.add_argument("--no-mock", action="store_true", help="使用真实 JIRA API（谨慎使用）")
    parser.add_argument("--no-dry-run", action="store_true", help="主流程测试不使用 dry-run")
    
    args = parser.parse_args()
    
    print("=" * 70)
    print("JIRA Monkey 测试自动化系统 - 测试套件")
    print("=" * 70)
    print(f"Mock 模式: {not args.no_mock}")
    print(f"Dry-run 模式: {not args.no_dry_run}")
    
    results = []
    
    # 运行测试
    if args.local_only:
        results.append(("本地数据库测试", run_local_db_tests()))
    elif args.integration_only:
        results.append(("集成测试", run_integration_tests(use_mock=not args.no_mock)))
    elif args.main_only:
        results.append(("主流程测试", run_main_pipeline_test(dry_run=not args.no_dry_run)))
    else:
        # 运行所有测试
        results.append(("本地数据库测试", run_local_db_tests()))
        results.append(("集成测试", run_integration_tests(use_mock=not args.no_mock)))
        results.append(("主流程测试", run_main_pipeline_test(dry_run=not args.no_dry_run)))
    
    # 打印总结
    print("\n" + "=" * 70)
    print("测试总结")
    print("=" * 70)
    
    all_passed = True
    for name, passed in results:
        status = "✓ PASS" if passed else "✗ FAIL"
        print(f"  {status} - {name}")
        if not passed:
            all_passed = False
    
    print("-" * 70)
    if all_passed:
        print("✓ 所有测试通过！")
        return 0
    else:
        print("✗ 部分测试失败")
        return 1


if __name__ == "__main__":
    sys.exit(main())
