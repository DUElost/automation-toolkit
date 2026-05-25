# 人力预估页面专项采集 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 在 `universal_Automation-Create-Task` 中新增“人力预估页面专项采集”命令，用于打开 `taskhrmy` 页面、录制人工操作期间的网络请求，并输出全量抓包和候选提交请求。

**Architecture:** 保留现有子计划创建主流程不变，新增一套轻量配置模型和专项录制入口。认证层继续复用 `ItmsAuthManager`，录制层在 `discovery.py` 中新增面向专项采集的类，CLI 层在 `workflow.py` 中新增 `discover-manpower` 命令并落到独立配置与独立输出文件。

**Tech Stack:** Python 3、Playwright、requests、pytest

---

### Task 1: 新增专项采集配置模型与加载器

**Files:**
- Modify: `python-tools/universal_Automation-Create-Task/itms_create_task/models.py`
- Modify: `python-tools/universal_Automation-Create-Task/itms_create_task/config_loader.py`
- Create: `python-tools/universal_Automation-Create-Task/tests/test_manpower_config_loader.py`

- [ ] **Step 1: 写失败测试，锁定专项配置结构与默认值**

```python
from pathlib import Path

from itms_create_task.config_loader import load_manpower_config


def test_load_manpower_config_resolves_runtime_paths(tmp_path):
    config_path = tmp_path / "manpower.json"
    config_path.write_text(
        """
        {
          "base_url": "http://itms.tinno.com",
          "entry_url": "http://itms.tinno.com/#/manpowerhub/manpower/task?tab=taskhrmy",
          "page_name": "我的预估任务管理",
          "browser": {
            "storage_state_path": ".runtime/itms_storage_state.json"
          },
          "auth": {},
          "capture": {
            "discovery_output_path": ".runtime/manpower_task_capture.json",
            "candidate_output_path": ".runtime/manpower_task_candidate.json",
            "create_keywords": ["manpower", "submit"]
          }
        }
        """,
        encoding="utf-8",
    )

    config = load_manpower_config(str(config_path))

    assert config.base_url == "http://itms.tinno.com"
    assert config.entry_url.endswith("tab=taskhrmy")
    assert config.page_name == "我的预估任务管理"
    assert config.workbench_url == "http://itms.tinno.com/#/workbench"
    assert Path(config.browser.storage_state_path).is_absolute()
    assert Path(config.capture.discovery_output_path).is_absolute()
    assert Path(config.capture.candidate_output_path).is_absolute()
    assert config.capture.create_keywords == ["manpower", "submit"]


def test_load_manpower_config_uses_capture_defaults(tmp_path):
    config_path = tmp_path / "manpower.json"
    config_path.write_text(
        """
        {
          "entry_url": "http://itms.tinno.com/#/manpowerhub/manpower/task?tab=taskhrmy",
          "capture": {}
        }
        """,
        encoding="utf-8",
    )

    config = load_manpower_config(str(config_path))

    assert config.base_url == "http://itms.tinno.com"
    assert config.page_name == "人力预估页面"
    assert config.capture.create_keywords == ["manpower", "task", "estimate", "save", "submit", "create", "add"]
```

- [ ] **Step 2: 运行测试并确认当前失败**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_config_loader.py -v`

Expected: FAIL，报 `ImportError: cannot import name 'load_manpower_config'` 或缺少专项配置模型字段。

- [ ] **Step 3: 增加专项采集 dataclass 和加载函数**

在 `models.py` 追加：

```python
@dataclass
class CaptureConfig:
    """专项录制配置。"""

    discovery_output_path: str = ".runtime/manpower_task_capture.json"
    candidate_output_path: str = ".runtime/manpower_task_candidate.json"
    create_keywords: List[str] = field(
        default_factory=lambda: ["manpower", "task", "estimate", "save", "submit", "create", "add"]
    )


@dataclass
class ManpowerCaptureConfig:
    """人力预估专项采集配置。"""

    config_path: str
    base_url: str
    workbench_url: str
    entry_url: str
    page_name: str
    browser: BrowserConfig
    auth: AuthConfig
    capture: CaptureConfig
```

在 `config_loader.py` 追加：

```python
from .models import (
    ApiConfig,
    AuthConfig,
    BrowserConfig,
    CaptureConfig,
    ItmsToolConfig,
    ManpowerCaptureConfig,
    UiConfig,
    UiFieldBinding,
)


def load_manpower_config(config_path: str) -> ManpowerCaptureConfig:
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

    return ManpowerCaptureConfig(
        config_path=str(Path(config_path).resolve()),
        base_url=raw.get("base_url", "http://itms.tinno.com"),
        workbench_url=raw.get("workbench_url", "http://itms.tinno.com/#/workbench"),
        entry_url=raw["entry_url"],
        page_name=raw.get("page_name", "人力预估页面"),
        browser=browser,
        auth=auth,
        capture=capture,
    )
```

- [ ] **Step 4: 重新运行配置测试**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_config_loader.py -v`

Expected: PASS，两个配置加载测试通过。

- [ ] **Step 5: 检查本任务改动边界**

Run: `cd F:\automation-toolkit; git diff -- python-tools/universal_Automation-Create-Task/itms_create_task/models.py python-tools/universal_Automation-Create-Task/itms_create_task/config_loader.py python-tools/universal_Automation-Create-Task/tests/test_manpower_config_loader.py`

Expected: 仅包含专项采集配置模型、加载函数和对应测试；不应混入子计划业务改动。

### Task 2: 新增专项录制器并补充候选筛选测试

**Files:**
- Modify: `python-tools/universal_Automation-Create-Task/itms_create_task/discovery.py`
- Create: `python-tools/universal_Automation-Create-Task/tests/test_manpower_discovery.py`

- [ ] **Step 1: 先写失败测试，固定筛选规则和落盘行为**

```python
import json

from itms_create_task.discovery import ManpowerCaptureDiscovery
from itms_create_task.models import CaptureConfig, ManpowerCaptureConfig, BrowserConfig, AuthConfig


class DummyAuthManager:
    def build_context_kwargs(self):
        return {}


def build_config(tmp_path):
    return ManpowerCaptureConfig(
        config_path=str(tmp_path / "manpower.json"),
        base_url="http://itms.tinno.com",
        workbench_url="http://itms.tinno.com/#/workbench",
        entry_url="http://itms.tinno.com/#/manpowerhub/manpower/task?tab=taskhrmy",
        page_name="我的预估任务管理",
        browser=BrowserConfig(storage_state_path=str(tmp_path / ".runtime" / "itms_storage_state.json")),
        auth=AuthConfig(),
        capture=CaptureConfig(
            discovery_output_path=str(tmp_path / ".runtime" / "manpower_task_capture.json"),
            candidate_output_path=str(tmp_path / ".runtime" / "manpower_task_candidate.json"),
            create_keywords=["manpower", "submit"],
        ),
    )


def test_select_candidate_uses_last_matching_write_request(tmp_path):
    config = build_config(tmp_path)
    discovery = ManpowerCaptureDiscovery(config, DummyAuthManager())
    captures = [
        {
            "method": "GET",
            "url": "http://itms.tinno.com/api/manpower/task/list",
            "request_headers": {},
            "response_headers": {},
            "post_data": None,
            "response_status": 200,
            "response_body": "{}",
        },
        {
            "method": "POST",
            "url": "http://itms.tinno.com/api/manpower/task/save",
            "request_headers": {"content-type": "application/json"},
            "response_headers": {},
            "post_data": "{\"name\":\"draft\"}",
            "response_status": 200,
            "response_body": "{}",
        },
        {
            "method": "POST",
            "url": "http://itms.tinno.com/api/manpower/task/submit",
            "request_headers": {"content-type": "application/json"},
            "response_headers": {},
            "post_data": "{\"name\":\"final\"}",
            "response_status": 200,
            "response_body": "{\"errno\":0}",
        },
    ]

    candidate = discovery._select_candidate_from_dicts(captures)

    assert candidate["url"].endswith("/submit")
    assert candidate["body_sample"] == {"name": "final"}


def test_write_capture_outputs_persists_both_files(tmp_path):
    config = build_config(tmp_path)
    discovery = ManpowerCaptureDiscovery(config, DummyAuthManager())
    captures = [
        {
            "method": "POST",
            "url": "http://itms.tinno.com/api/manpower/task/submit",
            "request_headers": {"content-type": "application/json"},
            "response_headers": {},
            "post_data": "{\"name\":\"final\"}",
            "response_status": 200,
            "response_body": "{\"errno\":0}",
        }
    ]

    payload = discovery._write_capture_outputs(captures)

    assert payload["candidate_request"]["url"].endswith("/submit")
    capture_path = tmp_path / ".runtime" / "manpower_task_capture.json"
    candidate_path = tmp_path / ".runtime" / "manpower_task_candidate.json"
    assert capture_path.exists()
    assert candidate_path.exists()
    assert json.loads(candidate_path.read_text(encoding="utf-8"))["url"].endswith("/submit")
```

- [ ] **Step 2: 运行测试并确认当前失败**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_discovery.py -v`

Expected: FAIL，报 `ImportError: cannot import name 'ManpowerCaptureDiscovery'`。

- [ ] **Step 3: 在 `discovery.py` 增加专项录制类和公共写出逻辑**

追加并复用现有 `RecordedRequest` 结构：

```python
from .models import ItmsToolConfig, ManpowerCaptureConfig, RecordedRequest


class ManpowerCaptureDiscovery:
    """录制人力预估页面的人工操作请求。"""

    def __init__(self, config: ManpowerCaptureConfig, auth_manager):
        self.config = config
        self.auth_manager = auth_manager

    def record_manual_flow(self) -> Dict[str, object]:
        """打开专项页面并录制人工操作请求。"""
        captures: List[RecordedRequest] = []
        capture_path = Path(self.config.capture.discovery_output_path)
        candidate_path = Path(self.config.capture.candidate_output_path)
        capture_path.parent.mkdir(parents=True, exist_ok=True)
        candidate_path.parent.mkdir(parents=True, exist_ok=True)

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
                if request.resource_type not in ("fetch", "xhr", "document"):
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
            page.goto(self.config.entry_url)

            print("浏览器已启动，开始录制人力预估页面网络请求。")
            print("请手动完成一次“添加任务并提交”的完整动作。")
            print("完成后回到终端按回车，脚本会保存录制结果。")
            input()

            context.storage_state(path=self.config.browser.storage_state_path)
            browser.close()

        return self._write_capture_outputs([capture.__dict__ for capture in captures])

    def _write_capture_outputs(self, captures: List[Dict[str, object]]) -> Dict[str, object]:
        payload = {
            "captures": captures,
            "candidate_request": self._select_candidate_from_dicts(captures),
        }

        capture_path = Path(self.config.capture.discovery_output_path)
        candidate_path = Path(self.config.capture.candidate_output_path)

        with open(capture_path, "w", encoding="utf-8") as file_obj:
            json.dump(payload, file_obj, ensure_ascii=False, indent=2)

        if payload["candidate_request"]:
            with open(candidate_path, "w", encoding="utf-8") as file_obj:
                json.dump(payload["candidate_request"], file_obj, ensure_ascii=False, indent=2)

        return payload

    def _select_candidate_from_dicts(self, captures: List[Dict[str, object]]) -> Optional[Dict[str, object]]:
        keywords = [item.lower() for item in self.config.capture.create_keywords]
        filtered = []

        for capture in captures:
            method = str(capture.get("method", "")).upper()
            url = str(capture.get("url", ""))
            post_data = capture.get("post_data")
            if method not in ("POST", "PUT", "PATCH"):
                continue
            if keywords and not any(keyword in url.lower() for keyword in keywords):
                continue
            if not post_data:
                continue
            filtered.append(capture)

        if not filtered:
            return None

        candidate = filtered[-1]
        return {
            "method": candidate["method"],
            "url": candidate["url"],
            "request_headers": self._filter_headers(candidate.get("request_headers", {})),
            "body_sample": self._try_parse_json(candidate.get("post_data")) or candidate.get("post_data"),
        }

    @staticmethod
    def _try_parse_json(value):
        if value is None:
            return None
        try:
            return json.loads(value)
        except (json.JSONDecodeError, TypeError):
            return None

    @staticmethod
    def _filter_headers(headers: Dict[str, object]) -> Dict[str, object]:
        allowed = {}
        for key, value in headers.items():
            key_lower = key.lower()
            if key_lower in ("content-type", "x-requested-with", "x-xsrf-token", "x-csrf-token"):
                allowed[key] = value
        return allowed
```

- [ ] **Step 4: 运行专项录制测试**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_discovery.py -v`

Expected: PASS，候选筛选和落盘测试通过。

- [ ] **Step 5: 检查本任务改动边界**

Run: `cd F:\automation-toolkit; git diff -- python-tools/universal_Automation-Create-Task/itms_create_task/discovery.py python-tools/universal_Automation-Create-Task/tests/test_manpower_discovery.py`

Expected: 仅包含专项录制类、候选筛选与落盘逻辑，以及对应测试。

### Task 3: 接入 CLI、新增示例配置并补充命令分发测试

**Files:**
- Modify: `python-tools/universal_Automation-Create-Task/itms_create_task/workflow.py`
- Create: `python-tools/universal_Automation-Create-Task/examples/manpower_config.example.json`
- Create: `python-tools/universal_Automation-Create-Task/tests/test_manpower_workflow.py`

- [ ] **Step 1: 先写失败测试，固定 CLI 行为**

```python
from types import SimpleNamespace

import itms_create_task.workflow as workflow


def test_build_parser_supports_discover_manpower():
    parser = workflow.build_parser()
    args = parser.parse_args(["discover-manpower", "--config", "examples/manpower_config.example.json"])

    assert args.command == "discover-manpower"


def test_main_dispatches_discover_manpower(monkeypatch):
    events = []

    class DummyDiscovery:
        def __init__(self, config, auth_manager):
            events.append(("init", config.entry_url))

        def record_manual_flow(self):
            events.append(("record", True))
            return {"candidate_request": {"url": "http://itms.tinno.com/api/manpower/task/submit"}}

    monkeypatch.setattr(workflow, "setup_logging", lambda: None)
    monkeypatch.setattr(workflow, "load_manpower_config", lambda path: SimpleNamespace(entry_url="http://itms.tinno.com/#/manpowerhub/manpower/task?tab=taskhrmy"))
    monkeypatch.setattr(workflow, "ItmsAuthManager", lambda config: object())
    monkeypatch.setattr(workflow, "ManpowerCaptureDiscovery", DummyDiscovery)
    monkeypatch.setattr(workflow.sys, "argv", ["main.py", "discover-manpower", "--config", "examples/manpower_config.example.json"])

    assert workflow.main() == 0
    assert events == [
        ("init", "http://itms.tinno.com/#/manpowerhub/manpower/task?tab=taskhrmy"),
        ("record", True),
    ]
```

- [ ] **Step 2: 运行测试并确认当前失败**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_workflow.py -v`

Expected: FAIL，`discover-manpower` 尚未加入 CLI，且 `load_manpower_config`、`ManpowerCaptureDiscovery` 尚未接入。

- [ ] **Step 3: 接入命令分发并新增专项配置样例**

在 `workflow.py` 中修改导入与命令集合：

```python
from .config_loader import load_config, load_form_data, load_manpower_config
from .discovery import ApiDiscovery, ManpowerCaptureDiscovery


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description="ITMS 子计划自动化创建工具")
    parser.add_argument(
        "command",
        choices=["auth", "discover", "discover-manpower", "run", "ui", "api", "inspect-options"],
        help="执行模式",
    )
    parser.add_argument("--config", default="examples/itms_config.example.json", help="配置文件路径")
    parser.add_argument("--form", help="表单数据 JSON 文件路径")
    parser.add_argument("--excel", help="Excel/CSV 表单文件路径")
    parser.add_argument("--sheet", help="Excel 工作表名称")
    parser.add_argument("--header-row", type=int, default=1, help="Excel 表头所在行，默认第 1 行")
    parser.add_argument("--project-name", help="覆盖项目名")
    parser.add_argument("--main-plan-name", help="覆盖主计划名")
    parser.add_argument("--testsuite-component-name", help="覆盖测试组件名")
    parser.add_argument("--task-type", help="覆盖任务类型")
    parser.add_argument("--task-sub-type", help="覆盖任务子类型")
    parser.add_argument("--owner-name", help="覆盖 Owner 名")
    parser.add_argument("--sub-plan-name", help="覆盖子计划名")
    return parser
```

在 `main()` 中加入专项分支：

```python
    if args.command == "discover-manpower":
        config = load_manpower_config(args.config)
        auth_manager = ItmsAuthManager(config)
        discovery = ManpowerCaptureDiscovery(config, auth_manager)
        payload = discovery.record_manual_flow()
        print(json.dumps(payload.get("candidate_request"), ensure_ascii=False, indent=2))
        return 0

    config = load_config(args.config)
    form_items = load_form_items(args)
```

新增 `examples/manpower_config.example.json`：

```json
{
  "base_url": "http://itms.tinno.com",
  "workbench_url": "http://itms.tinno.com/#/workbench",
  "entry_url": "http://itms.tinno.com/#/manpowerhub/manpower/task?tab=taskhrmy",
  "page_name": "我的预估任务管理",
  "browser": {
    "headless": false,
    "slow_mo_ms": 150,
    "timeout_ms": 20000,
    "storage_state_path": ".runtime/itms_storage_state.json"
  },
  "auth": {
    "auto_relogin": false,
    "login_url": "http://itms.tinno.com/#/workbench",
    "username_env": "ITMS_USERNAME",
    "password_env": "ITMS_PASSWORD",
    "username_selector": "",
    "password_selector": "",
    "submit_selector": "",
    "success_url_contains": "#/workbench",
    "success_wait_ms": 15000
  },
  "capture": {
    "discovery_output_path": ".runtime/manpower_task_capture.json",
    "candidate_output_path": ".runtime/manpower_task_candidate.json",
    "create_keywords": ["manpower", "task", "estimate", "save", "submit", "create", "add"]
  }
}
```

- [ ] **Step 4: 运行命令分发测试**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_workflow.py -v`

Expected: PASS，`discover-manpower` 命令解析和分发测试通过。

- [ ] **Step 5: 检查本任务改动边界**

Run: `cd F:\automation-toolkit; git diff -- python-tools/universal_Automation-Create-Task/itms_create_task/workflow.py python-tools/universal_Automation-Create-Task/examples/manpower_config.example.json python-tools/universal_Automation-Create-Task/tests/test_manpower_workflow.py`

Expected: 仅包含新命令分发、专项配置样例和对应 workflow 测试。

### Task 4: 更新使用文档并完成专项采集联调

**Files:**
- Modify: `python-tools/universal_Automation-Create-Task/README.md`

- [ ] **Step 1: 先补一个文档快照检查测试**

```python
from pathlib import Path


def test_readme_mentions_discover_manpower_command():
    readme = Path("README.md").read_text(encoding="utf-8")

    assert "discover-manpower" in readme
    assert "manpower_config.example.json" in readme
    assert "manpower_task_capture.json" in readme
```

将该测试追加到 `python-tools/universal_Automation-Create-Task/tests/test_manpower_workflow.py`。

- [ ] **Step 2: 运行测试并确认当前失败**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_workflow.py -v`

Expected: FAIL，README 尚未包含专项采集说明。

- [ ] **Step 3: 更新 README，加入专项采集使用方式**

在 `README.md` 增加一节：

````markdown
### 6. 录制人力预估页面提交请求

```powershell
python main.py discover-manpower --config examples\manpower_config.example.json
```

说明：

- 该命令会打开 `#/manpowerhub/manpower/task?tab=taskhrmy`
- 请手动完成一次“添加任务并提交”
- 完成后回到终端按回车
- 全量抓包会输出到 `.runtime/manpower_task_capture.json`
- 候选提交请求会输出到 `.runtime/manpower_task_candidate.json`
```
````

- [ ] **Step 4: 运行完整专项测试并做一次人工联调**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_config_loader.py tests/test_manpower_discovery.py tests/test_manpower_workflow.py -v`

Expected: PASS，专项采集相关测试全部通过。

人工联调命令：

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; python main.py discover-manpower --config examples\manpower_config.example.json`

Expected:
- 浏览器正常打开 `taskhrmy` 页面
- 人工提交后能生成 `examples\.runtime\manpower_task_capture.json`
- 若筛选成功，还会生成 `examples\.runtime\manpower_task_candidate.json`

- [ ] **Step 5: 检查最终改动边界**

Run: `cd F:\automation-toolkit; git diff -- python-tools/universal_Automation-Create-Task/README.md python-tools/universal_Automation-Create-Task/tests/test_manpower_workflow.py`

Expected: 仅包含专项采集说明文档与 README 断言测试，不应混入额外实现改动。
