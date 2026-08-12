# BPM 登录并进入 EHR Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 在 `python-tools/universal_Skill_task` 落地 Playwright 脚本：账号密码登录 `https://bpm.tinno.com`，在首页点击 EHR 入口并经 SSO 进入 EHR，以验证后续自动化可行性。

**Architecture:** 薄模块拆分——`config` 读环境变量、`browser` 启动有界面 Chromium、`bpm_login` 完成登录、`navigate_ehr` 点击 EHR；`main` 串联并在失败时截图到 `artifacts/`。选择器集中在登录/导航模块，便于按实测 DOM 微调。

**Tech Stack:** Python 3.8+、playwright、python-dotenv、pytest（仅测 config）

**Spec:** `docs/superpowers/specs/2026-08-12-bpm-ehr-login-design.md`

---

## File Structure

| Path | Responsibility |
|------|----------------|
| `python-tools/universal_Skill_task/.gitignore` | 忽略 `.env`、`artifacts/`、缓存 |
| `python-tools/universal_Skill_task/.env.example` | 凭据占位 |
| `python-tools/universal_Skill_task/requirements.txt` | playwright、python-dotenv、pytest |
| `python-tools/universal_Skill_task/config.py` | 加载 `BPM_*` / `KEEP_OPEN_SECONDS` |
| `python-tools/universal_Skill_task/browser.py` | 启动有界面 Chromium，返回 browser/context/page |
| `python-tools/universal_Skill_task/bpm_login.py` | 打开登录页、填账号密码、等待首页 |
| `python-tools/universal_Skill_task/navigate_ehr.py` | 首页点击 EHR，等待进入 EHR（含新标签页） |
| `python-tools/universal_Skill_task/main.py` | 串联流程、截图、保持窗口 |
| `python-tools/universal_Skill_task/tests/test_config.py` | config 单测 |
| `python-tools/universal_Skill_task/artifacts/` | 失败截图（gitignore） |
| `python-tools/universal_Skill_task/README.md` | 安装与运行说明 |

工作目录约定：命令在 `python-tools/universal_Skill_task` 下执行。

**选择器约定：** Task 4/5 先用「可运行的保守选择器」；Task 7 对真实站点跑通后，若失败则只改 `bpm_login.py` / `navigate_ehr.py` 内选择器常量，不改流程。

---

### Task 1: 脚手架

**Files:**
- Create: `python-tools/universal_Skill_task/.gitignore`
- Create: `python-tools/universal_Skill_task/.env.example`
- Create: `python-tools/universal_Skill_task/requirements.txt`
- Create: `python-tools/universal_Skill_task/artifacts/.gitkeep`

- [ ] **Step 1: 写 `.gitignore`**

```gitignore
.env
artifacts/*
!artifacts/.gitkeep
__pycache__/
*.pyc
.pytest_cache/
.venv/
venv/
*.log
```

- [ ] **Step 2: 写 `.env.example`**

```text
BPM_URL=https://bpm.tinno.com
BPM_USERNAME=
BPM_PASSWORD=
KEEP_OPEN_SECONDS=15
```

- [ ] **Step 3: 写 `requirements.txt`**

```text
playwright>=1.40.0
python-dotenv>=1.0.0
pytest>=7.0.0
```

- [ ] **Step 4: 创建 `artifacts/.gitkeep`（空文件）**

- [ ] **Step 5: Commit**

```bash
git add python-tools/universal_Skill_task/.gitignore python-tools/universal_Skill_task/.env.example python-tools/universal_Skill_task/requirements.txt python-tools/universal_Skill_task/artifacts/.gitkeep
git commit -m "chore(universal_Skill_task): scaffold BPM/EHR automation project"
```

---

### Task 2: config（TDD）

**Files:**
- Create: `python-tools/universal_Skill_task/config.py`
- Create: `python-tools/universal_Skill_task/tests/test_config.py`

- [ ] **Step 1: 写失败测试**

```python
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
```

- [ ] **Step 2: 运行测试确认失败**

Run: `cd python-tools/universal_Skill_task && pip install -r requirements.txt -q && pytest tests/test_config.py -v`

Expected: FAIL（`config` 未定义或导入失败）

- [ ] **Step 3: 写 `config.py`**

```python
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


def load_config(env_file: Optional[PathLike] = None) -> AppConfig:
    """Load config; prefer process env, optionally load dotenv file first."""
    path = Path(env_file) if env_file is not None else Path(__file__).resolve().parent / ".env"
    if path.is_file():
        load_dotenv(path, override=False)

    bpm_url = (os.getenv("BPM_URL") or "https://bpm.tinno.com").strip().rstrip("/")
    username = (os.getenv("BPM_USERNAME") or "").strip()
    password = os.getenv("BPM_PASSWORD") or ""
    keep_raw = (os.getenv("KEEP_OPEN_SECONDS") or "15").strip()

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
    )
```

- [ ] **Step 4: 运行测试确认通过**

Run: `cd python-tools/universal_Skill_task && pytest tests/test_config.py -v`

Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add python-tools/universal_Skill_task/config.py python-tools/universal_Skill_task/tests/test_config.py
git commit -m "feat(universal_Skill_task): add config loader for BPM credentials"
```

---

### Task 3: browser 启动

**Files:**
- Create: `python-tools/universal_Skill_task/browser.py`

- [ ] **Step 1: 写 `browser.py`**

```python
# -*- coding: utf-8 -*-
"""Launch headed Chromium for BPM automation."""

from __future__ import annotations

from contextlib import contextmanager
from typing import Iterator, Tuple

from playwright.sync_api import Browser, BrowserContext, Page, Playwright, sync_playwright


DEFAULT_TIMEOUT_MS = 30_000


@contextmanager
def launch_page(timeout_ms: int = DEFAULT_TIMEOUT_MS) -> Iterator[Tuple[Playwright, Browser, BrowserContext, Page]]:
    """Yield playwright, browser, context, page; always close on exit."""
    with sync_playwright() as playwright:
        browser = playwright.chromium.launch(headless=False)
        context = browser.new_context(viewport={"width": 1440, "height": 900})
        context.set_default_timeout(timeout_ms)
        page = context.new_page()
        try:
            yield playwright, browser, context, page
        finally:
            context.close()
            browser.close()
```

- [ ] **Step 2: 安装浏览器内核**

Run: `cd python-tools/universal_Skill_task && python -m playwright install chromium`

Expected: 安装成功（或已存在）

- [ ] **Step 3: Commit**

```bash
git add python-tools/universal_Skill_task/browser.py
git commit -m "feat(universal_Skill_task): add headed Chromium launcher"
```

---

### Task 4: BPM 登录

**Files:**
- Create: `python-tools/universal_Skill_task/bpm_login.py`

说明：以下选择器为常见门户表单的保守写法。若 Task 7 实测不匹配，只改本文件顶部常量。

- [ ] **Step 1: 写 `bpm_login.py`**

```python
# -*- coding: utf-8 -*-
"""Password login to BPM portal."""

from __future__ import annotations

from playwright.sync_api import Page, TimeoutError as PlaywrightTimeoutError

from config import AppConfig

# --- selectors (adjust after live probe) ---
USERNAME_SELECTORS = [
    'input[name="username"]',
    'input[name="account"]',
    'input[type="text"]',
    'input[placeholder*="账号"]',
    'input[placeholder*="用户"]',
    'input[placeholder*="邮箱"]',
    'input[placeholder*="手机"]',
]
PASSWORD_SELECTORS = [
    'input[name="password"]',
    'input[type="password"]',
]
SUBMIT_SELECTORS = [
    'button[type="submit"]',
    'input[type="submit"]',
    'button:has-text("登录")',
    'button:has-text("登 录")',
    'a:has-text("登录")',
]


class LoginError(RuntimeError):
    """BPM login failed."""


def _first_visible(page: Page, selectors: list[str]):
    for sel in selectors:
        loc = page.locator(sel).first
        try:
            if loc.count() and loc.is_visible():
                return loc
        except Exception:
            continue
    return None


def login_bpm(page: Page, cfg: AppConfig) -> None:
    """Open BPM URL, fill credentials, submit, wait until not on bare login form."""
    page.goto(cfg.bpm_url, wait_until="domcontentloaded")
    page.wait_for_timeout(1000)

    user = _first_visible(page, USERNAME_SELECTORS)
    pwd = _first_visible(page, PASSWORD_SELECTORS)
    if user is None or pwd is None:
        raise LoginError(
            "Login form not found (username/password). "
            "Possible captcha/SSO-only page — needs manual check."
        )

    user.fill(cfg.username)
    pwd.fill(cfg.password)

    submit = _first_visible(page, SUBMIT_SELECTORS)
    if submit is None:
        pwd.press("Enter")
    else:
        submit.click()

    try:
        # Leave login: password field should disappear or URL change meaningfully.
        page.wait_for_function(
            """() => {
              const pwd = document.querySelector('input[type="password"]');
              const stillLogin = pwd && pwd.offsetParent !== null;
              return !stillLogin;
            }""",
            timeout=45_000,
        )
    except PlaywrightTimeoutError as exc:
        body = ""
        try:
            body = page.inner_text("body")[:500]
        except Exception:
            pass
        hint = ""
        if any(k in body for k in ("验证码", "滑块", "二次", "扫码", "短信")):
            hint = " Possible captcha/2FA — manual intervention required."
        raise LoginError(f"Login did not complete within timeout.{hint} url={page.url}") from exc
```

- [ ] **Step 2: Commit**

```bash
git add python-tools/universal_Skill_task/bpm_login.py
git commit -m "feat(universal_Skill_task): add BPM password login helper"
```

---

### Task 5: 点击 EHR 入口

**Files:**
- Create: `python-tools/universal_Skill_task/navigate_ehr.py`

- [ ] **Step 1: 写 `navigate_ehr.py`**

```python
# -*- coding: utf-8 -*-
"""Navigate from BPM home to EHR via portal tile."""

from __future__ import annotations

from playwright.sync_api import BrowserContext, Page, TimeoutError as PlaywrightTimeoutError

# --- selectors (adjust after live probe) ---
EHR_CLICK_SELECTORS = [
    'text=EHR',
    'a:has-text("EHR")',
    'div:has-text("EHR")',
    '[title*="EHR"]',
    '[aria-label*="EHR"]',
]


class NavigateEhrError(RuntimeError):
    """Failed to open EHR from BPM home."""


def _find_ehr_locator(page: Page):
    for sel in EHR_CLICK_SELECTORS:
        loc = page.locator(sel).first
        try:
            if loc.count() and loc.is_visible():
                return loc
        except Exception:
            continue
    return None


def _looks_like_ehr(url: str, title: str) -> bool:
    blob = f"{url} {title}".lower()
    return any(k in blob for k in ("ehr", "hr", "human", "人事", "人力"))


def open_ehr(page: Page, context: BrowserContext) -> Page:
    """Click EHR on BPM home; return the page that shows EHR (may be a new tab)."""
    page.wait_for_timeout(1500)
    target = _find_ehr_locator(page)
    if target is None:
        raise NavigateEhrError(f"EHR entry not found on BPM home. url={page.url}")

    try:
        with context.expect_page(timeout=5_000) as new_page_info:
            target.click()
        ehr_page = new_page_info.value
        ehr_page.wait_for_load_state("domcontentloaded")
    except PlaywrightTimeoutError:
        # Same-tab navigation
        try:
            page.wait_for_load_state("domcontentloaded", timeout=30_000)
        except PlaywrightTimeoutError:
            pass
        ehr_page = page

    try:
        ehr_page.wait_for_timeout(2000)
        if not _looks_like_ehr(ehr_page.url, ehr_page.title()):
            # Soft wait: allow SPA redirect
            ehr_page.wait_for_timeout(3000)
        if not _looks_like_ehr(ehr_page.url, ehr_page.title()):
            raise NavigateEhrError(
                f"Opened a page but it does not look like EHR. url={ehr_page.url} title={ehr_page.title()}"
            )
    except NavigateEhrError:
        raise
    except Exception as exc:
        raise NavigateEhrError(f"EHR page check failed: {exc}") from exc

    return ehr_page
```

- [ ] **Step 2: Commit**

```bash
git add python-tools/universal_Skill_task/navigate_ehr.py
git commit -m "feat(universal_Skill_task): add BPM home to EHR navigation"
```

---

### Task 6: main 串联 + README

**Files:**
- Create: `python-tools/universal_Skill_task/main.py`
- Create: `python-tools/universal_Skill_task/README.md`

- [ ] **Step 1: 写 `main.py`**

```python
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
```

- [ ] **Step 2: 写 `README.md`**

```markdown
# universal_Skill_task — BPM → EHR 可行性脚本

用 Playwright（有界面）登录 [BPM](https://bpm.tinno.com)，在首页点击 EHR，经 SSO 进入 EHR。

## 准备

```powershell
cd python-tools\universal_Skill_task
pip install -r requirements.txt
python -m playwright install chromium
copy .env.example .env
# 编辑 .env，填写 BPM_USERNAME / BPM_PASSWORD
```

## 运行

```powershell
python main.py
```

成功时控制台输出 `[OK] BPM login success` 与 `[OK] EHR opened`；失败时在 `artifacts/` 留截图。

## 安全

- 真实密码只放本地 `.env`，勿提交 git
- 本仓库 `.gitignore` 已忽略 `.env` 与 `artifacts/*`
```

- [ ] **Step 3: Commit**

```bash
git add python-tools/universal_Skill_task/main.py python-tools/universal_Skill_task/README.md
git commit -m "feat(universal_Skill_task): wire BPM login to EHR entrypoint"
```

---

### Task 7: 本地可行性实测与选择器微调

**Files:**
- Create (local only): `python-tools/universal_Skill_task/.env`
- Possibly modify: `python-tools/universal_Skill_task/bpm_login.py`
- Possibly modify: `python-tools/universal_Skill_task/navigate_ehr.py`

- [ ] **Step 1: 写入本地 `.env`（勿 git add）**

由执行者用用户提供的账号写入（不要打印密码到日志）：

```text
BPM_URL=https://bpm.tinno.com
BPM_USERNAME=dai.lv@tinno.com
BPM_PASSWORD=<user-provided>
KEEP_OPEN_SECONDS=15
```

- [ ] **Step 2: 运行主流程**

Run: `cd python-tools/universal_Skill_task && python main.py`

Expected（理想）:
```text
[OK] BPM login success ...
[OK] EHR opened ...
```

- [ ] **Step 3: 若失败 —— 根据 `artifacts/*.png` 与当前 URL 微调选择器**

只改 `bpm_login.py` / `navigate_ehr.py` 顶部选择器列表或等待条件；再重复 Step 2，直到成功或确认阻塞点（验证码/二次验证/内网不通）。

- [ ] **Step 4: 回归 config 单测**

Run: `pytest tests/test_config.py -v`

Expected: PASS

- [ ] **Step 5: Commit（仅代码微调，绝不提交 `.env`）**

```bash
git status
# 确认无 .env
git add python-tools/universal_Skill_task/bpm_login.py python-tools/universal_Skill_task/navigate_ehr.py
git commit -m "fix(universal_Skill_task): tune BPM/EHR selectors after live probe"
```

若无需改选择器则跳过本 commit。

---

## Task 7 实测结果（2026-08-12）

`python main.py` 连续两次成功，退出码 0：

```text
[OK] BPM login success url=https://bpm.tinno.com/
[OK] EHR opened url=https://ehr.tinno.com/scripts/mgrqispi.dll?...EHR_BPM_SSO... title=Vantop
```

相比计划的额外改动（原因见 spec「实测修正」一节）：

- 新增 `cert_dialog.py`：自动确认个人数字证书弹窗
- 新增 `tests/test_cert_dialog.py`：验证 stop 事件能阻止按键外泄到页面
- `bpm_login.py`：改用 `#pwLogin .qiehuan` / `#username` / `#pwd` / `input[type=submit].sub-zh`
- `navigate_ehr.py`：先点 `#Shortcutmenu a`（门户），再点 `td[onclick*="vehrlogin"]`

单测：`pytest tests -v` → 4 passed。

## Spec coverage（自检）

| Spec 要求 | Task |
|-----------|------|
| Playwright 有界面登录 BPM | 3, 4, 6, 7 |
| 首页点 EHR，SSO 进入 | 5, 6, 7 |
| 凭据 `.env`，不进 git | 1, 2, 7 |
| 失败截图 `artifacts/` | 6 |
| 成功后保持浏览器一段时间 | 2, 6 |
| 验证码/二次验证明确失败 | 4 |
| 非目标：EHR 业务 / 无头 / 持久化 | 未实现（正确） |

## Placeholder scan

无 TBD/TODO；选择器以「实测微调」为 Task 7 的显式步骤，非空占位。

## Type consistency

- `AppConfig`：`bpm_url` / `username` / `password` / `keep_open_seconds`
- `login_bpm(page, cfg)` / `open_ehr(page, context) -> Page`
- `LoginError` / `NavigateEhrError` / `ConfigError`
