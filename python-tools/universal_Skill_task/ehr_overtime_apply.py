# -*- coding: utf-8 -*-
"""Open EHR 加班申请 and prefill fields. Never submit."""

from __future__ import annotations

from collections import OrderedDict
from datetime import date, time
from typing import List

from playwright.sync_api import Frame, Page

from ehr_nav import open_overtime_apply
from overtime_decision import Decision
from overtime_rules import Action

FORBIDDEN_CLICK_TEXTS: List[str] = [
    "提交",
    "保存",
    "送审",
    "确定",
    "确认提交",
    "同意提交",
]

# Real selectors from artifacts/probe_overtime_apply.txt frame[3] (ATT_S_OT_APP).
# The live form only shows 加班日期 / 开始时间 / 结束时间 / 加班原因; OT_TYPE and
# TO_DATE are hidden inputs the server derives from 加班日期.
SEL_CATEGORY = "select[name='OT_TYPE']"
SEL_START_DATE = "input[name='FROM_DATE']"
SEL_END_DATE = "input[name='TO_DATE']"
SEL_START_TIME = "input[name='FROM_TIME']"
SEL_END_TIME = "input[name='TO_TIME']"
SEL_REASON = "textarea[name='REMARK']"


class OvertimeApplyError(RuntimeError):
    """Failed to open or prefill overtime apply form."""


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


def plan_prefill_values(decision: Decision) -> "OrderedDict[str, str]":
    """Map an APPLY decision onto the selectors of the visible form fields."""
    if decision.action != Action.APPLY:
        raise OvertimeApplyError(f"Refuse to prefill when action={decision.action.value}")
    if decision.proposed_start is None or decision.proposed_end is None:
        raise OvertimeApplyError("APPLY decision missing proposed start/end")

    values: "OrderedDict[str, str]" = OrderedDict()
    values[SEL_START_DATE] = format_ehr_date(decision.target_date)
    values[SEL_START_TIME] = format_ehr_time(decision.proposed_start)
    values[SEL_END_TIME] = format_ehr_time(decision.proposed_end)
    values[SEL_REASON] = decision.reason or "待确认"
    return values


def _find_frame_with_selector(page: Page, selector: str) -> Frame:
    for frame in page.frames:
        try:
            if frame.locator(selector).count() > 0:
                return frame
        except Exception:
            continue
    raise OvertimeApplyError(f"Selector not found in any frame: {selector}")


def _fill_first(frame: Frame, selector: str, value: str) -> None:
    loc = frame.locator(selector).first
    loc.wait_for(state="visible", timeout=15_000)
    loc.fill(value)


def prefill_overtime_form(page: Page, decision: Decision) -> None:
    values = plan_prefill_values(decision)

    open_overtime_apply(page)
    page.wait_for_timeout(3_000)

    for selector, value in values.items():
        _fill_first(_find_frame_with_selector(page, selector), selector, value)

    # Safety: never click Submit or any forbidden control. No submit function exists.
