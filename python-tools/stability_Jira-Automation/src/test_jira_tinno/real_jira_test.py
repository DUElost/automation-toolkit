#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
真实 JIRA 环境测试
------------------

连接 https://jira.tinno.com 的 VCAME 项目，使用真实数据验证各决策场景。
"""

from __future__ import annotations

import logging
import os
import sys
from pathlib import Path
from typing import Any, Dict, List, Optional

# 添加项目根目录到路径
PROJECT_ROOT = Path(__file__).parent.parent.parent
sys.path.insert(0, str(PROJECT_ROOT))
sys.path.insert(0, str(PROJECT_ROOT / "src"))

from dotenv import load_dotenv
load_dotenv(PROJECT_ROOT / ".env")

from src.modules.database_manager import DatabaseManager
from src.modules.decision_engine import DecisionEngine
from src.modules.data_normalizer import DataNormalizer
from src.modules.jira_executor import JIRAExecutor
from src.modules.jira_synchronizer import JIRASynchronizer
from src.modules.excel_parser import ExcelParser

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

TEST_DIR = Path(__file__).parent
# 使用主数据库而非测试数据库
DB_PATH = PROJECT_ROOT / "jira_automation.db"


class RealJiraTestRunner:
    """真实 JIRA 环境测试运行器"""
    
    def __init__(self, excel_path: str, dry_run: bool = True):
        self.excel_path = excel_path
        self.dry_run = dry_run
        self.db: Optional[DatabaseManager] = None
        self.jira_sync: Optional[JIRASynchronizer] = None
        self.decision_engine: Optional[DecisionEngine] = None
        self.executor: Optional[JIRAExecutor] = None
        self.normalizer = DataNormalizer()
        self.parser = ExcelParser()
        
    def setup(self) -> bool:
        """初始化测试环境"""
        try:
            # 初始化数据库
            db_config = {"type": "sqlite", "path": str(DB_PATH)}
            self.db = DatabaseManager(db_config)
            logger.info("数据库初始化完成: %s", DB_PATH)
            
            # 初始化 JIRA 同步器
            jira_config = {
                "url": os.getenv("JIRA_URL", "https://jira.tinno.com"),
                "username": os.getenv("JIRA_USERNAME"),
                "password": os.getenv("JIRA_PASSWORD"),
                "project_key": os.getenv("JIRA_PROJECT_KEY", "VCAME"),
                "p12_path": os.getenv("JIRA_P12_PATH"),
                "p12_password": os.getenv("JIRA_P12_PASSWORD"),
                "mode": os.getenv("JIRA_MODE", "rest"),
            }
            self.jira_sync = JIRASynchronizer(jira_config)
            
            if not self.jira_sync.is_authenticated():
                logger.error("JIRA 认证失败")
                return False
            logger.info("JIRA 连接成功: %s (项目: %s)", 
                       jira_config["url"], jira_config["project_key"])
            
            # 初始化决策引擎
            decision_config = {
                "thresholds": {
                    "env_threshold": float(os.getenv("ENV_THRESHOLD", "0.99")),
                    "cause_threshold": float(os.getenv("CAUSE_THRESHOLD", "0.90")),
                    "summary_threshold": float(os.getenv("SUMMARY_THRESHOLD", "0.85")),
                },
                "cache_enabled": False,
            }
            self.decision_engine = DecisionEngine(self.db, decision_config)
            logger.info("决策引擎初始化完成")
            
            # 初始化执行器
            executor_config = {"dry_run": self.dry_run, "max_workers": 1}
            self.executor = JIRAExecutor(
                self.jira_sync, self.decision_engine, self.db, executor_config
            )
            logger.info("执行器初始化完成 (dry_run=%s)", self.dry_run)
            
            return True
            
        except Exception as e:
            logger.exception("初始化失败: %s", e)
            return False
    
    def cleanup(self) -> None:
        """清理测试环境"""
        if self.db:
            self.db.close()
        if self.jira_sync:
            self.jira_sync.close()
        logger.info("测试环境已清理")
    
    def load_excel_data(self) -> List[Dict[str, Any]]:
        """加载 Excel 数据"""
        logger.info("加载 Excel: %s", self.excel_path)
        raw_data = self.parser.parse_excel(self.excel_path)
        logger.info("解析到 %d 条原始数据", len(raw_data))
        
        # 标准化数据
        normalized = []
        for row in raw_data:
            norm = self.normalizer.normalize(row)
            norm["package_name"] = row.get("package") or row.get("Package")
            norm["detail"] = row.get("detail") or row.get("Detail") or ""
            normalized.append(norm)
        
        logger.info("标准化完成: %d 条", len(normalized))
        return normalized
    
    def sync_existing_issues(self) -> int:
        """从现有数据库加载已存在的问题（跳过 JIRA 同步）"""
        logger.info("检查本地数据库已存在问题...")
        
        try:
            # 直接查询本地数据库中的问题数量
            rows = self.db.execute("SELECT COUNT(*) as cnt FROM jira_issues_main") or []
            count = 0
            if rows:
                row = rows[0]
                count = row.get("cnt", 0) if isinstance(row, dict) else row[0]
            
            logger.info("本地数据库已有 %d 个问题记录", count)
            return count
            
        except Exception as e:
            logger.warning("查询本地数据库失败: %s", e)
            return 0
    
    def _extract_package_from_summary(self, summary: str) -> str:
        """从摘要中提取包名"""
        # 尝试从 [自动化][...][MonkeyAEE][...] 格式提取
        import re
        match = re.search(r'\]([a-z][a-z0-9_.]+)\s', summary, re.IGNORECASE)
        if match:
            return match.group(1)
        return ""
    
    def test_decision_engine(self, data: List[Dict[str, Any]], limit: int = 5) -> None:
        """测试决策引擎"""
        logger.info("\n" + "=" * 60)
        logger.info("决策引擎测试 (前 %d 条)", limit)
        logger.info("=" * 60)
        
        # 预加载候选问题
        packages = list(set(d.get("package_name") for d in data[:limit] if d.get("package_name")))
        self.decision_engine.preload_candidates(packages)
        
        for i, issue in enumerate(data[:limit]):
            logger.info("\n--- 问题 %d ---", i + 1)
            logger.info("包名: %s", issue.get("package_name"))
            logger.info("异常: %s", issue.get("exp_class"))
            logger.info("版本: %s", issue.get("version"))
            
            decision = self.decision_engine.decide(issue)
            logger.info("决策: %s", decision.action)
            logger.info("匹配: %s (相似度: %.3f)", decision.matched_key, decision.similarity_score)
            logger.info("环境相似度: %.3f, 原因相似度: %.3f", 
                       decision.env_similarity, decision.cause_similarity)
    
    def test_full_flow(self, data: List[Dict[str, Any]], limit: int = 3) -> Dict[str, Any]:
        """测试完整流程"""
        logger.info("\n" + "=" * 60)
        logger.info("完整流程测试 (前 %d 条, dry_run=%s)", limit, self.dry_run)
        logger.info("=" * 60)
        
        # 插入待处理问题
        for issue in data[:limit]:
            pending = {
                "action": "CREATE",
                "package_name": issue.get("package_name"),
                "module": None,
                "affect_project": issue.get("affect_project"),
                "key_information": issue.get("caused_by"),
                "exp_class": issue.get("exp_class"),
                "exp_type": issue.get("exp_type"),
                "cur_process": issue.get("cur_process"),
                "version": issue.get("version"),
                "detail": issue.get("detail"),
                "caused_by": issue.get("caused_by"),
                "count": issue.get("count", 1),
                "device_count": issue.get("device_count", 1),
                "normalized_summary": issue.get("normalized_summary"),
                "test_environment": issue.get("test_environment"),
                "bug_severity": issue.get("bug_severity"),
                "priority": issue.get("priority"),
                "assignee": None,
                "jira_summary": issue.get("jira_summary"),
                "jira_description": issue.get("jira_description"),
                "ps": issue.get("ps"),
                "source_file": self.excel_path,
                "row_number": issue.get("row_number"),
                "raw_data": issue,
            }
            self.db.insert_pending_issue(pending)
        
        logger.info("已插入 %d 条待处理问题", limit)
        
        # 执行处理
        result = self.executor.process_pending_issues(limit=limit)
        
        logger.info("\n执行结果:")
        logger.info("  处理数: %d", result.get("processed_count", 0))
        logger.info("  成功数: %d", result.get("success_count", 0))
        logger.info("  失败数: %d", result.get("error_count", 0))
        
        if result.get("errors"):
            logger.warning("  错误: %s", result["errors"])
        
        return result
    
    def run(self, sync_first: bool = True, test_limit: int = 5) -> bool:
        """运行测试"""
        if not self.setup():
            return False
        
        try:
            # 同步已存在问题
            if sync_first:
                self.sync_existing_issues()
            
            # 加载测试数据
            data = self.load_excel_data()
            if not data:
                logger.error("无测试数据")
                return False
            
            # 测试决策引擎
            self.test_decision_engine(data, limit=test_limit)
            
            # 测试完整流程
            result = self.test_full_flow(data, limit=min(3, test_limit))
            
            return result.get("success", False)
            
        finally:
            self.cleanup()


def main():
    """主函数"""
    import argparse
    
    parser = argparse.ArgumentParser(description="真实 JIRA 环境测试")
    parser.add_argument(
        "--excel", 
        default="JIRA_Upload_List_20251113_222654.xlsx",
        help="测试数据 Excel 文件路径"
    )
    parser.add_argument(
        "--dry-run", 
        action="store_true", 
        default=True,
        help="干运行模式，不实际写入 JIRA"
    )
    parser.add_argument(
        "--no-dry-run", 
        action="store_true",
        help="关闭干运行模式，实际写入 JIRA"
    )
    parser.add_argument(
        "--limit", 
        type=int, 
        default=5,
        help="测试数据条数限制"
    )
    parser.add_argument(
        "--skip-sync", 
        action="store_true",
        help="跳过同步已存在问题"
    )
    
    args = parser.parse_args()
    
    # 确定 Excel 路径
    excel_path = args.excel
    if not Path(excel_path).exists():
        excel_path = PROJECT_ROOT / args.excel
        if not excel_path.exists():
            logger.error("Excel 文件不存在: %s", args.excel)
            return 1
    
    dry_run = not args.no_dry_run
    
    print("=" * 60)
    print("JIRA Tinno 真实环境测试")
    print("=" * 60)
    print(f"Excel: {excel_path}")
    print(f"Dry-run: {dry_run}")
    print(f"Limit: {args.limit}")
    print("=" * 60)
    
    runner = RealJiraTestRunner(str(excel_path), dry_run=dry_run)
    success = runner.run(sync_first=not args.skip_sync, test_limit=args.limit)
    
    return 0 if success else 1


if __name__ == "__main__":
    sys.exit(main())
