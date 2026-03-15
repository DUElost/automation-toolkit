#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
JiraIssueTemplate
-----------------

提供与 test_excel_to_jira_upload_list.py 相同的字段规范化逻辑，供
主流程与离线脚本复用，确保提单字段一致。
"""

from __future__ import annotations

import os
from typing import Any, Dict, Optional

DEFAULT_REPORTER = os.getenv("JIRA_REPORTER", "dailv.tinno")
SUMMARY_PREFIX = os.getenv("JIRA_SUMMARY_PREFIX", "[自动化][V551A]")


def clean_version(version: Optional[str]) -> str:
    """与上传清单脚本保持一致的版本清洗逻辑。"""
    if not version:
        return "Unknown"
    version = str(version)
    if "ELA-LX3" in version or "ELA-LX2" in version:
        version_parts = version.split("-")
        if len(version_parts) >= 3:
            version_suffix = "-".join(version_parts[2:])
        else:
            version_suffix = version_parts[-1] if len(version_parts) > 1 else ""
        return f"V551A-{version_suffix}"
    return version[:20]


def build_summary(issue_data: Dict[str, Any]) -> str:
    """生成与上传清单一致的概要。"""
    count = issue_data.get("count", 0)
    version_clean = clean_version(issue_data.get("version"))
    exp_class = issue_data.get("exp_class", "Unknown")
    package = issue_data.get("package", "unknown.package")
    summary = (
        f"{SUMMARY_PREFIX}[Total Number {count}]"
        f"[{version_clean}][MonkeyAEE][{exp_class}]{package}发生{exp_class}"
    )
    if len(summary) > 255:
        return summary[:252] + "..."
    return summary


def build_environment(issue_data: Dict[str, Any]) -> str:
    """生成 Environment 字段内容。"""
    return "\n".join(
        [
            f"*Package:* {issue_data.get('package', 'unknown.package')}",
            f"*ExpClass:* {issue_data.get('exp_class', 'Unknown')}",
            f"*ExpType:* {issue_data.get('exp_type', 'Unknown')}",
            f"*CurProcess:* {issue_data.get('cur_process', issue_data.get('package', 'unknown.package'))}",
        ]
    )


def build_ps(issue_data: Dict[str, Any], reporter: Optional[str] = None) -> str:
    """生成 PS（备注）字段内容。"""
    cleaned_version = clean_version(issue_data.get("version"))
    reporter_value = reporter or DEFAULT_REPORTER
    return "\n".join(
        [
            f"*Reporter:* {reporter_value}",
            f"*Version:* {cleaned_version}",
            f"*Path:* {issue_data.get('path', '')}",
            f"*Duplicate Number:* {issue_data.get('count', 0)}",
            f"*Device Count:* {issue_data.get('device_count', 0)}",
        ]
    )


def map_severity_to_priority(severity: str) -> str:
    """根据问题等级映射到 Jira Priority。"""
    severity_priority_map = {
        "S": "Highest",
        "A": "High",
        "B": "Medium",
        "SWT": "Low",
    }
    return severity_priority_map.get(severity, "Medium")


def build_description(issue_data: Dict[str, Any]) -> str:
    """生成包含关键信息与CausedBy的描述。"""
    caused_by = issue_data.get("key_information") or issue_data.get("caused_by") or "N/A"
    template = [
        f"*Version*: {issue_data.get('version')}",
        f"*Package*: {issue_data.get('package')}",
        f"*Exception Class*: {issue_data.get('exp_class')} / {issue_data.get('exp_type')}",
        f"*Process*: {issue_data.get('cur_process')}",
        f"*Count / Devices*: {issue_data.get('count')} / {issue_data.get('device_count')}",
        "",
        "---- Detail ----",
        issue_data.get("detail") or "N/A",
        "",
        "---- Caused By ----",
        caused_by,
    ]
    return "\n".join(str(line) for line in template if line is not None)
