# -*- coding: utf-8 -*-
"""Open EHR 加班申请 and prefill fields. Never submit."""

from __future__ import annotations

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

# Real selectors from artifacts/probe_overtime_apply.txt frame[3] (ATT_S_OT_APP)
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
    if decision.action != Action.APPLY:
        raise OvertimeApplyError(f"Refuse to prefill when action={decision.action.value}")
    if decision.proposed_start is None or decision.proposed_end is None:
        raise OvertimeApplyError("APPLY decision missing proposed start/end")

    open_overtime_apply(page)
    page.wait_for_timeout(3_000)

    category = category_for_day_kind(decision.day_kind)
    start_date = format_ehr_date(decision.target_date)
    end_date = format_ehr_date(decision.target_date)
    start_time = format_ehr_time(decision.proposed_start)
    end_time = format_ehr_time(decision.proposed_end)
    reason = decision.reason or "待确认"

    frame = _find_frame_with_selector(page, SEL_CATEGORY)
    cat = frame.locator(SEL_CATEGORY).first
    tag = cat.evaluate("el => el.tagName")
    if tag == "SELECT":
        cat.select_option(label=category)
    else:
        frame.get_by_text(category, exact=True).first.click()

    _fill_first(_find_frame_with_selector(page, SEL_START_DATE), SEL_START_DATE, start_date)
    _fill_first(_find_frame_with_selector(page, SEL_START_TIME), SEL_START_TIME, start_time)
    _fill_first(_find_frame_with_selector(page, SEL_END_DATE), SEL_END_DATE, end_date)
    _fill_first(_find_frame_with_selector(page, SEL_END_TIME), SEL_END_TIME, end_time)
    _fill_first(_find_frame_with_selector(page, SEL_REASON), SEL_REASON, reason)

    # Safety: never click Submit or any forbidden control. No submit function exists.
