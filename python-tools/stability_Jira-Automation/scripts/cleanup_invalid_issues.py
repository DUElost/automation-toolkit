#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
清理数据库中不符合标题关键字条件的问题
"""

from __future__ import annotations

import argparse
import logging
import sys
from pathlib import Path
from typing import List

PROJECT_ROOT = Path(__file__).parent.parent
sys.path.insert(0, str(PROJECT_ROOT))
sys.path.insert(0, str(PROJECT_ROOT / "src"))

from src.modules.database_manager import DatabaseManager

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)


def cleanup_invalid_issues(db_path: str, keywords: List[str], dry_run: bool = True) -> int:
    """
    清理标题不同时包含所有关键字的问题。
    
    Args:
        db_path: 数据库路径
        keywords: 必须同时包含的关键字列表
        dry_run: 是否为试运行模式
    
    Returns:
        删除的问题数量
    """
    db = DatabaseManager({"type": "sqlite", "path": db_path})
    
    # 查询所有问题
    rows = db.execute("SELECT jira_key, summary FROM jira_issues_main") or []
    
    invalid_keys = []
    for row in rows:
        r = dict(row)
        jira_key = r.get("jira_key")
        summary = r.get("summary") or ""
        
        # 检查是否同时包含所有关键字
        if not all(keyword in summary for keyword in keywords):
            invalid_keys.append(jira_key)
            logger.info("不符合条件: %s - %s", jira_key, summary[:60])
    
    print(f"\n找到 {len(invalid_keys)} 个不符合条件的问题")
    
    if invalid_keys and not dry_run:
        for jira_key in invalid_keys:
            db.execute("DELETE FROM jira_issues_main WHERE jira_key = ?", (jira_key,))
        print(f"已删除 {len(invalid_keys)} 个问题")
    elif invalid_keys:
        print("(dry-run 模式，未实际删除)")
    
    db.close()
    return len(invalid_keys)


def main():
    parser = argparse.ArgumentParser(description="清理不符合标题关键字条件的问题")
    parser.add_argument("--db", default="db/tinno_VCAME.db", help="数据库路径")
    parser.add_argument("--keywords", nargs="+", default=["[自动化]", "[V551A]", "[MonkeyAEE]"],
                        help="必须同时包含的关键字")
    parser.add_argument("--execute", action="store_true", help="实际执行删除")
    args = parser.parse_args()
    
    print(f"数据库: {args.db}")
    print(f"关键字: {args.keywords}")
    print(f"模式: {'执行删除' if args.execute else 'dry-run'}")
    print()
    
    cleanup_invalid_issues(args.db, args.keywords, dry_run=not args.execute)


if __name__ == "__main__":
    main()
