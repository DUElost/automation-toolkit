# -*- coding: utf-8 -*-
"""Launch headed Chromium for BPM automation."""

from __future__ import annotations

from contextlib import contextmanager
from typing import Iterator, Tuple

from playwright.sync_api import Browser, BrowserContext, Page, Playwright, sync_playwright


DEFAULT_TIMEOUT_MS = 30_000


@contextmanager
def launch_page(timeout_ms: int = DEFAULT_TIMEOUT_MS) -> Iterator[Tuple[Playwright, Browser, BrowserContext, Page]]:
    """Yield playwright, browser, context, page; always close on exit."""
    with sync_playwright() as playwright:
        browser = playwright.chromium.launch(headless=False)
        # EHR (ehr.tinno.com) may present an expired/self-signed TLS cert;
        # ignore so Chromium does not block on the "继续前往（不安全）" interstitial.
        context = browser.new_context(
            viewport={"width": 1440, "height": 900},
            ignore_https_errors=True,
        )
        context.set_default_timeout(timeout_ms)
        page = context.new_page()
        try:
            yield playwright, browser, context, page
        finally:
            context.close()
            browser.close()
