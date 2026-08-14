# -*- coding: utf-8 -*-
"""Open EHR 加班申请 and prefill fields. Never submit."""

from __future__ import annotations

from datetime import date, time
from typing import List

FORBIDDEN_CLICK_TEXTS: List[str] = [
    "提交",
    "保存",
    "送审",
    "确定",
    "确认提交",
    "同意提交",
]


def category_for_day_kind(day_kind: str) -> str:
    if day_kind == "weekend":
        return "周末加班"
    return "平日加班"


def format_ehr_date(d: date) -> str:
    return f"{d.day:02d}/{d.month:02d}/{d.year}"


def format_ehr_time(t: time) -> str:
    return t.strftime("%H:%M")


def is_forbidden_click_text(text: str) -> bool:
    s = (text or "").strip()
    if not s:
        return False
    return any(bad in s for bad in FORBIDDEN_CLICK_TEXTS)
