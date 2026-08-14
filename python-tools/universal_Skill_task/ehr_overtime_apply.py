# -*- coding: utf-8 -*-
"""Open EHR 加班申请, prefill fields, and optionally submit when caller asks."""

from __future__ import annotations

from collections import OrderedDict
from datetime import date, time
from typing import List, Optional

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

# Visible fields on ATT_S_OT_APP. OT_TYPE / TO_DATE exist but are hidden and
# derived by the server from 加班日期 — do not fill them.
SEL_START_DATE = "input[name='FROM_DATE']"
SEL_START_TIME = "input[name='FROM_TIME']"
SEL_END_TIME = "input[name='TO_TIME']"
SEL_REASON = "textarea[name='REMARK']"
SEL_SUBMIT = "input[type='submit'][name='Submit']"


class OvertimeApplyError(RuntimeError):
    """Failed to open, prefill, or submit overtime apply form."""


def format_ehr_date(d: date) -> str:
    return f"{d.day:02d}/{d.month:02d}/{d.year}"


def format_ehr_time(t: time) -> str:
    return t.strftime("%H:%M")


def is_forbidden_click_text(text: str) -> bool:
    s = (text or "").strip()
    if not s:
        return False
    return any(bad in s for bad in FORBIDDEN_CLICK_TEXTS)


def plan_prefill_values(
    decision: Decision,
    reason: Optional[str] = None,
) -> "OrderedDict[str, str]":
    """Map an APPLY decision onto the selectors of the visible form fields."""
    if decision.action != Action.APPLY:
        raise OvertimeApplyError(f"Refuse to prefill when action={decision.action.value}")
    if decision.proposed_start is None or decision.proposed_end is None:
        raise OvertimeApplyError("APPLY decision missing proposed start/end")

    values: "OrderedDict[str, str]" = OrderedDict()
    values[SEL_START_DATE] = format_ehr_date(decision.target_date)
    values[SEL_START_TIME] = format_ehr_time(decision.proposed_start)
    values[SEL_END_TIME] = format_ehr_time(decision.proposed_end)
    values[SEL_REASON] = (reason or "").strip() or decision.reason or "待确认"
    return values


def _find_frame_with_selector(page: Page, selector: str) -> Frame:
    for frame in page.frames:
        try:
            if frame.locator(selector).count() > 0:
                return frame
        except Exception:
            continue
    raise OvertimeApplyError(f"Selector not found in any frame: {selector}")


_SET_READONLY_VALUE = """
(el, value) => {
  el.value = value;
  for (const type of ['input', 'change', 'blur']) {
    el.dispatchEvent(new Event(type, { bubbles: true }));
  }
  return el.value;
}
"""


def _fill_first(frame: Frame, selector: str, value: str) -> None:
    """Fill a field, or drive its own handlers when the date/time picker marks it readonly."""
    loc = frame.locator(selector).first
    loc.wait_for(state="visible", timeout=15_000)
    if loc.evaluate("el => el.readOnly === true"):
        loc.evaluate(_SET_READONLY_VALUE, value)
    else:
        loc.fill(value)

    actual = loc.input_value()
    if actual != value:
        raise OvertimeApplyError(f"Field {selector} kept {actual!r} instead of {value!r}")


def prefill_overtime_form(page: Page, decision: Decision, reason: Optional[str] = None) -> None:
    values = plan_prefill_values(decision, reason)

    open_overtime_apply(page)
    page.wait_for_timeout(3_000)

    for selector, value in values.items():
        _fill_first(_find_frame_with_selector(page, selector), selector, value)


def submit_overtime_form(page: Page) -> None:
    """Click the form Submit button. Caller must have passed --ALLOW."""
    frame = _find_frame_with_selector(page, SEL_SUBMIT)
    loc = frame.locator(SEL_SUBMIT).first
    loc.wait_for(state="visible", timeout=15_000)
    loc.click()
    page.wait_for_timeout(3_000)
