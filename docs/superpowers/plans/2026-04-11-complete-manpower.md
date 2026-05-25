# 标记人力预估任务已完成 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 为 `universal_Automation-Create-Task` 增加“标记人力预估任务已完成”的接口能力，以及标准输入和原始周计划 Excel 的两条 CLI 命令。

**Architecture:** 底层在 `manpower_api.py` 中新增独立的 `complete_estimate()`，只负责向 `POST /api/task/hrestimate/update/status` 提交表单编码请求；CLI 在 `workflow.py` 中新增 `complete-manpower` 与 `complete-manpower-from-weekly-plan` 两个分支，并复用现有任务定位与周计划映射逻辑，保持职责边界稳定。

**Tech Stack:** Python 3.11, argparse, requests, openpyxl, pytest

---

## 文件结构

### 需要修改

- `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/manpower_api.py`
  - 新增“标记已完成”接口调用
- `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/workflow.py`
  - 新增两个 CLI 命令分支
- `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`
  - 新增接口请求体、CLI 分发、README 文案测试
- `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/README.md`
  - 增加命令用法

### 不修改

- `create-manpower`
- `assign-manpower-testers`
- `assign-manpower-from-weekly-plan`
- `fill-manpower-actual-from-weekly-plan`

## Task 1: 为“标记已完成”接口写失败测试并最小实现

**Files:**
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/manpower_api.py`

- [ ] **Step 1: 写 `complete_estimate()` 的失败测试**

```python
def test_complete_estimate_posts_form_encoded_status_request():
    auth_manager = SequenceAuthManager(
        post_responses=[RecordingResponse({"errno": 0, "errmsg": "成功"}, text='{"errno":0,"errmsg":"成功"}')]
    )
    client = ManpowerApiClient(build_config(), auth_manager)

    result = client.complete_estimate("estimate-1")

    assert result["success"] is True
    assert auth_manager.session.post_calls[0]["url"] == "http://itms.tinno.com/api/task/hrestimate/update/status"
    assert auth_manager.session.post_calls[0]["data"] == "ids=estimate-1&status=2"
    assert auth_manager.session.post_calls[0]["headers"]["content-type"] == "application/x-www-form-urlencoded; charset=UTF-8"
```

- [ ] **Step 2: 跑测试确认失败**

Run:

```powershell
cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task
$env:PYTHONPATH='.'
pytest tests/test_manpower_api.py::test_complete_estimate_posts_form_encoded_status_request -q
```

Expected:

```text
FAILED
AttributeError: 'ManpowerApiClient' object has no attribute 'complete_estimate'
```

- [ ] **Step 3: 最小实现 `complete_estimate()`**

```python
def complete_estimate(self, estimate_id: str) -> Dict[str, Any]:
    """调用接口将人力预估任务标记为已完成。"""
    if not estimate_id:
        return {"success": False, "status_code": None, "request_body": None, "response_body": "缺少 estimateId"}

    payload = "ids=%s&status=2" % estimate_id
    session = self.auth_manager.create_requests_session(auto_refresh=True)
    try:
        response = session.post(
            self.config.base_url.rstrip("/") + "/api/task/hrestimate/update/status",
            data=payload,
            headers={"content-type": "application/x-www-form-urlencoded; charset=UTF-8"},
            timeout=30,
        )
    except Exception as exc:
        return self.build_failure_result(exc, request_body={"ids": estimate_id, "status": 2})

    response_text = getattr(response, "text", "")
    try:
        response_body = response.json()
    except Exception:
        response_body = None
    success = False
    if bool(getattr(response, "ok", False)) and isinstance(response_body, dict):
        success = response_body.get("errno") in (None, 0)
    return {
        "success": success,
        "status_code": getattr(response, "status_code", None),
        "request_body": {"ids": estimate_id, "status": 2},
        "response_body": response_text[:4000],
    }
```

- [ ] **Step 4: 为表单编码 POST 能力补最小测试支撑**

```python
class SequenceSession:
    def __init__(self, get_responses=None, post_responses=None, post_error=None):
        self.get_responses = list(get_responses or [])
        self.post_responses = list(post_responses or [])
        self.post_error = post_error
        self.get_calls = []
        self.post_calls = []

    def post(self, url, json=None, data=None, headers=None, timeout=None):
        self.post_calls.append({"url": url, "json": json, "data": data, "headers": headers, "timeout": timeout})
        if self.post_error is not None:
            raise self.post_error
        if self.post_responses:
            return self.post_responses.pop(0)
        raise AssertionError("未准备 POST 响应")
```

- [ ] **Step 5: 跑测试确认通过**

Run:

```powershell
cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task
$env:PYTHONPATH='.'
pytest tests/test_manpower_api.py::test_complete_estimate_posts_form_encoded_status_request -q
```

Expected:

```text
1 passed
```

## Task 2: 为 `complete-manpower` CLI 写失败测试并实现

**Files:**
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/workflow.py`

- [ ] **Step 1: 写 `complete-manpower` CLI 测试**

```python
def test_build_parser_supports_complete_manpower():
    parser = workflow.build_parser()

    args = parser.parse_args(["complete-manpower", "--excel", "examples/manpower_form_template.csv"])

    assert args.command == "complete-manpower"


def test_main_dispatches_complete_manpower(monkeypatch, capsys):
    class DummyAuthManager:
        def __init__(self, config):
            self.config = config

    class DummyClient:
        def __init__(self, config, auth_manager):
            pass

        def find_estimate(self, form_data, estimate_id=None):
            return {"success": True, "estimate_id": "estimate-1"}

        def complete_estimate(self, estimate_id):
            return {"success": True, "request_body": {"ids": estimate_id, "status": 2}, "response_body": "ok"}

    monkeypatch.setattr(workflow, "setup_logging", lambda: None)
    monkeypatch.setattr(workflow, "load_manpower_config", lambda path: SimpleNamespace(base_url="http://itms.tinno.com"))
    monkeypatch.setattr(
        workflow,
        "load_form_rows",
        lambda path, sheet_name=None, header_row=1: [{"projectName": "平台类", "taskName": "任务A", "beginDate": "2026-04-06", "endDate": "2026-04-12"}],
    )
    monkeypatch.setattr(workflow, "ItmsAuthManager", DummyAuthManager)
    monkeypatch.setattr(workflow, "ManpowerApiClient", DummyClient)
    monkeypatch.setattr(workflow.sys, "argv", ["main.py", "complete-manpower", "--excel", "examples/manpower_form_template.csv"])

    assert workflow.main() == 0
    assert '"status": 2' in capsys.readouterr().out
```

- [ ] **Step 2: 跑测试确认失败**

Run:

```powershell
cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task
$env:PYTHONPATH='.'
pytest tests/test_manpower_api.py::test_build_parser_supports_complete_manpower tests/test_manpower_api.py::test_main_dispatches_complete_manpower -q
```

Expected:

```text
FAILED
invalid choice: 'complete-manpower'
```

- [ ] **Step 3: 在 `workflow.py` 中新增命令分支**

```python
if args.command == "complete-manpower":
    config = load_manpower_config(_resolve_config_path(args))
    form_items = load_form_items(args)
    if not any(form_items):
        raise SystemExit("complete-manpower 模式需要通过 --form 或 --excel 提供表单数据。")

    auth_manager = ItmsAuthManager(config)
    api_client = ManpowerApiClient(config, auth_manager)
    results = []
    exit_code = 0
    for index, form_data in enumerate(form_items, 1):
        try:
            task_match = api_client.find_estimate(form_data, estimate_id=form_data.get("estimateId"))
        except Exception as exc:
            task_match = {"success": False, "error": str(exc)}
        if task_match.get("success"):
            try:
                complete_result = api_client.complete_estimate(task_match.get("estimate_id"))
            except Exception as exc:
                complete_result = api_client.build_failure_result(exc)
        else:
            complete_result = {"success": False, "skipped": True, "response_body": "任务定位失败，未执行完成标记"}
        if not task_match.get("success") or not complete_result.get("success"):
            exit_code = 1
        results.append({"row_index": index, "input": form_data, "task_match_result": task_match, "complete_result": complete_result})
    print_payload(results[0] if len(results) == 1 else results)
    return exit_code
```

- [ ] **Step 4: 将 `complete-manpower` 加入解析器与默认配置分支**

```python
choices=[
    "auth",
    "discover",
    "discover-manpower",
    "create-manpower",
    "assign-manpower-testers",
    "assign-manpower-from-weekly-plan",
    "fill-manpower-actual-from-weekly-plan",
    "complete-manpower",
    "run-manpower",
    "build-manpower-csv",
    "run",
    "ui",
    "api",
    "inspect-options",
]
```

```python
if args.command in (
    "discover-manpower",
    "create-manpower",
    "assign-manpower-testers",
    "assign-manpower-from-weekly-plan",
    "fill-manpower-actual-from-weekly-plan",
    "complete-manpower",
    "complete-manpower-from-weekly-plan",
    "run-manpower",
):
    return DEFAULT_MANPOWER_CONFIG_PATH
```

- [ ] **Step 5: 跑测试确认通过**

Run:

```powershell
cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task
$env:PYTHONPATH='.'
pytest tests/test_manpower_api.py::test_build_parser_supports_complete_manpower tests/test_manpower_api.py::test_main_dispatches_complete_manpower -q
```

Expected:

```text
2 passed
```

## Task 3: 为 `complete-manpower-from-weekly-plan` 写失败测试并实现

**Files:**
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/workflow.py`

- [ ] **Step 1: 写原始周计划批量完成测试**

```python
def test_build_parser_supports_complete_manpower_from_weekly_plan():
    parser = workflow.build_parser()

    args = parser.parse_args(["complete-manpower-from-weekly-plan", "--excel", "examples/本周项目计划表.xlsx"])

    assert args.command == "complete-manpower-from-weekly-plan"


def test_main_dispatches_complete_manpower_from_weekly_plan(monkeypatch, capsys):
    class DummyAuthManager:
        def __init__(self, config):
            self.config = config

    class DummyClient:
        def __init__(self, config, auth_manager):
            pass

        def find_estimate(self, form_data, estimate_id=None):
            return {"success": True, "estimate_id": "estimate-9"}

        def complete_estimate(self, estimate_id):
            return {"success": True, "request_body": {"ids": estimate_id, "status": 2}, "response_body": "ok"}

    monkeypatch.setattr(workflow, "setup_logging", lambda: None)
    monkeypatch.setattr(workflow, "load_manpower_config", lambda path: SimpleNamespace(base_url="http://itms.tinno.com"))
    monkeypatch.setattr(
        workflow,
        "build_manpower_csv_from_weekly_plan",
        lambda source_path, output_dir: "generated.csv",
    )
    monkeypatch.setattr(
        workflow,
        "load_form_rows",
        lambda path, sheet_name=None, header_row=1: [{"projectName": "平台类", "taskName": "任务A", "beginDate": "2026-04-06", "endDate": "2026-04-12"}],
    )
    monkeypatch.setattr(workflow, "ItmsAuthManager", DummyAuthManager)
    monkeypatch.setattr(workflow, "ManpowerApiClient", DummyClient)
    monkeypatch.setattr(workflow.sys, "argv", ["main.py", "complete-manpower-from-weekly-plan", "--excel", "examples/本周项目计划表.xlsx"])

    assert workflow.main() == 0
    output = capsys.readouterr().out
    assert '"generated_csv_path": "generated.csv"' in output
    assert '"status": 2' in output
```

- [ ] **Step 2: 跑测试确认失败**

Run:

```powershell
cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task
$env:PYTHONPATH='.'
pytest tests/test_manpower_api.py::test_build_parser_supports_complete_manpower_from_weekly_plan tests/test_manpower_api.py::test_main_dispatches_complete_manpower_from_weekly_plan -q
```

Expected:

```text
FAILED
invalid choice: 'complete-manpower-from-weekly-plan'
```

- [ ] **Step 3: 在 `workflow.py` 中新增批量完成分支**

```python
if args.command == "complete-manpower-from-weekly-plan":
    if not args.excel:
        raise SystemExit("complete-manpower-from-weekly-plan 模式需要通过 --excel 提供周计划 Excel 文件。")

    config = load_manpower_config(_resolve_config_path(args))
    generated_csv_path = build_manpower_csv_from_weekly_plan(args.excel, output_dir=str(TOOL_ROOT / "examples"))
    form_items = load_form_rows(generated_csv_path)
    auth_manager = ItmsAuthManager(config)
    api_client = ManpowerApiClient(config, auth_manager)
    results = []
    exit_code = 0
    for index, form_data in enumerate(form_items, 1):
        try:
            task_match = api_client.find_estimate(form_data, estimate_id=form_data.get("estimateId"))
        except Exception as exc:
            task_match = {"success": False, "error": str(exc)}
        if task_match.get("success"):
            try:
                complete_result = api_client.complete_estimate(task_match.get("estimate_id"))
            except Exception as exc:
                complete_result = api_client.build_failure_result(exc)
        else:
            complete_result = {"success": False, "skipped": True, "response_body": "任务定位失败，未执行完成标记"}
        if not task_match.get("success") or not complete_result.get("success"):
            exit_code = 1
        results.append({"generated_csv_path": generated_csv_path, "row_index": index, "input": form_data, "task_match_result": task_match, "complete_result": complete_result})
    print_payload(results[0] if len(results) == 1 else results)
    return exit_code
```

- [ ] **Step 4: 跑测试确认通过**

Run:

```powershell
cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task
$env:PYTHONPATH='.'
pytest tests/test_manpower_api.py::test_build_parser_supports_complete_manpower_from_weekly_plan tests/test_manpower_api.py::test_main_dispatches_complete_manpower_from_weekly_plan -q
```

Expected:

```text
2 passed
```

## Task 4: README 与完整专项回归

**Files:**
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/README.md`
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`

- [ ] **Step 1: 增加 README 文案测试**

```python
def test_readme_mentions_complete_manpower_commands():
    readme_path = Path(__file__).resolve().parents[1] / "README.md"
    content = readme_path.read_text(encoding="utf-8")

    assert "complete-manpower" in content
    assert "complete-manpower-from-weekly-plan" in content
    assert "status=2" in content
```

- [ ] **Step 2: 跑测试确认失败**

Run:

```powershell
cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task
$env:PYTHONPATH='.'
pytest tests/test_manpower_api.py::test_readme_mentions_complete_manpower_commands -q
```

Expected:

```text
FAILED
AssertionError
```

- [ ] **Step 3: 更新 README**

```markdown
### 13. 标记已创建的人力预估任务为已完成

```powershell
python main.py complete-manpower --excel examples\manpower_form_template_20260411_160000.csv
```

说明：

- 该命令只负责标记已完成，不会创建任务
- 接口固定调用 `POST /api/task/hrestimate/update/status`
- 请求体为表单编码 `ids=<estimateId>&status=2`

### 14. 直接从周计划 Excel 批量标记已完成

```powershell
python main.py complete-manpower-from-weekly-plan --excel examples\本周项目计划表.xlsx
```

说明：

- 该命令直接消费原始周计划 Excel
- 内部复用现有周计划映射与任务定位逻辑
- 若单行任务未找到，则该行跳过，不影响其他行
```

- [ ] **Step 4: 跑 README 测试确认通过**

Run:

```powershell
cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task
$env:PYTHONPATH='.'
pytest tests/test_manpower_api.py::test_readme_mentions_complete_manpower_commands -q
```

Expected:

```text
1 passed
```

- [ ] **Step 5: 跑完整专项回归**

Run:

```powershell
cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task
$env:PYTHONPATH='.'
pytest tests/test_manpower_api.py -q
```

Expected:

```text
<全部通过，例如 8x passed>
```

- [ ] **Step 6: 做静态检索确认改动入口完整**

Run:

```powershell
cd F:\automation-toolkit
rg -n "complete-manpower|complete-manpower-from-weekly-plan|update/status|status=2" python-tools\universal_Automation-Create-Task
```

Expected:

```text
README
workflow.py
manpower_api.py
test_manpower_api.py
```

## 自检

- Spec coverage：已覆盖底层接口调用、标准输入命令、原始周计划命令、README 文档与专项回归。
- Placeholder scan：计划中没有 `TODO`、`TBD` 或“类似前面任务”的省略写法。
- Type consistency：统一使用 `complete_estimate`、`complete_result`、`complete-manpower`、`complete-manpower-from-weekly-plan` 与 `status=2`。
