#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
JiraIssueTemplate
-----------------

提供与 test_excel_to_jira_upload_list.py 相同的字段规范化逻辑，供
主流程与离线脚本复用，确保提单字段一致。
"""

from __future__ import annotations

import json
import os
import re
from pathlib import Path
from typing import Any, Dict, Optional

DEFAULT_REPORTER = os.getenv("JIRA_REPORTER", "dailv.tinno")
SUMMARY_PREFIX = os.getenv("JIRA_SUMMARY_PREFIX", "[自动化]")
CURRENT_DIR = Path(__file__).resolve().parent
CONFIG_DIR = CURRENT_DIR / "config"
SUMMARY_PRODUCT_MAPPING = {
    "ELA-LX2": "V551A",
    "ELA-LX3": "V551A",
    "MLD-LX1": "V552AA",
    "MLD-LX2": "V552AA",
    "MLD-LX3": "V552AA",
}
LOG_PATH_REPLACEMENTS = {
    "/home/jxtinno/sonic_tinno": "220.175.120.251",
}
LOG_SERVER_FILE_MANAGER_URL = "ftp://172.21.15.4"
LOG_SERVER_FILEZILLA_HOST = "220.175.120.251"
LOG_SERVER_USERNAME = "jxtinno"
LOG_SERVER_PASSWORD_ENV = "TINNO_LOG_SERVER_PASSWORD"
LOG_SERVER_PASSWORD_PLACEHOLDER = "<请从本地安全配置获取>"
LOCAL_PS_WHITELIST_FILE = CONFIG_DIR / "local_ps_whitelist.json"


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


def _resolve_summary_prefix_token() -> str:
    tokens = re.findall(r"\[[^\]]+\]", str(SUMMARY_PREFIX or ""))
    if tokens:
        return tokens[0]
    return "[自动化]"


def _resolve_summary_product_token(version: Optional[str]) -> str:
    version_text = str(version or "").strip()
    if not version_text:
        return "Unknown"
    upper_version = version_text.upper()
    for prefix, product in SUMMARY_PRODUCT_MAPPING.items():
        if upper_version.startswith(prefix):
            return product
    match = re.search(r"\b(V\d+[A-Z]+)\b", upper_version)
    if match:
        return str(match.group(1) or "").strip() or "Unknown"
    first_token = re.split(r"[-_\s]", version_text, maxsplit=1)[0]
    return str(first_token or "Unknown").strip() or "Unknown"


def _resolve_test_case_token(issue_data: Dict[str, Any]) -> str:
    test_case_label = str(issue_data.get("test_case_label") or "").strip()
    if test_case_label:
        return test_case_label
    test_case = str(issue_data.get("test_case") or "").strip()
    if test_case.endswith("专项"):
        return test_case[:-2]
    if test_case:
        return test_case
    return "MonkeyAEE"


def build_summary(issue_data: Dict[str, Any]) -> str:
    """生成与上传清单一致的概要。"""
    count = issue_data.get("count", 0)
    version_clean = clean_version(issue_data.get("version"))
    summary_prefix = _resolve_summary_prefix_token()
    summary_product = _resolve_summary_product_token(issue_data.get("version"))
    test_case_token = _resolve_test_case_token(issue_data)
    exp_class = issue_data.get("exp_class", "Unknown")
    package = issue_data.get("package", "unknown.package")
    summary = (
        f"{summary_prefix}[{summary_product}][Total Number {count}]"
        f"[{version_clean}][{test_case_token}][{exp_class}]{package}发生{exp_class}"
    )
    if len(summary) > 255:
        return summary[:252] + "..."
    return summary


def _extract_detail_value(detail_text: Any, prefix: str) -> str:
    target_prefixes = (f"{prefix}：", f"{prefix}:")
    for raw_line in str(detail_text or "").splitlines():
        stripped = str(raw_line or "").strip()
        if not stripped:
            continue
        for candidate in target_prefixes:
            if stripped.startswith(candidate):
                return stripped[len(candidate):].strip()
    return ""


def build_environment(issue_data: Dict[str, Any]) -> str:
    """生成 Environment 字段内容。"""
    detail_text = issue_data.get("detail", "")
    package_display = _extract_detail_value(detail_text, "异常包名") or issue_data.get("package", "unknown.package")
    cur_process_display = _extract_detail_value(detail_text, "异常进程") or issue_data.get(
        "cur_process",
        issue_data.get("package", "unknown.package"),
    )
    return "\n".join(
        [
            f"*Package:* {package_display}",
            f"*ExpClass:* {issue_data.get('exp_class', 'Unknown')}",
            f"*ExpType:* {issue_data.get('exp_type', 'Unknown')}",
            f"*CurProcess:* {cur_process_display}",
        ]
    )


def load_local_ps_whitelist(whitelist_path: Path) -> Dict[str, Any]:
    if not whitelist_path.exists():
        return {}
    try:
        with whitelist_path.open("r", encoding="utf-8") as fp:
            data = json.load(fp)
        return data if isinstance(data, dict) else {}
    except Exception:
        return {}


def normalize_log_path_text(path_text: Any) -> str:
    text = str(path_text or "").strip()
    for source, target in LOG_PATH_REPLACEMENTS.items():
        text = text.replace(source, target)
    return text


def build_log_server_access_text() -> str:
    whitelist = load_local_ps_whitelist(LOCAL_PS_WHITELIST_FILE)
    allow_embed_password = bool(whitelist.get("allow_embed_log_server_password", False))
    whitelist_password = str(whitelist.get("log_server_password") or "").strip()
    env_password = str(os.getenv(LOG_SERVER_PASSWORD_ENV) or "").strip()
    password_text = LOG_SERVER_PASSWORD_PLACEHOLDER
    if env_password:
        password_text = env_password
    elif allow_embed_password:
        password_text = whitelist_password or env_password or LOG_SERVER_PASSWORD_PLACEHOLDER
    return "\n".join(
        [
            f"*{LOG_SERVER_FILEZILLA_HOST} 日志服务器访问方式：*",
            f"1、文件管理器中输入{LOG_SERVER_FILE_MANAGER_URL} 账号：{LOG_SERVER_USERNAME} 密码：{password_text}",
            f"2、使用filezilla工具连接 地址：{LOG_SERVER_FILEZILLA_HOST} 账号：{LOG_SERVER_USERNAME} 密码：{password_text} 端口默认21",
        ]
    )


def build_ps(issue_data: Dict[str, Any], reporter: Optional[str] = None) -> str:
    """生成 PS（备注）字段内容。"""
    cleaned_version = clean_version(issue_data.get("version"))
    reporter_value = reporter or DEFAULT_REPORTER
    normalized_path = normalize_log_path_text(issue_data.get("path", ""))
    return "\n".join(
        [
            f"*Reporter:* {reporter_value}",
            f"*Version:* {cleaned_version}",
            f"*Path:* {normalized_path}",
            f"*Duplicate Number:* {issue_data.get('count', 0)}",
            f"*Device Count:* {issue_data.get('device_count', 0)}",
            build_log_server_access_text(),
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
        f"*Test Case*: {issue_data.get('test_case') or issue_data.get('test_case_label') or ''}",
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
