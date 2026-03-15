#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
完整决策场景测试问题建立脚本
---------------------------

创建覆盖所有决策场景的测试问题：
1. CREATE  - 新建问题（无需预置问题）
2. UPDATE  - Open/Reopened 状态问题
3. COMMENT - Won't Fix 状态问题
4. REOPEN  - 已解决/已关闭(完成)状态问题
5. IGNORE  - 已关闭(完成)状态问题

使用方法:
    python scripts/setup_all_scenarios.py
"""

from __future__ import annotations

import os
import sys
from datetime import datetime, timedelta
from pathlib import Path
from typing import Dict, Optional

PROJECT_ROOT = Path(__file__).parent.parent
sys.path.insert(0, str(PROJECT_ROOT))
sys.path.insert(0, str(PROJECT_ROOT / "src"))

from dotenv import load_dotenv
load_dotenv(PROJECT_ROOT / ".env")

from src.modules.jira_p12_client import JiraP12Client
from src.modules.database_manager import DatabaseManager


class ScenarioBuilder:
    """决策场景测试问题构建器"""
    
    # 解决方案 ID 映射
    RESOLUTION_MAP = {
        "完成": "10000",
        "问题不修改": "10102",
    }
    
    def __init__(self):
        self.client = JiraP12Client(
            jira_url=os.getenv('JIRA_URL'),
            p12_file_path=os.getenv('JIRA_P12_PATH'),
            p12_password=os.getenv('JIRA_P12_PASSWORD'),
            jira_username=os.getenv('JIRA_USERNAME'),
            jira_password=os.getenv('JIRA_PASSWORD')
        )
        self.project_key = os.getenv('JIRA_PROJECT_KEY', 'VCAME')
        self.results: Dict[str, dict] = {}
    
    def close(self):
        self.client.close()
    
    def _create_issue(self, summary: str, description: str, 
                      package_name: str, exp_class: str) -> Optional[str]:
        """创建问题"""
        fields = {
            "project": {"key": self.project_key},
            "issuetype": {"name": "Bug"},
            "summary": summary,
            "description": description,
            "labels": ["MonkeyAEE", "ScenarioTest"],
            "components": [{"name": "AUTOTEST"}],
            "customfield_10120": {"value": "B"},
            "assignee": {"name": os.getenv('JIRA_USERNAME', 'dai.lv')},
        }
        
        try:
            result = self.client.create_issue(fields)
            return result.get('key')
        except Exception as e:
            print(f"    创建失败: {e}")
            return None
    
    def _transition_to_in_progress(self, issue_key: str) -> bool:
        """转换到处理中"""
        today = datetime.now()
        payload = {
            "transition": {"id": "4"},
            "fields": {
                "timetracking": {"originalEstimate": "1h"},
                "customfield_10109": today.strftime("%Y-%m-%d"),
                "customfield_10110": (today + timedelta(days=7)).strftime("%Y-%m-%d"),
            }
        }
        try:
            self.client._make_request("POST", f"/rest/api/2/issue/{issue_key}/transitions", json=payload)
            return True
        except Exception as e:
            print(f"    转换到处理中失败: {e}")
            return False
    
    def _record_worklog(self, issue_key: str) -> bool:
        """记录工时"""
        try:
            self.client._make_request(
                "POST",
                f"/rest/api/2/issue/{issue_key}/worklog",
                json={"timeSpent": "1h", "comment": "问题处理完成"}
            )
            return True
        except Exception:
            return False
    
    def _transition_to_resolved(self, issue_key: str, resolution: str = "完成",
                                fix_version: str = "P1") -> bool:
        """转换到已解决"""
        self._record_worklog(issue_key)
        
        payload = {
            "transition": {"id": "5"},
            "fields": {
                "resolution": {"id": self.RESOLUTION_MAP.get(resolution, "10000")},
                "fixVersions": [{"name": fix_version}],
                "customfield_10144": "根本原因: 测试用途",
                "customfield_10701": "现象确认: 测试用途",
                "customfield_10145": "长期措施: 测试用途",
                "customfield_10146": "可能风险: 无",
                "customfield_10147": "对应代码: N/A",
            }
        }
        try:
            self.client._make_request("POST", f"/rest/api/2/issue/{issue_key}/transitions", json=payload)
            return True
        except Exception as e:
            print(f"    转换到已解决失败: {e}")
            return False
    
    def _transition_to_closed(self, issue_key: str, resolution: str = "完成",
                              fix_version: str = "P1") -> bool:
        """转换到已关闭"""
        self._record_worklog(issue_key)
        
        payload = {
            "transition": {"id": "2"},
            "fields": {
                "resolution": {"id": self.RESOLUTION_MAP.get(resolution, "10000")},
                "fixVersions": [{"name": fix_version}],
                "customfield_10144": "根本原因: 测试用途",
                "customfield_10701": "现象确认: 测试用途",
            }
        }
        try:
            self.client._make_request("POST", f"/rest/api/2/issue/{issue_key}/transitions", json=payload)
            return True
        except Exception as e:
            print(f"    转换到已关闭失败: {e}")
            return False
    
    def _transition_to_reopened(self, issue_key: str) -> bool:
        """转换到重新打开"""
        payload = {"transition": {"id": "3"}}
        try:
            self.client._make_request("POST", f"/rest/api/2/issue/{issue_key}/transitions", json=payload)
            return True
        except Exception as e:
            print(f"    转换到重新打开失败: {e}")
            return False
    
    def _get_issue_info(self, issue_key: str) -> dict:
        """获取问题信息"""
        issue = self.client.get_issue(issue_key)
        fields = issue.get('fields', {})
        return {
            'key': issue_key,
            'status': fields.get('status', {}).get('name'),
            'resolution': fields.get('resolution', {}).get('name') if fields.get('resolution') else None,
            'fixVersions': [v.get('name') for v in fields.get('fixVersions', [])],
        }
    
    def create_open_issue(self) -> Optional[str]:
        """创建 Open 状态问题 (UPDATE 场景)"""
        print("\n[UPDATE场景] 创建 Open 状态问题...")
        key = self._create_issue(
            summary="[ScenarioTest][Open] com.android.settings java.lang.NullPointerException",
            description="决策场景测试: UPDATE\n包名: com.android.settings\n异常: java.lang.NullPointerException\n\n当匹配到此问题时，应更新计数",
            package_name="com.android.settings",
            exp_class="java.lang.NullPointerException"
        )
        if key:
            info = self._get_issue_info(key)
            self.results['OPEN_FOR_UPDATE'] = info
            print(f"  ✓ {key} - 状态: {info['status']}")
        return key
    
    def create_resolved_issue(self) -> Optional[str]:
        """创建 Resolved 状态问题 (REOPEN 场景)"""
        print("\n[REOPEN场景] 创建 Resolved 状态问题...")
        key = self._create_issue(
            summary="[ScenarioTest][Resolved] com.android.systemui java.lang.RuntimeException",
            description="决策场景测试: REOPEN\n包名: com.android.systemui\n异常: java.lang.RuntimeException\n\n当新版本出现相同问题时，应重新打开",
            package_name="com.android.systemui",
            exp_class="java.lang.RuntimeException"
        )
        if key:
            print(f"  创建成功: {key}")
            print("  转换: 开放 -> 处理中...")
            if self._transition_to_in_progress(key):
                print("  转换: 处理中 -> 已解决...")
                if self._transition_to_resolved(key, "完成", "P1"):
                    info = self._get_issue_info(key)
                    self.results['RESOLVED_FOR_REOPEN'] = info
                    print(f"  ✓ {key} - 状态: {info['status']}, 解决方案: {info['resolution']}, 修复版本: {info['fixVersions']}")
                    return key
        return None
    
    def create_wontfix_issue(self) -> Optional[str]:
        """创建 Resolved/Won't Fix 状态问题 (COMMENT 场景)
        
        注意：已解决/问题不修改 才是 Won't Fix 场景
        已关闭/问题不修改 等同于已关闭/完成，都是 IGNORE 场景
        """
        print("\n[COMMENT场景] 创建 Resolved/Won't Fix 状态问题...")
        key = self._create_issue(
            summary="[ScenarioTest][WontFix] com.android.phone java.lang.IllegalStateException",
            description="决策场景测试: COMMENT (Won't Fix)\n包名: com.android.phone\n异常: java.lang.IllegalStateException\n\n当匹配到此问题时，应添加备注而非重新打开",
            package_name="com.android.phone",
            exp_class="java.lang.IllegalStateException"
        )
        if key:
            print(f"  创建成功: {key}")
            print("  转换: 开放 -> 处理中...")
            if self._transition_to_in_progress(key):
                print("  转换: 处理中 -> 已解决 (问题不修改)...")
                if self._transition_to_resolved(key, "问题不修改", "P1"):
                    info = self._get_issue_info(key)
                    self.results['WONTFIX_FOR_COMMENT'] = info
                    print(f"  ✓ {key} - 状态: {info['status']}, 解决方案: {info['resolution']}")
                    return key
        return None
    
    def create_closed_issue(self) -> Optional[str]:
        """创建 Closed 状态问题 (IGNORE 场景)"""
        print("\n[IGNORE场景] 创建 Closed 状态问题...")
        key = self._create_issue(
            summary="[ScenarioTest][Closed] com.android.camera java.lang.OutOfMemoryError",
            description="决策场景测试: IGNORE\n包名: com.android.camera\n异常: java.lang.OutOfMemoryError\n\n当旧版本出现相同问题时，应忽略",
            package_name="com.android.camera",
            exp_class="java.lang.OutOfMemoryError"
        )
        if key:
            print(f"  创建成功: {key}")
            print("  转换: 开放 -> 处理中...")
            if self._transition_to_in_progress(key):
                print("  转换: 处理中 -> 已关闭 (完成)...")
                if self._transition_to_closed(key, "完成", "P1"):
                    info = self._get_issue_info(key)
                    self.results['CLOSED_FOR_IGNORE'] = info
                    print(f"  ✓ {key} - 状态: {info['status']}, 解决方案: {info['resolution']}, 修复版本: {info['fixVersions']}")
                    return key
        return None
    
    def create_reopened_issue(self) -> Optional[str]:
        """创建 Reopened 状态问题 (UPDATE 场景)"""
        print("\n[UPDATE场景] 创建 Reopened 状态问题...")
        key = self._create_issue(
            summary="[ScenarioTest][Reopened] com.android.launcher3 java.lang.IndexOutOfBoundsException",
            description="决策场景测试: UPDATE (回归)\n包名: com.android.launcher3\n异常: java.lang.IndexOutOfBoundsException\n\n当匹配到此问题时，应更新计数",
            package_name="com.android.launcher3",
            exp_class="java.lang.IndexOutOfBoundsException"
        )
        if key:
            print(f"  创建成功: {key}")
            print("  转换: 开放 -> 处理中...")
            if self._transition_to_in_progress(key):
                print("  转换: 处理中 -> 已关闭...")
                if self._transition_to_closed(key, "完成", "P1"):
                    print("  转换: 已关闭 -> 重新打开...")
                    if self._transition_to_reopened(key):
                        info = self._get_issue_info(key)
                        self.results['REOPENED_FOR_UPDATE'] = info
                        print(f"  ✓ {key} - 状态: {info['status']}")
                        return key
        return None
    
    def sync_to_database(self):
        """同步测试问题到本地数据库"""
        print("\n同步测试问题到本地数据库...")
        
        db_config = {"type": "sqlite", "path": str(PROJECT_ROOT / "jira_automation.db")}
        db = DatabaseManager(db_config)
        
        for scenario, info in self.results.items():
            issue_key = info['key']
            
            # 从摘要提取包名和异常类
            issue = self.client.get_issue(issue_key)
            fields = issue.get('fields', {})
            summary = fields.get('summary', '')
            description = fields.get('description', '')
            
            # 解析包名
            package_name = "com.test.scenario"
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
            
            # 解析异常类
            exp_class = "java.lang.Exception"
            if "NullPointerException" in summary:
                exp_class = "java.lang.NullPointerException"
            elif "RuntimeException" in summary:
                exp_class = "java.lang.RuntimeException"
            elif "IllegalStateException" in summary:
                exp_class = "java.lang.IllegalStateException"
            elif "OutOfMemoryError" in summary:
                exp_class = "java.lang.OutOfMemoryError"
            elif "IndexOutOfBoundsException" in summary:
                exp_class = "java.lang.IndexOutOfBoundsException"
            
            normalized_summary = f"{package_name}|{info['status']}|{exp_class}"
            fix_version = info['fixVersions'][0] if info['fixVersions'] else None
            
            # 检查是否已存在
            existing = db.execute(
                "SELECT id FROM jira_issues_main WHERE jira_key = ?",
                (issue_key,)
            )
            
            if existing:
                db.execute(
                    """UPDATE jira_issues_main 
                       SET status = ?, fix_version = ?, raw_caused_by = ?
                       WHERE jira_key = ?""",
                    (info['status'], fix_version, f"resolution={info['resolution']}", issue_key)
                )
            else:
                db.execute(
                    """INSERT INTO jira_issues_main 
                       (jira_key, summary, normalized_summary, status, package_name, 
                        exp_class, raw_caused_by, fix_version, test_environment)
                       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)""",
                    (issue_key, summary, normalized_summary, info['status'], package_name,
                     exp_class, f"resolution={info['resolution']}", fix_version, "ScenarioTest")
                )
            
            print(f"  ✓ {issue_key} 已同步")
        
        db.close()
    
    def print_summary(self):
        """打印汇总"""
        print()
        print("=" * 70)
        print("决策场景测试问题汇总")
        print("=" * 70)
        print()
        print(f"{'场景':<20} {'Key':<12} {'状态':<10} {'解决方案':<12} {'修复版本':<10}")
        print("-" * 70)
        
        scenario_names = {
            'OPEN_FOR_UPDATE': 'UPDATE (Open)',
            'RESOLVED_FOR_REOPEN': 'REOPEN (Resolved)',
            'WONTFIX_FOR_COMMENT': 'COMMENT (WontFix)',
            'CLOSED_FOR_IGNORE': 'IGNORE (Closed)',
            'REOPENED_FOR_UPDATE': 'UPDATE (Reopened)',
        }
        
        for scenario, info in self.results.items():
            name = scenario_names.get(scenario, scenario)
            res = info['resolution'] or '-'
            ver = info['fixVersions'][0] if info['fixVersions'] else '-'
            print(f"{name:<20} {info['key']:<12} {info['status']:<10} {res:<12} {ver:<10}")
        
        print("-" * 70)
        print()
        print("URL:")
        for info in self.results.values():
            print(f"  https://jira.tinno.com/browse/{info['key']}")
        print()


def main():
    print("=" * 70)
    print("JIRA 决策场景测试问题建立")
    print("=" * 70)
    print(f"项目: {os.getenv('JIRA_PROJECT_KEY', 'VCAME')}")
    print(f"URL: {os.getenv('JIRA_URL')}")
    
    builder = ScenarioBuilder()
    
    try:
        # 创建各场景问题
        builder.create_open_issue()
        builder.create_resolved_issue()
        builder.create_wontfix_issue()
        builder.create_closed_issue()
        builder.create_reopened_issue()
        
        # 同步到数据库
        builder.sync_to_database()
        
        # 打印汇总
        builder.print_summary()
        
    finally:
        builder.close()


if __name__ == "__main__":
    main()
