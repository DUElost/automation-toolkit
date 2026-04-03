# 稳定性测试报告自动生成工具

该工具用于根据一份 Excel 输入工作簿，自动生成稳定性测试报告目录、专项子报告和汇总报告。

## 当前能力

- 自动生成标准输入模板
- 自动创建稳定性汇总模板与专项模板
- 根据 `项目基础信息`、`专项执行清单`、`专项扩展字段`、`Bug汇总导入` 生成报告
- 支持 `MTBF`、`开关机`、`休眠唤醒`、`GPU`、`待机`、`DDR`、`联机UI+ADB重启与原生Monkey`、`Stress`、`Monkey2.0`

## 安装依赖

```powershell
cd F:\automation-toolkit\python-tools\universal_Auto-Create-TestReport
pip install -r requirements.txt
```

## 使用方式

### 1. 生成输入模板

```powershell
python main.py init-input
```

默认输出到 `examples/report_input_template.xlsx`。

### 2. 根据输入模板生成报告

```powershell
python main.py run --input examples\report_input_template.xlsx
```

可选参数：

- `--output-root`：覆盖输入表中的输出目录

## 输入工作簿结构

### 项目基础信息

至少包含以下列：

- `project_name`
- `project_stage`
- `software_version`
- `reporter`
- `report_date`
- `output_root`
- `template_profile`

### 专项执行清单

至少包含以下列：

- `specialty_code`
- `specialty_name`
- `enabled`
- `round_no`
- `test_cycle`
- `test_result`
- `device_count`
- `bug_summary`
- `subreport_title`

### 专项扩展字段

可选，用于 `Stress`、`Monkey2.0` 等特例字段：

- `specialty_code`
- `field_key`
- `field_value`

### Bug汇总导入

可选，存在时会写入汇总报告中的 `Bug_MonkeyList` 工作表。
