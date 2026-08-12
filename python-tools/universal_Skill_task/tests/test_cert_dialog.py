# -*- coding: utf-8 -*-
import sys
import threading
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from cert_dialog import auto_confirm_cert_dialog


def test_stops_before_sending_any_key_when_already_stopped():
    """A set stop event must prevent keystrokes from reaching page content."""
    stop = threading.Event()
    stop.set()

    started = time.time()
    auto_confirm_cert_dialog(stop_event=stop, deadline_s=10, initial_delay_s=5, interval_s=5)

    assert time.time() - started < 1.0


def test_stops_mid_loop_when_event_is_set():
    stop = threading.Event()
    thread = threading.Thread(
        target=auto_confirm_cert_dialog,
        kwargs={"stop_event": stop, "deadline_s": 30, "initial_delay_s": 0.1, "interval_s": 5},
        daemon=True,
    )
    thread.start()
    stop.set()
    thread.join(timeout=3)

    assert not thread.is_alive()
