#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
JIRASynchronizer
----------------

根据配置在「REST(P12证书)」与「内存模拟」之间切换，向上层提供统一接口。

优化：
- 添加网络请求重试机制
- 支持连接超时配置
"""

from __future__ import annotations

import logging
import json
import time
from dataclasses import dataclass, field
from datetime import datetime
from typing import Any, Dict, List, Optional, Tuple, Type

from .jira_p12_client import JiraP12Client

logger = logging.getLogger(__name__)

# 可重试的异常类型
RETRYABLE_EXCEPTIONS: Tuple[Type[Exception], ...] = (
    ConnectionError,
    TimeoutError,
    OSError,
)

# 默认重试配置
DEFAULT_MAX_RETRIES = 3
DEFAULT_RETRY_DELAY = 1.0
DEFAULT_MAX_RETRY_DELAY = 30.0


@dataclass
class MockIssue:
    key: str
    summary: str
    description: str
    status: str
    fields: Dict[str, Any] = field(default_factory=dict)
    history: List[str] = field(default_factory=list)

    def log(self, message: str) -> None:
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        self.history.append(f"[{timestamp}] {message}")


class InMemoryJiraBackend:
    """最小可用的 JIRA 模拟器，用于本地离线验证。"""

    def __init__(self, project_key: str = "LOCAL"):
        self.project_key = project_key or "LOCAL"
        self._counter = 1000
        self._issues: Dict[str, MockIssue] = {}

    def create_issue(self, payload: Dict[str, Any]) -> Dict[str, Any]:
        self._counter += 1
        key = f"{self.project_key}-{self._counter}"
        issue = MockIssue(
            key=key,
            summary=payload.get("summary", ""),
            description=payload.get("description", ""),
            status="Open",
            fields=payload.copy(),
        )
        issue.log("Created")
        self._issues[key] = issue
        return {"key": issue.key, "status": issue.status, "fields": issue.fields}

    def update_issue(self, key: str, payload: Dict[str, Any]) -> Dict[str, Any]:
        issue = self._issues[key]
        if "summary" in payload:
            issue.summary = payload["summary"]
        if "description" in payload:
            issue.description = payload["description"]
        issue.fields.update(payload)
        issue.log(f"Updated fields: {', '.join(payload.keys())}")
        return {"key": issue.key, "status": issue.status, "fields": issue.fields}

    def transition_issue(self, key: str, status: str, comment: Optional[str] = None) -> Dict[str, Any]:
        issue = self._issues[key]
        old_status = issue.status
        issue.status = status
        issue.log(f"Status {old_status} -> {status}")
        if comment:
            issue.log(f"Comment: {comment}")
        return {"key": issue.key, "status": issue.status}

    def describe_issue(self, key: str) -> Dict[str, Any]:
        issue = self._issues[key]
        return {
            "key": issue.key,
            "summary": issue.summary,
            "status": issue.status,
            "history": issue.history,
            "fields": issue.fields,
        }

    def close(self) -> None:
        logger.debug("InMemoryJiraBackend closed")

    def add_comment(self, key: str, comment: str) -> None:
        issue = self._issues.get(key)
        if not issue:
            raise KeyError(f"Issue {key} not found")
        issue.log(f"Comment: {comment}")


class JiraRestBackend:
    """使用 P12 证书调用 Jira REST API。"""

    def __init__(self, config: Dict[str, Any]):
        self.config = config
        self.project_key = config.get("project_key", "VCAME")
        self.issue_type = config.get("issue_type", "Bug")
        self.custom_fields = config.get("custom_fields", {})
        self.components_map = config.get("components_map", {})
        self.invalid_custom_fields: set[str] = set()
        self.available_components: List[str] = []
        self.available_component_lookup: Dict[str, str] = {}
        verify_ssl = bool(config.get("verify", False))
        self.client = JiraP12Client(
            jira_url=config.get("url", ""),
            p12_file_path=config.get("p12_path", ""),
            p12_password=config.get("p12_password", ""),
            jira_username=config.get("username", ""),
            jira_password=config.get("password", "") or config.get("api_token", ""),
            verify=verify_ssl,
        )
        self.client.ensure_authenticated()
        self._load_components()

    def create_issue(self, payload: Dict[str, Any]) -> Dict[str, Any]:
        fields = self._build_fields(payload, include_project=True)
        response = self._safe_call("create", fields)
        key = response.get("key")
        logger.info("Jira REST 创建问题 %s", key)
        return {"key": key, "status": "Open", "fields": fields}

    def update_issue(self, key: str, payload: Dict[str, Any]) -> Dict[str, Any]:
        fields = self._build_fields(payload, include_project=False)
        self._safe_call("update", fields, issue_key=key)
        logger.info("Jira REST 更新问题 %s", key)
        current = self.client.get_issue(key)
        status = current.get("fields", {}).get("status", {}).get("name", "")
        return {"key": key, "status": status, "fields": current.get("fields", {})}

    def transition_issue(self, key: str, status: str, comment: Optional[str] = None) -> Dict[str, Any]:
        transitions = self.client.get_transitions(key)
        transition_id = self._find_transition_id(transitions, status)
        if not transition_id:
            logger.warning("未找到状态 %s 的转换，忽略", status)
            return {"key": key, "status": status}
        self.client.transition_issue(key, transition_id, comment=comment)
        logger.info("Jira REST 状态流转 %s -> %s", key, status)
        updated = self.client.get_issue(key)
        new_status = updated.get("fields", {}).get("status", {}).get("name", status)
        return {"key": key, "status": new_status}

    def describe_issue(self, key: str) -> Dict[str, Any]:
        data = self.client.get_issue(key)
        fields = data.get("fields", {})
        history = [f"status={fields.get('status', {}).get('name')}"]
        return {
            "key": data.get("key"),
            "summary": fields.get("summary"),
            "status": fields.get("status", {}).get("name"),
            "history": history,
            "fields": fields,
        }

    def close(self) -> None:
        self.client.close()

    def add_comment(self, key: str, comment: str) -> None:
        if comment:
            self.client.add_comment(key, comment)

    # ------------------------------------------------------------------
    def _build_fields(self, payload: Dict[str, Any], include_project: bool) -> Dict[str, Any]:
        fields: Dict[str, Any] = {}
        if include_project:
            fields["project"] = {"key": self.project_key}
            fields["issuetype"] = {"name": self.issue_type}

        fields["summary"] = payload.get("summary")
        fields["description"] = payload.get("description") or ""
        labels = payload.get("labels") or ["MonkeyAEE"]
        fields["labels"] = labels

        if payload.get("priority"):
            fields["priority"] = {"name": payload["priority"]}
        if payload.get("test_environment"):
            fields["environment"] = payload["test_environment"]

        assignee = payload.get("assignee")
        if assignee:
            fields["assignee"] = {"name": assignee}

        # 组件是必填字段，确保始终设置
        module = payload.get("module") or payload.get("package_name") or ""
        component_name = self._map_component(module)
        if component_name:
            fields["components"] = [{"name": component_name}]

        # bug_severity 是必填字段，确保有默认值
        bug_severity = payload.get("bug_severity") or "C"
        self._apply_custom_field(fields, "bug_severity", bug_severity, as_option=True)
        
        # key_information 文本字段
        self._apply_custom_field(fields, "key_information", payload.get("key_information"))

        return fields

    def _apply_custom_field(self, fields: Dict[str, Any], field_key: str, value: Optional[str], as_option: bool = False) -> None:
        if not value:
            return
        jira_field = self.custom_fields.get(field_key)
        if not jira_field:
            return
        if jira_field in self.invalid_custom_fields:
            return
        if as_option:
            fields[jira_field] = {"value": value}
        else:
            fields[jira_field] = value

    def _map_component(self, module: str) -> str:
        """
        将模块名映射到有效的 JIRA 组件名。
        如果找不到匹配的组件，返回默认组件 AUTOTEST。
        """
        normalized = module.strip().lower() if module else ""
        candidate = None
        
        # 1. 先从配置的组件映射中查找
        if normalized:
            for key, name in self.components_map.items():
                if key.lower() == normalized:
                    candidate = name
                    break

        # 2. 从可用组件的小写查找表中查找
        if not candidate and normalized:
            candidate = self.available_component_lookup.get(normalized)

        # 3. 模糊匹配可用组件
        if not candidate and normalized:
            for comp in self.available_components:
                lowered = comp.lower()
                if normalized == lowered or normalized in lowered or lowered in normalized:
                    candidate = comp
                    break

        # 4. 验证候选组件是否有效
        if candidate and candidate in self.available_components:
            return candidate
        
        # 5. 候选无效或未找到，使用默认组件 AUTOTEST
        if "AUTOTEST" in self.available_components:
            if candidate:
                logger.warning("组件 '%s' 不可用，使用默认组件 AUTOTEST", candidate)
            return "AUTOTEST"
        
        # 6. 如果 AUTOTEST 也不存在，返回第一个可用组件
        if self.available_components:
            default_comp = self.available_components[0]
            logger.warning("使用第一个可用组件: %s", default_comp)
            return default_comp
        
        # 7. 没有可用组件，返回空字符串
        logger.error("没有可用的 JIRA 组件")
        return ""

    @staticmethod
    def _find_transition_id(transitions: Dict[str, Any], status: str) -> Optional[str]:
        desired = status.lower()
        # 状态名称映射（英文 -> 中文）
        status_aliases = {
            "reopened": ["重新打开", "reopen"],
            "reopen": ["重新打开", "reopened"],
            "closed": ["已关闭", "close"],
            "resolved": ["已解决", "resolve"],
            "in progress": ["处理中", "开始进行"],
            "open": ["开放", "停止进行"],
        }
        
        # 获取所有可能的别名
        aliases = [desired]
        if desired in status_aliases:
            aliases.extend(status_aliases[desired])
        
        for transition in transitions.get("transitions", []):
            to_status = transition.get("to", {}).get("name", "").lower()
            name = transition.get("name", "").lower()
            
            # 检查目标状态或转换名称是否匹配任何别名
            for alias in aliases:
                alias_lower = alias.lower()
                if to_status == alias_lower or name == alias_lower or alias_lower in name:
                    return transition.get("id")
        return None

    # ------------------------------------------------------------------
    def _safe_call(
        self, 
        action: str, 
        fields: Dict[str, Any], 
        issue_key: Optional[str] = None,
        max_retries: int = DEFAULT_MAX_RETRIES,
    ) -> Dict[str, Any]:
        """
        安全调用 JIRA API，支持字段错误处理和网络重试。
        
        Args:
            action: 操作类型 (create/update)
            fields: 字段数据
            issue_key: 问题键（更新时需要）
            max_retries: 最大重试次数
        """
        def _exec_call() -> Dict[str, Any]:
            if action == "create":
                return self.client.create_issue(fields)
            if action == "update" and issue_key:
                self.client.update_issue(issue_key, fields)
                return {"key": issue_key}
            raise ValueError(f"Unsupported Jira action: {action}")

        retry_count = 0
        last_exception = None
        
        while True:
            try:
                return _exec_call()
            except RETRYABLE_EXCEPTIONS as exc:
                # 网络错误重试
                retry_count += 1
                if retry_count >= max_retries:
                    logger.error("JIRA API 调用失败，已达最大重试次数 %d: %s", max_retries, exc)
                    raise
                delay = min(DEFAULT_RETRY_DELAY * (2 ** (retry_count - 1)), DEFAULT_MAX_RETRY_DELAY)
                logger.warning("JIRA API 网络错误，%d/%d 次重试，延迟 %.1f 秒: %s", retry_count, max_retries, delay, exc)
                time.sleep(delay)
                last_exception = exc
            except RuntimeError as exc:
                if self._handle_field_errors(exc, fields):
                    logger.warning(
                        "检测到不可用的Jira字段，已移除后重试: fields=%s",
                        sorted(self.invalid_custom_fields),
                    )
                    continue
                raise

    def _handle_field_errors(self, exc: Exception, fields: Dict[str, Any]) -> bool:
        body = self._extract_error_body(str(exc))
        if not isinstance(body, dict):
            return False
        errors = body.get("errors") or {}
        if not isinstance(errors, dict):
            return False
        changed = False
        for field_name, detail in errors.items():
            message = str(detail)
            if field_name.startswith("customfield_"):
                if field_name in fields:
                    fields.pop(field_name, None)
                    changed = True
                self.invalid_custom_fields.add(field_name)
            elif field_name == "components":
                logger.error("Jira组件不可用: %s", message)
                return False
        return changed

    @staticmethod
    def _extract_error_body(message: str) -> Optional[Dict[str, Any]]:
        if "body=" not in message:
            return None
        body_part = message.split("body=", 1)[1]
        if not body_part:
            return None
        try:
            return json.loads(body_part)
        except json.JSONDecodeError:
            return None

    # ------------------------------------------------------------------
    def _load_components(self) -> None:
        try:
            data = self.client.get_project_components(self.project_key)
        except Exception as exc:  # pragma: no cover
            logger.warning("获取Jira组件列表失败: %s", exc)
            data = []
        names = [item.get("name") for item in data if item.get("name")]
        self.available_components = names
        self.available_component_lookup = {name.lower(): name for name in names}
        if names:
            logger.info("获取到 %d 个Jira组件", len(names))
        else:
            logger.warning("未能加载到Jira组件，后续可能无法满足模块必填要求")


class JIRASynchronizer:
    """对外暴露统一接口，针对 REST 与 MOCK 自动切换。"""

    def __init__(self, jira_config: Optional[Dict[str, Any]] = None):
        self.config = jira_config or {}
        self.project_key = self.config.get("project_key") or "LOCAL"
        desired_mode = (self.config.get("mode") or "rest").lower()
        self._backend = None
        if desired_mode == "rest":
            try:
                self._backend = JiraRestBackend(self.config)
                self.mode = "rest"
                logger.info("JiraSynchronizer 运行在 REST 模式")
            except Exception as exc:  # pragma: no cover
                logger.error("Jira REST 初始化失败，回退到内存模式: %s", exc)
                self.mode = "mock"
        if self._backend is None:
            self._backend = InMemoryJiraBackend(self.project_key)
            self.mode = "mock"
            logger.info("JiraSynchronizer 运行在 MOCK 模式")

    def is_authenticated(self) -> bool:
        if self.mode == "rest":
            return True
        return True  # mock 模式恒为 True

    def create_issue(self, fields: Dict[str, Any]) -> Dict[str, Any]:
        return self._backend.create_issue(fields)

    def update_issue(self, key: str, fields: Dict[str, Any]) -> Dict[str, Any]:
        return self._backend.update_issue(key, fields)

    def transition_issue(self, key: str, status: str, comment: Optional[str] = None) -> Dict[str, Any]:
        return self._backend.transition_issue(key, status, comment)

    def describe_issue(self, key: str) -> Dict[str, Any]:
        return self._backend.describe_issue(key)

    def close(self) -> None:
        if hasattr(self._backend, "close"):
            self._backend.close()

    def add_comment(self, key: str, comment: str) -> None:
        if not comment:
            return
        if hasattr(self._backend, "add_comment"):
            self._backend.add_comment(key, comment)

    def search_issues(self, jql: str, max_results: int = 100) -> Dict[str, Any]:
        """
        搜索 JIRA 问题
        
        Args:
            jql: JQL 查询语句
            max_results: 最大返回数量
            
        Returns:
            搜索结果，包含 issues 列表
        """
        if self.mode == "rest" and hasattr(self._backend, "client"):
            return self._backend.client.search(jql, max_results=max_results)
        
        # Mock 模式：返回空结果
        logger.warning("Mock 模式不支持 search_issues，返回空结果")
        return {"issues": [], "total": 0}
