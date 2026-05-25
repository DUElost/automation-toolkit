#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Tinno Jira 第一阶段上传模板公共逻辑
---------------------------------

当前版本复用仓库中已验证过的 Tinno 标题、描述、Environment 和 PS 格式，
并迁移 Transsion 第一阶段里已验证的“测试专项解析”入口。
"""

from __future__ import annotations

import json
import logging
import re
from pathlib import Path
from typing import Any, Dict, List, Optional

import pandas as pd

from jira_issue_template import build_description, build_environment, build_ps, build_summary, map_severity_to_priority

logger = logging.getLogger(__name__)

EXCEL_FIELD_CANDIDATES = {
    "path": ["Path", "path", "日志地址", "Log Path"],
    "package": ["包名", "Package", "package", "异常包名", "App Package"],
    "version": ["版本", "Version", "version", "Build", "软件版本"],
    "exp_class": ["异常类型", "ExpClass", "Exp Class", "exp_class", "Exception Class"],
    "exp_type": ["异常子类", "ExpType ", "ExpType", "Exp Type", "exp_type", "Exception Type"],
    "cur_process": ["当前进程", "CurProcess", "cur_process", "异常进程", "Process"],
    "detail": ["Detail", "detail", "详情", "Description"],
    "key_information": ["key_information", "CausedBy", "caused_by", "关键日志", "Key Information"],
    "count": ["Count", "count", "次数", "Total Number"],
    "device_count": ["Device Count", "device_count", "DeviceCount", "设备数"],
    "severity_level": ["Severity Level", "severity_level", "问题等级", "Bug Severity"],
    "affect_project": ["Affect Project", "affect_project", "机型", "项目"],
    "test_case": ["TestCase", "Test Case", "test_case", "测试项", "测试专项", "专项"],
}

DEFAULT_TEST_CASE_ALIAS_MAPPING = {
    "monkeyaee": "Monkey专项",
    "monkey": "Monkey专项",
    "mtbf": "MTBF专项",
    "sleepwake": "休眠唤醒专项",
    "sleepawake": "休眠唤醒专项",
    "wakelock": "休眠唤醒专项",
    "poweronoff": "开关机专项",
    "poweroffon": "开关机专项",
    "reboot": "开关机专项",
    "restart": "开关机专项",
    "adbrebootmonkey": "ADB重启+Monkey专项",
    "factoryreset": "恢复出厂专项",
    "memleakstress": "内存泄漏Stress专项",
    "memoryleakstress": "内存泄漏Stress专项",
    "ddr": "DDR专项",
    "gpu": "GPU压力专项",
}

DEFAULT_TEST_CASE_LABEL_MAPPING = {
    "Monkey专项": "MonkeyAEE",
}


def clean_cell_value(value: Any) -> Any:
    if value is None:
        return ""
    try:
        if pd.isna(value):
            return ""
    except Exception:
        pass
    if isinstance(value, str):
        return value.strip()
    return value


def find_first_value(row: Any, field_name: str, default: Any = None) -> Any:
    for candidate in EXCEL_FIELD_CANDIDATES.get(field_name, []):
        value = clean_cell_value(row.get(candidate, None))
        if value not in ("", None):
            return value
    return default


def load_defaults(config_file: str | Path) -> Dict[str, Any]:
    with open(config_file, "r", encoding="utf-8") as fp:
        return json.load(fp)


def read_excel_smart(file_path: str | Path) -> pd.DataFrame:
    path = Path(file_path)
    if not path.exists():
        raise FileNotFoundError(f"Excel 文件不存在: {path}")
    if path.suffix.lower() == ".xlsx":
        return pd.read_excel(path, engine="openpyxl")
    if path.suffix.lower() == ".xls":
        return pd.read_excel(path)
    return pd.read_excel(path)


def _find_column(columns: List[str], candidates: List[str]) -> Optional[str]:
    lookup = {str(column).strip().lower(): column for column in columns}
    for candidate in candidates:
        key = candidate.strip().lower()
        if key in lookup:
            return lookup[key]
    return None


def load_package_owner_mapping(file_path: str | Path) -> Dict[str, Dict[str, str]]:
    path = Path(file_path)
    if not path.exists():
        logger.warning("包名映射文件不存在: %s", path)
        return {}
    df = read_excel_smart(path)
    package_col = _find_column(list(df.columns), ["包名", "Package", "package", "应用包名"])
    module_col = _find_column(list(df.columns), ["模块", "Module", "module", "组件", "Components"])
    assignee_col = _find_column(list(df.columns), ["经办人", "Assignee", "assignee", "负责人"])
    if not package_col:
        logger.warning("包名映射文件缺少包名列: %s", path)
        return {}

    mapping: Dict[str, Dict[str, str]] = {}
    for _, row in df.iterrows():
        package_name = str(clean_cell_value(row.get(package_col, "")) or "")
        if not package_name:
            continue
        mapping[package_name] = {
            "module": str(clean_cell_value(row.get(module_col, "")) or "") if module_col else "",
            "assignee": str(clean_cell_value(row.get(assignee_col, "")) or "") if assignee_col else "",
        }
    return mapping


def load_affect_project_mapping(file_path: str | Path) -> Dict[str, Dict[str, str]]:
    path = Path(file_path)
    if not path.exists():
        logger.warning("Affect Project 映射文件不存在: %s", path)
        return {}
    with open(path, "r", encoding="utf-8") as fp:
        data = json.load(fp)

    mapping: Dict[str, Dict[str, str]] = {}
    for raw_key, raw_value in data.items():
        affect_project = str(clean_cell_value(raw_key) or "").strip()
        if not affect_project:
            continue
        if isinstance(raw_value, dict):
            jira_project = str(clean_cell_value(raw_value.get("jira_project")) or "").strip()
            affect_project_value = str(clean_cell_value(raw_value.get("affect_project")) or affect_project).strip()
            monkey_project = str(clean_cell_value(raw_value.get("monkey_project")) or "").strip()
        else:
            jira_project = str(clean_cell_value(raw_value) or "").strip()
            affect_project_value = affect_project
            monkey_project = ""
        mapping[affect_project] = {
            "jira_project": jira_project,
            "affect_project": affect_project_value or affect_project,
            "monkey_project": monkey_project,
        }
    return mapping


def load_test_case_summary(summary_path: str | Path) -> Dict[str, Dict[str, Any]]:
    path = Path(summary_path)
    if not path.exists():
        logger.warning("稳定性专项汇总文件不存在: %s", path)
        return {}
    df = read_excel_smart(path)
    summary_mapping: Dict[str, Dict[str, Any]] = {}
    for row_index, row in df.iterrows():
        test_case = clean_cell_value(row.get("测试项"))
        if not test_case:
            continue
        case_index = clean_cell_value(row.get("编号"))
        if case_index is None:
            case_index = row_index
        summary_mapping[str(test_case).strip()] = {
            "index": str(_normalize_int(case_index, row_index)),
            "total_runs": _normalize_int(row.get("测试总次数"), 20),
            "preconditions": str(clean_cell_value(row.get("测试步骤")) or "").strip(),
        }
    logger.info("已加载 Tinno 专项汇总 %d 条", len(summary_mapping))
    return summary_mapping


def _parse_count_requirement(text: str) -> tuple[str, int]:
    match = re.search(r"(>=|<=|>|<|=)\s*(\d+)", str(text))
    if match:
        return match.group(1), int(match.group(2))
    digits = re.findall(r"\d+", str(text))
    if digits:
        return ">=", int(digits[0])
    return ">=", 0


def load_severity_rules(file_path: str | Path) -> List[Dict[str, Any]]:
    path = Path(file_path)
    if not path.exists():
        logger.warning("问题等级规则表不存在: %s", path)
        return []
    try:
        df = read_excel_smart(path)
    except Exception as exc:
        logger.warning("读取问题等级规则表失败: %s", exc)
        return []

    rules: List[Dict[str, Any]] = []
    for _, row in df.iterrows():
        level = str(clean_cell_value(row.get("问题等级")) or "").strip()
        keyword = str(clean_cell_value(row.get("报错类型")) or "").strip()
        requirement = str(clean_cell_value(row.get("次数要求")) or ">=0").strip()
        if not level or not keyword:
            continue
        operator, threshold = _parse_count_requirement(requirement)
        rules.append(
            {
                "level": level,
                "keyword": keyword,
                "operator": operator,
                "threshold": threshold,
            }
        )
    return rules


def _normalize_int(value: Any, default: int = 0) -> int:
    try:
        cleaned = clean_cell_value(value)
        if cleaned in ("", None):
            return default
        text = str(cleaned).strip()
        if not text:
            return default
        return int(float(text))
    except Exception:
        return default


def _normalize_lookup_text(value: Any) -> str:
    return re.sub(r"[\s_\-+/\\]+", "", str(clean_cell_value(value) or "")).lower()


def infer_test_case_from_text(
    text: Any,
    test_case_summary_mapping: Optional[Dict[str, Dict[str, Any]]] = None,
) -> str:
    text_value = str(clean_cell_value(text) or "").strip()
    if not text_value:
        return ""
    normalized_text = _normalize_lookup_text(text_value)
    if not normalized_text:
        return ""

    for test_case in (test_case_summary_mapping or {}).keys():
        normalized_case = _normalize_lookup_text(test_case)
        if normalized_case and normalized_case in normalized_text:
            return str(test_case).strip()

    for alias, resolved in DEFAULT_TEST_CASE_ALIAS_MAPPING.items():
        if alias in normalized_text:
            if not test_case_summary_mapping or resolved in test_case_summary_mapping:
                return resolved
    return ""


def infer_test_case_from_excel_path(
    file_path: str | Path | None,
    test_case_summary_mapping: Optional[Dict[str, Dict[str, Any]]] = None,
) -> str:
    if not file_path:
        return ""
    path = Path(file_path)
    for candidate in (path.stem, path.name, str(path)):
        resolved = infer_test_case_from_text(candidate, test_case_summary_mapping)
        if resolved:
            return resolved
    return ""


def resolve_test_case_name(
    raw_test_case: Any,
    default_test_case: Any,
    test_case_summary_mapping: Optional[Dict[str, Dict[str, Any]]],
    source_label: str,
) -> str:
    summary_mapping = test_case_summary_mapping or {}
    candidate = clean_cell_value(raw_test_case)
    candidate_source = source_label
    if candidate in ("", None):
        candidate = clean_cell_value(default_test_case)
        candidate_source = f"{source_label} -> 默认专项"

    if candidate in ("", None):
        raise ValueError(f"{candidate_source} 为空，无法解析 Tinno 测试专项")

    candidate_text = str(candidate).strip()
    if not summary_mapping:
        return candidate_text
    if candidate_text in summary_mapping:
        return candidate_text

    candidate_index = str(_normalize_int(candidate, -1))
    if candidate_index != "-1":
        for test_case_name, item in summary_mapping.items():
            item_index = str(clean_cell_value(item.get("index")) or "").strip()
            if item_index == candidate_index:
                return test_case_name

    inferred = infer_test_case_from_text(candidate_text, summary_mapping)
    if inferred:
        return inferred

    valid_pairs = "、".join(
        f"{item.get('index')}={test_case_name}"
        for test_case_name, item in summary_mapping.items()
    )
    raise ValueError(
        f"{candidate_source}={candidate_text} 与稳定性专项汇总.xlsx 不匹配；"
        f"请填写测试项全名、编号或可识别别名，当前支持: {valid_pairs}"
    )


def resolve_test_case_label(test_case: Any, defaults: Dict[str, Any]) -> str:
    test_case_text = str(clean_cell_value(test_case) or "").strip()
    label_mapping = defaults.get("test_case_label_mapping", {}) or {}
    mapped = str(clean_cell_value(label_mapping.get(test_case_text, "")) or "").strip()
    if mapped:
        return mapped
    mapped = DEFAULT_TEST_CASE_LABEL_MAPPING.get(test_case_text, "")
    if mapped:
        return mapped
    if test_case_text.endswith("专项"):
        return test_case_text[:-2]
    if test_case_text:
        return test_case_text
    labels = defaults.get("labels", ["MonkeyAEE"])
    if isinstance(labels, list) and labels:
        return str(labels[0] or "").strip() or "MonkeyAEE"
    return str(labels or "").strip() or "MonkeyAEE"


def _build_issue_data(
    row: Any,
    *,
    test_case: str = "",
    test_case_label: str = "",
) -> Dict[str, Any]:
    return {
        "path": str(find_first_value(row, "path", "")),
        "package": str(find_first_value(row, "package", "unknown.package")),
        "version": str(find_first_value(row, "version", "Unknown")),
        "exp_class": str(find_first_value(row, "exp_class", "Unknown")),
        "exp_type": str(find_first_value(row, "exp_type", "")),
        "cur_process": str(find_first_value(row, "cur_process", find_first_value(row, "package", "unknown.package"))),
        "detail": str(find_first_value(row, "detail", "")),
        "key_information": str(find_first_value(row, "key_information", "")),
        "count": _normalize_int(find_first_value(row, "count", 0), default=0),
        "device_count": _normalize_int(find_first_value(row, "device_count", 0), default=0),
        "affect_project": str(find_first_value(row, "affect_project", "")),
        "test_case": test_case,
        "test_case_label": test_case_label,
    }


def _match_count_requirement(actual_count: int, operator: str, threshold: int) -> bool:
    if operator == ">=":
        return actual_count >= threshold
    if operator == ">":
        return actual_count > threshold
    if operator == "<=":
        return actual_count <= threshold
    if operator == "<":
        return actual_count < threshold
    if operator == "=":
        return actual_count == threshold
    return actual_count >= threshold


def _detect_severity_level(issue_data: Dict[str, Any], defaults: Dict[str, Any], severity_rules: Optional[List[Dict[str, Any]]]) -> str:
    exp_class = str(issue_data.get("exp_class") or "")
    exp_type = str(issue_data.get("exp_type") or "")
    search_text = f"{exp_class} {exp_type}".lower()
    count = int(issue_data.get("count") or 0)
    for rule in severity_rules or []:
        keyword = str(rule.get("keyword") or "").strip().lower()
        if not keyword or keyword not in search_text:
            continue
        if _match_count_requirement(count, str(rule.get("operator") or ">="), int(rule.get("threshold") or 0)):
            return str(rule.get("level") or defaults.get("default_bug_severity", "B"))
    return str(defaults.get("default_bug_severity", "B"))


def _derive_affect_project_from_version(version: str) -> str:
    text = str(clean_cell_value(version) or "").strip()
    if not text:
        return ""
    version_parts = [part.strip() for part in text.split("-") if str(part).strip()]
    if len(version_parts) >= 2 and version_parts[1].upper().startswith("LX"):
        return f"{version_parts[0]}-{version_parts[1]}"
    first_token = re.split(r"[-_\s]", text, maxsplit=1)[0]
    return first_token.strip()


def _resolve_project_and_affect_project(
    issue_data: Dict[str, Any],
    defaults: Dict[str, Any],
    affect_project_mapping: Optional[Dict[str, Dict[str, str]]],
    project_override: Optional[str],
) -> tuple[str, str]:
    explicit_affect_project = str(issue_data.get("affect_project") or "").strip()
    derived_affect_project = _derive_affect_project_from_version(str(issue_data.get("version") or ""))
    affect_project_key = explicit_affect_project or derived_affect_project
    mapping_item = (affect_project_mapping or {}).get(affect_project_key, {})
    affect_project_value = (
        str(mapping_item.get("affect_project") or "").strip()
        or affect_project_key
        or str(defaults.get("default_affect_project", "")).strip()
    )
    project_value = (
        str(project_override or "").strip()
        or str(mapping_item.get("jira_project") or "").strip()
        or str(defaults.get("project_key", "VCAME")).strip()
    )
    return project_value, affect_project_value


def build_upload_rows(
    main_df: pd.DataFrame,
    defaults: Dict[str, Any],
    package_mapping: Dict[str, Dict[str, str]],
    severity_rules: Optional[List[Dict[str, Any]]] = None,
    affect_project_mapping: Optional[Dict[str, Dict[str, str]]] = None,
    test_case_summary_mapping: Optional[Dict[str, Dict[str, Any]]] = None,
    reporter_override: Optional[str] = None,
    assignee_override: Optional[str] = None,
    project_override: Optional[str] = None,
    module_override: Optional[str] = None,
    default_test_case: Optional[str] = None,
    source_excel_path: Optional[str | Path] = None,
) -> List[Dict[str, Any]]:
    rows: List[Dict[str, Any]] = []
    inferred_default_test_case = (
        str(clean_cell_value(default_test_case) or "").strip()
        or infer_test_case_from_excel_path(source_excel_path, test_case_summary_mapping)
        or str(clean_cell_value(defaults.get("default_test_case", "")) or "").strip()
    )
    for _, row in main_df.iterrows():
        resolved_test_case = resolve_test_case_name(
            raw_test_case=find_first_value(row, "test_case", None),
            default_test_case=inferred_default_test_case,
            test_case_summary_mapping=test_case_summary_mapping,
            source_label="上传模板行专项",
        )
        issue_data = _build_issue_data(
            row,
            test_case=resolved_test_case,
            test_case_label=resolve_test_case_label(resolved_test_case, defaults),
        )
        package_info = package_mapping.get(issue_data["package"], {})
        explicit_severity_level = str(find_first_value(row, "severity_level", "") or "").strip()
        severity_level = explicit_severity_level or _detect_severity_level(issue_data, defaults, severity_rules)
        priority = map_severity_to_priority(severity_level)
        reporter = reporter_override or defaults.get("default_reporter", "")
        assignee = assignee_override or package_info.get("assignee") or defaults.get("default_assignee", "")
        module = (
            module_override
            or package_info.get("module")
            or str(defaults.get("default_module_fallback", "System Stability")).strip()
            or "System Stability"
        )
        project_value, _ = _resolve_project_and_affect_project(
            issue_data=issue_data,
            defaults=defaults,
            affect_project_mapping=affect_project_mapping,
            project_override=project_override,
        )
        rows.append(
            {
                "Project": project_value,
                "Issue Type": defaults.get("issue_type", "Bug"),
                "Summary": build_summary(issue_data),
                "Description": build_description(issue_data),
                "Priority": priority,
                "Bug Severity": severity_level,
                "Test Case": resolved_test_case,
                "key_information": issue_data["key_information"],
                "Module": module,
                "Components": module,
                "Assignee": assignee,
                "Reporter": reporter,
                "Versions": issue_data["version"],
                "Environment": build_environment(issue_data),
                "PS": build_ps(issue_data, reporter=reporter),
                "Previous Version Status": defaults.get("default_previous_version_status", "Previous version exists"),
                "Previous Version Text": defaults.get("default_previous_version_text", "100%"),
            }
        )
    return rows


def save_upload_list(rows: List[Dict[str, Any]], output_path: str | Path) -> Path:
    target = Path(output_path)
    target.parent.mkdir(parents=True, exist_ok=True)
    pd.DataFrame(rows).to_excel(target, index=False, engine="openpyxl")
    return target
