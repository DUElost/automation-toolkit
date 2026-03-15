#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""检查数据库中的 resolution 字段"""

import sqlite3

conn = sqlite3.connect('db/tinno_VCAME.db')
cursor = conn.cursor()

# 检查有 resolution 的问题
cursor.execute('''
    SELECT jira_key, status, resolution 
    FROM jira_issues_main 
    WHERE resolution IS NOT NULL AND resolution != ''
''')
rows = cursor.fetchall()
print(f"有 resolution 的问题: {len(rows)}")
for r in rows:
    print(f"  {r[0]}: {r[1]} ({r[2]})")

print()

# 检查已解决状态的问题
cursor.execute('''
    SELECT jira_key, status, resolution 
    FROM jira_issues_main 
    WHERE status IN ('已解决', 'Resolved', '已关闭', 'Closed')
''')
rows = cursor.fetchall()
print(f"已解决/已关闭状态的问题: {len(rows)}")
for r in rows:
    print(f"  {r[0]}: {r[1]} ({r[2] or '无resolution'})")

conn.close()
