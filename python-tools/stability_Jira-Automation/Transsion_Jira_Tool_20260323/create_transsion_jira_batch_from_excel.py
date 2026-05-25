#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Transsion Jira 批量建单脚本
--------------------------

读取当前目录生成的上传模板 Excel，并在 jira.transsion.com 对应项目中批量创建问题。
"""

from __future__ import annotations

import argparse
import json
import logging
import os
import re
import sys
import time
from datetime import datetime
from pathlib import Path
from typing import Any, Dict, List, Tuple

import pandas as pd
from jira.exceptions import JIRAError

CURRENT_DIR = Path(__file__).resolve().parent
if str(CURRENT_DIR) not in sys.path:
    sys.path.insert(0, str(CURRENT_DIR))

from transsion_upload_template_common import load_defaults, load_priority_mapping_from_rules_excel, read_excel_smart
from transsion_batch_jira_common import (
    EXCEL_FIELD_CANDIDATES,
    add_issue_comment,
    assign_issue_to_user,
    build_field_name_lookup,
    build_issue_fields,
    clean_cell_value,
    connect_to_jira,
    extract_allowed_values,
    fetch_issue_snapshot_fields,
    find_first_value,
    get_create_meta_fields,
    resolve_bug_severity_attachment_name,
    resolve_project_key,
    resolve_user_name,
    transition_issue_to_open,
    update_issue_fields,
)
from transsion_regression_executor import decide_action, evaluate_regression_pass
from transsion_regression_matcher import is_strong_match
from transsion_regression_models import load_regression_rules
from transsion_regression_report import write_excel_summary
from transsion_regression_store import RegressionStore

logger = logging.getLogger(__name__)

CONFIG_DIR = CURRENT_DIR / "config"
LOG_DIR = CURRENT_DIR / "log"
RESULT_DIR = CURRENT_DIR / "result"
DEFAULT_CONFIG_FILE = CONFIG_DIR / "transsion_jira_defaults.json"
DEFAULT_REGRESSION_RULES_FILE = CONFIG_DIR / "regression_rules.json"
DEFAULT_SEVERITY_RULES = CONFIG_DIR / "问题等级定级表.xls"
DEFAULT_BUG_SEVERITY_IMAGE_DIR = CONFIG_DIR / "bug_severity_priority_image"
DEFAULT_INPUT_FILE = CURRENT_DIR / "JIRA_Upload_List_Transsion_开关机专项_20260325_115150.xlsx"
MONKEY_SUMMARY_KEYWORD = "[MonkeyAEE]"
STABILITY_SUMMARY_KEYWORD = "【稳定性专项】"
DEFAULT_CATEGORY_TAG = "稳定性专项"
DUPLICATE_FOLLOW_CLOSE_COMMENT = "跟随主单一同关闭。"
DUPLICATE_LINK_KEYWORDS = ("duplicate", "duplicates", "duplicated", "重复")
DUPLICATE_CUSTOM_FIELD_KEYS = ("customfield_14207",)
DUPLICATE_BACKFILL_STATUS_NAMES = {"verified"}


def setup_logging() -> None:
    LOG_DIR.mkdir(parents=True, exist_ok=True)
    logging.basicConfig(
        level=logging.INFO,
        format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
        handlers=[
            logging.StreamHandler(),
            logging.FileHandler(LOG_DIR / "create_transsion_jira_batch_from_excel.log", encoding="utf-8"),
        ],
    )


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Transsion Jira 批量建单脚本")
    parser.add_argument("--add-excel-file", dest="excel_file", default=None, help="上传模板 Excel 路径")
    parser.add_argument("--regression-project", dest="regression_project", default=None, help="回归验证模式的 Jira 项目 Key")
    parser.add_argument(
        "--regression-specialty",
        dest="regression_specialties",
        action="append",
        default=[],
        help="回归验证模式的专项名称，支持重复传参",
    )
    parser.add_argument("--current-version", dest="current_version", default=None, help="回归验证模式的当前验证版本")
    parser.add_argument("--history-reporter", dest="history_reporter", default=None, help="回归验证模式用于粗筛历史问题的 reporter")
    parser.add_argument("--jira-username", dest="jira_username", default=os.getenv("JIRA_USERNAME"), help="Jira 用户名")
    parser.add_argument("--jira-password", dest="jira_password", default=os.getenv("JIRA_PASSWORD"), help="Jira 密码")
    parser.add_argument("--jira-server", dest="jira_server", default=None, help="Jira 服务地址")
    parser.add_argument("--config-file", dest="config_file", default=str(DEFAULT_CONFIG_FILE), help="默认配置路径")
    parser.add_argument(
        "--severity-rules-file",
        dest="severity_rules_file",
        default=str(DEFAULT_SEVERITY_RULES),
        help="问题等级规则表路径，第二阶段会从同一份表读取等级到 Jira 优先级映射",
    )
    parser.add_argument(
        "--bug-severity-image-dir",
        dest="bug_severity_image_dir",
        default=str(DEFAULT_BUG_SEVERITY_IMAGE_DIR),
        help="问题严重定义附件图片目录",
    )
    parser.add_argument(
        "--wait-between-issues",
        dest="wait_between_issues",
        type=float,
        default=None,
        help="每条问题处理完成后，下一条开始前的强制等待秒数；0 表示不等待",
    )
    parser.add_argument("--dry-run", action="store_true", help="仅校验数据，不实际建单")
    parser.add_argument("--validate-metadata", action="store_true", help="打印项目元数据后退出")
    parser.add_argument("--add-comments", action="store_true", help="创建成功后把 PS 列追加为评论")
    parser.add_argument("--disable-regression", action="store_true", help="单次执行关闭新增回归验证功能")
    return parser.parse_args()


def resolve_run_mode(args: argparse.Namespace) -> str:
    has_excel_mode = bool(str(getattr(args, "excel_file", "") or "").strip())
    has_regression_mode = bool(str(getattr(args, "regression_project", "") or "").strip())

    if has_excel_mode and has_regression_mode:
        raise ValueError("Excel 模式参数与回归验证模式参数不能同时使用")
    if not has_excel_mode and not has_regression_mode:
        raise ValueError("必须选择 Excel 模式或回归验证模式")
    if has_regression_mode:
        missing: list[str] = []
        if not getattr(args, "regression_specialties", []):
            missing.append("--regression-specialty")
        if not str(getattr(args, "current_version", "") or "").strip():
            missing.append("--current-version")
        if not str(getattr(args, "history_reporter", "") or "").strip():
            missing.append("--history-reporter")
        if missing:
            raise ValueError(f"回归验证模式缺少必要参数: {', '.join(missing)}")
        return "regression_verify"
    return "excel"


def build_project_scoped_sqlite_path(project_key: str, sqlite_path_setting: Any) -> Path:
    project_text = str(project_key or "").strip()
    if not project_text:
        raise ValueError("project_key 不能为空")
    base_path = Path(str(sqlite_path_setting or "result/regression_cache"))
    if not base_path.is_absolute():
        base_path = CURRENT_DIR / base_path
    if base_path.suffix.lower() == ".db":
        base_path = base_path.parent
    return base_path / f"{project_text}.db"


def validate_upload_excel(df: pd.DataFrame) -> bool:
    required_fields = [
        "project",
        "issue_type",
        "summary",
        "description",
        "priority",
        "components",
        "versions",
        "assignee",
        "reporter",
        "risk",
        "issue_source",
        "issue_category",
        "issue_nature",
        "affect_project",
        "case_no",
    ]
    missing = []
    for field_name in required_fields:
        if not any(column in df.columns for column in EXCEL_FIELD_CANDIDATES[field_name]):
            missing.append(field_name)
    if missing:
        logger.error("上传模板缺少必要列: %s", missing)
        logger.error("当前列: %s", list(df.columns))
        return False
    return True


def get_meta_bundle(
    jira_client,
    project_key: str,
    issue_type_name: str,
    meta_cache: Dict[Tuple[str, str], Dict[str, Any]],
) -> Dict[str, Any]:
    cache_key = (project_key, issue_type_name)
    if cache_key in meta_cache:
        return meta_cache[cache_key]

    create_fields = get_create_meta_fields(jira_client, project_key, issue_type_name)
    if not create_fields:
        raise RuntimeError(f"无法读取项目 {project_key} / {issue_type_name} 的 create meta")

    bundle = {
        "create_fields": create_fields,
        "field_name_lookup": build_field_name_lookup(create_fields),
        "allowed_values": extract_allowed_values(create_fields),
    }
    meta_cache[cache_key] = bundle
    return bundle


def log_required_fields(project_key: str, issue_type_name: str, create_fields: Dict[str, Any]) -> None:
    logger.info("项目 %s / %s 的必填字段:", project_key, issue_type_name)
    for field_id, info in create_fields.items():
        if info.get("required"):
            logger.info("  - %s (%s)", info.get("name", field_id), field_id)


def _get_raw_row_value(row: Any, field_name: str) -> Any:
    if isinstance(row, dict):
        return row.get(field_name)
    if hasattr(row, "index") and field_name in row.index:
        return row[field_name]
    return None


def collect_regression_summary_keywords(df: pd.DataFrame) -> list[str]:
    has_monkey_rows = False
    has_non_monkey_rows = False
    for _, row in df.iterrows():
        summary_text = str(find_first_value(row, "summary", "") or "").strip()
        if not summary_text:
            continue
        if "【Monkey专项】" in summary_text or "执行Monkey专项过程中" in summary_text:
            has_monkey_rows = True
        else:
            has_non_monkey_rows = True

    keywords: list[str] = []
    if has_non_monkey_rows:
        keywords.append(STABILITY_SUMMARY_KEYWORD)
    if has_monkey_rows:
        keywords.append(MONKEY_SUMMARY_KEYWORD)
    return keywords


def extract_specialty_from_summary(summary: Any, category_tag: str = DEFAULT_CATEGORY_TAG) -> str:
    summary_text = str(summary or "").strip()
    if not summary_text:
        return ""
    if MONKEY_SUMMARY_KEYWORD in summary_text:
        return "MonkeyAEE"
    tags = re.findall(r"【([^】]+)】", summary_text)
    if not tags:
        return ""
    for index, tag in enumerate(tags):
        if tag == category_tag and index + 1 < len(tags):
            return str(tags[index + 1]).strip()
    return ""


def collect_batch_specialties(df: pd.DataFrame, category_tag: str = DEFAULT_CATEGORY_TAG) -> set[str]:
    specialties: set[str] = set()
    for _, row in df.iterrows():
        specialty = extract_specialty_from_summary(find_first_value(row, "summary", ""), category_tag=category_tag)
        if specialty:
            specialties.add(specialty)
    return specialties


def collect_batch_project_key(jira_client, df: pd.DataFrame, project_cache: Dict[str, str]) -> str:
    unique_project_keys: set[str] = set()
    for index, row in df.iterrows():
        project_text = str(find_first_value(row, "project", "") or "").strip()
        if not project_text:
            raise ValueError(f"第 {index + 1} 行缺少 Project，当前上传模板必须只包含一个 Jira 项目")
        project_key = str(resolve_project_key(jira_client, project_text, project_cache) or "").strip()
        if not project_key:
            raise ValueError(f"第 {index + 1} 行 Project 无法解析为有效 Jira 项目: {project_text}")
        unique_project_keys.add(project_key)

    if not unique_project_keys:
        raise ValueError("当前上传模板未解析到任何 Jira 项目")
    if len(unique_project_keys) > 1:
        raise ValueError(f"当前上传模板包含多个 Jira 项目: {', '.join(sorted(unique_project_keys))}")
    return next(iter(unique_project_keys))


def _escape_jql_text_keyword(keyword: str) -> str:
    escaped = str(keyword or "").replace("\\", "\\\\").replace('"', '\\"')
    return escaped.replace("[", "\\\\[").replace("]", "\\\\]")


def build_regression_base_jql(project_key: str, extra_jql: str) -> str:
    normalized_project_key = str(project_key or "").strip()
    if not normalized_project_key:
        raise ValueError("project_key 不能为空")

    normalized_extra_jql = str(extra_jql or "").strip()
    if normalized_extra_jql:
        normalized_extra_jql = re.sub(
            r'^\s*project\s*=\s*(?:"[^"]+"|[^\s]+)\s*(?:AND\s*)?',
            "",
            normalized_extra_jql,
            flags=re.IGNORECASE,
        ).strip()

    project_clause = f"project = {normalized_project_key}"
    if not normalized_extra_jql:
        return project_clause
    if normalized_extra_jql.upper().startswith("ORDER BY "):
        return f"{project_clause} {normalized_extra_jql}"
    return f"{project_clause} AND {normalized_extra_jql}"


def override_reporter_in_jql(jql_text: str, current_user: str) -> str:
    normalized_jql = str(jql_text or "").strip()
    normalized_user = str(current_user or "").strip()
    if not normalized_jql or not normalized_user:
        return normalized_jql

    reporter_in_pattern = re.compile(r"\breporter\s+in\s*\([^)]*\)", flags=re.IGNORECASE)
    reporter_equals_pattern = re.compile(r'\breporter\s*=\s*(?:"[^"]+"|[^\s)]+)', flags=re.IGNORECASE)
    if reporter_in_pattern.search(normalized_jql):
        return reporter_in_pattern.sub(f"reporter in ({normalized_user})", normalized_jql, count=1)
    if reporter_equals_pattern.search(normalized_jql):
        return reporter_equals_pattern.sub(f"reporter in ({normalized_user})", normalized_jql, count=1)
    return normalized_jql


def build_regression_export_jql(base_jql: str, keywords: list[str]) -> str:
    normalized_base_jql = str(base_jql or "").strip()
    if not normalized_base_jql or not keywords:
        return normalized_base_jql

    escaped_keywords = [f'summary ~ "{_escape_jql_text_keyword(keyword)}"' for keyword in keywords if str(keyword).strip()]
    if not escaped_keywords:
        return normalized_base_jql
    summary_clause = f"({' OR '.join(escaped_keywords)})"

    upper_base_jql = normalized_base_jql.upper()
    order_by_marker = " ORDER BY "
    order_by_index = upper_base_jql.find(order_by_marker)
    if order_by_index >= 0:
        return f"{normalized_base_jql[:order_by_index]} AND {summary_clause}{normalized_base_jql[order_by_index:]}"
    return f"{normalized_base_jql} AND {summary_clause}"


def resolve_regression_verify_summary_keyword(specialty: Any) -> str:
    normalized_specialty = str(specialty or "").strip()
    if normalized_specialty == "MonkeyAEE":
        return MONKEY_SUMMARY_KEYWORD
    if normalized_specialty == "Monkey专项":
        return "Monkey专项"
    return STABILITY_SUMMARY_KEYWORD


def build_regression_verify_jql(project_key: str, reporter: str, specialty: str) -> str:
    summary_keyword = resolve_regression_verify_summary_keyword(specialty)
    base_jql = build_regression_base_jql(project_key, f"reporter in ({str(reporter or '').strip()})")
    return build_regression_export_jql(base_jql, [summary_keyword])


def deduplicate_snapshot_rows_by_jira_key(rows: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
    seen: set[str] = set()
    deduped: List[Dict[str, Any]] = []
    for row in rows:
        jira_key = str((row or {}).get("jira_key") or "").strip()
        if not jira_key or jira_key in seen:
            continue
        seen.add(jira_key)
        deduped.append(dict(row))
    return deduped


def export_jira_snapshot(
    jira_client,
    regression_rules: Any,
    *,
    base_jql: str,
    summary_keywords: list[str] | None = None,
    field_mapping: Dict[str, Any] | None = None,
) -> List[Dict[str, Any]]:
    jira_export = getattr(regression_rules, "jira_export", None)
    if not jira_export or not getattr(jira_export, "enabled", False):
        return []

    export_jql = build_regression_export_jql(base_jql, summary_keywords or [])
    logger.info("历史问题单导出 JQL: %s", export_jql)
    issues = jira_client.search_issues(
        export_jql,
        maxResults=int(getattr(jira_export, "max_results", 500)),
        fields="*all",
    )
    snapshot_rows: List[Dict[str, Any]] = []
    for issue in issues:
        issue_key = str(getattr(issue, "key", "") or "").strip()
        if issue_key:
            snapshot_rows.append(fetch_issue_snapshot_fields(jira_client, issue_key, field_mapping=field_mapping))
    return snapshot_rows


def _version_sort_key(version: Any) -> tuple[str, ...]:
    text = str(version or "").strip()
    if not text:
        return ()
    tokens = re.findall(r"\d+|[A-Za-z]+", text)
    if not tokens:
        return (text.lower(),)
    normalized: list[str] = []
    for token in tokens:
        if token.isdigit():
            normalized.append(f"0{int(token):010d}")
        else:
            normalized.append(f"1{token.lower()}")
    return tuple(normalized)


def select_current_version(versions: List[str]) -> str:
    cleaned_versions = [str(item).strip() for item in versions if str(item).strip()]
    if not cleaned_versions:
        return ""
    return max(cleaned_versions, key=_version_sort_key)


def _parse_issue_timestamp(value: Any) -> datetime | None:
    text = str(value or "").strip()
    if not text:
        return None
    for fmt in ("%Y-%m-%dT%H:%M:%S.%f%z", "%Y-%m-%dT%H:%M:%S%z", "%Y-%m-%d %H:%M:%S"):
        try:
            return datetime.strptime(text, fmt)
        except ValueError:
            continue
    try:
        return datetime.fromisoformat(text.replace("Z", "+00:00"))
    except ValueError:
        return None


def _extract_sort_timestamps(row: Dict[str, Any]) -> tuple[datetime | None, datetime | None]:
    raw_payload = row.get("raw_payload")
    if isinstance(raw_payload, str):
        try:
            raw_payload = json.loads(raw_payload)
        except json.JSONDecodeError:
            raw_payload = {}
    fields = raw_payload.get("fields", {}) if isinstance(raw_payload, dict) else {}
    return (
        _parse_issue_timestamp(fields.get("updated")),
        _parse_issue_timestamp(fields.get("created")),
    )


def build_regression_row(row: Any) -> Dict[str, Any]:
    versions_raw = find_first_value(row, "versions", "")
    version_items = [
        item.strip()
        for item in str(versions_raw or "").replace("；", ",").replace(";", ",").split(",")
        if item.strip()
    ]
    return {
        "summary": find_first_value(row, "summary", ""),
        "description": find_first_value(row, "description", ""),
        "project": find_first_value(row, "project", ""),
        "issue_type": find_first_value(row, "issue_type", ""),
        "affect_project": find_first_value(row, "affect_project", ""),
        "environment": find_first_value(row, "environment", ""),
        "exp_class": find_first_value(row, "exp_class", ""),
        "caused_by": find_first_value(row, "caused_by", "") or "",
        "ps": find_first_value(row, "ps", ""),
        "versions": version_items,
        "current_version": select_current_version(version_items),
    }


def build_snapshot_field_mapping(defaults: Dict[str, Any]) -> Dict[str, Any]:
    field_ids = defaults.get("field_ids", {})
    mapping: Dict[str, Any] = {}
    for field_name in ("affect_project", "exp_class", "caused_by"):
        field_id = str(field_ids.get(field_name, "") or "").strip()
        if field_id:
            mapping[field_name] = field_id
    return mapping


def find_regression_match(
    current_row: Dict[str, Any],
    snapshot_rows: List[Dict[str, Any]],
    matching_rules: Any,
) -> Dict[str, Any] | None:
    threshold = getattr(matching_rules, "cause_similarity_threshold", 0.9)
    exact_fields = getattr(matching_rules, "required_exact_fields", None)
    candidates = [
        history_row
        for history_row in snapshot_rows
        if is_strong_match(current_row, history_row, threshold, exact_fields=exact_fields)
    ]
    if not candidates:
        return None

    def candidate_sort_key(history_row: Dict[str, Any]) -> tuple:
        updated_at, created_at = _extract_sort_timestamps(history_row)
        jira_key = str(history_row.get("jira_key") or "")
        return (
            0 if updated_at else 1,
            -(updated_at.timestamp()) if updated_at else 0,
            0 if created_at else 1,
            -(created_at.timestamp()) if created_at else 0,
            jira_key,
        )

    return sorted(candidates, key=candidate_sort_key)[0]


def build_execution_result(
    run_id: str,
    row_number: int,
    matched_row: Dict[str, Any] | None,
    action: str,
    manual_review: bool,
    success: bool,
    reason: str,
    result_message: str,
) -> Dict[str, Any]:
    return {
        "run_id": run_id,
        "row_number": row_number,
        "matched_jira_key": (matched_row or {}).get("jira_key"),
        "fix_version": (matched_row or {}).get("fix_version"),
        "action": action,
        "success": 1 if success else 0,
        "manual_review": 1 if manual_review else 0,
        "reason": reason,
        "result_message": result_message,
    }


def build_history_issue_main_comment(action: str, row: Any, matched_row: Dict[str, Any] | None) -> str:
    current_version = clean_cell_value(find_first_value(row, "versions")) or "未提供版本"
    history_key = str((matched_row or {}).get("jira_key") or "").strip() or "历史单"

    if action == "OPEN_LIKE_UPDATE":
        return f"自动化回归命中历史单 {history_key}，已按当前版本 {current_version} 的信息同步更新，请继续跟进。"
    if action == "WONT_FIX_KEEP":
        return f"自动化回归再次命中历史单 {history_key}，当前版本 {current_version} 继续复现，请重新关注评估。"
    if action == "RESOLVED_FIXED_WAIT_NEW_VERSION":
        return f"自动化回归命中历史单 {history_key}，当前版本 {current_version} 早于修复版本，先保留记录并继续观察。"
    return f"自动化回归命中历史单 {history_key}，请关注当前版本 {current_version} 的复现情况。"


def override_reporter_in_ps_text(ps_text: Any, current_user: str) -> str:
    normalized_ps_text = str(clean_cell_value(ps_text) or "").strip()
    normalized_user = str(current_user or "").strip()
    if not normalized_ps_text or not normalized_user:
        return normalized_ps_text

    reporter_pattern = re.compile(r"^\*Reporter:\*\s*.*$", flags=re.IGNORECASE | re.MULTILINE)
    if reporter_pattern.search(normalized_ps_text):
        return reporter_pattern.sub(f"*Reporter:* {normalized_user}", normalized_ps_text, count=1)
    return f"*Reporter:* {normalized_user}\n{normalized_ps_text}"


def add_history_issue_comments(
    jira_client,
    issue_key: str | None,
    action: str,
    row: Any,
    matched_row: Dict[str, Any] | None,
    ps_text: str | None,
    add_ps_comment: bool,
) -> int:
    if not issue_key:
        return 0

    add_issue_comment(jira_client, issue_key, build_history_issue_main_comment(action, row, matched_row))
    comment_count = 1
    comment_status = "ADDED"
    ps_comment_status = ""
    if add_ps_comment and ps_text:
        add_issue_comment(jira_client, issue_key, str(ps_text))
        comment_count += 1
        ps_comment_status = "ADDED"
    return {
        "comment_count": comment_count,
        "comment_status": comment_status,
        "ps_comment_status": ps_comment_status,
    }


def build_update_fields(issue_fields: Dict[str, Any]) -> Dict[str, Any]:
    allowed_update_fields = ("summary", "description", "priority")
    return {
        field_name: issue_fields[field_name]
        for field_name in allowed_update_fields
        if field_name in issue_fields
    }


def append_result(
    results: List[Dict[str, Any]],
    *,
    row_number: int,
    status: str,
    project_key: str,
    summary: Any,
    issue_key: str | None,
    matched_row: Dict[str, Any] | None,
    decision: Any,
    error: str | None,
) -> None:
    results.append(
        {
            "row": row_number,
            "status": status,
            "project": project_key,
            "summary": summary,
            "issue_key": issue_key,
            "matched_jira_key": (matched_row or {}).get("jira_key"),
            "decision": {
                "action": getattr(decision, "action", ""),
                "manual_review": bool(getattr(decision, "manual_review", False)),
                "update_jira": bool(getattr(decision, "update_jira", False)),
                "recreate_issue": bool(getattr(decision, "recreate_issue", False)),
            },
            "error": error,
        }
    )


def build_summary_row(
    *,
    row_number: int,
    matched_row: Dict[str, Any] | None,
    matched_jira_key: str | None,
    action: str,
    success: bool,
    manual_review: bool,
    reason: str,
    result_message: str,
    old_count: Any = "",
    new_count: Any = "",
    comment_status: str = "",
    ps_comment_status: str = "",
) -> Dict[str, Any]:
    history_row = dict(matched_row or {})
    if matched_jira_key and not history_row.get("jira_key"):
        history_row["jira_key"] = matched_jira_key
    return {
        "row_number": row_number,
        "matched_jira_key": history_row.get("jira_key") or "",
        "matched_status": history_row.get("status") or "",
        "matched_resolution": history_row.get("resolution") or "",
        "fix_version": history_row.get("fix_version") or "",
        "action": action,
        "success": 1 if success else 0,
        "manual_review": 1 if manual_review else 0,
        "reason": reason,
        "old_count": "" if old_count is None else old_count,
        "new_count": "" if new_count is None else new_count,
        "comment_status": comment_status,
        "ps_comment_status": ps_comment_status,
        "result_message": result_message,
    }


def _load_verified_versions(value: Any) -> list[str]:
    if value is None:
        return []
    if isinstance(value, str):
        text = value.strip()
        if not text:
            return []
        if text.startswith("["):
            try:
                parsed = json.loads(text)
            except json.JSONDecodeError:
                parsed = None
            if isinstance(parsed, list):
                return [str(item).strip() for item in parsed if str(item).strip()]
        return [item.strip() for item in re.split(r"[,;，；]", text) if item.strip()]
    if isinstance(value, (list, tuple, set)):
        return [str(item).strip() for item in value if str(item).strip()]
    normalized = str(value).strip()
    return [normalized] if normalized else []


def is_monkey_specialty(specialty: Any) -> bool:
    return str(specialty or "").strip() == "Monkey专项"


def build_regression_pass_comment(
    pass_count: int,
    versions: list[str],
    *,
    specialty: str,
    current_version: str,
) -> str:
    version_text = ", ".join(versions) if versions else "未记录版本"
    legacy_comment = f"已回归验证{pass_count}个版本PASS，已测试版本：{version_text}"
    if is_monkey_specialty(specialty):
        return legacy_comment
    return (
        "验证结果：PASS\n"
        "测试次数：0/1000\n"
        f"验证步骤：{specialty or '未识别专项'}\n"
        f"验证版本：{current_version or '未记录版本'}\n"
        "样机标识：PR1\n"
        "应用版本：/\n"
        "测试人员及联系方式：吕代+18379465576\n"
        f"备注：{legacy_comment}"
    )


def transition_issue_to_closed(jira_client, issue_key: str, closed_statuses: List[str]) -> Tuple[bool, str]:
    issue = jira_client.issue(issue_key)
    current_status = str(getattr(issue.fields.status, "name", "") or "").strip()
    normalized_closed_statuses = {str(item).strip().lower() for item in closed_statuses if str(item).strip()}
    if current_status.lower() in normalized_closed_statuses:
        return True, f"当前状态已是 {current_status}"

    transitions = jira_client.transitions(issue)
    selected_transition_id: str | None = None
    selected_transition_name = ""
    close_keywords = {"close", "closed", "关闭", "关单"}
    for transition in transitions:
        transition_name = str(transition.get("name") or "").strip()
        target_status_name = str(((transition.get("to") or {}).get("name")) or "").strip()
        if target_status_name.lower() in normalized_closed_statuses:
            selected_transition_id = str(transition.get("id") or "").strip()
            selected_transition_name = transition_name or target_status_name
            break
        if any(keyword in transition_name.lower() for keyword in ("close", "closed")) or any(
            keyword in transition_name for keyword in ("关闭", "关单")
        ):
            selected_transition_id = str(transition.get("id") or "").strip()
            selected_transition_name = transition_name or target_status_name
            break

    if not selected_transition_id:
        return False, f"未找到从 {current_status} 转到关闭状态的可用流转"

    jira_client.transition_issue(issue, selected_transition_id)
    return True, f"{current_status} -> {selected_transition_name}"


def _load_issue_raw_payload(row: Dict[str, Any]) -> Dict[str, Any]:
    raw_payload = row.get("raw_payload")
    if isinstance(raw_payload, str):
        try:
            raw_payload = json.loads(raw_payload)
        except json.JSONDecodeError:
            raw_payload = {}
    return raw_payload if isinstance(raw_payload, dict) else {}


def _is_duplicate_issue_link(link: Dict[str, Any]) -> bool:
    link_type = link.get("type") if isinstance(link.get("type"), dict) else {}
    candidates = [
        link.get("type"),
        link_type.get("name") if isinstance(link_type, dict) else "",
        link_type.get("outward") if isinstance(link_type, dict) else "",
        link_type.get("inward") if isinstance(link_type, dict) else "",
    ]
    normalized_text = " ".join(str(item or "").strip().lower() for item in candidates)
    return any(keyword in normalized_text for keyword in DUPLICATE_LINK_KEYWORDS)


def collect_duplicate_issue_keys(row: Dict[str, Any]) -> List[str]:
    raw_payload = _load_issue_raw_payload(row)
    fields = raw_payload.get("fields", {}) if isinstance(raw_payload, dict) else {}
    issue_links = fields.get("issuelinks") or fields.get("issueLinks") or []

    main_key = str(row.get("jira_key") or "").strip()
    duplicate_keys: List[str] = []
    seen: set[str] = set()

    def add_duplicate_key(linked_issue: Any) -> None:
        if isinstance(linked_issue, dict):
            linked_key = str(linked_issue.get("key") or "").strip()
        else:
            linked_key = str(getattr(linked_issue, "key", "") or "").strip()
        if linked_key and linked_key != main_key and linked_key not in seen:
            seen.add(linked_key)
            duplicate_keys.append(linked_key)

    if isinstance(issue_links, list):
        for link in issue_links:
            if not isinstance(link, dict) or not _is_duplicate_issue_link(link):
                continue
            for issue_side in ("outwardIssue", "inwardIssue"):
                add_duplicate_key(link.get(issue_side))

    for field_key in DUPLICATE_CUSTOM_FIELD_KEYS:
        linked_issues = fields.get(field_key) or []
        if isinstance(linked_issues, dict):
            linked_issues = [linked_issues]
        if not isinstance(linked_issues, list):
            continue
        for linked_issue in linked_issues:
            add_duplicate_key(linked_issue)
    return duplicate_keys


def get_issue_status_name(jira_client, issue_key: str) -> str:
    issue = jira_client.issue(issue_key)
    return str(getattr(issue.fields.status, "name", "") or "").strip()


def close_duplicate_issues_following_main(
    *,
    jira_client,
    store: Any,
    run_id: str,
    main_row: Dict[str, Any],
    closed_statuses: List[str],
    results: List[Dict[str, Any]],
    summary_rows: List[Dict[str, Any]],
    only_duplicate_statuses: set[str] | None = None,
) -> None:
    main_key = str(main_row.get("jira_key") or "").strip()
    normalized_allowed_statuses = {str(item).strip().lower() for item in (only_duplicate_statuses or set()) if str(item).strip()}
    for duplicate_key in collect_duplicate_issue_keys(main_row):
        duplicate_row = {
            "jira_key": duplicate_key,
            "summary": f"重复单跟随主单 {main_key}",
            "fix_version": main_row.get("fix_version"),
        }
        success = True
        reason = "跟随主单关闭"
        try:
            if normalized_allowed_statuses:
                current_status = get_issue_status_name(jira_client, duplicate_key)
                if current_status.lower() not in normalized_allowed_statuses:
                    logger.info("重复单 %s 状态为 %s，跳过跟随关闭", duplicate_key, current_status or "UNKNOWN")
                    continue
            add_issue_comment(jira_client, duplicate_key, DUPLICATE_FOLLOW_CLOSE_COMMENT)
            transitioned, transition_message = transition_issue_to_closed(jira_client, duplicate_key, closed_statuses)
            if not transitioned:
                raise RuntimeError(transition_message)
            result_message = f"duplicate of {main_key}; {transition_message}"
            logger.info("重复单 %s 跟随主单 %s 关闭: %s", duplicate_key, main_key, transition_message)
        except Exception as exc:
            success = False
            reason = "REGRESSION_DUPLICATE_CLOSE_ERROR"
            result_message = str(exc)
            logger.warning("重复单 %s 跟随主单 %s 关闭失败: %s", duplicate_key, main_key, exc)

        if hasattr(store, "save_execution_result"):
            store.save_execution_result(
                build_execution_result(
                    run_id=run_id,
                    row_number=None,
                    matched_row=duplicate_row,
                    action="REGRESSION_DUPLICATE_CLOSE",
                    manual_review=False,
                    success=success,
                    reason=reason,
                    result_message=result_message,
                )
            )
        summary_rows.append(
            build_summary_row(
                row_number="",
                matched_row=duplicate_row,
                matched_jira_key=duplicate_key,
                action="REGRESSION_DUPLICATE_CLOSE",
                success=success,
                manual_review=False,
                reason=reason,
                result_message=result_message,
                comment_status="ADDED" if success else "",
            )
        )
        append_result(
            results,
            row_number=0,
            status="SUCCESS" if success else "FAILED",
            project_key=str(main_row.get("affect_project") or ""),
            summary=duplicate_row.get("summary"),
            issue_key=duplicate_key,
            matched_row=duplicate_row,
            decision=type(
                "DuplicateCloseDecisionView",
                (),
                {
                    "action": "REGRESSION_DUPLICATE_CLOSE",
                    "manual_review": False,
                    "update_jira": False,
                    "recreate_issue": False,
                },
            )(),
            error=None if success else result_message,
        )


def process_closed_main_duplicate_followups(
    *,
    jira_client,
    store: Any,
    run_id: str,
    regression_rules: Any,
    snapshot_rows: List[Dict[str, Any]],
    allowed_specialties: set[str] | None,
    args: argparse.Namespace,
    results: List[Dict[str, Any]],
    summary_rows: List[Dict[str, Any]],
) -> None:
    if getattr(args, "dry_run", False):
        return

    status_rules = getattr(regression_rules, "status_rules", None)
    closed_statuses = list(getattr(status_rules, "closed_statuses", []) or [])
    normalized_closed_statuses = {str(item).strip().lower() for item in closed_statuses if str(item).strip()}
    if not normalized_closed_statuses:
        return

    for history_row in snapshot_rows:
        jira_key = str((history_row or {}).get("jira_key") or "").strip()
        if not jira_key:
            continue
        status_text = str((history_row or {}).get("status") or "").strip()
        if status_text.lower() not in normalized_closed_statuses:
            continue
        if allowed_specialties:
            specialty = extract_specialty_from_summary((history_row or {}).get("summary", ""))
            if specialty not in allowed_specialties:
                continue
        close_duplicate_issues_following_main(
            jira_client=jira_client,
            store=store,
            run_id=run_id,
            main_row=dict(history_row),
            closed_statuses=closed_statuses,
            results=results,
            summary_rows=summary_rows,
            only_duplicate_statuses=DUPLICATE_BACKFILL_STATUS_NAMES,
        )


def _get_regression_pass_candidates(
    *,
    store: Any,
    run_id: str,
    snapshot_rows: List[Dict[str, Any]],
    regression_rules: Any,
    matched_jira_keys: set[str],
    allowed_specialties: set[str] | None = None,
) -> List[Dict[str, Any]]:
    status_rules = getattr(regression_rules, "status_rules", None)
    resolved_statuses = list(getattr(status_rules, "resolved_statuses", []) or [])
    resolved_fixed_resolutions = list(getattr(status_rules, "resolved_fixed_resolutions", []) or [])
    if hasattr(store, "fetch_regression_pass_candidates"):
        candidates = list(
            store.fetch_regression_pass_candidates(
                run_id,
                resolved_statuses,
                resolved_fixed_resolutions,
                excluded_jira_keys=sorted(matched_jira_keys),
            )
        )
        if not allowed_specialties:
            return candidates
        return [
            dict(row)
            for row in candidates
            if extract_specialty_from_summary((row or {}).get("summary", "")) in allowed_specialties
        ]

    resolved_status_set = {str(item).strip() for item in resolved_statuses if str(item).strip()}
    resolved_resolution_set = {
        str(item).strip() for item in resolved_fixed_resolutions if str(item).strip()
    }
    candidates: List[Dict[str, Any]] = []
    for row in snapshot_rows:
        jira_key = str(row.get("jira_key") or "").strip()
        if not jira_key or jira_key in matched_jira_keys:
            continue
        if str(row.get("status") or "").strip() not in resolved_status_set:
            continue
        if str(row.get("resolution") or "").strip() not in resolved_resolution_set:
            continue
        if allowed_specialties:
            specialty = extract_specialty_from_summary(row.get("summary", ""))
            if specialty not in allowed_specialties:
                continue
        candidates.append(dict(row))
    return candidates


def process_regression_pass_candidates(
    *,
    jira_client,
    store: Any,
    run_id: str,
    current_version: str,
    regression_rules: Any,
    snapshot_rows: List[Dict[str, Any]],
    matched_jira_keys: set[str],
    allowed_specialties: set[str] | None,
    args: argparse.Namespace,
    results: List[Dict[str, Any]],
    summary_rows: List[Dict[str, Any]],
) -> None:
    regression_config = getattr(regression_rules, "regression", None)
    required_versions = int(getattr(regression_config, "required_regression_pass_versions", 2) or 2)
    closed_statuses = list(getattr(getattr(regression_rules, "status_rules", None), "closed_statuses", []) or [])
    pass_candidates = _get_regression_pass_candidates(
        store=store,
        run_id=run_id,
        snapshot_rows=snapshot_rows,
        regression_rules=regression_rules,
        matched_jira_keys=matched_jira_keys,
        allowed_specialties=allowed_specialties,
    )

    for history_row in pass_candidates:
        jira_key = str(history_row.get("jira_key") or "").strip()
        if not jira_key:
            continue
        issue_state = store.fetch_issue_state(jira_key) if hasattr(store, "fetch_issue_state") else None
        current_pass_count = int((issue_state or {}).get("regression_pass_count") or 0)
        verified_versions = _load_verified_versions((issue_state or {}).get("verified_versions"))
        pass_decision = evaluate_regression_pass(
            pass_count=current_pass_count,
            required_versions=required_versions,
            current_version=current_version,
            fix_version=history_row.get("fix_version"),
            already_verified=verified_versions,
        )
        if pass_decision.action == "REGRESSION_PASS_SKIP":
            reason = pass_decision.reason or "REGRESSION_PASS_SKIP"
            result_message = f"skip: {reason}"
            logger.info(
                "历史单 %s 回归结果: action=%s reason=%s",
                jira_key,
                pass_decision.action,
                reason,
            )
            store.save_execution_result(
                build_execution_result(
                    run_id=run_id,
                    row_number=None,
                    matched_row=history_row,
                    action=pass_decision.action,
                    manual_review=False,
                    success=True,
                    reason=reason,
                    result_message=result_message,
                )
            )
            summary_rows.append(
                build_summary_row(
                    row_number="",
                    matched_row=history_row,
                    matched_jira_key=jira_key,
                    action=pass_decision.action,
                    success=True,
                    manual_review=False,
                    reason=reason,
                    result_message=result_message,
                )
            )
            append_result(
                results,
                row_number=0,
                status="SUCCESS",
                project_key=str(history_row.get("affect_project") or ""),
                summary=history_row.get("summary"),
                issue_key=jira_key,
                matched_row=history_row,
                decision=type(
                    "PassDecisionView",
                    (),
                    {
                        "action": pass_decision.action,
                        "manual_review": False,
                        "update_jira": False,
                        "recreate_issue": False,
                    },
                )(),
                error=None,
            )
            continue

        new_verified_versions = list(verified_versions)
        current_version_text = str(current_version or "").strip()
        if current_version_text and current_version_text not in new_verified_versions:
            new_verified_versions.append(current_version_text)
        specialty = extract_specialty_from_summary(history_row.get("summary", ""))
        result_message = build_regression_pass_comment(
            pass_decision.new_pass_count,
            new_verified_versions,
            specialty=specialty,
            current_version=current_version_text,
        )
        success = True
        reason = "回归PASS判定"
        comment_status = ""
        logger.info(
            "历史单 %s 回归结果: action=%s reason=%s",
            jira_key,
            pass_decision.action,
            reason,
        )

        if not args.dry_run:
            try:
                if pass_decision.comment_required:
                    add_issue_comment(jira_client, jira_key, result_message)
                    comment_status = "ADDED"
                if pass_decision.close_issue:
                    transitioned, transition_message = transition_issue_to_closed(jira_client, jira_key, closed_statuses)
                    if not transitioned:
                        raise RuntimeError(transition_message)
                    result_message = f"{result_message}; {transition_message}"
                    close_duplicate_issues_following_main(
                        jira_client=jira_client,
                        store=store,
                        run_id=run_id,
                        main_row=history_row,
                        closed_statuses=closed_statuses,
                        results=results,
                        summary_rows=summary_rows,
                    )
                if hasattr(store, "record_regression_pass"):
                    store.record_regression_pass(
                        jira_key,
                        current_version_text,
                        pass_decision.new_pass_count,
                        status="已关闭" if pass_decision.close_issue else history_row.get("status"),
                        resolution=history_row.get("resolution"),
                        fix_version=history_row.get("fix_version"),
                        updated_at=datetime.now().isoformat(timespec="seconds"),
                    )
            except Exception as exc:
                success = False
                reason = "REGRESSION_PASS_ERROR"
                result_message = str(exc)
        else:
            result_message = f"dry-run: {pass_decision.action}"

        store.save_execution_result(
            build_execution_result(
                run_id=run_id,
                row_number=None,
                matched_row=history_row,
                action=pass_decision.action,
                manual_review=False,
                success=success,
                reason=reason,
                result_message=result_message,
            )
        )
        summary_rows.append(
            build_summary_row(
                row_number="",
                matched_row=history_row,
                matched_jira_key=jira_key,
                action=pass_decision.action,
                success=success,
                manual_review=False,
                reason=reason,
                result_message=result_message,
                comment_status=comment_status,
            )
        )
        append_result(
            results,
            row_number=0,
            status="SUCCESS" if success else "FAILED",
            project_key=str(history_row.get("affect_project") or ""),
            summary=history_row.get("summary"),
            issue_key=jira_key,
            matched_row=history_row,
            decision=type(
                "PassDecisionView",
                (),
                {
                    "action": pass_decision.action,
                    "manual_review": False,
                    "update_jira": False,
                    "recreate_issue": False,
                },
            )(),
            error=None if success else result_message,
        )


def execute_decision(
    *,
    jira_client,
    row: Any,
    issue_fields: Dict[str, Any],
    decision: Any,
    matched_row: Dict[str, Any] | None,
    priority_mapping_config: Dict[str, Any],
    args: argparse.Namespace,
    row_number: int,
    current_user: str,
    target_assignee: str | None,
) -> Dict[str, Any]:
    action = str(getattr(decision, "action", "") or "")
    issue_key = str((matched_row or {}).get("jira_key") or "").strip() or None
    ps_text = override_reporter_in_ps_text(find_first_value(row, "ps"), current_user)
    result_message = action

    try:
        if matched_row and not getattr(decision, "recreate_issue", False):
            if action == "OPEN_LIKE_UPDATE":
                update_fields = build_update_fields(issue_fields)
                if update_fields:
                    update_issue_fields(jira_client, issue_key, update_fields)
                result_message = f"{action}: updated {issue_key}"
                comment_status = ""
                ps_comment_status = ""
                if getattr(decision, "comment_required", False):
                    comment_result = add_history_issue_comments(
                        jira_client,
                        issue_key,
                        action,
                        row,
                        matched_row,
                        ps_text,
                        bool(getattr(args, "add_comments", False)),
                    )
                    comment_status = str(comment_result.get("comment_status") or "")
                    ps_comment_status = str(comment_result.get("ps_comment_status") or "")
                    result_message = f"{result_message}; commented x{comment_result.get('comment_count', 0)}"
                return {
                    "status": "SUCCESS",
                    "issue_key": issue_key,
                    "result_message": result_message,
                    "comment_status": comment_status,
                    "ps_comment_status": ps_comment_status,
                }

            if action in {"WONT_FIX_KEEP", "RESOLVED_FIXED_WAIT_NEW_VERSION"}:
                comment_status = ""
                ps_comment_status = ""
                if getattr(decision, "comment_required", False):
                    comment_result = add_history_issue_comments(
                        jira_client,
                        issue_key,
                        action,
                        row,
                        matched_row,
                        ps_text,
                        bool(getattr(args, "add_comments", False)),
                    )
                    comment_status = str(comment_result.get("comment_status") or "")
                    ps_comment_status = str(comment_result.get("ps_comment_status") or "")
                    result_message = f"{action}: commented {issue_key} x{comment_result.get('comment_count', 0)}"
                else:
                    result_message = f"{action}: no comment"
                return {
                    "status": "SUCCESS",
                    "issue_key": issue_key,
                    "result_message": result_message,
                    "comment_status": comment_status,
                    "ps_comment_status": ps_comment_status,
                }

            if action == "MANUAL_REVIEW":
                return {"status": "SUCCESS", "issue_key": issue_key, "result_message": f"{action}: no jira change"}

        new_issue = jira_client.create_issue(fields=issue_fields)
        issue_key = str(new_issue.key)
        logger.info("第 %d 行创建成功: %s", row_number, issue_key)
        result_message = f"{action} -> {issue_key}"

        if args.add_comments and ps_text:
            jira_client.add_comment(issue_key, str(ps_text))
            logger.info("第 %d 行已追加评论", row_number)
            ps_comment_status = "ADDED"
        else:
            ps_comment_status = ""

        attachment_name = resolve_bug_severity_attachment_name(
            row,
            priority_mapping_config.get("severity_to_priority", {}),
            priority_mapping_config.get("priority_aliases", {}),
        )
        if attachment_name:
            attachment_path = Path(args.bug_severity_image_dir) / attachment_name
            if attachment_path.exists():
                with open(attachment_path, "rb") as fp:
                    jira_client.add_attachment(issue=issue_key, attachment=fp, filename=attachment_path.name)
                logger.info("第 %d 行已上传问题严重定义附件: %s", row_number, attachment_path.name)
            else:
                logger.warning("第 %d 行缺少问题严重定义附件: %s", row_number, attachment_path)
        else:
            logger.warning("第 %d 行无法根据 Risk/Priority 解析严重定义附件", row_number)

        transitioned, transition_message = transition_issue_to_open(jira_client, issue_key)
        if transitioned:
            logger.info("第 %d 行已执行状态流转: %s", row_number, transition_message)
        else:
            logger.warning("第 %d 行状态流转跳过: %s", row_number, transition_message)

        if target_assignee and current_user and target_assignee != current_user:
            assigned, assign_message = assign_issue_to_user(jira_client, issue_key, target_assignee)
            if assigned:
                logger.info("第 %d 行已回写模块负责人: %s", row_number, assign_message)
            else:
                logger.warning("第 %d 行回写模块负责人失败: %s", row_number, assign_message)

        return {
            "status": "SUCCESS",
            "issue_key": issue_key,
            "result_message": result_message,
            "comment_status": "",
            "ps_comment_status": ps_comment_status,
        }
    except JIRAError as exc:
        error_text = getattr(exc, "text", "") or str(exc)
        logger.error("第 %d 行 Jira 动作执行失败: %s", row_number, error_text)
        return {"status": "FAILED", "issue_key": issue_key, "result_message": error_text, "reason": "JIRA_ERROR"}
    except Exception as exc:
        logger.exception("第 %d 行动作执行失败", row_number)
        return {"status": "FAILED", "issue_key": issue_key, "result_message": str(exc), "reason": "EXCEPTION"}


def is_regression_enabled(regression_rules: Any) -> bool:
    regression_config = getattr(regression_rules, "regression", None)
    return bool(getattr(regression_config, "enabled", True))


def write_run_outputs(
    *,
    results: List[Dict[str, Any]],
    regression_enabled: bool,
    store: Any,
    regression_rules: Any,
    run_id: str,
    summary_rows: List[Dict[str, Any]],
) -> int:
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    RESULT_DIR.mkdir(parents=True, exist_ok=True)
    result_path = RESULT_DIR / f"transsion_jira_batch_create_result_{timestamp}.json"
    with open(result_path, "w", encoding="utf-8") as fp:
        json.dump(results, fp, ensure_ascii=False, indent=2)
    logger.info("结果已写入: %s", result_path)
    if regression_enabled and store is not None:
        excel_summary_dir = Path(getattr(regression_rules.output, "excel_summary_dir", RESULT_DIR))
        if not excel_summary_dir.is_absolute():
            excel_summary_dir = CURRENT_DIR / excel_summary_dir
        excel_summary_dir.mkdir(parents=True, exist_ok=True)
        summary_path = excel_summary_dir / f"transsion_jira_batch_create_summary_{timestamp}.xlsx"
        write_excel_summary(summary_path, summary_rows)
        logger.info("Excel 摘要已写入: %s", summary_path)
        store.save_sync_run(
            {
                "run_id": run_id,
                "finished_at": datetime.now().isoformat(timespec="seconds"),
            }
        )

    success_count = sum(1 for item in results if item["status"] in {"SUCCESS", "DRY_RUN"})
    failed_count = sum(1 for item in results if item["status"] == "FAILED")
    logger.info("处理完成，总计=%d 成功/校验通过=%d 失败=%d", len(results), success_count, failed_count)
    return 0 if failed_count == 0 else 1


def run_excel_mode(args: argparse.Namespace) -> int:
    defaults = load_defaults(args.config_file)
    priority_mapping_config = load_priority_mapping_from_rules_excel(args.severity_rules_file)
    regression_rules = load_regression_rules(DEFAULT_REGRESSION_RULES_FILE)
    regression_enabled = is_regression_enabled(regression_rules) and not bool(getattr(args, "disable_regression", False))
    jira_server = args.jira_server or defaults.get("jira_server")
    wait_between_issues = float(
        args.wait_between_issues
        if args.wait_between_issues is not None
        else defaults.get("default_wait_between_issues_seconds", 5)
    )
    if not args.jira_username or not args.jira_password:
        logger.error("需要提供 Jira 用户名和密码")
        return 1

    df = read_excel_smart(args.excel_file)
    logger.info("已读取上传模板 %d 条，列: %s", len(df), list(df.columns))
    if not validate_upload_excel(df):
        return 1
    summary_keywords = collect_regression_summary_keywords(df)
    batch_specialties = collect_batch_specialties(df)

    jira = connect_to_jira(jira_server, args.jira_username, args.jira_password)
    current_user = str(jira.current_user() or "").strip()
    logger.info("Jira 连接成功，当前用户: %s", current_user)
    project_cache: Dict[str, str] = {}
    try:
        batch_project_key = collect_batch_project_key(jira, df, project_cache)
    except ValueError as exc:
        logger.error(str(exc))
        return 1
    regression_base_jql = build_regression_base_jql(
        batch_project_key,
        override_reporter_in_jql(getattr(getattr(regression_rules, "jira_export", None), "jql", ""), current_user),
    )

    run_id = datetime.now().strftime("%Y%m%d_%H%M%S")
    store = None
    snapshot_rows: List[Dict[str, Any]] = []
    if regression_enabled:
        store = RegressionStore(
            build_project_scoped_sqlite_path(
                batch_project_key,
                getattr(regression_rules.output, "sqlite_path", "result/regression_cache"),
            )
        )
        snapshot_field_mapping = build_snapshot_field_mapping(defaults)
        snapshot_rows = export_jira_snapshot(
            jira,
            regression_rules,
            base_jql=regression_base_jql,
            summary_keywords=summary_keywords,
            field_mapping=snapshot_field_mapping,
        )
        store.save_sync_run(
            {
                "run_id": run_id,
                "started_at": datetime.now().isoformat(timespec="seconds"),
                "jql": build_regression_export_jql(regression_base_jql, summary_keywords),
            }
        )
        store.save_snapshot(run_id, snapshot_rows)

    meta_cache: Dict[Tuple[str, str], Dict[str, Any]] = {}
    user_cache: Dict[str, str] = {}
    results: List[Dict[str, Any]] = []
    summary_rows: List[Dict[str, Any]] = []
    matched_history_keys: set[str] = set()

    if args.validate_metadata:
        seen: set[Tuple[str, str]] = set()
        for _, row in df.iterrows():
            project_key = str(resolve_project_key(jira, find_first_value(row, "project", defaults.get("project_key")), project_cache))
            issue_type_name = str(find_first_value(row, "issue_type", defaults.get("issue_type", "故障")))
            cache_key = (project_key, issue_type_name)
            if cache_key in seen:
                continue
            seen.add(cache_key)
            bundle = get_meta_bundle(jira, project_key, issue_type_name, meta_cache)
            log_required_fields(project_key, issue_type_name, bundle["create_fields"])
            logger.info("字段名映射: %s", json.dumps(bundle["field_name_lookup"], ensure_ascii=False))
        return 0

    for index, row in df.iterrows():
        row_number = index + 1
        project_key = str(resolve_project_key(jira, find_first_value(row, "project", defaults.get("project_key")), project_cache))
        issue_type_name = str(find_first_value(row, "issue_type", defaults.get("issue_type", "故障")))
        summary = find_first_value(row, "summary", "未指定概要")
        matched_row: Dict[str, Any] | None = None
        decision: Any = type("DecisionFallback", (), {
            "action": "FAILED",
            "manual_review": False,
            "update_jira": False,
            "recreate_issue": False,
        })()

        try:
            regression_row = build_regression_row(row)
            if regression_enabled:
                matched_row = find_regression_match(regression_row, snapshot_rows, regression_rules.matching)
                if matched_row and str((matched_row or {}).get("jira_key") or "").strip():
                    matched_history_keys.add(str(matched_row.get("jira_key")).strip())
            decision = decide_action(
                regression_row,
                matched_row or {},
                current_version=regression_row.get("current_version", ""),
            )
            requires_issue_fields = bool(
                getattr(decision, "update_jira", False) or getattr(decision, "recreate_issue", False)
            )
            issue_fields: Dict[str, Any] = {}
            target_assignee: str | None = None
            if requires_issue_fields:
                bundle = get_meta_bundle(jira, project_key, issue_type_name, meta_cache)
                target_assignee_raw = find_first_value(row, "assignee", defaults.get("default_assignee"))
                target_assignee = resolve_user_name(
                    jira,
                    target_assignee_raw,
                    user_cache,
                    fallback=defaults.get("default_assignee"),
                )
                issue_fields = build_issue_fields(
                    jira_client=jira,
                    row=row,
                    defaults=defaults,
                    create_fields=bundle["create_fields"],
                    allowed_values=bundle["allowed_values"],
                    severity_to_priority_mapping=priority_mapping_config.get("severity_to_priority", {}),
                    priority_alias_mapping=priority_mapping_config.get("priority_aliases", {}),
                    user_cache=user_cache,
                    project_cache=project_cache,
                    create_assignee_override=current_user,
                    create_reporter_override=current_user,
                )
            reason = "命中历史单" if matched_row else "未命中历史单"
            logger.info("第 %d 行准备处理: [%s] %s", row_number, project_key, summary)

            if args.dry_run:
                dry_run_message = f"dry-run: {getattr(decision, 'action', '')}"
                logger.info(
                    "第 %d 行 dry-run结果: matched_jira_key=%s action=%s reason=%s",
                    row_number,
                    str((matched_row or {}).get("jira_key") or "").strip() or "NONE",
                    str(getattr(decision, "action", "") or ""),
                    reason,
                )
                if regression_enabled and store is not None:
                    store.save_execution_result(
                        build_execution_result(
                            run_id=run_id,
                            row_number=row_number,
                            matched_row=matched_row,
                            action=getattr(decision, "action", ""),
                            manual_review=bool(getattr(decision, "manual_review", False)),
                            success=True,
                            reason=reason,
                            result_message=dry_run_message,
                        )
                    )
                    summary_rows.append(
                        build_summary_row(
                            row_number=row_number,
                            matched_row=matched_row,
                            matched_jira_key=str((matched_row or {}).get("jira_key") or ""),
                            action=str(getattr(decision, "action", "") or ""),
                            success=True,
                            manual_review=bool(getattr(decision, "manual_review", False)),
                            reason=reason,
                            result_message=dry_run_message,
                        )
                    )
                append_result(
                    results,
                    row_number=row_number,
                    status="DRY_RUN",
                    project_key=project_key,
                    summary=summary,
                    issue_key=None,
                    matched_row=matched_row,
                    decision=decision,
                    error=None,
                )
                continue

            issue_key: str | None = None
            execution_outcome = execute_decision(
                jira_client=jira,
                row=row,
                issue_fields=issue_fields,
                decision=decision,
                matched_row=matched_row,
                priority_mapping_config=priority_mapping_config,
                args=args,
                row_number=row_number,
                current_user=current_user,
                target_assignee=target_assignee,
            )
            result_status = str(execution_outcome.get("status") or "SUCCESS")
            issue_key = execution_outcome.get("issue_key")
            result_message = str(execution_outcome.get("result_message") or getattr(decision, "action", ""))
            success_flag = result_status != "FAILED"
            outcome_reason = str(execution_outcome.get("reason") or reason)
            matched_jira_key = str(
                ((matched_row or {}).get("jira_key"))
                or (issue_key or "")
            )
            logger.info(
                "第 %d 行执行结果: matched_jira_key=%s action=%s reason=%s status=%s result=%s",
                row_number,
                matched_jira_key or "NONE",
                str(getattr(decision, "action", "") or ""),
                outcome_reason,
                result_status,
                result_message,
            )

            if regression_enabled and store is not None:
                store.save_execution_result(
                    build_execution_result(
                        run_id=run_id,
                        row_number=row_number,
                        matched_row=matched_row if matched_row else ({"jira_key": issue_key} if issue_key else None),
                        action=getattr(decision, "action", ""),
                        manual_review=bool(getattr(decision, "manual_review", False)),
                        success=success_flag,
                        reason=outcome_reason,
                        result_message=result_message,
                    )
                )
                summary_rows.append(
                    build_summary_row(
                        row_number=row_number,
                        matched_row=matched_row,
                        matched_jira_key=matched_jira_key,
                        action=str(getattr(decision, "action", "") or ""),
                        success=success_flag,
                        manual_review=bool(getattr(decision, "manual_review", False)),
                        reason=outcome_reason,
                        result_message=result_message,
                        comment_status=str(execution_outcome.get("comment_status") or ""),
                        ps_comment_status=str(execution_outcome.get("ps_comment_status") or ""),
                    )
                )
            append_result(
                results,
                row_number=row_number,
                status=result_status,
                project_key=project_key,
                summary=summary,
                issue_key=issue_key,
                matched_row=matched_row,
                decision=decision,
                error=None if success_flag else result_message,
            )
        except JIRAError as exc:
            error_text = getattr(exc, "text", "") or str(exc)
            logger.error("第 %d 行 Jira 创建失败: %s", row_number, error_text)
            if regression_enabled and store is not None:
                store.save_execution_result(
                    build_execution_result(
                        run_id=run_id,
                        row_number=row_number,
                        matched_row=matched_row,
                        action=str(getattr(decision, "action", "FAILED") or "FAILED"),
                        manual_review=bool(getattr(decision, "manual_review", False)),
                        success=False,
                        reason="JIRA_ERROR",
                        result_message=error_text,
                    )
                )
                summary_rows.append(
                    build_summary_row(
                        row_number=row_number,
                        matched_row=matched_row,
                        matched_jira_key=str((matched_row or {}).get("jira_key") or ""),
                        action=str(getattr(decision, "action", "FAILED") or "FAILED"),
                        success=False,
                        manual_review=bool(getattr(decision, "manual_review", False)),
                        reason="JIRA_ERROR",
                        result_message=error_text,
                    )
                )
            append_result(
                results,
                row_number=row_number,
                status="FAILED",
                project_key=project_key,
                summary=summary,
                issue_key=None,
                matched_row=matched_row,
                decision=decision,
                error=error_text,
            )
        except Exception as exc:
            logger.exception("第 %d 行处理失败", row_number)
            if regression_enabled and store is not None:
                store.save_execution_result(
                    build_execution_result(
                        run_id=run_id,
                        row_number=row_number,
                        matched_row=matched_row,
                        action=str(getattr(decision, "action", "FAILED") or "FAILED"),
                        manual_review=bool(getattr(decision, "manual_review", False)),
                        success=False,
                        reason="EXCEPTION",
                        result_message=str(exc),
                    )
                )
                summary_rows.append(
                    build_summary_row(
                        row_number=row_number,
                        matched_row=matched_row,
                        matched_jira_key=str((matched_row or {}).get("jira_key") or ""),
                        action=str(getattr(decision, "action", "FAILED") or "FAILED"),
                        success=False,
                        manual_review=bool(getattr(decision, "manual_review", False)),
                        reason="EXCEPTION",
                        result_message=str(exc),
                    )
                )
            append_result(
                results,
                row_number=row_number,
                status="FAILED",
                project_key=project_key,
                summary=summary,
                issue_key=None,
                matched_row=matched_row,
                decision=decision,
                error=str(exc),
            )

        if not args.dry_run and wait_between_issues > 0 and index < len(df) - 1:
            logger.info("第 %d 行处理完成，等待 %.1f 秒后继续下一条", row_number, wait_between_issues)
            time.sleep(wait_between_issues)

    if regression_enabled and store is not None:
        process_regression_pass_candidates(
            jira_client=jira,
            store=store,
            run_id=run_id,
            current_version=select_current_version(
                [str(find_first_value(row, "versions", "") or "").strip() for _, row in df.iterrows()]
            ),
            regression_rules=regression_rules,
            snapshot_rows=snapshot_rows,
            matched_jira_keys=matched_history_keys,
            allowed_specialties=batch_specialties,
            args=args,
            results=results,
            summary_rows=summary_rows,
        )
        process_closed_main_duplicate_followups(
            jira_client=jira,
            store=store,
            run_id=run_id,
            regression_rules=regression_rules,
            snapshot_rows=snapshot_rows,
            allowed_specialties=batch_specialties,
            args=args,
            results=results,
            summary_rows=summary_rows,
        )
    return write_run_outputs(
        results=results,
        regression_enabled=regression_enabled,
        store=store,
        regression_rules=regression_rules,
        run_id=run_id,
        summary_rows=summary_rows,
    )


def run_regression_verify_mode(args: argparse.Namespace) -> int:
    defaults = load_defaults(args.config_file)
    regression_rules = load_regression_rules(DEFAULT_REGRESSION_RULES_FILE)
    regression_enabled = is_regression_enabled(regression_rules) and not bool(getattr(args, "disable_regression", False))
    if not regression_enabled:
        logger.error("回归验证模式要求回归功能处于开启状态")
        return 1

    jira_server = args.jira_server or defaults.get("jira_server")
    if not args.jira_username or not args.jira_password:
        logger.error("需要提供 Jira 用户名和密码")
        return 1

    project_key = str(args.regression_project or "").strip()
    specialties = [str(item).strip() for item in (args.regression_specialties or []) if str(item).strip()]
    current_version = str(args.current_version or "").strip()
    history_reporter = str(args.history_reporter or "").strip()
    if args.validate_metadata:
        logger.warning("回归验证模式忽略 --validate-metadata")

    jira = connect_to_jira(jira_server, args.jira_username, args.jira_password)
    current_user = str(jira.current_user() or "").strip()
    logger.info("Jira 连接成功，当前用户: %s", current_user)
    logger.info("回归验证模式: project=%s reporter=%s current_version=%s", project_key, history_reporter, current_version)

    run_id = datetime.now().strftime("%Y%m%d_%H%M%S")
    store = RegressionStore(
        build_project_scoped_sqlite_path(
            project_key,
            getattr(regression_rules.output, "sqlite_path", "result/regression_cache"),
        )
    )
    snapshot_field_mapping = build_snapshot_field_mapping(defaults)
    all_snapshot_rows: List[Dict[str, Any]] = []
    built_jqls: List[str] = []
    base_jql = build_regression_base_jql(project_key, f"reporter in ({history_reporter})")
    for specialty in specialties:
        built_jql = build_regression_verify_jql(project_key, history_reporter, specialty)
        built_jqls.append(built_jql)
        logger.info("专项 %s 使用 JQL: %s", specialty, built_jql)
        summary_keyword = resolve_regression_verify_summary_keyword(specialty)
        all_snapshot_rows.extend(
            export_jira_snapshot(
                jira,
                regression_rules,
                base_jql=base_jql,
                summary_keywords=[summary_keyword],
                field_mapping=snapshot_field_mapping,
            )
        )

    snapshot_rows = deduplicate_snapshot_rows_by_jira_key(all_snapshot_rows)
    store.save_sync_run(
        {
            "run_id": run_id,
            "started_at": datetime.now().isoformat(timespec="seconds"),
            "jql": "\n".join(built_jqls),
            "current_version": current_version,
        }
    )
    store.save_snapshot(run_id, snapshot_rows)

    results: List[Dict[str, Any]] = []
    summary_rows: List[Dict[str, Any]] = []
    process_regression_pass_candidates(
        jira_client=jira,
        store=store,
        run_id=run_id,
        current_version=current_version,
        regression_rules=regression_rules,
        snapshot_rows=snapshot_rows,
        matched_jira_keys=set(),
        allowed_specialties=set(specialties),
        args=args,
        results=results,
        summary_rows=summary_rows,
    )
    process_closed_main_duplicate_followups(
        jira_client=jira,
        store=store,
        run_id=run_id,
        regression_rules=regression_rules,
        snapshot_rows=snapshot_rows,
        allowed_specialties=set(specialties),
        args=args,
        results=results,
        summary_rows=summary_rows,
    )
    return write_run_outputs(
        results=results,
        regression_enabled=regression_enabled,
        store=store,
        regression_rules=regression_rules,
        run_id=run_id,
        summary_rows=summary_rows,
    )


def run_batch_create(args: argparse.Namespace) -> int:
    mode = resolve_run_mode(args)
    if mode == "regression_verify":
        return run_regression_verify_mode(args)
    return run_excel_mode(args)


def main() -> int:
    setup_logging()
    args = parse_args()
    return run_batch_create(args)


if __name__ == "__main__":
    sys.exit(main())
