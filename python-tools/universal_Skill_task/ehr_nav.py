# -*- coding: utf-8 -*-
"""EHR in-app navigation. Always go via 首页; never browser back."""

from __future__ import annotations

from playwright.sync_api import Page

HOME_SELECTORS = [
    'a:has-text("首页")',
    'text=首页',
]
ATTENDANCE_SELECTORS = [
    'a:has-text("我的考勤")',
    'text=我的考勤',
]
OVERTIME_QUERY_SELECTORS = [
    'a:has-text("加班查询")',
    'text=加班查询',
]


class EhrNavError(RuntimeError):
    """EHR navigation failed."""


def _click_first(page: Page, selectors: list, what: str) -> None:
    last_exc = None
    for sel in selectors:
        loc = page.locator(sel).first
        try:
            if loc.count() and loc.is_visible():
                loc.click(timeout=15_000)
                page.wait_for_timeout(2_000)
                return
        except Exception as exc:
            last_exc = exc
            continue
    raise EhrNavError(f"Cannot click {what}. last_error={last_exc} url={page.url}")


def go_home(page: Page) -> None:
    _click_first(page, HOME_SELECTORS, "首页")


def open_my_attendance(page: Page) -> None:
    go_home(page)
    _click_first(page, ATTENDANCE_SELECTORS, "我的考勤")


def open_overtime_query(page: Page) -> None:
    go_home(page)
    _click_first(page, OVERTIME_QUERY_SELECTORS, "加班查询")
