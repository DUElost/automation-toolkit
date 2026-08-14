# -*- coding: utf-8 -*-
"""Assemble and format overtime Decision records."""

from __future__ import annotations

from dataclasses import dataclass
from datetime import date, time
from typing import List, Optional, Sequence

from overtime_rules import (
    LUNCH_SPAN_NOTE,
    Action,
    ExistingOvertime,
    decide_action,
    is_weekend,
    propose_for_day,
    spans_lunch,
)

ALLOW_SUBMIT_OVERTIME = False  # hard forbid submit in this phase


@dataclass(frozen=True)
class Decision:
    target_date: date
    day_kind: str  # weekday|weekend
    punches: List[time]
    existing: Optional[ExistingOvertime]
    action: Action
    proposed_start: Optional[time]
    proposed_end: Optional[time]
    reason: str
    notes: str


def _fmt_t(t: Optional[time]) -> str:
    return "none" if t is None else t.strftime("%H:%M")


def _fmt_punches(punches: Sequence[time]) -> str:
    if not punches:
        return "[]"
    return "[" + ", ".join(p.strftime("%H:%M") for p in punches) + "]"


def _fmt_existing(existing: Optional[ExistingOvertime]) -> str:
    if existing is None:
        return "none"
    return f"[{existing.start.strftime('%H:%M')}-{existing.end.strftime('%H:%M')}]"


def build_decision(
    target_date: date,
    punches: Sequence[time],
    existing: Optional[ExistingOvertime],
) -> Decision:
    proposed = propose_for_day(target_date, punches)
    action, window = decide_action(proposed, existing)
    notes_parts = []
    if window is not None:
        if is_weekend(target_date) and window.start < time(18, 0) and window.end >= time(20, 0):
            raw_end_hint = max(punches) if punches else None
            if raw_end_hint and raw_end_hint > time(19, 0):
                notes_parts.append("跨18:00-19:00，结束减1小时")
        if spans_lunch(window.start, window.end):
            notes_parts.append(LUNCH_SPAN_NOTE)
    if action == Action.SKIP_DIFF_MANUAL:
        notes_parts.append("已有申请与计算结果不一致，需人工处理")
    if not ALLOW_SUBMIT_OVERTIME:
        notes_parts.append("ALLOW_SUBMIT_OVERTIME=False（本阶段仅日志）")

    return Decision(
        target_date=target_date,
        day_kind="weekend" if is_weekend(target_date) else "weekday",
        punches=list(punches),
        existing=existing,
        action=action,
        proposed_start=None if window is None else window.start,
        proposed_end=None if window is None else window.end,
        reason="待确认",
        notes="; ".join(notes_parts) if notes_parts else "",
    )


def format_decision(d: Decision) -> str:
    lines = [
        f"target_date={d.target_date.isoformat()} ({d.day_kind})",
        f"punches={_fmt_punches(d.punches)}",
        f"existing={_fmt_existing(d.existing)}",
        f"action={d.action.value}",
        f"proposed_start={_fmt_t(d.proposed_start)}",
        f"proposed_end={_fmt_t(d.proposed_end)}",
        f"reason={d.reason}",
        f"notes={d.notes}",
    ]
    return "\n".join(lines)
