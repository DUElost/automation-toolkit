# -*- coding: utf-8 -*-
"""BPM login → open EHR (feasibility check)."""

from __future__ import annotations

import sys
import time
import traceback
from datetime import datetime
from pathlib import Path

from browser import launch_page
from bpm_login import LoginError, login_bpm
from config import ConfigError, load_config
from navigate_ehr import NavigateEhrError, open_ehr

ROOT = Path(__file__).resolve().parent
ARTIFACTS = ROOT / "artifacts"


def _screenshot(page, tag: str) -> Path:
    ARTIFACTS.mkdir(parents=True, exist_ok=True)
    path = ARTIFACTS / f"{datetime.now().strftime('%Y%m%d_%H%M%S')}_{tag}.png"
    try:
        page.screenshot(path=str(path), full_page=True)
    except Exception:
        page.screenshot(path=str(path))
    return path


def main() -> int:
    try:
        cfg = load_config()
    except ConfigError as exc:
        print(f"[FAIL] config: {exc}")
        return 2

    with launch_page() as (_pw, _browser, context, page):
        try:
            print(f"[INFO] open {cfg.bpm_url}")
            login_bpm(page, cfg)
            print(f"[OK] BPM login success url={page.url}")

            ehr_page = open_ehr(page, context)
            print(f"[OK] EHR opened url={ehr_page.url} title={ehr_page.title()}")
            print(f"[INFO] keep browser open {cfg.keep_open_seconds}s")
            time.sleep(cfg.keep_open_seconds)
            return 0
        except (LoginError, NavigateEhrError) as exc:
            print(f"[FAIL] {exc}")
            try:
                shot = _screenshot(page, "fail")
                print(f"[INFO] screenshot={shot}")
                print(f"[INFO] current_url={page.url}")
            except Exception:
                pass
            return 1
        except Exception as exc:
            print(f"[FAIL] unexpected: {exc}")
            traceback.print_exc()
            try:
                shot = _screenshot(page, "unexpected")
                print(f"[INFO] screenshot={shot}")
            except Exception:
                pass
            return 1


if __name__ == "__main__":
    sys.exit(main())
