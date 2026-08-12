# -*- coding: utf-8 -*-
"""Navigate from BPM home to EHR via portal tile."""

from __future__ import annotations

from playwright.sync_api import BrowserContext, Page, TimeoutError as PlaywrightTimeoutError

# --- selectors (adjust after live probe) ---
EHR_CLICK_SELECTORS = [
    'text=EHR',
    'a:has-text("EHR")',
    'div:has-text("EHR")',
    '[title*="EHR"]',
    '[aria-label*="EHR"]',
]


class NavigateEhrError(RuntimeError):
    """Failed to open EHR from BPM home."""


def _find_ehr_locator(page: Page):
    for sel in EHR_CLICK_SELECTORS:
        loc = page.locator(sel).first
        try:
            if loc.count() and loc.is_visible():
                return loc
        except Exception:
            continue
    return None


def _looks_like_ehr(url: str, title: str) -> bool:
    blob = f"{url} {title}".lower()
    return any(k in blob for k in ("ehr", "hr", "human", "人事", "人力"))


def open_ehr(page: Page, context: BrowserContext) -> Page:
    """Click EHR on BPM home; return the page that shows EHR (may be a new tab)."""
    page.wait_for_timeout(1500)
    target = _find_ehr_locator(page)
    if target is None:
        raise NavigateEhrError(f"EHR entry not found on BPM home. url={page.url}")

    try:
        with context.expect_page(timeout=5_000) as new_page_info:
            target.click()
        ehr_page = new_page_info.value
        ehr_page.wait_for_load_state("domcontentloaded")
    except PlaywrightTimeoutError:
        # Same-tab navigation
        try:
            page.wait_for_load_state("domcontentloaded", timeout=30_000)
        except PlaywrightTimeoutError:
            pass
        ehr_page = page

    try:
        ehr_page.wait_for_timeout(2000)
        if not _looks_like_ehr(ehr_page.url, ehr_page.title()):
            # Soft wait: allow SPA redirect
            ehr_page.wait_for_timeout(3000)
        if not _looks_like_ehr(ehr_page.url, ehr_page.title()):
            raise NavigateEhrError(
                f"Opened a page but it does not look like EHR. url={ehr_page.url} title={ehr_page.title()}"
            )
    except NavigateEhrError:
        raise
    except Exception as exc:
        raise NavigateEhrError(f"EHR page check failed: {exc}") from exc

    return ehr_page
