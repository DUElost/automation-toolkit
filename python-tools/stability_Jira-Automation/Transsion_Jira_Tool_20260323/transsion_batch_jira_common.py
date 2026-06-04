#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Transsion Jira 第二阶段公共逻辑
------------------------------

供当前目录下批量建单脚本复用。
"""

from __future__ import annotations

import logging
import os
import re
import json
from typing import Any, Dict, List, Optional, Tuple

from jira import JIRA

logger = logging.getLogger(__name__)

EXCEL_FIELD_CANDIDATES = {
    "project": ["Project", "project"],
    "issue_type": ["Issue Type", "issuetype", "issue_type"],
    "summary": ["Summary", "summary"],
    "description": ["Description", "description"],
    "priority": ["Priority", "priority"],
    "severity_level": ["Severity Level", "severity_level", "问题等级"],
    "exp_class": ["Exp Class", "exp_class", "ExpClass"],
    "caused_by": ["CausedBy", "Cause By", "caused_by"],
    "assignee": ["Assignee", "assignee"],
    "reporter": ["Reporter", "reporter"],
    "components": ["Components", "components", "Module", "module"],
    "versions": ["Versions", "versions", "Version", "version"],
    "environment": ["Environment", "environment"],
    "risk": ["Risk", "risk"],
    "issue_source": ["Issue Source", "问题来源", "issue_source"],
    "issue_category": ["Issue Category", "问题分类", "issue_category"],
    "issue_nature": ["Issue Nature", "问题性质", "issue_nature"],
    "affect_project": ["Affect Project", "affect_project", "AffectProject"],
    "case_no": ["Case No", "case_no", "用例编号"],
    "clients": ["Clients", "clients"],
    "fix_way": ["Fix Way", "fix_way"],
    "focus": ["Focus", "重点关注", "focus"],
    "importance": ["Importance", "重要性", "importance"],
    "security_level": ["Security Level", "security", "安全级别"],
    "opener": ["Opener", "opener"],
    "ps": ["PS", "备注", "Comment", "comment"],
}

ATTACHMENT_RISK_NAME_MAP = {
    "once": "Once",
    "occasional": "Occasional",
    "often": "Often",
    "must": "Must",
}

ATTACHMENT_PRIORITY_NAME_MAP = {
    "紧急": "Block",
    "严重": "Critical",
    "重要": "Major",
    "次要": "Major",
    "微小": "Major",
    "block": "Block",
    "blocker": "Block",
    "critical": "Critical",
    "major": "Major",
}

OPEN_STATUS_NAMES = {"open", "开放"}
OPEN_TRANSITION_NAMES = {"allocate", "open"}

def clean_cell_value(value: Any) -> Any:
    if isinstance(value, str):
        cleaned = value.strip()
        return cleaned if cleaned and cleaned.lower() != "nan" else None
    try:
        import pandas as pd  # 延迟导入，避免工具脚本启动过重
        if pd.isna(value):
            return None
    except Exception:
        pass
    return value


def find_first_value(row: Any, field_name: str, default: Any = None) -> Any:
    for column in EXCEL_FIELD_CANDIDATES.get(field_name, []):
        if hasattr(row, "index") and column in row.index:
            value = clean_cell_value(row[column])
            if value is not None:
                return value
        elif isinstance(row, dict) and column in row:
            value = clean_cell_value(row[column])
            if value is not None:
                return value
    return default


def build_priority_alias_lookup(
    severity_to_priority_mapping: Dict[str, str],
    priority_alias_mapping: Dict[str, List[str]],
) -> Dict[str, str]:
    lookup: Dict[str, str] = {}
    for severity, priority_name in severity_to_priority_mapping.items():
        severity_text = str(severity).strip().lower()
        priority_text = str(priority_name).strip()
        if severity_text and priority_text:
            lookup[severity_text] = priority_text
    for canonical_name, aliases in priority_alias_mapping.items():
        canonical_text = str(canonical_name).strip()
        if not canonical_text:
            continue
        lookup[canonical_text.lower()] = canonical_text
        for alias in aliases:
            alias_text = str(alias).strip().lower()
            if alias_text:
                lookup[alias_text] = canonical_text
    return lookup


def normalize_priority_name(
    value: Any,
    severity_to_priority_mapping: Dict[str, str],
    priority_alias_mapping: Dict[str, List[str]],
) -> str:
    if value is None:
        return "重要"
    text = str(value).strip()
    if not text:
        return "重要"
    alias_lookup = build_priority_alias_lookup(severity_to_priority_mapping, priority_alias_mapping)
    return alias_lookup.get(text.lower(), text)


def normalize_comma_values(value: Any) -> List[str]:
    if value is None:
        return []
    if isinstance(value, list):
        return [str(item).strip() for item in value if str(item).strip()]
    tokens = re.split(r"[,;，；]\s*", str(value).strip())
    return [token for token in tokens if token]


def connect_to_jira(server: str, username: str, password: str) -> JIRA:
    for key in ["HTTP_PROXY", "HTTPS_PROXY", "http_proxy", "https_proxy", "ALL_PROXY", "all_proxy"]:
        os.environ.pop(key, None)
    os.environ["NO_PROXY"] = "*"
    options = {
        "server": server,
        "verify": False,
        "proxies": {"http": None, "https": None},
    }
    return JIRA(options=options, basic_auth=(username, password))


def fetch_issue_snapshot_fields(
    jira_client: JIRA,
    issue_key: str,
    field_mapping: Optional[Dict[str, Any]] = None,
) -> Dict[str, Any]:
    issue = jira_client.issue(issue_key)
    raw_payload = getattr(issue, "raw", {}) or {}
    fields = raw_payload.get("fields", {}) if isinstance(raw_payload, dict) else {}
    issue_fields = getattr(issue, "fields", None)

    def pick_value(container: Any, key: str) -> Any:
        if isinstance(container, dict):
            return container.get(key)
        return getattr(container, key, None)

    def normalize_fix_version(value: Any) -> Optional[str]:
        if value is None:
            return None
        if isinstance(value, list):
            names = []
            for item in value:
                if isinstance(item, dict):
                    name = str(item.get("name") or item.get("value") or "").strip()
                else:
                    name = str(item or "").strip()
                if name:
                    names.append(name)
            return ", ".join(names) if names else None
        if isinstance(value, dict):
            name = str(value.get("name") or value.get("value") or "").strip()
            return name or None
        text = str(value).strip()
        return text or None

    def normalize_name(value: Any) -> Optional[str]:
        if value is None:
            return None
        if isinstance(value, str):
            text = value.strip()
            return text or None
        name = pick_value(value, "name")
        if name is not None:
            text = str(name).strip()
            return text or None
        option_value = pick_value(value, "value")
        if option_value is not None:
            text = str(option_value).strip()
            return text or None
        text = str(value).strip()
        return text or None

    def resolve_field_value(field_name: str) -> Any:
        mapped_value: Any = None
        if field_mapping:
            mapping_value = field_mapping.get(field_name)
            if isinstance(mapping_value, (list, tuple, set)):
                candidates = [str(item).strip() for item in mapping_value if str(item).strip()]
            elif mapping_value:
                candidates = [str(mapping_value).strip()]
            else:
                candidates = []
            for candidate in candidates:
                if candidate in fields:
                    mapped_value = fields.get(candidate)
                    break
                if issue_fields is not None and hasattr(issue_fields, candidate):
                    mapped_value = getattr(issue_fields, candidate)
                    break
            if mapped_value is not None:
                return mapped_value
        if field_name in fields:
            return fields.get(field_name)
        if issue_fields is not None and hasattr(issue_fields, field_name):
            return getattr(issue_fields, field_name)
        return None

    status_value = pick_value(fields, "status")
    resolution_value = pick_value(fields, "resolution")
    fix_versions = pick_value(fields, "fixVersions") or pick_value(fields, "fix_version") or []
    raw_payload_text = raw_payload
    if not isinstance(raw_payload_text, str):
        raw_payload_text = json.dumps(raw_payload_text, ensure_ascii=False)

    result: Dict[str, Any] = {
        "jira_key": str(getattr(issue, "key", issue_key) or issue_key),
        "summary": pick_value(fields, "summary"),
        "status": normalize_name(pick_value(status_value, "name")) or normalize_name(pick_value(issue_fields, "status")),
        "resolution": normalize_name(pick_value(resolution_value, "name")) or normalize_name(
            pick_value(issue_fields, "resolution")
        ),
        "fix_version": normalize_fix_version(fix_versions),
        "raw_payload": raw_payload_text,
    }

    for field_name in ("affect_project", "environment", "exp_class", "caused_by"):
        value = resolve_field_value(field_name)
        if value is not None:
            result[field_name] = normalize_name(value)

    return result


def resolve_project_key(
    jira_client: JIRA,
    raw_project: str,
    project_cache: Optional[Dict[str, str]] = None,
) -> str:
    text = str(raw_project or "").strip()
    if not text:
        return text

    cache = project_cache if project_cache is not None else {}
    if text in cache:
        return cache[text]

    try:
        project = jira_client.project(text)
        resolved = getattr(project, "key", text)
        cache[text] = resolved
        return resolved
    except Exception:
        pass

    try:
        projects = jira_client.projects()
    except Exception:
        projects = []

    for project in projects:
        project_key = getattr(project, "key", "")
        project_name = getattr(project, "name", "")
        if text == project_name or text == project_key:
            cache[text] = project_key
            return project_key

    return text


def get_create_meta_fields(jira_client: JIRA, project_key: str, issue_type_name: str) -> Dict[str, Any]:
    meta = jira_client.createmeta(projectKeys=project_key, expand="projects.issuetypes.fields")
    for project in meta.get("projects", []):
        if project.get("key") != project_key:
            continue
        for issue_type in project.get("issuetypes", []):
            if issue_type.get("name") == issue_type_name:
                return issue_type.get("fields", {})
    return {}


def build_field_name_lookup(create_fields: Dict[str, Any]) -> Dict[str, str]:
    mapping: Dict[str, str] = {}
    for field_id, info in create_fields.items():
        field_name = str(info.get("name") or "").strip()
        if field_name:
            mapping[field_name] = field_id
    return mapping


def extract_allowed_values(create_fields: Dict[str, Any]) -> Dict[str, Dict[str, Any]]:
    result: Dict[str, Dict[str, Any]] = {}
    for field_id, info in create_fields.items():
        allowed_values = info.get("allowedValues", [])
        if not allowed_values:
            continue
        value_map: Dict[str, Any] = {}
        for item in allowed_values:
            if isinstance(item, dict):
                display = item.get("value") or item.get("name") or item.get("id")
                if display is not None:
                    value_map[str(display)] = item
        if value_map:
            result[field_id] = value_map
    return result


def resolve_user_name(
    jira_client: JIRA,
    raw_value: Optional[str],
    user_cache: Optional[Dict[str, str]] = None,
    fallback: Optional[str] = None,
) -> Optional[str]:
    if not raw_value:
        return fallback

    cache = user_cache if user_cache is not None else {}
    text = str(raw_value).strip()
    if not text:
        return fallback
    if text in cache:
        return cache[text]

    candidates = [text]
    if "(" in text:
        candidates.append(text.split("(", 1)[0].strip())
    if "@" in text:
        candidates.append(text.split("@", 1)[0].strip())

    seen = set()
    for candidate in candidates:
        if not candidate or candidate in seen:
            continue
        seen.add(candidate)
        try:
            users = jira_client.search_users(user=candidate, maxResults=20)
        except TypeError:
            users = jira_client.search_users(candidate, maxResults=20)
        except Exception:
            users = []

        for user in users:
            user_name = getattr(user, "name", None)
            display_name = getattr(user, "displayName", "")
            email_address = getattr(user, "emailAddress", "")
            if not user_name:
                continue
            if candidate == user_name or candidate == email_address or candidate in display_name:
                cache[text] = user_name
                return user_name

        if re.fullmatch(r"[A-Za-z0-9._-]+", candidate):
            cache[text] = candidate
            return candidate

    if fallback:
        cache[text] = fallback
    return fallback


def _resolve_option_value(value_text: str, field_allowed: Optional[Dict[str, Any]]) -> str:
    if not value_text or not field_allowed:
        return value_text
    if value_text in field_allowed:
        return value_text
    for key in field_allowed:
        if key.lower() == value_text.lower():
            return key
    return value_text


def option_payload(field_id: str, value: Any, allowed_values: Dict[str, Dict[str, Any]], multi: bool = False) -> Any:
    values = normalize_comma_values(value)
    if not values:
        return [] if multi else None
    resolved = [_resolve_option_value(item, allowed_values.get(field_id)) for item in values]
    if multi:
        return [{"value": item} for item in resolved]
    return {"value": resolved[0]}


def validate_single_value(field_name: str, field_id: str, value: Any, allowed_values: Dict[str, Dict[str, Any]]) -> None:
    if value is None:
        return
    value_text = str(value).strip()
    if not value_text:
        return
    field_allowed = allowed_values.get(field_id)
    if field_allowed:
        matched = _resolve_option_value(value_text, field_allowed)
        if matched != value_text:
            return
        if value_text not in field_allowed:
            raise ValueError(f"{field_name}={value_text} 不在当前项目可选值中")


def validate_multi_values(field_name: str, field_id: str, values: List[str], allowed_values: Dict[str, Dict[str, Any]]) -> None:
    if not values:
        return
    field_allowed = allowed_values.get(field_id)
    if not field_allowed:
        return
    invalid = []
    for item in values:
        matched = _resolve_option_value(item, field_allowed)
        if matched != item:
            continue
        if item not in field_allowed:
            invalid.append(item)
    if invalid:
        raise ValueError(f"{field_name} 存在无效值: {invalid}")


def resolve_components_for_create(values: List[str], allowed_values: Dict[str, Dict[str, Any]]) -> List[str]:
    if not values:
        return values
    field_allowed = allowed_values.get("components")
    if not field_allowed:
        return values
    resolved = [_resolve_option_value(item, field_allowed) for item in values]
    invalid = [item for item in resolved if item not in field_allowed]
    if not invalid:
        return resolved
    fallback_component = "ODM处理"
    if fallback_component not in field_allowed:
        raise ValueError(
            f"Components 存在无效值: {invalid}；尝试回退默认模块 {fallback_component} 失败，"
            f"当前项目未配置该可选值"
        )
    return [fallback_component]


def is_field_available(create_fields: Dict[str, Any], field_id: str) -> bool:
    return bool(field_id) and field_id in create_fields


def resolve_priority_payload(
    raw_value: Any,
    allowed_values: Dict[str, Dict[str, Any]],
    severity_to_priority_mapping: Dict[str, str],
    priority_alias_mapping: Dict[str, List[str]],
) -> Tuple[str, Dict[str, str]]:
    normalized_name = normalize_priority_name(raw_value, severity_to_priority_mapping, priority_alias_mapping)
    raw_text = str(raw_value).strip() if raw_value is not None else ""
    field_allowed = allowed_values.get("priority", {})

    for candidate in [normalized_name, raw_text]:
        if candidate and candidate in field_allowed:
            item = field_allowed[candidate]
            priority_id = str(item.get("id") or "").strip()
            priority_name = str(item.get("name") or candidate).strip()
            if priority_id:
                return priority_name, {"id": priority_id}
            return priority_name, {"name": priority_name}

    for item in field_allowed.values():
        priority_name = str(item.get("name") or "").strip()
        priority_id = str(item.get("id") or "").strip()
        if normalized_name == priority_name or raw_text == priority_name or normalized_name == priority_id or raw_text == priority_id:
            if priority_id:
                return priority_name, {"id": priority_id}
            return priority_name, {"name": priority_name}

    if field_allowed:
        allowed_names = list(field_allowed.keys())
        raise ValueError(f"Priority={raw_text or normalized_name} 不在当前项目可选值中，可选值: {allowed_names}")
    return normalized_name, {"name": normalized_name}


def resolve_bug_severity_attachment_name(
    row: Any,
    severity_to_priority_mapping: Dict[str, str],
    priority_alias_mapping: Dict[str, List[str]],
) -> Optional[str]:
    risk_value = str(find_first_value(row, "risk", "") or "").strip().lower()
    severity_level_raw = str(find_first_value(row, "severity_level", "") or "").strip()
    priority_value_raw = str(find_first_value(row, "priority", "") or "").strip()

    risk_name = ATTACHMENT_RISK_NAME_MAP.get(risk_value)
    normalized_priority = ""
    if severity_level_raw:
        normalized_priority = str(severity_to_priority_mapping.get(severity_level_raw.upper(), "")).strip()
    if not normalized_priority and priority_value_raw:
        normalized_priority = normalize_priority_name(priority_value_raw, severity_to_priority_mapping, priority_alias_mapping)
    severity_name = ATTACHMENT_PRIORITY_NAME_MAP.get(str(normalized_priority or "").strip().lower())
    if not risk_name or not severity_name:
        return None
    return f"{risk_name}-{severity_name}.png"


def transition_issue_to_open(jira_client: JIRA, issue_key: str) -> Tuple[bool, str]:
    issue = jira_client.issue(issue_key)
    current_status = str(getattr(issue.fields.status, "name", "") or "").strip()
    if current_status.lower() in OPEN_STATUS_NAMES:
        return True, f"当前状态已是 {current_status}"

    transitions = jira_client.transitions(issue)
    selected_transition_id: Optional[str] = None
    selected_transition_name = ""
    for transition in transitions:
        transition_name = str(transition.get("name") or "").strip()
        target_status_name = str(((transition.get("to") or {}).get("name")) or "").strip()
        if target_status_name.lower() in OPEN_STATUS_NAMES or transition_name.lower() in OPEN_TRANSITION_NAMES:
            selected_transition_id = str(transition.get("id") or "").strip()
            selected_transition_name = transition_name or target_status_name
            break

    if not selected_transition_id:
        return False, f"未找到从 {current_status} 转到 Open/开放 的可用流转"

    jira_client.transition_issue(issue, selected_transition_id)
    return True, f"{current_status} -> {selected_transition_name}"


def assign_issue_to_user(jira_client: JIRA, issue_key: str, assignee_name: Optional[str]) -> Tuple[bool, str]:
    assignee_text = str(assignee_name or "").strip()
    if not assignee_text:
        return False, "未提供目标经办人"

    try:
        jira_client.assign_issue(issue_key, assignee_text)
        return True, assignee_text
    except Exception:
        pass

    try:
        issue = jira_client.issue(issue_key)
        issue.update(fields={"assignee": {"name": assignee_text}})
        return True, assignee_text
    except Exception as exc:
        return False, str(exc)


def update_issue_fields(jira_client: JIRA, issue_key: str, fields: Dict[str, Any]) -> None:
    issue = jira_client.issue(issue_key)
    issue.update(fields=fields)


def add_issue_comment(jira_client: JIRA, issue_key: str, comment: str) -> None:
    jira_client.add_comment(issue_key, comment)


def build_issue_fields(
    jira_client: JIRA,
    row: Any,
    defaults: Dict[str, Any],
    create_fields: Dict[str, Any],
    allowed_values: Dict[str, Dict[str, Any]],
    severity_to_priority_mapping: Dict[str, str],
    priority_alias_mapping: Dict[str, List[str]],
    user_cache: Dict[str, str],
    project_cache: Dict[str, str],
    create_assignee_override: Optional[str] = None,
    create_reporter_override: Optional[str] = None,
) -> Dict[str, Any]:
    field_ids = defaults.get("field_ids", {})
    project_key = resolve_project_key(jira_client, find_first_value(row, "project", defaults.get("project_key")), project_cache)
    issue_type_name = find_first_value(row, "issue_type", defaults.get("issue_type", "故障"))
    summary = find_first_value(row, "summary", "")
    description = find_first_value(row, "description", "")
    priority_name, priority_payload = resolve_priority_payload(
        find_first_value(row, "priority", "重要"),
        allowed_values,
        severity_to_priority_mapping,
        priority_alias_mapping,
    )
    components = normalize_comma_values(find_first_value(row, "components", ""))
    versions = normalize_comma_values(find_first_value(row, "versions", ""))
    environment = find_first_value(row, "environment", "")
    reporter_raw = find_first_value(row, "reporter", defaults.get("default_reporter"))
    assignee_raw = find_first_value(row, "assignee", defaults.get("default_assignee"))
    reporter = (
        resolve_user_name(jira_client, create_reporter_override, user_cache, fallback=defaults.get("default_reporter"))
        if create_reporter_override
        else resolve_user_name(jira_client, reporter_raw, user_cache, fallback=defaults.get("default_reporter"))
    )
    assignee = resolve_user_name(jira_client, assignee_raw, user_cache, fallback=defaults.get("default_assignee"))
    create_assignee = resolve_user_name(jira_client, create_assignee_override, user_cache, fallback=assignee) if create_assignee_override else assignee

    if not components:
        raise ValueError("Components 不能为空")
    if not versions:
        raise ValueError("Versions 不能为空")

    components = resolve_components_for_create(components, allowed_values)
    validate_multi_values("Components", "components", components, allowed_values)
    try:
        validate_multi_values("Versions", "versions", versions, allowed_values)
    except ValueError:
        version_allowed = allowed_values.get("versions", {})
        logger.error(
            "Versions 校验失败: project=%s issue_type=%s submitted=%s allowed_count=%d allowed_sample=%s",
            project_key,
            issue_type_name,
            versions,
            len(version_allowed),
            list(version_allowed.keys())[:10],
        )
        raise

    issue_fields: Dict[str, Any] = {
        "project": {"key": str(project_key)},
        "issuetype": {"name": str(issue_type_name)},
        "summary": str(summary),
        "description": str(description),
        "priority": priority_payload,
        "components": [{"name": name} for name in components],
        "versions": [{"name": name} for name in versions],
        "reporter": {"name": reporter},
        "assignee": {"name": create_assignee},
    }
    if environment:
        issue_fields["environment"] = str(environment)

    risk_value = find_first_value(row, "risk", "once")
    issue_source_value = find_first_value(row, "issue_source", defaults.get("default_issue_source"))
    issue_category_value = find_first_value(row, "issue_category", defaults.get("default_issue_category"))
    issue_nature_value = find_first_value(row, "issue_nature", defaults.get("default_issue_nature"))
    affect_project_value = find_first_value(row, "affect_project", "")
    case_no_value = find_first_value(row, "case_no", "NA")
    exp_class_value = find_first_value(row, "exp_class", "")
    caused_by_value = find_first_value(row, "caused_by", "")
    clients_value = find_first_value(row, "clients", ",".join(defaults.get("default_clients", [])))
    fix_way_value = find_first_value(row, "fix_way", defaults.get("default_fix_way"))
    focus_value = find_first_value(row, "focus", defaults.get("default_focus"))
    importance_value = find_first_value(row, "importance", defaults.get("default_importance"))
    security_value = find_first_value(row, "security_level", defaults.get("default_security_level"))
    opener_raw = find_first_value(row, "opener", reporter_raw)
    opener_value = (
        resolve_user_name(jira_client, create_reporter_override, user_cache, fallback=reporter)
        if create_reporter_override
        else resolve_user_name(jira_client, opener_raw, user_cache, fallback=reporter)
    )

    if is_field_available(create_fields, field_ids.get("risk", "")):
        validate_single_value("Risk", field_ids["risk"], risk_value, allowed_values)
        issue_fields[field_ids["risk"]] = option_payload(field_ids["risk"], risk_value, allowed_values)
    if is_field_available(create_fields, field_ids.get("issue_source", "")):
        validate_single_value("Issue Source", field_ids["issue_source"], issue_source_value, allowed_values)
        issue_fields[field_ids["issue_source"]] = option_payload(field_ids["issue_source"], issue_source_value, allowed_values)
    if is_field_available(create_fields, field_ids.get("issue_category", "")):
        validate_single_value("Issue Category", field_ids["issue_category"], issue_category_value, allowed_values)
        issue_fields[field_ids["issue_category"]] = option_payload(field_ids["issue_category"], issue_category_value, allowed_values)
    if is_field_available(create_fields, field_ids.get("issue_nature", "")):
        validate_single_value("Issue Nature", field_ids["issue_nature"], issue_nature_value, allowed_values)
        issue_fields[field_ids["issue_nature"]] = option_payload(field_ids["issue_nature"], issue_nature_value, allowed_values)
    if is_field_available(create_fields, field_ids.get("affect_project", "")):
        validate_single_value("Affect Project", field_ids["affect_project"], affect_project_value, allowed_values)
        issue_fields[field_ids["affect_project"]] = option_payload(field_ids["affect_project"], affect_project_value, allowed_values)
    if is_field_available(create_fields, field_ids.get("case_no", "")):
        issue_fields[field_ids["case_no"]] = str(case_no_value)
    if is_field_available(create_fields, field_ids.get("exp_class", "")) and clean_cell_value(exp_class_value):
        exp_class_field_id = field_ids["exp_class"]
        if allowed_values.get(exp_class_field_id):
            validate_single_value("Exp Class", exp_class_field_id, exp_class_value, allowed_values)
            issue_fields[exp_class_field_id] = option_payload(exp_class_field_id, exp_class_value, allowed_values)
        else:
            issue_fields[exp_class_field_id] = str(exp_class_value)
    if is_field_available(create_fields, field_ids.get("caused_by", "")) and clean_cell_value(caused_by_value):
        issue_fields[field_ids["caused_by"]] = str(caused_by_value)

    if is_field_available(create_fields, field_ids.get("clients", "")) and clean_cell_value(clients_value):
        issue_fields[field_ids["clients"]] = option_payload(field_ids["clients"], clients_value, allowed_values, multi=True)
    if is_field_available(create_fields, field_ids.get("fix_way", "")) and clean_cell_value(fix_way_value):
        validate_single_value("Fix Way", field_ids["fix_way"], fix_way_value, allowed_values)
        issue_fields[field_ids["fix_way"]] = option_payload(field_ids["fix_way"], fix_way_value, allowed_values)
    if is_field_available(create_fields, field_ids.get("focus", "")) and clean_cell_value(focus_value):
        issue_fields[field_ids["focus"]] = option_payload(field_ids["focus"], focus_value, allowed_values)
    if is_field_available(create_fields, field_ids.get("importance", "")) and clean_cell_value(importance_value):
        validate_single_value("Importance", field_ids["importance"], importance_value, allowed_values)
        issue_fields[field_ids["importance"]] = option_payload(field_ids["importance"], importance_value, allowed_values)
    if is_field_available(create_fields, field_ids.get("opener", "")) and opener_value:
        issue_fields[field_ids["opener"]] = {"name": opener_value}
    if "security" in create_fields and clean_cell_value(security_value):
        issue_fields["security"] = {"name": str(security_value)}

    return issue_fields
