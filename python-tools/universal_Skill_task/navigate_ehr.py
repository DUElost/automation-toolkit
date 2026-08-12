# -*- coding: utf-8 -*-
"""Open EHR from the navigation panel on the BPM portal home page."""

from __future__ import annotations

from playwright.sync_api import BrowserContext, Page, TimeoutError as PlaywrightTimeoutError

from cert_dialog import confirm_in_background

# After login the portal lands on the timesheet view; 门户 switches to the home panels.
PORTAL_TAB = "#Shortcutmenu a"
# Tile in the 导航 panel at the bottom right; its onclick opens EHR in a new tab.
EHR_TILE = 'td[onclick*="vehrlogin"]'
EHR_HOST = "ehr.tinno.com"


class NavigateEhrError(RuntimeError):
    """Failed to open EHR from the BPM portal."""


def open_ehr(page: Page, context: BrowserContext) -> Page:
    """Switch to the portal home, click the EHR tile, and return the new EHR tab."""
    try:
        page.click(PORTAL_TAB, timeout=30_000)
    except PlaywrightTimeoutError as exc:
        raise NavigateEhrError(f"Could not click the 门户 tab. url={page.url}") from exc

    try:
        page.wait_for_selector(EHR_TILE, state="visible", timeout=45_000)
    except PlaywrightTimeoutError as exc:
        raise NavigateEhrError(f"EHR tile never became visible on the portal home. url={page.url}") from exc

    _thread, stop_confirming = confirm_in_background(deadline_s=40)
    try:
        with context.expect_page(timeout=30_000) as new_page:
            page.click(EHR_TILE, timeout=15_000)
        ehr_page = new_page.value
        ehr_page.wait_for_load_state("domcontentloaded", timeout=60_000)
        ehr_page.wait_for_timeout(5_000)
    except PlaywrightTimeoutError as exc:
        raise NavigateEhrError(f"EHR tab did not open after clicking the tile. url={page.url}") from exc
    finally:
        stop_confirming.set()

    if EHR_HOST not in ehr_page.url:
        raise NavigateEhrError(f"Opened tab is not EHR. url={ehr_page.url} title={ehr_page.title()}")

    return ehr_page
