#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
决策编码、文案模板与状态映射。
"""

from __future__ import annotations

from dataclasses import dataclass
from datetime import datetime
from typing import Any, Dict, List, Optional, Sequence

from .version_utils import VersionComparator, VersionOutcome


class ActionKey:
    ACT_NEW_ISSUE = "ACT_NEW_ISSUE"
    ACT_NEW_REF_CLOSED = "ACT_NEW_REF_CLOSED"
    ACT_LOG_WONT_FIX = "ACT_LOG_WONT_FIX"
    ACT_UPDATE_OPEN = "ACT_UPDATE_OPEN"
    ACT_IGNORE_LEGACY = "ACT_IGNORE_LEGACY"
    ACT_REOPEN = "ACT_REOPEN"
    ACT_REGRESSION_PASS_1 = "ACT_REGRESSION_PASS_1"
    ACT_REGRESSION_CLOSE = "ACT_REGRESSION_CLOSE"
    ACT_REGRESSION_SKIP = "ACT_REGRESSION_SKIP"

    @classmethod
    def all(cls) -> List[str]:
        return [
            cls.ACT_NEW_ISSUE,
            cls.ACT_NEW_REF_CLOSED,
            cls.ACT_LOG_WONT_FIX,
            cls.ACT_UPDATE_OPEN,
            cls.ACT_IGNORE_LEGACY,
            cls.ACT_REOPEN,
            cls.ACT_REGRESSION_PASS_1,
            cls.ACT_REGRESSION_CLOSE,
            cls.ACT_REGRESSION_SKIP,
        ]


@dataclass
class DecisionOutcome:
    action_key: str
    comment: Optional[str] = None
    reopen: bool = False
    create_new: bool = False
    update_fields: bool = False
    reference_issue: Optional[str] = None
    reason: str = ""


class DecisionTemplates:
    """针对不同决策的备注生成器。"""

    @staticmethod
    def new_ref_closed(current_version: Optional[str], old_key: Optional[str]) -> str:
        return "\n".join(
            [
                f"关联旧单：{old_key or 'N/A'} (原单已关闭，此次重新提单)",
                f"复现版本：{current_version or 'Unknown'}",
                "Log详情：自动化上传，请补充细节。",
            ]
        )

    @staticmethod
    def wont_fix(current_version: Optional[str], total_count: Optional[int]) -> str:
        suffix = f"累计报错次数: {total_count}" if total_count is not None else "累计报错次数: 未统计"
        return "\n".join(
            [
                "Status: Won't Fix 待后续补充信息。",
                f"Current Version: {current_version or 'Unknown'}",
                suffix,
            ]
        )

    @staticmethod
    def update_open(current_version: Optional[str]) -> str:
        return "\n".join(
            [
                "Status: 问题继续在新版本中出现，待后续补充信息。",
                f"Version: {current_version or 'Unknown'}",
                "Note: 自动化系统更新了标题与等级数据。",
            ]
        )

    @staticmethod
    def ignore_legacy(current_version: Optional[str], fix_version: Optional[str]) -> str:
        return "\n".join(
            [
                "Status: 在历史版本中出现，待新版本验证结果。",
                f"Reason: 当前测试版本 {current_version or 'Unknown'} 早于 修复版本 {fix_version or 'Unknown'}。",
            ]
        )

    @staticmethod
    def reopen(current_version: Optional[str], fix_version: Optional[str]) -> str:
        return "\n".join(
            [
                "Status: 问题复现 Reopen 待后续补充信息。",
                f"Version Logic: 修复版本 {fix_version or 'Unknown'} <= 当前版本 {current_version or 'Unknown'}，确认复现。",
            ]
        )

    @staticmethod
    def regression_pass(version: Optional[str]) -> str:
        today = datetime.now().strftime("%Y-%m-%d")
        return "\n".join(
            [
                "Status: 已回归验证 1 个版本 PASS",
                f"Verified Version: {version or 'Unknown'} ({today})",
            ]
        )

    @staticmethod
    def regression_close(history: Sequence[Dict[str, Any]]) -> str:
        lines = ["Status: Closed", "Regression History:"]
        for item in history:
            version = item.get("version") or "Unknown"
            date = item.get("date") or datetime.now().strftime("%Y-%m-%d")
            lines.append(f"{version} ({date}, 验证通过)")
        return "\n".join(lines)


class DecisionPolicy:
    """将 Jira 状态映射为标准决策编码。"""

    CLOSED_STATUS = {"closed", "done", "已关闭"}
    RESOLVED_STATUS = {"resolved", "已解决"}
    WONT_FIX_KEYWORDS = {"won't fix", "wont fix", "won’t fix", "不解决"}

    def __init__(self, comparator: VersionComparator):
        self.comparator = comparator

    def decide_existing(
        self,
        pending_issue: Dict[str, Any],
        status: str,
        resolution: str,
        fix_version: Optional[str],
        matched_key: Optional[str],
    ) -> DecisionOutcome:
        status_key = self._normalize(status)
        resolution_key = self._normalize(resolution)

        if status_key in self.CLOSED_STATUS:
            comment = DecisionTemplates.new_ref_closed(pending_issue.get("version"), matched_key)
            return DecisionOutcome(
                action_key=ActionKey.ACT_NEW_REF_CLOSED,
                comment=comment,
                create_new=True,
                update_fields=True,
                reference_issue=matched_key,
                reason="matched-closed",
            )

        if self._is_wont_fix(status_key, resolution_key):
            total_count = pending_issue.get("count")
            return DecisionOutcome(
                action_key=ActionKey.ACT_LOG_WONT_FIX,
                comment=DecisionTemplates.wont_fix(pending_issue.get("version"), total_count),
                update_fields=False,
                reason="wont-fix",
            )

        if status_key in self.RESOLVED_STATUS:
            version_result = self.comparator.compare(pending_issue.get("version"), fix_version)
            if version_result.outcome == VersionOutcome.IS_NEWER_OR_EQUAL:
                return DecisionOutcome(
                    action_key=ActionKey.ACT_REOPEN,
                    comment=DecisionTemplates.reopen(pending_issue.get("version"), fix_version),
                    reopen=True,
                    update_fields=True,
                    reason=version_result.reason,
                )
            return DecisionOutcome(
                action_key=ActionKey.ACT_IGNORE_LEGACY,
                comment=DecisionTemplates.ignore_legacy(pending_issue.get("version"), fix_version),
                update_fields=False,
                reason=version_result.reason,
            )

        return DecisionOutcome(
            action_key=ActionKey.ACT_UPDATE_OPEN,
            comment=DecisionTemplates.update_open(pending_issue.get("version")),
            update_fields=True,
            reason="status-open",
        )

    @staticmethod
    def _normalize(value: Optional[str]) -> str:
        return (value or "").strip().lower()

    def _is_wont_fix(self, status: str, resolution: str) -> bool:
        combined = f"{status} {resolution}".lower()
        return any(keyword in combined for keyword in self.WONT_FIX_KEYWORDS)
