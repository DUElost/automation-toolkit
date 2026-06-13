#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Transsion 上传模板公共逻辑
-------------------------

仅服务于当前目录下第一阶段“原始结果 -> 上传模板”脚本。
"""

from __future__ import annotations

import copy
import json
import logging
import os
import re
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

import pandas as pd

logger = logging.getLogger(__name__)
CURRENT_DIR = Path(__file__).resolve().parent
CONFIG_DIR = CURRENT_DIR / "config"


def load_defaults(config_path: str | Path) -> Dict[str, Any]:
    with open(config_path, "r", encoding="utf-8") as fp:
        return json.load(fp)


def load_local_ps_whitelist(whitelist_path: str | Path) -> Dict[str, Any]:
    path = Path(whitelist_path)
    if not path.exists():
        return {}
    try:
        with open(path, "r", encoding="utf-8") as fp:
            data = json.load(fp)
        return data if isinstance(data, dict) else {}
    except Exception as exc:
        logger.warning("读取本地 PS 白名单失败: %s", exc)
        return {}


def load_project_key_mapping(mapping_path: str | Path) -> Dict[str, str]:
    path = Path(mapping_path)
    if not path.exists():
        logger.warning("项目映射文件不存在: %s", path)
        return {}
    with open(path, "r", encoding="utf-8") as fp:
        data = json.load(fp)
    return {str(key).strip(): str(value).strip() for key, value in data.items() if str(key).strip() and str(value).strip()}


def load_affect_project_mapping(mapping_path: str | Path) -> Dict[str, Dict[str, str]]:
    path = Path(mapping_path)
    if not path.exists():
        logger.warning("Affect Project 统一映射文件不存在: %s", path)
        return {}
    with open(path, "r", encoding="utf-8") as fp:
        data = json.load(fp)

    mapping: Dict[str, Dict[str, str]] = {}
    for raw_key, raw_value in data.items():
        affect_project = str(raw_key).strip()
        if not affect_project:
            continue
        if isinstance(raw_value, dict):
            jira_project = str(raw_value.get("jira_project") or "").strip()
            affect_project_value = str(raw_value.get("affect_project") or "").strip()
            monkey_project = str(raw_value.get("monkey_project") or "").strip()
        else:
            jira_project = str(raw_value).strip()
            affect_project_value = str(raw_value).strip()
            monkey_project = ""
        mapping[affect_project] = {
            "jira_project": jira_project,
            "affect_project": affect_project_value,
            "monkey_project": monkey_project,
        }
    return mapping


def split_affect_project_mapping(mapping: Dict[str, Dict[str, str]]) -> Tuple[Dict[str, str], Dict[str, str], Dict[str, str]]:
    project_key_mapping: Dict[str, str] = {}
    affect_project_value_mapping: Dict[str, str] = {}
    monkey_project_mapping: Dict[str, str] = {}
    for affect_project, item in mapping.items():
        jira_project = str(item.get("jira_project") or "").strip()
        affect_project_value = str(item.get("affect_project") or "").strip()
        monkey_project = str(item.get("monkey_project") or "").strip()
        if jira_project:
            project_key_mapping[affect_project] = jira_project
        if affect_project_value:
            affect_project_value_mapping[affect_project] = affect_project_value
        if monkey_project:
            monkey_project_mapping[affect_project] = monkey_project
    return project_key_mapping, affect_project_value_mapping, monkey_project_mapping


DEFAULT_PRIORITY_ALIAS_MAPPING: Dict[str, List[str]] = {
    "紧急": ["S", "1", "highest", "blocker"],
    "严重": ["A", "2", "high", "critical"],
    "重要": ["B", "3", "medium", "major"],
    "次要": ["C", "4", "low", "minor"],
    "微小": ["5", "lowest", "trivial"],
}

LOG_PATH_REPLACEMENTS = {
    "/home/jxtinno/sonic_tinno": "220.175.120.251",
}

LOG_SERVER_FILE_MANAGER_URL = "ftp://172.21.15.4"
LOG_SERVER_FILEZILLA_HOST = "220.175.120.251"
LOG_SERVER_USERNAME = "jxtinno"
LOG_SERVER_PASSWORD_ENV = "TRANSSION_LOG_SERVER_PASSWORD"
LOG_SERVER_PASSWORD_PLACEHOLDER = "<请从本地安全配置获取>"
LOCAL_PS_WHITELIST_FILE = CONFIG_DIR / "local_ps_whitelist.json"


def read_excel_smart(file_path: str | Path) -> pd.DataFrame:
    path = Path(file_path)
    if path.suffix.lower() == ".xlsx":
        return pd.read_excel(path, engine="openpyxl")
    if path.suffix.lower() == ".xls":
        return pd.read_excel(path, engine="xlrd")
    try:
        return pd.read_excel(path, engine="openpyxl")
    except Exception:
        return pd.read_excel(path, engine="xlrd")


def read_excel_sheet(file_path: str | Path, sheet_name: str) -> pd.DataFrame:
    path = Path(file_path)
    if path.suffix.lower() == ".xlsx":
        return pd.read_excel(path, sheet_name=sheet_name, engine="openpyxl")
    return pd.read_excel(path, sheet_name=sheet_name, engine="xlrd")


def clean_cell_value(value: Any) -> Any:
    if isinstance(value, str):
        cleaned = value.strip()
        return cleaned if cleaned and cleaned.lower() != "nan" else None
    if pd.isna(value):
        return None
    return value


def load_package_owner_mapping(mapping_path: str | Path) -> Dict[str, Dict[str, str]]:
    df = read_excel_smart(mapping_path)
    mappings: Dict[str, Dict[str, str]] = {}
    for _, row in df.iterrows():
        package = clean_cell_value(row.get("应用包名"))
        module = clean_cell_value(row.get("模块"))
        owner = clean_cell_value(row.get("负责人"))
        if not package or not module:
            continue
        mappings[str(package).lower()] = {
            "component": str(module),
            "owner": str(owner) if owner else "",
        }
    logger.info("已加载包名映射 %d 条", len(mappings))
    return mappings


def normalize_int_value(value: Any, default: int = 0) -> int:
    cleaned = clean_cell_value(value)
    if cleaned is None:
        return default
    try:
        return int(float(cleaned))
    except Exception:
        digits = re.findall(r"\d+", str(cleaned))
        if digits:
            return int(digits[0])
    return default


def normalize_log_path_text(path_text: Any) -> str:
    text = str(clean_cell_value(path_text) or "").strip()
    for source, target in LOG_PATH_REPLACEMENTS.items():
        text = text.replace(source, target)
    return text


def normalize_exp_class_display(exp_class: Any) -> str:
    text = str(clean_cell_value(exp_class) or "").strip()
    if not text:
        return ""
    bracket_match = re.search(r"\(([A-Za-z]{2,10})\)\s*$", text)
    if bracket_match:
        return bracket_match.group(1).upper()
    if re.fullmatch(r"[A-Za-z]{2,10}", text):
        return text.upper()
    return text


def load_component_regex_mapping(regex_path: str | Path) -> List[Tuple[re.Pattern[str], str]]:
    text = Path(regex_path).read_text(encoding="utf-8", errors="ignore")
    pattern = re.compile(r'"([^"]+)"\s*:\s*"([^"]+)"')
    rules: List[Tuple[re.Pattern[str], str]] = []
    for raw_pattern, component in pattern.findall(text):
        try:
            rules.append((re.compile(raw_pattern, re.IGNORECASE), component))
        except re.error:
            logger.warning("忽略非法正则: %s", raw_pattern)
    logger.info("已加载正则模块映射 %d 条", len(rules))
    return rules


def parse_count_requirement(text: str) -> Tuple[str, int]:
    match = re.search(r"(>=|<=|>|<|=)\s*(\d+)", text)
    if match:
        return match.group(1), int(match.group(2))
    digits = re.findall(r"\d+", text)
    if digits:
        return ">=", int(digits[0])
    return ">=", 0


def load_severity_rules(rules_path: str | Path) -> List[Dict[str, Any]]:
    df = read_excel_smart(rules_path)
    rules: List[Dict[str, Any]] = []
    for _, row in df.iterrows():
        level = clean_cell_value(row.get("问题等级"))
        keyword = clean_cell_value(row.get("报错类型"))
        requirement = clean_cell_value(row.get("次数要求")) or ">=0"
        if not level or not keyword:
            continue
        operator, threshold = parse_count_requirement(str(requirement))
        rules.append(
            {
                "level": str(level),
                "keyword": str(keyword),
                "operator": operator,
                "threshold": threshold,
            }
        )
    logger.info("已加载问题等级规则 %d 条", len(rules))
    return rules


def load_probability_rating_mapping(rating_path: str | Path) -> Dict[str, Dict[str, Any]]:
    df = read_excel_smart(rating_path)
    mapping: Dict[str, Dict[str, Any]] = {}
    for _, row in df.iterrows():
        level = clean_cell_value(row.get("概率"))
        if not level:
            continue
        mapping[str(level).strip().lower()] = {
            "add_occasional_tag": bool(normalize_int_value(row.get("是否加偶现标签"), 0)),
            "title_phrase": str(clean_cell_value(row.get("标题附加词语")) or "").strip(),
        }
    logger.info("已加载问题出现概率规则 %d 条", len(mapping))
    return mapping


def load_test_case_summary(summary_path: str | Path) -> Dict[str, Dict[str, Any]]:
    df = read_excel_smart(summary_path)
    summary_mapping: Dict[str, Dict[str, Any]] = {}
    for row_index, row in df.iterrows():
        test_case = clean_cell_value(row.get("测试项"))
        if not test_case:
            continue
        case_index = clean_cell_value(row.get("编号"))
        if case_index is None:
            case_index = row_index
        summary_mapping[str(test_case).strip()] = {
            "index": str(normalize_int_value(case_index, row_index)),
            "total_runs": normalize_int_value(row.get("测试总次数"), 20),
            "preconditions": str(clean_cell_value(row.get("测试步骤")) or "").strip(),
        }
    logger.info("已加载专项汇总 %d 条", len(summary_mapping))
    return summary_mapping


def resolve_test_case_name(
    raw_test_case: Any,
    default_test_case: Any,
    test_case_summary_mapping: Dict[str, Dict[str, Any]],
    source_label: str,
) -> str:
    candidate = clean_cell_value(raw_test_case)
    candidate_source = source_label
    if candidate is None:
        candidate = clean_cell_value(default_test_case)
        candidate_source = f"{source_label} -> --set-test-case"

    if candidate is None:
        raise ValueError(f"{candidate_source} 为空，无法匹配稳定性专项汇总.xlsx 中的测试项")

    candidate_text = str(candidate).strip()
    if candidate_text in test_case_summary_mapping:
        return candidate_text

    candidate_index = str(normalize_int_value(candidate, -1))
    if candidate_index != "-1":
        for test_case_name, item in test_case_summary_mapping.items():
            item_index = str(clean_cell_value(item.get("index")) or "").strip()
            if item_index == candidate_index:
                return test_case_name

    valid_pairs = "、".join(
        f"{item.get('index')}={test_case_name}"
        for test_case_name, item in test_case_summary_mapping.items()
    )
    raise ValueError(
        f"{candidate_source}={candidate_text} 与稳定性专项汇总.xlsx 不匹配；"
        f"请填写测试项全名或编号，当前支持: {valid_pairs}"
    )


def load_priority_mapping_from_rules_excel(rules_path: str | Path) -> Dict[str, Dict[str, Any]]:
    path = Path(rules_path)
    if not path.exists():
        logger.warning("问题等级规则表不存在: %s", path)
        return {
            "severity_to_priority": {},
            "priority_aliases": copy.deepcopy(DEFAULT_PRIORITY_ALIAS_MAPPING),
        }

    priority_aliases = copy.deepcopy(DEFAULT_PRIORITY_ALIAS_MAPPING)
    severity_to_priority: Dict[str, str] = {}

    try:
        mapping_df = read_excel_sheet(path, "等级优先级映射")
    except Exception:
        logger.warning("未在 %s 中读取到 sheet: 等级优先级映射，使用默认优先级映射", path)
        return {
            "severity_to_priority": severity_to_priority,
            "priority_aliases": priority_aliases,
        }

    for _, row in mapping_df.iterrows():
        severity_level = clean_cell_value(row.get("问题等级"))
        priority_name = clean_cell_value(row.get("Jira优先级")) or clean_cell_value(row.get("Priority"))
        aliases_text = clean_cell_value(row.get("Priority别名")) or clean_cell_value(row.get("别名"))
        if not priority_name:
            continue

        canonical_priority = str(priority_name).strip()
        alias_list = priority_aliases.setdefault(canonical_priority, [])

        if severity_level:
            severity_text = str(severity_level).strip().upper()
            severity_to_priority[severity_text] = canonical_priority
            if severity_text not in alias_list:
                alias_list.append(severity_text)

        if aliases_text:
            for alias in re.split(r"[,;，；]\s*", str(aliases_text)):
                alias_clean = str(alias).strip()
                if alias_clean and alias_clean not in alias_list:
                    alias_list.append(alias_clean)

    return {
        "severity_to_priority": severity_to_priority,
        "priority_aliases": priority_aliases,
    }


def match_requirement(actual_count: int, operator: str, threshold: int) -> bool:
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
    return True


def detect_severity_result(issue_data: Dict[str, Any], rules: List[Dict[str, Any]]) -> Tuple[str, str]:
    primary_text = " ".join(
        [
            str(issue_data.get("exp_class") or ""),
            str(issue_data.get("exp_type") or ""),
        ]
    ).lower()
    secondary_text = " ".join(
        [
            str(issue_data.get("package") or ""),
            str(issue_data.get("cur_process") or ""),
            str(issue_data.get("caused_by") or ""),
        ]
    ).lower()
    count = int(issue_data.get("count") or 0)

    for rule in rules:
        keyword = str(rule["keyword"]).lower()
        if keyword not in primary_text:
            continue
        if match_requirement(count, str(rule["operator"]), int(rule["threshold"])):
            return str(rule["level"]), f"rule={rule['level']} | keyword={rule['keyword']} | count {rule['operator']} {rule['threshold']} | source=primary"

    for rule in rules:
        keyword = str(rule["keyword"]).lower()
        if keyword not in secondary_text:
            continue
        if match_requirement(count, str(rule["operator"]), int(rule["threshold"])):
            return str(rule["level"]), f"rule={rule['level']} | keyword={rule['keyword']} | count {rule['operator']} {rule['threshold']} | source=secondary"

    if count >= 20:
        return "A", "fallback=count>=20"
    if count >= 5:
        return "B", "fallback=5<=count<20"
    return "C", "fallback=count<5"


def detect_severity_level(issue_data: Dict[str, Any], rules: List[Dict[str, Any]]) -> str:
    return detect_severity_result(issue_data, rules)[0]


def derive_risk_value(count: int, device_count: int = 0) -> str:
    if count <= 1:
        return "once"
    if device_count <= 0:
        if count >= 10:
            return "must"
        if count >= 5:
            return "often"
        return "occasional"
    ratio = count / max(device_count, 1)
    if ratio >= 0.8:
        return "must"
    if ratio >= 0.4:
        return "often"
    if ratio > 0.1:
        return "occasional"
    return "once"


def derive_probability_level(count: int, total_runs: int) -> str:
    if count <= 1:
        return "once"
    if total_runs > 0 and count >= total_runs:
        return "must"
    if total_runs <= 0:
        return "often" if count >= 3 else "occasional"
    return "often" if (count / total_runs) >= (3 / 20) else "occasional"


def build_probability_context(
    count: int,
    total_runs: int,
    probability_rating_mapping: Dict[str, Dict[str, Any]],
) -> Dict[str, Any]:
    level = derive_probability_level(count, total_runs)
    config = probability_rating_mapping.get(level, {})
    return {
        "level": level,
        "total_runs": total_runs,
        "add_occasional_tag": bool(config.get("add_occasional_tag", level != "must")),
        "title_phrase": str(config.get("title_phrase") or "").strip(),
    }


def derive_affect_project(version: str, explicit_value: Optional[str] = None) -> str:
    if explicit_value:
        return str(explicit_value).strip()
    version_str = str(version or "").strip()
    return version_str.split("-", 1)[0] if "-" in version_str else version_str


def resolve_affect_project_template_value(
    affect_project: str,
    affect_project_value_mapping: Dict[str, str],
    project_key_mapping: Dict[str, str],
) -> str:
    affect_project_text = str(affect_project or "").strip()
    if not affect_project_text:
        return ""
    mapped_option_value = str(affect_project_value_mapping.get(affect_project_text, "") or "").strip()
    if mapped_option_value:
        return mapped_option_value
    mapped_project_key = str(project_key_mapping.get(affect_project_text, "") or "").strip()
    if mapped_project_key:
        return mapped_project_key
    return affect_project_text


def resolve_project_key_for_test_case(
    affect_project: str,
    test_case: str,
    project_key_mapping: Dict[str, str],
    monkey_project_mapping: Dict[str, str],
    default_project_key: str,
) -> str:
    affect_project_text = str(affect_project or "").strip()
    test_case_text = str(test_case or "").strip()
    if test_case_text == "Monkey专项":
        monkey_project = str(monkey_project_mapping.get(affect_project_text, "") or "").strip()
        if monkey_project:
            return monkey_project
    mapped_project_key = str(project_key_mapping.get(affect_project_text, "") or "").strip()
    if mapped_project_key:
        return mapped_project_key
    return str(default_project_key or "").strip()


def map_severity_to_priority(level: str, severity_to_priority: Dict[str, str]) -> str:
    normalized_level = str(level or "").strip().upper()
    if not normalized_level:
        return "重要"
    return severity_to_priority.get(normalized_level, "重要")


def derive_issue_target(issue_data: Dict[str, Any]) -> str:
    ignored = {"kernel api dump", "none", "nan", ""}
    for candidate in [
        issue_data.get("package"),
        issue_data.get("cur_process"),
        issue_data.get("exp_type"),
        issue_data.get("exp_class"),
    ]:
        if not candidate:
            continue
        text = str(candidate).strip()
        if text.lower() in ignored:
            continue
        return text
    return "系统"


def is_same_package_and_exp_class(issue_data: Dict[str, Any]) -> bool:
    package = str(issue_data.get("package") or "").strip().lower()
    exp_class = str(issue_data.get("exp_class") or "").strip().lower()
    return bool(package and exp_class and package == exp_class)


def build_failure_phrase(issue_target: str, exp_class: str, probability_phrase: str = "", same_package_as_exp_class: bool = False) -> str:
    target = issue_target or "系统"
    upper = (exp_class or "").strip().upper()
    prefix = str(probability_phrase or "").strip()

    def apply_prefix(action_text: str) -> str:
        return f"{prefix}{action_text}" if prefix else action_text

    if same_package_as_exp_class and exp_class:
        return f"测试机{apply_prefix('发生了')}{exp_class}报错"
    if "ANR" in upper:
        return f"{target}{apply_prefix('出现')}ANR"
    if "NE" in upper:
        return f"{target}{apply_prefix('发生')}NE报错"
    if "KE" in upper or "KERNEL" in upper:
        return f"{target}{apply_prefix('发生')}KE报错"
    if "DUMP" in upper:
        return f"{apply_prefix('发生')}{exp_class}"
    return f"{target}{apply_prefix('发生')}{exp_class or '异常'}报错"


def infer_component_and_owner(
    issue_data: Dict[str, Any],
    package_owner_mapping: Dict[str, Dict[str, str]],
    regex_mapping: List[Tuple[re.Pattern[str], str]],
) -> Tuple[str, str]:
    package = str(issue_data.get("package") or "").strip().lower()
    if package and package in package_owner_mapping:
        item = package_owner_mapping[package]
        return item.get("component", ""), item.get("owner", "")

    search_text = " ".join(
        [
            str(issue_data.get("package") or ""),
            str(issue_data.get("cur_process") or ""),
            str(issue_data.get("exp_class") or ""),
            str(issue_data.get("exp_type") or ""),
            str(issue_data.get("detail") or ""),
            str(issue_data.get("caused_by") or ""),
        ]
    )
    for pattern, component in regex_mapping:
        if pattern.search(search_text):
            return component, ""
    return "", ""


def build_summary_text(issue_data: Dict[str, Any], test_case: str, summary_tags: List[str], defaults: Dict[str, Any]) -> str:
    count = int(issue_data.get("count") or 0)
    affect_project = derive_affect_project(str(issue_data.get("version") or ""), issue_data.get("affect_project"))
    tags = [
        defaults.get("default_team_tag", "天珑团队"),
        defaults.get("default_bug_tag", "BUG"),
    ]
    if affect_project:
        tags.append(affect_project)
    tags.extend([tag for tag in summary_tags if tag])
    tags.append(defaults.get("default_category_tag", "稳定性专项"))
    tags.append(test_case)
    if issue_data.get("add_occasional_tag"):
        tags.append("偶现")
    tags.append(f"Total Number {count}")
    failure_phrase = build_failure_phrase(
        derive_issue_target(issue_data),
        str(issue_data.get("exp_class") or ""),
        str(issue_data.get("probability_phrase") or ""),
        is_same_package_and_exp_class(issue_data),
    )
    summary = "".join(f"【{tag}】" for tag in tags) + f"执行{test_case}过程中，{failure_phrase}"
    return summary[:255] if len(summary) > 255 else summary


def resolve_rom_ram_text(issue_data: Dict[str, Any]) -> str:
    return str(clean_cell_value(issue_data.get("rom_ram")) or "").strip()


def build_description_text(issue_data: Dict[str, Any], test_case: str, defaults: Dict[str, Any], environment_override: Optional[str]) -> str:
    count = int(issue_data.get("count") or 0)
    total_runs = int(issue_data.get("total_runs") or 0) or 20
    issue_target = derive_issue_target(issue_data)
    base_failure_phrase = build_failure_phrase(
        issue_target,
        str(issue_data.get("exp_class") or ""),
        "",
        is_same_package_and_exp_class(issue_data),
    )
    failure_phrase = build_failure_phrase(
        issue_target,
        str(issue_data.get("exp_class") or ""),
        str(issue_data.get("probability_phrase") or ""),
        is_same_package_and_exp_class(issue_data),
    )
    normalized_expect_source = base_failure_phrase.replace("发生了", "发生")
    expect_phrase = normalized_expect_source.replace("出现", "不会出现").replace("发生", "不会发生")
    if expect_phrase == base_failure_phrase:
        expect_phrase = f"{issue_target}不会发生{issue_data.get('exp_class') or '异常'}报错"

    rom_ram = resolve_rom_ram_text(issue_data) or "/"
    creator = str(defaults.get("default_creator") or "NA").strip() or "NA"
    detail = clean_cell_value(issue_data.get("detail"))

    parts = [
        f"*Precondition*: {issue_data.get('preconditions') or defaults.get('default_preconditions', '/')}",
        f"*Environment*: {rom_ram}",
        f"*Operation Steps*: 执行{test_case}",
        f"*Expect Result*: 执行{test_case}过程中，{expect_phrase}",
        f"*Test Result*: 执行{test_case}过程中，{failure_phrase}",
        f"*Ref Phone Results If Needed*: {defaults.get('default_ref_result', '无需对比')}",
        f"*Risk*: {count}/{total_runs}，评级 {issue_data.get('probability_level') or ''}",
        "*Log And Screenshot Address*:",
        str(issue_data.get("path") or ""),
        f"*Recovery Technique*: {defaults.get('default_recovery', '不涉及恢复')}",
        f"*Problem Time*: {issue_data.get('exp_time') or '/'}",
        f"*Creator*: {creator}",
        "*Others*:",
    ]
    if detail:
        parts.append(str(detail))
    return "\n".join(parts)


def build_log_server_access_text() -> str:
    whitelist = load_local_ps_whitelist(LOCAL_PS_WHITELIST_FILE)
    allow_embed_password = bool(whitelist.get("allow_embed_log_server_password", False))
    whitelist_password = str(whitelist.get("log_server_password") or "").strip()
    env_password = str(os.getenv(LOG_SERVER_PASSWORD_ENV) or "").strip()
    password_text = LOG_SERVER_PASSWORD_PLACEHOLDER
    if allow_embed_password:
        password_text = whitelist_password or env_password or LOG_SERVER_PASSWORD_PLACEHOLDER
    return "\n".join(
        [
            f"*{LOG_SERVER_FILEZILLA_HOST} 日志服务器访问方式：*",
            f"1、文件管理器中输入{LOG_SERVER_FILE_MANAGER_URL} 账号：{LOG_SERVER_USERNAME} 密码：{password_text}",
            f"2、使用filezilla工具连接 地址：{LOG_SERVER_FILEZILLA_HOST} 账号：{LOG_SERVER_USERNAME} 密码：{password_text} 端口默认21",
        ]
    )


def build_ps_text(issue_data: Dict[str, Any], reporter: str) -> str:
    return "\n".join(
        [
            f"*Reporter:* {reporter}",
            f"*Version:* {issue_data.get('version') or ''}",
            f"*Path:* {issue_data.get('path') or ''}",
            f"*Duplicate Number:* {issue_data.get('count') or 0}",
            f"*Device Count:* {issue_data.get('device_count') or 1}",
            f"*Probability:* {issue_data.get('count') or 0}/{issue_data.get('total_runs') or 20} -> {issue_data.get('probability_level') or ''}",
            build_log_server_access_text(),
        ]
    )


def build_environment_text(issue_data: Dict[str, Any], environment_override: Optional[str]) -> str:
    detail_text = str(issue_data.get("detail") or "")
    matched_lines: List[str] = []
    for line in detail_text.splitlines():
        stripped = str(line).strip()
        if not stripped:
            continue
        if stripped.startswith("异常包名：") or stripped.startswith("异常进程："):
            matched_lines.append(stripped)
    if matched_lines:
        return "\n".join(matched_lines)
    fallback_lines: List[str] = []
    exp_class = normalize_exp_class_display(issue_data.get("exp_class"))
    cur_process = str(clean_cell_value(issue_data.get("cur_process")) or "").strip()
    if exp_class:
        fallback_lines.append(f"Exp Class：{exp_class}")
    if cur_process:
        fallback_lines.append(f"CurProcess：{cur_process}")
    if fallback_lines:
        return "\n".join(fallback_lines)
    rom_ram = resolve_rom_ram_text(issue_data)
    if rom_ram:
        return rom_ram
    return environment_override or ""


def prepare_issue_record(
    raw_row: pd.Series,
    test_case: str,
    defaults: Dict[str, Any],
    project_key_mapping: Dict[str, str],
    affect_project_value_mapping: Dict[str, str],
    monkey_project_mapping: Dict[str, str],
    severity_to_priority_mapping: Dict[str, str],
    severity_rules: List[Dict[str, Any]],
    probability_rating_mapping: Dict[str, Dict[str, Any]],
    test_case_summary_mapping: Dict[str, Dict[str, Any]],
    package_owner_mapping: Dict[str, Dict[str, str]],
    regex_mapping: List[Tuple[re.Pattern[str], str]],
    summary_tags: List[str],
    default_affect_project: Optional[str],
    environment_override: Optional[str],
    default_case_no: Optional[str],
    default_reporter: Optional[str],
    default_assignee: Optional[str],
) -> Dict[str, Any]:
    count_raw = clean_cell_value(raw_row.get("Count")) or 0
    device_id = clean_cell_value(raw_row.get("DeviceId"))
    device_count_raw = (
        clean_cell_value(raw_row.get("Device Count"))
        or clean_cell_value(raw_row.get("DeviceCount"))
        or clean_cell_value(raw_row.get("device_count"))
    )
    device_count = normalize_int_value(device_count_raw, 0)
    if device_count <= 0:
        device_count = 1 if device_id else 0

    issue_data = {
        "id": clean_cell_value(raw_row.get("Id")) or "",
        "path": normalize_log_path_text(raw_row.get("Path")),
        "version": clean_cell_value(raw_row.get("Version")) or "",
        "exp_time": clean_cell_value(raw_row.get("ExpTime")) or "",
        "exp_class": clean_cell_value(raw_row.get("ExpClass")) or "",
        "exp_type": clean_cell_value(raw_row.get("ExpType ")) or "",
        "cur_process": clean_cell_value(raw_row.get("CurProcess")) or "",
        "package": clean_cell_value(raw_row.get("Package")) or "",
        "detail": clean_cell_value(raw_row.get("Detail")) or "",
        "caused_by": clean_cell_value(raw_row.get("CausedBy")) or "",
        "rom_ram": clean_cell_value(raw_row.get("Rom_Ram")) or clean_cell_value(raw_row.get("rom_ram")) or "",
        "count": int(float(count_raw)),
        "device_count": device_count,
        "device_id": device_id or "",
        "affect_project": derive_affect_project(
            str(clean_cell_value(raw_row.get("Version")) or ""),
            default_affect_project,
        ),
    }

    test_case_summary = test_case_summary_mapping.get(test_case, {})
    total_runs = int(test_case_summary.get("total_runs") or 20)
    probability_context = build_probability_context(issue_data["count"], total_runs, probability_rating_mapping)
    issue_data["total_runs"] = total_runs
    issue_data["preconditions"] = str(test_case_summary.get("preconditions") or defaults.get("default_preconditions", "/"))
    issue_data["probability_level"] = probability_context["level"]
    issue_data["probability_phrase"] = probability_context["title_phrase"]
    issue_data["add_occasional_tag"] = probability_context["add_occasional_tag"]

    component, owner = infer_component_and_owner(issue_data, package_owner_mapping, regex_mapping)
    severity_level, severity_rule = detect_severity_result(issue_data, severity_rules)
    reporter = default_reporter or defaults.get("default_reporter", "")
    assignee = owner or default_assignee or defaults.get("default_assignee", reporter)
    # Transsion 当前流程中 Case No 不使用原始 Activity，统一固定为 NA。
    case_no = default_case_no or "NA"
    affect_project_option = resolve_affect_project_template_value(
        issue_data["affect_project"],
        affect_project_value_mapping,
        project_key_mapping,
    )
    resolved_project_key = resolve_project_key_for_test_case(
        issue_data["affect_project"],
        test_case,
        project_key_mapping,
        monkey_project_mapping,
        defaults.get("project_key", ""),
    )

    return {
        "Project": resolved_project_key,
        "Issue Type": defaults.get("issue_type", "故障"),
        "Summary": build_summary_text(issue_data, test_case, summary_tags, defaults),
        "Description": build_description_text(issue_data, test_case, defaults, environment_override),
        "Priority": map_severity_to_priority(severity_level, severity_to_priority_mapping),
        "Severity Level": severity_level,
        "Severity Rule": severity_rule,
        "Assignee": assignee,
        "Reporter": reporter,
        "Components": component or "Framework_other",
        "Versions": issue_data["version"],
        "Environment": build_environment_text(issue_data, environment_override),
        "Risk": issue_data["probability_level"],
        "Issue Source": defaults.get("default_issue_source", "内测 (自动化测试)"),
        "Issue Category": defaults.get("default_issue_category", "Stability"),
        "Issue Nature": defaults.get("default_issue_nature", "New issues"),
        "Affect Project": affect_project_option,
        "Case No": case_no,
        "Clients": ", ".join(defaults.get("default_clients", [])),
        "Fix Way": defaults.get("default_fix_way", "修改代码"),
        "Focus": defaults.get("default_focus", "None"),
        "Importance": defaults.get("default_importance", "中"),
        "Security Level": defaults.get("default_security_level", "ODM项目"),
        "Opener": reporter,
        "PS": build_ps_text(issue_data, reporter),
        "Exp Class": normalize_exp_class_display(issue_data["exp_class"]),
        "CausedBy": issue_data["caused_by"],
        "Package": issue_data["package"],
        "Count": issue_data["count"],
        "Device Count": issue_data["device_count"],
        "Test Total Count": issue_data["total_runs"],
    }
