#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
测试数据生成器
--------------

生成模拟的 Monkey 测试数据，用于验证各类 ActionKey 场景。
"""

from __future__ import annotations

import json
import random
import string
from dataclasses import dataclass, field
from datetime import datetime
from typing import Any, Dict, List, Optional


@dataclass
class MockIssueData:
    """模拟问题数据"""
    package: str
    exp_class: str
    exp_type: str
    cur_process: str
    version: str
    detail: str
    caused_by: str
    count: int = 1
    device_count: int = 1
    path: str = ""
    affect_project: str = "VCAME"
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "package": self.package,
            "exp_class": self.exp_class,
            "exp_type": self.exp_type,
            "cur_process": self.cur_process,
            "version": self.version,
            "detail": self.detail,
            "caused_by": self.caused_by,
            "count": self.count,
            "device_count": self.device_count,
            "path": self.path,
            "affect_project": self.affect_project,
            "row_number": random.randint(1, 1000),
            "source_file": "test_data.xlsx",
        }


class TestDataGenerator:
    """测试数据生成器"""
    
    # 常用包名
    PACKAGES = [
        "com.android.settings",
        "com.android.systemui",
        "com.android.launcher3",
        "com.android.phone",
        "com.android.camera",
        "com.android.gallery3d",
        "com.android.contacts",
        "com.android.mms",
        "com.android.browser",
        "com.android.music",
    ]
    
    # 异常类型
    EXCEPTION_CLASSES = [
        "java.lang.NullPointerException",
        "java.lang.IllegalStateException",
        "java.lang.RuntimeException",
        "java.lang.OutOfMemoryError",
        "android.view.WindowManager$BadTokenException",
        "java.lang.SecurityException",
        "java.lang.IndexOutOfBoundsException",
        "java.util.ConcurrentModificationException",
    ]
    
    # 异常类型简称
    EXCEPTION_TYPES = [
        "NPE",
        "ISE",
        "RTE",
        "OOM",
        "BadToken",
        "Security",
        "IOOB",
        "CME",
    ]

    def __init__(self, base_version: str = "V551A-15-251127V01"):
        self.base_version = base_version
    
    def generate_version(self, days_offset: int = 0) -> str:
        """生成版本号，days_offset 为相对于基准的天数偏移"""
        # 从基准版本提取时间戳部分
        # V551A-15-251127V01 -> 251127
        base_date = 251127  # YYMMDD
        new_date = base_date + days_offset
        build_num = random.randint(1, 50)
        return f"V551A-15-{new_date}V{build_num:02d}"
    
    def generate_stack_trace(self, exp_class: str, package: str) -> str:
        """生成模拟堆栈信息"""
        lines = [
            f"{exp_class}: Simulated error message",
            f"\tat {package}.MainActivity.onCreate(MainActivity.java:{random.randint(50, 500)})",
            f"\tat android.app.Activity.performCreate(Activity.java:{random.randint(100, 800)})",
            f"\tat android.app.Instrumentation.callActivityOnCreate(Instrumentation.java:{random.randint(100, 300)})",
        ]
        return "\n".join(lines)
    
    def generate_caused_by(self, exp_class: str, package: str) -> str:
        """生成 CausedBy 信息"""
        return f"Caused by: {exp_class}\n\tat {package}.core.Handler.process(Handler.java:{random.randint(10, 200)})"
    
    def generate_single_issue(
        self,
        package: Optional[str] = None,
        exp_class: Optional[str] = None,
        version: Optional[str] = None,
        count: int = 1,
    ) -> MockIssueData:
        """生成单个问题数据"""
        pkg = package or random.choice(self.PACKAGES)
        exc = exp_class or random.choice(self.EXCEPTION_CLASSES)
        exc_type = self.EXCEPTION_TYPES[self.EXCEPTION_CLASSES.index(exc)] if exc in self.EXCEPTION_CLASSES else "Unknown"
        ver = version or self.generate_version()
        
        return MockIssueData(
            package=pkg,
            exp_class=exc,
            exp_type=exc_type,
            cur_process=pkg,
            version=ver,
            detail=self.generate_stack_trace(exc, pkg),
            caused_by=self.generate_caused_by(exc, pkg),
            count=count,
            device_count=random.randint(1, count),
            path=f"/data/anr/traces_{random.randint(1000, 9999)}.txt",
        )
    
    def generate_batch(self, count: int = 10) -> List[Dict[str, Any]]:
        """批量生成问题数据"""
        return [self.generate_single_issue().to_dict() for _ in range(count)]


# ============================================================
# 各 ActionKey 场景的测试数据
# ============================================================

class ActionKeyTestScenarios:
    """
    各 ActionKey 场景的测试数据生成器。
    
    ActionKey 说明：
    - ACT_NEW_ISSUE: 新问题，无匹配
    - ACT_NEW_REF_CLOSED: 匹配到已关闭问题，新建并关联
    - ACT_LOG_WONT_FIX: 匹配到不解决状态，仅备注
    - ACT_UPDATE_OPEN: 匹配到未解决状态，更新标题和等级
    - ACT_IGNORE_LEGACY: 匹配到已解决，但版本早于修复版本
    - ACT_REOPEN: 匹配到已解决，版本晚于修复版本，Reopen
    - ACT_REGRESSION_PASS_1: 已解决问题未匹配，第1次PASS
    - ACT_REGRESSION_CLOSE: 已解决问题未匹配，第2次PASS后关单
    - ACT_REGRESSION_SKIP: 已达到2次PASS，跳过
    """
    
    def __init__(self):
        self.generator = TestDataGenerator()
    
    def scenario_new_issue(self) -> Dict[str, Any]:
        """场景1: 新问题，数据库中无匹配"""
        unique_suffix = ''.join(random.choices(string.ascii_lowercase, k=6))
        return {
            "name": "ACT_NEW_ISSUE",
            "description": "新问题，数据库中无匹配，应新建JIRA",
            "pending_issue": self.generator.generate_single_issue(
                package=f"com.test.unique.{unique_suffix}",
                version=self.generator.generate_version(0),
            ).to_dict(),
            "existing_issue": None,
            "expected_action": "CREATE",
        }
    
    def scenario_match_closed(self) -> Dict[str, Any]:
        """场景2: 匹配到已关闭问题"""
        pkg = "com.android.settings"
        exc = "java.lang.NullPointerException"
        caused_by = self.generator.generate_caused_by(exc, pkg)
        
        return {
            "name": "ACT_NEW_REF_CLOSED",
            "description": "匹配到已关闭问题，决策引擎返回UPDATE但执行器会忽略",
            "pending_issue": self.generator.generate_single_issue(
                package=pkg,
                exp_class=exc,
                version=self.generator.generate_version(0),
            ).to_dict(),
            "existing_issue": {
                "jira_key": "VCAME-TEST-CLOSED",
                "status": "Closed",
                "package_name": pkg,
                "normalized_summary": f"[自动化][V551A][MonkeyAEE][{exc}]{pkg}发生{exc}",
                "test_environment": f"*Package:* {pkg}\n*ExpClass:* {exc}",
                "raw_caused_by": caused_by,
            },
            # 决策引擎会返回 UPDATE（匹配到），执行器判断状态后忽略
            "expected_action": "UPDATE",
        }
    
    def scenario_wont_fix(self) -> Dict[str, Any]:
        """场景3: 匹配到不解决状态"""
        pkg = "com.android.systemui"
        exc = "java.lang.IllegalStateException"
        exc_type = "ISE"
        caused_by = self.generator.generate_caused_by(exc, pkg)
        # 确保 test_environment 完全匹配
        test_env = f"*Package:* {pkg}\n*ExpClass:* {exc}\n*ExpType:* {exc_type}\n*CurProcess:* {pkg}"
        
        pending = self.generator.generate_single_issue(
            package=pkg,
            exp_class=exc,
            version=self.generator.generate_version(0),
        ).to_dict()
        # 覆盖 caused_by 确保匹配
        pending["caused_by"] = caused_by
        
        return {
            "name": "ACT_LOG_WONT_FIX",
            "description": "匹配到不解决状态，仅添加备注",
            "pending_issue": pending,
            "existing_issue": {
                "jira_key": "VCAME-TEST-WONTFIX",
                "status": "Open",
                "resolution": "Won't Fix",
                "package_name": pkg,
                "normalized_summary": f"[自动化][V551A][MonkeyAEE][{exc}]{pkg}发生{exc}",
                "test_environment": test_env,
                "raw_caused_by": caused_by,
            },
            "expected_action": "UPDATE",
            "expected_comment": "Won't fix待后续补充信息",
        }
    
    def scenario_update_open(self) -> Dict[str, Any]:
        """场景4: 匹配到未解决状态"""
        pkg = "com.android.launcher3"
        exc = "java.lang.RuntimeException"
        caused_by = self.generator.generate_caused_by(exc, pkg)
        
        return {
            "name": "ACT_UPDATE_OPEN",
            "description": "匹配到未解决状态，更新标题和等级",
            "pending_issue": self.generator.generate_single_issue(
                package=pkg,
                exp_class=exc,
                version=self.generator.generate_version(0),
                count=5,
            ).to_dict(),
            "existing_issue": {
                "jira_key": "VCAME-TEST-OPEN",
                "status": "Open",
                "package_name": pkg,
                "normalized_summary": f"[自动化][V551A][MonkeyAEE][{exc}]{pkg}发生{exc}",
                "test_environment": f"*Package:* {pkg}\n*ExpClass:* {exc}",
                "raw_caused_by": caused_by,
                "count": 3,
            },
            "expected_action": "UPDATE",
            "expected_comment": "问题继续在新版本中出现，待后续补充信息",
        }
    
    def scenario_ignore_legacy(self) -> Dict[str, Any]:
        """场景5: 匹配到已解决，版本早于修复版本"""
        pkg = "com.android.phone"
        exc = "java.lang.SecurityException"
        caused_by = self.generator.generate_caused_by(exc, pkg)
        
        return {
            "name": "ACT_IGNORE_LEGACY",
            "description": "匹配到已解决，当前版本早于修复版本，仅备注",
            "pending_issue": self.generator.generate_single_issue(
                package=pkg,
                exp_class=exc,
                version="V551A-15-251120V10",  # 早于修复版本
            ).to_dict(),
            "existing_issue": {
                "jira_key": "VCAME-TEST-RESOLVED-LEGACY",
                "status": "Resolved",
                "package_name": pkg,
                "normalized_summary": f"[自动化][V551A][MonkeyAEE][{exc}]{pkg}发生{exc}",
                "test_environment": f"*Package:* {pkg}\n*ExpClass:* {exc}",
                "raw_caused_by": caused_by,
                "fix_version": "V551A-15-251125V20",  # 修复版本
            },
            "expected_action": "UPDATE",
            "expected_comment": "在历史版本中出现，待新版本验证结果",
        }
    
    def scenario_reopen(self) -> Dict[str, Any]:
        """场景6: 匹配到已解决，版本晚于修复版本，Reopen"""
        pkg = "com.android.camera"
        exc = "java.lang.OutOfMemoryError"
        caused_by = self.generator.generate_caused_by(exc, pkg)
        
        return {
            "name": "ACT_REOPEN",
            "description": "匹配到已解决，当前版本晚于修复版本，Reopen",
            "pending_issue": self.generator.generate_single_issue(
                package=pkg,
                exp_class=exc,
                version="V551A-15-251128V15",  # 晚于修复版本
            ).to_dict(),
            "existing_issue": {
                "jira_key": "VCAME-TEST-RESOLVED-REOPEN",
                "status": "Resolved",
                "package_name": pkg,
                "normalized_summary": f"[自动化][V551A][MonkeyAEE][{exc}]{pkg}发生{exc}",
                "test_environment": f"*Package:* {pkg}\n*ExpClass:* {exc}",
                "raw_caused_by": caused_by,
                "fix_version": "V551A-15-251125V20",  # 修复版本
            },
            "expected_action": "UPDATE",
            "expected_reopen": True,
            "expected_comment": "问题复现Reopen待后续补充信息",
        }
    
    def scenario_regression_pass_1(self) -> Dict[str, Any]:
        """场景7: 已解决问题未匹配，第1次PASS"""
        pkg = "com.android.gallery3d"
        exc = "java.lang.IndexOutOfBoundsException"
        
        return {
            "name": "ACT_REGRESSION_PASS_1",
            "description": "已解决问题未在上传清单中匹配，第1次回归PASS",
            "existing_issue": {
                "jira_key": "VCAME-TEST-PASS1",
                "status": "Resolved",
                "package_name": pkg,
                "regression_pass_count": 0,
                "verified_versions": "[]",
            },
            "pending_issues": [],  # 空，表示未匹配
            "expected_comment": "已回归验证1个版本PASS",
            "expected_pass_count": 1,
        }
    
    def scenario_regression_close(self) -> Dict[str, Any]:
        """场景8: 已解决问题未匹配，第2次PASS后关单"""
        pkg = "com.android.contacts"
        exc = "java.util.ConcurrentModificationException"
        
        return {
            "name": "ACT_REGRESSION_CLOSE",
            "description": "已解决问题第2次回归PASS，关单",
            "existing_issue": {
                "jira_key": "VCAME-TEST-PASS2",
                "status": "Resolved",
                "package_name": pkg,
                "regression_pass_count": 1,
                "verified_versions": '["V551A-15-251126V10"]',
            },
            "pending_issues": [],
            "expected_comment": "已回归验证2个版本PASS",
            "expected_pass_count": 2,
            "expected_status": "Closed",
        }
    
    def get_all_scenarios(self) -> List[Dict[str, Any]]:
        """获取所有测试场景"""
        return [
            self.scenario_new_issue(),
            self.scenario_match_closed(),
            self.scenario_wont_fix(),
            self.scenario_update_open(),
            self.scenario_ignore_legacy(),
            self.scenario_reopen(),
            self.scenario_regression_pass_1(),
            self.scenario_regression_close(),
        ]


if __name__ == "__main__":
    # 测试数据生成
    scenarios = ActionKeyTestScenarios()
    all_scenarios = scenarios.get_all_scenarios()
    
    print("=" * 60)
    print("ActionKey 测试场景")
    print("=" * 60)
    
    for scenario in all_scenarios:
        print(f"\n【{scenario['name']}】")
        print(f"  描述: {scenario['description']}")
        if scenario.get('expected_action'):
            print(f"  期望动作: {scenario['expected_action']}")
        if scenario.get('expected_comment'):
            print(f"  期望备注: {scenario['expected_comment']}")
