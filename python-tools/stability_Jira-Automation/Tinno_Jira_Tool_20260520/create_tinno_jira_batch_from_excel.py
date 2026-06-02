#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Tinno Jira 批量建单脚本
----------------------

基于 `Transsion_Jira_Tool_20260323` 的第二阶段结构迁移。
当前版本优先落地：
- Tinno P12 认证
- 已确认的自定义字段
- PS 评论追加
- 本地项目缓存库与 build_version 落库
- 可配置的 Tinno 回归匹配、结构化 PASS/FAIL 备注与审计输出
"""

from __future__ import annotations

import argparse
import json
import logging
import os
import re
import sqlite3
import sys
import time
from datetime import datetime
from pathlib import Path
from typing import Any, Dict, List, Tuple
from urllib.parse import urlparse

import pandas as pd

CURRENT_DIR = Path(__file__).resolve().parent
PROJECT_ROOT = CURRENT_DIR.parent
SRC_DIR = PROJECT_ROOT / "src"
if str(CURRENT_DIR) not in sys.path:
    sys.path.insert(0, str(CURRENT_DIR))
if str(PROJECT_ROOT) not in sys.path:
    sys.path.insert(0, str(PROJECT_ROOT))
if str(SRC_DIR) not in sys.path:
    sys.path.insert(0, str(SRC_DIR))

from tinno_batch_jira_common import (
    add_issue_comment,
    build_field_name_lookup,
    build_issue_fields,
    clean_cell_value,
    connect_to_jira,
    extract_allowed_values,
    fetch_issue_snapshot_fields,
    find_first_value,
    get_create_meta_fields,
    resolve_project_key,
    transition_issue_to_closed,
    update_issue_fields,
)
from tinno_upload_template_common import (
    build_upload_rows as build_test_upload_rows,
    load_affect_project_mapping as load_upload_affect_project_mapping,
    load_package_owner_mapping as load_upload_package_owner_mapping,
    load_severity_rules as load_upload_severity_rules,
    load_test_case_summary as load_upload_test_case_summary,
    save_upload_list as save_generated_upload_list,
)
from tinno_regression_executor import decide_action, evaluate_regression_pass
from tinno_regression_matcher import is_strong_match
from tinno_regression_models import load_regression_rules
from tinno_regression_report import write_excel_summary
from tinno_regression_store import RegressionStore
from src.modules.database_manager import DatabaseManager

logger = logging.getLogger(__name__)

CONFIG_DIR = CURRENT_DIR / "config"
LOG_DIR = CURRENT_DIR / "log"
RESULT_DIR = CURRENT_DIR / "result"
DEFAULT_CONFIG_FILE = CONFIG_DIR / "tinno_jira_defaults.json"
DEFAULT_REGRESSION_RULES_FILE = CONFIG_DIR / "regression_rules.json"
DEFAULT_REGRESSION_COMMENT_CONFIG_FILE = CONFIG_DIR / "regression_comment_config.json"
DEFAULT_PACKAGE_MAPPING = CONFIG_DIR / "包名与模块&经办人对应表_tinno.xls"
DEFAULT_SEVERITY_RULES = CONFIG_DIR / "问题等级定级表.xls"
DEFAULT_AFFECT_PROJECT_MAPPING = CONFIG_DIR / "affect_project_mapping.json"
DEFAULT_TEST_CASE_SUMMARY = CONFIG_DIR / "稳定性专项汇总.xlsx"
DEFAULT_LOCAL_ENV_FILE = CURRENT_DIR / ".env.local"
DEFAULT_PROJECT_HISTORY_SQLITE_PATH = "result/tinno_regression_cache"
DEFAULT_TEST_MODE_MAIN_EXCEL = CURRENT_DIR / "resource" / "Result_None_None_MonkeyAEE_SH_20260521.xls"
DEFAULT_TEST_MODE_PROJECT_KEY = "VCAME"
DEFAULT_TEST_MODE_MODULE = "AUTOTEST"
DEFAULT_TEST_MODE_OUTPUT_PREFIX = "JIRA_Upload_List_Tinno_Test"
TINNO_TEST_COOKIE_JSESSIONID_ENV = "TINNO_TEST_JIRA_COOKIE_JSESSIONID"
TINNO_TEST_COOKIE_XSRF_TOKEN_ENV = "TINNO_TEST_JIRA_COOKIE_XSRF_TOKEN"
DUPLICATE_FOLLOW_CLOSE_COMMENT = "跟随主单一同关闭。"
DUPLICATE_LINK_KEYWORDS = ("duplicate", "duplicates", "duplicated", "重复")
DUPLICATE_CUSTOM_FIELD_KEYS = ("customfield_14207",)
DUPLICATE_BACKFILL_STATUS_NAMES = {"verified"}
_REGRESSION_COMMENT_CONFIG_CACHE: Dict[str, Any] | None = None


def load_local_env(env_file: str | Path = DEFAULT_LOCAL_ENV_FILE, override: bool = False) -> None:
    path = Path(env_file)
    if not path.exists():
        return

    for raw_line in path.read_text(encoding="utf-8").splitlines():
        line = raw_line.strip()
        if not line or line.startswith("#"):
            continue
        if line.startswith("export "):
            line = line[7:].strip()
        key, separator, value = line.partition("=")
        if not separator:
            continue
        env_key = key.strip()
        env_value = value.strip()
        if len(env_value) >= 2 and env_value[0] == env_value[-1] and env_value[0] in {"'", '"'}:
            env_value = env_value[1:-1]
        if override or not os.getenv(env_key):
            os.environ[env_key] = env_value


def setup_logging() -> None:
    LOG_DIR.mkdir(parents=True, exist_ok=True)
    logging.basicConfig(
        level=logging.INFO,
        format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
        handlers=[
            logging.StreamHandler(),
            logging.FileHandler(LOG_DIR / "create_tinno_jira_batch_from_excel.log", encoding="utf-8"),
        ],
    )


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Tinno Jira 批量建单脚本（优先使用 Cookie，失效后回退到账号密码）")
    parser.add_argument("--add-excel-file", dest="excel_file", default=None, help="上传模板 Excel 路径")
    parser.add_argument("--regression-project", dest="regression_project", default=None, help="回归验证模式项目 Key")
    parser.add_argument(
        "--regression-specialty",
        dest="regression_specialties",
        action="append",
        default=[],
        help="回归验证模式专项名称，支持重复传参；可传专项名或标题中的专项标识",
    )
    parser.add_argument("--current-version", dest="current_version", default=None, help="回归验证模式当前版本")
    parser.add_argument("--history-reporter", dest="history_reporter", default=None, help="回归验证模式历史单 reporter")
    parser.add_argument("--test-mode", action="store_true", help="VCAME 测试模式：优先读取本地测试 Cookie，并可基于默认 Monkey 报告自动生成上传模板")
    parser.add_argument("--create-only", action="store_true", help="仅新建问题单并同步本地项目数据库，不做回归匹配与验证")
    parser.add_argument("--disable-regression", action="store_true", help="关闭最小回归匹配与 PASS 验证")
    parser.add_argument("--jira-username", dest="jira_username", default=os.getenv("JIRA_USERNAME"), help="Jira 用户名（Cookie 失效时用于回退登录）")
    parser.add_argument("--jira-password", dest="jira_password", default=os.getenv("JIRA_PASSWORD"), help="Jira 密码（Cookie 失效时用于回退登录）")
    parser.add_argument("--jira-server", dest="jira_server", default=None, help="Jira 服务地址")
    parser.add_argument("--jira-p12-path", dest="jira_p12_path", default=os.getenv("JIRA_P12_PATH"), help="P12 证书路径")
    parser.add_argument("--jira-p12-password", dest="jira_p12_password", default=os.getenv("JIRA_P12_PASSWORD"), help="P12 证书密码")
    parser.add_argument("--jira-cookie-string", dest="jira_cookie_string", default=os.getenv("JIRA_COOKIE_STRING"), help="完整 Cookie 字符串，优先于账号密码登录")
    parser.add_argument("--jira-cookie-jsessionid", dest="jira_cookie_jsessionid", default=os.getenv("JIRA_COOKIE_JSESSIONID"), help="JSESSIONID，优先于账号密码登录")
    parser.add_argument("--jira-cookie-xsrf-token", dest="jira_cookie_xsrf_token", default=os.getenv("JIRA_COOKIE_XSRF_TOKEN"), help="atlassian.xsrf.token，优先于账号密码登录")
    parser.add_argument("--config-file", dest="config_file", default=str(DEFAULT_CONFIG_FILE), help="默认配置路径")
    parser.add_argument("--dry-run", action="store_true", help="仅组装字段，不实际建单")
    parser.add_argument("--validate-metadata", action="store_true", help="读取 Create Meta 并打印")
    parser.add_argument("--add-comments", action="store_true", help="创建成功后把 PS 列追加为评论")
    parser.add_argument("--wait-between-issues", dest="wait_between_issues", type=float, default=0.5, help="每条问题之间的等待秒数")
    return parser.parse_args()


def read_excel_smart(file_path: str | Path) -> pd.DataFrame:
    path = Path(file_path)
    if not path.exists():
        raise FileNotFoundError(f"Excel 文件不存在: {path}")
    if path.suffix.lower() == ".xlsx":
        return pd.read_excel(path, engine="openpyxl")
    return pd.read_excel(path)


def load_defaults(config_file: str | Path) -> Dict[str, Any]:
    with open(config_file, "r", encoding="utf-8") as fp:
        return json.load(fp)


def resolve_test_mode_user(args: argparse.Namespace, defaults: Dict[str, Any]) -> str:
    for candidate in (
        getattr(args, "history_reporter", None),
        getattr(args, "jira_username", None),
        os.getenv("JIRA_USERNAME"),
        os.getenv("JIRA_REPORTER"),
        defaults.get("default_reporter"),
        defaults.get("default_assignee"),
    ):
        user_name = str(candidate or "").strip()
        if user_name:
            return user_name
    return "dai.lv"


def apply_test_mode_defaults(args: argparse.Namespace, defaults: Dict[str, Any]) -> None:
    if not bool(getattr(args, "test_mode", False)):
        return
    if not hasattr(args, "regression_specialties") or args.regression_specialties is None:
        args.regression_specialties = []
    if not args.jira_server:
        args.jira_server = str(defaults.get("jira_server") or "https://jira.tinno.com")
    if not args.jira_cookie_jsessionid:
        args.jira_cookie_jsessionid = str(
            os.getenv(TINNO_TEST_COOKIE_JSESSIONID_ENV) or os.getenv("JIRA_COOKIE_JSESSIONID") or ""
        ).strip() or None
    if not args.jira_cookie_xsrf_token:
        args.jira_cookie_xsrf_token = str(
            os.getenv(TINNO_TEST_COOKIE_XSRF_TOKEN_ENV) or os.getenv("JIRA_COOKIE_XSRF_TOKEN") or ""
        ).strip() or None
    if not args.history_reporter:
        args.history_reporter = resolve_test_mode_user(args, defaults)
    if not args.regression_specialties:
        default_specialty = resolve_regression_specialty(defaults.get("default_test_case"), defaults)
        if default_specialty:
            args.regression_specialties = [default_specialty]


def build_test_mode_upload_rows(defaults: Dict[str, Any], args: argparse.Namespace) -> List[Dict[str, Any]]:
    source_df = read_excel_smart(DEFAULT_TEST_MODE_MAIN_EXCEL)
    package_mapping = load_upload_package_owner_mapping(DEFAULT_PACKAGE_MAPPING)
    severity_rules = load_upload_severity_rules(DEFAULT_SEVERITY_RULES)
    affect_project_mapping = load_upload_affect_project_mapping(DEFAULT_AFFECT_PROJECT_MAPPING)
    test_case_summary_mapping = load_upload_test_case_summary(DEFAULT_TEST_CASE_SUMMARY)
    current_user = resolve_test_mode_user(args, defaults)
    return build_test_upload_rows(
        main_df=source_df,
        defaults=defaults,
        package_mapping=package_mapping,
        severity_rules=severity_rules,
        affect_project_mapping=affect_project_mapping,
        test_case_summary_mapping=test_case_summary_mapping,
        reporter_override=current_user,
        assignee_override=current_user,
        project_override=DEFAULT_TEST_MODE_PROJECT_KEY,
        module_override=DEFAULT_TEST_MODE_MODULE,
        default_test_case=str(defaults.get("default_test_case") or "Monkey专项"),
        source_excel_path=str(DEFAULT_TEST_MODE_MAIN_EXCEL),
    )


def ensure_test_mode_upload_excel(args: argparse.Namespace, defaults: Dict[str, Any]) -> Path:
    rows = build_test_mode_upload_rows(defaults, args)
    if not rows:
        raise RuntimeError("测试模式未生成任何 Tinno 上传记录")
    RESULT_DIR.mkdir(parents=True, exist_ok=True)
    output_path = RESULT_DIR / f"{DEFAULT_TEST_MODE_OUTPUT_PREFIX}_{datetime.now().strftime('%Y%m%d_%H%M%S')}.xlsx"
    return save_generated_upload_list(rows, output_path)


def infer_test_mode_current_version(args: argparse.Namespace, defaults: Dict[str, Any]) -> str:
    rows = build_test_mode_upload_rows(defaults, args)
    version_candidates = [str(row.get("Versions") or "").strip() for row in rows if str(row.get("Versions") or "").strip()]
    return select_current_version(version_candidates)


def validate_upload_excel(df: pd.DataFrame) -> bool:
    required_fields = ["Summary", "Description"]
    missing = [item for item in required_fields if item not in df.columns]
    if missing:
        logger.error("上传模板缺少必填列: %s", ", ".join(missing))
        return False
    return True


def save_results(results: List[Dict[str, Any]]) -> Path:
    RESULT_DIR.mkdir(parents=True, exist_ok=True)
    target = RESULT_DIR / f"tinno_jira_batch_create_result_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
    with target.open("w", encoding="utf-8") as fp:
        json.dump(results, fp, ensure_ascii=False, indent=2)
    return target


def load_regression_comment_config(path: str | Path = DEFAULT_REGRESSION_COMMENT_CONFIG_FILE) -> Dict[str, Any]:
    global _REGRESSION_COMMENT_CONFIG_CACHE
    config_path = Path(path)
    if _REGRESSION_COMMENT_CONFIG_CACHE is not None and config_path == DEFAULT_REGRESSION_COMMENT_CONFIG_FILE:
        return dict(_REGRESSION_COMMENT_CONFIG_CACHE)

    with config_path.open("r", encoding="utf-8") as fp:
        data = json.load(fp)
    if not isinstance(data, dict):
        raise ValueError("回归备注配置必须是 JSON 对象")

    common = data.get("common", {}) or {}
    if not isinstance(common, dict):
        raise ValueError("回归备注配置 common 必须是对象")

    pass_template = str(data.get("pass_template") or "").strip()
    fail_template = str(data.get("fail_template") or "").strip()
    if not pass_template or not fail_template:
        raise ValueError("回归备注配置缺少 pass_template 或 fail_template")

    normalized = {
        "common": {
            "device_mark": str(common.get("device_mark") or "PR1").strip() or "PR1",
            "tester_contact": str(common.get("tester_contact") or "吕代+18379465576").strip() or "吕代+18379465576",
            "pass_test_count": str(common.get("pass_test_count") or "0/1000").strip() or "0/1000",
        },
        "pass_template": pass_template,
        "fail_template": fail_template,
    }
    if config_path == DEFAULT_REGRESSION_COMMENT_CONFIG_FILE:
        _REGRESSION_COMMENT_CONFIG_CACHE = dict(normalized)
    return normalized


def _resolve_comment_config(comment_config: Dict[str, Any] | None = None) -> Dict[str, Any]:
    return dict(comment_config or load_regression_comment_config())


def _render_regression_comment(template: str, values: Dict[str, Any]) -> str:
    return str(template).format(**values)


def build_project_scoped_sqlite_path(project_key: str, sqlite_path_setting: Any) -> Path:
    project_text = str(project_key or "").strip()
    if not project_text:
        raise ValueError("project_key 不能为空")
    base_path = Path(str(sqlite_path_setting or "result/tinno_regression_cache"))
    if not base_path.is_absolute():
        base_path = CURRENT_DIR / base_path
    if base_path.suffix.lower() == ".db":
        base_path = base_path.parent
    return base_path / f"{project_text}.db"


def parse_jira_host(jira_url: str) -> str:
    parsed = urlparse(str(jira_url or "").strip())
    netloc = parsed.netloc or parsed.path
    parts = [item for item in netloc.split(".") if item]
    if len(parts) >= 2:
        if parts[0].lower() == "jira":
            return parts[1]
        return parts[0]
    return netloc.replace(".", "_")


def build_project_history_db_path(
    jira_server: str,
    project_key: str,
    sqlite_path_setting: Any = DEFAULT_PROJECT_HISTORY_SQLITE_PATH,
) -> Path:
    project_text = str(project_key or "").strip()
    if not project_text:
        raise ValueError("project_key 不能为空")
    return build_project_scoped_sqlite_path(project_text, sqlite_path_setting)


def build_legacy_project_history_db_path(jira_server: str, project_key: str) -> Path:
    project_text = str(project_key or "").strip()
    if not project_text:
        raise ValueError("project_key 不能为空")
    jira_host = parse_jira_host(jira_server)
    return PROJECT_ROOT / "db" / f"{jira_host}_{project_text}.db"


def migrate_legacy_project_history_db(project_db: DatabaseManager | None, legacy_db_path: str | Path) -> int:
    if project_db is None:
        return 0

    legacy_path = Path(legacy_db_path)
    target_path = Path(str(getattr(project_db, "db_path", "") or "")).resolve()
    if not legacy_path.exists():
        return 0
    if legacy_path.resolve() == target_path:
        return 0

    migrated_count = 0
    with sqlite3.connect(str(legacy_path)) as legacy_conn:
        legacy_conn.row_factory = sqlite3.Row
        cursor = legacy_conn.cursor()
        cursor.execute("SELECT name FROM sqlite_master WHERE type='table' AND name='jira_issues_main'")
        if cursor.fetchone() is None:
            return 0
        cursor.execute("SELECT * FROM jira_issues_main ORDER BY id")
        for row in cursor.fetchall():
            record = dict(row)
            jira_key = str(record.get("jira_key") or "").strip()
            if not jira_key:
                continue
            if project_db.get_issue_by_key(jira_key):
                continue
            project_db.insert_issue(record)
            migrated_count += 1
    return migrated_count


def get_project_history_issue(project_db: DatabaseManager | None, jira_key: str) -> Dict[str, Any] | None:
    if project_db is None:
        return None
    issue_key = str(jira_key or "").strip()
    if not issue_key:
        return None
    return project_db.get_issue_by_key(issue_key)


def backfill_issue_state_from_project_history(store: RegressionStore | None, project_db: DatabaseManager | None) -> int:
    if store is None or project_db is None:
        return 0

    rows = project_db.execute(
        """
        SELECT jira_key, status, resolution, fix_version, build_version, version,
               regression_pass_count, verified_versions
        FROM jira_issues_main
        ORDER BY id
        """
    )
    updated_count = 0
    for row in rows or []:
        record = dict(row)
        jira_key = str(record.get("jira_key") or "").strip()
        if not jira_key:
            continue
        issue_state = store.fetch_issue_state(jira_key) or {}
        payload: Dict[str, Any] = {"jira_key": jira_key}

        for source_key, target_key in (
            ("status", "status"),
            ("resolution", "resolution"),
            ("fix_version", "fix_version"),
            ("build_version", "build_version"),
        ):
            source_value = str(record.get(source_key) or "").strip()
            if source_value:
                payload[target_key] = source_value

        last_seen_version = str(record.get("version") or "").strip()
        if last_seen_version:
            payload["last_seen_version"] = last_seen_version

        regression_pass_count = record.get("regression_pass_count")
        if regression_pass_count is not None:
            payload["regression_pass_count"] = int(regression_pass_count or 0)

        verified_versions = record.get("verified_versions")
        if verified_versions not in (None, ""):
            payload["verified_versions"] = verified_versions

        normalized_existing = {
            "status": str(issue_state.get("status") or "").strip(),
            "resolution": str(issue_state.get("resolution") or "").strip(),
            "fix_version": str(issue_state.get("fix_version") or "").strip(),
            "build_version": str(issue_state.get("build_version") or "").strip(),
            "last_seen_version": str(issue_state.get("last_seen_version") or "").strip(),
            "regression_pass_count": int(issue_state.get("regression_pass_count") or 0),
            "verified_versions": json.dumps(_load_verified_versions(issue_state.get("verified_versions")), ensure_ascii=True),
        }
        normalized_payload = {
            "status": str(payload.get("status") or "").strip(),
            "resolution": str(payload.get("resolution") or "").strip(),
            "fix_version": str(payload.get("fix_version") or "").strip(),
            "build_version": str(payload.get("build_version") or "").strip(),
            "last_seen_version": str(payload.get("last_seen_version") or "").strip(),
            "regression_pass_count": int(payload.get("regression_pass_count") or 0),
            "verified_versions": json.dumps(_load_verified_versions(payload.get("verified_versions")), ensure_ascii=True),
        }
        if issue_state and normalized_existing == normalized_payload:
            continue

        store.upsert_issue_state(payload)
        updated_count += 1
    return updated_count


def collect_batch_project_key(jira_client: Any, df: pd.DataFrame, project_cache: Dict[str, str], defaults: Dict[str, Any]) -> str:
    unique_project_keys: set[str] = set()
    for index, row in df.iterrows():
        project_text = str(find_first_value(row, "project", defaults.get("project_key", "")) or "").strip()
        if not project_text:
            raise ValueError(f"第 {index + 2} 行缺少 Project")
        project_key = str(resolve_project_key(jira_client, project_text, project_cache) or "").strip()
        if not project_key:
            raise ValueError(f"第 {index + 2} 行 Project 无法解析: {project_text}")
        unique_project_keys.add(project_key)

    if not unique_project_keys:
        raise ValueError("当前上传模板未解析到任何 Jira 项目")
    if len(unique_project_keys) > 1:
        raise ValueError(f"当前上传模板包含多个 Jira 项目: {', '.join(sorted(unique_project_keys))}")
    return next(iter(unique_project_keys))


def _escape_jql_text_keyword(keyword: str) -> str:
    escaped = str(keyword or "").replace("\\", "\\\\").replace('"', '\\"')
    return escaped.replace("[", "\\\\[").replace("]", "\\\\]")


def build_row_log_label(index: int) -> str:
    return f"第 {index + 1} 条（Excel 第 {index + 2} 行）"


def build_excel_row_log_label(row_number: int) -> str:
    try:
        excel_row_number = int(row_number)
    except (TypeError, ValueError):
        return f"第 {row_number} 条"
    issue_index = max(excel_row_number - 1, 1)
    return f"第 {issue_index} 条（Excel 第 {excel_row_number} 行）"


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


def build_regression_export_jql(base_jql: str, keywords: List[str]) -> str:
    normalized_base_jql = str(base_jql or "").strip()
    cleaned_keywords = [str(keyword or "").strip() for keyword in keywords if str(keyword or "").strip()]
    if not normalized_base_jql or not cleaned_keywords:
        return normalized_base_jql

    escaped_keywords = [f'summary ~ "{_escape_jql_text_keyword(keyword)}"' for keyword in cleaned_keywords]
    summary_clause = f"({' OR '.join(escaped_keywords)})"

    upper_base_jql = normalized_base_jql.upper()
    order_by_marker = " ORDER BY "
    order_by_index = upper_base_jql.find(order_by_marker)
    if order_by_index >= 0:
        return f"{normalized_base_jql[:order_by_index]} AND {summary_clause}{normalized_base_jql[order_by_index:]}"
    return f"{normalized_base_jql} AND {summary_clause}"


def collect_regression_summary_keywords(df: pd.DataFrame, defaults: Dict[str, Any]) -> List[str]:
    specialties = sorted(collect_batch_specialties(df, defaults))
    if specialties:
        return specialties

    summary_prefix = str(defaults.get("summary_prefix", "") or "")
    summary_prefix_tokens = re.findall(r"\[[^\]]+\]", summary_prefix)
    if summary_prefix_tokens:
        return [summary_prefix_tokens[0]]
    return ["[自动化]"]


def resolve_regression_verify_summary_keyword(specialty: Any, defaults: Dict[str, Any]) -> str:
    return resolve_regression_specialty(specialty, defaults)


def build_regression_verify_jql(project_key: str, reporter: str, specialty: Any, defaults: Dict[str, Any]) -> str:
    summary_keyword = resolve_regression_verify_summary_keyword(specialty, defaults)
    base_jql = build_regression_base_jql(project_key, f"reporter in ({str(reporter or '').strip()})")
    return build_regression_export_jql(base_jql, [summary_keyword] if summary_keyword else [])


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
    jira_client: Any,
    regression_rules: Any,
    *,
    base_jql: str,
    summary_keywords: List[str],
    field_mapping: Dict[str, Any] | None = None,
) -> List[Dict[str, Any]]:
    jira_export = getattr(regression_rules, "jira_export", None)
    if not jira_export or not getattr(jira_export, "enabled", False):
        return []

    export_jql = build_regression_export_jql(base_jql, summary_keywords)
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


def _version_sort_key(version: Any) -> Tuple[str, ...]:
    text = str(version or "").strip()
    if not text:
        return ()
    tokens = re.findall(r"\d+|[A-Za-z]+", text)
    if not tokens:
        return (text.lower(),)
    normalized: List[str] = []
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


def _parse_summary_tokens(summary: Any) -> List[str]:
    return [item.strip() for item in re.findall(r"\[([^\]]+)\]", str(summary or "")) if item.strip()]


def _find_summary_version_index(tokens: List[str]) -> int:
    for index, token in enumerate(tokens):
        if re.search(r"\d{6}V\d+", token, flags=re.IGNORECASE):
            return index
    return -1


def _extract_summary_test_case(summary: Any) -> str:
    tokens = _parse_summary_tokens(summary)
    version_index = _find_summary_version_index(tokens)
    if version_index >= 0 and version_index + 2 < len(tokens):
        return tokens[version_index + 1]
    return ""


def build_test_case_label_mapping(defaults: Dict[str, Any]) -> Dict[str, str]:
    normalized_mapping: Dict[str, str] = {}
    raw_mapping = defaults.get("test_case_label_mapping", {}) or {}
    if isinstance(raw_mapping, dict):
        for raw_label, raw_token in raw_mapping.items():
            label = str(raw_label or "").strip()
            token = str(raw_token or "").strip()
            if not token:
                continue
            if label:
                normalized_mapping[label] = token
            normalized_mapping[token] = token
    return normalized_mapping


def resolve_regression_specialty(specialty: Any, defaults: Dict[str, Any]) -> str:
    specialty_text = str(specialty or "").strip()
    if not specialty_text:
        return ""
    return build_test_case_label_mapping(defaults).get(specialty_text, specialty_text)


def resolve_regression_specialties(raw_specialties: List[Any], defaults: Dict[str, Any]) -> List[str]:
    resolved: List[str] = []
    for raw_specialty in raw_specialties or []:
        specialty = resolve_regression_specialty(raw_specialty, defaults)
        if specialty and specialty not in resolved:
            resolved.append(specialty)
    return resolved


def extract_specialty_from_summary(summary: Any) -> str:
    return _extract_summary_test_case(summary)


def extract_specialty_from_row(row: Any, defaults: Dict[str, Any] | None = None) -> str:
    def _normalize_specialty(value: Any) -> str:
        specialty_text = str(value or "").strip()
        if not specialty_text:
            return ""
        if defaults is not None:
            return resolve_regression_specialty(specialty_text, defaults)
        return specialty_text

    specialty = _normalize_specialty(getattr(row, "get", lambda *_args, **_kwargs: "")("specialty"))
    if specialty:
        return specialty
    specialty = extract_specialty_from_summary(find_first_value(row, "summary", ""))
    if specialty:
        return specialty
    return _normalize_specialty(find_first_value(row, "test_case", ""))


def collect_batch_specialties(df: pd.DataFrame, defaults: Dict[str, Any]) -> set[str]:
    specialties: set[str] = set()
    for _, row in df.iterrows():
        specialty = extract_specialty_from_row(row, defaults)
        if not specialty:
            specialty = resolve_regression_specialty(find_first_value(row, "test_case", ""), defaults)
        if specialty:
            specialties.add(specialty)
    return specialties


def _extract_version_from_text(text: Any) -> str:
    def _normalize_candidate_version(value: Any) -> str:
        normalized = str(value or "").strip()
        list_match = re.match(r"^\[\s*['\"]?(.+?)['\"]?\s*\]$", normalized)
        if list_match:
            return str(list_match.group(1) or "").strip()
        return normalized

    for line in str(text or "").splitlines():
        normalized = line.strip()
        normalized_lower = normalized.lower()
        if normalized_lower.startswith("*version:*") or normalized.startswith("版本：") or normalized.startswith("版本:"):
            extracted = re.sub(r"^(?:\*version:\*|版本：|版本:)\s*", "", normalized, flags=re.IGNORECASE).strip()
            return _normalize_candidate_version(extracted)
    match = re.search(r"版本[：:]\s*([^\s,，；;]+)", str(text or ""), flags=re.IGNORECASE)
    if match:
        return _normalize_candidate_version(match.group(1))
    return ""


def _extract_exp_class_from_environment(environment_text: Any) -> str:
    for line in str(environment_text or "").splitlines():
        normalized = line.strip()
        if normalized.lower().startswith("*expclass:*"):
            return re.sub(r"^\*expclass:\*\s*", "", normalized, flags=re.IGNORECASE).strip()
    return ""


def _extract_summary_version(summary: Any) -> str:
    tokens = _parse_summary_tokens(summary)
    version_index = _find_summary_version_index(tokens)
    if version_index >= 0:
        return tokens[version_index]
    for token in tokens:
        if re.search(r"\d{6}V\d+", token, flags=re.IGNORECASE):
            return token
    return ""


def _extract_summary_exp_class(summary: Any) -> str:
    tokens = _parse_summary_tokens(summary)
    version_index = _find_summary_version_index(tokens)
    if version_index >= 0 and version_index + 2 < len(tokens):
        return tokens[version_index + 2]
    return ""


def build_regression_row(row: Any, defaults: Dict[str, Any]) -> Dict[str, Any]:
    summary = str(find_first_value(row, "summary", "") or "")
    description = str(find_first_value(row, "description", "") or "")
    environment = str(find_first_value(row, "environment", "") or "")
    versions_raw = str(find_first_value(row, "versions", "") or "")
    version_items = [
        re.sub(r"^\[\s*['\"]?(.+?)['\"]?\s*\]$", r"\1", item.strip())
        for item in versions_raw.replace("；", ",").replace(";", ",").replace("，", ",").split(",")
        if item.strip()
    ]
    if not version_items:
        for candidate_version in (
            _extract_version_from_text(find_first_value(row, "ps", "")),
            _extract_version_from_text(description),
            _extract_version_from_text(environment),
            _extract_summary_version(summary),
        ):
            if candidate_version:
                version_items.append(candidate_version)
                break

    project_key = str(find_first_value(row, "project", defaults.get("project_key", "VCAME")) or "").strip()
    affect_project = str(find_first_value(row, "affect_project", "") or "").strip() or project_key
    exp_class = str(find_first_value(row, "exp_class", "") or "").strip()
    if not exp_class:
        exp_class = _extract_exp_class_from_environment(environment) or _extract_summary_exp_class(summary)
    current_version = select_current_version(version_items)
    specialty = extract_specialty_from_summary(summary)
    if not specialty:
        specialty = resolve_regression_specialty(find_first_value(row, "test_case", ""), defaults)

    return {
        "summary": summary,
        "description": description,
        "project": project_key,
        "issue_type": str(find_first_value(row, "issue_type", defaults.get("issue_type", "Bug")) or ""),
        "affect_project": affect_project,
        "environment": environment,
        "exp_class": exp_class,
        "caused_by": str(find_first_value(row, "key_information", "") or ""),
        "ps": str(find_first_value(row, "ps", "") or ""),
        "versions": version_items,
        "build_version": current_version,
        "current_version": current_version,
        "specialty": specialty,
    }


def build_snapshot_field_mapping(defaults: Dict[str, Any]) -> Dict[str, Any]:
    field_ids = defaults.get("field_ids", {})
    mapping: Dict[str, Any] = {}
    for field_name in ("affect_project", "exp_class", "key_information"):
        field_id = str(field_ids.get(field_name, "") or "").strip()
        if field_id:
            mapping[field_name] = field_id
    return mapping


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


def _extract_sort_timestamps(row: Dict[str, Any]) -> Tuple[datetime | None, datetime | None]:
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


def find_regression_match(current_row: Dict[str, Any], snapshot_rows: List[Dict[str, Any]], matching_rules: Any) -> Dict[str, Any] | None:
    threshold = getattr(matching_rules, "cause_similarity_threshold", 0.9)
    exact_fields = getattr(matching_rules, "required_exact_fields", None)
    current_specialty = extract_specialty_from_row(current_row)
    candidates = [
        history_row
        for history_row in snapshot_rows
        if (
            not current_specialty
            or extract_specialty_from_row(history_row) == current_specialty
        )
        if is_strong_match(current_row, history_row, threshold, exact_fields=exact_fields)
    ]
    if not candidates:
        return None

    def candidate_sort_key(history_row: Dict[str, Any]) -> Tuple[int, float, int, float, str]:
        updated_at, created_at = _extract_sort_timestamps(history_row)
        jira_key = str(history_row.get("jira_key") or "")
        return (
            0 if updated_at else 1,
            -(updated_at.timestamp()) if updated_at else 0.0,
            0 if created_at else 1,
            -(created_at.timestamp()) if created_at else 0.0,
            jira_key,
        )

    return sorted(candidates, key=candidate_sort_key)[0]


def build_execution_result(
    run_id: str,
    row_number: Any,
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
    row_number: Any,
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


def build_history_issue_main_comment(
    action: str,
    row: Any,
    matched_row: Dict[str, Any] | None,
    *,
    comment_config: Dict[str, Any] | None = None,
) -> str:
    resolved_comment_config = _resolve_comment_config(comment_config)
    common_config = resolved_comment_config.get("common", {}) or {}
    regression_row = build_regression_row(row, {"project_key": ""})
    summary = str(find_first_value(row, "summary", "") or "")
    description = str(find_first_value(row, "description", "") or "")
    environment = str(find_first_value(row, "environment", "") or "")
    current_version = str(regression_row.get("current_version") or "未提供版本")
    history_key = str((matched_row or {}).get("jira_key") or "").strip() or "历史单"
    specialty = extract_specialty_from_summary(summary) or str(find_first_value(row, "test_case", "") or "").strip() or "未识别专项"
    package_name = str(_extract_environment_value(environment, "Package") or "").strip()
    total_number = _extract_total_number(summary)

    app_version = "/"
    raw_package_candidates = [
        _extract_environment_value(environment, "Package"),
    ]
    raw_text = "\n".join([description, environment])
    for pattern in (
        r"异常包名[：:]\s*\[\s*['\"]?([^'\"]+?)['\"]?\s*\]",
        r"\*Package\*:\s*\[\s*['\"]?([^'\"]+?)['\"]?\s*\]",
        r"Package[：:]\s*\[\s*['\"]?([^'\"]+?)['\"]?\s*\]",
    ):
        match = re.search(pattern, raw_text, flags=re.IGNORECASE)
        if match:
            raw_package_candidates.append(str(match.group(1) or "").strip())
    for candidate in raw_package_candidates:
        normalized_candidate = str(candidate or "").strip()
        if not normalized_candidate:
            continue
        if package_name and normalized_candidate.startswith(f"{package_name} "):
            app_version = normalized_candidate[len(package_name) :].strip() or "/"
            break
        if normalized_candidate != package_name and " " in normalized_candidate:
            app_version = normalized_candidate.split(" ", 1)[1].strip() or "/"
            break

    if action in {"OPEN_LIKE_UPDATE", "DUPLICATE_COMMENT"}:
        remark = f"自动化回归命中历史单 {history_key}，当前版本 {current_version} 再次复现，请继续跟进。"
    elif action == "WONT_FIX_KEEP":
        remark = f"自动化回归再次命中历史单 {history_key}，当前版本 {current_version} 继续复现，请重新关注评估。"
    elif action == "RESOLVED_FIXED_WAIT_NEW_VERSION":
        remark = f"自动化回归命中历史单 {history_key}，当前版本 {current_version} 早于修复版本，先保留记录并继续观察。"
    else:
        remark = f"自动化回归命中历史单 {history_key}，请关注当前版本 {current_version} 的复现情况。"

    return _render_regression_comment(
        resolved_comment_config.get("fail_template", ""),
        {
            "test_count": str(total_number or "/"),
            "specialty": specialty,
            "current_version": current_version,
            "device_mark": str(common_config.get("device_mark") or "PR1"),
            "app_version": app_version,
            "tester_contact": str(common_config.get("tester_contact") or "吕代+18379465576"),
            "remark": remark,
        },
    )


def add_history_issue_comments(
    jira_client: Any,
    issue_key: str | None,
    action: str,
    row: Any,
    matched_row: Dict[str, Any] | None,
    ps_text: str | None,
    add_ps_comment: bool,
) -> Dict[str, Any]:
    if not issue_key:
        return {"comment_count": 0, "comment_status": "", "ps_comment_status": ""}

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


def _should_retry_create_without_assignee(exc: Exception, issue_fields: Dict[str, Any]) -> bool:
    assignee_name = str((((issue_fields or {}).get("assignee") or {}).get("name") or "")).strip()
    if not assignee_name:
        return False
    message = str(exc or "")
    lowered = message.lower()
    return "cannot be assigned issues" in lowered and '"assignee"' in lowered


def _create_issue_with_assignee_fallback(
    jira_client: Any,
    issue_fields: Dict[str, Any],
    row_number: int,
) -> Tuple[Dict[str, Any], Dict[str, Any], bool]:
    create_fields = dict(issue_fields or {})
    try:
        return jira_client.create_issue(create_fields), create_fields, False
    except Exception as exc:
        if not _should_retry_create_without_assignee(exc, create_fields):
            raise
        assignee_name = str((((create_fields or {}).get("assignee") or {}).get("name") or "")).strip()
        retry_fields = dict(create_fields)
        retry_fields.pop("assignee", None)
        logger.warning("%s 经办人 %s 不可分配，移除 assignee 后重试建单", build_excel_row_log_label(row_number), assignee_name or "<empty>")
        created_issue = jira_client.create_issue(retry_fields)
        return created_issue, retry_fields, True


def _upsert_snapshot_issue_states(store: RegressionStore, snapshot_rows: List[Dict[str, Any]]) -> None:
    for snapshot_row in snapshot_rows:
        jira_key = str(snapshot_row.get("jira_key") or "").strip()
        if not jira_key:
            continue
        store.upsert_issue_state(
            {
                "jira_key": jira_key,
                "status": snapshot_row.get("status"),
                "resolution": snapshot_row.get("resolution"),
                "fix_version": snapshot_row.get("fix_version"),
                "build_version": snapshot_row.get("build_version"),
            }
        )


def _load_verified_versions(value: Any) -> List[str]:
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


def build_regression_pass_comment(
    pass_count: int,
    versions: List[str],
    *,
    specialty: str,
    current_version: str,
    comment_config: Dict[str, Any] | None = None,
) -> str:
    resolved_comment_config = _resolve_comment_config(comment_config)
    common_config = resolved_comment_config.get("common", {}) or {}
    version_text = ", ".join(versions) if versions else (current_version or "未记录版本")
    legacy_comment = f"已回归验证{pass_count}个版本PASS，已测试版本：{version_text}"
    return _render_regression_comment(
        resolved_comment_config.get("pass_template", ""),
        {
            "test_count": str(common_config.get("pass_test_count") or "0/1000"),
            "specialty": specialty or "未识别专项",
            "current_version": current_version or "未记录版本",
            "device_mark": str(common_config.get("device_mark") or "PR1"),
            "app_version": "/",
            "tester_contact": str(common_config.get("tester_contact") or "吕代+18379465576"),
            "remark": legacy_comment,
        },
    )


def is_strict_version_project(project_key: Any, strict_version_project_keys: Any = None) -> bool:
    project_text = str(project_key or "").strip().upper()
    if not project_text:
        return False
    if isinstance(strict_version_project_keys, str):
        normalized = {strict_version_project_keys.strip().upper()} if strict_version_project_keys.strip() else set()
    else:
        normalized = {
            str(item).strip().upper()
            for item in (strict_version_project_keys or [])
            if str(item).strip()
        }
    return project_text in normalized


def infer_history_project_key(history_row: Dict[str, Any]) -> str:
    affect_project = str(history_row.get("affect_project") or "").strip()
    if affect_project:
        return affect_project
    jira_key = str(history_row.get("jira_key") or "").strip()
    if "-" in jira_key:
        return jira_key.split("-", 1)[0]
    return ""


def merge_history_sources(
    history_row: Dict[str, Any] | None,
    issue_state: Dict[str, Any] | None,
    project_db_row: Dict[str, Any] | None,
) -> Dict[str, Any] | None:
    merged = merge_history_with_issue_state(history_row, issue_state)
    if not merged and not project_db_row:
        return None
    merged = dict(merged or {})
    if project_db_row:
        for key in ("build_version", "fix_version", "status", "resolution", "version"):
            if key == "build_version":
                if str(project_db_row.get(key) or "").strip():
                    merged[key] = project_db_row.get(key)
                continue
            if not str(merged.get(key) or "").strip() and str(project_db_row.get(key) or "").strip():
                merged[key] = project_db_row.get(key)
    return merged


def merge_history_with_issue_state(
    history_row: Dict[str, Any] | None,
    issue_state: Dict[str, Any] | None,
) -> Dict[str, Any] | None:
    if not history_row and not issue_state:
        return None
    merged = dict(history_row or {})
    for key in ("build_version", "fix_version", "status", "resolution", "last_seen_version"):
        if not str(merged.get(key) or "").strip() and issue_state and str(issue_state.get(key) or "").strip():
            merged[key] = issue_state.get(key)
    return merged


def _load_issue_raw_payload(row: Dict[str, Any]) -> Dict[str, Any]:
    raw_payload = row.get("raw_payload")
    if isinstance(raw_payload, str):
        try:
            raw_payload = json.loads(raw_payload)
        except json.JSONDecodeError:
            raw_payload = {}
    return raw_payload if isinstance(raw_payload, dict) else {}


def _is_duplicate_issue_link(link: Dict[str, Any]) -> bool:
    link_type = link.get("type") or {}
    link_name = str(link_type.get("name") or link_type.get("inward") or link_type.get("outward") or "").strip().lower()
    return bool(link_name) and any(keyword in link_name for keyword in DUPLICATE_LINK_KEYWORDS)


def collect_duplicate_issue_keys(main_row: Dict[str, Any]) -> List[str]:
    raw_payload = _load_issue_raw_payload(main_row)
    fields = raw_payload.get("fields", {}) if isinstance(raw_payload, dict) else {}
    issue_links = fields.get("issuelinks") or []
    main_key = str(main_row.get("jira_key") or "").strip()
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


def get_issue_status_name(jira_client: Any, issue_key: str) -> str:
    issue = jira_client.issue(issue_key)
    fields = getattr(issue, "fields", None)
    status = getattr(fields, "status", None)
    return str(getattr(status, "name", "") or "").strip()


def build_create_new_decision() -> Any:
    return type(
        "DecisionCreateOnly",
        (),
        {
            "action": "CREATE_NEW",
            "manual_review": False,
            "update_jira": False,
            "recreate_issue": True,
            "comment_required": False,
        },
    )()


def is_create_only_mode(args: argparse.Namespace) -> bool:
    return bool(getattr(args, "create_only", False) or getattr(args, "disable_regression", False))


def _extract_environment_value(environment_text: Any, field_name: str) -> str:
    pattern = re.compile(rf"^\*{re.escape(field_name)}:\*\s*(.+)$", flags=re.IGNORECASE)
    for raw_line in str(environment_text or "").splitlines():
        match = pattern.match(str(raw_line or "").strip())
        if match:
            return str(match.group(1) or "").strip()
    return ""


def _extract_total_number(summary: Any) -> int:
    match = re.search(r"\[Total Number\s+(\d+)\]", str(summary or ""), flags=re.IGNORECASE)
    if not match:
        return 0
    try:
        return int(match.group(1))
    except (TypeError, ValueError):
        return 0


def _normalize_upload_row(source_row: Any) -> Dict[str, Any]:
    if source_row is None:
        return {}
    if hasattr(source_row, "to_dict"):
        raw_mapping = source_row.to_dict()
    else:
        try:
            raw_mapping = dict(source_row)
        except Exception:
            return {}

    normalized: Dict[str, Any] = {}
    for key, value in raw_mapping.items():
        cleaned_value = clean_cell_value(value)
        if isinstance(cleaned_value, (dict, list, str, int, float, bool)) or cleaned_value is None:
            normalized[str(key)] = cleaned_value
        else:
            normalized[str(key)] = str(cleaned_value)
    return normalized


def _load_json_dict(value: Any) -> Dict[str, Any]:
    if isinstance(value, dict):
        return dict(value)
    if isinstance(value, str) and value.strip():
        try:
            parsed = json.loads(value)
        except json.JSONDecodeError:
            return {}
        if isinstance(parsed, dict):
            return parsed
    return {}


def _find_source_row_value(source_row: Any, *candidates: str) -> str:
    for candidate in candidates:
        try:
            value = source_row.get(candidate, None)
        except Exception:
            value = None
        cleaned = clean_cell_value(value)
        if cleaned not in ("", None):
            return str(cleaned)
    return ""


def _extract_assignee_from_issue_fields(issue_fields: Dict[str, Any] | None) -> str:
    if not issue_fields:
        return ""
    assignee_value = issue_fields.get("assignee")
    if isinstance(assignee_value, dict):
        return str(assignee_value.get("name") or assignee_value.get("accountId") or "").strip()
    return str(assignee_value or "").strip()


def sync_issue_to_project_history_db(
    *,
    project_db: DatabaseManager | None,
    jira_key: str,
    source_row: Any | None = None,
    effective_issue_fields: Dict[str, Any] | None = None,
    assignee_fallback_used: bool = False,
    regression_row: Dict[str, Any],
    status: str,
    resolution: str,
    fix_version: str,
) -> None:
    if project_db is None:
        return

    issue_key = str(jira_key or "").strip()
    if not issue_key:
        return

    existing = project_db.get_issue_by_key(issue_key) or {}
    summary = str(regression_row.get("summary") or "")
    description = str(regression_row.get("description") or "")
    environment = str(regression_row.get("environment") or "")
    caused_by = str(regression_row.get("caused_by") or "")
    current_version = str(regression_row.get("current_version") or "")
    build_version = str(regression_row.get("build_version") or "")
    affect_project = str(regression_row.get("affect_project") or regression_row.get("project") or "")
    assignee = str(find_first_value(source_row, "assignee", "") or "")
    if assignee_fallback_used:
        assignee = _extract_assignee_from_issue_fields(effective_issue_fields)
    elif effective_issue_fields and "assignee" in effective_issue_fields:
        assignee = _extract_assignee_from_issue_fields(effective_issue_fields)
    bug_severity = str(find_first_value(source_row, "bug_severity", "B") or "B")
    priority = str(find_first_value(source_row, "priority", "Medium") or "Medium")
    package_name = str(_extract_environment_value(environment, "Package") or "")
    exp_type = str(_extract_environment_value(environment, "ExpType") or "")
    cur_process = str(_extract_environment_value(environment, "CurProcess") or "")
    source_file = _find_source_row_value(source_row, "Source File", "source_file", "Path", "path")
    upload_row = _normalize_upload_row(source_row)
    occurrence_count = _extract_total_number(summary)
    raw_data = _load_json_dict(existing.get("raw_data")) if existing else {}
    raw_data.update(
        {
            "project": affect_project,
            "build_version": build_version,
            "current_version": current_version,
            "ps": str(regression_row.get("ps") or ""),
        }
    )
    if upload_row:
        raw_data["upload_row"] = upload_row
    if source_file:
        raw_data["path"] = source_file

    if existing:
        update_payload: Dict[str, Any] = {
            "status": str(status or existing.get("status") or ""),
            "resolution": str(resolution or existing.get("resolution") or ""),
            "assignee": assignee or existing.get("assignee") or "",
            "bug_severity": bug_severity or existing.get("bug_severity") or "",
            "priority": priority or existing.get("priority") or "",
            "summary": summary or existing.get("summary") or "",
            "normalized_summary": summary or existing.get("normalized_summary") or "",
            "description": description or existing.get("description") or "",
            "test_environment": environment or existing.get("test_environment") or "",
            "raw_caused_by": caused_by or existing.get("raw_caused_by") or "",
            "package_name": package_name or existing.get("package_name") or "",
            "exp_class": str(regression_row.get("exp_class") or existing.get("exp_class") or ""),
            "exp_type": exp_type or existing.get("exp_type") or "",
            "cur_process": cur_process or existing.get("cur_process") or "",
            "version": current_version or existing.get("version") or "",
            "count": (occurrence_count or 0) + (existing.get("count") or 0),
            "source_file": source_file or existing.get("source_file") or "",
            "raw_data": raw_data,
            "fix_version": str(fix_version or existing.get("fix_version") or ""),
        }
        if not str(existing.get("build_version") or "").strip() and build_version:
            update_payload["build_version"] = build_version
        project_db.update_main_table_record(issue_key, update_payload)
        return

    project_db.insert_issue(
        {
            "jira_key": issue_key,
            "status": str(status or "Open"),
            "summary": summary,
            "normalized_summary": summary,
            "test_environment": environment,
            "raw_caused_by": caused_by,
            "assignee": assignee or None,
            "bug_severity": bug_severity or "B",
            "priority": priority or "Medium",
            "description": description,
            "resolution": str(resolution or ""),
            "package_name": package_name,
            "exp_class": str(regression_row.get("exp_class") or ""),
            "exp_type": exp_type,
            "cur_process": cur_process,
            "version": current_version,
            "count": occurrence_count,
            "device_count": 0,
            "source_file": source_file,
            "raw_data": raw_data,
            "fix_version": str(fix_version or ""),
            "build_version": build_version,
            "regression_pass_count": 0,
            "verified_versions": [],
        }
    )


def sync_regression_pass_to_project_history_db(
    *,
    project_db: DatabaseManager | None,
    jira_key: str,
    history_row: Dict[str, Any],
    current_version: str,
    new_pass_count: int,
    verified_versions: List[str],
    status: str,
    resolution: str,
    fix_version: str,
    build_version: str,
) -> None:
    if project_db is None:
        return

    issue_key = str(jira_key or "").strip()
    if not issue_key:
        return

    existing = project_db.get_issue_by_key(issue_key) or {}
    summary = str(history_row.get("summary") or existing.get("summary") or issue_key)
    environment = str(history_row.get("environment") or existing.get("test_environment") or "")
    caused_by = str(history_row.get("caused_by") or existing.get("raw_caused_by") or "")
    package_name = str(_extract_environment_value(environment, "Package") or existing.get("package_name") or "")
    exp_class = str(
        history_row.get("exp_class") or existing.get("exp_class") or _extract_environment_value(environment, "ExpClass") or ""
    )
    exp_type = str(_extract_environment_value(environment, "ExpType") or existing.get("exp_type") or "")
    cur_process = str(_extract_environment_value(environment, "CurProcess") or existing.get("cur_process") or "")
    verified_versions_payload = list(verified_versions or [])
    if not verified_versions_payload:
        verified_versions_payload = _load_verified_versions(existing.get("verified_versions"))
    effective_pass_count = int(new_pass_count or existing.get("regression_pass_count") or 0)
    raw_data = _load_json_dict(existing.get("raw_data")) if existing else {}
    raw_data.update(
        {
            "project": str(history_row.get("affect_project") or ""),
            "build_version": build_version,
            "current_version": current_version,
            "regression_synced": True,
        }
    )

    update_payload: Dict[str, Any] = {
        "status": status,
        "resolution": resolution,
        "summary": summary,
        "normalized_summary": summary,
        "test_environment": environment,
        "raw_caused_by": caused_by,
        "package_name": package_name,
        "exp_class": exp_class,
        "exp_type": exp_type,
        "cur_process": cur_process,
        "version": current_version,
        "fix_version": fix_version,
        "build_version": build_version,
        "regression_pass_count": effective_pass_count,
        "verified_versions": verified_versions_payload,
        "raw_data": raw_data,
    }
    if existing:
        project_db.update_main_table_record(issue_key, update_payload)
        return

    project_db.insert_issue(
        {
            "jira_key": issue_key,
            "status": status or "Open",
            "summary": summary,
            "normalized_summary": summary,
            "test_environment": environment,
            "raw_caused_by": caused_by,
            "assignee": None,
            "bug_severity": str(existing.get("bug_severity") or "B"),
            "priority": str(existing.get("priority") or "Medium"),
            "description": str(history_row.get("description") or existing.get("description") or ""),
            "resolution": resolution,
            "package_name": package_name,
            "exp_class": exp_class,
            "exp_type": exp_type,
            "cur_process": cur_process,
            "version": current_version,
            "count": int(existing.get("count") or 0),
            "device_count": int(existing.get("device_count") or 0),
            "source_file": str(existing.get("source_file") or ""),
            "raw_data": raw_data,
            "fix_version": fix_version,
            "build_version": build_version,
            "regression_pass_count": effective_pass_count,
            "verified_versions": verified_versions_payload,
        }
    )


def close_duplicate_issues_following_main(
    *,
    jira_client: Any,
    store: RegressionStore,
    project_db: DatabaseManager | None,
    run_id: str,
    main_row: Dict[str, Any],
    closed_statuses: List[str],
    results: List[Dict[str, Any]],
    summary_rows: List[Dict[str, Any]],
    only_duplicate_statuses: set[str] | None = None,
) -> None:
    main_key = str(main_row.get("jira_key") or "").strip()
    normalized_allowed_statuses = {
        str(item).strip().lower() for item in (only_duplicate_statuses or set()) if str(item).strip()
    }
    for duplicate_key in collect_duplicate_issue_keys(main_row):
        duplicate_row = {
            "jira_key": duplicate_key,
            "summary": f"重复单跟随主单 {main_key}",
            "fix_version": main_row.get("fix_version"),
            "build_version": main_row.get("build_version"),
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
            transitioned, transition_message = transition_issue_to_closed(
                jira_client,
                duplicate_key,
                closed_statuses,
                resolution_name="完成",
                fix_version=str(main_row.get("fix_version") or "").strip() or None,
            )
            if not transitioned:
                raise RuntimeError(transition_message)
            result_message = f"duplicate of {main_key}; {transition_message}"
            sync_regression_pass_to_project_history_db(
                project_db=project_db,
                jira_key=duplicate_key,
                history_row=duplicate_row,
                current_version=str(main_row.get("last_seen_version") or ""),
                new_pass_count=0,
                verified_versions=[],
                status="已关闭",
                resolution="完成",
                fix_version=str(main_row.get("fix_version") or ""),
                build_version=str(main_row.get("build_version") or ""),
            )
        except Exception as exc:
            success = False
            reason = "REGRESSION_DUPLICATE_CLOSE_ERROR"
            result_message = str(exc)
            logger.warning("重复单 %s 跟随主单 %s 关闭失败: %s", duplicate_key, main_key, exc)

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
                "DuplicateDecisionView",
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
    jira_client: Any,
    store: RegressionStore,
    project_db: DatabaseManager | None,
    run_id: str,
    regression_rules: Any,
    snapshot_rows: List[Dict[str, Any]],
    allowed_specialties: set[str] | None,
    args: argparse.Namespace,
    results: List[Dict[str, Any]],
    summary_rows: List[Dict[str, Any]],
) -> None:
    if not is_duplicate_followups_enabled(regression_rules):
        return
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
            project_db=project_db,
            run_id=run_id,
            main_row=dict(history_row),
            closed_statuses=closed_statuses,
            results=results,
            summary_rows=summary_rows,
            only_duplicate_statuses=DUPLICATE_BACKFILL_STATUS_NAMES,
        )


def process_regression_pass_candidates(
    *,
    jira_client: Any,
    store: RegressionStore,
    project_db: DatabaseManager | None,
    run_id: str,
    current_version: str,
    regression_rules: Any,
    matched_jira_keys: set[str],
    allowed_specialties: set[str] | None,
    args: argparse.Namespace,
    results: List[Dict[str, Any]],
    summary_rows: List[Dict[str, Any]],
) -> None:
    regression_config = getattr(regression_rules, "regression", None)
    status_rules = getattr(regression_rules, "status_rules", None)
    required_versions = int(getattr(regression_config, "required_regression_pass_versions", 2) or 2)
    strict_version_project_keys = get_strict_version_project_keys(regression_rules)
    resolved_statuses = list(getattr(status_rules, "resolved_statuses", []) or [])
    resolved_fixed_resolutions = list(getattr(status_rules, "resolved_fixed_resolutions", []) or [])
    closed_statuses = list(getattr(status_rules, "closed_statuses", []) or [])
    pass_candidates = store.fetch_regression_pass_candidates(
        run_id,
        resolved_statuses,
        resolved_fixed_resolutions,
        excluded_jira_keys=matched_jira_keys,
    )
    if allowed_specialties:
        pass_candidates = [
            dict(row)
            for row in pass_candidates
            if extract_specialty_from_summary((row or {}).get("summary", "")) in allowed_specialties
        ]

    for history_row in pass_candidates:
        jira_key = str(history_row.get("jira_key") or "").strip()
        if not jira_key:
            continue
        issue_state = store.fetch_issue_state(jira_key) or {}
        history_row = merge_history_sources(
            history_row,
            issue_state,
            get_project_history_issue(project_db, jira_key),
        ) or history_row
        current_pass_count = int(issue_state.get("regression_pass_count") or 0)
        verified_versions = _load_verified_versions(issue_state.get("verified_versions"))
        project_key = infer_history_project_key(history_row)
        pass_decision = evaluate_regression_pass(
            pass_count=current_pass_count,
            required_versions=required_versions,
            current_version=current_version,
            fix_version=history_row.get("fix_version"),
            already_verified=verified_versions,
            build_version=history_row.get("build_version"),
            project_key=project_key,
            strict_version_project_keys=strict_version_project_keys,
        )
        reason = pass_decision.reason or "回归PASS判定"
        logger.info("回归验证候选 %s: action=%s reason=%s", jira_key, pass_decision.action, reason)

        if pass_decision.action == "REGRESSION_PASS_SKIP":
            result_message = f"skip: {reason}"
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
        if current_version and current_version not in new_verified_versions:
            new_verified_versions.append(current_version)
        result_message = build_regression_pass_comment(
            pass_decision.new_pass_count,
            new_verified_versions,
            specialty=extract_specialty_from_summary((history_row or {}).get("summary", "")),
            current_version=current_version,
        )
        success = True
        comment_status = ""
        action_reason = "回归PASS判定"

        if not args.dry_run:
            try:
                if pass_decision.comment_required:
                    add_issue_comment(jira_client, jira_key, result_message)
                    comment_status = "ADDED"
                if pass_decision.close_issue:
                    transitioned, transition_message = transition_issue_to_closed(
                        jira_client,
                        jira_key,
                        closed_statuses,
                        resolution_name="完成",
                        fix_version=str(history_row.get("fix_version") or "").strip() or None,
                    )
                    if not transitioned:
                        raise RuntimeError(transition_message)
                    result_message = f"{result_message}; {transition_message}"
                    if is_duplicate_followups_enabled(regression_rules):
                        close_duplicate_issues_following_main(
                            jira_client=jira_client,
                            store=store,
                            project_db=project_db,
                            run_id=run_id,
                            main_row=history_row,
                            closed_statuses=closed_statuses,
                            results=results,
                            summary_rows=summary_rows,
                        )
                store.record_regression_pass(
                    jira_key,
                    current_version,
                    pass_decision.new_pass_count,
                    status="已关闭" if pass_decision.close_issue else history_row.get("status"),
                    resolution=history_row.get("resolution"),
                    fix_version=history_row.get("fix_version"),
                    build_version=history_row.get("build_version"),
                    updated_at=datetime.now().isoformat(timespec="seconds"),
                )
                sync_regression_pass_to_project_history_db(
                    project_db=project_db,
                    jira_key=jira_key,
                    history_row=history_row,
                    current_version=current_version,
                    new_pass_count=pass_decision.new_pass_count,
                    verified_versions=new_verified_versions,
                    status="已关闭" if pass_decision.close_issue else str(history_row.get("status") or ""),
                    resolution=str(history_row.get("resolution") or ""),
                    fix_version=str(history_row.get("fix_version") or ""),
                    build_version=str(history_row.get("build_version") or ""),
                )
            except Exception as exc:
                success = False
                action_reason = "REGRESSION_PASS_ERROR"
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
                reason=action_reason,
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
                reason=action_reason,
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
    jira_client: Any,
    row: Any,
    issue_fields: Dict[str, Any],
    decision: Any,
    matched_row: Dict[str, Any] | None,
    args: argparse.Namespace,
    row_number: int,
) -> Dict[str, Any]:
    action = str(getattr(decision, "action", "") or "")
    issue_key = str((matched_row or {}).get("jira_key") or "").strip() or None
    ps_text = str(find_first_value(row, "ps", "") or "").strip()
    result_message = action

    try:
        if matched_row and not getattr(decision, "recreate_issue", False):
            if action == "OPEN_LIKE_UPDATE":
                if issue_fields and "summary" in issue_fields and matched_row:
                    existing_summary = str(matched_row.get("summary") or "")
                    existing_count = _extract_total_number(existing_summary)
                    current_count = _extract_total_number(str(issue_fields.get("summary", "")))
                    if existing_count > 0 and current_count > 0:
                        new_total = existing_count + current_count
                        issue_fields["summary"] = re.sub(
                            r"\[Total Number\s+\d+\]",
                            f"[Total Number {new_total}]",
                            issue_fields["summary"],
                            flags=re.IGNORECASE,
                        )
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

            if action in {"WONT_FIX_KEEP", "RESOLVED_FIXED_WAIT_NEW_VERSION", "DUPLICATE_COMMENT", "DUPLICATE_KEEP"}:
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

        new_issue, effective_issue_fields, used_assignee_fallback = _create_issue_with_assignee_fallback(
            jira_client,
            issue_fields,
            row_number,
        )
        issue_key = str((new_issue or {}).get("key") or "")
        result_message = f"{action} -> {issue_key}"
        if used_assignee_fallback:
            result_message = f"{result_message}; assignee removed and retried"
        ps_comment_status = ""
        if args.add_comments and ps_text:
            add_issue_comment(jira_client, issue_key, ps_text)
            ps_comment_status = "ADDED"
        return {
            "status": "SUCCESS",
            "issue_key": issue_key,
            "result_message": result_message,
            "effective_issue_fields": effective_issue_fields,
            "assignee_fallback_used": used_assignee_fallback,
            "comment_status": "",
            "ps_comment_status": ps_comment_status,
        }
    except Exception as exc:
        logger.exception("%s 动作执行失败", build_excel_row_log_label(row_number))
        return {"status": "FAILED", "issue_key": issue_key, "result_message": str(exc), "reason": "EXCEPTION"}


def is_regression_enabled(regression_rules: Any) -> bool:
    regression_config = getattr(regression_rules, "regression", None)
    return bool(getattr(regression_config, "enabled", True))


def get_strict_version_project_keys(regression_rules: Any) -> List[str]:
    regression_config = getattr(regression_rules, "regression", None)
    values = getattr(regression_config, "strict_version_project_keys", []) or []
    if isinstance(values, str):
        return [values] if values.strip() else []
    return [str(item).strip() for item in values if str(item).strip()]


def is_duplicate_followups_enabled(regression_rules: Any) -> bool:
    regression_config = getattr(regression_rules, "regression", None)
    return bool(getattr(regression_config, "enable_duplicate_followups", False))


def should_write_audit_report(regression_rules: Any) -> bool:
    regression_config = getattr(regression_rules, "regression", None)
    return bool(getattr(regression_config, "write_audit_report", True))


def save_audit_report(
    *,
    results: List[Dict[str, Any]],
    summary_rows: List[Dict[str, Any]],
    run_id: str,
) -> Path:
    RESULT_DIR.mkdir(parents=True, exist_ok=True)
    target = RESULT_DIR / f"tinno_jira_batch_create_audit_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
    action_counts: Dict[str, int] = {}
    reason_counts: Dict[str, int] = {}
    status_counts: Dict[str, int] = {}

    for item in results:
        status_text = str(item.get("status") or "").strip() or "UNKNOWN"
        status_counts[status_text] = status_counts.get(status_text, 0) + 1

    for row in summary_rows:
        action_text = str(row.get("action") or "").strip() or "UNKNOWN"
        reason_text = str(row.get("reason") or "").strip() or "UNKNOWN"
        action_counts[action_text] = action_counts.get(action_text, 0) + 1
        reason_counts[reason_text] = reason_counts.get(reason_text, 0) + 1

    payload = {
        "run_id": run_id,
        "generated_at": datetime.now().isoformat(timespec="seconds"),
        "total_results": len(results),
        "total_summary_rows": len(summary_rows),
        "status_counts": status_counts,
        "action_counts": action_counts,
        "reason_counts": reason_counts,
        "rows": summary_rows,
    }
    with target.open("w", encoding="utf-8") as fp:
        json.dump(payload, fp, ensure_ascii=False, indent=2)
    return target


def write_run_outputs(
    *,
    results: List[Dict[str, Any]],
    regression_enabled: bool,
    store: RegressionStore | None,
    regression_rules: Any | None,
    run_id: str,
    summary_rows: List[Dict[str, Any]],
) -> int:
    output_file = save_results(results)
    logger.info("结果已写入: %s", output_file)
    if regression_enabled and regression_rules is not None and should_write_audit_report(regression_rules):
        audit_file = save_audit_report(results=results, summary_rows=summary_rows, run_id=run_id)
        logger.info("审计结果已写入: %s", audit_file)
    if regression_enabled and store is not None:
        excel_summary_dir = Path(getattr(regression_rules.output, "excel_summary_dir", RESULT_DIR))
        if not excel_summary_dir.is_absolute():
            excel_summary_dir = CURRENT_DIR / excel_summary_dir
        excel_summary_dir.mkdir(parents=True, exist_ok=True)
        summary_path = excel_summary_dir / f"tinno_jira_batch_create_summary_{datetime.now().strftime('%Y%m%d_%H%M%S')}.xlsx"
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
    apply_test_mode_defaults(args, defaults)
    create_only_mode = is_create_only_mode(args)
    regression_rules: Any | None = None
    regression_enabled = False
    if not create_only_mode:
        regression_rules = load_regression_rules(DEFAULT_REGRESSION_RULES_FILE)
        regression_enabled = is_regression_enabled(regression_rules)

    if bool(getattr(args, "test_mode", False)) and not args.excel_file:
        generated_excel = ensure_test_mode_upload_excel(args, defaults)
        args.excel_file = str(generated_excel)
        logger.info("测试模式已生成上传模板: %s", generated_excel)
    if not args.excel_file:
        logger.error("Excel 模式需要提供 --add-excel-file，或使用 --test-mode")
        return 1
    if not args.jira_cookie_jsessionid and not args.jira_cookie_xsrf_token and (not args.jira_username or not args.jira_password):
        logger.error("需要提供 Cookie 或 Jira 用户名密码")
        return 1
    if not args.jira_p12_path or not args.jira_p12_password:
        logger.error("需要提供 Tinno P12 证书路径和密码")
        return 1

    jira_server = args.jira_server or defaults["jira_server"]
    df = read_excel_smart(args.excel_file)
    logger.info("已读取上传模板 %d 条，列: %s", len(df), list(df.columns))
    if not validate_upload_excel(df):
        return 1

    jira = connect_to_jira(
        server=jira_server,
        username=args.jira_username,
        password=args.jira_password,
        p12_file_path=args.jira_p12_path,
        p12_password=args.jira_p12_password,
        verify=bool(defaults.get("verify", False)),
        cookie_string=args.jira_cookie_string,
        cookie_jsessionid=args.jira_cookie_jsessionid,
        cookie_xsrf_token=args.jira_cookie_xsrf_token,
    )
    logger.info("当前认证来源: %s", getattr(jira, "auth_mode", "unknown"))
    project_db: DatabaseManager | None = None

    try:
        if args.validate_metadata:
            seen: set[Tuple[str, str]] = set()
            for _, row in df.iterrows():
                pair = (
                    str(resolve_project_key(jira, find_first_value(row, "project", defaults.get("project_key", "VCAME")), {})),
                    str(find_first_value(row, "issue_type", defaults.get("issue_type", "Bug"))),
                )
                if pair in seen:
                    continue
                seen.add(pair)
                create_fields = get_create_meta_fields(jira, pair[0], pair[1])
                lookup = build_field_name_lookup(create_fields)
                allowed = extract_allowed_values(create_fields)
                logger.info("项目 %s / 类型 %s 可创建字段数: %d", pair[0], pair[1], len(create_fields))
                logger.info("字段映射: %s", lookup)
                logger.info("带候选值字段数: %d", len(allowed))
            return 0

        current_user = str(jira.current_user() or "").strip()
        project_cache: Dict[str, str] = {}
        user_cache: Dict[str, str] = {}
        create_meta_cache: Dict[Tuple[str, str], Dict[str, Any]] = {}
        batch_project_key = collect_batch_project_key(jira, df, project_cache, defaults)
        project_history_sqlite_path_setting = DEFAULT_PROJECT_HISTORY_SQLITE_PATH
        if regression_enabled and regression_rules is not None:
            project_history_sqlite_path_setting = str(
                getattr(getattr(regression_rules, "output", None), "sqlite_path", DEFAULT_PROJECT_HISTORY_SQLITE_PATH)
                or DEFAULT_PROJECT_HISTORY_SQLITE_PATH
            )
        project_db = DatabaseManager(
            {
                "type": "sqlite",
                "path": str(
                    build_project_history_db_path(
                        jira_server,
                        batch_project_key,
                        sqlite_path_setting=project_history_sqlite_path_setting,
                    )
                ),
            }
        )
        migrated_count = migrate_legacy_project_history_db(
            project_db,
            build_legacy_project_history_db_path(jira_server, batch_project_key),
        )
        if migrated_count:
            logger.info("已从旧项目库迁移 %d 条记录到单库缓存: %s", migrated_count, batch_project_key)
        regression_rows = [build_regression_row(row, defaults) for _, row in df.iterrows()]
        batch_current_version = select_current_version(
            [str(item.get("current_version") or "").strip() for item in regression_rows]
        )
        batch_specialties = collect_batch_specialties(df, defaults)

        run_id = datetime.now().strftime("%Y%m%d_%H%M%S")
        store: RegressionStore | None = None
        snapshot_rows: List[Dict[str, Any]] = []
        if regression_enabled:
            regression_base_jql = build_regression_base_jql(
                batch_project_key,
                override_reporter_in_jql(
                    getattr(getattr(regression_rules, "jira_export", None), "jql", ""),
                    current_user or str(defaults.get("default_reporter", "") or ""),
                ),
            )
            summary_keywords = collect_regression_summary_keywords(df, defaults)
            store = RegressionStore(
                build_project_scoped_sqlite_path(
                    batch_project_key,
                    getattr(regression_rules.output, "sqlite_path", "result/tinno_regression_cache"),
                )
            )
            snapshot_rows = export_jira_snapshot(
                jira,
                regression_rules,
                base_jql=regression_base_jql,
                summary_keywords=summary_keywords,
                field_mapping=build_snapshot_field_mapping(defaults),
            )
            snapshot_rows = deduplicate_snapshot_rows_by_jira_key(snapshot_rows)
            store.save_sync_run(
                {
                    "run_id": run_id,
                    "started_at": datetime.now().isoformat(timespec="seconds"),
                    "jql": build_regression_export_jql(regression_base_jql, summary_keywords),
                    "current_version": batch_current_version,
                }
            )
            repaired_count = backfill_issue_state_from_project_history(store, project_db)
            if repaired_count:
                logger.info("已用项目主表回填 %d 条 issue_state 记录: %s", repaired_count, batch_project_key)
            store.save_snapshot(run_id, snapshot_rows)
            _upsert_snapshot_issue_states(store, snapshot_rows)

        results: List[Dict[str, Any]] = []
        summary_rows: List[Dict[str, Any]] = []
        matched_history_keys: set[str] = set()

        for index, row in df.iterrows():
            row_number = index + 2
            row_log_label = build_row_log_label(index)
            regression_row = regression_rows[index]
            project_key = str(resolve_project_key(jira, regression_row.get("project", ""), project_cache) or "")
            summary = str(regression_row.get("summary") or "")
            matched_row: Dict[str, Any] | None = None
            decision = build_create_new_decision()
            try:
                if create_only_mode:
                    reason = "create-only 模式"
                else:
                    reason = "未命中历史单"
                if regression_enabled:
                    matched_row = find_regression_match(regression_row, snapshot_rows, regression_rules.matching)
                    if matched_row and store is not None:
                        matched_key = str(matched_row.get("jira_key") or "").strip()
                        matched_row = merge_history_sources(
                            matched_row,
                            store.fetch_issue_state(matched_key),
                            get_project_history_issue(project_db, matched_key),
                        )
                    if matched_row and str((matched_row or {}).get("jira_key") or "").strip():
                        matched_history_keys.add(str(matched_row.get("jira_key")).strip())
                    reason = "命中历史单" if matched_row else "未命中历史单"
                if not create_only_mode:
                    decision = decide_action(
                        regression_row,
                        matched_row or {},
                        current_version=regression_row.get("current_version", ""),
                        strict_version_project_keys=get_strict_version_project_keys(regression_rules),
                    )
                requires_issue_fields = not matched_row or bool(
                    getattr(decision, "update_jira", False) or getattr(decision, "recreate_issue", False)
                )
                issue_fields: Dict[str, Any] = {}
                if requires_issue_fields:
                    issue_fields = build_issue_fields(
                        jira_client=jira,
                        row=row,
                        defaults=defaults,
                        user_cache=user_cache,
                        project_cache=project_cache,
                        create_meta_cache=create_meta_cache,
                    )

                matched_jira_key = str((matched_row or {}).get("jira_key") or "").strip()
                if args.dry_run:
                    dry_run_message = f"dry-run: {getattr(decision, 'action', '')}"
                    logger.info(
                        "%s dry-run结果: matched_jira_key=%s action=%s reason=%s",
                        row_log_label,
                        matched_jira_key or "NONE",
                        str(getattr(decision, "action", "") or ""),
                        reason,
                    )
                    if regression_enabled and store is not None:
                        store.save_execution_result(
                            build_execution_result(
                                run_id=run_id,
                                row_number=row_number,
                                matched_row=matched_row,
                                action=str(getattr(decision, "action", "") or ""),
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
                                matched_jira_key=matched_jira_key,
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

                execution_outcome = execute_decision(
                    jira_client=jira,
                    row=row,
                    issue_fields=issue_fields,
                    decision=decision,
                    matched_row=matched_row,
                    args=args,
                    row_number=row_number,
                )
                result_status = str(execution_outcome.get("status") or "SUCCESS")
                issue_key = str(execution_outcome.get("issue_key") or "").strip() or None
                result_message = str(execution_outcome.get("result_message") or getattr(decision, "action", ""))
                success_flag = result_status != "FAILED"
                outcome_reason = str(execution_outcome.get("reason") or reason)
                logger.info(
                    "%s 执行结果: matched_jira_key=%s action=%s reason=%s status=%s result=%s",
                    row_log_label,
                    matched_jira_key or issue_key or "NONE",
                    str(getattr(decision, "action", "") or ""),
                    outcome_reason,
                    result_status,
                    result_message,
                )

                if regression_enabled and store is not None:
                    persisted_match_row = matched_row if matched_row else ({"jira_key": issue_key} if issue_key else None)
                    store.save_execution_result(
                        build_execution_result(
                            run_id=run_id,
                            row_number=row_number,
                            matched_row=persisted_match_row,
                            action=str(getattr(decision, "action", "") or ""),
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
                            matched_jira_key=matched_jira_key or (issue_key or ""),
                            action=str(getattr(decision, "action", "") or ""),
                            success=success_flag,
                            manual_review=bool(getattr(decision, "manual_review", False)),
                            reason=outcome_reason,
                            result_message=result_message,
                            comment_status=str(execution_outcome.get("comment_status") or ""),
                            ps_comment_status=str(execution_outcome.get("ps_comment_status") or ""),
                        )
                    )
                    if issue_key:
                        store.upsert_issue_state(
                            {
                                "jira_key": issue_key,
                                "status": (matched_row or {}).get("status") or "Open",
                                "resolution": (matched_row or {}).get("resolution"),
                                "fix_version": (matched_row or {}).get("fix_version"),
                                "build_version": (matched_row or {}).get("build_version") or regression_row.get("build_version"),
                                "last_seen_version": regression_row.get("current_version"),
                                "updated_at": datetime.now().isoformat(timespec="seconds"),
                            }
                        )
                if success_flag and issue_key:
                    sync_issue_to_project_history_db(
                        project_db=project_db,
                        jira_key=issue_key,
                        source_row=row,
                        effective_issue_fields=execution_outcome.get("effective_issue_fields"),
                        assignee_fallback_used=bool(execution_outcome.get("assignee_fallback_used", False)),
                        regression_row=regression_row,
                        status=str((matched_row or {}).get("status") or "Open"),
                        resolution=str((matched_row or {}).get("resolution") or ""),
                        fix_version=str((matched_row or {}).get("fix_version") or ""),
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
            except Exception as exc:
                logger.exception("%s 处理失败", row_log_label)
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

            if not args.dry_run and args.wait_between_issues > 0 and index < len(df) - 1:
                time.sleep(max(args.wait_between_issues, 0.0))

        if regression_enabled and store is not None:
            process_regression_pass_candidates(
                jira_client=jira,
                store=store,
                project_db=project_db,
                run_id=run_id,
                current_version=batch_current_version,
                regression_rules=regression_rules,
                matched_jira_keys=matched_history_keys,
                allowed_specialties=batch_specialties,
                args=args,
                results=results,
                summary_rows=summary_rows,
            )
            if is_duplicate_followups_enabled(regression_rules):
                process_closed_main_duplicate_followups(
                    jira_client=jira,
                    store=store,
                    project_db=project_db,
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
    finally:
        jira.close()
        if project_db is not None:
            project_db.close()


def run_regression_verify_mode(args: argparse.Namespace) -> int:
    defaults = load_defaults(args.config_file)
    apply_test_mode_defaults(args, defaults)
    if bool(getattr(args, "test_mode", False)) and not args.regression_project:
        args.regression_project = DEFAULT_TEST_MODE_PROJECT_KEY
    if bool(getattr(args, "test_mode", False)) and not args.current_version:
        args.current_version = infer_test_mode_current_version(args, defaults)
    regression_rules = load_regression_rules(DEFAULT_REGRESSION_RULES_FILE)
    regression_enabled = is_regression_enabled(regression_rules) and not bool(getattr(args, "disable_regression", False))
    if getattr(args, "create_only", False):
        logger.error("回归验证模式不支持 --create-only")
        return 1
    if not regression_enabled:
        logger.error("回归验证模式要求回归功能处于开启状态")
        return 1
    if not args.regression_project:
        logger.error("回归验证模式需要提供 --regression-project")
        return 1
    if not args.current_version:
        logger.error("回归验证模式需要提供 --current-version")
        return 1
    resolved_specialties = resolve_regression_specialties(getattr(args, "regression_specialties", []), defaults)
    if not resolved_specialties:
        logger.error("回归验证模式需要提供 --regression-specialty")
        return 1
    if not args.history_reporter:
        logger.error("回归验证模式需要提供 --history-reporter")
        return 1
    if not args.jira_cookie_jsessionid and not args.jira_cookie_xsrf_token and (not args.jira_username or not args.jira_password):
        logger.error("需要提供 Cookie 或 Jira 用户名密码")
        return 1
    if not args.jira_p12_path or not args.jira_p12_password:
        logger.error("需要提供 Tinno P12 证书路径和密码")
        return 1
    if args.validate_metadata:
        logger.warning("回归验证模式忽略 --validate-metadata")

    jira_server = args.jira_server or defaults["jira_server"]
    jira = connect_to_jira(
        server=jira_server,
        username=args.jira_username,
        password=args.jira_password,
        p12_file_path=args.jira_p12_path,
        p12_password=args.jira_p12_password,
        verify=bool(defaults.get("verify", False)),
        cookie_string=args.jira_cookie_string,
        cookie_jsessionid=args.jira_cookie_jsessionid,
        cookie_xsrf_token=args.jira_cookie_xsrf_token,
    )
    logger.info("当前认证来源: %s", getattr(jira, "auth_mode", "unknown"))
    project_db: DatabaseManager | None = None

    try:
        project_key = str(args.regression_project or "").strip()
        current_version = str(args.current_version or "").strip()
        history_reporter = str(args.history_reporter or "").strip()
        project_history_sqlite_path_setting = str(
            getattr(getattr(regression_rules, "output", None), "sqlite_path", DEFAULT_PROJECT_HISTORY_SQLITE_PATH)
            or DEFAULT_PROJECT_HISTORY_SQLITE_PATH
        )
        project_db = DatabaseManager(
            {
                "type": "sqlite",
                "path": str(
                    build_project_history_db_path(
                        jira_server,
                        project_key,
                        sqlite_path_setting=project_history_sqlite_path_setting,
                    )
                ),
            }
        )
        migrated_count = migrate_legacy_project_history_db(
            project_db,
            build_legacy_project_history_db_path(jira_server, project_key),
        )
        if migrated_count:
            logger.info("已从旧项目库迁移 %d 条记录到单库缓存: %s", migrated_count, project_key)
        summary_keywords = collect_regression_summary_keywords(
            pd.DataFrame([{"Summary": f"{defaults.get('summary_prefix', '[自动化]')}[{resolved_specialties[0]}]"}]),
            defaults,
        )

        run_id = datetime.now().strftime("%Y%m%d_%H%M%S")
        store = RegressionStore(
            build_project_scoped_sqlite_path(
                project_key,
                getattr(regression_rules.output, "sqlite_path", "result/tinno_regression_cache"),
            )
        )
        base_jql = build_regression_base_jql(project_key, f"reporter in ({history_reporter})")
        all_snapshot_rows: List[Dict[str, Any]] = []
        built_jqls: List[str] = []
        for specialty in resolved_specialties:
            built_jqls.append(build_regression_verify_jql(project_key, history_reporter, specialty, defaults))
            all_snapshot_rows.extend(
                export_jira_snapshot(
                    jira,
                    regression_rules,
                    base_jql=base_jql,
                    summary_keywords=[resolve_regression_verify_summary_keyword(specialty, defaults)],
                    field_mapping=build_snapshot_field_mapping(defaults),
                )
            )
        snapshot_rows = all_snapshot_rows
        snapshot_rows = deduplicate_snapshot_rows_by_jira_key(snapshot_rows)
        store.save_sync_run(
            {
                "run_id": run_id,
                "started_at": datetime.now().isoformat(timespec="seconds"),
                "jql": "\n".join(built_jqls) if built_jqls else build_regression_export_jql(base_jql, summary_keywords),
                "current_version": current_version,
            }
        )
        repaired_count = backfill_issue_state_from_project_history(store, project_db)
        if repaired_count:
            logger.info("已用项目主表回填 %d 条 issue_state 记录: %s", repaired_count, project_key)
        store.save_snapshot(run_id, snapshot_rows)
        _upsert_snapshot_issue_states(store, snapshot_rows)

        results: List[Dict[str, Any]] = []
        summary_rows: List[Dict[str, Any]] = []
        process_regression_pass_candidates(
            jira_client=jira,
            store=store,
            project_db=project_db,
            run_id=run_id,
            current_version=current_version,
            regression_rules=regression_rules,
            matched_jira_keys=set(),
            allowed_specialties=set(resolved_specialties),
            args=args,
            results=results,
            summary_rows=summary_rows,
        )
        if is_duplicate_followups_enabled(regression_rules):
            process_closed_main_duplicate_followups(
                jira_client=jira,
                store=store,
                project_db=project_db,
                run_id=run_id,
                regression_rules=regression_rules,
                snapshot_rows=snapshot_rows,
                allowed_specialties=set(resolved_specialties),
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
    finally:
        jira.close()
        if project_db is not None:
            project_db.close()


def main() -> int:
    load_local_env()
    setup_logging()
    args = parse_args()
    if args.regression_project:
        return run_regression_verify_mode(args)
    return run_excel_mode(args)


if __name__ == "__main__":
    raise SystemExit(main())
