# -*- coding: utf-8 -*-
"""
接口调用逻辑。
"""

import json
from copy import deepcopy
from datetime import datetime
from pathlib import Path
from typing import Any, Dict

from .auth import ItmsAuthManager
from .context_resolver import ItmsContextResolver
from .models import ApiExecutionResult, ItmsToolConfig


class ItmsApiClient:
    """基于录制接口的子计划创建客户端。"""

    def __init__(self, config: ItmsToolConfig, auth_manager: ItmsAuthManager):
        self.config = config
        self.auth_manager = auth_manager
        self.context_resolver = ItmsContextResolver(config, auth_manager)

    def has_profile(self) -> bool:
        """判断是否存在可用接口配置。"""
        return Path(self.config.api.profile_path).exists()

    def create_sub_plan(self, form_data: Dict[str, Any]) -> ApiExecutionResult:
        """使用录制的接口配置执行子计划创建。"""
        profile = self._load_profile()
        session = self.auth_manager.create_requests_session(auto_refresh=True)

        request_body = profile.get("body_sample")
        if isinstance(request_body, dict):
            request_body = deepcopy(request_body)
            request_body = self.context_resolver.build_request_payload(form_data, request_body)

        context = self._build_context(form_data)
        resolved_overrides = self._resolve_template_values(
            deepcopy(self.config.api.body_overrides), context
        )

        if isinstance(request_body, dict) and isinstance(resolved_overrides, dict):
            request_body = self._deep_merge(request_body, resolved_overrides)
        elif resolved_overrides:
            request_body = resolved_overrides

        headers = profile.get("request_headers", {})
        response = session.request(
            method=profile["method"],
            url=profile["url"],
            json=request_body if isinstance(request_body, dict) else None,
            data=request_body if isinstance(request_body, str) else None,
            headers=headers,
            timeout=30,
        )

        response_text = response.text
        success, recoverable, message = self._evaluate_response(response, response_text)

        return ApiExecutionResult(
            success=success,
            recoverable=recoverable,
            status_code=response.status_code,
            url=profile["url"],
            request_body=request_body,
            response_body=response_text[:4000],
            message=message,
        )

    def _load_profile(self) -> Dict[str, Any]:
        """读取接口配置文件。"""
        with open(self.config.api.profile_path, "r", encoding="utf-8") as file_obj:
            return json.load(file_obj)

    def _build_context(self, form_data: Dict[str, Any]) -> Dict[str, Any]:
        """构建模板替换上下文。"""
        context = {
            "project_name": self.config.project_name,
            "main_plan_name": self.config.main_plan_name,
            "testsuite_component_name": self.config.testsuite_component_name,
            "task_type": self.config.task_type,
            "task_sub_type": self.config.task_sub_type,
            "owner_name": self.config.owner_name,
        }
        context.update(form_data)

        if "start_time" not in context and context.get("start_date"):
            context["start_time"] = self._normalize_datetime_text(
                str(context["start_date"]), "09:00:00"
            )
        if "end_time" not in context and context.get("end_date"):
            context["end_time"] = self._normalize_datetime_text(
                str(context["end_date"]), "18:00:00"
            )
        return context

    def _resolve_template_values(self, value: Any, context: Dict[str, Any]) -> Any:
        """递归解析 `{{field}}` 模板值。"""
        if isinstance(value, dict):
            return {
                key: self._resolve_template_values(item, context)
                for key, item in value.items()
            }
        if isinstance(value, list):
            return [self._resolve_template_values(item, context) for item in value]
        if isinstance(value, str):
            return self._resolve_string(value, context)
        return value

    @staticmethod
    def _resolve_string(template: str, context: Dict[str, Any]) -> Any:
        """替换字符串模板。"""
        if template.startswith("{{") and template.endswith("}}"):
            key = template[2:-2].strip()
            return context.get(key, "")

        result = template
        for key, value in context.items():
            result = result.replace("{{%s}}" % key, str(value))
        return result

    def _deep_merge(self, base: Dict[str, Any], override: Dict[str, Any]) -> Dict[str, Any]:
        """深度合并 dict。"""
        for key, value in override.items():
            if isinstance(value, dict) and isinstance(base.get(key), dict):
                base[key] = self._deep_merge(base[key], value)
            else:
                base[key] = value
        return base

    @staticmethod
    def _normalize_datetime_text(value: str, default_time: str) -> str:
        """将日期或时间字符串格式化为接口需要的时间文本。"""
        text = value.strip()
        if not text:
            return text
        if len(text) == 10:
            return "%s %s" % (text, default_time)
        try:
            parsed = datetime.fromisoformat(text)
            return parsed.strftime("%Y-%m-%d %H:%M:%S")
        except ValueError:
            return text

    @staticmethod
    def _evaluate_response(response, response_text: str):
        """根据 HTTP 与业务字段综合判断是否成功。"""
        if not response.ok or "login" in response.url.lower():
            return False, True, "接口调用失败"

        try:
            payload = response.json()
        except ValueError:
            return True, False, "接口调用成功"

        if isinstance(payload, dict):
            errno = payload.get("errno")
            if errno not in (None, 0):
                errmsg = payload.get("errmsg", "")
                recoverable = errno in (40100, 40300, 50000)
                if errno == 501:
                    recoverable = False
                if errmsg and ("已存在" in errmsg or "重复" in errmsg or "必填" in errmsg or "不能为空" in errmsg):
                    recoverable = False
                message = "接口调用失败，errno=%s" % errno
                if errmsg:
                    message = "%s，errmsg=%s" % (message, errmsg)
                return False, recoverable, message

        return True, False, "接口调用成功"
