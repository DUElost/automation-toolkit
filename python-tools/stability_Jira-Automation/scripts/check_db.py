#!/usr/bin/env python3
import sqlite3

conn = sqlite3.connect('jira_automation.db')
conn.row_factory = sqlite3.Row

# 查看 Open 状态问题详情
cursor = conn.execute("SELECT jira_key, package_name, test_environment, raw_caused_by FROM jira_issues_main WHERE status = 'Open'")
print("Open 状态问题详情:")
for row in cursor:
    print(f"Key: {row['jira_key']}")
    print(f"Package: {row['package_name']}")
    env = row['test_environment'] or ''
    print(f"Env: {env[:200]}")
    caused = row['raw_caused_by'] or ''
    print(f"CausedBy: {caused[:200]}")
    print("---")

conn.close()
