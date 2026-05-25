# 周计划 Excel 转人力预估 CSV Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 为 `universal_Automation-Create-Task` 新增 `build-manpower-csv` 命令，把 `本周项目计划表.xlsx` 转成带时间戳的 `manpower_form_template_YYYYMMDD_HHMMSS.csv`。

**Architecture:** 在 `excel_loader.py` 增加一个纯转换函数，负责读取首个工作表、校验表头、按规则生成行数据并写出 CSV。CLI 只负责命令分发和输出路径打印，避免把 Excel 规则塞进 `workflow.py`。测试继续集中在 `tests/test_manpower_api.py`，覆盖命令分发、周起止日期、字段映射和输出文件名。

**Tech Stack:** Python 3、openpyxl、csv、pathlib、datetime、pytest

---

### Task 1: 增加周计划 Excel 到人力预估 CSV 的转换函数

**Files:**
- Modify: `python-tools/universal_Automation-Create-Task/itms_create_task/excel_loader.py`
- Modify: `python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`

- [ ] **Step 1: 先写失败测试，锁定字段映射和周范围**

```python
from pathlib import Path

from itms_create_task.excel_loader import build_manpower_csv_from_weekly_plan


def test_build_manpower_csv_from_weekly_plan_creates_expected_rows(tmp_path):
    source_path = tmp_path / "weekly_plan.xlsx"
    output_dir = tmp_path / "out"

    workbook = Workbook()
    sheet = workbook.active
    sheet.append(["项目", "本周计划", "人力投入", "项目编号"])
    sheet.append(["KO5", "第九轮monkey挂测，开关机，休眠唤醒，MTBF", 4, "V657"])
    sheet.append(["lamu26", "MTBF测试收结果", 0.5, "P329D"])
    workbook.save(source_path)

    output_path = build_manpower_csv_from_weekly_plan(
        str(source_path),
        output_dir=str(output_dir),
        today=date(2026, 4, 11),
    )

    rows = load_form_rows(str(output_path))
    assert rows == [
        {
            "projectName": "V657",
            "taskName": "KO5：第九轮monkey挂测，开关机，休眠唤醒，MTBF",
            "site": "南昌",
            "groupType": "系统",
            "beginDate": "2026-04-06",
            "endDate": "2026-04-12",
            "standardWorkHours": 32,
        },
        {
            "projectName": "P329D",
            "taskName": "lamu26：MTBF测试收结果",
            "site": "南昌",
            "groupType": "系统",
            "beginDate": "2026-04-06",
            "endDate": "2026-04-12",
            "standardWorkHours": 4,
        },
    ]
    assert Path(output_path).name.startswith("manpower_form_template_20260411_")
```

- [ ] **Step 2: 运行聚焦测试，确认当前红灯**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py::test_build_manpower_csv_from_weekly_plan_creates_expected_rows -v`

Expected: FAIL，提示 `build_manpower_csv_from_weekly_plan` 未定义或行为不符合预期。

- [ ] **Step 3: 写最小实现**

```python
def build_manpower_csv_from_weekly_plan(source_path: str, output_dir: str, today=None) -> str:
    path = Path(source_path)
    if path.suffix.lower() not in (".xlsx", ".xlsm"):
        raise ValueError("build-manpower-csv 只支持 Excel 文件")

    workbook = load_workbook(filename=str(path), read_only=True, data_only=True)
    sheet = workbook[workbook.sheetnames[0]]
    rows = list(sheet.iter_rows(values_only=True))
    headers = [_normalize_header(item) for item in rows[0]]
    required_headers = ["项目", "本周计划", "人力投入", "项目编号"]
    missing = [header for header in required_headers if header not in headers]
    if missing:
        raise ValueError("缺少必要表头: %s" % ",".join(missing))

    current_day = today or date.today()
    week_begin = current_day - timedelta(days=current_day.weekday())
    week_end = week_begin + timedelta(days=6)
    timestamp = datetime.combine(current_day, datetime.min.time()).strftime("%Y%m%d_%H%M%S")
    output_path = Path(output_dir) / ("manpower_form_template_%s.csv" % timestamp)
    output_path.parent.mkdir(parents=True, exist_ok=True)

    header_index = {header: idx for idx, header in enumerate(headers) if header}
    output_rows = []
    for row in rows[1:]:
        project = _normalize_value(row[header_index["项目"]])
        weekly_plan = _normalize_value(row[header_index["本周计划"]])
        effort = _normalize_value(row[header_index["人力投入"]])
        project_code = _normalize_value(row[header_index["项目编号"]])
        if project in (None, "") and weekly_plan in (None, "") and effort in (None, "") and project_code in (None, ""):
            continue
        standard_work_hours = _convert_effort_to_hours(effort)
        output_rows.append(
            {
                "projectName": project_code,
                "taskName": "%s：%s" % (project, weekly_plan),
                "site": "南昌",
                "groupType": "系统",
                "beginDate": week_begin.strftime("%Y-%m-%d"),
                "endDate": week_end.strftime("%Y-%m-%d"),
                "standardWorkHours": standard_work_hours,
            }
        )

    with open(output_path, "w", encoding="utf-8-sig", newline="") as file_obj:
        writer = csv.DictWriter(
            file_obj,
            fieldnames=["projectName", "taskName", "site", "groupType", "beginDate", "endDate", "standardWorkHours"],
        )
        writer.writeheader()
        writer.writerows(output_rows)
    return str(output_path)
```

- [ ] **Step 4: 运行测试，确认转绿**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py::test_build_manpower_csv_from_weekly_plan_creates_expected_rows -v`

Expected: PASS。

- [ ] **Step 5: 补边界测试**

```python
def test_build_manpower_csv_from_weekly_plan_rejects_missing_headers(tmp_path):
    source_path = tmp_path / "weekly_plan.xlsx"
    workbook = Workbook()
    sheet = workbook.active
    sheet.append(["项目", "本周计划", "项目编号"])
    workbook.save(source_path)

    with pytest.raises(ValueError, match="缺少必要表头.*人力投入"):
        build_manpower_csv_from_weekly_plan(str(source_path), output_dir=str(tmp_path), today=date(2026, 4, 11))


def test_build_manpower_csv_from_weekly_plan_rejects_non_excel_input(tmp_path):
    source_path = tmp_path / "weekly_plan.csv"
    source_path.write_text("项目,本周计划,人力投入,项目编号\n", encoding="utf-8")

    with pytest.raises(ValueError, match="只支持 Excel 文件"):
        build_manpower_csv_from_weekly_plan(str(source_path), output_dir=str(tmp_path), today=date(2026, 4, 11))
```

- [ ] **Step 6: 跑这一组转换测试**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py::test_build_manpower_csv_from_weekly_plan_creates_expected_rows tests/test_manpower_api.py::test_build_manpower_csv_from_weekly_plan_rejects_missing_headers tests/test_manpower_api.py::test_build_manpower_csv_from_weekly_plan_rejects_non_excel_input -v`

Expected: PASS。

### Task 2: 接入 build-manpower-csv 命令分发

**Files:**
- Modify: `python-tools/universal_Automation-Create-Task/itms_create_task/workflow.py`
- Modify: `python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`

- [ ] **Step 1: 先写失败测试，锁定命令分发**

```python
import itms_create_task.workflow as workflow


def test_build_parser_supports_build_manpower_csv():
    parser = workflow.build_parser()
    args = parser.parse_args(["build-manpower-csv", "--excel", "examples/本周项目计划表.xlsx"])

    assert args.command == "build-manpower-csv"


def test_main_dispatches_build_manpower_csv(monkeypatch, capsys):
    calls = []

    def fake_builder(source_path, output_dir):
        calls.append((source_path, output_dir))
        return "F:/automation-toolkit/python-tools/universal_Automation-Create-Task/examples/manpower_form_template_20260411_134500.csv"

    monkeypatch.setattr(workflow, "setup_logging", lambda: None)
    monkeypatch.setattr(workflow, "build_manpower_csv_from_weekly_plan", fake_builder)
    monkeypatch.setattr(
        workflow.sys,
        "argv",
        ["main.py", "build-manpower-csv", "--excel", "examples/本周项目计划表.xlsx"],
    )

    assert workflow.main() == 0
    assert calls == [("examples/本周项目计划表.xlsx", str(workflow.TOOL_ROOT / "examples"))]
    assert "manpower_form_template_20260411_134500.csv" in capsys.readouterr().out
```

- [ ] **Step 2: 运行聚焦测试，确认红灯**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py::test_build_parser_supports_build_manpower_csv tests/test_manpower_api.py::test_main_dispatches_build_manpower_csv -v`

Expected: FAIL，命令尚未注册。

- [ ] **Step 3: 写最小 CLI 实现**

```python
from .excel_loader import build_manpower_csv_from_weekly_plan, load_form_rows


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description="ITMS 子计划自动化创建工具")
    parser.add_argument(
        "command",
        choices=[
            "auth",
            "discover",
            "discover-manpower",
            "create-manpower",
            "build-manpower-csv",
            "run",
            "ui",
            "api",
            "inspect-options",
        ],
        help="执行模式",
    )
    ...


def main() -> int:
    ...
    if args.command == "build-manpower-csv":
        if not args.excel:
            raise SystemExit("build-manpower-csv 模式需要通过 --excel 提供周计划 Excel 文件。")
        output_path = build_manpower_csv_from_weekly_plan(
            args.excel,
            output_dir=str(TOOL_ROOT / "examples"),
        )
        print_payload({"output_path": output_path})
        return 0
```

- [ ] **Step 4: 运行命令分发测试**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py::test_build_parser_supports_build_manpower_csv tests/test_manpower_api.py::test_main_dispatches_build_manpower_csv -v`

Expected: PASS。

- [ ] **Step 5: 补空参数测试**

```python
def test_main_build_manpower_csv_requires_excel(monkeypatch):
    monkeypatch.setattr(workflow, "setup_logging", lambda: None)
    monkeypatch.setattr(workflow.sys, "argv", ["main.py", "build-manpower-csv"])

    with pytest.raises(SystemExit, match="build-manpower-csv"):
        workflow.main()
```

- [ ] **Step 6: 运行 CLI 测试组**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py::test_build_parser_supports_build_manpower_csv tests/test_manpower_api.py::test_main_dispatches_build_manpower_csv tests/test_manpower_api.py::test_main_build_manpower_csv_requires_excel -v`

Expected: PASS。

### Task 3: 更新 README 并完成专项验证

**Files:**
- Modify: `python-tools/universal_Automation-Create-Task/README.md`
- Modify: `python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`

- [ ] **Step 1: 先写 README 断言测试**

```python
def test_readme_mentions_build_manpower_csv_command():
    readme_path = Path(__file__).resolve().parents[1] / "README.md"
    content = readme_path.read_text(encoding="utf-8")

    assert "build-manpower-csv" in content
    assert "本周项目计划表.xlsx" in content
    assert "manpower_form_template_" in content
```

- [ ] **Step 2: 运行 README 测试，确认红灯**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py::test_readme_mentions_build_manpower_csv_command -v`

Expected: FAIL，README 还没写新命令。

- [ ] **Step 3: 在 README 追加转换命令说明**

````markdown
### 8. 从周计划 Excel 生成批量人力预估 CSV

```powershell
python main.py build-manpower-csv --excel examples\本周项目计划表.xlsx
```

说明：

- 读取首个工作表中的 `项目 / 本周计划 / 人力投入 / 项目编号`
- 自动生成 `projectName / taskName / site / groupType / beginDate / endDate / standardWorkHours`
- 输出到 `examples/manpower_form_template_YYYYMMDD_HHMMSS.csv`
- 生成后可直接继续执行 `create-manpower --excel <输出文件>`
````

- [ ] **Step 4: 运行 README 测试**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py::test_readme_mentions_build_manpower_csv_command -v`

Expected: PASS。

- [ ] **Step 5: 运行完整专项测试**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py -q`

Expected: PASS，现有人力预估测试和新增 CSV 转换测试全部通过。

- [ ] **Step 6: 进行一次实际转换验证**

Run: `cd F:\automation-toolkit; python .\python-tools\universal_Automation-Create-Task\main.py build-manpower-csv --excel .\python-tools\universal_Automation-Create-Task\examples\本周项目计划表.xlsx`

Expected: 输出一个位于 `python-tools/universal_Automation-Create-Task/examples` 下的 `manpower_form_template_YYYYMMDD_HHMMSS.csv` 绝对路径。

- [ ] **Step 7: 检查变更边界**

Run: `cd F:\automation-toolkit; git diff -- python-tools/universal_Automation-Create-Task/itms_create_task/excel_loader.py python-tools/universal_Automation-Create-Task/itms_create_task/workflow.py python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py python-tools/universal_Automation-Create-Task/README.md`

Expected: 仅包含 `build-manpower-csv` 转换逻辑、CLI 分发、README 说明和对应测试。
