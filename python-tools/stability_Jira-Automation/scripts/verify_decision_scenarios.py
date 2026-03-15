#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
决策场景验证脚本
---------------

使用真实 JIRA 问题验证各决策场景：
1. CREATE - 新建问题
2. UPDATE - 更新 Open/Reopened 状态问题
3. COMMENT - Won't Fix 状态添加备注
4. REOPEN - 已解决/已关闭问题重新打开
5. IGNORE - 已关闭问题忽略

测试问题清单 (2024-12-24 创建)：
- VCAME-278: 开放状态 (UPDATE 场景) - com.android.settings
- VCAME-279: 已解决/完成 (REOPEN 场景) - com.android.systemui
- VCAME-280: 已关闭/问题不修改 (COMMENT 场景) - com.android.phone
- VCAME-281: 已关闭/完成 (IGNORE 场景) - com.android.camera
- VCAME-282: 重新打开 (UPDATE 场景) - com.android.launcher3
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
from src.modules.jira_synchronizer import JIRASynchronizer
from src.modules.jira_p12_client import JiraP12Client

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

# 测试问题映射 (2024-12-24 新创建)
TEST_ISSUES = {
    "VCAME-278": {"status": "开放", "resolution": None, "scenario": "UPDATE", "package": "com.android.settings"},
    "VCAME-279": {"status": "已解决", "resolution": "完成", "scenario": "REOPEN", "package": "com.android.systemui"},
    "VCAME-280": {"status": "已关闭", "resolution": "问题不修改", "scenario": "COMMENT", "package": "com.android.phone"},
    "VCAME-281": {"status": "已关闭", "resolution": "完成", "scenario": "IGNORE", "package": "com.android.camera"},
    "VCAME-282": {"status": "重新打开", "resolution": None, "scenario": "UPDATE", "package": "com.android.launcher3"},
}


def sync_test_issues_to_db():
    """将测试问题同步到本地数据库"""
    print("=" * 60)
    print("同步测试问题到本地数据库")
    print("=" * 60)
    
    # 初始化 JIRA 客户端
    client = JiraP12Client(
        jira_url=os.getenv('JIRA_URL'),
        p12_file_path=os.getenv('JIRA_P12_PATH'),
        p12_password=os.getenv('JIRA_P12_PASSWORD'),
        jira_username=os.getenv('JIRA_USERNAME'),
        jira_password=os.getenv('JIRA_PASSWORD')
    )
    
    # 初始化数据库
    db_config = {"type": "sqlite", "path": str(PROJECT_ROOT / "jira_automation.db")}
    db = DatabaseManager(db_config)
    
    synced = []
    for issue_key, expected in TEST_ISSUES.items():
        try:
            # 获取问题详情
            issue = client.get_issue(issue_key)
            fields = issue.get('fields', {})
            
            status = fields.get('status', {}).get('name')
            resolution = fields.get('resolution', {}).get('name') if fields.get('resolution') else None
            summary = fields.get('summary', '')
            fix_versions = [v.get('name') for v in fields.get('fixVersions', [])]
            
            # 从摘要中提取包名
            package_name = "com.test.workflow"
            if "com.android.settings" in summary:
                package_name = "com.android.settings"
            elif "com.android.systemui" in summary:
                package_name = "com.android.systemui"
            elif "com.android.phone" in summary:
                package_name = "com.android.phone"
            elif "com.android.camera" in summary:
                package_name = "com.android.camera"
            elif "com.android.launcher3" in summary:
                package_name = "com.android.launcher3"
            
            # 插入或更新数据库
            # 生成 normalized_summary
            normalized_summary = f"{package_name}|{status}|java.lang.Exception"
            
            issue_data = {
                "jira_key": issue_key,
                "summary": summary,
                "normalized_summary": normalized_summary,
                "status": status,
                "package_name": package_name,
                "exp_class": "java.lang.Exception",
                "raw_caused_by": f"测试用途 - resolution={resolution}",
                "fix_version": fix_versions[0] if fix_versions else None,
                "test_environment": "WorkflowTest",
            }
            
            # 检查是否已存在
            existing = db.execute(
                "SELECT id FROM jira_issues_main WHERE jira_key = ?",
                (issue_key,)
            )
            
            if existing:
                # 更新
                db.execute(
                    """UPDATE jira_issues_main 
                       SET status = ?, fix_version = ?, raw_caused_by = ?
                       WHERE jira_key = ?""",
                    (status, issue_data["fix_version"], issue_data["raw_caused_by"], issue_key)
                )
            else:
                # 插入
                db.execute(
                    """INSERT INTO jira_issues_main 
                       (jira_key, summary, normalized_summary, status, package_name, 
                        exp_class, raw_caused_by, fix_version, test_environment)
                       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)""",
                    (issue_key, summary, normalized_summary, status, package_name,
                     issue_data["exp_class"], issue_data["raw_caused_by"],
                     issue_data["fix_version"], issue_data["test_environment"])
                )
            
            synced.append({
                "key": issue_key,
                "status": status,
                "resolution": resolution,
                "scenario": expected["scenario"],
            })
            print(f"  ✓ {issue_key}: {status} / {resolution} -> {expected['scenario']}")
            
        except Exception as e:
            print(f"  ✗ {issue_key}: {e}")
    
    db.close()
    client.close()
    
    print(f"\n同步完成: {len(synced)} 个问题")
    return synced


def show_scenario_summary():
    """显示决策场景汇总"""
    print()
    print("=" * 60)
    print("决策场景测试问题汇总")
    print("=" * 60)
    print()
    print("场景说明:")
    print("  CREATE  - 数据库中无匹配问题，创建新问题")
    print("  UPDATE  - 匹配到 Open/Reopened 状态问题，更新计数")
    print("  COMMENT - 匹配到 Won't Fix 状态问题，添加备注")
    print("  REOPEN  - 匹配到已解决问题，版本晚于修复版本，重新打开")
    print("  IGNORE  - 匹配到已关闭问题，版本早于修复版本，忽略")
    print()
    print("测试问题:")
    print("-" * 60)
    print(f"{'Key':<12} {'状态':<10} {'解决方案':<12} {'预期决策':<10}")
    print("-" * 60)
    for key, info in TEST_ISSUES.items():
        res = info['resolution'] or '-'
        print(f"{key:<12} {info['status']:<10} {res:<12} {info['scenario']:<10}")
    print("-" * 60)
    print()
    print("验证方法:")
    print("  1. 使用 config/Result_None_None_MonkeyAEE_SH_20251118_org.xls 数据")
    print("  2. 调整阈值使测试数据能匹配到对应问题")
    print("  3. 运行 src/main.py 观察决策结果")
    print()
    print("URL:")
    for key in TEST_ISSUES:
        print(f"  https://jira.tinno.com/browse/{key}")


def main():
    sync_test_issues_to_db()
    show_scenario_summary()


if __name__ == "__main__":
    main()
