# -*- coding: utf-8 -*-
"""Password login to the TINNO BPM portal."""

from __future__ import annotations

from playwright.sync_api import Page, TimeoutError as PlaywrightTimeoutError

from cert_dialog import confirm_in_background
from config import AppConfig

LOGIN_PATH = "login.jsp"

# The portal shows WeCom QR login first; this toggle swaps in the password form.
SWITCH_TO_PASSWORD = "#pwLogin .qiehuan"
USERNAME_INPUT = "#username"
# Not type=password: the portal fakes masking with -webkit-text-security.
PASSWORD_INPUT = "#pwd"
SUBMIT_BUTTON = "input[type=submit].sub-zh"
ERROR_TIP = ".tishi"


class LoginError(RuntimeError):
    """BPM login failed."""


def _ensure_password_form(page: Page) -> None:
    if page.locator(USERNAME_INPUT).is_visible():
        return
    page.locator(SWITCH_TO_PASSWORD).click()
    try:
        page.wait_for_selector(USERNAME_INPUT, state="visible", timeout=10_000)
    except PlaywrightTimeoutError as exc:
        raise LoginError(f"Password form did not appear. url={page.url}") from exc


def _error_tip(page: Page) -> str:
    try:
        tip = page.locator(ERROR_TIP).first
        if tip.count() and tip.is_visible():
            return (tip.inner_text() or "").strip()
    except PlaywrightTimeoutError:
        pass
    return ""


def login_bpm(page: Page, cfg: AppConfig) -> None:
    """Open BPM, submit credentials, and wait until the portal home page loads.

    The site requires a personal digital certificate, so the native certificate prompt
    is confirmed in the background while the first navigation runs.
    """
    _thread, stop_confirming = confirm_in_background(deadline_s=90)
    print("[INFO] If a certificate dialog appears, click the Chrome window and press Enter once.", flush=True)
    try:
        page.goto(cfg.bpm_url, wait_until="commit", timeout=90_000)
        page.wait_for_load_state("domcontentloaded", timeout=60_000)
    except PlaywrightTimeoutError as exc:
        raise LoginError(
            f"Could not open {cfg.bpm_url}. The certificate prompt may still be waiting, "
            "or the site is unreachable outside the company network."
        ) from exc
    finally:
        stop_confirming.set()

    page.wait_for_timeout(1_500)
    if LOGIN_PATH not in page.url:
        dismiss_bpm_home_overlays(page)
        return

    _ensure_password_form(page)
    page.fill(USERNAME_INPUT, cfg.username)
    page.fill(PASSWORD_INPUT, cfg.password)
    page.click(SUBMIT_BUTTON)

    try:
        page.wait_for_url(lambda url: LOGIN_PATH not in url, timeout=45_000)
    except PlaywrightTimeoutError as exc:
        tip = _error_tip(page)
        detail = f" portal says: {tip}" if tip else ""
        raise LoginError(f"Login did not complete.{detail} url={page.url}") from exc

    page.wait_for_timeout(3_000)
    dismiss_bpm_home_overlays(page)


def dismiss_bpm_home_overlays(page: Page) -> None:
    """Close login-home notices (e.g. 审计通知书) that block the top nav.

    Only closes Ext window/dialog components and mask layers — never hide
    arbitrary large DOM parents (that blanked the portal after timesheet).
    """
    try:
        page.keyboard.press("Escape")
    except Exception:
        pass
    page.wait_for_timeout(400)
    try:
        removed = page.evaluate(
            """() => {
              let closed = 0;
              if (window.Ext) {
                Ext.ComponentMgr.all.each(function (c) {
                  try {
                    const xt = (c.getXType && c.getXType()) || '';
                    if (xt !== 'window' && xt !== 'messagebox' && xt !== 'panel') return;
                    if (c.hidden) return;
                    const text = (
                      (c.title || '') + ' ' +
                      ((c.body && c.body.dom && c.body.dom.innerText) || '')
                    ).slice(0, 500);
                    const hit = /审计|通知书|公告|点击图片查看详情|专审/.test(text);
                    if (!hit) return;
                    if (typeof c.close === 'function') { c.close(); closed++; return; }
                    if (typeof c.hide === 'function') { c.hide(); closed++; }
                  } catch (e) {}
                });
              }
              document.querySelectorAll('.x-window').forEach((win) => {
                const text = (win.innerText || '').slice(0, 500);
                if (!/审计|通知书|点击图片查看详情|专审/.test(text)) return;
                const closeBtn = win.querySelector('.x-tool-close');
                if (closeBtn) {
                  try { closeBtn.click(); closed++; } catch (e) {}
                } else {
                  win.style.display = 'none';
                  closed++;
                }
              });
              document.querySelectorAll('.x-mask, .ext-el-mask, .x-mask-loading, .x-shadow').forEach((el) => {
                el.style.display = 'none';
                closed++;
              });
              return closed;
            }"""
        )
        if removed:
            print(f"[INFO] dismissed BPM overlays count={removed}", flush=True)
    except Exception:
        pass
    for label in ("关闭", "我知道了", "知道了"):
        try:
            loc = page.get_by_role("button", name=label)
            if loc.count() and loc.first.is_visible():
                loc.first.click(timeout=1_500)
                page.wait_for_timeout(300)
        except Exception:
            pass
    try:
        page.keyboard.press("Escape")
    except Exception:
        pass
    page.wait_for_timeout(500)
