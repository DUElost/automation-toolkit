# -*- coding: utf-8 -*-
"""Password login to BPM portal."""

from __future__ import annotations

from playwright.sync_api import Page, TimeoutError as PlaywrightTimeoutError

from config import AppConfig

# --- selectors (adjust after live probe) ---
USERNAME_SELECTORS = [
    'input[name="username"]',
    'input[name="account"]',
    'input[type="text"]',
    'input[placeholder*="账号"]',
    'input[placeholder*="用户"]',
    'input[placeholder*="邮箱"]',
    'input[placeholder*="手机"]',
]
PASSWORD_SELECTORS = [
    'input[name="password"]',
    'input[type="password"]',
]
SUBMIT_SELECTORS = [
    'button[type="submit"]',
    'input[type="submit"]',
    'button:has-text("登录")',
    'button:has-text("登 录")',
    'a:has-text("登录")',
]


class LoginError(RuntimeError):
    """BPM login failed."""


def _first_visible(page: Page, selectors: list[str]):
    for sel in selectors:
        loc = page.locator(sel).first
        try:
            if loc.count() and loc.is_visible():
                return loc
        except Exception:
            continue
    return None


def login_bpm(page: Page, cfg: AppConfig) -> None:
    """Open BPM URL, fill credentials, submit, wait until not on bare login form."""
    page.goto(cfg.bpm_url, wait_until="domcontentloaded")
    page.wait_for_timeout(1000)

    user = _first_visible(page, USERNAME_SELECTORS)
    pwd = _first_visible(page, PASSWORD_SELECTORS)
    if user is None or pwd is None:
        raise LoginError(
            "Login form not found (username/password). "
            "Possible captcha/SSO-only page — needs manual check."
        )

    user.fill(cfg.username)
    pwd.fill(cfg.password)

    submit = _first_visible(page, SUBMIT_SELECTORS)
    if submit is None:
        pwd.press("Enter")
    else:
        submit.click()

    try:
        # Leave login: password field should disappear or URL change meaningfully.
        page.wait_for_function(
            """() => {
              const pwd = document.querySelector('input[type="password"]');
              const stillLogin = pwd && pwd.offsetParent !== null;
              return !stillLogin;
            }""",
            timeout=45_000,
        )
    except PlaywrightTimeoutError as exc:
        body = ""
        try:
            body = page.inner_text("body")[:500]
        except Exception:
            pass
        hint = ""
        if any(k in body for k in ("验证码", "滑块", "二次", "扫码", "短信")):
            hint = " Possible captcha/2FA — manual intervention required."
        raise LoginError(f"Login did not complete within timeout.{hint} url={page.url}") from exc
