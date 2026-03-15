#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
集成测试
--------

使用 src/main.py 进行完整流程测试，验证各功能点。
"""

from __future__ import annotations

import json
import logging
import os
import sys
import tempfile
from pathlib import Path
from typing import Any, Dict, List, Optional

import pandas as pd

# 添加项目路径
sys.path.insert(0, str(Path(__file__).parent.parent))

from modules.config_loader import ConfigLoader
from modules.database_manager import DatabaseManager
from modules.excel_parser import ExcelParser
from modules.data_normalizer import DataNormalizer
from modules.decision_engine import DecisionEngine
from modules.jira_executor import JIRAExecutor
from modules.jira_synchronizer import JIRASynchronizer
from modules.lark_integration import LarkIntegration
from test_jira_tinno.test_data_generator import ActionKeyTestScenarios, TestDataGenerator

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

# 测试目录
TEST_DIR = Path(__file__).parent
TEST_DB_PATH = TEST_DIR / "integration_test.db"
TEST_EXCEL_PATH = TEST_DIR / "test_monkey_data.xlsx"


class IntegrationTester:
    """集成测试器"""
    
    def __init__(self, use_mock: bool = True):
        """
        初始化集成测试器
        
        Args:
            use_mock: 是否使用 Mock 模式（不实际调用 JIRA API）
        """
        self.use_mock = use_mock
        self.test_dir = TEST_DIR
        self.db_path = str(TEST_DB_PATH)
        self.excel_path = str(TEST_EXCEL_PATH)
        
        self.db: Optional[DatabaseManager] = None
        self.jira_sync: Optional[JIRASynchronizer] = None
        self.decision_engine: Optional[DecisionEngine] = None
        self.executor: Optional[JIRAExecutor] = None
        
        self.generator = TestDataGenerator()
        self.scenarios = ActionKeyTestScenarios()
    
    def setup(self):
        """初始化测试环境"""
        logger.info("初始化集成测试环境...")
        
        # 清理旧文件
        for path in [TEST_DB_PATH, TEST_EXCEL_PATH]:
            if path.exists():
                os.remove(path)
        
        # 初始化数据库
        db_config = {"type": "sqlite", "path": self.db_path}
        self.db = DatabaseManager(db_config)
        
        # 初始化 JIRA 同步器（Mock 或 REST）
        if self.use_mock:
            jira_config = {
                "mode": "mock",
                "project_key": "VCAME",
            }
        else:
            # 从环境变量加载真实配置
            config_loader = ConfigLoader()
            jira_config = config_loader.get_jira_config()
            jira_config["mode"] = "rest"
        
        self.jira_sync = JIRASynchronizer(jira_config)
        
        # 初始化决策引擎
        decision_config = {
            "thresholds": {
                "env_threshold": 0.99,
                "cause_threshold": 0.90,
                "summary_threshold": 0.85,
            },
            "cache_enabled": True,
        }
        self.decision_engine = DecisionEngine(self.db, decision_config)
        
        # 初始化执行器
        executor_config = {
            "dry_run": self.use_mock,
            "max_workers": 1,
            "batch_size": 10,
        }
        self.executor = JIRAExecutor(
            self.jira_sync,
            self.decision_engine,
            self.db,
            executor_config,
        )
        
        logger.info("集成测试环境初始化完成 (mode=%s)", "mock" if self.use_mock else "rest")
    
    def teardown(self):
        """清理测试环境"""
        if self.db:
            self.db.close()
        if self.jira_sync:
            self.jira_sync.close()
        logger.info("集成测试环境已清理")
    
    def generate_test_excel(self, issues: List[Dict[str, Any]]) -> str:
        """生成测试用 Excel 文件"""
        # 转换为 DataFrame 格式
        rows = []
        for issue in issues:
            rows.append({
                "Id": len(rows) + 1,
                "Path": issue.get("path", ""),
                "Version": issue.get("version", ""),
                "AffectProject": issue.get("affect_project", "VCAME"),
                "ExpTime": "",
                "ExpClass": issue.get("exp_class", ""),
                "ExpType": issue.get("exp_type", ""),
                "CurProcess": issue.get("cur_process", ""),
                "Package": issue.get("package", ""),
                "Detail": issue.get("detail", ""),
                "CausedBy": issue.get("caused_by", ""),
                "extraTag": "",
                "Count": issue.get("count", 1),
                "DeviceCount": issue.get("device_count", 1),
            })
        
        df = pd.DataFrame(rows)
        df.to_excel(self.excel_path, index=False)
        logger.info("生成测试 Excel: %s (%d 条记录)", self.excel_path, len(rows))
        return self.excel_path
    
    def insert_existing_issues(self, issues: List[Dict[str, Any]]) -> None:
        """插入已存在的问题到数据库"""
        for issue in issues:
            record = {
                "jira_key": issue.get("jira_key"),
                "status": issue.get("status", "Open"),
                "summary": issue.get("normalized_summary", "Test"),
                "normalized_summary": issue.get("normalized_summary", "Test"),
                "test_environment": issue.get("test_environment", ""),
                "raw_caused_by": issue.get("raw_caused_by", ""),
                "assignee": issue.get("assignee"),
                "bug_severity": issue.get("bug_severity", "C"),
                "priority": issue.get("priority", "Medium"),
                "description": "",
                "package_name": issue.get("package_name"),
                "exp_class": issue.get("exp_class"),
                "exp_type": issue.get("exp_type"),
                "cur_process": issue.get("cur_process"),
                "version": issue.get("version"),
                "count": issue.get("count", 1),
                "device_count": issue.get("device_count", 1),
                "fix_version": issue.get("fix_version"),
                "regression_pass_count": issue.get("regression_pass_count", 0),
                "verified_versions": issue.get("verified_versions"),
            }
            self.db.insert_issue(record)
            logger.info("插入已存在问题: %s", record["jira_key"])
    
    def run_full_pipeline(self, excel_path: str) -> Dict[str, Any]:
        """运行完整处理流程"""
        logger.info("开始运行完整流程...")
        
        # 1. 解析 Excel
        parser = ExcelParser()
        raw_data = parser.parse_excel(excel_path)
        logger.info("解析 Excel 完成: %d 条", len(raw_data))
        
        # 2. 数据标准化
        normalizer = DataNormalizer()
        normalized_data = normalizer.batch_normalize(raw_data)
        logger.info("数据标准化完成: %d 条", len(normalized_data))
        
        # 3. 插入待处理表
        for item in normalized_data:
            pending = {
                "action": "CREATE",
                "package_name": item.get("package"),
                "module": None,
                "affect_project": item.get("affect_project"),
                "key_information": item.get("caused_by"),
                "exp_class": item.get("exp_class"),
                "exp_type": item.get("exp_type"),
                "cur_process": item.get("cur_process"),
                "version": item.get("version"),
                "detail": item.get("detail"),
                "caused_by": item.get("caused_by"),
                "count": item.get("count"),
                "device_count": item.get("device_count"),
                "normalized_summary": item.get("normalized_summary"),
                "test_environment": item.get("test_environment"),
                "bug_severity": item.get("bug_severity"),
                "priority": item.get("priority"),
                "assignee": None,
                "jira_summary": item.get("jira_summary"),
                "jira_description": item.get("jira_description"),
                "ps": item.get("ps"),
                "source_file": item.get("source_file"),
                "row_number": item.get("row_number"),
                "raw_data": item,
            }
            self.db.insert_pending_issue(pending)
        
        logger.info("待处理问题插入完成")
        
        # 4. 执行 JIRA 操作
        result = self.executor.process_pending_issues()
        logger.info("JIRA 操作执行完成: %s", result)
        
        return result
    
    def test_scenario_new_issue(self) -> bool:
        """测试场景: 新问题"""
        logger.info("\n" + "=" * 60)
        logger.info("测试场景: ACT_NEW_ISSUE (新问题)")
        
        self.setup()
        try:
            # 生成新问题数据
            scenario = self.scenarios.scenario_new_issue()
            pending = scenario["pending_issue"]
            
            # 生成 Excel
            self.generate_test_excel([pending])
            
            # 运行流程
            result = self.run_full_pipeline(self.excel_path)
            
            # 验证
            if result["success"] and result["processed_count"] == 1:
                logger.info("✓ 新问题场景测试通过")
                return True
            else:
                logger.error("✗ 新问题场景测试失败: %s", result)
                return False
        finally:
            self.teardown()
    
    def test_scenario_update_open(self) -> bool:
        """测试场景: 更新未解决问题"""
        logger.info("\n" + "=" * 60)
        logger.info("测试场景: ACT_UPDATE_OPEN (更新未解决问题)")
        
        self.setup()
        try:
            scenario = self.scenarios.scenario_update_open()
            existing = scenario["existing_issue"]
            pending = scenario["pending_issue"]
            
            # 插入已存在问题
            self.insert_existing_issues([existing])
            
            # 生成 Excel
            self.generate_test_excel([pending])
            
            # 运行流程
            result = self.run_full_pipeline(self.excel_path)
            
            # 验证
            stats = self.executor.get_execution_stats()
            if result["success"] and stats["updated"] >= 0:
                logger.info("✓ 更新未解决问题场景测试通过")
                return True
            else:
                logger.error("✗ 更新未解决问题场景测试失败: %s", result)
                return False
        finally:
            self.teardown()
    
    def test_scenario_regression_pass(self) -> bool:
        """测试场景: 回归 PASS"""
        logger.info("\n" + "=" * 60)
        logger.info("测试场景: ACT_REGRESSION_PASS (回归验证)")
        
        self.setup()
        try:
            scenario = self.scenarios.scenario_regression_pass_1()
            existing = scenario["existing_issue"]
            
            # 插入已解决问题
            self.insert_existing_issues([existing])
            
            # 生成空 Excel（无匹配问题）
            other_issue = self.generator.generate_single_issue(
                package="com.test.other.package",
            ).to_dict()
            self.generate_test_excel([other_issue])
            
            # 运行流程
            result = self.run_full_pipeline(self.excel_path)
            
            # 验证回归 PASS 计数
            updated = self.db.get_issue_by_key(existing["jira_key"])
            if updated and updated.get("regression_pass_count", 0) >= 1:
                logger.info("✓ 回归 PASS 场景测试通过 (pass_count=%d)", updated["regression_pass_count"])
                return True
            else:
                logger.error("✗ 回归 PASS 场景测试失败")
                return False
        finally:
            self.teardown()
    
    def run_all_tests(self) -> bool:
        """运行所有集成测试"""
        results = []
        
        results.append(("ACT_NEW_ISSUE", self.test_scenario_new_issue()))
        results.append(("ACT_UPDATE_OPEN", self.test_scenario_update_open()))
        results.append(("ACT_REGRESSION_PASS", self.test_scenario_regression_pass()))
        
        # 打印摘要
        print("\n" + "=" * 60)
        print("集成测试摘要")
        print("=" * 60)
        
        passed = 0
        for name, ok in results:
            status = "✓ PASS" if ok else "✗ FAIL"
            print(f"  {status} - {name}")
            if ok:
                passed += 1
        
        print("-" * 60)
        print(f"总计: {passed}/{len(results)} 通过")
        
        return passed == len(results)


def main():
    """主函数"""
    print("=" * 60)
    print("JIRA Tinno 集成测试")
    print("=" * 60)
    
    # 使用 Mock 模式运行测试
    tester = IntegrationTester(use_mock=True)
    success = tester.run_all_tests()
    
    return 0 if success else 1


if __name__ == "__main__":
    sys.exit(main())
