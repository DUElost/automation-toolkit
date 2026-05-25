# 从周计划 Excel 直接关联人力预估测试人员设计

## 背景

当前 `universal_Automation-Create-Task` 已支持以下能力：
- `build-manpower-csv`：从“本周项目计划表.xlsx”生成标准人力预估 CSV
- `assign-manpower-testers`：根据标准 CSV 或 JSON，定位已创建的人力预估任务并关联测试人员
- `run-manpower`：按标准 CSV 或 JSON 一体执行“创建 + 关联”

新的需求是：不再要求用户手工分两步执行“周计划 Excel -> CSV -> 关联”，而是允许直接基于原始“本周项目计划表.xlsx”对已创建的测试任务执行测试人员关联。

## 目标

新增一条专用编排命令，直接消费原始周计划 Excel：
- `assign-manpower-from-weekly-plan`

该命令内部自动完成：
1. 读取原始周计划 Excel
2. 生成带时间戳的标准人力预估 CSV
3. 基于该 CSV 定位已创建的人力预估任务
4. 调用测试人员关联接口完成关联

## 非目标

本次不做以下内容：
- 不修改 `assign-manpower-testers` 的输入契约
- 不修改 `build-manpower-csv` 的职责边界
- 不新增 UI 自动化逻辑
- 不直接从原始 Excel 旁路实现一套新的任务定位/关联逻辑
- 不增加新的 Excel 模板格式

## 方案对比

### 方案 A：扩展 `assign-manpower-testers`，同时支持原始周计划 Excel 与标准 CSV

优点：命令更少。

缺点：一个命令承担两种输入模型，参数语义会混乱；后续排错时很难判断当前走的是哪条路径。

### 方案 B：新增 `assign-manpower-from-weekly-plan`，内部复用“生成 CSV + 关联”两段能力

优点：职责清晰，原始输入与标准输入分开；复用现有稳定逻辑；中间 CSV 可保留，便于审计、补跑和定位问题。

缺点：CLI 命令数增加一条。

### 方案 C：只在仓库外写 PowerShell 包装脚本

优点：实现快。

缺点：逻辑脱离 Python 工具本体，不利于测试、复用和后续维护。

## 结论

采用方案 B。

新增 `assign-manpower-from-weekly-plan` 编排命令，直接面向原始“本周项目计划表.xlsx”；代码层仍然复用：
- `build_manpower_csv_from_weekly_plan`
- `load_form_rows`
- `find_estimate`
- `assign_testers`

## 命令设计

### `assign-manpower-from-weekly-plan`

示例：

```powershell
python main.py assign-manpower-from-weekly-plan --excel examples\本周项目计划表.xlsx
```

行为：
- 必须通过 `--excel` 提供原始周计划 Excel
- 先调用 `build_manpower_csv_from_weekly_plan()` 生成带时间戳的中间 CSV
- 再读取该 CSV 的每一行
- 对每一行执行：
  - `find_estimate()` 定位已创建任务
  - `assign_testers()` 关联测试人员
- 最终输出中同时保留：
  - `generated_csv_path`
  - `row_index`
  - `input`
  - `task_match_result`
  - `assign_result`

## 数据流

### 输入

原始 Excel 列：
- `项目`
- `本周计划`
- `人力投入`
- `项目编号`
- `测试人员`

### 中间标准 CSV

沿用现有标准化结果：
- `projectName`
- `taskName`
- `site`
- `groupType`
- `beginDate`
- `endDate`
- `standardWorkHours`
- `testerNames`

### 关联阶段

沿用现有逻辑：
- 测试人员解析：优先 `username`，其次 `nickname`
- 任务定位：当前登录人 `leaderId` + `projectName` + `taskName` + `beginDate` + `endDate`
- 关联接口：`POST /api/task/hrestimate/update/tester`
- 请求体：`id + userIds`

## 输出结构

单行输出：
- `generated_csv_path`
- `row_index`
- `input`
- `task_match_result`
- `assign_result`

多行输出时为数组，每行都重复带上 `generated_csv_path`，方便单独拷贝结果定位对应中间文件。

## 错误处理

- 任何一行任务定位失败，不影响其他行
- 任何一行测试人员关联失败，不影响其他行
- 如果原始 Excel 缺少 `测试人员` 列，仍由 `build-manpower-csv` 阶段直接报错
- 若某行 `testerNames` 为空，则该行返回跳过关联状态
- 不回滚任何已存在任务

## 复用与边界

为避免重复代码：
- 不新增第二套 Excel 解析规则
- 不新增第二套任务定位逻辑
- 不新增第二套测试人员匹配逻辑

`assign-manpower-from-weekly-plan` 只是一层编排：
- 输入模型转换复用 `build-manpower-csv`
- 执行复用 `assign-manpower-testers` 对应的底层能力

## 测试策略

至少覆盖：
- CLI 新命令解析成功
- 未传 `--excel` 时正确报错
- 命令会先调用 `build_manpower_csv_from_weekly_plan`
- 命令会读取生成后的 CSV，而不是直接读取原始 Excel
- 单行定位并关联成功的结果结构正确
- 当某行定位失败时，其他行仍继续执行
- README 中记录了新命令用法

## 风险与约束

主要约束是：该命令依赖当前原始周计划表字段结构稳定不变。

如果后续周计划 Excel 结构变化，只应修复 `build-manpower-csv` 的映射逻辑，而不应在 `assign-manpower-from-weekly-plan` 中再新增一套解析分支。这样可以保持数据入口单一、行为可预测。
