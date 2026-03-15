#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
决策场景实际验证脚本
-------------------

使用已创建的测试问题验证各决策场景：
- VCAME-278: 开放状态 -> UPDATE
- VCAME-279: 已解决/完成 -> REOPEN
- VCAME-280: 已关闭/问题不修改 -> COMMENT (Won't Fix)
- VCAME-281: 已关闭/完成 -> IGNORE
- VCAME-282: 重新打开 -> UPDATE
"""

from __future__ import annotations

import logging
import os
import sys
from pathlib import Path
from typing import Any, Dict, List

PROJECT_ROOT = Path(__file__).parent.parent
sys.path.insert(0, str(PROJECT_ROOT))
sys.path.insert(0, str(PROJECT_ROOT / "src"))

from dotenv import load_dotenv
load_dotenv(PROJECT_ROOT / ".env")

from src.modules.database_manager import DatabaseManager
from src.modules.decision_engine import DecisionEngine
from src.modules.jira_synchronizer import JIRASynchronizer
from src.modules.jira_executor import JIRAExecutor

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

# 测试场景数据 - 使用与数据库一致的格式
TEST_SCENARIOS = [
    {
        "name": "UPDATE (Open)",
        "expected_action": "UPDATE",
        "expected_key": "VCAME-278",
        "pending_issue": {
            "id": 1001,
            "action": "CREATE",
            "package_name": "com.android.settings",
            "normalized_summary": "com.android.settings|开放|java.lang.NullPointerException",
            "caused_by": "resolution=None",
            "test_environment": "ScenarioTest",
            "version": "P2",
            "jira_summary": "[ScenarioTest] com.android.settings NullPointerException",
            "jira_description": "测试 UPDATE 场景",
            "exp_class": "java.lang.NullPointerException",
            "exp_type": "CRASH",
            "cur_process": "com.android.settings.SettingsActivity",
            "detail": "测试详情",
            "count": 5,
            "device_count": 2,
            "bug_severity": "B",
        }
    },
    {
        "name": "REOPEN (Resolved)",
        "expected_action": "UPDATE",
        "expected_key": "VCAME-279",
        "pending_issue": {
            "id": 1002,
            "action": "CREATE",
            "package_name": "com.android.systemui",
            "normalized_summary": "com.android.systemui|已解决|java.lang.RuntimeException",
            "caused_by": "resolution=完成",
            "test_environment": "ScenarioTest",
            "version": "P2",
            "jira_summary": "[ScenarioTest] com.android.systemui RuntimeException",
            "jira_description": "测试 REOPEN 场景",
            "exp_class": "java.lang.RuntimeException",
            "exp_type": "CRASH",
            "cur_process": "com.android.systemui.SystemUIService",
            "detail": "测试详情",
            "count": 3,
            "device_count": 1,
            "bug_severity": "B",
        }
    },
    {
        "name": "COMMENT (Won't Fix)",
        "expected_action": "UPDATE",
        "expected_key": "VCAME-284",
        "pending_issue": {
            "id": 1003,
            "action": "CREATE",
            "package_name": "com.android.dialer",
            "normalized_summary": "com.android.dialer|已解决|java.lang.IllegalArgumentException",
            "caused_by": "resolution=问题不修改",
            "test_environment": "ScenarioTest",
            "version": "P2",
            "jira_summary": "[ScenarioTest] com.android.dialer IllegalArgumentException",
            "jira_description": "测试 COMMENT 场景",
            "exp_class": "java.lang.IllegalArgumentException",
            "exp_type": "CRASH",
            "cur_process": "com.android.dialer.DialerActivity",
            "detail": "测试详情",
            "count": 2,
            "device_count": 1,
            "bug_severity": "C",
        }
    },
    {
        "name": "IGNORE (Closed)",
        "expected_action": "UPDATE",
        "expected_key": "VCAME-281",
        "pending_issue": {
            "id": 1004,
            "action": "CREATE",
            "package_name": "com.android.camera",
            "normalized_summary": "com.android.camera|已关闭|java.lang.OutOfMemoryError",
            "caused_by": "resolution=完成",
            "test_environment": "ScenarioTest",
            "version": "P0",
            "jira_summary": "[ScenarioTest] com.android.camera OutOfMemoryError",
            "jira_description": "测试 IGNORE 场景",
            "exp_class": "java.lang.OutOfMemoryError",
            "exp_type": "CRASH",
            "cur_process": "com.android.camera.CameraActivity",
            "detail": "测试详情",
            "count": 1,
            "device_count": 1,
            "bug_severity": "B",
        }
    },
    {
        "name": "UPDATE (Reopened)",
        "expected_action": "UPDATE",
        "expected_key": "VCAME-282",
        "pending_issue": {
            "id": 1005,
            "action": "CREATE",
            "package_name": "com.android.launcher3",
            "normalized_summary": "com.android.launcher3|重新打开|java.lang.IndexOutOfBoundsException",
            "caused_by": "resolution=None",
            "test_environment": "ScenarioTest",
            "version": "P2",
            "jira_summary": "[ScenarioTest] com.android.launcher3 IndexOutOfBoundsException",
            "jira_description": "测试 UPDATE (Reopened) 场景",
            "exp_class": "java.lang.IndexOutOfBoundsException",
            "exp_type": "CRASH",
            "cur_process": "com.android.launcher3.Launcher",
            "detail": "测试详情",
            "count": 4,
            "device_count": 2,
            "bug_severity": "B",
        }
    },
    {
        "name": "CREATE (No Match)",
        "expected_action": "CREATE",
        "expected_key": None,
        "pending_issue": {
            "id": 1006,
            "action": "CREATE",
            "package_name": "com.android.newapp",
            "normalized_summary": "com.android.newapp|新建|java.lang.SecurityException",
            "caused_by": "新问题",
            "test_environment": "ScenarioTest",
            "version": "P2",
            "jira_summary": "[ScenarioTest] com.android.newapp SecurityException",
            "jira_description": "测试 CREATE 场景 - 无匹配问题",
            "exp_class": "java.lang.SecurityException",
            "exp_type": "CRASH",
            "cur_process": "com.android.newapp.MainActivity",
            "detail": "测试详情",
            "count": 1,
            "device_count": 1,
            "bug_severity": "C",
        }
    },
]


def validate_decision_engine():
    """验证决策引擎"""
    print("=" * 70)
    print("决策引擎验证")
    print("=" * 70)
    
    # 初始化数据库
    db_config = {"type": "sqlite", "path": str(PROJECT_ROOT / "jira_automation.db")}
    db = DatabaseManager(db_config)
    
    # 初始化决策引擎（使用较低阈值以便测试匹配）
    decision_config = {
        "thresholds": {
            "env_threshold": 0.5,    # 降低阈值以便测试
            "cause_threshold": 0.3,
            "summary_threshold": 0.3,
        },
        "cache_enabled": False,
    }
    engine = DecisionEngine(db, decision_config)
    
    results = []
    print()
    print(f"{'场景':<25} {'预期动作':<10} {'实际动作':<10} {'匹配Key':<15} {'结果':<8}")
    print("-" * 70)
    
    for scenario in TEST_SCENARIOS:
        decision = engine.decide(scenario["pending_issue"])
        
        # 验证结果
        action_match = decision.action == scenario["expected_action"]
        key_match = (
            (decision.matched_key == scenario["expected_key"]) or
            (scenario["expected_key"] is None and decision.matched_key is None)
        )
        
        passed = action_match and key_match
        status = "✓ PASS" if passed else "✗ FAIL"
        
        results.append({
            "name": scenario["name"],
            "expected_action": scenario["expected_action"],
            "actual_action": decision.action,
            "expected_key": scenario["expected_key"],
            "actual_key": decision.matched_key,
            "passed": passed,
            "similarity": decision.similarity_score,
            "env_sim": decision.environment_similarity,
            "cause_sim": decision.cause_similarity,
        })
        
        matched_key = decision.matched_key or "-"
        print(f"{scenario['name']:<25} {scenario['expected_action']:<10} {decision.action:<10} {matched_key:<15} {status:<8}")
    
    print("-" * 70)
    
    # 统计
    passed_count = sum(1 for r in results if r["passed"])
    total_count = len(results)
    print(f"\n总计: {passed_count}/{total_count} 通过")
    
    # 详细信息
    print("\n详细相似度信息:")
    for r in results:
        print(f"  {r['name']}: env={r['env_sim']:.3f}, cause={r['cause_sim']:.3f}, total={r['similarity']:.3f}")
    
    db.close()
    return results


def validate_full_execution(dry_run: bool = True):
    """验证完整执行流程"""
    print()
    print("=" * 70)
    print(f"完整执行流程验证 {'(DRY-RUN)' if dry_run else '(REAL)'}")
    print("=" * 70)
    
    # 初始化数据库
    db_config = {"type": "sqlite", "path": str(PROJECT_ROOT / "jira_automation.db")}
    db = DatabaseManager(db_config)
    
    # 初始化 JIRA 同步器
    jira_config = {
        "url": os.getenv("JIRA_URL"),
        "username": os.getenv("JIRA_USERNAME"),
        "password": os.getenv("JIRA_PASSWORD"),
        "p12_path": os.getenv("JIRA_P12_PATH"),
        "p12_password": os.getenv("JIRA_P12_PASSWORD"),
        "project_key": os.getenv("JIRA_PROJECT_KEY", "VCAME"),
        "mode": "rest",
    }
    
    jira_sync = JIRASynchronizer(jira_config)
    if not jira_sync.is_authenticated():
        print("JIRA 认证失败")
        return
    
    # 初始化决策引擎
    decision_config = {
        "thresholds": {
            "env_threshold": 0.5,
            "cause_threshold": 0.3,
            "summary_threshold": 0.3,
        },
        "cache_enabled": False,
    }
    engine = DecisionEngine(db, decision_config)
    
    # 初始化执行器
    executor_config = {
        "dry_run": dry_run,
        "max_workers": 1,
        "batch_size": 10,
    }
    executor = JIRAExecutor(jira_sync, engine, db, executor_config)
    
    # 清空待处理表
    db.execute("DELETE FROM pending_issues")
    
    # 插入测试数据
    print("\n插入测试数据...")
    for scenario in TEST_SCENARIOS[:3]:  # 只测试前3个场景
        issue = scenario["pending_issue"]
        db.insert_pending_issue(issue)
        print(f"  + {scenario['name']}: {issue['package_name']}")
    
    # 执行处理
    print("\n执行处理...")
    result = executor.process_pending_issues()
    
    print(f"\n处理结果:")
    print(f"  成功: {result['success']}")
    print(f"  处理数: {result['processed_count']}")
    print(f"  成功数: {result['success_count']}")
    print(f"  失败数: {result['error_count']}")
    
    if result.get("errors"):
        print(f"  错误: {result['errors']}")
    
    # 显示统计
    stats = executor.get_execution_stats()
    print(f"\n执行统计:")
    print(f"  创建: {stats['created']}")
    print(f"  更新: {stats['updated']}")
    print(f"  失败: {stats['failed']}")
    
    jira_sync.close()
    db.close()


def show_database_status():
    """显示数据库状态"""
    print()
    print("=" * 70)
    print("数据库状态")
    print("=" * 70)
    
    db_config = {"type": "sqlite", "path": str(PROJECT_ROOT / "jira_automation.db")}
    db = DatabaseManager(db_config)
    
    # 查询测试问题
    rows = db.execute(
        "SELECT jira_key, status, fix_version, package_name, normalized_summary "
        "FROM jira_issues_main WHERE jira_key LIKE 'VCAME-27%' OR jira_key LIKE 'VCAME-28%' "
        "ORDER BY jira_key"
    ) or []
    
    print(f"\n测试问题 ({len(rows)} 条):")
    print(f"{'Key':<12} {'状态':<10} {'修复版本':<8} {'包名':<30}")
    print("-" * 70)
    for row in rows:
        r = dict(row)
        print(f"{r['jira_key']:<12} {r['status'] or '-':<10} {r['fix_version'] or '-':<8} {r['package_name'] or '-':<30}")
    
    # 查询待处理问题
    pending = db.execute("SELECT COUNT(*) as cnt FROM pending_issues") or []
    pending_count = pending[0]['cnt'] if pending else 0
    print(f"\n待处理问题: {pending_count} 条")
    
    db.close()


def main():
    import argparse
    parser = argparse.ArgumentParser(description="决策场景验证")
    parser.add_argument("--mode", choices=["decision", "execute", "status", "all"], 
                       default="decision", help="验证模式")
    parser.add_argument("--real", action="store_true", help="真实执行（非 dry-run）")
    args = parser.parse_args()
    
    if args.mode in ["decision", "all"]:
        validate_decision_engine()
    
    if args.mode in ["execute", "all"]:
        validate_full_execution(dry_run=not args.real)
    
    if args.mode in ["status", "all"]:
        show_database_status()


if __name__ == "__main__":
    main()
