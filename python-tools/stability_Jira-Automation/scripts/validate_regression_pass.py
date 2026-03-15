#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
回归 PASS 场景验证脚本
---------------------

验证已解决问题未匹配时的回归 PASS 逻辑：
- VCAME-285: regression_pass_count=0 -> 记录第1次PASS
- VCAME-286: regression_pass_count=1 -> 记录第2次PASS并关单
"""

import os
import sys
from pathlib import Path

PROJECT_ROOT = Path(__file__).parent.parent
sys.path.insert(0, str(PROJECT_ROOT))
sys.path.insert(0, str(PROJECT_ROOT / "src"))

from dotenv import load_dotenv
load_dotenv(PROJECT_ROOT / ".env")

from src.modules.database_manager import DatabaseManager
from src.modules.decision_engine import DecisionEngine
from src.modules.jira_synchronizer import JIRASynchronizer
from src.modules.jira_executor import JIRAExecutor
from src.modules.jira_p12_client import JiraP12Client


def check_issue_status(key):
    """检查问题状态"""
    client = JiraP12Client(
        jira_url=os.getenv("JIRA_URL"),
        p12_file_path=os.getenv("JIRA_P12_PATH"),
        p12_password=os.getenv("JIRA_P12_PASSWORD"),
        jira_username=os.getenv("JIRA_USERNAME"),
        jira_password=os.getenv("JIRA_PASSWORD")
    )
    
    issue = client.get_issue(key)
    status = issue.get("fields", {}).get("status", {}).get("name")
    resolution = issue.get("fields", {}).get("resolution", {}).get("name")
    
    # 获取评论
    comments = client._make_request("GET", f"/rest/api/2/issue/{key}/comment")
    comment_bodies = [c.get("body", "") for c in comments.get("comments", [])]
    
    client.close()
    return status, resolution, comment_bodies


def check_db_status(key):
    """检查数据库状态"""
    db_config = {"type": "sqlite", "path": str(PROJECT_ROOT / "jira_automation.db")}
    db = DatabaseManager(db_config)
    
    rows = db.execute(
        "SELECT status, regression_pass_count FROM jira_issues_main WHERE jira_key = ?",
        (key,)
    )
    db.close()
    
    if rows:
        return dict(rows[0])
    return None


def run_executor_without_matching():
    """运行执行器，不插入任何待处理问题（模拟未匹配场景）"""
    print("\n运行执行器（无待处理问题，触发回归PASS逻辑）...")
    
    db_config = {"type": "sqlite", "path": str(PROJECT_ROOT / "jira_automation.db")}
    db = DatabaseManager(db_config)
    
    # 清空待处理表
    db.execute("DELETE FROM pending_issues")
    
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
    
    decision_config = {
        "thresholds": {
            "env_threshold": 0.5,
            "cause_threshold": 0.3,
            "summary_threshold": 0.3,
        },
        "cache_enabled": False,
    }
    engine = DecisionEngine(db, decision_config)
    
    executor_config = {
        "dry_run": False,
        "max_workers": 1,
        "batch_size": 10,
    }
    executor = JIRAExecutor(jira_sync, engine, db, executor_config)
    
    # 执行处理（无待处理问题，会触发 _handle_resolved_without_matches）
    result = executor.process_pending_issues()
    
    jira_sync.close()
    db.close()
    
    return result


def main():
    print("=" * 70)
    print("回归 PASS 场景验证")
    print("=" * 70)
    
    # 检查初始状态
    print("\n[初始状态]")
    for key in ["VCAME-285", "VCAME-286"]:
        status, resolution, comments = check_issue_status(key)
        db_info = check_db_status(key)
        pass_count = db_info.get("regression_pass_count", 0) if db_info else 0
        print(f"  {key}: JIRA={status}/{resolution}, DB.pass_count={pass_count}")
        if comments:
            print(f"    评论: {comments[-1][:50]}..." if len(comments[-1]) > 50 else f"    评论: {comments[-1]}")
    
    # 运行执行器
    result = run_executor_without_matching()
    print(f"\n执行结果: processed={result['processed_count']}, success={result['success']}")
    
    # 检查最终状态
    print("\n[最终状态]")
    all_passed = True
    
    # VCAME-285: 应该记录第1次PASS，状态保持已解决
    status, resolution, comments = check_issue_status("VCAME-285")
    db_info = check_db_status("VCAME-285")
    pass_count = db_info.get("regression_pass_count", 0) if db_info else 0
    has_pass1_comment = any("已回归验证1个版本PASS" in c for c in comments)
    
    pass1_ok = (status == "已解决" and pass_count == 1 and has_pass1_comment)
    print(f"  VCAME-285 (PASS_1):")
    print(f"    状态: {status}/{resolution}")
    print(f"    DB.pass_count: {pass_count}")
    print(f"    有PASS1评论: {has_pass1_comment}")
    print(f"    验证结果: {'✓ PASS' if pass1_ok else '✗ FAIL'}")
    if not pass1_ok:
        all_passed = False
    
    # VCAME-286: 应该记录第2次PASS并关单
    status, resolution, comments = check_issue_status("VCAME-286")
    db_info = check_db_status("VCAME-286")
    pass_count = db_info.get("regression_pass_count", 0) if db_info else 0
    has_pass2_comment = any("已回归验证2个版本PASS" in c for c in comments)
    
    pass2_ok = (status == "已关闭" and pass_count == 2 and has_pass2_comment)
    print(f"\n  VCAME-286 (PASS_2):")
    print(f"    状态: {status}/{resolution}")
    print(f"    DB.pass_count: {pass_count}")
    print(f"    有PASS2评论: {has_pass2_comment}")
    print(f"    验证结果: {'✓ PASS' if pass2_ok else '✗ FAIL'}")
    if not pass2_ok:
        all_passed = False
    
    print()
    print("=" * 70)
    print(f"回归 PASS 场景验证: {'全部通过 ✓' if all_passed else '存在失败 ✗'}")
    print("=" * 70)
    
    return 0 if all_passed else 1


if __name__ == "__main__":
    sys.exit(main())
