# 周计划 Excel 转人力预估 CSV 设计

## 背景

`python-tools/universal_Automation-Create-Task` 目前已经具备：

- `create-manpower`：直接调用 `POST /api/task/hrestimate/create`
- `--excel`：从 `.csv/.xlsx` 读取批量人力预估表单

当前新增需求不是直接提交，而是先把 `本周项目计划表.xlsx` 转成 `create-manpower` 可直接消费的 `manpower_form_template_时间戳.csv`，减少每周手工整理。

## 目标

新增一个最小专项命令，把周计划 Excel 转成带时间戳的 CSV。

输入：

- `本周项目计划表.xlsx`

输出：

- 目录：`python-tools/universal_Automation-Create-Task/examples`
- 文件名：`manpower_form_template_YYYYMMDD_HHMMSS.csv`

输出 CSV 字段固定为：

- `projectName`
- `taskName`
- `site`
- `groupType`
- `beginDate`
- `endDate`
- `standardWorkHours`

## 已确认规则

源表当前结构为首个工作表 `Sheet1`，表头如下：

- `项目`
- `本周计划`
- `人力投入`
- `项目编号`

转换规则：

- `projectName` = `项目编号`
- `taskName` = `项目` + `：` + `本周计划`
- `site` = `南昌`
- `groupType` = `系统`
- `standardWorkHours` = `人力投入 * 8`
- `beginDate` = 当前日期所在周的周一
- `endDate` = 当前日期所在周的周日

本次按用户确认，`taskName` 前缀使用 `项目` 列，不使用 `项目编号` 列。

## 范围

本次只做：

- Excel 读取
- 规则转换
- 生成带时间戳 CSV
- 输出生成路径

本次不做：

- 自动直接提交
- 自定义映射规则
- 多工作表选择策略优化
- 复杂去重逻辑

## 行过滤规则

默认跳过整行为空的数据。

对 `人力投入 = 0` 的行，本次保留，不做过滤。原因是当前没有业务规则明确说明 0 工时必须忽略，贸然过滤会引入数据丢失风险。

## CLI 设计

新增命令：

```powershell
python main.py build-manpower-csv --excel examples\本周项目计划表.xlsx
```

行为：

1. 读取 `--excel` 指向的 `.xlsx`
2. 取第一个工作表
3. 根据表头做字段映射
4. 按当前日期计算本周周一、周日
5. 生成 `examples/manpower_form_template_YYYYMMDD_HHMMSS.csv`
6. 输出生成文件绝对路径

错误处理：

- 缺少 `--excel` 时直接报错
- 输入文件不是 `.xlsx/.xlsm` 时报错
- 缺少必要表头时报错并指出字段名

## 实现边界

建议改动：

- `python-tools/universal_Automation-Create-Task/itms_create_task/workflow.py`
  - 新增 `build-manpower-csv` 命令分发
- `python-tools/universal_Automation-Create-Task/itms_create_task/excel_loader.py`
  - 新增周计划 Excel 读取与转换辅助函数
- `python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`
  - 新增命令分发和转换规则测试
- `python-tools/universal_Automation-Create-Task/README.md`
  - 新增命令用法说明

可选新增：

- 若测试需要更清晰，也可以新增 `tests/test_manpower_csv_builder.py`

## 关键实现细节

### 周起止日期

基于运行当天日期计算：

- 周一 = `today - timedelta(days=today.weekday())`
- 周日 = 周一 + 6 天

日期输出格式固定为 `YYYY-MM-DD`。

### 工时换算

`standardWorkHours = 人力投入 * 8`

输出规则：

- 若结果是整数，输出整数，例如 `4 * 8 = 32`
- 若结果不是整数，保留小数值，例如 `0.5 * 8 = 4.0`

本次不主动四舍五入，避免篡改原始投入信息。

### CSV 编码

输出使用 UTF-8 with BOM，便于 Windows 下 Excel 直接打开不乱码。

## 测试策略

至少覆盖：

- `build_parser` 支持 `build-manpower-csv`
- 缺少 `--excel` 报错
- 正确读取 `项目 / 本周计划 / 人力投入 / 项目编号`
- 正确生成 `taskName`
- 正确换算 `standardWorkHours`
- 正确生成本周周一、周日
- 正确生成带时间戳文件名
- 生成 CSV 表头正确

## 风险与取舍

### 1. 时间戳文件名会持续累积

这是有意选择。用户明确要求避免重复，因此优先保证每次生成唯一文件，而不是覆盖旧模板。

### 2. 周范围按运行当天计算

这是当前需求最直接的解释。若后续需要“按某个指定周生成”，再单独补 `--week` 或 `--date` 参数。

### 3. 表头依赖当前 Excel 格式

当前实现会显式校验必要表头，不做模糊猜测。若后续表头改名，再补字段别名映射。
