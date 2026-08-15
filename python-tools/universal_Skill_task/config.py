# -*- coding: utf-8 -*-
"""Load BPM automation settings from environment / .env."""

from __future__ import annotations

import os
from dataclasses import dataclass
from pathlib import Path
from typing import Optional, Union

from dotenv import load_dotenv

PathLike = Union[str, Path]


class ConfigError(ValueError):
    """Invalid or missing configuration."""


@dataclass(frozen=True)
class AppConfig:
    bpm_url: str
    username: str
    password: str
    keep_open_seconds: int
    feishu_webhook_url: Optional[str] = None
    feishu_secret: Optional[str] = None


def load_config(env_file: Optional[PathLike] = None) -> AppConfig:
    """Load config; prefer process env, optionally load dotenv file first."""
    path = Path(env_file) if env_file is not None else Path(__file__).resolve().parent / ".env"
    if path.is_file():
        load_dotenv(path, override=False)

    bpm_url = (os.getenv("BPM_URL") or "https://bpm.tinno.com").strip().rstrip("/")
    username = (os.getenv("BPM_USERNAME") or "").strip()
    password = os.getenv("BPM_PASSWORD") or ""
    keep_raw = (os.getenv("KEEP_OPEN_SECONDS") or "15").strip()
    feishu_webhook_url = (os.getenv("FEISHU_WEBHOOK_URL") or "").strip() or None
    feishu_secret = (os.getenv("FEISHU_SECRET") or "").strip() or None

    if not username or not password:
        raise ConfigError("BPM_USERNAME and BPM_PASSWORD are required (set in .env or environment).")

    try:
        keep_open_seconds = int(keep_raw)
    except ValueError as exc:
        raise ConfigError("KEEP_OPEN_SECONDS must be an integer") from exc

    return AppConfig(
        bpm_url=bpm_url,
        username=username,
        password=password,
        keep_open_seconds=keep_open_seconds,
        feishu_webhook_url=feishu_webhook_url,
        feishu_secret=feishu_secret,
    )
