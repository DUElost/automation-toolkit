from __future__ import annotations

from dataclasses import dataclass
import json
import re
from typing import Any, Mapping


OPEN_LIKE_STATUSES = {"Open", "开放", "Reopened", "重新打开", "处理中", "In Progress"}
WONT_FIX_RESOLUTIONS = {"问题不修改", "非问题", "Won't Fix", "Won't Do", "不解决"}
DUPLICATE_RESOLUTIONS = {"重复问题", "Duplicate"}
RESOLVED_STATUSES = {"Resolved", "已解决", "Verified"}
RESOLVED_FIXED_RESOLUTIONS = {"完成", "Done"}
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


def _is_comparable_version(version: Any) -> bool:
    text = _normalize_text(version)
    return bool(text and re.search(r"\d", text))


def _compare_versions(current_version: Any, fix_version: Any) -> int:
    current_key = _version_key(current_version)
    fix_key = _version_key(fix_version)
    if current_key < fix_key:
        return -1
    if current_key > fix_key:
        return 1
    return 0


def _compare_mld_versions(current_version: str, fix_version: str) -> int:
    """Compare MLD-style versions by date, then board, then V-number.

    MLD format: MLD-LX{N}-{date}V{ver}  (e.g. MLD-LX3-16-260521V5)
    Fix versions with embedded MLD styles should already be normalized
    by _normalize_compare_version before calling this.

    Primary sort is by BUILD DATE (earlier date = older), so regression
    PASS only proceeds when the fix version date is <= current date.
    """
    cur_match = re.search(r'(\d+)(V\d+)', current_version)
    fix_match = re.search(r'(\d+)(V\d+)', fix_version)

    if not cur_match or not fix_match:
        return _compare_versions(current_version, fix_version)

    cur_date = int(cur_match.group(1))
    fix_date = int(fix_match.group(1))

    if cur_date < fix_date:
        return -1
    if cur_date > fix_date:
        return 1

    # Same date → compare LX number
    cur_lx_match = re.search(r'LX(\d+)', current_version)
    fix_lx_match = re.search(r'LX(\d+)', fix_version)
    if cur_lx_match and fix_lx_match:
        cur_lx = int(cur_lx_match.group(1))
        fix_lx = int(fix_lx_match.group(1))
        if cur_lx < fix_lx:
            return -1
        if cur_lx > fix_lx:
            return 1

    # Same date and LX → compare V-number
    cur_ver = int(cur_match.group(2)[1:])
    fix_ver = int(fix_match.group(2)[1:])
    if cur_ver < fix_ver:
        return -1
    if cur_ver > fix_ver:
        return 1
    return 0


def _is_open_like(status: str) -> bool:
    return status in OPEN_LIKE_STATUSES


def _is_wont_fix(resolution: str) -> bool:
    return resolution in WONT_FIX_RESOLUTIONS


def _is_duplicate_resolution(resolution: str) -> bool:
    return resolution in DUPLICATE_RESOLUTIONS


def _is_closed(status: str) -> bool:
    return status in CLOSED_STATUSES


def _is_resolved(status: str) -> bool:
    return status in RESOLVED_STATUSES


def _resolve_project_key(current_row: Mapping[str, Any], history: Mapping[str, Any]) -> str:
    candidates = [
        history.get("project"),
        history.get("affect_project"),
        current_row.get("project"),
        history.get("jira_key"),
    ]
    for candidate in candidates:
        text = _normalize_text(candidate)
        if not text:
            continue
        if "-" in text and text.upper() == text:
            return text.split("-", 1)[0]
        return text
    return ""


def _normalize_project_keys(values: Any) -> set[str]:
    if values is None:
        return set()
    if isinstance(values, str):
        return {values.strip().upper()} if values.strip() else set()
    if isinstance(values, (list, tuple, set)):
        return {str(item).strip().upper() for item in values if str(item).strip()}
    text = str(values).strip()
    return {text.upper()} if text else set()


def _is_strict_version_project(project_key: str, strict_version_project_keys: Any = None) -> bool:
    return project_key.upper() in _normalize_project_keys(strict_version_project_keys)


def _select_fix_version_for_comparison(fix_version: Any) -> str:
    versions = _split_versions(fix_version)
    if not versions:
        return ""
    return max(versions, key=_version_key)


def _normalize_compare_version(version: str) -> str:
    """Normalize build/fix versions to MLD-style for VFFCA version comparison.

    Fix versions like V552AA-HONOR-LX2-16-260521V5_Release_user_...
    embed an MLD-style version (LX2-16-260521V5).  Extract that so it
    can be compared with Monkey report versions (MLD-LX3-16-260521V5).
    """
    text = _normalize_text(version)
    if not text:
        return text
    if re.match(r'^MLD-LX\d+', text, re.IGNORECASE):
        return text
    match = re.search(r'(LX\d+-\d+-\d+V\d+)', text, re.IGNORECASE)
    if match:
        return f"MLD-{match.group(1)}"
    return text


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


def decide_action(
    current_row: Mapping[str, Any],
    history: Mapping[str, Any],
    current_version: Any,
    *,
    strict_version_project_keys: Any = None,
) -> ActionDecision:
    status = _normalize_text(history.get("status"))
    resolution = _normalize_text(history.get("resolution"))
    fix_version = _normalize_text(history.get("fix_version"))
    build_version = _normalize_text(history.get("build_version"))
    project_key = _resolve_project_key(current_row, history)

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

    if _is_duplicate_resolution(resolution):
        current_version_text = _normalize_text(current_version)
        if not _is_comparable_version(current_version_text) or not _is_comparable_version(build_version):
            return ActionDecision(
                action="MANUAL_REVIEW",
                update_jira=False,
                manual_review=True,
                comment_required=False,
            )
        if _compare_versions(current_version_text, build_version) > 0:
            return ActionDecision(
                action="DUPLICATE_COMMENT",
                update_jira=False,
                manual_review=False,
                comment_required=True,
            )
        return ActionDecision(
            action="DUPLICATE_KEEP",
            update_jira=False,
            manual_review=False,
            comment_required=False,
        )

    if _is_closed(status):
        return ActionDecision(
            action="CLOSED_RECREATE",
            update_jira=False,
            manual_review=False,
            comment_required=False,
            recreate_issue=True,
        )

    if _is_resolved(status) and resolution in RESOLVED_FIXED_RESOLUTIONS:
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
        if _is_strict_version_project(project_key, strict_version_project_keys):
            comparison_fix_version = _normalize_compare_version(comparison_fix_version)
            current_version_text = _normalize_compare_version(current_version_text)
            build_version = _normalize_compare_version(build_version)
            if not build_version:
                return ActionDecision(
                    action="MANUAL_REVIEW",
                    update_jira=False,
                    manual_review=True,
                    comment_required=False,
                )
            if _compare_mld_versions(comparison_fix_version, build_version) <= 0:
                return ActionDecision(
                    action="MANUAL_REVIEW",
                    update_jira=False,
                    manual_review=True,
                    comment_required=False,
                )
            if _compare_mld_versions(current_version_text, build_version) < 0:
                return ActionDecision(
                    action="MANUAL_REVIEW",
                    update_jira=False,
                    manual_review=True,
                    comment_required=False,
                )
        if _compare_mld_versions(current_version_text, comparison_fix_version) >= 0:
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
    *,
    build_version: Any = None,
    project_key: Any = None,
    strict_version_project_keys: Any = None,
) -> RegressionPassDecision:
    current_version_text = _normalize_text(current_version)
    comparison_fix_version = _select_fix_version_for_comparison(fix_version)
    normalized_verified_versions = _normalize_verified_versions(already_verified)
    normalized_pass_count = int(pass_count or 0)
    normalized_required_versions = max(int(required_versions or 0), 1)
    normalized_build_version = _normalize_text(build_version)
    normalized_project_key = _normalize_text(project_key)

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

    if _is_strict_version_project(normalized_project_key, strict_version_project_keys):
        comparison_fix_version = _normalize_compare_version(comparison_fix_version)
        current_version_text = _normalize_compare_version(current_version_text)
        normalized_build_version = _normalize_compare_version(normalized_build_version)
        if not normalized_build_version:
            return RegressionPassDecision(
                action="REGRESSION_PASS_SKIP",
                record_pass=False,
                close_issue=False,
                new_pass_count=normalized_pass_count,
                comment_required=False,
                reason="BUILD_VERSION_EMPTY",
            )
        if _compare_mld_versions(comparison_fix_version, normalized_build_version) <= 0:
            return RegressionPassDecision(
                action="REGRESSION_PASS_SKIP",
                record_pass=False,
                close_issue=False,
                new_pass_count=normalized_pass_count,
                comment_required=False,
                reason="FIX_VERSION_NOT_AFTER_BUILD_VERSION",
            )
        if _compare_mld_versions(current_version_text, normalized_build_version) < 0:
            return RegressionPassDecision(
                action="REGRESSION_PASS_SKIP",
                record_pass=False,
                close_issue=False,
                new_pass_count=normalized_pass_count,
                comment_required=False,
                reason="CURRENT_VERSION_BEFORE_BUILD_VERSION",
            )

    if _compare_mld_versions(current_version_text, comparison_fix_version) < 0:
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
