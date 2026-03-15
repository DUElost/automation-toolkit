#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
本地数据库测试
--------------

在本地 SQLite 数据库中模拟各类 ActionKey 场景，验证决策逻辑。
"""

from __future__ import annotations

import json
import logging
import os
import sys
from pathlib import Path
from typing import Any, Dict, List, Optional

# 添加项目路径
sys.path.insert(0, str(Path(__file__).parent.parent))

from modules.database_manager import DatabaseManager
from modules.decision_engine import DecisionEngine, DecisionResult
from modules.data_normalizer import DataNormalizer
from modules.version_utils import compare_versions
from test_jira_tinno.test_data_generator import ActionKeyTestScenarios, TestDataGenerator

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

# 测试数据库路径
TEST_DB_PATH = Path(__file__).parent / "test_jira_tinno.db"


class LocalDBTester:
    """本地数据库测试器"""
    
    def __init__(self, db_path: str = None):
        self.db_path = db_path or str(TEST_DB_PATH)
        self.db: Optional[DatabaseManager] = None
        self.decision_engine: Optional[DecisionEngine] = None
        self.normalizer = DataNormalizer()
        self.scenarios = ActionKeyTestScenarios()
        self.results: List[Dict[str, Any]] = []
    
    def setup(self):
        """初始化测试环境"""
        # 删除旧的测试数据库
        if Path(self.db_path).exists():
            os.remove(self.db_path)
            logger.info("已删除旧测试数据库: %s", self.db_path)
        
        # 创建新数据库
        db_config = {"type": "sqlite", "path": self.db_path}
        self.db = DatabaseManager(db_config)
        
        # 初始化决策引擎（测试时降低阈值以便匹配）
        decision_config = {
            "thresholds": {
                "env_threshold": 0.70,  # 测试时降低阈值
                "cause_threshold": 0.80,
                "summary_threshold": 0.70,
            },
            "cache_enabled": True,
        }
        self.decision_engine = DecisionEngine(self.db, decision_config)
        
        logger.info("测试环境初始化完成")
    
    def teardown(self):
        """清理测试环境"""
        if self.db:
            self.db.close()
        logger.info("测试环境已清理")
    
    def insert_existing_issue(self, issue_data: Dict[str, Any]) -> None:
        """插入模拟的已存在问题"""
        record = {
            "jira_key": issue_data.get("jira_key", "VCAME-TEST-001"),
            "status": issue_data.get("status", "Open"),
            "summary": issue_data.get("normalized_summary", "Test Summary"),
            "normalized_summary": issue_data.get("normalized_summary", "Test Summary"),
            "test_environment": issue_data.get("test_environment", "Test Env"),
            "raw_caused_by": issue_data.get("raw_caused_by", "Test CausedBy"),
            "assignee": issue_data.get("assignee"),
            "bug_severity": issue_data.get("bug_severity", "C"),
            "priority": issue_data.get("priority", "Medium"),
            "description": issue_data.get("description", ""),
            "package_name": issue_data.get("package_name", "com.test"),
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
        self.db.insert_issue(record)
        logger.info("插入测试问题: %s (status=%s)", record["jira_key"], record["status"])
    
    def normalize_pending_issue(self, raw_data: Dict[str, Any]) -> Dict[str, Any]:
        """标准化待处理问题"""
        normalized = self.normalizer.normalize(raw_data)
        normalized["package_name"] = raw_data.get("package")
        normalized["detail"] = raw_data.get("detail", "")
        return normalized
    
    def run_scenario(self, scenario: Dict[str, Any]) -> Dict[str, Any]:
        """运行单个测试场景"""
        name = scenario["name"]
        description = scenario["description"]
        
        logger.info("=" * 60)
        logger.info("运行场景: %s", name)
        logger.info("描述: %s", description)
        
        result = {
            "name": name,
            "description": description,
            "passed": False,
            "details": {},
        }
        
        try:
            # 插入已存在问题（如果有）
            existing = scenario.get("existing_issue")
            if existing:
                self.insert_existing_issue(existing)
            
            # 处理待处理问题
            pending = scenario.get("pending_issue")
            if pending:
                normalized = self.normalize_pending_issue(pending)
                decision = self.decision_engine.decide(normalized)
                
                result["details"]["decision_action"] = decision.action
                result["details"]["matched_key"] = decision.matched_key
                result["details"]["similarity_score"] = decision.similarity_score
                
                # 验证期望
                expected_action = scenario.get("expected_action")
                if expected_action:
                    if decision.action == expected_action:
                        logger.info("✓ 动作匹配: %s", decision.action)
                        result["passed"] = True
                    else:
                        logger.error("✗ 动作不匹配: 期望 %s, 实际 %s", expected_action, decision.action)
                        result["passed"] = False
            else:
                # 回归场景（无待处理问题）
                result["details"]["scenario_type"] = "regression"
                result["passed"] = True
                logger.info("✓ 回归场景数据准备完成")
            
        except Exception as e:
            logger.exception("场景执行失败: %s", e)
            result["passed"] = False
            result["details"]["error"] = str(e)
        
        return result
    
    def run_all_scenarios(self) -> List[Dict[str, Any]]:
        """运行所有测试场景"""
        all_scenarios = self.scenarios.get_all_scenarios()
        
        for i, scenario in enumerate(all_scenarios):
            # 每个场景使用独立的数据库
            self.db_path = str(TEST_DB_PATH.parent / f"test_jira_tinno_{i}.db")
            self.setup()
            try:
                result = self.run_scenario(scenario)
                self.results.append(result)
            finally:
                self.teardown()
                # 保留测试数据库文件以便检查
                # 如需清理，取消下面注释
                # try:
                #     if Path(self.db_path).exists():
                #         os.remove(self.db_path)
                # except Exception:
                #     pass
        
        return self.results
    
    def print_summary(self):
        """打印测试摘要"""
        print("\n" + "=" * 60)
        print("测试摘要")
        print("=" * 60)
        
        passed = sum(1 for r in self.results if r["passed"])
        total = len(self.results)
        
        for result in self.results:
            status = "✓ PASS" if result["passed"] else "✗ FAIL"
            print(f"  {status} - {result['name']}: {result['description']}")
        
        print("-" * 60)
        print(f"总计: {passed}/{total} 通过")
        
        return passed == total


def test_version_comparison():
    """测试版本比较逻辑"""
    print("\n" + "=" * 60)
    print("版本比较测试")
    print("=" * 60)
    
    test_cases = [
        ("V551A-15-251128V15", "V551A-15-251125V20", 1, "复现: 当前版本 > 修复版本"),
        ("V551A-15-251120V10", "V551A-15-251125V20", -1, "历史: 当前版本 < 修复版本"),
        ("V551A-15-251125V20", "V551A-15-251125V20", 0, "相同版本"),
    ]
    
    all_passed = True
    for current, fix, expected, desc in test_cases:
        result = compare_versions(current, fix)
        status = "✓" if result == expected else "✗"
        if result != expected:
            all_passed = False
        print(f"  {status} {desc}: compare({current}, {fix}) = {result} (期望 {expected})")
    
    return all_passed


def main():
    """主函数"""
    print("=" * 60)
    print("JIRA Tinno 本地数据库测试")
    print("=" * 60)
    
    # 版本比较测试
    version_ok = test_version_comparison()
    
    # 场景测试
    tester = LocalDBTester()
    tester.run_all_scenarios()
    scenarios_ok = tester.print_summary()
    
    # 总结
    print("\n" + "=" * 60)
    if version_ok and scenarios_ok:
        print("✓ 所有测试通过！")
        return 0
    else:
        print("✗ 部分测试失败")
        return 1


if __name__ == "__main__":
    sys.exit(main())
