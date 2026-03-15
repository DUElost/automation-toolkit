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
from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.serialization import pkcs12
from urllib.parse import urljoin

logger = logging.getLogger(__name__)


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
    ) -> None:
        self.jira_url = jira_url.rstrip("/")
        self.p12_file_path = p12_file_path
        self.p12_password = p12_password or ""
        self.jira_username = jira_username
        self.jira_password = jira_password
        self.verify = verify
        self.timeout = timeout
        self.session: Optional[requests.Session] = None
        self.cert_files: Optional[tuple[str, str]] = None
        self.is_logged_in = False

    # ------------------------------------------------------------------
    def ensure_authenticated(self) -> None:
        if self.is_logged_in and self.session:
            return
        self.connect()
        self.login()

    def connect(self) -> None:
        logger.debug("使用P12证书建立SSL连接 ...")
        self.cert_files = self._extract_cert_and_key()
        self.session = requests.Session()
        self.session.trust_env = False  # 忽略系统代理
        self.session.proxies = {}
        self.session.cert = self.cert_files
        resp = self.session.get(self.jira_url, verify=self.verify, timeout=self.timeout, allow_redirects=True)
        if resp.status_code != 200:
            raise RuntimeError(f"Jira SSL连接失败，状态码: {resp.status_code}")
        logger.info("P12证书SSL连接成功")

    def login(self) -> None:
        if not self.session:
            raise RuntimeError("请先调用 connect() 建立SSL连接")
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
        if resp.status_code != 200:
            raise RuntimeError(f"Jira登录失败, status={resp.status_code}, body={resp.text}")
        self.is_logged_in = True
        logger.info("Jira REST 登录成功")

    # ------------------------------------------------------------------
    def create_issue(self, fields: Dict[str, Any]) -> Dict[str, Any]:
        return self._make_request("POST", "/rest/api/2/issue", json={"fields": fields})

    def update_issue(self, issue_key: str, fields: Dict[str, Any]) -> Dict[str, Any]:
        return self._make_request("PUT", f"/rest/api/2/issue/{issue_key}", json={"fields": fields})

    def add_comment(self, issue_key: str, comment_text: str) -> Dict[str, Any]:
        return self._make_request("POST", f"/rest/api/2/issue/{issue_key}/comment", json={"body": comment_text})

    def get_issue(self, issue_key: str) -> Dict[str, Any]:
        return self._make_request("GET", f"/rest/api/2/issue/{issue_key}")

    def search(self, jql: str, max_results: int = 50) -> Dict[str, Any]:
        params = {"jql": jql, "maxResults": max_results}
        return self._make_request("GET", "/rest/api/2/search", params=params)

    def get_transitions(self, issue_key: str) -> Dict[str, Any]:
        return self._make_request("GET", f"/rest/api/2/issue/{issue_key}/transitions")

    def transition_issue(self, issue_key: str, transition_id: str, comment: Optional[str] = None, fields: Optional[Dict[str, Any]] = None) -> Dict[str, Any]:
        if comment:
            self.add_comment(issue_key, comment)
        payload: Dict[str, Any] = {"transition": {"id": transition_id}}
        if fields:
            payload["fields"] = fields
        return self._make_request("POST", f"/rest/api/2/issue/{issue_key}/transitions", json=payload)

    def get_project_components(self, project_key: str) -> List[Dict[str, Any]]:
        return self._make_request("GET", f"/rest/api/2/project/{project_key}/components")

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
        logger.debug("JiraP12Client连接已关闭")

    # ------------------------------------------------------------------
    def _make_request(self, method: str, endpoint: str, **kwargs: Any) -> Dict[str, Any]:
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
