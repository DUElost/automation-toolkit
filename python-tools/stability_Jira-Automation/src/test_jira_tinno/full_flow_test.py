#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
完整流程测试
------------

模拟完整的 JIRA 执行流程，包括评论记录，验证各 ActionKey 场景的实际行为。
"""

from __future__ import annotations

import json
import logging
import os
import sys
from pathlib import Path
from typing import Any, Dict, List, Optional

sys.path.insert(0, str(Path(__file__).parent.parent))

from modules.database_manager import DatabaseManager
from modules.decision_engine import DecisionEngine
from modules.data_normalizer import DataNormalizer
from modules.jira_executor import JIRAExecutor, COMMENT_WONT_FIX, COMMENT_REOPEN, COMMENT_WAIT_NEW, COMMENT_CONTINUE, COMMENT_PASS_1, COMMENT_PASS_2
from modules.jira_synchronizer import JIRASynchronizer
from modules.version_utils import compare_versions
from test_jira_tinno.test_data_generator import ActionKeyTestScenarios

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

TEST_DIR = Path(__file__).parent


class MockJiraBackendWithComments:
    """带评论记录的 Mock JIRA 后端"""
    
    def __init__(self, project_key: str = "VCAME"):
        self.project_key = project_key
        self._counter = 1000
        self._issues: Dict[str, Dict[str, Any]] = {}
        self._comments: Dict[str, List[str]] = {}  # jira_key -> [comments]
        self._transitions: Dict[str, List[str]] = {}  # jira_key -> [status changes]
    
    def create_issue(self, payload: Dict[str, Any]) -> Dict[str, Any]:
        self._counter += 1
        key = f"{self.project_key}-{self._counter}"
        self._issues[key] = {
            "key": key,
            "status": "Open",
            "fields": payload.copy(),
        }
        self._comments[key] = []
        self._transitions[key] = ["Open"]
        return {"key": key, "status": "Open", "fields": payload}
    
    def update_issue(self, key: str, payload: Dict[str, Any]) -> Dict[str, Any]:
        if key in self._issues:
            self._issues[key]["fields"].update(payload)
        return {"key": key, "status": self._issues.get(key, {}).get("status", "Open")}
    
    def transition_issue(self, key: str, status: str, comment: str = None) -> Dict[str, Any]:
        if key in self._issues:
            self._issues[key]["status"] = status
            self._transitions.setdefault(key, []).append(status)
        if comment:
            self._comments.setdefault(key, []).append(comment)
        return {"key": key, "status": status}
    
    def describe_issue(self, key: str) -> Dict[str, Any]:
        issue = self._issues.get(key, {})
        return {
            "key": key,
            "fields": issue.get("fields", {}),
            "status": issue.get("status", "Unknown"),
        }
    
    def add_comment(self, key: str, comment: str) -> None:
        self._comments.setdefault(key, []).append(comment)
    
    def close(self) -> None:
        pass
    
    def get_comments(self, key: str) -> List[str]:
        return self._comments.get(key, [])
    
    def get_all_comments(self) -> Dict[str, List[str]]:
        return self._comments.copy()
    
    def get_transitions(self, key: str) -> List[str]:
        return self._transitions.get(key, [])


class MockJiraSynchronizer:
    """Mock JIRA 同步器"""
    
    def __init__(self, config: Dict[str, Any] = None):
        self.config = config or {}
        self.project_key = self.config.get("project_key", "VCAME")
        # 使用 "test" 模式而非 "mock"，避免 JIRAExecutor 强制启用 dry_run
        self.mode = "test"
        self._backend = MockJiraBackendWithComments(self.project_key)
    
    def is_authenticated(self) -> bool:
        return True
    
    def create_issue(self, fields: Dict[str, Any]) -> Dict[str, Any]:
        return self._backend.create_issue(fields)
    
    def update_issue(self, key: str, fields: Dict[str, Any]) -> Dict[str, Any]:
        return self._backend.update_issue(key, fields)
    
    def transition_issue(self, key: str, status: str, comment: str = None) -> Dict[str, Any]:
        return self._backend.transition_issue(key, status, comment)
    
    def describe_issue(self, key: str) -> Dict[str, Any]:
        return self._backend.describe_issue(key)
    
    def add_comment(self, key: str, comment: str) -> None:
        self._backend.add_comment(key, comment)
    
    def close(self) -> None:
        self._backend.close()
    
    def get_all_comments(self) -> Dict[str, List[str]]:
        return self._backend.get_all_comments()
    
    def preset_issue(self, issue_data: Dict[str, Any]) -> None:
        """预设已存在问题到 Mock 后端，用于测试"""
        key = issue_data.get("jira_key")
        if not key:
            return
        status = issue_data.get("status", "Open")
        resolution = issue_data.get("resolution", "")
        fix_version = issue_data.get("fix_version")
        
        # 构建 fields 结构，模拟真实 JIRA API 返回格式
        fields = {
            "status": {"name": status},
            "resolution": {"name": resolution} if resolution else None,
            "fixVersions": [{"name": fix_version}] if fix_version else [],
        }
        
        self._backend._issues[key] = {
            "key": key,
            "status": status,
            "fields": fields,
        }
        self._backend._comments[key] = []
        self._backend._transitions[key] = [status]


class FullFlowTester:
    """完整流程测试器"""
    
    def __init__(self):
        self.scenarios = ActionKeyTestScenarios()
        self.normalizer = DataNormalizer()
        self.results: List[Dict[str, Any]] = []
    
    def run_scenario(self, scenario: Dict[str, Any], db_path: str) -> Dict[str, Any]:
        """运行单个场景的完整流程"""
        name = scenario["name"]
        
        # 清理旧数据库
        if Path(db_path).exists():
            os.remove(db_path)
        
        # 初始化组件
        db_config = {"type": "sqlite", "path": db_path}
        db = DatabaseManager(db_config)
        
        # 创建评论记录表
        db.execute("""
            CREATE TABLE IF NOT EXISTS test_comments (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                jira_key TEXT NOT NULL,
                comment TEXT NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        """)
        
        jira_sync = MockJiraSynchronizer({"project_key": "VCAME"})
        
        decision_config = {
            "thresholds": {
                "env_threshold": 0.70,
                "cause_threshold": 0.80,
                "summary_threshold": 0.70,
            },
            "cache_enabled": False,
        }
        decision_engine = DecisionEngine(db, decision_config)
        
        executor_config = {"dry_run": False, "max_workers": 1}
        executor = JIRAExecutor(jira_sync, decision_engine, db, executor_config)
        
        result = {
            "name": name,
            "description": scenario["description"],
            "passed": False,
            "comments": [],
            "expected_comment": scenario.get("expected_comment"),
            "details": {},
        }
        
        try:
            # 插入已存在问题
            existing = scenario.get("existing_issue")
            if existing:
                self._insert_existing_issue(db, existing)
                # 同时预设到 Mock 后端，确保 describe_issue 能返回正确状态
                jira_sync.preset_issue(existing)
            
            # 处理待处理问题
            pending = scenario.get("pending_issue")
            if pending:
                normalized = self.normalizer.normalize(pending)
                normalized["package_name"] = pending.get("package")
                normalized["detail"] = pending.get("detail", "")
                
                # 插入待处理表
                self._insert_pending_issue(db, normalized)
                
                # 执行处理
                exec_result = executor.process_pending_issues(limit=1)
                result["details"]["exec_result"] = exec_result
            else:
                # 回归场景：直接调用回归处理
                exec_result = executor.process_pending_issues(limit=0)
                result["details"]["exec_result"] = exec_result
            
            # 收集评论
            all_comments = jira_sync.get_all_comments()
            result["comments"] = all_comments
            
            # 将评论保存到数据库
            for jira_key, comments in all_comments.items():
                for comment in comments:
                    db.execute(
                        "INSERT INTO test_comments (jira_key, comment) VALUES (?, ?)",
                        (jira_key, comment)
                    )
            
            # 验证评论
            expected_comment = scenario.get("expected_comment")
            if expected_comment:
                found = any(
                    expected_comment in comment
                    for comments in all_comments.values()
                    for comment in comments
                )
                if found:
                    logger.info("✓ 评论匹配: %s", expected_comment)
                    result["passed"] = True
                else:
                    logger.warning("✗ 未找到期望评论: %s", expected_comment)
                    logger.info("  实际评论: %s", all_comments)
                    result["passed"] = False
            else:
                result["passed"] = True
            
        except Exception as e:
            logger.exception("场景执行失败: %s", e)
            result["passed"] = False
            result["details"]["error"] = str(e)
        finally:
            db.close()
        
        return result
    
    def _insert_existing_issue(self, db: DatabaseManager, issue_data: Dict[str, Any]) -> None:
        """插入已存在问题"""
        record = {
            "jira_key": issue_data.get("jira_key"),
            "status": issue_data.get("status", "Open"),
            "summary": issue_data.get("normalized_summary", "Test"),
            "normalized_summary": issue_data.get("normalized_summary", "Test"),
            "test_environment": issue_data.get("test_environment", ""),
            "raw_caused_by": issue_data.get("raw_caused_by", ""),
            "assignee": issue_data.get("assignee"),
            "bug_severity": issue_data.get("bug_severity", "C"),
            "priority": issue_data.get("priority", "Medium"),
            "description": "",
            "package_name": issue_data.get("package_name"),
            "exp_class": issue_data.get("exp_class"),
            "exp_type": issue_data.get("exp_type"),
            "cur_process": issue_data.get("cur_process"),
            "version": issue_data.get("version"),
            "count": issue_data.get("count", 1),
            "device_count": issue_data.get("device_count", 1),
            "fix_version": issue_data.get("fix_version"),
            "regression_pass_count": issue_data.get("regression_pass_count", 0),
            "verified_versions": issue_data.get("verified_versions"),
        }
        db.insert_issue(record)
    
    def _insert_pending_issue(self, db: DatabaseManager, normalized: Dict[str, Any]) -> None:
        """插入待处理问题"""
        pending = {
            "action": "CREATE",
            "package_name": normalized.get("package_name") or normalized.get("package"),
            "module": None,
            "affect_project": normalized.get("affect_project"),
            "key_information": normalized.get("caused_by"),
            "exp_class": normalized.get("exp_class"),
            "exp_type": normalized.get("exp_type"),
            "cur_process": normalized.get("cur_process"),
            "version": normalized.get("version"),
            "detail": normalized.get("detail"),
            "caused_by": normalized.get("caused_by"),
            "count": normalized.get("count", 1),
            "device_count": normalized.get("device_count", 1),
            "normalized_summary": normalized.get("normalized_summary"),
            "test_environment": normalized.get("test_environment"),
            "bug_severity": normalized.get("bug_severity"),
            "priority": normalized.get("priority"),
            "assignee": None,
            "jira_summary": normalized.get("jira_summary"),
            "jira_description": normalized.get("jira_description"),
            "ps": normalized.get("ps"),
            "source_file": normalized.get("source_file"),
            "row_number": normalized.get("row_number"),
            "raw_data": normalized,
        }
        db.insert_pending_issue(pending)
    
    def run_all_scenarios(self) -> List[Dict[str, Any]]:
        """运行所有场景"""
        all_scenarios = self.scenarios.get_all_scenarios()
        
        for i, scenario in enumerate(all_scenarios):
            db_path = str(TEST_DIR / f"full_flow_test_{i}.db")
            logger.info("\n" + "=" * 60)
            logger.info("场景 %d: %s", i, scenario["name"])
            logger.info("描述: %s", scenario["description"])
            
            result = self.run_scenario(scenario, db_path)
            self.results.append(result)
        
        return self.results
    
    def print_summary(self) -> bool:
        """打印测试摘要"""
        print("\n" + "=" * 60)
        print("完整流程测试摘要")
        print("=" * 60)
        
        passed = 0
        for result in self.results:
            status = "✓ PASS" if result["passed"] else "✗ FAIL"
            print(f"\n{status} - {result['name']}")
            print(f"  描述: {result['description']}")
            if result.get("expected_comment"):
                print(f"  期望评论: {result['expected_comment']}")
            if result.get("comments"):
                print(f"  实际评论: {result['comments']}")
            if result["passed"]:
                passed += 1
        
        print("\n" + "-" * 60)
        print(f"总计: {passed}/{len(self.results)} 通过")
        
        return passed == len(self.results)


def main():
    """主函数"""
    print("=" * 60)
    print("JIRA Tinno 完整流程测试（含评论验证）")
    print("=" * 60)
    
    tester = FullFlowTester()
    tester.run_all_scenarios()
    success = tester.print_summary()
    
    return 0 if success else 1


if __name__ == "__main__":
    sys.exit(main())
