# -*- coding: utf-8 -*-
"""Open EHR from the navigation panel on the BPM portal home page."""

from __future__ import annotations

from playwright.sync_api import BrowserContext, Page, TimeoutError as PlaywrightTimeoutError

from cert_dialog import confirm_in_background
from bpm_login import dismiss_bpm_home_overlays

# After login the portal lands on the timesheet view; 门户 switches to the home panels.
PORTAL_TAB = "#Shortcutmenu a"
# Tile in the 导航 panel at the bottom right; its onclick opens EHR in a new tab.
EHR_TILE = 'td[onclick*="vehrlogin"]'
EHR_HOST = "ehr.tinno.com"
BPM_HOME = "https://bpm.tinno.com/"


class NavigateEhrError(RuntimeError):
    """Failed to open EHR from the BPM portal."""


def _switch_to_portal(page: Page) -> None:
    dismiss_bpm_home_overlays(page)
    try:
        page.evaluate("() => App.navTabs.activeModel('Shortcutmenu')")
        page.wait_for_timeout(2_000)
        return
    except Exception:
        pass
    try:
        page.locator(PORTAL_TAB).first.click(timeout=10_000)
        page.wait_for_timeout(2_000)
        return
    except PlaywrightTimeoutError:
        pass
    dismiss_bpm_home_overlays(page)
    try:
        page.evaluate("() => App.navTabs.activeModel('Shortcutmenu')")
        page.wait_for_timeout(2_000)
    except Exception as exc:
        raise NavigateEhrError(f"Could not open 门户. url={page.url}") from exc


def _ehr_tile_present(page: Page) -> bool:
    try:
        return bool(
            page.evaluate(
                """() => !!document.querySelector('td[onclick*=\"vehrlogin\"]')"""
            )
        )
    except Exception:
        return False


def _ensure_portal_with_ehr_tile(page: Page) -> None:
    """Reach 门户 home with the EHR shortcut tile in the DOM."""
    _switch_to_portal(page)
    dismiss_bpm_home_overlays(page)
    if _ehr_tile_present(page):
        return

    # After 工时提报 the content frame can be blank; reload BPM home and retry.
    print("[INFO] EHR tile missing after 门户 switch; reloading BPM home", flush=True)
    page.goto(BPM_HOME, wait_until="domcontentloaded", timeout=60_000)
    page.wait_for_timeout(3_000)
    dismiss_bpm_home_overlays(page)
    _switch_to_portal(page)
    dismiss_bpm_home_overlays(page)
    if not _ehr_tile_present(page):
        raise NavigateEhrError(f"EHR tile never became visible on the portal home. url={page.url}")


def open_ehr(page: Page, context: BrowserContext) -> Page:
    """Switch to the portal home, click the EHR tile, and return the new EHR tab."""
    _ensure_portal_with_ehr_tile(page)

    _thread, stop_confirming = confirm_in_background(deadline_s=40)
    try:
        with context.expect_page(timeout=30_000) as new_page:
            clicked = page.evaluate(
                """() => {
                  const el = document.querySelector('td[onclick*=\"vehrlogin\"]');
                  if (!el) return false;
                  el.click();
                  return true;
                }"""
            )
            if not clicked:
                page.click(EHR_TILE, timeout=10_000)
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
