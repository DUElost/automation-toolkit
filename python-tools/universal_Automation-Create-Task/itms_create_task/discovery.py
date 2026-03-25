# -*- coding: utf-8 -*-
"""
接口录制与候选接口筛选。
"""

import json
import logging
from pathlib import Path
from typing import Dict, List, Optional

from playwright.sync_api import sync_playwright

from .auth import ItmsAuthManager
from .models import ItmsToolConfig, RecordedRequest


LOGGER = logging.getLogger(__name__)


class ApiDiscovery:
    """录制浏览器网络请求，提取子计划创建接口候选。"""

    def __init__(self, config: ItmsToolConfig, auth_manager: ItmsAuthManager):
        self.config = config
        self.auth_manager = auth_manager

    def record_manual_flow(self) -> Dict[str, object]:
        """让用户手动执行一次创建动作，并录制全部请求。"""
        output_path = Path(self.config.api.discovery_output_path)
        profile_path = Path(self.config.api.profile_path)
        output_path.parent.mkdir(parents=True, exist_ok=True)
        profile_path.parent.mkdir(parents=True, exist_ok=True)

        captures: List[RecordedRequest] = []
        context_kwargs = self.auth_manager.build_context_kwargs()

        with sync_playwright() as playwright:
            browser = playwright.chromium.launch(
                headless=self.config.browser.headless,
                slow_mo=self.config.browser.slow_mo_ms,
            )
            context = browser.new_context(**context_kwargs)
            context.set_default_timeout(self.config.browser.timeout_ms)
            page = context.new_page()

            def on_response(response):
                request = response.request
                resource_type = request.resource_type
                if resource_type not in ("fetch", "xhr", "document"):
                    return
                if self.config.base_url not in request.url:
                    return

                try:
                    response_body = response.text()
                except Exception:
                    response_body = None

                captures.append(
                    RecordedRequest(
                        method=request.method,
                        url=request.url,
                        request_headers=request.headers,
                        response_headers=response.headers,
                        post_data=request.post_data,
                        response_status=response.status,
                        response_body=response_body,
                    )
                )

            page.on("response", on_response)

            entry_url = self.config.sub_plan_form_url or self.config.main_plan_content_url or self.config.workbench_url
            page.goto(entry_url)

            print("浏览器已启动，开始录制网络请求。")
            print("请手动完成一次“添加子计划并提交”的完整动作。")
            print("完成后回到终端按回车，脚本会保存录制结果。")
            input()

            context.storage_state(path=self.config.browser.storage_state_path)
            browser.close()

        payload = {
            "captures": [capture.__dict__ for capture in captures],
            "candidate_request": self._select_candidate(captures),
        }

        with open(output_path, "w", encoding="utf-8") as file_obj:
            json.dump(payload, file_obj, ensure_ascii=False, indent=2)

        candidate = payload["candidate_request"]
        if candidate:
            with open(profile_path, "w", encoding="utf-8") as file_obj:
                json.dump(candidate, file_obj, ensure_ascii=False, indent=2)
            LOGGER.info("已生成接口候选配置: %s", profile_path)
        else:
            LOGGER.warning("未识别到明确的创建接口，请检查录制文件: %s", output_path)

        return payload

    def _select_candidate(self, captures: List[RecordedRequest]) -> Optional[Dict[str, object]]:
        """从录制结果中筛选最可能的创建接口。"""
        keywords = [item.lower() for item in self.config.api.create_keywords]
        filtered = []

        for capture in captures:
            if capture.method.upper() not in ("POST", "PUT", "PATCH"):
                continue
            url_lower = capture.url.lower()
            if keywords and not any(keyword in url_lower for keyword in keywords):
                continue
            if not capture.post_data:
                continue
            filtered.append(capture)

        if not filtered:
            return None

        candidate = filtered[-1]
        request_body = self._try_parse_json(candidate.post_data)

        return {
            "method": candidate.method,
            "url": candidate.url,
            "request_headers": self._filter_headers(candidate.request_headers),
            "body_sample": request_body if request_body is not None else candidate.post_data,
        }

    @staticmethod
    def _try_parse_json(value: Optional[str]):
        """尽量将请求体解析成 JSON。"""
        if value is None:
            return None
        try:
            return json.loads(value)
        except (json.JSONDecodeError, TypeError):
            return None

    @staticmethod
    def _filter_headers(headers: Dict[str, object]) -> Dict[str, object]:
        """过滤掉不适合持久化的请求头。"""
        allowed = {}
        for key, value in headers.items():
            key_lower = key.lower()
            if key_lower in ("content-type", "x-requested-with", "x-xsrf-token", "x-csrf-token"):
                allowed[key] = value
        return allowed
