#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
创建回归 PASS 场景测试问题
-------------------------

场景说明：
- PASS_1: 已解决/完成状态，regression_pass_count=0，未匹配时记录第1次PASS
- PASS_2: 已解决/完成状态，regression_pass_count=1，未匹配时记录第2次PASS并关单
"""

import os
import sys
from pathlib import Path
from datetime import datetime, timedelta

PROJECT_ROOT = Path(__file__).parent.parent
sys.path.insert(0, str(PROJECT_ROOT))
sys.path.insert(0, str(PROJECT_ROOT / "src"))

from dotenv import load_dotenv
load_dotenv(PROJECT_ROOT / ".env")

from src.modules.jira_p12_client import JiraP12Client
from src.modules.database_manager import DatabaseManager

RESOLUTION_MAP = {
    "完成": "10000",
    "问题不修改": "10102",
}


def create_resolved_issue(client, summary, description, package_name):
    """创建并转换到已解决状态"""
    # 创建问题
    fields = {
        "project": {"key": "VCAME"},
        "issuetype": {"name": "Bug"},
        "summary": summary,
        "description": description,
        "labels": ["MonkeyAEE", "ScenarioTest", "RegressionPass"],
        "components": [{"name": "AUTOTEST"}],
        "customfield_10120": {"value": "B"},
        "assignee": {"name": "dai.lv"},
    }
    
    result = client.create_issue(fields)
    key = result.get("key")
    print(f"  创建成功: {key}")
    
    # 转换到处理中
    today = datetime.now()
    payload = {
        "transition": {"id": "4"},
        "fields": {
            "timetracking": {"originalEstimate": "1h"},
            "customfield_10109": today.strftime("%Y-%m-%d"),
            "customfield_10110": (today + timedelta(days=7)).strftime("%Y-%m-%d"),
        }
    }
    client._make_request("POST", f"/rest/api/2/issue/{key}/transitions", json=payload)
    print(f"  转换到处理中成功")
    
    # 记录工时
    client._make_request("POST", f"/rest/api/2/issue/{key}/worklog", 
                        json={"timeSpent": "1h", "comment": "问题处理完成"})
    
    # 转换到已解决 (完成)
    payload = {
        "transition": {"id": "5"},
        "fields": {
            "resolution": {"id": RESOLUTION_MAP["完成"]},
            "fixVersions": [{"name": "P1"}],
            "customfield_10144": "根本原因: 测试用途",
            "customfield_10701": "现象确认: 测试用途",
            "customfield_10145": "长期措施: 测试用途",
            "customfield_10146": "可能风险: 无",
            "customfield_10147": "对应代码: N/A",
        }
    }
    client._make_request("POST", f"/rest/api/2/issue/{key}/transitions", json=payload)
    print(f"  转换到已解决(完成)成功")
    
    # 获取最终状态
    issue = client.get_issue(key)
    status = issue.get("fields", {}).get("status", {}).get("name")
    resolution = issue.get("fields", {}).get("resolution", {}).get("name")
    print(f"  最终状态: {status} / {resolution}")
    
    return key


def sync_to_database(key, package_name, regression_pass_count):
    """同步到数据库"""
    db_config = {"type": "sqlite", "path": str(PROJECT_ROOT / "jira_automation.db")}
    db = DatabaseManager(db_config)
    
    db.execute("""
        INSERT OR REPLACE INTO jira_issues_main 
        (jira_key, summary, normalized_summary, status, package_name, exp_class, 
         raw_caused_by, fix_version, test_environment, regression_pass_count)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    """, (
        key,
        f"[ScenarioTest][RegressionPass] {package_name}",
        f"{package_name}|已解决|java.lang.TestException",
        "已解决",
        package_name,
        "java.lang.TestException",
        "resolution=完成",
        "P1",
        "ScenarioTest",
        regression_pass_count
    ))
    
    db.close()
    print(f"  已同步到数据库 (regression_pass_count={regression_pass_count})")


def main():
    print("=" * 70)
    print("创建回归 PASS 场景测试问题")
    print("=" * 70)
    
    client = JiraP12Client(
        jira_url=os.getenv("JIRA_URL"),
        p12_file_path=os.getenv("JIRA_P12_PATH"),
        p12_password=os.getenv("JIRA_P12_PASSWORD"),
        jira_username=os.getenv("JIRA_USERNAME"),
        jira_password=os.getenv("JIRA_PASSWORD")
    )
    
    try:
        # 场景1: 第1次 PASS (regression_pass_count=0)
        print("\n[PASS_1场景] 创建已解决问题 (regression_pass_count=0)...")
        key1 = create_resolved_issue(
            client,
            "[ScenarioTest][RegressionPass1] com.android.music java.lang.TestException",
            "决策场景测试: 回归PASS第1次\n包名: com.android.music\n\n当未匹配到此问题时，应记录第1次PASS",
            "com.android.music"
        )
        sync_to_database(key1, "com.android.music", 0)
        print(f"  ✓ {key1} - 用于验证第1次PASS")
        
        # 场景2: 第2次 PASS (regression_pass_count=1)
        print("\n[PASS_2场景] 创建已解决问题 (regression_pass_count=1)...")
        key2 = create_resolved_issue(
            client,
            "[ScenarioTest][RegressionPass2] com.android.gallery java.lang.TestException",
            "决策场景测试: 回归PASS第2次\n包名: com.android.gallery\n\n当未匹配到此问题时，应记录第2次PASS并关单",
            "com.android.gallery"
        )
        sync_to_database(key2, "com.android.gallery", 1)
        print(f"  ✓ {key2} - 用于验证第2次PASS并关单")
        
        print()
        print("=" * 70)
        print("回归 PASS 场景测试问题创建完成")
        print("=" * 70)
        print(f"  PASS_1: {key1} (regression_pass_count=0)")
        print(f"  PASS_2: {key2} (regression_pass_count=1)")
        print()
        print("URL:")
        print(f"  https://jira.tinno.com/browse/{key1}")
        print(f"  https://jira.tinno.com/browse/{key2}")
        
    finally:
        client.close()


if __name__ == "__main__":
    main()
