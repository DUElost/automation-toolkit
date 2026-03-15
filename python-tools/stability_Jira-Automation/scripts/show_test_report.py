#!/usr/bin/env python3
"""显示测试报告"""
import sqlite3

conn = sqlite3.connect('jira_automation.db')
conn.row_factory = sqlite3.Row

print("=" * 60)
print("真实 JIRA 环境测试清单")
print("=" * 60)
print()
print("【测试说明】")
print("- DRY-* 问题：dry-run 模式下模拟创建，仅存在于本地数据库")
print("- VCAME-TEST-* 问题：本地测试数据，用于验证决策逻辑")
print("- VCAME-268：真实写入测试创建的问题")
print()

# DryRun 状态问题
cursor = conn.execute(
    "SELECT jira_key, package_name FROM jira_issues_main WHERE status = 'DryRun'"
)
rows = list(cursor)
print(f"【模拟创建的问题】共 {len(rows)} 个")
for row in rows:
    print(f"  {row['jira_key']} | {row['package_name']}")

print()

# 测试问题
cursor = conn.execute(
    "SELECT jira_key, status, package_name FROM jira_issues_main WHERE jira_key LIKE 'VCAME-TEST-%'"
)
rows = list(cursor)
print(f"【测试用问题】共 {len(rows)} 个")
for row in rows:
    print(f"  {row['jira_key']} | {row['status']} | {row['package_name']}")

print()

# 真实问题
cursor = conn.execute(
    "SELECT jira_key, status, package_name FROM jira_issues_main "
    "WHERE jira_key LIKE 'VCAME-%' AND jira_key NOT LIKE 'VCAME-TEST-%' "
    "AND status NOT IN ('DryRun', 'Pending Upload')"
)
rows = list(cursor)
print(f"【真实 JIRA 问题】共 {len(rows)} 个")
for row in rows:
    note = " ← 真实写入测试创建" if row['jira_key'] == 'VCAME-268' else ""
    print(f"  {row['jira_key']} | {row['status']} | {row['package_name']}{note}")

conn.close()
