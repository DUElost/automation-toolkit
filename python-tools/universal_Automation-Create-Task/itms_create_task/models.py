# -*- coding: utf-8 -*-
"""
数据模型定义。
"""

from dataclasses import dataclass, field
from typing import Any, Dict, List, Optional


@dataclass
class BrowserConfig:
    """浏览器运行配置。"""

    headless: bool = False
    slow_mo_ms: int = 0
    timeout_ms: int = 20000
    storage_state_path: str = ".runtime/itms_storage_state.json"


@dataclass
class AuthConfig:
    """认证与自动续登录配置。"""

    auto_relogin: bool = False
    login_url: str = ""
    username_env: str = "ITMS_USERNAME"
    password_env: str = "ITMS_PASSWORD"
    username_selector: str = ""
    password_selector: str = ""
    submit_selector: str = ""
    success_url_contains: str = "#/workbench"
    success_wait_ms: int = 15000


@dataclass
class ApiConfig:
    """接口模式配置。"""

    enabled: bool = True
    profile_path: str = ".runtime/itms_create_sub_plan_api.json"
    discovery_output_path: str = ".runtime/itms_api_discovery.json"
    create_keywords: List[str] = field(default_factory=list)
    body_overrides: Dict[str, Any] = field(default_factory=dict)


@dataclass
class UiFieldBinding:
    """表单字段绑定。"""

    field: str
    field_type: str = "text"
    label: Optional[str] = None
    selector: Optional[str] = None
    option_text: Optional[str] = None


@dataclass
class UiConfig:
    """UI 自动化配置。"""

    prefer_direct_urls: bool = True
    texts: Dict[str, Any] = field(default_factory=dict)
    field_bindings: List[UiFieldBinding] = field(default_factory=list)


@dataclass
class ItmsToolConfig:
    """工具总配置。"""

    config_path: str
    base_url: str
    workbench_url: str
    project_center_url: str
    project_name: str
    project_overview_url: str
    plans_url: str
    main_plan_name: str
    testsuite_component_name: str
    task_type: str
    task_sub_type: str
    main_plan_content_url: str
    sub_plan_form_url: str
    owner_name: str
    browser: BrowserConfig
    auth: AuthConfig
    api: ApiConfig
    ui: UiConfig


@dataclass
class RecordedRequest:
    """录制得到的接口请求。"""

    method: str
    url: str
    request_headers: Dict[str, Any]
    response_headers: Dict[str, Any]
    post_data: Optional[str]
    response_status: Optional[int]
    response_body: Optional[str]


@dataclass
class ApiExecutionResult:
    """接口执行结果。"""

    success: bool
    recoverable: bool
    status_code: Optional[int]
    url: str
    request_body: Any
    response_body: str
    message: str
