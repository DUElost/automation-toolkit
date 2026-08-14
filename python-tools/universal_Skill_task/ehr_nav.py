# -*- coding: utf-8 -*-
"""EHR in-app navigation. Always go via 首页; never browser back."""

from __future__ import annotations

import time
from typing import List, Optional, Tuple

from playwright.sync_api import Locator, Page

HOME_TEXTS = ["首页"]
ATTENDANCE_TEXTS = ["我的考勤"]
OVERTIME_QUERY_TEXTS = ["加班查询"]
OVERTIME_APPLY_TEXTS = ["加班申请"]


class EhrNavError(RuntimeError):
    """EHR navigation failed."""


def _iter_roots(page: Page):
    yield page
    for frame in page.frames:
        if frame == page.main_frame:
            continue
        yield frame


def _visible_matches(page: Page, text: str) -> List[Tuple[float, Locator]]:
    """Return (area, locator) for visible exact text matches; smaller area first."""
    found: List[Tuple[float, Locator]] = []
    for root in _iter_roots(page):
        try:
            loc = root.get_by_text(text, exact=True)
            count = loc.count()
        except Exception:
            continue
        for i in range(count):
            item = loc.nth(i)
            try:
                if not item.is_visible():
                    continue
                box = item.bounding_box()
                if not box:
                    continue
                area = float(box["width"]) * float(box["height"])
                found.append((area, item))
            except Exception:
                continue
    found.sort(key=lambda x: x[0])
    return found


def _click_by_texts(page: Page, texts: List[str], what: str) -> None:
    last_exc: Optional[BaseException] = None
    for text in texts:
        matches = _visible_matches(page, text)
        for _area, item in matches:
            try:
                item.click(timeout=10_000)
                page.wait_for_timeout(2_500)
                return
            except Exception as exc:  # noqa: BLE001
                last_exc = exc
                continue
    raise EhrNavError(f"Cannot click {what}. last_error={last_exc} url={page.url}")


def go_home(page: Page) -> None:
    _click_by_texts(page, HOME_TEXTS, "首页")


def open_my_attendance(page: Page) -> None:
    go_home(page)
    page.wait_for_timeout(1_000)
    _click_by_texts(page, ATTENDANCE_TEXTS, "我的考勤")


def open_overtime_query(page: Page) -> None:
    go_home(page)
    page.wait_for_timeout(1_000)
    _click_by_texts(page, OVERTIME_QUERY_TEXTS, "加班查询")


def open_overtime_apply(page: Page) -> None:
    go_home(page)
    page.wait_for_timeout(1_000)
    _click_by_texts(page, OVERTIME_APPLY_TEXTS, "加班申请")


HOME_READY_TEXTS = ["我的考勤", "加班查询", "加班申请"]


def wait_ehr_home_ready(page: Page, timeout_ms: int = 60_000) -> None:
    """Poll until any home shortcut label shows, so a slow SSO load isn't a long stall."""
    deadline = time.monotonic() + timeout_ms / 1000.0
    while time.monotonic() < deadline:
        for text in HOME_READY_TEXTS:
            if _visible_matches(page, text):
                return
        page.wait_for_timeout(500)
    raise EhrNavError(f"EHR home shortcuts never appeared. url={page.url}")
