# -*- coding: utf-8 -*-
import os
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[1]
import sys

sys.path.insert(0, str(ROOT))

from config import load_config, ConfigError


def test_load_config_requires_credentials(monkeypatch, tmp_path):
    monkeypatch.chdir(tmp_path)
    monkeypatch.delenv("BPM_USERNAME", raising=False)
    monkeypatch.delenv("BPM_PASSWORD", raising=False)
    with pytest.raises(ConfigError):
        load_config(env_file=tmp_path / ".env")


def test_load_config_from_env(monkeypatch, tmp_path):
    monkeypatch.chdir(tmp_path)
    monkeypatch.setenv("BPM_URL", "https://bpm.example.com")
    monkeypatch.setenv("BPM_USERNAME", "u@tinno.com")
    monkeypatch.setenv("BPM_PASSWORD", "secret")
    monkeypatch.setenv("KEEP_OPEN_SECONDS", "20")
    cfg = load_config(env_file=tmp_path / ".env")
    assert cfg.bpm_url == "https://bpm.example.com"
    assert cfg.username == "u@tinno.com"
    assert cfg.password == "secret"
    assert cfg.keep_open_seconds == 20
