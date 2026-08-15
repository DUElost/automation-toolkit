# -*- coding: utf-8 -*-
"""BPM → EHR → decide last 7 days → prefill APPLY days; submit only with --ALLOW."""

from __future__ import annotations

import sys
import traceback
from dataclasses import replace
from datetime import datetime
from pathlib import Path
from typing import List, Optional

from account_config import (
    AccountConfig,
    AccountRunResult,
    RunOptions,
    parse_run_options,
    reason_for_account,
    resolve_accounts,
)
from browser import launch_page
from bpm_login import LoginError, login_bpm
from config import AppConfig, ConfigError, load_config
from ehr_attendance import AttendanceReadError, read_punches_for_days
from ehr_nav import EhrNavError, wait_ehr_home_ready
from ehr_overtime_apply import OvertimeApplyError, prefill_overtime_form, submit_overtime_form
from ehr_overtime_query import read_existing_overtime, read_existing_overtime_for_days
from feishu_notify import FeishuNotifyError, notify_account_results, notify_failure
from navigate_ehr import NavigateEhrError, open_ehr
from overtime_decision import Decision, build_decision, format_decision
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


def _wait_enter(msg: str, *, no_prompt: bool) -> None:
    if no_prompt:
        print(f"[INFO] {msg} (skipped: --no-prompt)", flush=True)
        return
    print(msg, flush=True)
    try:
        input()
    except EOFError:
        pass


def _send_feishu_results(cfg: AppConfig, results: List[AccountRunResult]) -> None:
    if not cfg.feishu_webhook_url:
        print("[INFO] FEISHU_WEBHOOK_URL not set; skip Feishu notify", flush=True)
        return
    try:
        notify_account_results(
            cfg.feishu_webhook_url,
            results,
            secret=cfg.feishu_secret,
        )
        print("[OK] Feishu summary sent", flush=True)
    except FeishuNotifyError as exc:
        print(f"[WARN] Feishu notify failed: {exc}", flush=True)


def _send_feishu_failure(cfg: AppConfig, error: str) -> None:
    if not cfg.feishu_webhook_url:
        return
    try:
        notify_failure(
            cfg.feishu_webhook_url,
            error,
            secret=cfg.feishu_secret,
            log_path=str(ARTIFACTS),
        )
        print("[OK] Feishu failure alert sent", flush=True)
    except FeishuNotifyError as exc:
        print(f"[WARN] Feishu failure alert failed: {exc}", flush=True)


def _run_single_account(
    cfg: AppConfig,
    account: AccountConfig,
    reason: Optional[str],
    options: RunOptions,
) -> AccountRunResult:
    result = AccountRunResult(
        account_id=account.account_id,
        username=account.username,
        reason=reason,
    )
    account_cfg = replace(cfg, username=account.username, password=account.password)
    days = target_days_last_week()
    decisions: List[Decision] = []
    submitted_dates: List[str] = []

    print(
        f"[INFO] account={account.account_id} target_days="
        f"{days[0].isoformat()}..{days[-1].isoformat()} ({len(days)} days)",
        flush=True,
    )

    with launch_page() as (_pw, _browser, context, page):
        ehr_page = page
        try:
            login_bpm(page, account_cfg)
            print(f"[OK] [{account.account_id}] BPM login url={page.url}")
            ehr_page = open_ehr(page, context)
            print(f"[OK] [{account.account_id}] EHR opened url={ehr_page.url}")
            wait_ehr_home_ready(ehr_page)
            print(f"[OK] [{account.account_id}] EHR home ready")

            print(f"[INFO] [{account.account_id}] batch read: 我的考勤", flush=True)
            punches_map = read_punches_for_days(ehr_page, days)
            print(f"[INFO] [{account.account_id}] batch read: 加班查询", flush=True)
            existing_map = read_existing_overtime_for_days(ehr_page, days)

            for i, target in enumerate(days, start=1):
                print(
                    f"[INFO] [{account.account_id}] === day {i}/{len(days)} "
                    f"{target.isoformat()} ===",
                    flush=True,
                )
                punches = punches_map[target]
                existing = existing_map[target]
                decision = build_decision(target, punches, existing)
                decisions.append(decision)
                text = format_decision(decision)
                print("[DECISION]")
                print(text)
                print(f"[INFO] decision_log={_write_log(text)}")

                if decision.action != Action.APPLY:
                    continue
                if options.decisions_only:
                    print(f"[INFO] [{account.account_id}] decisions-only: skip prefill")
                    continue

                prefill_overtime_form(ehr_page, decision, reason)
                shot = _screenshot(ehr_page, f"{account.account_id}_filled_{target:%Y%m%d}")
                print(f"[OK] prefilled; screenshot={shot}")

                if not options.allow_submit:
                    print(f"[INFO] [{account.account_id}] no --ALLOW — did not click submit")
                    _wait_enter(
                        f"[INFO] Review {target.isoformat()}, press Enter...",
                        no_prompt=options.no_prompt,
                    )
                    continue

                submit_overtime_form(ehr_page)
                _screenshot(ehr_page, f"{account.account_id}_submitted_{target:%Y%m%d}")
                saved = read_existing_overtime(ehr_page, target)
                if saved is None:
                    msg = f"{target.isoformat()} not found in 加班查询 after submit"
                    result.decisions = decisions
                    result.submitted_dates = submitted_dates
                    result.run_success = False
                    result.error_message = msg
                    print(f"[FAIL] [{account.account_id}] {msg}")
                    return result
                print(f"[OK] submitted {target.isoformat()} verified={saved}")
                submitted_dates.append(target.isoformat())

            result.decisions = decisions
            result.submitted_dates = submitted_dates
            print(f"[OK] [{account.account_id}] finished; browser closed", flush=True)
            return result
        except (
            LoginError,
            NavigateEhrError,
            EhrNavError,
            OvertimeApplyError,
            AttendanceReadError,
        ) as exc:
            print(f"[FAIL] [{account.account_id}] {exc}")
            try:
                print(f"[INFO] screenshot={_screenshot(ehr_page, f'{account.account_id}_fail')}")
            except Exception:
                pass
            result.decisions = decisions
            result.submitted_dates = submitted_dates
            result.run_success = False
            result.error_message = str(exc)
            return result
        except Exception as exc:
            print(f"[FAIL] [{account.account_id}] unexpected: {exc}")
            traceback.print_exc()
            try:
                print(
                    f"[INFO] screenshot={_screenshot(ehr_page, f'{account.account_id}_unexpected')}"
                )
            except Exception:
                pass
            result.decisions = decisions
            result.submitted_dates = submitted_dates
            result.run_success = False
            result.error_message = str(exc)
            return result


def main() -> int:
    options = parse_run_options(sys.argv[1:])
    if options.allow_submit:
        print("[WARN] --ALLOW set: will click 提交 after each APPLY prefill", flush=True)
    if options.decisions_only:
        print("[INFO] --decisions-only: read/decide/notify only, no prefill", flush=True)

    try:
        cfg = load_config()
        accounts = resolve_accounts(cfg, options)
    except ConfigError as exc:
        print(f"[FAIL] config: {exc}")
        return 2

    results: List[AccountRunResult] = []
    for index, account in enumerate(accounts):
        if index > 0:
            print("[INFO] previous account finished; starting fresh browser session", flush=True)
        reason = reason_for_account(options, account.account_id)
        print(f"[INFO] ===== account {account.account_id} ({account.username}) =====", flush=True)
        result = _run_single_account(cfg, account, reason, options)
        results.append(result)

    _send_feishu_results(cfg, results)
    if not results:
        _send_feishu_failure(cfg, "no accounts configured")
        return 2

    if all(item.run_success for item in results):
        return 0
    return 1


if __name__ == "__main__":
    sys.exit(main())
