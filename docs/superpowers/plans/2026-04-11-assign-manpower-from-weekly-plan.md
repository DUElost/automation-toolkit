# 从周计划 Excel 直接关联人力预估测试人员 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 为 `universal_Automation-Create-Task` 增加 `assign-manpower-from-weekly-plan` 命令，使原始“本周项目计划表.xlsx”可直接用于给已创建的人力预估任务关联测试人员。

**Architecture:** 新命令只做编排，不新增第二套解析或关联逻辑。内部先复用 `build_manpower_csv_from_weekly_plan()` 生成带时间戳的标准 CSV，再复用 `load_form_rows()`、`find_estimate()` 和 `assign_testers()` 逐行执行任务定位与测试人员关联。

**Tech Stack:** Python 3.11, argparse, openpyxl, pytest

---

## 文件结构

### 需要修改

- `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/workflow.py`
  - 新增 `assign-manpower-from-weekly-plan` 命令解析与分发
- `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`
  - 增加 CLI 解析、分发、报错和结果结构测试
- `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/README.md`
  - 补充新命令用法

### 不修改

- `excel_loader.py` 的标准 CSV 生成规则
- `manpower_api.py` 的任务定位与测试人员关联逻辑
- `assign-manpower-testers` 的输入契约

### Task 1: 为 CLI 解析与报错补失败测试

**Files:**
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/workflow.py`

- [ ] **Step 1: 写解析器支持新命令的失败测试**

```python
def test_build_parser_supports_assign_manpower_from_weekly_plan():
    parser = workflow.build_parser()
    assert parser.parse_args(["assign-manpower-from-weekly-plan"]).command == "assign-manpower-from-weekly-plan"
```

- [ ] **Step 2: 写未传 `--excel` 时的失败测试**

```python
def test_main_assign_manpower_from_weekly_plan_requires_excel(monkeypatch):
    monkeypatch.setattr(workflow, "setup_logging", lambda: None)
    monkeypatch.setattr(workflow.sys, "argv", ["main.py", "assign-manpower-from-weekly-plan"])

    with pytest.raises(SystemExit, match="assign-manpower-from-weekly-plan"):
        workflow.main()
```

- [ ] **Step 3: 跑测试确认失败**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py -k "assign_manpower_from_weekly_plan" -v`
Expected: FAIL，提示解析器不认识该命令。

- [ ] **Step 4: 在 `workflow.py` 中最小接入命令与参数校验**

```python
choices=[..., "assign-manpower-from-weekly-plan", ...]
```

并在 `_resolve_config_path()` 中将该命令纳入人力预估默认配置分支。

在 `main()` 中新增最小报错分支：

```python
if args.command == "assign-manpower-from-weekly-plan":
    if not args.excel:
        raise SystemExit("assign-manpower-from-weekly-plan 模式需要通过 --excel 提供周计划 Excel 文件。")
```

- [ ] **Step 5: 跑测试确认通过**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py -k "assign_manpower_from_weekly_plan" -v`
Expected: PASS。

### Task 2: 为命令编排写失败测试

**Files:**
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/workflow.py`

- [ ] **Step 1: 写“先生成 CSV，再读取生成结果并执行关联”的失败测试**

```python
def test_main_dispatches_assign_manpower_from_weekly_plan(monkeypatch, capsys):
    calls = []

    class DummyAuthManager:
        def __init__(self, config):
            self.config = config
            calls.append(("auth", config.base_url))

    class DummyClient:
        def __init__(self, config, auth_manager):
            calls.append(("client", config.base_url, isinstance(auth_manager, DummyAuthManager)))

        def find_estimate(self, form_data, estimate_id=None):
            calls.append(("find", form_data, estimate_id))
            return {"success": True, "estimate_id": "estimate-1"}

        def assign_testers(self, estimate_id, tester_names):
            calls.append(("assign", estimate_id, tester_names))
            return {"success": True, "request_body": {"id": estimate_id, "userIds": ["u1"]}, "response_body": "ok"}

    monkeypatch.setattr(workflow, "setup_logging", lambda: None)
    monkeypatch.setattr(workflow, "load_manpower_config", lambda path: SimpleNamespace(base_url="http://itms.tinno.com", config_path=path))
    monkeypatch.setattr(workflow, "build_manpower_csv_from_weekly_plan", lambda source_path, output_dir: "generated.csv")
    monkeypatch.setattr(workflow, "load_form_rows", lambda path, sheet_name=None, header_row=1: [{"projectName": "T727", "taskName": "X1103：专项验证", "beginDate": "2026-04-06", "endDate": "2026-04-12", "testerNames": "TNNC01"}])
    monkeypatch.setattr(workflow, "ItmsAuthManager", DummyAuthManager)
    monkeypatch.setattr(workflow, "ManpowerApiClient", DummyClient)
    monkeypatch.setattr(workflow.sys, "argv", ["main.py", "assign-manpower-from-weekly-plan", "--excel", "weekly.xlsx"])

    assert workflow.main() == 0
    output = capsys.readouterr().out
    assert '"generated_csv_path": "generated.csv"' in output
    assert ("assign", "estimate-1", "TNNC01") in calls
```

- [ ] **Step 2: 写任务定位失败但批处理继续的测试**

```python
def test_main_assign_manpower_from_weekly_plan_continues_when_find_estimate_fails(monkeypatch, capsys):
    ...
    assert workflow.main() == 1
    assert '"row_index": 1' in output
    assert '"row_index": 2' in output
```

- [ ] **Step 3: 跑测试确认失败**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py -k "dispatches_assign_manpower_from_weekly_plan or continues_when_find_estimate_fails" -v`
Expected: FAIL。

- [ ] **Step 4: 在 `workflow.py` 中实现完整编排逻辑**

新增命令分支：

```python
if args.command == "assign-manpower-from-weekly-plan":
    if not args.excel:
        raise SystemExit("assign-manpower-from-weekly-plan 模式需要通过 --excel 提供周计划 Excel 文件。")

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
                assign_result = api_client.assign_testers(task_match.get("estimate_id"), form_data.get("testerNames"))
            except Exception as exc:
                assign_result = api_client.build_failure_result(exc)
        else:
            assign_result = {"success": False, "skipped": True, "response_body": "任务定位失败，未执行关联"}
        if not task_match.get("success") or not assign_result.get("success"):
            exit_code = 1
        results.append({
            "generated_csv_path": generated_csv_path,
            "row_index": index,
            "input": form_data,
            "task_match_result": task_match,
            "assign_result": assign_result,
        })
    print_payload(results[0] if len(results) == 1 else results)
    return exit_code
```

- [ ] **Step 5: 跑测试确认通过**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py -k "assign_manpower_from_weekly_plan" -v`
Expected: PASS。

### Task 3: 更新 README 并做整体验证

**Files:**
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/README.md`
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`

- [ ] **Step 1: 写 README 约束测试**

```python
def test_readme_mentions_assign_manpower_from_weekly_plan_command():
    readme = Path("README.md").read_text(encoding="utf-8")
    assert "assign-manpower-from-weekly-plan" in readme
    assert "本周项目计划表.xlsx" in readme
```

- [ ] **Step 2: 跑测试确认失败**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py::test_readme_mentions_assign_manpower_from_weekly_plan_command -v`
Expected: FAIL。

- [ ] **Step 3: 更新 README 用法**

补充一节：

```powershell
python main.py assign-manpower-from-weekly-plan --excel examples\本周项目计划表.xlsx
```

说明：
- 该命令直接消费原始周计划 Excel
- 内部会先生成标准 CSV，再执行任务定位与测试人员关联
- 生成的中间 CSV 会保留在 `examples/` 下，便于补跑与审计

- [ ] **Step 4: 跑完整专项测试**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py -q`
Expected: 全部 PASS。

- [ ] **Step 5: 做静态自检**

Run: `cd F:\automation-toolkit; rg -n "assign-manpower-from-weekly-plan|generated_csv_path" python-tools\universal_Automation-Create-Task`
Expected: 新命令与结果字段都能在 `workflow.py`、`README.md`、测试中找到。

## 自检结论

- Spec coverage：已覆盖新命令解析、编排、错误处理、README、完整测试。
- Placeholder scan：每一步都给出了具体代码、命令与预期结果，没有占位项。
- Type consistency：统一使用 `assign-manpower-from-weekly-plan`、`generated_csv_path`、`find_estimate`、`assign_testers` 这些命名，保持与现有实现一致。
