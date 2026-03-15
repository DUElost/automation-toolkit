#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""检查数据库中问题的状态"""

import sys
from pathlib import Path

PROJECT_ROOT = Path(__file__).parent.parent
sys.path.insert(0, str(PROJECT_ROOT))
sys.path.insert(0, str(PROJECT_ROOT / "src"))

from src.modules.database_manager import DatabaseManager

db = DatabaseManager({'type': 'sqlite', 'path': str(PROJECT_ROOT / 'jira_automation.db')})

# 查看所有问题的状态
print('=== 数据库中所有问题的状态 ===')
rows = db.execute('SELECT jira_key, status, summary, regression_pass_count FROM jira_issues_main ORDER BY jira_key') or []
for row in rows:
    r = dict(row)
    summary = (r.get('summary') or '')[:60]
    pass_count = r.get('regression_pass_count', 0)
    print(f"{r['jira_key']}: {r['status']} | pass_count={pass_count} | {summary}...")

print()
print('=== 按状态统计 ===')
status_rows = db.execute('SELECT status, COUNT(*) as cnt FROM jira_issues_main GROUP BY status') or []
for row in status_rows:
    r = dict(row)
    print(f"  {r['status'] or '未知'}: {r['cnt']}")

# 检查已解决状态的问题
print()
print('=== 已解决状态的问题（回归验证候选） ===')
resolved_rows = db.execute(
    "SELECT jira_key, status, summary, regression_pass_count FROM jira_issues_main "
    "WHERE status IN ('Resolved','已解决','Verified','已验证')"
) or []
if resolved_rows:
    for row in resolved_rows:
        r = dict(row)
        summary = (r.get('summary') or '')[:60]
        print(f"  {r['jira_key']}: {r['status']} | {summary}...")
else:
    print("  无已解决状态的问题")

db.close()
