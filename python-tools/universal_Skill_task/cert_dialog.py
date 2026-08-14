# -*- coding: utf-8 -*-
"""Auto-confirm the Chromium client-certificate prompt on Windows.

Company policy blocks the AutoSelectCertificateForUrls registry key, and the prompt
is a browser-native dialog Playwright cannot reach, so it is confirmed by focusing the
Playwright Chromium window and sending ENTER (also PostMessage as a fallback).
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
WM_KEYDOWN = 0x0100
WM_KEYUP = 0x0101
WM_ACTIVATE = 0x0006
WA_ACTIVE = 1

# Only match Playwright's Chromium — never RDP / other apps' #32770 dialogs.
BROWSER_TITLE_HINTS = ("Chrome for Testing",)


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
    """Return hwnd of the visible Playwright Chromium window, or None."""
    match = []

    def callback(hwnd, _lparam):
        if not user32.IsWindowVisible(hwnd):
            return True
        cls = _window_class(hwnd)
        if cls != "Chrome_WidgetWin_1":
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


def _post_enter(hwnd) -> None:
    user32.PostMessageW(hwnd, WM_ACTIVATE, WA_ACTIVE, 0)
    user32.PostMessageW(hwnd, WM_KEYDOWN, VK_RETURN, 0)
    user32.PostMessageW(hwnd, WM_KEYUP, VK_RETURN, 0)


def auto_confirm_cert_dialog(
    stop_event: Optional[threading.Event] = None,
    deadline_s: float = 60.0,
    initial_delay_s: float = 1.0,
    interval_s: float = 1.5,
) -> None:
    """Repeatedly confirm the certificate prompt until stopped or the deadline passes."""
    stop = stop_event or threading.Event()
    if stop.wait(initial_delay_s):
        return

    started = time.time()
    while not stop.is_set() and time.time() - started < deadline_s:
        hwnd = find_browser_window()
        if hwnd:
            try:
                _focus(hwnd)
                time.sleep(0.2)
                _post_enter(hwnd)
                _press_enter()
            except OSError:
                pass
        if stop.wait(interval_s):
            return


def confirm_in_background(deadline_s: float = 60.0) -> tuple[threading.Thread, threading.Event]:
    """Start the confirm loop in a daemon thread; caller sets the event to stop it."""
    stop = threading.Event()
    thread = threading.Thread(
        target=auto_confirm_cert_dialog,
        kwargs={"stop_event": stop, "deadline_s": deadline_s, "initial_delay_s": 1.0, "interval_s": 1.5},
        daemon=True,
    )
    thread.start()
    return thread, stop
