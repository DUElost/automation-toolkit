#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""调试 Case6：同步 Jira 中的 [自动化] 工单并检查本地库。"""

from __future__ import annotations

import argparse
import json
import sqlite3
from pathlib import Path

import os
import sys

SCRIPT_DIR = Path(__file__).resolve().parent
MODULE_DIR = SCRIPT_DIR / "src"
if str(MODULE_DIR) not in sys.path:
    sys.path.insert(0, str(MODULE_DIR))

from modules.config_loader import ConfigLoader
from modules.database_manager import DatabaseManager
from modules.jira_p12_client import JiraP12Client
from modules.jira_issue_template import build_environment
from main import build_jira_config

JQL_AUTOMATION = r'project = VCAME AND summary ~ "\\[自动化\\]" AND statusCategory = Done'


def _build_db_config(loader: ConfigLoader, db_path: Path) -> dict:
    cfg = loader.get_database_config() or {}
    cfg.update({"type": "sqlite", "path": str(db_path)})
    return cfg


def _build_record(issue: dict) -> dict:
    fields = issue.get("fields", {})
    summary = fields.get("summary") or issue.get("key") or ""
    description = fields.get("description") or ""
    assignee = (fields.get("assignee") or {}).get("name")
    priority = (fields.get("priority") or {}).get("name") or "Medium"
    fix_versions = fields.get("fixVersions") or []
    fix_version = fix_versions[0].get("name") if fix_versions else None
    env = build_environment({
        "package": "sync",
        "exp_class": "Unknown",
        "exp_type": "Unknown",
        "cur_process": "sync",
        "version": fields.get("environment") or "SYNC",
        "detail": description,
        "path": "jira_sync",
        "count": 0,
        "device_count": 0,
    })
    return {
        "jira_key": issue.get("key"),
        "status": (fields.get("status") or {}).get("name", "Unknown"),
        "summary": summary,
        "normalized_summary": summary,
        "test_environment": env,
        "raw_caused_by": description,
        "assignee": assignee,
        "bug_severity": "Medium",
        "priority": priority,
        "description": description,
        "package_name": "sync",
        "exp_class": "Unknown",
        "exp_type": "Unknown",
        "cur_process": "sync",
        "version": fields.get("environment") or "SYNC",
        "count": 0,
        "device_count": 0,
        "source_file": "jira_sync",
        "raw_data": json.dumps(issue, ensure_ascii=False),
        "fix_version": fix_version,
        "regression_pass_count": 0,
    }


def sync_automation_issues(db: DatabaseManager, loader: ConfigLoader) -> None:
    jira_config = build_jira_config(loader, argparse.Namespace(**{}))
    client = JiraP12Client(
        jira_url=jira_config.get("url", ""),
        p12_file_path=jira_config.get("p12_path", ""),
        p12_password=jira_config.get("p12_password", ""),
        jira_username=jira_config.get("username", ""),
        jira_password=jira_config.get("password", "") or jira_config.get("api_token", ""),
    )
    client.ensure_authenticated()
    response = client.search(JQL_AUTOMATION, max_results=200)
    issues = response.get("issues", [])
    inserted = updated = 0
    for raw_issue in issues:
        record = _build_record(raw_issue)
        existing = db.get_issue_by_key(record["jira_key"])
        if existing:
            db.update_main_table_record(record["jira_key"], record)
            updated += 1
        else:
            db.insert_main_table_record(record)
            inserted += 1
    print(f"同步完成: 新增 {inserted} 条, 更新 {updated} 条")


def list_resolved_issues(db_path: Path) -> None:
    conn = sqlite3.connect(db_path)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()
    rows = cur.execute(
        """
        SELECT jira_key, status, summary, test_environment, regression_pass_count
        FROM jira_issues_main
        WHERE status IN ('Resolved','已解决')
        ORDER BY jira_key
        """
    ).fetchall()
    if not rows:
        print("未找到状态为 Resolved/已解决 的工单")
        return
    print(f"找到 {len(rows)} 条已解决/Resolved 工单：")
    for row in rows:
        d = dict(row)
        summary = d.get("summary") or ""
        env = d.get("test_environment") or ""
        reason = []
        if "[自动化]" not in summary:
            reason.append("摘要缺少[自动化]")
        if "*Package:" not in env:
            reason.append("test_environment 非规范格式")
        reason_text = " | ".join(reason) if reason else "符合 Case6 条件"
        print(
            f"- {d['jira_key']} status={d['status']} pass_count={d.get('regression_pass_count',0)}\n"
            f"  summary={summary}\n"
            f"  env={env}\n"
            f"  检测结果: {reason_text}"
        )
    conn.close()


def main() -> None:
    parser = argparse.ArgumentParser(description="调试 Case6 回归条件的脚本")
    parser.add_argument("--db-path", default="tests/jira_local.db", help="SQLite 数据库路径")
    parser.add_argument("--config", default=".env", help="配置文件路径")
    parser.add_argument("--sync", action="store_true", help="先从 Jira 同步 [自动化] 工单")
    args = parser.parse_args()
    db_path = Path(args.db_path)
    loader = ConfigLoader(args.config)
    if args.sync:
        db = DatabaseManager(_build_db_config(loader, db_path))
        sync_automation_issues(db, loader)
        db.connection.close()
    list_resolved_issues(db_path)


if __name__ == "__main__":
    main()
