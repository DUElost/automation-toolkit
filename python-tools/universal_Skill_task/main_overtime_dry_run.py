# -*- coding: utf-8 -*-
"""BPM → EHR → read punches/overtime → decision log only (no submit)."""

from __future__ import annotations

import sys
import time
import traceback
from datetime import datetime
from pathlib import Path

from browser import launch_page
from bpm_login import LoginError, login_bpm
from config import ConfigError, load_config
from ehr_attendance import read_punches_for_day
from ehr_nav import EhrNavError, wait_ehr_home_ready
from ehr_overtime_query import read_existing_overtime
from navigate_ehr import NavigateEhrError, open_ehr
from overtime_decision import ALLOW_SUBMIT_OVERTIME, build_decision, format_decision
from overtime_rules import target_yesterday

ROOT = Path(__file__).resolve().parent
ARTIFACTS = ROOT / "artifacts"


def _write_log(text: str) -> Path:
    ARTIFACTS.mkdir(parents=True, exist_ok=True)
    path = ARTIFACTS / f"overtime_decision_{datetime.now().strftime('%Y%m%d_%H%M%S')}.log"
    path.write_text(text + "\n", encoding="utf-8")
    return path


def _screenshot(page, tag: str) -> Path:
    ARTIFACTS.mkdir(parents=True, exist_ok=True)
    path = ARTIFACTS / f"{datetime.now().strftime('%Y%m%d_%H%M%S')}_{tag}.png"
    try:
        page.screenshot(path=str(path), full_page=True)
    except Exception:
        page.screenshot(path=str(path))
    return path


def main() -> int:
    if ALLOW_SUBMIT_OVERTIME:
        print("[FAIL] ALLOW_SUBMIT_OVERTIME must stay False in dry-run phase")
        return 3

    try:
        cfg = load_config()
    except ConfigError as exc:
        print(f"[FAIL] config: {exc}")
        return 2

    target = target_yesterday()
    print(f"[INFO] target_date(Beijing yesterday)={target.isoformat()}")

    with launch_page() as (_pw, _browser, context, page):
        ehr_page = page
        try:
            login_bpm(page, cfg)
            print(f"[OK] BPM login url={page.url}")
            ehr_page = open_ehr(page, context)
            print(f"[OK] EHR opened url={ehr_page.url}")
            wait_ehr_home_ready(ehr_page)
            print("[OK] EHR home ready")

            punches = read_punches_for_day(ehr_page, target)
            print(f"[OK] punches={punches}")
            existing = read_existing_overtime(ehr_page, target)
            print(f"[OK] existing={existing}")

            decision = build_decision(target, punches, existing)
            text = format_decision(decision)
            print("[DECISION]")
            print(text)
            log_path = _write_log(text)
            print(f"[INFO] decision_log={log_path}")

            print(f"[INFO] keep browser open {cfg.keep_open_seconds}s")
            time.sleep(cfg.keep_open_seconds)
            return 0
        except (LoginError, NavigateEhrError, EhrNavError) as exc:
            print(f"[FAIL] {exc}")
            try:
                print(f"[INFO] screenshot={_screenshot(ehr_page, 'fail')}")
            except Exception:
                pass
            return 1
        except Exception as exc:
            print(f"[FAIL] unexpected: {exc}")
            traceback.print_exc()
            try:
                print(f"[INFO] screenshot={_screenshot(ehr_page, 'unexpected')}")
            except Exception:
                pass
            return 1


if __name__ == "__main__":
    sys.exit(main())
