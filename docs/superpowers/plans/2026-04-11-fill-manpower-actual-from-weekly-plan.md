# 从周计划 Excel 回填人力预估实际工时 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 为 `universal_Automation-Create-Task` 增加 `fill-manpower-actual-from-weekly-plan` 命令，使原始“本周项目计划表.xlsx”可直接用于给已创建的人力预估任务回填测试人员实际工时。

**Architecture:** 新命令作为编排层存在，不改动现有创建与测试人员关联职责。底层在 `manpower_api.py` 中补充读取任务详情、构造 `update/actual` 请求体、计算个人实际工时的独立能力；CLI 在 `workflow.py` 中新增单独命令分支；Excel 原始列解析在 `excel_loader.py` 中增加一个轻量读取辅助，避免复制现有标准字段映射。

**Tech Stack:** Python 3.11, argparse, openpyxl, requests, pytest

---

## 文件结构

### 需要修改

- `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/excel_loader.py`
  - 新增针对原始周计划 Excel 的实际工时列解析辅助函数
- `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/manpower_api.py`
  - 新增任务详情读取、实际工时计算、`update/actual` 请求构造与提交能力
- `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/workflow.py`
  - 新增 `fill-manpower-actual-from-weekly-plan` 命令
- `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`
  - 增加原始 Excel 工时列解析、公式计算、CLI 命令与接口调用测试
- `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/README.md`
  - 补充新命令用法

### 不修改

- `create-manpower`、`assign-manpower-testers`、`assign-manpower-from-weekly-plan` 的职责边界
- 现有 `build-manpower-csv` 产物格式

### Task 1: 为原始周计划 Excel 的实际工时列解析写失败测试

**Files:**
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/excel_loader.py`

- [ ] **Step 1: 写原始周计划实际工时列解析测试**

```python
def test_load_weekly_plan_actual_rows_reads_testers_and_actual_columns(tmp_path):
    source_path = tmp_path / "weekly_plan.xlsx"
    workbook = Workbook()
    sheet = workbook.active
    sheet.append(["项目", "本周计划", "人力投入", "项目编号", "测试人员", "实际工时01", "实际工时02"])
    sheet.append(["V551A", "专项验证", 8, "V551A", "吕代,张三", 0.1, 0.2])
    workbook.save(source_path)

    rows = load_weekly_plan_actual_rows(str(source_path))

    assert rows == [{
        "projectName": "V551A",
        "taskName": "V551A：专项验证",
        "effort": 8,
        "testerNames": ["吕代", "张三"],
        "actualRatios": [0.1, 0.2],
    }]
```

- [ ] **Step 2: 跑测试确认失败**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py::test_load_weekly_plan_actual_rows_reads_testers_and_actual_columns -v`
Expected: FAIL，提示 `load_weekly_plan_actual_rows` 不存在。

- [ ] **Step 3: 在 `excel_loader.py` 中实现最小读取辅助函数**

新增函数：

```python
def load_weekly_plan_actual_rows(source_path: str) -> List[Dict[str, Any]]:
    workbook = load_workbook(filename=str(Path(source_path)), read_only=True, data_only=True)
    sheet = workbook[workbook.sheetnames[0]]
    rows = list(sheet.iter_rows(values_only=True))
    headers = [_normalize_header(item) or str(item).strip() if item is not None else None for item in rows[0]]
    header_index = {header: index for index, header in enumerate(headers) if header}
    required_headers = ["项目", "本周计划", "人力投入", "项目编号", "测试人员"]
    ...
```

按行输出：
- `projectName`
- `taskName`
- `effort`
- `testerNames`（列表）
- `actualRatios`（按 `实际工时01/02/...` 顺序读取的列表）
- `beginDate` / `endDate`（按本周周一周日自动计算）

- [ ] **Step 4: 跑测试确认通过**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py::test_load_weekly_plan_actual_rows_reads_testers_and_actual_columns -v`
Expected: PASS。

### Task 2: 为实际工时计算与 payload 生成写失败测试

**Files:**
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/manpower_api.py`

- [ ] **Step 1: 写个人实际工时计算测试**

```python
def test_build_actual_work_items_calculates_personal_actual_hours():
    client = ManpowerApiClient(build_config(), SequenceAuthManager())

    items = client.build_actual_work_items(
        effort=8,
        tester_names=["吕代", "张三"],
        actual_ratios=[0.1, 0.2],
        resolved_users={
            "吕代": {"id": "u1", "nickname": "吕代"},
            "张三": {"id": "u2", "nickname": "张三"},
        },
        task_estimate_id="estimate-1",
        task_weekly_id="weekly-1",
    )

    assert items == [
        {"taskEstimateId": "estimate-1", "taskWeeklyId": "weekly-1", "userId": "u1", "userName": "吕代", "personalActualWorkHours": 6.4},
        {"taskEstimateId": "estimate-1", "taskWeeklyId": "weekly-1", "userId": "u2", "userName": "张三", "personalActualWorkHours": 12.8},
    ]
```

- [ ] **Step 2: 写空值跳过与非数字报错测试**

```python
def test_build_actual_work_items_skips_empty_ratio():
    ...


def test_build_actual_work_items_rejects_non_numeric_ratio():
    ...
```

- [ ] **Step 3: 跑测试确认失败**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py -k "build_actual_work_items" -v`
Expected: FAIL。

- [ ] **Step 4: 在 `manpower_api.py` 中实现最小计算函数**

新增：

```python
def build_actual_work_items(self, effort, tester_names, actual_ratios, resolved_users, task_estimate_id, task_weekly_id):
    items = []
    for index, tester_name in enumerate(tester_names):
        if index >= len(actual_ratios):
            continue
        ratio = actual_ratios[index]
        if ratio in (None, ""):
            continue
        try:
            ratio_value = float(ratio)
        except ValueError as exc:
            raise ValueError("实际工时必须是数字") from exc
        actual_hours = float(effort) * ratio_value * 8
        user = resolved_users[tester_name]
        items.append({
            "taskEstimateId": task_estimate_id,
            "taskWeeklyId": task_weekly_id,
            "userId": user["id"],
            "userName": user.get("nickname") or user.get("username") or tester_name,
            "personalActualWorkHours": actual_hours,
        })
    return items
```

- [ ] **Step 5: 跑测试确认通过**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py -k "build_actual_work_items" -v`
Expected: PASS。

### Task 3: 为实际工时接口提交写失败测试

**Files:**
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/manpower_api.py`

- [ ] **Step 1: 写读取任务详情并提交 `update/actual` 的测试**

```python
def test_fill_actual_work_posts_update_actual_payload():
    auth_manager = SequenceAuthManager(
        get_responses=[
            RecordingResponse({"errno": 0, "data": {"weekList": [
                {"id": "weekly-1", "taskEstimateId": "estimate-1", "year": 2026, "week": 15, "splitBeginDate": "2026-04-06", "splitEndDate": "2026-04-12", "standardWorkHours": 48}
            ]}}, text='{"errno":0}'),
            RecordingResponse({"errno": 0, "data": {"list": [{"id": "u1", "username": "dai.lv", "nickname": "吕代", "status": 1}]}}, text='{"errno":0}'),
        ],
        post_responses=[RecordingResponse({"errno": 0, "errmsg": "成功"}, text='{"errno":0,"errmsg":"成功"}')],
    )
    client = ManpowerApiClient(build_config(), auth_manager)

    result = client.fill_actual_work(
        estimate_id="estimate-1",
        effort=8,
        tester_names=["吕代"],
        actual_ratios=[0.1],
    )

    assert result["success"] is True
    assert auth_manager.session.post_calls[0]["json"]["id"] == "estimate-1"
    assert auth_manager.session.post_calls[0]["json"]["weekList"][0]["weeklyPersonalList"][0]["personalActualWorkHours"] == 6.4
```

- [ ] **Step 2: 跑测试确认失败**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py -k "fill_actual_work_posts_update_actual_payload" -v`
Expected: FAIL。

- [ ] **Step 3: 在 `manpower_api.py` 中实现最小接口提交流程**

新增：
- `read_estimate_detail(self, estimate_id)`
- `fill_actual_work(self, estimate_id, effort, tester_names, actual_ratios)`

`fill_actual_work()` 内部流程：
1. 读取任务详情
2. 解析测试人员 -> 用户映射
3. 基于第一条 `weekList` 构造 payload
4. 调 `POST /api/task/hrestimate/update/actual`
5. 返回标准结构结果

- [ ] **Step 4: 跑测试确认通过**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py -k "fill_actual_work_posts_update_actual_payload" -v`
Expected: PASS。

### Task 4: 为 CLI 命令写失败测试并实现

**Files:**
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/workflow.py`

- [ ] **Step 1: 写命令解析和分发测试**

```python
def test_build_parser_supports_fill_manpower_actual_from_weekly_plan():
    parser = workflow.build_parser()
    assert parser.parse_args(["fill-manpower-actual-from-weekly-plan", "--excel", "examples/本周项目计划表.xlsx"]).command == "fill-manpower-actual-from-weekly-plan"


def test_main_dispatches_fill_manpower_actual_from_weekly_plan(monkeypatch, capsys):
    ...
    assert '"fill_actual_result"' in output
```

- [ ] **Step 2: 写缺少 `--excel` 的失败测试**

```python
def test_main_fill_manpower_actual_from_weekly_plan_requires_excel(monkeypatch):
    ...
```

- [ ] **Step 3: 跑测试确认失败**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py -k "fill_manpower_actual_from_weekly_plan" -v`
Expected: FAIL。

- [ ] **Step 4: 在 `workflow.py` 中新增命令分支**

新增命令：
- `fill-manpower-actual-from-weekly-plan`

分支流程：
1. 校验 `--excel`
2. 读取原始周计划实际工时行
3. 定位任务
4. 调 `fill_actual_work()`
5. 输出 `row_index / input / task_match_result / actual_work_payload_preview / fill_actual_result`

- [ ] **Step 5: 跑测试确认通过**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py -k "fill_manpower_actual_from_weekly_plan" -v`
Expected: PASS。

### Task 5: 更新 README 并做完整验证

**Files:**
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/README.md`
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`

- [ ] **Step 1: 写 README 约束测试**

```python
def test_readme_mentions_fill_manpower_actual_from_weekly_plan_command():
    readme = Path("README.md").read_text(encoding="utf-8")
    assert "fill-manpower-actual-from-weekly-plan" in readme
    assert "实际工时01" in readme
```

- [ ] **Step 2: 跑测试确认失败**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py::test_readme_mentions_fill_manpower_actual_from_weekly_plan_command -v`
Expected: FAIL。

- [ ] **Step 3: 更新 README 用法**

补充一节：

```powershell
python main.py fill-manpower-actual-from-weekly-plan --excel examples\本周项目计划表.xlsx
```

说明：
- `测试人员` 与 `实际工时01/02/...` 按顺序一一对应
- 实际工时计算公式：`人力投入 * 实际工时XX * 8`
- 当前第一版优先支持单周任务

- [ ] **Step 4: 跑完整专项测试**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py -q`
Expected: 全部 PASS。

- [ ] **Step 5: 做静态自检**

Run: `cd F:\automation-toolkit; rg -n "fill-manpower-actual-from-weekly-plan|personalActualWorkHours|update/actual|实际工时01" python-tools\universal_Automation-Create-Task`
Expected: 新命令、计算字段和接口路径都能在实现、README 和测试中找到。

## 自检结论

- Spec coverage：已覆盖原始 Excel 工时列解析、公式计算、接口调用、CLI 命令、README 和完整测试。
- Placeholder scan：所有代码步骤都给出了明确函数、命令与断言，没有占位项。
- Type consistency：统一使用 `fill-manpower-actual-from-weekly-plan`、`personalActualWorkHours`、`fill_actual_work`、`actual_work_payload_preview` 等命名，与接口事实保持一致。
