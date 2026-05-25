# 周计划人力任务一体编排与周一维护 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 为 `universal_Automation-Create-Task` 增加两条编排命令：`run-weekly-manpower` 用于从原始周计划 Excel 一次完成创建、关联测试人员、回填实际工时；`monday-manpower-maintenance` 用于周一批量标记任务已完成并输出提醒消息。

**Architecture:** 不改写现有底层接口能力，继续复用 `create_estimate`、`assign_testers`、`fill_actual_work`、`complete_estimate`。命令级编排全部落在 `workflow.py`，由其串起现有能力并统一输出结果结构；README 与测试同步扩展，确保入口、短路逻辑与提醒输出可验证。

**Tech Stack:** Python 3.11, argparse, requests, openpyxl, pytest

---

## 文件结构

### 需要修改

- `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/workflow.py`
  - 新增两个编排命令
- `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`
  - 新增 CLI 分发、短路逻辑、提醒输出与 README 文案测试
- `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/README.md`
  - 新增两条命令文档

### 尽量不改

- `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/manpower_api.py`
  - 除非实现中发现必须抽一个轻量编排辅助，否则保持不变

## Task 1: 为 `run-weekly-manpower` 写失败测试并实现

**Files:**
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/workflow.py`

- [ ] **Step 1: 写解析器与编排成功路径测试**

```python
def test_build_parser_supports_run_weekly_manpower():
    parser = workflow.build_parser()

    args = parser.parse_args(["run-weekly-manpower", "--excel", "examples/本周项目计划表.xlsx"])

    assert args.command == "run-weekly-manpower"


def test_main_dispatches_run_weekly_manpower(monkeypatch, capsys):
    class DummyAuthManager:
        def __init__(self, config):
            self.config = config

    class DummyClient:
        def __init__(self, config, auth_manager):
            pass

        def create_estimate(self, form_data):
            return {"success": True, "response_body": '{"errno":0,"data":{"id":"estimate-1"}}'}

        def assign_testers(self, estimate_id, tester_names):
            return {"success": True, "response_body": "assign-ok"}

        def fill_actual_work(self, estimate_id, effort, tester_names, actual_ratios):
            return {"success": True, "response_body": "actual-ok"}

    monkeypatch.setattr(workflow, "setup_logging", lambda: None)
    monkeypatch.setattr(workflow, "load_manpower_config", lambda path: SimpleNamespace(base_url="http://itms.tinno.com"))
    monkeypatch.setattr(workflow, "build_manpower_csv_from_weekly_plan", lambda source_path, output_dir: "generated.csv")
    monkeypatch.setattr(
        workflow,
        "load_form_rows",
        lambda path, sheet_name=None, header_row=1: [{"projectName": "平台类", "taskName": "任务A", "beginDate": "2026-04-06", "endDate": "2026-04-12", "testerNames": "洪子鑫"}],
    )
    monkeypatch.setattr(
        workflow,
        "load_weekly_plan_actual_rows",
        lambda source_path: [{"projectName": "平台类", "taskName": "任务A", "beginDate": "2026-04-06", "endDate": "2026-04-12", "effort": 6, "testerNames": ["洪子鑫"], "actualRatios": [1]}],
    )
    monkeypatch.setattr(workflow, "ItmsAuthManager", DummyAuthManager)
    monkeypatch.setattr(workflow, "ManpowerApiClient", DummyClient)
    monkeypatch.setattr(workflow.sys, "argv", ["main.py", "run-weekly-manpower", "--excel", "examples/本周项目计划表.xlsx"])

    assert workflow.main() == 0
    output = capsys.readouterr().out
    assert '"create_result"' in output
    assert '"assign_result"' in output
    assert '"fill_actual_result"' in output
```

- [ ] **Step 2: 跑测试确认失败**

Run:

```powershell
cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task
$env:PYTHONPATH='.'
pytest tests/test_manpower_api.py::test_build_parser_supports_run_weekly_manpower tests/test_manpower_api.py::test_main_dispatches_run_weekly_manpower -q
```

Expected:

```text
FAILED
invalid choice: 'run-weekly-manpower'
```

- [ ] **Step 3: 在 `workflow.py` 中新增 `run-weekly-manpower` 命令**

```python
if args.command == "run-weekly-manpower":
    if not args.excel:
        raise SystemExit("run-weekly-manpower 模式需要通过 --excel 提供周计划 Excel 文件。")

    config = load_manpower_config(_resolve_config_path(args))
    generated_csv_path = build_manpower_csv_from_weekly_plan(args.excel, output_dir=str(TOOL_ROOT / "examples"))
    create_items = load_form_rows(generated_csv_path)
    actual_items = load_weekly_plan_actual_rows(args.excel)
    actual_index = {
        (item["projectName"], item["taskName"], item["beginDate"], item["endDate"]): item
        for item in actual_items
    }
    auth_manager = ItmsAuthManager(config)
    api_client = ManpowerApiClient(config, auth_manager)
    results = []
    exit_code = 0
    for index, create_form in enumerate(create_items, 1):
        key = (create_form.get("projectName"), create_form.get("taskName"), create_form.get("beginDate"), create_form.get("endDate"))
        actual_form = actual_index.get(key) or {}
        create_result = api_client.create_estimate(create_form)
        if not create_result.get("success"):
            assign_result = {"success": False, "skipped": True, "response_body": "创建失败，未执行关联"}
            fill_actual_result = {"success": False, "skipped": True, "response_body": "创建失败，未执行实际工时回填"}
            exit_code = 1
        else:
            estimate_id = api_client._extract_estimate_id(create_result)
            assign_result = api_client.assign_testers(estimate_id, create_form.get("testerNames"))
            if not assign_result.get("success"):
                fill_actual_result = {"success": False, "skipped": True, "response_body": "关联失败，未执行实际工时回填"}
                exit_code = 1
            else:
                fill_actual_result = api_client.fill_actual_work(estimate_id, actual_form.get("effort"), actual_form.get("testerNames"), actual_form.get("actualRatios"))
                if not fill_actual_result.get("success"):
                    exit_code = 1
        results.append({"generated_csv_path": generated_csv_path, "row_index": index, "input": create_form, "create_result": create_result, "assign_result": assign_result, "fill_actual_result": fill_actual_result})
    print_payload(results[0] if len(results) == 1 else results)
    return exit_code
```

- [ ] **Step 4: 将 `run-weekly-manpower` 加入命令集合与默认配置分支**

```python
"run-weekly-manpower",
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
    "run-weekly-manpower",
    "monday-manpower-maintenance",
    "run-manpower",
):
    return DEFAULT_MANPOWER_CONFIG_PATH
```

- [ ] **Step 5: 跑测试确认通过**

Run:

```powershell
cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task
$env:PYTHONPATH='.'
pytest tests/test_manpower_api.py::test_build_parser_supports_run_weekly_manpower tests/test_manpower_api.py::test_main_dispatches_run_weekly_manpower -q
```

Expected:

```text
2 passed
```

## Task 2: 为 `run-weekly-manpower` 的短路逻辑写测试

**Files:**
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/workflow.py`

- [ ] **Step 1: 写创建失败与关联失败短路测试**

```python
def test_main_run_weekly_manpower_skips_later_steps_when_create_failed(monkeypatch, capsys):
    class DummyAuthManager:
        def __init__(self, config):
            self.config = config

    class DummyClient:
        def __init__(self, config, auth_manager):
            pass

        def create_estimate(self, form_data):
            return {"success": False, "response_body": "bad"}

    monkeypatch.setattr(workflow, "setup_logging", lambda: None)
    monkeypatch.setattr(workflow, "load_manpower_config", lambda path: SimpleNamespace(base_url="http://itms.tinno.com"))
    monkeypatch.setattr(workflow, "build_manpower_csv_from_weekly_plan", lambda source_path, output_dir: "generated.csv")
    monkeypatch.setattr(workflow, "load_form_rows", lambda path, sheet_name=None, header_row=1: [{"projectName": "平台类", "taskName": "任务A", "beginDate": "2026-04-06", "endDate": "2026-04-12", "testerNames": "洪子鑫"}])
    monkeypatch.setattr(workflow, "load_weekly_plan_actual_rows", lambda source_path: [{"projectName": "平台类", "taskName": "任务A", "beginDate": "2026-04-06", "endDate": "2026-04-12", "effort": 6, "testerNames": ["洪子鑫"], "actualRatios": [1]}])
    monkeypatch.setattr(workflow, "ItmsAuthManager", DummyAuthManager)
    monkeypatch.setattr(workflow, "ManpowerApiClient", DummyClient)
    monkeypatch.setattr(workflow.sys, "argv", ["main.py", "run-weekly-manpower", "--excel", "examples/本周项目计划表.xlsx"])

    assert workflow.main() == 1
    output = capsys.readouterr().out
    assert "创建失败，未执行关联" in output
    assert "创建失败，未执行实际工时回填" in output
```

- [ ] **Step 2: 跑测试确认失败**

Run:

```powershell
cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task
$env:PYTHONPATH='.'
pytest tests/test_manpower_api.py::test_main_run_weekly_manpower_skips_later_steps_when_create_failed -q
```

Expected:

```text
FAILED
```

- [ ] **Step 3: 按测试补全短路行为**

```python
if not create_result.get("success"):
    assign_result = {"success": False, "skipped": True, "response_body": "创建失败，未执行关联"}
    fill_actual_result = {"success": False, "skipped": True, "response_body": "创建失败，未执行实际工时回填"}
elif not assign_result.get("success"):
    fill_actual_result = {"success": False, "skipped": True, "response_body": "关联失败，未执行实际工时回填"}
```

- [ ] **Step 4: 跑测试确认通过**

Run:

```powershell
cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task
$env:PYTHONPATH='.'
pytest tests/test_manpower_api.py::test_main_run_weekly_manpower_skips_later_steps_when_create_failed -q
```

Expected:

```text
1 passed
```

## Task 3: 为 `monday-manpower-maintenance` 写失败测试并实现

**Files:**
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/workflow.py`

- [ ] **Step 1: 写解析器与提醒输出测试**

```python
def test_build_parser_supports_monday_manpower_maintenance():
    parser = workflow.build_parser()

    args = parser.parse_args(["monday-manpower-maintenance", "--excel", "examples/本周项目计划表.xlsx"])

    assert args.command == "monday-manpower-maintenance"


def test_main_dispatches_monday_manpower_maintenance(monkeypatch, capsys):
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
    monkeypatch.setattr(workflow, "build_manpower_csv_from_weekly_plan", lambda source_path, output_dir: "generated.csv")
    monkeypatch.setattr(workflow, "load_form_rows", lambda path, sheet_name=None, header_row=1: [{"projectName": "平台类", "taskName": "任务A", "beginDate": "2026-04-06", "endDate": "2026-04-12"}])
    monkeypatch.setattr(workflow, "ItmsAuthManager", DummyAuthManager)
    monkeypatch.setattr(workflow, "ManpowerApiClient", DummyClient)
    monkeypatch.setattr(workflow.sys, "argv", ["main.py", "monday-manpower-maintenance", "--excel", "examples/本周项目计划表.xlsx"])

    assert workflow.main() == 0
    output = capsys.readouterr().out
    assert '"reminder_message"' in output
    assert "请编写并确认本周项目计划表.xlsx" in output
```

- [ ] **Step 2: 跑测试确认失败**

Run:

```powershell
cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task
$env:PYTHONPATH='.'
pytest tests/test_manpower_api.py::test_build_parser_supports_monday_manpower_maintenance tests/test_manpower_api.py::test_main_dispatches_monday_manpower_maintenance -q
```

Expected:

```text
FAILED
invalid choice: 'monday-manpower-maintenance'
```

- [ ] **Step 3: 在 `workflow.py` 中新增周一维护命令**

```python
if args.command == "monday-manpower-maintenance":
    if not args.excel:
        raise SystemExit("monday-manpower-maintenance 模式需要通过 --excel 提供周计划 Excel 文件。")

    config = load_manpower_config(_resolve_config_path(args))
    generated_csv_path = build_manpower_csv_from_weekly_plan(args.excel, output_dir=str(TOOL_ROOT / "examples"))
    form_items = load_form_rows(generated_csv_path)
    auth_manager = ItmsAuthManager(config)
    api_client = ManpowerApiClient(config, auth_manager)
    reminder_message = "请编写并确认本周项目计划表.xlsx"
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
    print_payload({"reminder_message": reminder_message, "items": results})
    return exit_code
```

- [ ] **Step 4: 跑测试确认通过**

Run:

```powershell
cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task
$env:PYTHONPATH='.'
pytest tests/test_manpower_api.py::test_build_parser_supports_monday_manpower_maintenance tests/test_manpower_api.py::test_main_dispatches_monday_manpower_maintenance -q
```

Expected:

```text
2 passed
```

## Task 4: README 与完整专项回归

**Files:**
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/README.md`

- [ ] **Step 1: 写 README 文案测试**

```python
def test_readme_mentions_weekly_orchestration_commands():
    readme_path = Path(__file__).resolve().parents[1] / "README.md"
    content = readme_path.read_text(encoding="utf-8")

    assert "run-weekly-manpower" in content
    assert "monday-manpower-maintenance" in content
    assert "请编写并确认本周项目计划表.xlsx" in content
```

- [ ] **Step 2: 跑测试确认失败**

Run:

```powershell
cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task
$env:PYTHONPATH='.'
pytest tests/test_manpower_api.py::test_readme_mentions_weekly_orchestration_commands -q
```

Expected:

```text
FAILED
AssertionError
```

- [ ] **Step 3: 更新 README**

```markdown
### 15. 从周计划 Excel 一次执行创建、关联与实际工时回填

```powershell
python main.py run-weekly-manpower --excel examples\本周项目计划表.xlsx
```

说明：

- 该命令直接消费原始周计划 Excel
- 内部按顺序执行：创建任务、关联测试人员、回填实际工时
- 某行创建失败时，不继续关联和工时回填
- 某行关联失败时，不继续工时回填

### 16. 周一批量完成任务并输出提醒

```powershell
python main.py monday-manpower-maintenance --excel examples\本周项目计划表.xlsx
```

说明：

- 该命令批量标记对应任务已完成
- 同时输出提醒消息：`请编写并确认本周项目计划表.xlsx`
- 适合由 Windows 计划任务在每周一固定时间触发
```

- [ ] **Step 4: 跑 README 测试确认通过**

Run:

```powershell
cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task
$env:PYTHONPATH='.'
pytest tests/test_manpower_api.py::test_readme_mentions_weekly_orchestration_commands -q
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
<全部通过，例如 9x passed>
```

- [ ] **Step 6: 静态检索确认新入口完整**

Run:

```powershell
cd F:\automation-toolkit
rg -n "run-weekly-manpower|monday-manpower-maintenance|reminder_message" python-tools\universal_Automation-Create-Task
```

Expected:

```text
README
workflow.py
test_manpower_api.py
```

## 自检

- Spec coverage：已覆盖一体编排命令、周一维护命令、短路逻辑、提醒输出与文档说明。
- Placeholder scan：计划中没有占位词或省略实现内容。
- Type consistency：统一使用 `run-weekly-manpower`、`monday-manpower-maintenance`、`create_result`、`assign_result`、`fill_actual_result`、`complete_result`、`reminder_message`。
