#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
完整两轮验证测试
---------------

使用真实测试数据进行两轮上传验证：
- 第1轮: Result_None_None_MonkeyAEE_SH_20251117.xls
- 第2轮: Result_None_None_MonkeyAEE_SH_20251118_org.xls

验证场景：
1. CREATE - 新建问题
2. UPDATE - 更新问题计数
3. REOPEN - 重新打开已解决问题
4. COMMENT - Won't Fix 添加备注
5. IGNORE - 已关闭问题忽略
6. REGRESSION_PASS - 回归PASS记录
"""

from __future__ import annotations

import argparse
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

from src.modules.config_loader import ConfigLoader
from src.modules.excel_parser import ExcelParser
from src.modules.data_normalizer import DataNormalizer
from src.modules.lark_integration import LarkIntegration
from src.modules.database_manager import DatabaseManager
from src.modules.jira_synchronizer import JIRASynchronizer
from src.modules.decision_engine import DecisionEngine
from src.modules.jira_executor import JIRAExecutor

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)


def run_round(excel_file: str, round_num: int, dry_run: bool = True) -> Dict[str, Any]:
    """
    执行一轮测试
    
    Args:
        excel_file: Excel 文件路径
        round_num: 轮次编号
        dry_run: 是否为试运行模式
    
    Returns:
        执行结果统计
    """
    print()
    print("=" * 70)
    print(f"第 {round_num} 轮测试: {Path(excel_file).name}")
    print(f"模式: {'DRY-RUN (不实际写入JIRA)' if dry_run else 'REAL (实际写入JIRA)'}")
    print("=" * 70)
    
    # 加载配置
    config_loader = ConfigLoader(str(PROJECT_ROOT / ".env"))
    
    # 初始化数据库
    db_config = {
        "type": "sqlite",
        "path": str(PROJECT_ROOT / "jira_automation.db"),
    }
    db = DatabaseManager(db_config)
    
    # 初始化模块
    excel_parser = ExcelParser()
    data_normalizer = DataNormalizer()
    
    # 初始化飞书集成
    lark_config = config_loader.get_lark_config()
    lark_integration = LarkIntegration(lark_config)
    
    # 解析 Excel
    print(f"\n[1/4] 解析 Excel 文件...")
    raw_data = excel_parser.parse_excel(excel_file)
    print(f"  解析完成: {len(raw_data)} 条数据")
    
    # 数据标准化
    print(f"\n[2/4] 数据标准化...")
    normalized_data = data_normalizer.batch_normalize(raw_data)
    print(f"  标准化完成: {len(normalized_data)} 条数据")
    
    # 准备待处理问题
    print(f"\n[3/4] 准备待处理问题...")
    
    # 清空待处理表
    db.execute("DELETE FROM pending_issues")
    
    pending_count = 0
    for item in normalized_data:
        # 获取模块和经办人
        module = lark_integration.get_module_by_package(item.get('package', ''))
        assignee = lark_integration.get_assignee_by_module(module)
        
        pending_issue = {
            'action': 'CREATE',
            'package_name': item.get('package'),
            'module': module,
            'key_information': item.get('key_information'),
            'exp_class': item.get('exp_class'),
            'exp_type': item.get('exp_type'),
            'cur_process': item.get('cur_process'),
            'version': item.get('version'),
            'detail': item.get('detail'),
            'caused_by': item.get('caused_by'),
            'count': item.get('count'),
            'device_count': item.get('device_count'),
            'normalized_summary': item.get('normalized_summary'),
            'test_environment': item.get('test_environment'),
            'bug_severity': item.get('bug_severity'),
            'priority': item.get('priority'),
            'assignee': assignee,
            'jira_summary': item.get('jira_summary'),
            'jira_description': item.get('jira_description'),
            'ps': item.get('ps'),
            'affect_project': item.get('affect_project'),
            'source_file': Path(excel_file).name,
            'row_number': item.get('row_number', 0),
        }
        
        try:
            db.insert_pending_issue(pending_issue)
            pending_count += 1
        except Exception as e:
            logger.warning("插入待处理问题失败: %s", e)
    
    print(f"  待处理问题: {pending_count} 条")
    
    # 执行 JIRA 操作
    print(f"\n[4/4] 执行 JIRA 操作...")
    
    # 从 ConfigLoader 获取完整的 JIRA 配置（包含 custom_fields 和 components_map）
    jira_config = config_loader.get_jira_config()
    # 覆盖环境变量中的配置
    jira_config.update({
        "url": os.getenv("JIRA_URL"),
        "username": os.getenv("JIRA_USERNAME"),
        "password": os.getenv("JIRA_PASSWORD"),
        "p12_path": os.getenv("JIRA_P12_PATH"),
        "p12_password": os.getenv("JIRA_P12_PASSWORD"),
        "project_key": os.getenv("JIRA_PROJECT_KEY", "VCAME"),
        "mode": "rest",
    })
    
    jira_sync = JIRASynchronizer(jira_config)
    if not jira_sync.is_authenticated():
        print("  JIRA 认证失败!")
        db.close()
        return {"success": False, "error": "JIRA认证失败"}
    
    # 初始化决策引擎
    decision_config = {
        "thresholds": {
            "env_threshold": float(os.getenv("ENV_THRESHOLD", "0.99")),
            "cause_threshold": float(os.getenv("CAUSE_THRESHOLD", "0.90")),
            "summary_threshold": float(os.getenv("SUMMARY_THRESHOLD", "0.85")),
        },
        "cache_enabled": True,
    }
    engine = DecisionEngine(db, decision_config)
    
    # 初始化执行器
    executor_config = {
        "dry_run": dry_run,
        "max_workers": 3,
        "batch_size": 50,
    }
    executor = JIRAExecutor(jira_sync, engine, db, executor_config)
    
    # 执行处理
    result = executor.process_pending_issues()
    stats = executor.get_execution_stats()
    
    print(f"\n执行结果:")
    print(f"  处理数: {result['processed_count']}")
    print(f"  成功数: {result['success_count']}")
    print(f"  失败数: {result['error_count']}")
    print(f"  创建: {stats['created']}")
    print(f"  更新: {stats['updated']}")
    print(f"  回归关闭: {stats.get('regression_closed', 0)}")
    
    if result.get('errors'):
        print(f"\n错误详情:")
        for err in result['errors'][:5]:
            print(f"  - {err}")
    
    jira_sync.close()
    db.close()
    
    return {
        "success": result['success'],
        "round": round_num,
        "file": Path(excel_file).name,
        "raw_count": len(raw_data),
        "normalized_count": len(normalized_data),
        "pending_count": pending_count,
        "processed_count": result['processed_count'],
        "success_count": result['success_count'],
        "error_count": result['error_count'],
        "created": stats['created'],
        "updated": stats['updated'],
        "regression_closed": stats.get('regression_closed', 0),
    }


def show_database_summary():
    """显示数据库汇总"""
    print()
    print("=" * 70)
    print("数据库汇总")
    print("=" * 70)
    
    db_config = {"type": "sqlite", "path": str(PROJECT_ROOT / "jira_automation.db")}
    db = DatabaseManager(db_config)
    
    # 统计主表
    rows = db.execute("SELECT COUNT(*) as cnt FROM jira_issues_main") or []
    total = rows[0]['cnt'] if rows else 0
    
    # 按状态统计
    status_rows = db.execute(
        "SELECT status, COUNT(*) as cnt FROM jira_issues_main GROUP BY status"
    ) or []
    
    print(f"\n主表问题总数: {total}")
    print("\n按状态统计:")
    for row in status_rows:
        r = dict(row)
        print(f"  {r['status'] or '未知'}: {r['cnt']}")
    
    # 最近创建的问题
    recent = db.execute(
        "SELECT jira_key, status, package_name, created_at "
        "FROM jira_issues_main ORDER BY created_at DESC LIMIT 10"
    ) or []
    
    print("\n最近创建的问题:")
    for row in recent:
        r = dict(row)
        print(f"  {r['jira_key']}: {r['status']} - {r['package_name']}")
    
    db.close()


def main():
    parser = argparse.ArgumentParser(description="完整两轮验证测试")
    parser.add_argument("--round", type=int, choices=[1, 2], help="只运行指定轮次")
    parser.add_argument("--real", action="store_true", help="真实执行（非 dry-run）")
    parser.add_argument("--summary", action="store_true", help="只显示数据库汇总")
    args = parser.parse_args()
    
    if args.summary:
        show_database_summary()
        return 0
    
    # 测试数据文件
    test_files = [
        str(PROJECT_ROOT / "config" / "Result_None_None_MonkeyAEE_SH_20251117.xls"),
        str(PROJECT_ROOT / "config" / "Result_None_None_MonkeyAEE_SH_20251118_org.xls"),
    ]
    
    # 检查文件存在
    for f in test_files:
        if not Path(f).exists():
            print(f"错误: 文件不存在 - {f}")
            return 1
    
    results = []
    dry_run = not args.real
    
    if args.round:
        # 只运行指定轮次
        idx = args.round - 1
        result = run_round(test_files[idx], args.round, dry_run)
        results.append(result)
    else:
        # 运行两轮
        for i, excel_file in enumerate(test_files, 1):
            result = run_round(excel_file, i, dry_run)
            results.append(result)
    
    # 汇总
    print()
    print("=" * 70)
    print("测试汇总")
    print("=" * 70)
    print()
    print(f"{'轮次':<6} {'文件':<45} {'处理':<6} {'创建':<6} {'更新':<6} {'结果':<8}")
    print("-" * 70)
    for r in results:
        status = "✓ PASS" if r['success'] else "✗ FAIL"
        print(f"{r['round']:<6} {r['file']:<45} {r['processed_count']:<6} {r['created']:<6} {r['updated']:<6} {status:<8}")
    print("-" * 70)
    
    # 显示数据库汇总
    show_database_summary()
    
    return 0 if all(r['success'] for r in results) else 1


if __name__ == "__main__":
    sys.exit(main())
