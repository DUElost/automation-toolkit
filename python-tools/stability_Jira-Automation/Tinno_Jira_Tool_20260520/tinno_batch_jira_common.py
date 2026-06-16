#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Tinno Jira 第二阶段公共逻辑
--------------------------

当前版本只落地已确认的 Tinno 认证、字段和备注能力：
- P12 证书 + 账号密码认证
- 基础建单字段组装
- PS 备注追加
- Create Meta / 用户搜索等后续迁移所需的最小适配层
"""

from __future__ import annotations

from difflib import SequenceMatcher
import json
import logging
import re
from pathlib import Path
from types import SimpleNamespace
from typing import Any, Dict, List, Optional, Tuple

from jira_p12_client import JiraP12Client

logger = logging.getLogger(__name__)

EXCEL_FIELD_CANDIDATES = {
    "project": ["Project", "project"],
    "issue_type": ["Issue Type", "issue_type", "issuetype"],
    "summary": ["Summary", "summary"],
    "description": ["Description", "description"],
    "priority": ["Priority", "priority"],
    "bug_severity": ["Bug Severity", "bug_severity", "Severity Level", "severity_level", "问题等级"],
    "test_case": ["Test Case", "TestCase", "test_case", "测试项", "测试专项", "专项"],
    "key_information": ["key_information", "Key Information", "CausedBy", "Cause By", "caused_by"],
    "assignee": ["Assignee", "assignee"],
    "reporter": ["Reporter", "reporter"],
    "components": ["Components", "components", "Module", "module"],
    "versions": ["Versions", "versions", "Version", "version"],
    "environment": ["Environment", "environment"],
    "affect_project": ["Affect Project", "affect_project", "AffectProject"],
    "exp_class": ["异常类型", "Exp Class", "exp_class", "Exception Class"],
    "previous_version_status": ["Previous Version Status", "previous_version_status"],
    "previous_version_text": ["Previous Version Text", "previous_version_text"],
    "ps": ["PS", "ps"],
}

OPEN_STATUS_NAMES = {"open", "开放", "reopened", "重新打开", "处理中"}
OPEN_TRANSITION_NAMES = {"open", "开放", "reopen", "重新打开", "开始处理", "开始进行"}
PREVIOUS_VERSION_STATUS_VALUES = {
    "No previous version",
    "Previous version exists",
    "Previous version does't exist",
}
RECURRENCE_PROBABILITY_VALUES = {"100%", ">50%", ">10%", ">1%"}
VERSION_PREFIXES = ("*version:*", "版本：", "版本:")


def clean_cell_value(value: Any) -> Any:
    if value is None:
        return ""
    try:
        import pandas as pd

        if pd.isna(value):
            return ""
    except Exception:
        pass
    if isinstance(value, str):
        return value.strip()
    return value


def find_first_value(row: Any, field_name: str, default: Any = None) -> Any:
    for candidate in EXCEL_FIELD_CANDIDATES.get(field_name, []):
        try:
            value = row.get(candidate, None)
        except Exception:
            value = None
        value = clean_cell_value(value)
        if value not in ("", None):
            return value
    return default


def normalize_comma_values(value: Any) -> List[str]:
    text = str(clean_cell_value(value) or "").replace(";", ",").replace("；", ",").replace("，", ",")
    return [item.strip() for item in text.split(",") if item.strip()]


def normalize_previous_version_fields(
    raw_status: Any,
    raw_text: Any,
    defaults: Dict[str, Any],
) -> Tuple[str, str]:
    default_status = str(defaults.get("default_previous_version_status", "") or "")
    default_text = str(defaults.get("default_previous_version_text", "") or "")
    status = str(clean_cell_value(raw_status) or "")
    text = str(clean_cell_value(raw_text) or "")

    if status in RECURRENCE_PROBABILITY_VALUES and not text:
        return default_status, status
    if text in PREVIOUS_VERSION_STATUS_VALUES and (not status or status == default_status):
        return text, default_text

    return status or default_status, text or default_text


class TinnoIssue:
    def __init__(self, payload: Dict[str, Any]) -> None:
        self.raw = payload
        self.key = payload.get("key", "")
        self.fields = self._to_namespace(payload.get("fields", {}) or {})

    def update(self, fields: Dict[str, Any]) -> None:
        raw_fields = self.raw.setdefault("fields", {})
        raw_fields.update(fields)
        self.fields = self._to_namespace(raw_fields)

    def _to_namespace(self, value: Any) -> Any:
        if isinstance(value, dict):
            return SimpleNamespace(**{key: self._to_namespace(item) for key, item in value.items()})
        if isinstance(value, list):
            return [self._to_namespace(item) for item in value]
        return value


class TinnoJiraClientAdapter:
    """把 JiraP12Client 包装成更接近 python-jira 的调用风格。"""

    def __init__(
        self,
        server: str,
        username: str,
        password: str,
        p12_file_path: str,
        p12_password: str,
        verify: bool = False,
        cookie_string: Optional[str] = None,
        cookie_jsessionid: Optional[str] = None,
        cookie_xsrf_token: Optional[str] = None,
    ) -> None:
        self.server = server.rstrip("/")
        self.username = username
        self._client = JiraP12Client(
            jira_url=server,
            p12_file_path=p12_file_path,
            p12_password=p12_password,
            jira_username=username,
            jira_password=password,
            verify=verify,
            cookie_string=cookie_string,
            cookie_jsessionid=cookie_jsessionid,
            cookie_xsrf_token=cookie_xsrf_token,
        )
        self._client.ensure_authenticated()

    def close(self) -> None:
        self._client.close()

    @property
    def auth_mode(self) -> str:
        return str(getattr(self._client, "auth_mode", "unknown") or "unknown")

    def current_user(self) -> str:
        return self.username

    def create_issue(self, fields: Dict[str, Any]) -> Dict[str, Any]:
        return self._client.create_issue(fields)

    def add_comment(self, issue_key: str, comment: str) -> Dict[str, Any]:
        return self._client.add_comment(issue_key, comment)

    def get_issue_comments(
        self,
        issue_key: str,
        start_at: int = 0,
        max_results: int = 100,
    ) -> Dict[str, Any]:
        return self._client.get_issue_comments(issue_key, start_at=start_at, max_results=max_results)

    def get_issue(self, issue_key: str) -> Dict[str, Any]:
        return self._client.get_issue(issue_key)

    def update_issue(self, issue_key: str, fields: Dict[str, Any]) -> Dict[str, Any]:
        return self._client.update_issue(issue_key, fields)

    def issue(self, issue_key: str) -> TinnoIssue:
        return TinnoIssue(self.get_issue(issue_key))

    def transitions(self, issue: Any, expand_fields: bool = False) -> List[Dict[str, Any]]:
        issue_key = issue if isinstance(issue, str) else getattr(issue, "key", "")
        payload = self._client.get_transitions(issue_key, expand_fields=expand_fields)
        return payload.get("transitions", []) if isinstance(payload, dict) else []

    def transition_issue(
        self,
        issue: Any,
        transition_id: str,
        comment: Optional[str] = None,
        fields: Optional[Dict[str, Any]] = None,
    ) -> Dict[str, Any]:
        issue_key = issue if isinstance(issue, str) else getattr(issue, "key", "")
        return self._client.transition_issue(issue_key, transition_id, comment=comment, fields=fields)

    def assign_issue(self, issue_key: str, assignee_name: str) -> Dict[str, Any]:
        return self.update_issue(issue_key, {"assignee": {"name": assignee_name}})

    def search_users(self, user: str, maxResults: int = 20) -> List[SimpleNamespace]:
        params = {"username": user, "maxResults": maxResults}
        try:
            payload = self._client._make_request("GET", "/rest/api/2/user/search", params=params)
        except Exception:
            payload = []
        if not isinstance(payload, list):
            return []
        return [SimpleNamespace(**item) for item in payload if isinstance(item, dict)]

    def project(self, project_key: str) -> SimpleNamespace:
        payload = self._client._make_request("GET", f"/rest/api/2/project/{project_key}")
        if isinstance(payload, dict):
            return SimpleNamespace(**payload)
        return SimpleNamespace(key=project_key, name=project_key)

    def project_versions(self, project_key: str) -> List[SimpleNamespace]:
        payload = self._client.get_project_versions(project_key)
        if not isinstance(payload, list):
            return []
        return [SimpleNamespace(**item) for item in payload if isinstance(item, dict)]

    def projects(self) -> List[SimpleNamespace]:
        try:
            payload = self._client._make_request("GET", "/rest/api/2/project")
        except Exception:
            payload = []
        if not isinstance(payload, list):
            return []
        return [SimpleNamespace(**item) for item in payload if isinstance(item, dict)]

    def createmeta(self, projectKeys: str, expand: str = "projects.issuetypes.fields") -> Dict[str, Any]:
        params = {"projectKeys": projectKeys, "expand": expand}
        return self._client._make_request("GET", "/rest/api/2/issue/createmeta", params=params)

    def search_issues(
        self,
        jql: str,
        maxResults: int = 50,  # noqa: N803
        fields: str = "*all",
    ) -> List[TinnoIssue]:
        payload = self._client.search(jql, max_results=maxResults, fields=fields)
        issues = payload.get("issues", []) if isinstance(payload, dict) else []
        return [TinnoIssue(item) for item in issues if isinstance(item, dict)]


def connect_to_jira(
    server: str,
    username: str,
    password: str,
    p12_file_path: str,
    p12_password: str,
    verify: bool = False,
    cookie_string: Optional[str] = None,
    cookie_jsessionid: Optional[str] = None,
    cookie_xsrf_token: Optional[str] = None,
) -> TinnoJiraClientAdapter:
    return TinnoJiraClientAdapter(
        server=server,
        username=username,
        password=password,
        p12_file_path=p12_file_path,
        p12_password=p12_password,
        verify=verify,
        cookie_string=cookie_string,
        cookie_jsessionid=cookie_jsessionid,
        cookie_xsrf_token=cookie_xsrf_token,
    )


def fetch_issue_snapshot_fields(
    jira_client: TinnoJiraClientAdapter,
    issue_key: str,
    field_mapping: Optional[Dict[str, Any]] = None,
) -> Dict[str, Any]:
    payload = jira_client.get_issue(issue_key)
    fields = payload.get("fields", {}) if isinstance(payload, dict) else {}

    def _pick(name: str) -> Any:
        candidates = field_mapping.get(name, []) if field_mapping else []
        if isinstance(candidates, str):
            candidates = [candidates]
        for candidate in candidates:
            if candidate in fields:
                return fields.get(candidate)
        return fields.get(name)

    def _normalize_name(value: Any) -> str:
        if isinstance(value, dict):
            return str(value.get("name") or value.get("value") or "").strip()
        if isinstance(value, list):
            parts = []
            for item in value:
                if isinstance(item, dict):
                    parts.append(str(item.get("name") or item.get("value") or "").strip())
                else:
                    parts.append(str(item).strip())
            return ", ".join([item for item in parts if item])
        return str(value or "").strip()

    def _extract_exp_class(environment_text: Any, summary_text: Any) -> str:
        environment_value = str(environment_text or "")
        for line in environment_value.splitlines():
            if line.lower().startswith("*expclass:*"):
                return line.replace("*ExpClass:*", "", 1).replace("*expclass:*", "", 1).strip()

        normalized_tokens = [item.strip() for item in re.findall(r"\[([^\]]+)\]", str(summary_text or "")) if item.strip()]
        version_index = -1
        for index, token in enumerate(normalized_tokens):
            if re.search(r"\d{6}V\d+", token, flags=re.IGNORECASE):
                version_index = index
                break
        if version_index >= 0 and version_index + 2 < len(normalized_tokens):
            return normalized_tokens[version_index + 2]
        return ""

    def _summary_tokens(summary_text: Any) -> List[str]:
        return [item.strip() for item in re.findall(r"\[([^\]]+)\]", str(summary_text or "")) if item.strip()]

    def _looks_like_build_version(token: Any) -> bool:
        text = str(token or "").strip()
        if not text:
            return False
        patterns = (
            r"\d{6}V\d+",
            r"user(?:debug)?",
            r"Daily_user",
            r"Release_user",
            r"_sign\b",
            r"_FLASH\b",
            r"\bFTM\b",
        )
        return any(re.search(pattern, text, flags=re.IGNORECASE) for pattern in patterns)

    def _extract_build_version_from_text(text: Any) -> str:
        for line in str(text or "").splitlines():
            normalized = str(line or "").strip()
            normalized_lower = normalized.lower()
            if normalized_lower.startswith(VERSION_PREFIXES):
                return re.sub(r"^(?:\*version:\*|版本：|版本:)\s*", "", normalized, flags=re.IGNORECASE).strip()
        match = re.search(r"版本[：:]\s*([^\s,，；;]+)", str(text or ""), flags=re.IGNORECASE)
        if match:
            return str(match.group(1) or "").strip()
        return ""

    def _extract_build_version(summary_text: Any, environment_text: Any, description_text: Any) -> str:
        for text in (environment_text, description_text):
            candidate = _extract_build_version_from_text(text)
            if candidate:
                return candidate

        tokens = _summary_tokens(summary_text)
        for token in tokens:
            if _looks_like_build_version(token):
                return token
        return ""

    project_value = fields.get("project") if isinstance(fields.get("project"), dict) else {}
    normalized_summary = _normalize_name(fields.get("summary"))
    normalized_environment = _normalize_name(_pick("environment"))
    normalized_description = _normalize_name(fields.get("description"))

    return {
        "jira_key": payload.get("key", issue_key),
        "summary": normalized_summary,
        "status": _normalize_name((fields.get("status") or {}).get("name") if isinstance(fields.get("status"), dict) else fields.get("status")),
        "resolution": _normalize_name((fields.get("resolution") or {}).get("name") if isinstance(fields.get("resolution"), dict) else fields.get("resolution")),
        "fix_version": _normalize_name(fields.get("fixVersions")),
        "build_version": _extract_build_version(normalized_summary, normalized_environment, normalized_description),
        "affect_project": _normalize_name(_pick("affect_project")) or _normalize_name(project_value.get("key") if isinstance(project_value, dict) else project_value),
        "environment": normalized_environment,
        "exp_class": _normalize_name(_pick("exp_class")) or _extract_exp_class(normalized_environment, normalized_summary),
        "caused_by": _normalize_name(_pick("key_information") or _pick("caused_by")),
        "raw_payload": json.dumps(payload, ensure_ascii=False),
    }


def resolve_project_key(
    jira_client: TinnoJiraClientAdapter,
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
        return text


def get_create_meta_fields(
    jira_client: TinnoJiraClientAdapter,
    project_key: str,
    issue_type_name: str,
) -> Dict[str, Any]:
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
    jira_client: TinnoJiraClientAdapter,
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
    for candidate in [text, text.split("@", 1)[0].strip(), text.split("(", 1)[0].strip()]:
        if not candidate:
            continue
        users = jira_client.search_users(candidate, maxResults=20)
        for user in users:
            user_name = getattr(user, "name", None)
            display_name = getattr(user, "displayName", "")
            email_address = getattr(user, "emailAddress", "")
            if not user_name:
                continue
            if candidate == user_name or candidate == email_address or candidate in display_name:
                cache[text] = user_name
                return user_name
    cache[text] = fallback or text
    return cache[text]


def transition_issue_to_open(jira_client: TinnoJiraClientAdapter, issue_key: str) -> Tuple[bool, str]:
    issue = jira_client.issue(issue_key)
    current_status = str(getattr(getattr(issue.fields, "status", None), "name", "") or "").strip()
    if current_status.lower() in OPEN_STATUS_NAMES:
        return True, f"当前状态已是 {current_status}"
    transitions = jira_client.transitions(issue)
    for transition in transitions:
        transition_name = str(transition.get("name") or "").strip()
        target_status_name = str(((transition.get("to") or {}).get("name")) or "").strip()
        if target_status_name.lower() in OPEN_STATUS_NAMES or transition_name.lower() in OPEN_TRANSITION_NAMES:
            jira_client.transition_issue(issue, str(transition.get("id") or "").strip())
            return True, f"{current_status} -> {transition_name or target_status_name}"
    return False, f"未找到从 {current_status} 转到 Open/开放 的可用流转"


def transition_issue_to_closed(
    jira_client: TinnoJiraClientAdapter,
    issue_key: str,
    closed_statuses: List[str],
    *,
    resolution_name: str = "完成",
    fix_version: Optional[str] = None,
) -> Tuple[bool, str]:
    return _transition_issue_to_target_status(
        jira_client,
        issue_key,
        target_statuses=closed_statuses,
        transition_keywords=("close", "closed", "关闭", "关单"),
        resolution_name=resolution_name,
        fix_version=fix_version,
    )


def transition_issue_to_resolved(
    jira_client: TinnoJiraClientAdapter,
    issue_key: str,
    resolved_statuses: List[str],
    *,
    resolution_name: str = "完成",
    fix_version: Optional[str] = None,
) -> Tuple[bool, str]:
    return _transition_issue_to_target_status(
        jira_client,
        issue_key,
        target_statuses=resolved_statuses,
        transition_keywords=("resolve", "resolved", "解决", "已解决"),
        resolution_name=resolution_name,
        fix_version=fix_version,
    )


def get_project_version_names(jira_client: TinnoJiraClientAdapter, project_key: str) -> List[str]:
    version_names: List[str] = []
    for item in jira_client.project_versions(project_key):
        name = str(getattr(item, "name", "") or "").strip()
        if name:
            version_names.append(name)
    return version_names


def resolve_allowed_version_names(
    candidate_versions: List[str],
    allowed_versions: List[str],
) -> Tuple[List[str], List[str]]:
    normalized_lookup = {str(item or "").strip(): str(item or "").strip() for item in allowed_versions if str(item or "").strip()}
    matched: List[str] = []
    missing: List[str] = []
    for candidate in candidate_versions:
        normalized_candidate = str(candidate or "").strip()
        if not normalized_candidate:
            continue
        resolved = normalized_lookup.get(normalized_candidate)
        if resolved:
            matched.append(resolved)
        else:
            missing.append(normalized_candidate)
    return matched, missing


def _normalize_allowed_text(value: Any) -> str:
    text = str(value or "").strip().lower()
    return re.sub(r"[\s/_-]+", "", text)


def _extract_allowed_value_names(field_meta: Dict[str, Any]) -> List[str]:
    allowed_names: List[str] = []
    for item in field_meta.get("allowedValues", []) or []:
        if not isinstance(item, dict):
            continue
        name = str(item.get("name") or item.get("value") or item.get("id") or "").strip()
        if name:
            allowed_names.append(name)
    return allowed_names


def _resolve_allowed_name(candidate: str, allowed_names: List[str]) -> str:
    text = str(candidate or "").strip()
    if not text or not allowed_names:
        return text

    exact_lookup = {item: item for item in allowed_names}
    if text in exact_lookup:
        return exact_lookup[text]

    lower_lookup: Dict[str, str] = {}
    normalized_lookup: Dict[str, str] = {}
    for item in allowed_names:
        lower_key = item.lower()
        normalized_key = _normalize_allowed_text(item)
        lower_lookup.setdefault(lower_key, item)
        normalized_lookup.setdefault(normalized_key, item)

    lower_match = lower_lookup.get(text.lower())
    if lower_match:
        return lower_match

    normalized_match = normalized_lookup.get(_normalize_allowed_text(text))
    if normalized_match:
        return normalized_match

    scored_matches: List[Tuple[float, str]] = []
    for item in allowed_names:
        ratio = SequenceMatcher(None, _normalize_allowed_text(text), _normalize_allowed_text(item)).ratio()
        scored_matches.append((ratio, item))
    scored_matches.sort(key=lambda pair: pair[0], reverse=True)
    if not scored_matches:
        return text

    best_ratio, best_name = scored_matches[0]
    second_ratio = scored_matches[1][0] if len(scored_matches) > 1 else 0.0
    if best_ratio >= 0.90 and (best_ratio - second_ratio) >= 0.03:
        return best_name
    return text


def resolve_allowed_component_names(component_names: List[str], field_meta: Dict[str, Any]) -> Tuple[List[str], List[str]]:
    allowed_names = _extract_allowed_value_names(field_meta)
    if not allowed_names:
        return component_names, []

    matched: List[str] = []
    missing: List[str] = []
    exact_allowed = set(allowed_names)
    for item in component_names:
        candidate = str(item or "").strip()
        if not candidate:
            continue
        resolved = _resolve_allowed_name(candidate, allowed_names)
        if resolved in exact_allowed:
            matched.append(resolved)
            continue
        missing.append(candidate)
    return matched, missing


def _transition_issue_to_target_status(
    jira_client: TinnoJiraClientAdapter,
    issue_key: str,
    *,
    target_statuses: List[str],
    transition_keywords: Tuple[str, ...],
    resolution_name: str,
    fix_version: Optional[str],
) -> Tuple[bool, str]:
    issue = jira_client.issue(issue_key)
    current_status = str(getattr(getattr(issue.fields, "status", None), "name", "") or "").strip()
    normalized_target_statuses = {str(item).strip().lower() for item in target_statuses if str(item).strip()}
    if current_status.lower() in normalized_target_statuses:
        return True, f"当前状态已是 {current_status}"

    transitions = jira_client.transitions(issue, expand_fields=True)
    selected_transition_id = ""
    selected_transition_name = ""
    selected_transition_fields: Dict[str, Any] = {}
    for transition in transitions:
        transition_name = str(transition.get("name") or "").strip()
        target_status_name = str(((transition.get("to") or {}).get("name")) or "").strip()
        transition_name_lower = transition_name.lower()
        if target_status_name.lower() in normalized_target_statuses:
            selected_transition_id = str(transition.get("id") or "").strip()
            selected_transition_name = transition_name or target_status_name
            selected_transition_fields = transition.get("fields", {}) or {}
            break
        if any(keyword in transition_name_lower for keyword in transition_keywords) or any(
            keyword in transition_name for keyword in transition_keywords
        ):
            selected_transition_id = str(transition.get("id") or "").strip()
            selected_transition_name = transition_name or target_status_name
            selected_transition_fields = transition.get("fields", {}) or {}
            break

    if not selected_transition_id:
        return False, f"未找到从 {current_status} 转到目标状态的可用流转"

    fields, error_message = build_transition_fields(
        selected_transition_fields,
        resolution_name=resolution_name,
        fix_version=fix_version,
    )
    if error_message:
        return False, error_message
    jira_client.transition_issue(issue, selected_transition_id, fields=fields or None)
    return True, f"{current_status} -> {selected_transition_name}"


def build_transition_fields(
    transition_fields: Dict[str, Any],
    *,
    resolution_name: str = "完成",
    fix_version: Optional[str] = None,
) -> Tuple[Dict[str, Any], str]:
    fields: Dict[str, Any] = {}
    resolution_meta = (transition_fields or {}).get("resolution") or {}
    resolution_payload, resolution_error = _resolve_allowed_single_value(resolution_meta, resolution_name)
    if resolution_error:
        return {}, resolution_error
    if resolution_payload:
        fields["resolution"] = resolution_payload

    fix_version_text = str(fix_version or "").strip()
    if fix_version_text:
        fix_meta = (transition_fields or {}).get("fixVersions") or {}
        fix_payload, fix_error = _resolve_allowed_multi_values(fix_meta, normalize_comma_values(fix_version_text))
        if fix_error:
            return {}, fix_error
        if fix_payload:
            fields["fixVersions"] = fix_payload

    return fields, ""


def _resolve_allowed_single_value(field_meta: Dict[str, Any], expected_name: str) -> Tuple[Dict[str, Any], str]:
    expected_text = str(expected_name or "").strip()
    if not expected_text:
        if field_meta.get("required"):
            return {}, f"流转字段 {field_meta.get('name') or 'resolution'} 缺少必填值"
        return {}, ""

    allowed_values = field_meta.get("allowedValues", []) or []
    if not allowed_values:
        return {"name": expected_text}, ""

    for item in allowed_values:
        if not isinstance(item, dict):
            continue
        item_name = str(item.get("name") or item.get("value") or item.get("id") or "").strip()
        if item_name != expected_text:
            continue
        if item.get("id") is not None:
            return {"id": str(item.get("id"))}, ""
        if item.get("name") is not None:
            return {"name": str(item.get("name"))}, ""
        if item.get("value") is not None:
            return {"name": str(item.get("value"))}, ""
    return {}, f"流转字段 {field_meta.get('name') or 'resolution'} 不支持值: {expected_text}"


def _resolve_allowed_multi_values(field_meta: Dict[str, Any], expected_names: List[str]) -> Tuple[List[Dict[str, Any]], str]:
    cleaned_expected_names = [str(item or "").strip() for item in expected_names if str(item or "").strip()]
    if not cleaned_expected_names:
        return [], ""

    allowed_values = field_meta.get("allowedValues", []) or []
    if not allowed_values:
        return [{"name": item} for item in cleaned_expected_names], ""

    normalized_allowed: Dict[str, Dict[str, Any]] = {}
    for item in allowed_values:
        if not isinstance(item, dict):
            continue
        key = str(item.get("name") or item.get("value") or item.get("id") or "").strip()
        if key:
            normalized_allowed[key] = item

    payload: List[Dict[str, Any]] = []
    missing: List[str] = []
    for expected_name in cleaned_expected_names:
        item = normalized_allowed.get(expected_name)
        if not item:
            missing.append(expected_name)
            continue
        if item.get("id") is not None:
            payload.append({"id": str(item.get("id"))})
        else:
            payload.append({"name": str(item.get("name") or item.get("value") or expected_name)})

    if missing:
        return [], f"流转字段 {field_meta.get('name') or 'fixVersions'} 不支持值: {', '.join(missing)}"
    return payload, ""


def assign_issue_to_user(
    jira_client: TinnoJiraClientAdapter,
    issue_key: str,
    assignee_name: Optional[str],
) -> Tuple[bool, str]:
    assignee_text = str(assignee_name or "").strip()
    if not assignee_text:
        return False, "未提供目标经办人"
    try:
        jira_client.assign_issue(issue_key, assignee_text)
        return True, assignee_text
    except Exception as exc:
        return False, str(exc)


def update_issue_fields(jira_client: TinnoJiraClientAdapter, issue_key: str, fields: Dict[str, Any]) -> None:
    jira_client.update_issue(issue_key, fields)


def normalize_comment_body(comment: str) -> str:
    return re.sub(r"\s+", " ", str(comment or "").strip())


def issue_has_comment(jira_client: TinnoJiraClientAdapter, issue_key: str, comment: str) -> bool:
    expected = normalize_comment_body(comment)
    if not expected:
        return False
    payload = jira_client.get_issue_comments(issue_key)
    comments = payload.get("comments", []) if isinstance(payload, dict) else []
    for item in comments:
        body = item.get("body") if isinstance(item, dict) else ""
        if normalize_comment_body(body) == expected:
            return True
    return False


def add_issue_comment(jira_client: TinnoJiraClientAdapter, issue_key: str, comment: str) -> None:
    if comment:
        jira_client.add_comment(issue_key, comment)


def build_issue_fields(
    jira_client: TinnoJiraClientAdapter,
    row: Any,
    defaults: Dict[str, Any],
    user_cache: Optional[Dict[str, str]] = None,
    project_cache: Optional[Dict[str, str]] = None,
    create_meta_cache: Optional[Dict[Tuple[str, str], Dict[str, Any]]] = None,
    create_assignee_override: Optional[str] = None,
    create_reporter_override: Optional[str] = None,
) -> Dict[str, Any]:
    user_cache = user_cache if user_cache is not None else {}
    project_cache = project_cache if project_cache is not None else {}
    create_meta_cache = create_meta_cache if create_meta_cache is not None else {}
    field_ids = defaults.get("field_ids", {})
    labels = defaults.get("labels", ["MonkeyAEE"])

    project_key = resolve_project_key(
        jira_client,
        str(find_first_value(row, "project", defaults.get("project_key", "VCAME"))),
        project_cache,
    )
    issue_type_name = str(find_first_value(row, "issue_type", defaults.get("issue_type", "Bug")))
    summary = str(find_first_value(row, "summary", ""))
    description = str(find_first_value(row, "description", ""))
    priority = str(find_first_value(row, "priority", defaults.get("default_priority", "Medium")))
    bug_severity = str(find_first_value(row, "bug_severity", defaults.get("default_bug_severity", "B")))
    key_information = str(find_first_value(row, "key_information", ""))
    environment = str(find_first_value(row, "environment", ""))
    components = normalize_comma_values(find_first_value(row, "components", defaults.get("default_component", "AUTOTEST")))
    affect_project = str(find_first_value(row, "affect_project", defaults.get("default_affect_project", "")))
    previous_version_status, previous_version_text = normalize_previous_version_fields(
        find_first_value(row, "previous_version_status", ""),
        find_first_value(row, "previous_version_text", ""),
        defaults,
    )
    assignee_raw = create_assignee_override or find_first_value(row, "assignee", defaults.get("default_assignee"))

    assignee = resolve_user_name(jira_client, assignee_raw, user_cache, fallback=defaults.get("default_assignee"))
    meta_key = (project_key, issue_type_name)
    create_fields = create_meta_cache.get(meta_key)
    if create_fields is None:
        if hasattr(jira_client, "createmeta"):
            create_fields = get_create_meta_fields(jira_client, project_key, issue_type_name)
        else:
            create_fields = {}
        create_meta_cache[meta_key] = create_fields
    component_field_id = build_field_name_lookup(create_fields).get("Component/s", "components")
    component_field_meta = create_fields.get(component_field_id, {})
    components, missing_components = resolve_allowed_component_names(components, component_field_meta)
    if missing_components:
        raise ValueError(
            "Components 不支持值: "
            + ", ".join(missing_components)
            + "；当前候选: "
            + ", ".join(_extract_allowed_value_names(component_field_meta)[:20])
        )

    fields: Dict[str, Any] = {
        "project": {"key": project_key},
        "issuetype": {"name": issue_type_name},
        "summary": summary,
        "description": description,
        "priority": {"name": priority},
        "labels": labels,
    }
    if assignee:
        fields["assignee"] = {"name": assignee}
    if components:
        fields["components"] = [{"name": item} for item in components]
    if environment:
        fields["environment"] = environment
    if affect_project and field_ids.get("affect_project"):
        fields[field_ids["affect_project"]] = {"value": affect_project}
    if bug_severity and field_ids.get("bug_severity"):
        fields[field_ids["bug_severity"]] = {"value": bug_severity}
    if key_information and field_ids.get("key_information"):
        fields[field_ids["key_information"]] = key_information
    if previous_version_status and field_ids.get("previous_version_status"):
        fields[field_ids["previous_version_status"]] = {"value": previous_version_status}
    if previous_version_text and field_ids.get("previous_version_text"):
        fields[field_ids["previous_version_text"]] = {"value": previous_version_text}
    return fields
