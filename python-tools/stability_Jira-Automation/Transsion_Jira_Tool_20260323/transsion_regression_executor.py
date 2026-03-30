from __future__ import annotations

from dataclasses import dataclass
import json
import re
from typing import Any, Mapping


OPEN_LIKE_STATUSES = {"Open", "开放", "Reopened", "重新打开", "处理中"}
WONT_FIX_RESOLUTIONS = {"问题不修改", "非问题", "Won't Fix", "不解决"}
RESOLVED_STATUS = "已解决"
RESOLVED_FIXED_RESOLUTION = "已修复"
CLOSED_STATUSES = {"Closed", "已关闭", "已关单"}


@dataclass(frozen=True)
class ActionDecision:
    action: str
    update_jira: bool
    manual_review: bool
    comment_required: bool
    recreate_issue: bool = False


@dataclass(frozen=True)
class RegressionPassDecision:
    action: str
    record_pass: bool
    close_issue: bool
    new_pass_count: int
    comment_required: bool
    reason: str = ""


def _normalize_text(value: Any) -> str:
    return str(value or "").strip()


def _split_versions(value: Any) -> list[str]:
    text = _normalize_text(value)
    if not text:
        return []
    return [part.strip() for part in re.split(r"[,;，；]", text) if part.strip()]


def _version_key(version: Any) -> tuple[str, ...]:
    text = _normalize_text(version)
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


def _compare_versions(current_version: Any, fix_version: Any) -> int:
    current_key = _version_key(current_version)
    fix_key = _version_key(fix_version)
    if current_key < fix_key:
        return -1
    if current_key > fix_key:
        return 1
    return 0


def _is_open_like(status: str) -> bool:
    return status in OPEN_LIKE_STATUSES


def _is_wont_fix(resolution: str) -> bool:
    return resolution in WONT_FIX_RESOLUTIONS


def _is_closed(status: str) -> bool:
    return status in CLOSED_STATUSES


def _select_fix_version_for_comparison(fix_version: Any) -> str:
    versions = _split_versions(fix_version)
    if not versions:
        return ""
    return max(versions, key=_version_key)


def _normalize_verified_versions(value: Any) -> list[str]:
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
                return [_normalize_text(item) for item in parsed if _normalize_text(item)]
        return [_normalize_text(item) for item in re.split(r"[,;，；]", text) if _normalize_text(item)]
    if isinstance(value, (list, tuple, set)):
        return [_normalize_text(item) for item in value if _normalize_text(item)]
    normalized = _normalize_text(value)
    return [normalized] if normalized else []


def decide_action(current_row: Mapping[str, Any], history: Mapping[str, Any], current_version: Any) -> ActionDecision:
    status = _normalize_text(history.get("status"))
    resolution = _normalize_text(history.get("resolution"))
    fix_version = _normalize_text(history.get("fix_version"))

    if _is_open_like(status):
        return ActionDecision(
            action="OPEN_LIKE_UPDATE",
            update_jira=True,
            manual_review=False,
            comment_required=True,
        )

    if _is_wont_fix(resolution):
        return ActionDecision(
            action="WONT_FIX_KEEP",
            update_jira=False,
            manual_review=False,
            comment_required=True,
        )

    if _is_closed(status):
        return ActionDecision(
            action="CLOSED_RECREATE",
            update_jira=False,
            manual_review=False,
            comment_required=False,
            recreate_issue=True,
        )

    if status == RESOLVED_STATUS and resolution == RESOLVED_FIXED_RESOLUTION:
        if not fix_version:
            return ActionDecision(
                action="MANUAL_REVIEW",
                update_jira=False,
                manual_review=True,
                comment_required=False,
            )
        comparison_fix_version = _select_fix_version_for_comparison(fix_version)
        current_version_text = _normalize_text(current_version)
        if not current_version_text or not comparison_fix_version:
            return ActionDecision(
                action="MANUAL_REVIEW",
                update_jira=False,
                manual_review=True,
                comment_required=False,
            )
        if _compare_versions(current_version_text, comparison_fix_version) >= 0:
            return ActionDecision(
                action="MANUAL_REVIEW",
                update_jira=False,
                manual_review=True,
                comment_required=False,
            )
        return ActionDecision(
            action="RESOLVED_FIXED_WAIT_NEW_VERSION",
            update_jira=False,
            manual_review=False,
            comment_required=True,
        )

    return ActionDecision(
        action="CREATE_NEW",
        update_jira=False,
        manual_review=False,
        comment_required=False,
        recreate_issue=True,
    )


def evaluate_regression_pass(
    pass_count: Any,
    required_versions: Any,
    current_version: Any,
    fix_version: Any,
    already_verified: Any,
) -> RegressionPassDecision:
    current_version_text = _normalize_text(current_version)
    comparison_fix_version = _select_fix_version_for_comparison(fix_version)
    normalized_verified_versions = _normalize_verified_versions(already_verified)
    normalized_pass_count = int(pass_count or 0)
    normalized_required_versions = max(int(required_versions or 0), 1)

    if not current_version_text:
        return RegressionPassDecision(
            action="REGRESSION_PASS_SKIP",
            record_pass=False,
            close_issue=False,
            new_pass_count=normalized_pass_count,
            comment_required=False,
            reason="CURRENT_VERSION_EMPTY",
        )

    if not comparison_fix_version:
        return RegressionPassDecision(
            action="REGRESSION_PASS_SKIP",
            record_pass=False,
            close_issue=False,
            new_pass_count=normalized_pass_count,
            comment_required=False,
            reason="FIX_VERSION_EMPTY",
        )

    if _compare_versions(current_version_text, comparison_fix_version) < 0:
        return RegressionPassDecision(
            action="REGRESSION_PASS_SKIP",
            record_pass=False,
            close_issue=False,
            new_pass_count=normalized_pass_count,
            comment_required=False,
            reason="CURRENT_VERSION_BEFORE_FIX_VERSION",
        )

    if current_version_text in normalized_verified_versions:
        return RegressionPassDecision(
            action="REGRESSION_PASS_SKIP",
            record_pass=False,
            close_issue=False,
            new_pass_count=normalized_pass_count,
            comment_required=False,
            reason="CURRENT_VERSION_ALREADY_VERIFIED",
        )

    new_pass_count = normalized_pass_count + 1
    if new_pass_count >= normalized_required_versions:
        return RegressionPassDecision(
            action="REGRESSION_PASS_CLOSE",
            record_pass=True,
            close_issue=True,
            new_pass_count=new_pass_count,
            comment_required=True,
        )

    return RegressionPassDecision(
        action="REGRESSION_PASS_PROGRESS",
        record_pass=True,
        close_issue=False,
        new_pass_count=new_pass_count,
        comment_required=True,
    )
