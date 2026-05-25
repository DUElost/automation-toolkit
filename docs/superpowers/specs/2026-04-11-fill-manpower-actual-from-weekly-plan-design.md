# 从周计划 Excel 回填人力预估实际工时设计

## 背景

当前 `universal_Automation-Create-Task` 已支持：
- `assign-manpower-testers`：给已创建的人力预估任务关联测试人员
- `assign-manpower-from-weekly-plan`：直接基于“本周项目计划表.xlsx”给已创建任务关联测试人员
- `run-manpower`：按标准 CSV 一体执行创建 + 关联

现在新增的业务需求是：基于同一份“本周项目计划表.xlsx”，给对应的已创建人力预估任务下、已关联的测试人员填写实际工时。

已确认的输入规则：
- Excel 中有 `测试人员` 列，多个测试人员用英文逗号分隔
- Excel 中新增 `实际工时01`、`实际工时02`、... 列
- `实际工时01` 对应 `测试人员` 的第 1 个人，`实际工时02` 对应第 2 个人，依此类推
- 实际工时计算公式为：`人力投入 * 实际工时XX * 8`

已确认的接口事实：
- 实际工时提交接口：`POST /api/task/hrestimate/update/actual`
- 请求体包含：
  - 顶层 `id = taskEstimateId`
  - `weekList`
  - `weeklyPersonalList`
  - 每个测试人员项需包含 `userId`、`userName`、`personalActualWorkHours`

## 目标

新增一条专用命令：
- `fill-manpower-actual-from-weekly-plan`

使其可以直接消费原始“本周项目计划表.xlsx”，完成：
1. 定位已创建的人力预估任务
2. 解析测试人员顺序与实际工时列
3. 计算每位测试人员的实际工时
4. 调 `POST /api/task/hrestimate/update/actual` 写回

## 非目标

本次不做以下内容：
- 不把“填写实际工时”混进 `assign-manpower-testers`
- 不把“填写实际工时”混进 `assign-manpower-from-weekly-plan`
- 不做 UI 自动化填写实际工时
- 不新增新的 Excel 模板格式
- 不改变现有测试人员关联逻辑

## 方案对比

### 方案 A：扩展 `assign-manpower-from-weekly-plan`，同时做“关联 + 实际工时回填”

优点：用户只跑一个命令。

缺点：职责混杂，失败边界变复杂；关联成功但工时失败、工时成功但关联未做等场景会让结果难以理解。

### 方案 B：新增 `fill-manpower-actual-from-weekly-plan`，单独处理“实际工时回填”

优点：职责清晰；可单独补跑；后续若需要组合命令，可以在脚本层做编排而不污染现有能力。

缺点：命令数增加一条。

### 方案 C：扩展 `run-manpower`，只对新建任务顺带写实际工时

优点：对“创建新任务”场景一步到位。

缺点：无法覆盖“历史已创建任务补写实际工时”的核心需求。

## 结论

采用方案 B。

新增 `fill-manpower-actual-from-weekly-plan`，直接面向原始周计划 Excel，但底层仍复用现有：
- 周计划 Excel 转标准任务定位字段的逻辑
- 测试人员解析逻辑
- 任务定位逻辑

## 命令设计

### `fill-manpower-actual-from-weekly-plan`

示例：

```powershell
python main.py fill-manpower-actual-from-weekly-plan --excel examples\本周项目计划表.xlsx
```

行为：
- 必须通过 `--excel` 提供原始周计划 Excel
- 逐行读取原始 Excel
- 对每一行：
  - 构造标准任务定位字段
  - 定位已创建的人力预估任务
  - 解析 `测试人员`
  - 读取 `实际工时01/02/...`
  - 计算每位测试人员的 `personalActualWorkHours`
  - 调 `POST /api/task/hrestimate/update/actual`

## 数据模型

### 输入列

原始 Excel 使用：
- `项目`
- `本周计划`
- `人力投入`
- `项目编号`
- `测试人员`
- `实际工时01`
- `实际工时02`
- `实际工时03`
- ...

### 任务定位字段

与现有规则一致：
- `projectName = 项目编号`
- `taskName = 项目 + ： + 本周计划`
- `beginDate / endDate = 本周周一 / 周日`

### 测试人员与实际工时映射

固定按顺序映射：
- `测试人员` 第 1 个 -> `实际工时01`
- `测试人员` 第 2 个 -> `实际工时02`
- 以此类推

### 计算公式

对每位测试人员：
- `personalActualWorkHours = 人力投入 * 实际工时XX * 8`

示例：
- `人力投入 = 8`
- `实际工时01 = 0.1`
- 则第 1 个测试人员实际工时 = `8 * 0.1 * 8 = 6.4`

## 接口策略

### 任务定位

沿用现有 `find_estimate()`：
- 根据 `projectName + taskName + beginDate + endDate + 当前登录人 leaderId` 精确匹配

### 实际工时提交

使用：
- `POST /api/task/hrestimate/update/actual`

请求体结构：
- 顶层 `id = taskEstimateId`
- `weekList` 保持服务端结构
- 每周项中的 `weeklyPersonalList` 仅为本次需要更新的测试人员构造最小字段：
  - `taskEstimateId`
  - `taskWeeklyId`
  - `userId`
  - `userName`
  - `personalActualWorkHours`

实现策略：
- 先读取已存在任务详情，拿到其 `weekList`
- 基于每周项构造本次更新 payload
- 第一版只处理单周任务，但实现允许保留 `weekList` 数组结构，便于后续扩展跨周

## 错误处理

- 某行定位任务失败，不影响其他行
- 某行测试人员解析失败，不影响其他行
- 某个 `实际工时XX` 为空时，对应测试人员跳过，不导致整行失败
- 某个 `实际工时XX` 不是数字时，该行失败
- 若测试人员数量多于实际工时列数量，则多出来的测试人员跳过，并在结果中给出提示
- 不回滚任何已存在任务数据

## 输出结构

每行输出：
- `row_index`
- `input`
- `task_match_result`
- `actual_work_payload_preview`
- `fill_actual_result`

其中：
- `actual_work_payload_preview` 用于展示本行计算后的人员与工时
- `fill_actual_result` 包含接口请求摘要与响应

## 复用与边界

为避免重复代码：
- 不新增第二套任务定位规则
- 不新增第二套测试人员解析规则
- 原始 Excel 解析可在现有 `excel_loader.py` 基础上扩展辅助函数，或在 `workflow.py` 中最小读取，但不得复制现有标准字段映射逻辑两份

## 测试策略

至少覆盖：
- 原始周计划 Excel 新增实际工时列的读取
- 多个测试人员与 `实际工时01/02/...` 的顺序映射
- 实际工时公式计算正确，支持小数
- 空实际工时列时对应人员跳过
- 非数字实际工时列时报错
- `fill-manpower-actual-from-weekly-plan` 命令解析成功
- 命令未传 `--excel` 时正确报错
- 命令分发时能定位任务并调用实际工时接口
- README 中记录了新命令用法

## 风险与约束

主要风险是：实际工时接口虽然已确认请求体主结构，但多周任务如何拆分到不同 `weekList` 项，目前尚未通过真实样本完全覆盖。

因此第一版范围应明确为：
- 优先支持单周任务
- 保持请求结构与接口事实一致
- 若后续出现跨周任务，再基于真实样本扩展 week 级分摊规则，而不是现在猜测。
