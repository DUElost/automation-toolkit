# 人力预估接口自动提交 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 为 `universal_Automation-Create-Task` 新增 `create-manpower` 命令，复用现有登录态直接调用 `POST /api/task/hrestimate/create` 自动提交人力预估。

**Architecture:** 新增一个独立的 `manpower_api.py` 作为人力预估接口客户端，负责当前用户查询、`daterange` 生成、`weekList` 拆分和创建请求提交。CLI 层在 `workflow.py` 增加 `create-manpower` 分支，示例输入和 README 单独补齐，不污染现有“子计划创建”逻辑。

**Tech Stack:** Python 3、requests、Playwright storage_state、pytest、openpyxl

---

### Task 1: 增加人力预估请求体生成与当前用户解析

**Files:**
- Create: `python-tools/universal_Automation-Create-Task/itms_create_task/manpower_api.py`
- Create: `python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`

- [ ] **Step 1: 写失败测试，固定当前用户解析、`daterange` 和单周 `weekList` 行为**

```python
# -*- coding: utf-8 -*-
from types import SimpleNamespace

from itms_create_task.manpower_api import ManpowerApiClient


class DummySession:
    def __init__(self, payload):
        self.payload = payload

    def get(self, url, params=None, timeout=30):
        return SimpleNamespace(json=lambda: self.payload, text=str(self.payload), status_code=200, ok=True, url=url)


class DummyAuthManager:
    def __init__(self, payload):
        self.payload = payload

    def create_requests_session(self, auto_refresh=True):
        return DummySession(self.payload)


def build_config():
    return SimpleNamespace(base_url="http://itms.tinno.com")


def test_build_request_payload_uses_current_user_id():
    auth_manager = DummyAuthManager(
        {"errno": 0, "data": {"userId": "65417411391957279", "nickName": "桂雨旺", "email": "yuwang.gui@tinno.com"}}
    )
    client = ManpowerApiClient(build_config(), auth_manager)

    payload = client.build_request_payload(
        {
            "projectName": "V657",
            "taskName": "第九轮稳定性挂测",
            "site": "南昌",
            "groupType": "系统",
            "beginDate": "2026-04-06",
            "endDate": "2026-04-12",
            "standardWorkHours": 32,
        }
    )

    assert payload["leaderId"] == "65417411391957279"
    assert payload["daterange"] == ["2026-04-05T16:00:00.000Z", "2026-04-11T16:00:00.000Z"]
    assert payload["weekList"] == [
        {
            "year": "2026",
            "week": 15,
            "splitBeginDate": "2026-04-06",
            "splitEndDate": "2026-04-12",
            "standardWorkHours": 32,
        }
    ]
```

- [ ] **Step 2: 运行测试并确认当前失败**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py::test_build_request_payload_uses_current_user_id -v`

Expected: FAIL，报 `ModuleNotFoundError: No module named 'itms_create_task.manpower_api'`。

- [ ] **Step 3: 用最小实现创建 `ManpowerApiClient` 和纯函数辅助逻辑**

```python
# -*- coding: utf-8 -*-
"""
人力预估接口提交流程。
"""

from datetime import datetime, timedelta
from typing import Any, Dict, List


class ManpowerApiClient:
    """人力预估接口客户端。"""

    REQUIRED_FIELDS = ("projectName", "taskName", "site", "groupType", "beginDate", "endDate", "standardWorkHours")

    def __init__(self, config, auth_manager):
        self.config = config
        self.auth_manager = auth_manager

    def get_current_user(self) -> Dict[str, Any]:
        """获取当前登录用户。"""
        session = self.auth_manager.create_requests_session(auto_refresh=True)
        response = session.get(self.config.base_url.rstrip("/") + "/api/auth/info", params={}, timeout=30)
        payload = response.json()
        if payload.get("errno") not in (None, 0):
            raise RuntimeError("获取当前用户失败: %s" % payload.get("errmsg", ""))
        data = payload.get("data", {})
        if "userId" in data and "id" not in data:
            data["id"] = data["userId"]
        return data

    def build_request_payload(self, form_data: Dict[str, Any]) -> Dict[str, Any]:
        """构造创建请求体。"""
        self._validate_form_data(form_data)
        current_user = self.get_current_user()
        begin_date = self._parse_date(str(form_data["beginDate"]))
        end_date = self._parse_date(str(form_data["endDate"]))
        if begin_date > end_date:
            raise ValueError("beginDate 不能大于 endDate")

        return {
            "projectName": form_data["projectName"],
            "taskName": form_data["taskName"],
            "site": form_data["site"],
            "groupType": form_data["groupType"],
            "beginDate": form_data["beginDate"],
            "endDate": form_data["endDate"],
            "leaderId": str(current_user.get("id") or current_user.get("userId") or ""),
            "daterange": self._build_daterange(begin_date, end_date),
            "weekList": self._build_week_list(begin_date, end_date, int(form_data["standardWorkHours"])),
        }

    @classmethod
    def _validate_form_data(cls, form_data: Dict[str, Any]) -> None:
        missing = [field for field in cls.REQUIRED_FIELDS if form_data.get(field) in (None, "")]
        if missing:
            raise ValueError("缺少必填字段: %s" % ",".join(missing))

    @staticmethod
    def _parse_date(value: str) -> datetime.date:
        return datetime.strptime(value, "%Y-%m-%d").date()

    @staticmethod
    def _build_daterange(begin_date, end_date) -> List[str]:
        start_dt = datetime(begin_date.year, begin_date.month, begin_date.day) - timedelta(hours=8)
        end_dt = datetime(end_date.year, end_date.month, end_date.day) - timedelta(hours=8)
        return [
            start_dt.strftime("%Y-%m-%dT%H:%M:%S.000Z"),
            end_dt.strftime("%Y-%m-%dT%H:%M:%S.000Z"),
        ]

    @staticmethod
    def _build_week_list(begin_date, end_date, standard_work_hours: int) -> List[Dict[str, Any]]:
        items = []
        cursor = begin_date
        while cursor <= end_date:
            week_start = cursor
            week_end = min(end_date, cursor + timedelta(days=(6 - cursor.weekday())))
            iso_year, iso_week, _ = week_start.isocalendar()
            items.append(
                {
                    "year": str(iso_year),
                    "week": iso_week,
                    "splitBeginDate": week_start.strftime("%Y-%m-%d"),
                    "splitEndDate": week_end.strftime("%Y-%m-%d"),
                    "standardWorkHours": standard_work_hours,
                }
            )
            cursor = week_end + timedelta(days=1)
        return items
```

- [ ] **Step 4: 重新运行单周请求体测试**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py::test_build_request_payload_uses_current_user_id -v`

Expected: PASS。

- [ ] **Step 5: 检查本任务改动边界**

Run: `cd F:\automation-toolkit; git diff -- python-tools/universal_Automation-Create-Task/itms_create_task/manpower_api.py python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`

Expected: 仅包含人力预估请求体生成与对应测试。

### Task 2: 补跨周拆分、缺字段校验和创建接口调用测试

**Files:**
- Modify: `python-tools/universal_Automation-Create-Task/itms_create_task/manpower_api.py`
- Modify: `python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`

- [ ] **Step 1: 追加失败测试，锁定跨周拆分、缺字段报错和创建请求提交**

```python
import pytest


class RecordingSession:
    def __init__(self, get_payload):
        self.get_payload = get_payload
        self.requests = []

    def get(self, url, params=None, timeout=30):
        return SimpleNamespace(json=lambda: self.get_payload, text=str(self.get_payload), status_code=200, ok=True, url=url)

    def request(self, method, url, json=None, data=None, headers=None, timeout=30):
        self.requests.append({"method": method, "url": url, "json": json, "data": data, "headers": headers})
        return SimpleNamespace(json=lambda: {"errno": 0, "errmsg": "成功"}, text='{"errno":0,"errmsg":"成功"}', status_code=200, ok=True, url=url)


class RecordingAuthManager:
    def __init__(self, get_payload):
        self.session = RecordingSession(get_payload)

    def create_requests_session(self, auto_refresh=True):
        return self.session


def test_build_request_payload_splits_cross_week_ranges():
    auth_manager = DummyAuthManager({"errno": 0, "data": {"userId": "65417411391957279"}})
    client = ManpowerApiClient(build_config(), auth_manager)

    payload = client.build_request_payload(
        {
            "projectName": "V657",
            "taskName": "跨周任务",
            "site": "南昌",
            "groupType": "系统",
            "beginDate": "2026-04-10",
            "endDate": "2026-04-14",
            "standardWorkHours": 32,
        }
    )

    assert payload["weekList"] == [
        {"year": "2026", "week": 15, "splitBeginDate": "2026-04-10", "splitEndDate": "2026-04-12", "standardWorkHours": 32},
        {"year": "2026", "week": 16, "splitBeginDate": "2026-04-13", "splitEndDate": "2026-04-14", "standardWorkHours": 32},
    ]


def test_build_request_payload_rejects_missing_standard_work_hours():
    auth_manager = DummyAuthManager({"errno": 0, "data": {"userId": "65417411391957279"}})
    client = ManpowerApiClient(build_config(), auth_manager)

    with pytest.raises(ValueError, match="standardWorkHours"):
        client.build_request_payload(
            {
                "projectName": "V657",
                "taskName": "缺工时",
                "site": "南昌",
                "groupType": "系统",
                "beginDate": "2026-04-06",
                "endDate": "2026-04-12",
            }
        )


def test_create_estimate_posts_to_hrestimate_create():
    auth_manager = RecordingAuthManager({"errno": 0, "data": {"userId": "65417411391957279"}})
    client = ManpowerApiClient(build_config(), auth_manager)

    result = client.create_estimate(
        {
            "projectName": "V657",
            "taskName": "接口提交",
            "site": "南昌",
            "groupType": "系统",
            "beginDate": "2026-04-06",
            "endDate": "2026-04-12",
            "standardWorkHours": 32,
        }
    )

    assert result["success"] is True
    assert auth_manager.session.requests[0]["method"] == "POST"
    assert auth_manager.session.requests[0]["url"] == "http://itms.tinno.com/api/task/hrestimate/create"
    assert auth_manager.session.requests[0]["json"]["leaderId"] == "65417411391957279"
```

- [ ] **Step 2: 运行测试并确认当前失败**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py::test_build_request_payload_splits_cross_week_ranges tests/test_manpower_api.py::test_build_request_payload_rejects_missing_standard_work_hours tests/test_manpower_api.py::test_create_estimate_posts_to_hrestimate_create -v`

Expected: FAIL，`create_estimate` 尚未实现。

- [ ] **Step 3: 在客户端补齐创建接口调用和结果标准化**

```python
    def create_estimate(self, form_data: Dict[str, Any]) -> Dict[str, Any]:
        """提交人力预估。"""
        session = self.auth_manager.create_requests_session(auto_refresh=True)
        payload = self.build_request_payload(form_data)
        response = session.request(
            method="POST",
            url=self.config.base_url.rstrip("/") + "/api/task/hrestimate/create",
            json=payload,
            headers={"content-type": "application/json;charset=UTF-8"},
            timeout=30,
        )
        response_text = response.text
        try:
            body = response.json()
        except ValueError:
            body = {}
        success = response.ok and body.get("errno") in (None, 0)
        return {
            "success": success,
            "status_code": response.status_code,
            "request_body": payload,
            "response_body": response_text[:4000],
        }
```

- [ ] **Step 4: 运行整组 API 测试**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py -v`

Expected: PASS。

- [ ] **Step 5: 检查本任务改动边界**

Run: `cd F:\automation-toolkit; git diff -- python-tools/universal_Automation-Create-Task/itms_create_task/manpower_api.py python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`

Expected: 仅包含跨周拆分、缺字段校验、创建接口调用和对应测试。

### Task 3: 接入 CLI 命令与表单样例

**Files:**
- Modify: `python-tools/universal_Automation-Create-Task/itms_create_task/workflow.py`
- Create: `python-tools/universal_Automation-Create-Task/examples/manpower_form.example.json`
- Create: `python-tools/universal_Automation-Create-Task/examples/manpower_form_template.csv`
- Modify: `python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`

- [ ] **Step 1: 追加失败测试，锁定 `create-manpower` 命令分发**

```python
import itms_create_task.workflow as workflow


def test_build_parser_supports_create_manpower():
    parser = workflow.build_parser()
    args = parser.parse_args(["create-manpower", "--config", "examples/manpower_config.example.json", "--form", "examples/manpower_form.example.json"])

    assert args.command == "create-manpower"


def test_main_dispatches_create_manpower(monkeypatch):
    calls = []

    class DummyClient:
        def __init__(self, config, auth_manager):
            calls.append(("init", True))

        def create_estimate(self, form_data):
            calls.append(("create", form_data["taskName"]))
            return {"success": True}

    monkeypatch.setattr(workflow, "setup_logging", lambda: None)
    monkeypatch.setattr(workflow, "load_manpower_config", lambda path: SimpleNamespace(base_url="http://itms.tinno.com"))
    monkeypatch.setattr(workflow, "load_form_data", lambda path: {"taskName": "接口提交"})
    monkeypatch.setattr(workflow, "ItmsAuthManager", lambda config: object())
    monkeypatch.setattr(workflow, "ManpowerApiClient", DummyClient)
    monkeypatch.setattr(
        workflow.sys,
        "argv",
        ["main.py", "create-manpower", "--config", "examples/manpower_config.example.json", "--form", "examples/manpower_form.example.json"],
    )

    assert workflow.main() == 0
    assert calls == [("init", True), ("create", "接口提交")]
```

- [ ] **Step 2: 运行测试并确认当前失败**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py::test_build_parser_supports_create_manpower tests/test_manpower_api.py::test_main_dispatches_create_manpower -v`

Expected: FAIL，`create-manpower` 尚未加入 CLI，且 `ManpowerApiClient` 未接入。

- [ ] **Step 3: 在 `workflow.py` 增加命令分发，并新增表单样例文件**

```python
from .manpower_api import ManpowerApiClient


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description="ITMS 子计划自动化创建工具")
    parser.add_argument(
        "command",
        choices=["auth", "discover", "discover-manpower", "create-manpower", "run", "ui", "api", "inspect-options"],
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


def main() -> int:
    setup_logging()
    parser = build_parser()
    args = parser.parse_args()

    if args.command == "discover-manpower":
        config = load_manpower_config(args.config)
        auth_manager = ItmsAuthManager(config)
        discovery = ManpowerCaptureDiscovery(config, auth_manager)
        payload = discovery.record_manual_flow()
        print(json.dumps(payload.get("candidate_request"), ensure_ascii=False, indent=2))
        return 0

    if args.command == "create-manpower":
        config = load_manpower_config(args.config)
        form_items = load_form_items(args)
        auth_manager = ItmsAuthManager(config)
        client = ManpowerApiClient(config, auth_manager)
        results = [client.create_estimate(form_data) for form_data in form_items]
        print(json.dumps(results[0] if len(results) == 1 else results, ensure_ascii=False, indent=2))
        return 0 if all(item.get("success") for item in results) else 1
```

新增 `examples/manpower_form.example.json`：

```json
{
  "projectName": "V657",
  "taskName": "第九轮稳定性挂测",
  "site": "南昌",
  "groupType": "系统",
  "beginDate": "2026-04-06",
  "endDate": "2026-04-12",
  "standardWorkHours": 32
}
```

新增 `examples/manpower_form_template.csv`：

```csv
projectName,taskName,site,groupType,beginDate,endDate,standardWorkHours
V657,第九轮稳定性挂测,南昌,系统,2026-04-06,2026-04-12,32
```

- [ ] **Step 4: 运行 CLI 分发测试**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py::test_build_parser_supports_create_manpower tests/test_manpower_api.py::test_main_dispatches_create_manpower -v`

Expected: PASS。

- [ ] **Step 5: 检查本任务改动边界**

Run: `cd F:\automation-toolkit; git diff -- python-tools/universal_Automation-Create-Task/itms_create_task/workflow.py python-tools/universal_Automation-Create-Task/examples/manpower_form.example.json python-tools/universal_Automation-Create-Task/examples/manpower_form_template.csv python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`

Expected: 仅包含 `create-manpower` 命令分发、表单样例和对应测试。

### Task 4: 更新 README 并完成专项验证

**Files:**
- Modify: `python-tools/universal_Automation-Create-Task/README.md`
- Modify: `python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`

- [ ] **Step 1: 追加失败测试，锁定 README 中的 `create-manpower` 文档**

```python
from pathlib import Path


def test_readme_mentions_create_manpower_command():
    content = (Path(__file__).resolve().parents[1] / "README.md").read_text(encoding="utf-8")

    assert "create-manpower" in content
    assert "manpower_form.example.json" in content
    assert "standardWorkHours" in content
```

- [ ] **Step 2: 运行测试并确认当前失败**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py::test_readme_mentions_create_manpower_command -v`

Expected: FAIL，README 尚未包含接口提交说明。

- [ ] **Step 3: 在 README 追加接口提交用法**

````markdown
### 7. 直接提交人力预估

```powershell
python main.py create-manpower --config examples\manpower_config.example.json --form examples\manpower_form.example.json
```

说明：

- 该命令直接调用 `POST /api/task/hrestimate/create`
- 当前登录用户会自动作为 `leaderId`
- `standardWorkHours` 需要在表单中显式传入
- 支持通过 `--excel` 批量提交
````

- [ ] **Step 4: 运行完整专项测试并进行一次人工联调**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_capture.py tests/test_manpower_api.py -v`

Expected: PASS。

人工联调命令：

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; python main.py create-manpower --config examples\manpower_config.example.json --form examples\manpower_form.example.json`

Expected:
- 能自动读取当前登录用户 `userId`
- 能调用 `POST /api/task/hrestimate/create`
- 控制台输出标准化 JSON 结果

- [ ] **Step 5: 检查最终改动边界**

Run: `cd F:\automation-toolkit; git diff -- python-tools/universal_Automation-Create-Task/README.md python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py python-tools/universal_Automation-Create-Task/itms_create_task/manpower_api.py python-tools/universal_Automation-Create-Task/itms_create_task/workflow.py python-tools/universal_Automation-Create-Task/examples/manpower_form.example.json python-tools/universal_Automation-Create-Task/examples/manpower_form_template.csv`

Expected: 仅包含人力预估接口提交相关实现、样例和文档，不应混入子计划业务改动。
