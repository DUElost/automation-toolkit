# -*- coding: utf-8 -*-
"""
配置加载与路径解析。
"""

import json
from pathlib import Path
from typing import Any, Dict, List

from .models import (
    ApiConfig,
    AuthConfig,
    BrowserConfig,
    CaptureConfig,
    ItmsToolConfig,
    ManpowerCaptureToolConfig,
    UiConfig,
    UiFieldBinding,
)


def _resolve_path(base_dir: Path, value: str) -> str:
    """将相对路径解析为绝对路径。"""
    path = Path(value)
    if path.is_absolute():
        return str(path)
    return str((base_dir / path).resolve())


def load_json_file(file_path: str) -> Dict[str, Any]:
    """读取 JSON 文件。"""
    with open(file_path, "r", encoding="utf-8") as file_obj:
        return json.load(file_obj)


def load_form_data(file_path: str) -> Dict[str, Any]:
    """读取表单数据文件。"""
    return load_json_file(file_path)


def load_config(config_path: str) -> ItmsToolConfig:
    """加载工具配置。"""
    raw = load_json_file(config_path)
    config_dir = Path(config_path).resolve().parent

    browser_raw = raw.get("browser", {})
    auth_raw = raw.get("auth", {})
    api_raw = raw.get("api", {})
    ui_raw = raw.get("ui", {})

    field_bindings: List[UiFieldBinding] = []
    for item in ui_raw.get("field_bindings", []):
        field_bindings.append(
            UiFieldBinding(
                field=item["field"],
                field_type=item.get("type", "text"),
                label=item.get("label"),
                selector=item.get("selector"),
                option_text=item.get("option_text"),
            )
        )

    browser = BrowserConfig(
        headless=browser_raw.get("headless", False),
        slow_mo_ms=browser_raw.get("slow_mo_ms", 0),
        timeout_ms=browser_raw.get("timeout_ms", 20000),
        storage_state_path=_resolve_path(
            config_dir, browser_raw.get("storage_state_path", ".runtime/itms_storage_state.json")
        ),
        executable_path=_resolve_path(config_dir, browser_raw["executable_path"]) if browser_raw.get("executable_path") else "",
    )

    auth = AuthConfig(
        auto_relogin=auth_raw.get("auto_relogin", False),
        login_url=auth_raw.get("login_url", raw.get("workbench_url", "http://itms.tinno.com/#/workbench")),
        username_env=auth_raw.get("username_env", "ITMS_USERNAME"),
        password_env=auth_raw.get("password_env", "ITMS_PASSWORD"),
        username_selector=auth_raw.get("username_selector", ""),
        password_selector=auth_raw.get("password_selector", ""),
        submit_selector=auth_raw.get("submit_selector", ""),
        success_url_contains=auth_raw.get("success_url_contains", "#/workbench"),
        success_wait_ms=auth_raw.get("success_wait_ms", 15000),
    )

    api = ApiConfig(
        enabled=api_raw.get("enabled", True),
        profile_path=_resolve_path(
            config_dir, api_raw.get("profile_path", ".runtime/itms_create_sub_plan_api.json")
        ),
        discovery_output_path=_resolve_path(
            config_dir, api_raw.get("discovery_output_path", ".runtime/itms_api_discovery.json")
        ),
        create_keywords=api_raw.get("create_keywords", []),
        body_overrides=api_raw.get("body_overrides", {}),
    )

    ui = UiConfig(
        prefer_direct_urls=ui_raw.get("prefer_direct_urls", True),
        texts=ui_raw.get("texts", {}),
        field_bindings=field_bindings,
    )

    return ItmsToolConfig(
        config_path=str(Path(config_path).resolve()),
        base_url=raw.get("base_url", "http://itms.tinno.com"),
        workbench_url=raw.get("workbench_url", "http://itms.tinno.com/#/workbench"),
        project_center_url=raw.get("project_center_url", "http://itms.tinno.com/#/projecthub/projects"),
        project_name=raw.get("project_name", "T726A"),
        project_overview_url=raw.get("project_overview_url", ""),
        plans_url=raw.get("plans_url", ""),
        main_plan_name=raw.get("main_plan_name", "RC阶段测试"),
        testsuite_component_name=raw.get("testsuite_component_name", "稳定性"),
        task_type=raw.get("task_type", "专项测试计划"),
        task_sub_type=raw.get("task_sub_type", "monkey专项"),
        main_plan_content_url=raw.get("main_plan_content_url", ""),
        sub_plan_form_url=raw.get("sub_plan_form_url", ""),
        owner_name=raw.get("owner_name", ""),
        browser=browser,
        auth=auth,
        api=api,
        ui=ui,
    )


def load_manpower_config(config_path: str) -> ManpowerCaptureToolConfig:
    """加载人力预估专项采集配置。"""
    raw = load_json_file(config_path)
    config_dir = Path(config_path).resolve().parent

    browser_raw = raw.get("browser", {})
    auth_raw = raw.get("auth", {})
    capture_raw = raw.get("capture", {})

    browser = BrowserConfig(
        headless=browser_raw.get("headless", False),
        slow_mo_ms=browser_raw.get("slow_mo_ms", 0),
        timeout_ms=browser_raw.get("timeout_ms", 20000),
        storage_state_path=_resolve_path(
            config_dir, browser_raw.get("storage_state_path", ".runtime/itms_storage_state.json")
        ),
        executable_path=_resolve_path(config_dir, browser_raw["executable_path"]) if browser_raw.get("executable_path") else "",
    )

    auth = AuthConfig(
        auto_relogin=auth_raw.get("auto_relogin", False),
        login_url=auth_raw.get("login_url", raw.get("workbench_url", "http://itms.tinno.com/#/workbench")),
        username_env=auth_raw.get("username_env", "ITMS_USERNAME"),
        password_env=auth_raw.get("password_env", "ITMS_PASSWORD"),
        username_selector=auth_raw.get("username_selector", ""),
        password_selector=auth_raw.get("password_selector", ""),
        submit_selector=auth_raw.get("submit_selector", ""),
        success_url_contains=auth_raw.get("success_url_contains", "#/workbench"),
        success_wait_ms=auth_raw.get("success_wait_ms", 15000),
    )

    capture = CaptureConfig(
        discovery_output_path=_resolve_path(
            config_dir, capture_raw.get("discovery_output_path", ".runtime/manpower_task_capture.json")
        ),
        candidate_output_path=_resolve_path(
            config_dir, capture_raw.get("candidate_output_path", ".runtime/manpower_task_candidate.json")
        ),
        create_keywords=capture_raw.get(
            "create_keywords",
            ["manpower", "task", "estimate", "save", "submit", "create", "add"],
        ),
    )

    return ManpowerCaptureToolConfig(
        config_path=str(Path(config_path).resolve()),
        base_url=raw.get("base_url", "http://itms.tinno.com"),
        workbench_url=raw.get("workbench_url", "http://itms.tinno.com/#/workbench"),
        entry_url=raw["entry_url"],
        page_name=raw.get("page_name", "人力预估页面"),
        browser=browser,
        auth=auth,
        capture=capture,
    )
