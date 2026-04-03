from __future__ import annotations

import json
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any, Dict, List, Union


EXPECTED_REQUIRED_EXACT_FIELDS = ["affect_project", "environment", "exp_class"]
TOP_LEVEL_KEYS = {"jira_export", "matching", "status_rules", "regression", "output"}
SECTION_KEYS = {
    "jira_export": {"enabled", "jql", "max_results", "fields"},
    "matching": {"required_exact_fields", "cause_similarity_threshold"},
    "status_rules": {
        "open_like_statuses",
        "resolved_statuses",
        "resolved_fixed_resolutions",
        "wont_fix_resolutions",
        "closed_statuses",
    },
    "regression": {"enabled", "required_regression_pass_versions"},
    "output": {"sqlite_path", "excel_summary_dir"},
}


@dataclass
class JiraExportRules:
    enabled: bool
    jql: str
    max_results: int
    fields: List[str] = field(default_factory=list)


@dataclass
class MatchingRules:
    required_exact_fields: List[str] = field(default_factory=list)
    cause_similarity_threshold: float = 0.9


@dataclass
class StatusRules:
    open_like_statuses: List[str] = field(default_factory=list)
    resolved_statuses: List[str] = field(default_factory=list)
    resolved_fixed_resolutions: List[str] = field(default_factory=list)
    wont_fix_resolutions: List[str] = field(default_factory=list)
    closed_statuses: List[str] = field(default_factory=list)


@dataclass
class RegressionConfig:
    enabled: bool = True
    required_regression_pass_versions: int = 2


@dataclass
class OutputConfig:
    sqlite_path: str = "result/transsion_regression_cache.db"
    excel_summary_dir: str = "result"


@dataclass
class RegressionRules:
    jira_export: JiraExportRules
    matching: MatchingRules
    status_rules: StatusRules
    regression: RegressionConfig
    output: OutputConfig


def _load_json(path: Union[str, Path]) -> Dict[str, Any]:
    config_path = Path(path)
    with config_path.open("r", encoding="utf-8") as handle:
        data = json.load(handle)
    if not isinstance(data, dict):
        raise ValueError("回归配置文件必须是 JSON 对象")
    return data


def _coerce_section(data: Dict[str, Any], key: str) -> Dict[str, Any]:
    if key not in data:
        return {}
    value = data[key]
    if not isinstance(value, dict):
        raise ValueError(f"{key} 必须是对象")
    allowed_keys = SECTION_KEYS[key]
    unknown_keys = sorted(set(value) - allowed_keys)
    if unknown_keys:
        raise ValueError(f"{key} 包含未知键: {', '.join(unknown_keys)}")
    return value


def _coerce_bool(value: Any, field_name: str, default: bool = False) -> bool:
    if value is None:
        return default
    if isinstance(value, bool):
        return value
    raise ValueError(f"{field_name} 必须是布尔值")


def _coerce_int(value: Any, field_name: str, default: int) -> int:
    if value is None:
        return default
    try:
        return int(value)
    except (TypeError, ValueError):
        raise ValueError(f"{field_name} 必须是整数")


def _coerce_float(value: Any, field_name: str, default: float) -> float:
    if value is None:
        return default
    try:
        return float(value)
    except (TypeError, ValueError):
        raise ValueError(f"{field_name} 必须是数字")


def _coerce_str(value: Any, field_name: str, default: str = "") -> str:
    if value is None:
        return default
    text = str(value).strip()
    if not text:
        raise ValueError(f"{field_name} 不能为空")
    return text


def _coerce_str_list(value: Any, field_name: str, *, allow_empty: bool = False) -> List[str]:
    if not isinstance(value, list):
        raise ValueError(f"{field_name} 必须是列表")
    items = [str(item).strip() for item in value if str(item).strip()]
    if not items and not allow_empty:
        raise ValueError(f"{field_name} 不能为空")
    return items


def _validate_required_exact_fields(value: List[str]) -> List[str]:
    if value != EXPECTED_REQUIRED_EXACT_FIELDS:
        raise ValueError(
            "matching.required_exact_fields 必须严格等于 "
            "['affect_project', 'environment', 'exp_class']"
        )
    return value


def load_regression_rules(path: Union[str, Path]) -> RegressionRules:
    data = _load_json(path)
    unknown_top_level_keys = sorted(set(data) - TOP_LEVEL_KEYS)
    if unknown_top_level_keys:
        raise ValueError(f"顶层包含未知键: {', '.join(unknown_top_level_keys)}")

    matching_data = _coerce_section(data, "matching")
    matching_required_exact_fields = _coerce_str_list(
        matching_data.get("required_exact_fields"),
        "matching.required_exact_fields",
    )
    matching_required_exact_fields = _validate_required_exact_fields(matching_required_exact_fields)

    jira_export_data = _coerce_section(data, "jira_export")
    status_rules_data = _coerce_section(data, "status_rules")
    regression_data = _coerce_section(data, "regression")
    output_data = _coerce_section(data, "output")

    jira_export = JiraExportRules(
        enabled=_coerce_bool(jira_export_data.get("enabled"), "jira_export.enabled", False),
        jql=_coerce_str(jira_export_data.get("jql"), "jira_export.jql", ""),
        max_results=_coerce_int(
            jira_export_data.get("max_results"),
            "jira_export.max_results",
            500,
        ),
        fields=_coerce_str_list(
            jira_export_data.get("fields"),
            "jira_export.fields",
            allow_empty=True,
        ),
    )

    matching = MatchingRules(
        required_exact_fields=matching_required_exact_fields,
        cause_similarity_threshold=_coerce_float(
            matching_data.get("cause_similarity_threshold"),
            "matching.cause_similarity_threshold",
            0.9,
        ),
    )

    status_rules = StatusRules(
        open_like_statuses=_coerce_str_list(
            status_rules_data.get("open_like_statuses"),
            "status_rules.open_like_statuses",
        ),
        resolved_statuses=_coerce_str_list(
            status_rules_data.get("resolved_statuses"),
            "status_rules.resolved_statuses",
        ),
        resolved_fixed_resolutions=_coerce_str_list(
            status_rules_data.get("resolved_fixed_resolutions"),
            "status_rules.resolved_fixed_resolutions",
        ),
        wont_fix_resolutions=_coerce_str_list(
            status_rules_data.get("wont_fix_resolutions"),
            "status_rules.wont_fix_resolutions",
        ),
        closed_statuses=_coerce_str_list(
            status_rules_data.get("closed_statuses"),
            "status_rules.closed_statuses",
        ),
    )

    regression = RegressionConfig(
        enabled=_coerce_bool(
            regression_data.get("enabled"),
            "regression.enabled",
            True,
        ),
        required_regression_pass_versions=_coerce_int(
            regression_data.get("required_regression_pass_versions"),
            "regression.required_regression_pass_versions",
            2,
        )
    )

    output = OutputConfig(
        sqlite_path=_coerce_str(
            output_data.get("sqlite_path"),
            "output.sqlite_path",
            "result/transsion_regression_cache.db",
        ),
        excel_summary_dir=_coerce_str(
            output_data.get("excel_summary_dir"),
            "output.excel_summary_dir",
            "result",
        ),
    )

    return RegressionRules(
        jira_export=jira_export,
        matching=matching,
        status_rules=status_rules,
        regression=regression,
        output=output,
    )
