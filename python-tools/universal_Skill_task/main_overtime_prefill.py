# -*- coding: utf-8 -*-
"""BPM → EHR → decide → prefill overtime apply (never submit)."""

from __future__ import annotations

import sys
import traceback
from datetime import datetime
from pathlib import Path
from typing import List, Optional

from browser import launch_page
from bpm_login import LoginError, login_bpm
from config import ConfigError, load_config
from ehr_attendance import read_punches_for_day
from ehr_nav import EhrNavError, wait_ehr_home_ready
from ehr_overtime_apply import OvertimeApplyError, prefill_overtime_form
from ehr_overtime_query import read_existing_overtime
from navigate_ehr import NavigateEhrError, open_ehr
from overtime_decision import ALLOW_SUBMIT_OVERTIME, build_decision, format_decision
from overtime_rules import Action, target_yesterday

ROOT = Path(__file__).resolve().parent
ARTIFACTS = ROOT / "artifacts"


def _write_log(text: str) -> Path:
    ARTIFACTS.mkdir(parents=True, exist_ok=True)
    path = ARTIFACTS / f"overtime_decision_{datetime.now().strftime('%Y%m%d_%H%M%S')}.log"
    path.write_text(text + "\n", encoding="utf-8")
    return path


def _screenshot(page, tag: str) -> Path:
    ARTIFACTS.mkdir(parents=True, exist_ok=True)
    path = ARTIFACTS / f"overtime_prefill_{datetime.now().strftime('%Y%m%d_%H%M%S')}_{tag}.png"
    try:
        page.screenshot(path=str(path), full_page=True)
    except Exception:
        page.screenshot(path=str(path))
    return path


def _wait_enter(msg: str) -> None:
    print(msg, flush=True)
    try:
        input()
    except EOFError:
        pass


def _parse_reason(argv: List[str]) -> Optional[str]:
    """Read --reason "..." (or --reason=...) from the command line."""
    for i, arg in enumerate(argv):
        if arg == "--reason" and i + 1 < len(argv):
            return argv[i + 1]
        if arg.startswith("--reason="):
            return arg.split("=", 1)[1]
    return None


def main() -> int:
    reason = _parse_reason(sys.argv[1:])
    if ALLOW_SUBMIT_OVERTIME:
        print("[FAIL] ALLOW_SUBMIT_OVERTIME must stay False in prefill phase")
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
            print(f"[INFO] decision_log={_write_log(text)}")

            if decision.action != Action.APPLY:
                print(f"[INFO] skip prefill because action={decision.action.value}")
                _wait_enter("[INFO] Press Enter to close browser...")
                return 0

            prefill_overtime_form(ehr_page, decision, reason)
            shot = _screenshot(ehr_page, "filled")
            print(f"[OK] prefilled; screenshot={shot}")
            print("[INFO] ALLOW_SUBMIT_OVERTIME=False — did not click submit")
            _wait_enter("[INFO] Review the form, then press Enter to close browser...")
            return 0
        except (LoginError, NavigateEhrError, EhrNavError, OvertimeApplyError) as exc:
            print(f"[FAIL] {exc}")
            try:
                print(f"[INFO] screenshot={_screenshot(ehr_page, 'fail')}")
            except Exception:
                pass
            _wait_enter("[INFO] Press Enter to close browser...")
            return 1
        except Exception as exc:
            print(f"[FAIL] unexpected: {exc}")
            traceback.print_exc()
            try:
                print(f"[INFO] screenshot={_screenshot(ehr_page, 'unexpected')}")
            except Exception:
                pass
            _wait_enter("[INFO] Press Enter to close browser...")
            return 1


if __name__ == "__main__":
    sys.exit(main())
