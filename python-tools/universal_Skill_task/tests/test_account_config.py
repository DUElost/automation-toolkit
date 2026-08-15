# -*- coding: utf-8 -*-
"""Tests for multi-account configuration."""

import sys
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from account_config import (
    load_accounts_from_yaml,
    parse_run_options,
    reason_for_account,
    resolve_accounts,
)
from config import AppConfig, ConfigError


def test_parse_run_options_reason_per_account():
    opts = parse_run_options([
        "--ALLOW",
        "--accounts-file", "accounts.yaml",
        "--reason", 'rin:"项目A挂测"',
        "--reason", "zhangsan:项目B挂测",
    ])
    assert opts.allow_submit is True
    assert opts.accounts_file == "accounts.yaml"
    assert dict(opts.reason_by_id) == {
        "rin": "项目A挂测",
        "zhangsan": "项目B挂测",
    }


def test_parse_run_options_global_reason():
    opts = parse_run_options(["--reason", "统一事由"])
    assert opts.global_reason == "统一事由"


def test_load_accounts_from_yaml(tmp_path):
    path = tmp_path / "accounts.yaml"
    path.write_text(
        "accounts:\n"
        "  - id: rin\n"
        "    username: a@tinno.com\n"
        "    password: secret\n",
        encoding="utf-8",
    )
    accounts = load_accounts_from_yaml(path)
    assert len(accounts) == 1
    assert accounts[0].account_id == "rin"
    assert accounts[0].username == "a@tinno.com"


def test_load_accounts_allows_same_username_different_ids(tmp_path):
    path = tmp_path / "accounts.yaml"
    path.write_text(
        "accounts:\n"
        "  - id: account1\n"
        "    username: a@tinno.com\n"
        "    password: secret\n"
        "  - id: account2\n"
        "    username: a@tinno.com\n"
        "    password: secret\n",
        encoding="utf-8",
    )
    accounts = load_accounts_from_yaml(path)
    assert len(accounts) == 2
    assert accounts[0].account_id == "account1"
    assert accounts[1].account_id == "account2"
    assert accounts[0].username == accounts[1].username


def test_resolve_accounts_default_from_app_config():
    cfg = AppConfig(
        bpm_url="https://bpm.tinno.com",
        username="u@tinno.com",
        password="pw",
        keep_open_seconds=15,
    )
    opts = parse_run_options([])
    accounts = resolve_accounts(cfg, opts)
    assert len(accounts) == 1
    assert accounts[0].account_id == "u@tinno.com"
    assert accounts[0].username == "u@tinno.com"


def test_reason_for_account_prefers_per_id_mapping():
    opts = parse_run_options(["--reason", "全局", "--reason", "rin:专用"])
    assert reason_for_account(opts, "rin") == "专用"
    assert reason_for_account(opts, "other") == "全局"
