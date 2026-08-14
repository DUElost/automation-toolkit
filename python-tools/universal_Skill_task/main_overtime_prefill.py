# -*- coding: utf-8 -*-
"""BPM → EHR → decide last 7 days → prefill APPLY days; submit only with --ALLOW."""

from __future__ import annotations

import sys
import traceback
from datetime import datetime
from pathlib import Path
from typing import List, Optional, Tuple

from browser import launch_page
from bpm_login import LoginError, login_bpm
from config import ConfigError, load_config
from ehr_attendance import read_punches_for_day
from ehr_nav import EhrNavError, wait_ehr_home_ready
from ehr_overtime_apply import OvertimeApplyError, prefill_overtime_form, submit_overtime_form
from ehr_overtime_query import read_existing_overtime
from navigate_ehr import NavigateEhrError, open_ehr
from overtime_decision import build_decision, format_decision
from overtime_rules import Action, target_days_last_week

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


def parse_cli_flags(argv: List[str]) -> Tuple[Optional[str], bool]:
    """Return (reason, allow_submit). --ALLOW means consent to click 提交."""
    reason: Optional[str] = None
    allow = False
    i = 0
    while i < len(argv):
        arg = argv[i]
        if arg == "--ALLOW":
            allow = True
        elif arg == "--reason" and i + 1 < len(argv):
            reason = argv[i + 1]
            i += 1
        elif arg.startswith("--reason="):
            reason = arg.split("=", 1)[1]
        i += 1
    return reason, allow


def main() -> int:
    reason, allow_submit = parse_cli_flags(sys.argv[1:])
    if allow_submit:
        print("[WARN] --ALLOW set: will click 提交 after each APPLY prefill", flush=True)

    try:
        cfg = load_config()
    except ConfigError as exc:
        print(f"[FAIL] config: {exc}")
        return 2

    days = target_days_last_week()
    print(
        f"[INFO] target_days(Beijing last 7 excl. today)="
        f"{days[0].isoformat()}..{days[-1].isoformat()} ({len(days)} days)",
        flush=True,
    )

    with launch_page() as (_pw, _browser, context, page):
        ehr_page = page
        try:
            login_bpm(page, cfg)
            print(f"[OK] BPM login url={page.url}")
            ehr_page = open_ehr(page, context)
            print(f"[OK] EHR opened url={ehr_page.url}")
            wait_ehr_home_ready(ehr_page)
            print("[OK] EHR home ready")

            applied = 0
            submitted = 0
            skipped = 0
            for i, target in enumerate(days, start=1):
                print(f"[INFO] === day {i}/{len(days)} {target.isoformat()} ===", flush=True)
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
                    skipped += 1
                    continue

                prefill_overtime_form(ehr_page, decision, reason)
                shot = _screenshot(ehr_page, f"filled_{target.strftime('%Y%m%d')}")
                print(f"[OK] prefilled; screenshot={shot}")
                applied += 1

                if allow_submit:
                    submit_overtime_form(ehr_page)
                    _screenshot(ehr_page, f"submitted_{target.strftime('%Y%m%d')}")
                    saved = read_existing_overtime(ehr_page, target)
                    if saved is None:
                        print(f"[FAIL] {target.isoformat()} not found in 加班查询 after submit")
                        _wait_enter("[INFO] Press Enter to close browser...")
                        return 1
                    print(f"[OK] submitted {target.isoformat()} verified={saved}")
                    submitted += 1
                else:
                    print("[INFO] no --ALLOW — did not click submit")
                    _wait_enter(
                        f"[INFO] Review {target.isoformat()}, then press Enter for next day "
                        f"(or close after last)..."
                    )

            print(f"[INFO] done: applied={applied} submitted={submitted} skipped={skipped}")
            if applied == 0 or allow_submit:
                _wait_enter("[INFO] Press Enter to close browser...")
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
