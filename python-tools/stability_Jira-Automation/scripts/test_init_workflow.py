#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
初始化阶段工作流验证脚本
------------------------

验证 AGENTS.md 中描述的初始化阶段逻辑，复用 src/main.py 的核心函数。
"""

from __future__ import annotations

import argparse
import logging
import os
import sys
from pathlib import Path

PROJECT_ROOT = Path(__file__).parent.parent
sys.path.insert(0, str(PROJECT_ROOT))
sys.path.insert(0, str(PROJECT_ROOT / "src"))

from dotenv import load_dotenv
load_dotenv(PROJECT_ROOT / ".env")

# 复用 main.py 的核心函数
from src.main import (
    parse_jira_host,
    build_jql,
    sync_jira_to_local,
    load_title_keywords,
    build_jira_config,
)
from src.modules.config_loader import ConfigLoader
from src.modules.database_manager import DatabaseManager
from src.modules.jira_synchronizer import JIRASynchronizer

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)


def get_db_path(jira_url: str, project_key: str) -> str:
    """根据 JIRA 系统和项目库生成数据库路径"""
    jira_host = parse_jira_host(jira_url)
    db_dir = PROJECT_ROOT / "db"
    db_dir.mkdir(parents=True, exist_ok=True)
    return str(db_dir / f"{jira_host}_{project_key}.db")


def show_database_summary(db: DatabaseManager):
    """显示数据库汇总信息"""
    print()
    print("=" * 60)
    print("数据库汇总")
    print("=" * 60)
    
    rows = db.execute("SELECT COUNT(*) as cnt FROM jira_issues_main") or []
    total = dict(rows[0])['cnt'] if rows else 0
    
    status_rows = db.execute(
        "SELECT status, COUNT(*) as cnt FROM jira_issues_main GROUP BY status"
    ) or []
    
    print(f"\n问题总数: {total}")
    print("\n按状态统计:")
    for row in status_rows:
        r = dict(row)
        print(f"  {r['status'] or '未知'}: {r['cnt']}")
    
    regression_rows = db.execute(
        "SELECT COUNT(*) as cnt FROM jira_issues_main "
        "WHERE status IN ('Resolved', '已解决', 'Verified', '已验证')"
    ) or []
    regression_count = dict(regression_rows[0])['cnt'] if regression_rows else 0
    print(f"\n回归验证候选: {regression_count}")
    
    recent = db.execute(
        "SELECT jira_key, status, summary "
        "FROM jira_issues_main ORDER BY created_at DESC LIMIT 5"
    ) or []
    
    if recent:
        print("\n最近同步的问题:")
        for row in recent:
            r = dict(row)
            summary_short = r['summary'][:40] + "..." if len(r['summary']) > 40 else r['summary']
            print(f"  {r['jira_key']}: {r['status']} - {summary_short}")


def main():
    parser = argparse.ArgumentParser(description="初始化阶段工作流验证")
    parser.add_argument("--jira-url", default=os.getenv("JIRA_URL"), help="JIRA 系统 URL")
    parser.add_argument("--project", default=os.getenv("JIRA_PROJECT_KEY", "VCAME"), help="项目库 Key")
    parser.add_argument("--keywords", nargs="+", help="标题筛选关键字（默认从配置文件读取）")
    parser.add_argument("--max-results", type=int, default=100, help="最大同步数量")
    parser.add_argument("--skip-sync", action="store_true", help="跳过 JIRA 同步")
    args = parser.parse_args()
    
    # 加载标题关键字
    keywords = args.keywords or load_title_keywords()
    
    print()
    print("=" * 60)
    print("初始化阶段工作流验证")
    print("=" * 60)
    
    # Phase 1.1: 解析配置
    print(f"\n[1/4] 解析配置")
    print(f"  JIRA URL: {args.jira_url}")
    print(f"  项目库: {args.project}")
    print(f"  标题关键字: {keywords}")
    
    # Phase 1.2: 数据库定位
    print(f"\n[2/4] 数据库定位")
    db_path = get_db_path(args.jira_url, args.project)
    print(f"  数据库路径: {db_path}")
    print(f"  数据库存在: {Path(db_path).exists()}")
    
    db = DatabaseManager({"type": "sqlite", "path": db_path})
    logger.info("数据库初始化完成: %s", db_path)
    
    # Phase 1.3: JIRA 连接
    print(f"\n[3/4] JIRA 连接")
    
    config_loader = ConfigLoader(str(PROJECT_ROOT / ".env"))
    jira_config = config_loader.get_jira_config()
    jira_config.update({
        "url": args.jira_url,
        "username": os.getenv("JIRA_USERNAME"),
        "password": os.getenv("JIRA_PASSWORD"),
        "p12_path": os.getenv("JIRA_P12_PATH"),
        "p12_password": os.getenv("JIRA_P12_PASSWORD"),
        "project_key": args.project,
        "mode": "rest",
    })
    
    jira_sync = JIRASynchronizer(jira_config)
    
    if not jira_sync.is_authenticated():
        print("  JIRA 认证失败，退出")
        db.close()
        return 1
    
    print(f"  认证状态: 成功")
    print(f"  运行模式: {jira_sync.mode}")
    
    # Phase 1.4: 数据同步（复用 main.py 的 sync_jira_to_local）
    print(f"\n[4/4] 数据同步")
    if args.skip_sync:
        print("  跳过 JIRA 同步")
        synced = 0
    else:
        synced = sync_jira_to_local(
            jira_sync, db, args.project, keywords, args.max_results
        )
        print(f"  同步完成: {synced} 个问题")
    
    # 显示数据库汇总
    show_database_summary(db)
    
    # 清理
    jira_sync.close()
    db.close()
    
    print()
    print("=" * 60)
    print("初始化阶段完成")
    print("=" * 60)
    print(f"  数据库: {db_path}")
    print(f"  同步问题数: {synced}")
    
    return 0


if __name__ == "__main__":
    sys.exit(main())
