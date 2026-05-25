# -*- coding: utf-8 -*-
"""
登录态与 requests 会话处理。
"""

import json
import logging
import os
from pathlib import Path
from typing import Dict, Optional, Tuple

import requests
from playwright.sync_api import sync_playwright

from .models import ItmsToolConfig


LOGGER = logging.getLogger(__name__)


class ItmsAuthManager:
    """管理 Playwright 登录态与 requests Session。"""

    def __init__(self, config: ItmsToolConfig):
        self.config = config

    def ensure_storage_state(self) -> str:
        """启动浏览器，让用户手动登录并保存 storage state。"""
        storage_path = Path(self.config.browser.storage_state_path)
        storage_path.parent.mkdir(parents=True, exist_ok=True)

        with sync_playwright() as playwright:
            browser = playwright.chromium.launch(**self.build_launch_kwargs())
            context = browser.new_context()
            context.set_default_timeout(self.config.browser.timeout_ms)
            page = context.new_page()
            page.goto(self.config.workbench_url)

            print("请在打开的浏览器中完成 ITMS 登录。")
            print("登录完成后，回到终端按回车保存登录态。")
            input()

            context.storage_state(path=str(storage_path))
            browser.close()

        LOGGER.info("storage_state 已保存到 %s", storage_path)
        return str(storage_path)

    def create_requests_session(self, auto_refresh: bool = True) -> requests.Session:
        """根据 storage state 生成 requests.Session。"""
        self.ensure_valid_storage_state(auto_refresh=auto_refresh)
        return self._create_session_from_storage()

    def ensure_valid_storage_state(self, auto_refresh: bool = True) -> str:
        """确保本地 storage_state 可用，必要时自动重新登录。"""
        storage_path = Path(self.config.browser.storage_state_path)
        if not storage_path.exists():
            if auto_refresh and self.can_auto_relogin():
                return self.login_with_password()
            raise FileNotFoundError("未找到 storage_state，请先执行 auth 命令完成登录。")

        ok, _ = self.validate_storage_state()
        if ok:
            return str(storage_path)

        if auto_refresh and self.can_auto_relogin():
            LOGGER.warning("检测到 ITMS 登录态失效，准备自动重新登录。")
            return self.login_with_password()

        raise RuntimeError("当前登录态已失效，请先重新执行 auth 命令完成登录。")

    def validate_storage_state(self) -> Tuple[bool, str]:
        """校验当前 storage_state 是否仍然有效。"""
        try:
            session = self._create_session_from_storage()
        except Exception as exc:
            return False, str(exc)

        token = session.cookies.get("X-Tfts-Token") or session.cookies.get("JSESSIONID")
        if not token:
            return False, "storage_state 中未找到认证 token"

        try:
            response = session.get(
                "%s/api/auth/info" % self.config.base_url.rstrip("/"),
                params={"token": token},
                timeout=30,
            )
            payload = response.json()
        except Exception as exc:
            return False, "校验登录态失败: %s" % exc

        errno = payload.get("errno")
        if errno in (None, 0):
            return True, ""
        return False, "errno=%s errmsg=%s" % (errno, payload.get("errmsg", ""))

    def can_auto_relogin(self) -> bool:
        """判断是否具备自动重新登录条件。"""
        auth_config = self.config.auth
        username, password = self._get_credentials()
        return bool(
            auth_config.auto_relogin
            and username
            and password
            and auth_config.username_selector
            and auth_config.password_selector
            and auth_config.submit_selector
        )

    def login_with_password(self) -> str:
        """使用账号密码自动登录并刷新 storage_state。"""
        username, password = self._get_credentials()
        if not username or not password:
            raise RuntimeError("未找到自动登录凭据，请检查环境变量配置。")

        auth_config = self.config.auth
        storage_path = Path(self.config.browser.storage_state_path)
        storage_path.parent.mkdir(parents=True, exist_ok=True)

        with sync_playwright() as playwright:
            browser = playwright.chromium.launch(**self.build_launch_kwargs())
            context = browser.new_context()
            context.set_default_timeout(self.config.browser.timeout_ms)
            page = context.new_page()
            page.goto(auth_config.login_url or self.config.workbench_url)

            page.locator(auth_config.username_selector).first.fill(username)
            page.locator(auth_config.password_selector).first.fill(password)
            page.locator(auth_config.submit_selector).first.click()

            self._wait_for_login_success(page)
            context.storage_state(path=str(storage_path))
            browser.close()

        LOGGER.info("已通过账号密码自动刷新 storage_state: %s", storage_path)
        return str(storage_path)

    def _create_session_from_storage(self) -> requests.Session:
        """从 storage_state 创建 requests.Session。"""
        storage_path = Path(self.config.browser.storage_state_path)
        if not storage_path.exists():
            raise FileNotFoundError("未找到 storage_state，请先执行 auth 命令完成登录。")
        with open(storage_path, "r", encoding="utf-8") as file_obj:
            storage_state = json.load(file_obj)

        session = requests.Session()
        session.headers.update(
            {
                "User-Agent": (
                    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
                    "AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36"
                ),
                "Accept": "application/json, text/plain, */*",
                "Referer": self.config.workbench_url,
            }
        )

        for cookie in storage_state.get("cookies", []):
            session.cookies.set(
                cookie.get("name"),
                cookie.get("value"),
                domain=cookie.get("domain"),
                path=cookie.get("path", "/"),
            )

        return session

    def build_context_kwargs(self) -> Dict[str, Optional[str]]:
        """生成 Playwright context 创建参数。"""
        storage_path = Path(self.config.browser.storage_state_path)
        kwargs = {}
        if storage_path.exists():
            kwargs["storage_state"] = str(storage_path)
        return kwargs

    def build_launch_kwargs(self) -> Dict[str, object]:
        """生成 Playwright 浏览器启动参数。"""
        kwargs: Dict[str, object] = {
            "headless": self.config.browser.headless,
            "slow_mo": self.config.browser.slow_mo_ms,
        }
        executable_path = self.config.browser.executable_path.strip()
        if executable_path:
            kwargs["executable_path"] = executable_path
        return kwargs

    def _get_credentials(self) -> Tuple[str, str]:
        """从环境变量读取账号密码。"""
        username = os.environ.get(self.config.auth.username_env, "").strip()
        password = os.environ.get(self.config.auth.password_env, "").strip()
        return username, password

    def _wait_for_login_success(self, page) -> None:
        """等待登录成功。"""
        success_hint = self.config.auth.success_url_contains.strip()
        if success_hint:
            page.wait_for_url(lambda url: success_hint in url, timeout=self.config.auth.success_wait_ms)
            return
        page.wait_for_timeout(self.config.auth.success_wait_ms)
