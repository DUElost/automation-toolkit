# -*- coding: utf-8 -*-
"""Standalone backup tool: revoke specific EHR overtime applications.

Not part of the daily full workflow. Example:

  python main_overtime_cancel.py --no-prompt --accounts-file accounts.yaml ^
    --date 2026-09-20 --start 09:00 --end 20:00

  # actually revoke:
  python main_overtime_cancel.py --ALLOW --no-prompt --accounts-file accounts.yaml ^
    --date 2026-09-20 --start 09:00 --end 20:00
"""

from __future__ import annotations

import sys
import traceback
from dataclasses import dataclass, replace
from datetime import date, datetime, time
from pathlib import Path
from typing import List, Optional, Sequence

from account_config import AccountConfig, parse_run_options, resolve_accounts
from browser import launch_page
from bpm_login import LoginError, login_bpm
from config import AppConfig, ConfigError, load_config
from ehr_nav import EhrNavError, wait_ehr_home_ready
from ehr_overtime_cancel import (
    OvertimeCancelError,
    OvertimeCancelTarget,
    cancel_matching_overtime,
)
from navigate_ehr import NavigateEhrError, open_ehr

ROOT = Path(__file__).resolve().parent
ARTIFACTS = ROOT / "artifacts"


@dataclass(frozen=True)
class CancelCliOptions:
    allow: bool
    no_prompt: bool
    accounts_file: Optional[str]
    account_ids: tuple[str, ...]
    targets: tuple[OvertimeCancelTarget, ...]


def _parse_date(text: str) -> date:
    return date.fromisoformat(text.strip().replace("/", "-")[:10])


def _parse_time(text: str) -> time:
    parts = text.strip().split(":")
    if len(parts) != 2:
        raise ValueError(f"invalid time: {text!r}")
    return time(int(parts[0]), int(parts[1]))


def parse_cancel_options(argv: Sequence[str]) -> CancelCliOptions:
    allow = False
    no_prompt = False
    accounts_file: Optional[str] = None
    account_ids: List[str] = []
    dates: List[date] = []
    starts: List[time] = []
    ends: List[Optional[time]] = []
    i = 0
    while i < len(argv):
        arg = argv[i]
        if arg == "--ALLOW":
            allow = True
        elif arg == "--no-prompt":
            no_prompt = True
        elif arg == "--accounts-file" and i + 1 < len(argv):
            accounts_file = argv[i + 1]
            i += 1
        elif arg.startswith("--accounts-file="):
            accounts_file = arg.split("=", 1)[1]
        elif arg == "--account" and i + 1 < len(argv):
            account_ids.append(argv[i + 1].strip())
            i += 1
        elif arg.startswith("--account="):
            account_ids.append(arg.split("=", 1)[1].strip())
        elif arg == "--date" and i + 1 < len(argv):
            dates.append(_parse_date(argv[i + 1]))
            i += 1
        elif arg.startswith("--date="):
            dates.append(_parse_date(arg.split("=", 1)[1]))
        elif arg == "--start" and i + 1 < len(argv):
            starts.append(_parse_time(argv[i + 1]))
            i += 1
        elif arg.startswith("--start="):
            starts.append(_parse_time(arg.split("=", 1)[1]))
        elif arg == "--end" and i + 1 < len(argv):
            ends.append(_parse_time(argv[i + 1]))
            i += 1
        elif arg.startswith("--end="):
            ends.append(_parse_time(arg.split("=", 1)[1]))
        i += 1

    if not dates:
        raise ConfigError("at least one --date YYYY-MM-DD is required")
    if not starts:
        # Default to the known bad makeup-day pattern.
        starts = [time(9, 0)] * len(dates)
    if len(starts) == 1 and len(dates) > 1:
        starts = starts * len(dates)
    if len(starts) != len(dates):
        raise ConfigError("--date and --start counts must match (or pass one --start)")

    if not ends:
        ends = [None] * len(dates)
    elif len(ends) == 1 and len(dates) > 1:
        ends = ends * len(dates)
    elif len(ends) != len(dates):
        raise ConfigError("--end count must match --date (or pass one --end)")

    targets = tuple(
        OvertimeCancelTarget(target_date=d, start=s, end=e)
        for d, s, e in zip(dates, starts, ends)
    )
    return CancelCliOptions(
        allow=allow,
        no_prompt=no_prompt,
        accounts_file=accounts_file,
        account_ids=tuple(a for a in account_ids if a),
        targets=targets,
    )


def _screenshot(page, tag: str) -> Path:
    ARTIFACTS.mkdir(parents=True, exist_ok=True)
    path = ARTIFACTS / f"overtime_cancel_{datetime.now().strftime('%Y%m%d_%H%M%S')}_{tag}.png"
    try:
        page.screenshot(path=str(path), full_page=True)
    except Exception:
        page.screenshot(path=str(path))
    return path


def _run_account(
    cfg: AppConfig,
    account: AccountConfig,
    options: CancelCliOptions,
) -> bool:
    account_cfg = replace(cfg, username=account.username, password=account.password)
    print(f"[INFO] ===== cancel account {account.account_id} ({account.username}) =====", flush=True)
    ok = True
    with launch_page() as (_pw, _browser, context, page):
        ehr = page
        try:
            login_bpm(page, account_cfg)
            ehr = open_ehr(page, context)
            wait_ehr_home_ready(ehr)
            matched = cancel_matching_overtime(
                ehr,
                options.targets,
                allow=options.allow,
            )
            if not matched:
                print(f"[WARN] [{account.account_id}] nothing matched", flush=True)
            _screenshot(ehr, f"{account.account_id}_done")
        except (
            LoginError,
            NavigateEhrError,
            EhrNavError,
            OvertimeCancelError,
        ) as exc:
            ok = False
            print(f"[FAIL] [{account.account_id}] {exc}", flush=True)
            try:
                print(f"[INFO] screenshot={_screenshot(ehr, f'{account.account_id}_fail')}")
            except Exception:
                pass
        except Exception as exc:
            ok = False
            print(f"[FAIL] [{account.account_id}] unexpected: {exc}", flush=True)
            traceback.print_exc()
            try:
                print(f"[INFO] screenshot={_screenshot(ehr, f'{account.account_id}_unexpected')}")
            except Exception:
                pass
    return ok


def main(argv: Optional[Sequence[str]] = None) -> int:
    args = list(sys.argv[1:] if argv is None else argv)
    try:
        options = parse_cancel_options(args)
        # Reuse accounts-file parsing via RunOptions shim.
        run_opts = parse_run_options(
            ["--accounts-file", options.accounts_file] if options.accounts_file else []
        )
        cfg = load_config()
        accounts = resolve_accounts(cfg, run_opts)
        if options.account_ids:
            wanted = set(options.account_ids)
            accounts = [a for a in accounts if a.account_id in wanted]
            missing = wanted - {a.account_id for a in accounts}
            if missing:
                raise ConfigError(f"unknown --account ids: {sorted(missing)}")
        if not accounts:
            raise ConfigError("no accounts to run")
    except (ConfigError, ValueError) as exc:
        print(f"[FAIL] {exc}", flush=True)
        return 2

    if options.allow:
        print("[WARN] --ALLOW set: will click 撤销申请 for matched rows", flush=True)
    else:
        print("[INFO] dry-run mode (no --ALLOW): list matches only", flush=True)

    all_ok = True
    for account in accounts:
        if not _run_account(cfg, account, options):
            all_ok = False
    return 0 if all_ok else 1


if __name__ == "__main__":
    raise SystemExit(main())
