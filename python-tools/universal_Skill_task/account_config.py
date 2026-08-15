# -*- coding: utf-8 -*-
"""Multi-account configuration for EHR overtime automation."""

from __future__ import annotations

from dataclasses import dataclass, field
from pathlib import Path
from typing import Dict, List, Optional, Sequence, Tuple

import yaml

from config import AppConfig, ConfigError


@dataclass(frozen=True)
class AccountConfig:
    account_id: str
    username: str
    password: str


@dataclass
class AccountRunResult:
    account_id: str
    username: str
    reason: Optional[str] = None
    decisions: List = field(default_factory=list)
    submitted_dates: List[str] = field(default_factory=list)
    run_success: bool = True
    error_message: Optional[str] = None

    @property
    def submitted_count(self) -> int:
        return len(self.submitted_dates)


@dataclass(frozen=True)
class RunOptions:
    allow_submit: bool = False
    no_prompt: bool = False
    decisions_only: bool = False
    global_reason: Optional[str] = None
    reason_by_id: Tuple[Tuple[str, str], ...] = ()
    accounts_file: Optional[str] = None


def parse_run_options(argv: Sequence[str]) -> RunOptions:
    allow = False
    no_prompt = False
    decisions_only = False
    global_reason: Optional[str] = None
    reason_by_id: Dict[str, str] = {}
    accounts_file: Optional[str] = None
    i = 0
    while i < len(argv):
        arg = argv[i]
        if arg == "--ALLOW":
            allow = True
        elif arg == "--no-prompt":
            no_prompt = True
        elif arg == "--decisions-only":
            decisions_only = True
        elif arg == "--accounts-file" and i + 1 < len(argv):
            accounts_file = argv[i + 1]
            i += 1
        elif arg.startswith("--accounts-file="):
            accounts_file = arg.split("=", 1)[1]
        elif arg == "--reason" and i + 1 < len(argv):
            global_reason = _apply_reason_arg(argv[i + 1], reason_by_id, global_reason)
            i += 1
        elif arg.startswith("--reason="):
            global_reason = _apply_reason_arg(arg.split("=", 1)[1], reason_by_id, global_reason)
        i += 1
    return RunOptions(
        allow_submit=allow,
        no_prompt=no_prompt,
        decisions_only=decisions_only,
        global_reason=global_reason,
        reason_by_id=tuple(reason_by_id.items()),
        accounts_file=accounts_file,
    )


def _apply_reason_arg(
    value: str,
    reason_by_id: Dict[str, str],
    global_reason: Optional[str],
) -> Optional[str]:
    text = value.strip()
    if ":" in text:
        account_id, reason = text.split(":", 1)
        account_id = account_id.strip()
        reason = reason.strip().strip('"').strip("'")
        if account_id:
            reason_by_id[account_id] = reason
        return global_reason
    return text.strip('"').strip("'")


def load_accounts_from_yaml(path: Path) -> List[AccountConfig]:
    if not path.is_file():
        raise ConfigError(f"accounts file not found: {path}")
    data = yaml.safe_load(path.read_text(encoding="utf-8"))
    if not isinstance(data, dict) or "accounts" not in data:
        raise ConfigError("accounts file must contain top-level 'accounts' list")
    raw_accounts = data["accounts"]
    if not isinstance(raw_accounts, list) or not raw_accounts:
        raise ConfigError("accounts list is empty")

    accounts: List[AccountConfig] = []
    seen: set[str] = set()
    for item in raw_accounts:
        if not isinstance(item, dict):
            raise ConfigError("each account entry must be a mapping")
        account_id = str(item.get("id") or "").strip()
        username = str(item.get("username") or "").strip()
        password = str(item.get("password") or "")
        if not account_id or not username or not password:
            raise ConfigError("account requires id, username, and password")
        if account_id in seen:
            raise ConfigError(f"duplicate account id: {account_id}")
        seen.add(account_id)
        accounts.append(AccountConfig(account_id=account_id, username=username, password=password))
    return accounts


def resolve_accounts(cfg: AppConfig, options: RunOptions) -> List[AccountConfig]:
    if options.accounts_file:
        return load_accounts_from_yaml(Path(options.accounts_file))
    if not cfg.username or not cfg.password:
        raise ConfigError("BPM_USERNAME and BPM_PASSWORD are required when --accounts-file is not set")
    return [AccountConfig(account_id=cfg.username, username=cfg.username, password=cfg.password)]


def reason_for_account(options: RunOptions, account_id: str) -> Optional[str]:
    mapping = dict(options.reason_by_id)
    if account_id in mapping:
        return mapping[account_id]
    return options.global_reason
