#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""检查数据库中的 summary 字段"""

import sys
from pathlib import Path

PROJECT_ROOT = Path(__file__).parent.parent
sys.path.insert(0, str(PROJECT_ROOT))
sys.path.insert(0, str(PROJECT_ROOT / "src"))

from src.modules.database_manager import DatabaseManager


def main():
    db = DatabaseManager({"type": "sqlite", "path": str(PROJECT_ROOT / "jira_automation.db")})
    
    # 查看最近创建的问题的 summary
    rows = db.execute("""
        SELECT jira_key, status, summary 
        FROM jira_issues_main 
        WHERE jira_key LIKE 'VCAME-%' 
        ORDER BY CAST(SUBSTR(jira_key, 7) AS INTEGER) DESC 
        LIMIT 5
    """) or []
    
    print("最近创建的问题 summary:")
    for r in rows:
        d = dict(r)
        jira_key = d.get("jira_key")
        status = d.get("status")
        summary = d.get("summary") or "NULL"
        print(f"{jira_key}: {status}")
        print(f"  summary: {summary[:100] if summary else 'NULL'}...")
        
        # 检查是否包含关键字
        keywords = ["[自动化]", "[V551A]", "[MonkeyAEE]"]
        has_all = all(kw in (summary or "") for kw in keywords)
        print(f"  包含所有关键字: {has_all}")
        print()
    
    db.close()


if __name__ == "__main__":
    main()
