# -*- coding: utf-8 -*-
"""Auto-confirm the Chromium client-certificate prompt on Windows.

Company policy blocks the AutoSelectCertificateForUrls registry key, and the prompt
is a browser-native dialog Playwright cannot reach, so it is confirmed by sending
ENTER to the browser window.
"""

from __future__ import annotations

import ctypes
import ctypes.wintypes as wt
import threading
import time
from typing import Optional

user32 = ctypes.windll.user32
kernel32 = ctypes.windll.kernel32

_EnumWindowsProc = ctypes.WINFUNCTYPE(wt.BOOL, wt.HWND, wt.LPARAM)

VK_RETURN = 0x0D
KEYEVENTF_KEYUP = 0x0002
SW_RESTORE = 9

BROWSER_TITLE_HINTS = ("Chrome for Testing", "Chromium")


def _window_title(hwnd) -> str:
    length = user32.GetWindowTextLengthW(hwnd)
    if length <= 0:
        return ""
    buf = ctypes.create_unicode_buffer(length + 1)
    user32.GetWindowTextW(hwnd, buf, length + 1)
    return buf.value


def _window_class(hwnd) -> str:
    buf = ctypes.create_unicode_buffer(256)
    user32.GetClassNameW(hwnd, buf, 256)
    return buf.value


def find_browser_window():
    """Return hwnd of the visible headed-Chromium window, or None."""
    match = []

    def callback(hwnd, _lparam):
        if not user32.IsWindowVisible(hwnd):
            return True
        if not _window_class(hwnd).startswith("Chrome_WidgetWin"):
            return True
        title = _window_title(hwnd)
        if any(hint in title for hint in BROWSER_TITLE_HINTS):
            match.append(hwnd)
        return True

    user32.EnumWindows(_EnumWindowsProc(callback), 0)
    return match[0] if match else None


def _focus(hwnd) -> None:
    user32.ShowWindow(hwnd, SW_RESTORE)
    foreground_thread = user32.GetWindowThreadProcessId(user32.GetForegroundWindow(), None)
    current_thread = kernel32.GetCurrentThreadId()
    user32.AttachThreadInput(current_thread, foreground_thread, True)
    user32.BringWindowToTop(hwnd)
    user32.SetForegroundWindow(hwnd)
    user32.AttachThreadInput(current_thread, foreground_thread, False)


def _press_enter() -> None:
    user32.keybd_event(VK_RETURN, 0, 0, 0)
    time.sleep(0.05)
    user32.keybd_event(VK_RETURN, 0, KEYEVENTF_KEYUP, 0)


def auto_confirm_cert_dialog(
    stop_event: Optional[threading.Event] = None,
    deadline_s: float = 45.0,
    initial_delay_s: float = 3.5,
    interval_s: float = 3.0,
) -> None:
    """Repeatedly confirm the certificate prompt until stopped or the deadline passes.

    Intended to run in a daemon thread while the main thread navigates. Retries because
    the prompt may appear again for other tinno.com hosts during SSO redirects. The
    caller should set stop_event once navigation returns, so stray ENTER keystrokes
    never reach page content.
    """
    stop = stop_event or threading.Event()
    if stop.wait(initial_delay_s):
        return

    started = time.time()
    while not stop.is_set() and time.time() - started < deadline_s:
        hwnd = find_browser_window()
        if hwnd:
            try:
                _focus(hwnd)
                time.sleep(0.5)
                _press_enter()
            except OSError:
                pass
        if stop.wait(interval_s):
            return


def confirm_in_background(deadline_s: float = 45.0) -> tuple[threading.Thread, threading.Event]:
    """Start the confirm loop in a daemon thread; caller sets the event to stop it."""
    stop = threading.Event()
    thread = threading.Thread(
        target=auto_confirm_cert_dialog,
        kwargs={"stop_event": stop, "deadline_s": deadline_s},
        daemon=True,
    )
    thread.start()
    return thread, stop
