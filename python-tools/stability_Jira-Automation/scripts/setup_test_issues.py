#!/usr/bin/env python3
"""设置各种状态的测试问题用于验证决策场景"""
import sqlite3
import json

conn = sqlite3.connect('jira_automation.db')

# 测试问题数据
test_issues = [
    {
        "jira_key": "VCAME-TEST-OPEN-001",
        "status": "Open",
        "summary": "[自动化][V551A][MonkeyAEE][NPE]com.test.scenario.open发生NPE",
        "package_name": "com.test.scenario.open",
        "normalized_summary": "[自动化][V551A][MonkeyAEE][NPE]com.test.scenario.open发生NPE",
        "test_environment": "*Package:* com.test.scenario.open\n*ExpClass:* java.lang.NullPointerException\n*ExpType:* NPE\n*CurProcess:* com.test.scenario.open",
        "raw_caused_by": "Caused by: java.lang.NullPointerException\n\tat com.test.scenario.open.MainActivity.onCreate(MainActivity.java:100)",
        "bug_severity": "B",
        "fix_version": None,
        "regression_pass_count": 0,
    },
    {
        "jira_key": "VCAME-TEST-WONTFIX-001",
        "status": "Won't Fix",
        "summary": "[自动化][V551A][MonkeyAEE][ISE]com.test.scenario.wontfix发生ISE",
        "package_name": "com.test.scenario.wontfix",
        "normalized_summary": "[自动化][V551A][MonkeyAEE][ISE]com.test.scenario.wontfix发生ISE",
        "test_environment": "*Package:* com.test.scenario.wontfix\n*ExpClass:* java.lang.IllegalStateException\n*ExpType:* ISE\n*CurProcess:* com.test.scenario.wontfix",
        "raw_caused_by": "Caused by: java.lang.IllegalStateException\n\tat com.test.scenario.wontfix.Service.onStart(Service.java:200)",
        "bug_severity": "C",
        "fix_version": None,
        "regression_pass_count": 0,
    },
    {
        "jira_key": "VCAME-TEST-RESOLVED-001",
        "status": "Resolved",
        "summary": "[自动化][V551A][MonkeyAEE][RTE]com.test.scenario.resolved发生RTE",
        "package_name": "com.test.scenario.resolved",
        "normalized_summary": "[自动化][V551A][MonkeyAEE][RTE]com.test.scenario.resolved发生RTE",
        "test_environment": "*Package:* com.test.scenario.resolved\n*ExpClass:* java.lang.RuntimeException\n*ExpType:* RTE\n*CurProcess:* com.test.scenario.resolved",
        "raw_caused_by": "Caused by: java.lang.RuntimeException\n\tat com.test.scenario.resolved.Handler.process(Handler.java:300)",
        "bug_severity": "B",
        "fix_version": "V551A-15-251220V10",
        "regression_pass_count": 0,
    },
    {
        "jira_key": "VCAME-TEST-CLOSED-001",
        "status": "Closed",
        "summary": "[自动化][V551A][MonkeyAEE][OOM]com.test.scenario.closed发生OOM",
        "package_name": "com.test.scenario.closed",
        "normalized_summary": "[自动化][V551A][MonkeyAEE][OOM]com.test.scenario.closed发生OOM",
        "test_environment": "*Package:* com.test.scenario.closed\n*ExpClass:* java.lang.OutOfMemoryError\n*ExpType:* OOM\n*CurProcess:* com.test.scenario.closed",
        "raw_caused_by": "Caused by: java.lang.OutOfMemoryError\n\tat com.test.scenario.closed.ImageLoader.load(ImageLoader.java:400)",
        "bug_severity": "A",
        "fix_version": "V551A-15-251215V05",
        "regression_pass_count": 2,
    },
    {
        "jira_key": "VCAME-TEST-REGPASS-001",
        "status": "Resolved",
        "summary": "[自动化][V551A][MonkeyAEE][ANR]com.test.scenario.regpass发生ANR",
        "package_name": "com.test.scenario.regpass",
        "normalized_summary": "[自动化][V551A][MonkeyAEE][ANR]com.test.scenario.regpass发生ANR",
        "test_environment": "*Package:* com.test.scenario.regpass\n*ExpClass:* ANR\n*ExpType:* ANR\n*CurProcess:* com.test.scenario.regpass",
        "raw_caused_by": "Subject: Input dispatching timed out\n\tat com.test.scenario.regpass.Activity.onResume",
        "bug_severity": "B",
        "fix_version": "V551A-15-251218V08",
        "regression_pass_count": 0,
        "verified_versions": "[]",
    },
]

# 清理旧测试数据
conn.execute("DELETE FROM jira_issues_main WHERE jira_key LIKE 'VCAME-TEST-%'")

# 插入测试数据
for issue in test_issues:
    columns = list(issue.keys())
    placeholders = ", ".join(["?" for _ in columns])
    col_names = ", ".join(columns)
    values = [issue[k] for k in columns]
    
    conn.execute(f"INSERT INTO jira_issues_main ({col_names}) VALUES ({placeholders})", values)

conn.commit()

# 验证插入
cursor = conn.execute("SELECT jira_key, status, package_name, fix_version, regression_pass_count FROM jira_issues_main WHERE jira_key LIKE 'VCAME-TEST-%'")
print("已插入测试问题:")
for row in cursor:
    print(f"  {row[0]} | {row[1]} | {row[2]} | fix={row[3]} | pass={row[4]}")

conn.close()
print("\n测试数据设置完成!")
