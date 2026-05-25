#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
JiraP12Client
-------------

基于 P12 证书的 Jira Server API 客户端，供 REST 模式的 JIRASynchronizer 调用。
"""

from __future__ import annotations

import json
import logging
import os
import tempfile
from typing import Any, Dict, List, Optional

import requests
import urllib3
from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.serialization import pkcs12
from requests.auth import HTTPBasicAuth
from requests.adapters import HTTPAdapter
from urllib.parse import urljoin, urlparse
from urllib3.poolmanager import PoolManager
from urllib3.util.ssl_ import create_urllib3_context

logger = logging.getLogger(__name__)


class LegacySSLHttpAdapter(HTTPAdapter):
    """为 Tinno 旧证书链降低 OpenSSL 安全级别。"""

    def __init__(self, ciphers: str = "ALL:@SECLEVEL=0", **kwargs: Any) -> None:
        self.ciphers = ciphers
        super().__init__(**kwargs)

    def init_poolmanager(self, connections: int, maxsize: int, block: bool = False, **pool_kwargs: Any) -> None:
        context = create_urllib3_context(ciphers=self.ciphers)
        context.check_hostname = False
        self.poolmanager = PoolManager(
            num_pools=connections,
            maxsize=maxsize,
            block=block,
            ssl_context=context,
            **pool_kwargs,
        )


class JiraP12Client:
    """封装 P12 证书 + 用户密码认证流程。"""

    def __init__(
        self,
        jira_url: str,
        p12_file_path: str,
        p12_password: str,
        jira_username: str,
        jira_password: str,
        verify: bool = False,
        timeout: int = 30,
        cookie_string: Optional[str] = None,
        cookie_jsessionid: Optional[str] = None,
        cookie_xsrf_token: Optional[str] = None,
        cookie_rememberme: Optional[str] = None,
        cookie_crowd_token: Optional[str] = None,
    ) -> None:
        self.jira_url = jira_url.rstrip("/")
        self.p12_file_path = p12_file_path
        self.p12_password = p12_password or ""
        self.jira_username = jira_username
        self.jira_password = jira_password
        self.verify = verify
        self.timeout = timeout
        if not self.verify:
            urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)
        self.cookie_string = cookie_string if cookie_string is not None else os.getenv("JIRA_COOKIE_STRING", "")
        self.cookie_jsessionid = cookie_jsessionid if cookie_jsessionid is not None else os.getenv("JIRA_COOKIE_JSESSIONID", "")
        self.cookie_xsrf_token = cookie_xsrf_token if cookie_xsrf_token is not None else os.getenv("JIRA_COOKIE_XSRF_TOKEN", "")
        self.cookie_rememberme = cookie_rememberme if cookie_rememberme is not None else os.getenv("JIRA_COOKIE_REMEMBERME", "")
        self.cookie_crowd_token = cookie_crowd_token if cookie_crowd_token is not None else os.getenv("JIRA_COOKIE_CROWD_TOKEN", "")
        self.session: Optional[requests.Session] = None
        self.cert_files: Optional[tuple[str, str]] = None
        self.is_logged_in = False
        self.auth_mode = "none"

    # ------------------------------------------------------------------
    def ensure_authenticated(self) -> None:
        if self.is_logged_in and self.session:
            return
        self.connect()
        self.login()

    def connect(self) -> None:
        logger.debug("使用P12证书建立SSL连接 ...")
        self.cert_files = self._extract_cert_and_key()
        self.session = self._build_session(self.cert_files)
        resp = self.session.get(self.jira_url, verify=self.verify, timeout=self.timeout, allow_redirects=True)
        if resp.status_code != 200:
            raise RuntimeError(f"Jira SSL连接失败，状态码: {resp.status_code}")
        logger.info("P12证书SSL连接成功")

    def login(self) -> None:
        if not self.session:
            raise RuntimeError("请先调用 connect() 建立SSL连接")

        if self._try_cookie_auth():
            return

        logger.info("使用账号 %s 登录Jira ...", self.jira_username)
        login_data = {"username": self.jira_username, "password": self.jira_password}
        headers = {"Content-Type": "application/json", "X-Atlassian-Token": "no-check"}
        resp = self.session.post(
            urljoin(self.jira_url, "/rest/auth/1/session"),
            json=login_data,
            headers=headers,
            timeout=self.timeout,
            verify=self.verify,
        )
        if resp.status_code == 200:
            self.is_logged_in = True
            self.auth_mode = "rest"
            logger.info("Jira REST 登录成功")
            return

        logger.warning("Jira session 登录失败，尝试回退到 Basic Auth: status=%s", resp.status_code)
        self.session.auth = HTTPBasicAuth(self.jira_username, self.jira_password)
        verify_resp = self.session.get(
            urljoin(self.jira_url, "/rest/api/2/myself"),
            timeout=self.timeout,
            verify=self.verify,
        )
        if self._response_has_json(verify_resp):
            self.is_logged_in = True
            self.auth_mode = "basic"
            logger.info("Jira Basic Auth 回退成功")
            return

        if self._try_cookie_auth():
            return

        raise RuntimeError(f"Jira登录失败, status={resp.status_code}, body={resp.text}")

    # ------------------------------------------------------------------
    def create_issue(self, fields: Dict[str, Any]) -> Dict[str, Any]:
        return self._make_request("POST", "/rest/api/2/issue", json={"fields": fields})

    def update_issue(self, issue_key: str, fields: Dict[str, Any]) -> Dict[str, Any]:
        return self._make_request("PUT", f"/rest/api/2/issue/{issue_key}", json={"fields": fields})

    def add_comment(self, issue_key: str, comment_text: str) -> Dict[str, Any]:
        return self._make_request("POST", f"/rest/api/2/issue/{issue_key}/comment", json={"body": comment_text})

    def get_issue(self, issue_key: str) -> Dict[str, Any]:
        return self._make_request("GET", f"/rest/api/2/issue/{issue_key}")

    def search(self, jql: str, max_results: int = 50, fields: str = "*all") -> Dict[str, Any]:
        params = {"jql": jql, "maxResults": max_results, "fields": fields}
        return self._make_request("GET", "/rest/api/2/search", params=params)

    def get_transitions(self, issue_key: str, expand_fields: bool = False) -> Dict[str, Any]:
        endpoint = f"/rest/api/2/issue/{issue_key}/transitions"
        if expand_fields:
            endpoint = f"{endpoint}?expand=transitions.fields"
        return self._make_request("GET", endpoint)

    def transition_issue(self, issue_key: str, transition_id: str, comment: Optional[str] = None, fields: Optional[Dict[str, Any]] = None) -> Dict[str, Any]:
        if comment:
            self.add_comment(issue_key, comment)
        payload: Dict[str, Any] = {"transition": {"id": transition_id}}
        if fields:
            payload["fields"] = fields
        return self._make_request("POST", f"/rest/api/2/issue/{issue_key}/transitions", json=payload)

    def get_project_components(self, project_key: str) -> List[Dict[str, Any]]:
        return self._make_request("GET", f"/rest/api/2/project/{project_key}/components")

    def get_project_versions(self, project_key: str) -> List[Dict[str, Any]]:
        return self._make_request("GET", f"/rest/api/2/project/{project_key}/versions")

    # ------------------------------------------------------------------
    def close(self) -> None:
        if self.session:
            self.session.close()
        if self.cert_files:
            for path in self.cert_files:
                try:
                    os.unlink(path)
                except OSError:
                    pass
        self.session = None
        self.cert_files = None
        self.is_logged_in = False
        self.auth_mode = "none"
        logger.debug("JiraP12Client连接已关闭")

    def _build_session(self, cert_files: tuple[str, str]) -> requests.Session:
        session = requests.Session()
        session.mount("https://", LegacySSLHttpAdapter())
        session.trust_env = False  # 忽略系统代理
        session.proxies = {}
        session.cert = cert_files
        return session

    # ------------------------------------------------------------------
    def _make_request(self, method: str, endpoint: str, **kwargs: Any) -> Any:
        self.ensure_authenticated()
        url = urljoin(self.jira_url, endpoint)
        headers = kwargs.pop("headers", {})
        headers.setdefault("Content-Type", "application/json")
        resp = self.session.request(
            method,
            url,
            headers=headers,
            timeout=self.timeout,
            verify=self.verify,
            **kwargs,
        )
        if 200 <= resp.status_code < 300:
            if resp.content:
                try:
                    return resp.json()
                except json.JSONDecodeError:
                    return {"text": resp.text}
            return {}
        raise RuntimeError(f"Jira API请求失败 ({method} {url}), status={resp.status_code}, body={resp.text}")

    def _extract_cert_and_key(self) -> tuple[str, str]:
        if not self.p12_file_path or not os.path.exists(self.p12_file_path):
            raise FileNotFoundError(f"P12证书文件不存在: {self.p12_file_path}")
        with open(self.p12_file_path, "rb") as fp:
            p12_data = fp.read()
        private_key, certificate, _ = pkcs12.load_key_and_certificates(
            p12_data, self.p12_password.encode() if self.p12_password else None
        )
        if not private_key or not certificate:
            raise RuntimeError("无法从P12文件中提取有效证书/私钥")

        cert_temp = tempfile.NamedTemporaryFile(mode="wb", suffix=".crt", delete=False)
        key_temp = tempfile.NamedTemporaryFile(mode="wb", suffix=".key", delete=False)
        cert_temp.write(certificate.public_bytes(serialization.Encoding.PEM))
        cert_temp.flush()
        key_temp.write(
            private_key.private_bytes(
                encoding=serialization.Encoding.PEM,
                format=serialization.PrivateFormat.PKCS8,
                encryption_algorithm=serialization.NoEncryption(),
            )
        )
        key_temp.flush()
        cert_temp.close()
        key_temp.close()
        logger.debug("P12证书转换为临时PEM文件: %s, %s", cert_temp.name, key_temp.name)
        return cert_temp.name, key_temp.name

    def _parse_cookie_string(self, cookie_string: str) -> Dict[str, str]:
        cookies: Dict[str, str] = {}
        for chunk in str(cookie_string or "").split(";"):
            if "=" not in chunk:
                continue
            key, value = chunk.strip().split("=", 1)
            key = key.strip()
            value = value.strip()
            if key and value:
                cookies[key] = value
        return cookies

    def _load_cookie_values(self) -> Dict[str, str]:
        cookies = self._parse_cookie_string(self.cookie_string)
        if self.cookie_jsessionid:
            cookies["JSESSIONID"] = self.cookie_jsessionid
        if self.cookie_xsrf_token:
            cookies["atlassian.xsrf.token"] = self.cookie_xsrf_token
        if self.cookie_rememberme:
            cookies["seraph.rememberme.cookie"] = self.cookie_rememberme
        if self.cookie_crowd_token:
            cookies["crowd.token_key"] = self.cookie_crowd_token
        return cookies

    def _apply_cookies(self, cookies: Dict[str, str]) -> None:
        if not self.session:
            raise RuntimeError("请先建立 session 后再设置 Cookie")
        domain = (urlparse(self.jira_url).hostname or "").strip()
        if not domain:
            raise RuntimeError(f"无法从 Jira URL 解析 Cookie 域名: {self.jira_url}")
        for key, value in cookies.items():
            self.session.cookies.set(key, value, domain=domain)

    def _try_cookie_auth(self) -> bool:
        if not self.session:
            return False
        cookies = self._load_cookie_values()
        if not cookies:
            return False

        logger.info("检测到 Tinno Cookie，尝试 P12 + Cookie 认证")
        self.session.auth = None
        self._apply_cookies(cookies)
        verify_resp = self.session.get(
            urljoin(self.jira_url, "/rest/api/2/myself"),
            timeout=self.timeout,
            verify=self.verify,
        )
        if verify_resp.status_code != 200:
            logger.warning("Tinno Cookie 回退失败，status=%s", verify_resp.status_code)
            return False
        if not self._response_has_json(verify_resp):
            logger.warning("Tinno Cookie 回退失败，myself 未返回 JSON")
            return False

        self.is_logged_in = True
        self.auth_mode = "cookie"
        logger.info("Tinno Cookie 回退成功")
        return True

    def _response_has_json(self, response: requests.Response) -> bool:
        if response.status_code != 200:
            return False
        content_type = str((response.headers or {}).get("Content-Type", "")).lower()
        try:
            payload = response.json()
        except (ValueError, json.JSONDecodeError):
            return False
        return "json" in content_type and payload is not None
