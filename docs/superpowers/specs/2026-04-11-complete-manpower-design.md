# 标记人力预估任务已完成设计

## 背景

当前 `universal_Automation-Create-Task` 已支持：
- 创建人力预估任务
- 关联测试人员
- 从周计划 Excel 回填实际工时

现在新增的业务需求是：对已创建的人力预估任务执行“标记已完成”操作。

已确认的接口事实：
- 提交参数示例：`ids=323323772247429136&status=2`
- 该请求不是 JSON，请按表单编码提交
- 当前场景针对“任务人力”中的人力预估任务，不涉及项目人力

## 目标

新增两条能力：

1. `complete-manpower`
   - 对标准 JSON/CSV 输入中的已创建任务执行“标记已完成”
   - 支持优先使用 `estimateId`
   - 若没有 `estimateId`，则复用当前已有的任务定位逻辑

2. `complete-manpower-from-weekly-plan`
   - 直接读取原始 [本周项目计划表.xlsx](F:/automation-toolkit/python-tools/universal_Automation-Create-Task/examples/本周项目计划表.xlsx)
   - 自动定位对应已创建任务
   - 批量标记为已完成

## 不做的事

- 不把“标记已完成”自动串到 `fill-manpower-actual-from-weekly-plan`
- 不修改已有创建、关联测试人员、回填实际工时命令的职责
- 不推断其他状态值，仅按已确认的 `status=2` 实现
- 不做 UI 自动化，优先走接口

## 方案选项

### 方案 1：只做 `complete-manpower`

优点：
- 改动最小
- 与现有标准 CSV/JSON 输入兼容

缺点：
- 不能直接消费原始周计划 Excel
- 用户还需要先转换输入

### 方案 2：只做 `complete-manpower-from-weekly-plan`

优点：
- 最贴近当前真实使用方式

缺点：
- 缺少基础能力复用点
- 无法单独补标记某一条历史任务

### 方案 3：底层能力 + 两个 CLI 命令

推荐采用。

优点：
- 底层职责清晰
- 标准输入和原始周计划 Excel 两种场景都覆盖
- 复用现有任务定位逻辑，不重复造轮子

缺点：
- 比单命令多一层 CLI 分支，但复杂度可控

## 设计

### 接口层

在 [manpower_api.py](F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/manpower_api.py) 新增：

1. `complete_estimate(estimate_id: str) -> Dict[str, Any]`
   - 调用 `POST /api/task/hrestimate/update/status`
   - 使用表单编码提交
   - 请求体固定为：
     - `ids=<estimate_id>`
     - `status=2`
   - 返回统一结果结构：
     - `success`
     - `status_code`
     - `request_body`
     - `response_body`

2. 复用现有 `find_estimate(...)`
   - `complete-manpower` 和 `complete-manpower-from-weekly-plan` 都通过它定位任务

### CLI 层

在 [workflow.py](F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/workflow.py) 新增两个命令：

1. `complete-manpower`
   - 输入：`--form` 或 `--excel`
   - 行为：
     - 若输入里带 `estimateId`，优先直接完成
     - 否则先定位任务，再标记完成

2. `complete-manpower-from-weekly-plan`
   - 输入：`--excel <本周项目计划表.xlsx>`
   - 行为：
     - 先复用现有周计划映射能力，转成标准任务字段
     - 再逐行定位任务并标记完成

### 输入定位规则

沿用现有逻辑：
- `projectName`
- `taskName`
- `beginDate`
- `endDate`

并基于当前登录用户 `leaderId` 查询其名下任务。

### 输出结构

每行输出统一为：
- `row_index`
- `input`
- `task_match_result`
- `complete_result`

规则：
- 定位失败：该行跳过完成操作，`complete_result.skipped = true`
- 完成失败：该行失败，但不影响其他行
- 完成成功：返回接口原始响应摘要

## 错误处理

- 缺少 `estimateId` 且任务定位失败：返回可读错误，不中断其他行
- 接口 HTTP 失败：返回统一失败结构
- 接口业务失败：以 `errno != 0` 视为失败
- 输入缺少必要字段：直接报参数错误

## 测试

在 [test_manpower_api.py](F:/automation-toolkit/python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py) 增加：

1. `complete_estimate` 请求体测试
   - 断言请求地址为 `/api/task/hrestimate/update/status`
   - 断言提交体为表单编码 `ids=<id>&status=2`

2. `complete-manpower` CLI 分发测试
   - 覆盖按 `estimateId` 完成
   - 覆盖按定位结果完成

3. `complete-manpower-from-weekly-plan` CLI 测试
   - 覆盖原始 Excel 转标准输入后批量完成

4. README 命令说明测试

## 验证

实现后执行：

```powershell
cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task
$env:PYTHONPATH='.'
pytest tests/test_manpower_api.py -q
```

并补一条静态检索确认：

```powershell
cd F:\automation-toolkit
rg -n "complete-manpower|complete-manpower-from-weekly-plan|update/status|status=2" python-tools\universal_Automation-Create-Task
```
