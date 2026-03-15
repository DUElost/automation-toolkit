#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
将指定问题状态改为"已解决"，用于测试回归 PASS 功能
"""

import os
import sys
import time
from pathlib import Path

PROJECT_ROOT = Path(__file__).parent.parent
sys.path.insert(0, str(PROJECT_ROOT))
sys.path.insert(0, str(PROJECT_ROOT / "src"))

from dotenv import load_dotenv
load_dotenv(PROJECT_ROOT / ".env")

from src.modules.jira_synchronizer import JIRASynchronizer
from src.modules.database_manager import DatabaseManager


def setup_resolved_issues(issue_keys: list, fix_version: str = "VVTB35.41-1"):
    """将问题状态改为已解决"""
    
    # 初始化 JIRA 连接
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
        print("JIRA 认证失败!")
        return
    
    # 获取底层 client
    client = jira_sync._backend.client
    
    # 初始化数据库
    db = DatabaseManager({"type": "sqlite", "path": str(PROJECT_ROOT / "jira_automation.db")})
    
    for issue_key in issue_keys:
        print(f"\n处理 {issue_key}...")
        
        try:
            # 获取当前状态
            issue = jira_sync.describe_issue(issue_key)
            if not issue:
                print(f"  问题不存在")
                continue
            
            current_status = issue.get("status", "")
            print(f"  当前状态: {current_status}")
            
            # 获取可用转换
            transitions = client.get_transitions(issue_key)
            trans_list = transitions.get("transitions", [])
            print(f"  可用转换: {[t.get('name') for t in trans_list]}")
            
            # 如果是 Open 状态，先转到处理中
            if current_status.lower() in ["open", "开放"]:
                # 查找"开始进行"转换
                start_transition = None
                for t in trans_list:
                    if t.get("name") in ["开始进行", "Start Progress", "In Progress"]:
                        start_transition = t
                        break
                
                if start_transition:
                    print(f"  执行转换: {start_transition.get('name')}")
                    # 添加必填字段
                    from datetime import datetime, timedelta
                    today = datetime.now().strftime("%Y-%m-%d")
                    end_date = (datetime.now() + timedelta(days=7)).strftime("%Y-%m-%d")
                    start_fields = {
                        "timetracking": {"originalEstimate": "1h"},  # 预估时间 1 小时
                        "customfield_10109": today,  # Start date
                        "customfield_10110": end_date,  # End date
                        "customfield_10111": today,  # Baseline start date
                        "customfield_10112": end_date,  # Baseline end date
                    }
                    client.transition_issue(issue_key, start_transition["id"], fields=start_fields)
                    time.sleep(1)
                    
                    # 重新获取转换
                    transitions = client.get_transitions(issue_key)
                    trans_list = transitions.get("transitions", [])
                    print(f"  新可用转换: {[t.get('name') for t in trans_list]}")
            
            # 查找"已解决"转换
            resolve_transition = None
            for t in trans_list:
                name = t.get("name", "").lower()
                if "解决" in name or "resolve" in name:
                    resolve_transition = t
                    break
            
            if resolve_transition:
                print(f"  执行转换: {resolve_transition.get('name')}")
                
                # 先添加工时记录
                try:
                    worklog_payload = {
                        "timeSpent": "1h",
                        "comment": "自动化测试工时"
                    }
                    client._make_request("POST", f"/rest/api/2/issue/{issue_key}/worklog", json=worklog_payload)
                    print(f"  已添加工时记录")
                except Exception as e:
                    print(f"  添加工时记录失败: {e}")
                
                # 构建转换字段
                fields = {}
                # 添加解决方案
                fields["resolution"] = {"name": "完成"}
                # 使用项目中存在的版本 P1
                fields["fixVersions"] = [{"name": "P1"}]
                # 添加根本原因（问题的起因）
                fields["customfield_10144"] = "自动化测试问题，已修复"
                # 添加长期措施（解决方案）
                fields["customfield_10145"] = "代码修复，已验证通过"
                # 添加可能风险（RiskProbability）
                fields["customfield_10146"] = "无风险"
                # 添加对应的解决代码（Corresponding code）
                fields["customfield_10147"] = "N/A"
                
                client.transition_issue(issue_key, resolve_transition["id"], fields=fields)
                print(f"  ✓ 已转换为已解决状态")
                
                # 更新数据库
                db.update_main_table_record(issue_key, {"status": "Resolved", "fix_version": "P1"})
            else:
                print(f"  ✗ 未找到已解决转换")
                
        except Exception as e:
            print(f"  ✗ 处理失败: {e}")
            import traceback
            traceback.print_exc()
    
    jira_sync.close()
    db.close()
    print("\n完成!")


if __name__ == "__main__":
    # 选择几个问题来测试回归 PASS
    # 这些问题标题都包含 [自动化]、[V551A]、[MonkeyAEE]
    test_issues = [
        "VCAME-307",  # ANR 问题
        "VCAME-308",  # ANR 问题
        "VCAME-312",  # Java 问题
    ]
    
    setup_resolved_issues(test_issues)
