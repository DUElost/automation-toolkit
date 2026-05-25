# 周计划人力任务一体编排与周一维护设计

## 背景

当前 `universal_Automation-Create-Task` 已具备以下能力：
- `create-manpower`：创建人力预估任务
- `assign-manpower-testers`：关联测试人员
- `fill-manpower-actual-from-weekly-plan`：基于原始周计划 Excel 回填实际工时
- `complete-manpower` / `complete-manpower-from-weekly-plan`：标记人力预估任务为已完成

用户希望把这些底层能力收敛成更符合实际工作流的两类操作：

1. 一条命令完成“从本周项目计划表.xlsx 到任务创建、人员关联、实际工时回填”的全链路编排
2. 在固定时间点，例如每周一，自动执行：
   - 对既有测试任务标记已完成
   - 提醒编写新的本周项目计划表

## 目标

新增两个面向业务流程的命令：

1. `run-weekly-manpower`
   - 输入：原始 [本周项目计划表.xlsx](F:/automation-toolkit/python-tools/universal_Automation-Create-Task/examples/本周项目计划表.xlsx)
   - 结果：自动完成
     - 创建任务
     - 关联测试人员
     - 回填实际工时

2. `monday-manpower-maintenance`
   - 输入：原始周计划 Excel 或默认路径
   - 结果：自动完成
     - 标记对应任务已完成
     - 输出提醒消息，提示编写本周项目计划表

## 不做的事

- 不把“周一维护”强塞进 `run-weekly-manpower`
- 不引入 UI 自动化，继续优先走接口
- 不直接实现消息平台集成，第一版先输出可读提醒文本
- 不改写现有底层命令职责，只在脚本层编排

## 方案选项

### 方案 1：所有动作并进一条命令

优点：
- 用户看起来只有一个入口

缺点：
- “创建/关联/工时回填”和“周一完成/提醒”是两种不同时间语义
- 容易误操作，维护成本高

### 方案 2：两条编排命令，共享底层能力

推荐采用。

优点：
- 业务语义清晰
- 便于日常执行与周一自动化分别调度
- 保持现有底层命令解耦

缺点：
- 命令数会增加，但职责更清楚

## 设计

### 命令 1：`run-weekly-manpower`

职责：
- 读取原始周计划 Excel
- 自动生成标准 CSV
- 批量执行创建
- 对创建成功行继续关联测试人员
- 对已关联测试人员的任务继续回填实际工时

内部编排顺序：

1. `build-manpower-csv`
2. `create-manpower`
3. `assign-manpower-testers`
4. `fill-manpower-actual-from-weekly-plan`

但这是脚本层编排，不是再起四个子进程。代码层复用现有底层方法：
- `create_estimate`
- `assign_testers`
- `fill_actual_work`

输出结构建议：
- `row_index`
- `input`
- `create_result`
- `assign_result`
- `fill_actual_result`

规则：
- 创建失败：该行后续步骤跳过
- 关联失败：该行实际工时回填跳过
- 实际工时失败：不回滚前两步

### 命令 2：`monday-manpower-maintenance`

职责：
- 对周计划表中对应的既有任务批量标记已完成
- 输出本周提醒文本

内部步骤：

1. 读取原始周计划 Excel
2. 复用现有周计划映射能力定位任务
3. 批量执行 `complete_estimate`
4. 输出提醒文本，例如：
   - `请编写并确认本周项目计划表.xlsx`

第一版提醒形式：
- 直接打印到终端输出
- 同时返回结构化字段 `reminder_message`

后续若需要企业微信、飞书或邮件提醒，可以在这个命令外层继续包，不应污染底层人力接口逻辑。

### 调度

周一自动执行建议使用 Windows 计划任务：
- 触发时间：每周一固定时间
- 执行命令：`python main.py monday-manpower-maintenance --excel <path>`

当前仓库内先实现命令，不在本次范围内强绑某种系统计划任务配置脚本。

## 文件变更

### 需要修改

- [workflow.py](F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/workflow.py)
  - 新增两个编排命令分支
- [manpower_api.py](F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/manpower_api.py)
  - 如有必要，增加一个轻量编排辅助方法；优先不扩展，直接由 workflow 编排
- [test_manpower_api.py](F:/automation-toolkit/python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py)
  - 增加命令分发和结果结构测试
- [README.md](F:/automation-toolkit/python-tools/universal_Automation-Create-Task/README.md)
  - 增加两条新命令用法

### 不修改

- 现有底层接口协议
- 现有 Excel 字段映射规则
- 浏览器认证与 UI 自动化逻辑

## 错误处理

- 单行失败不影响其他行
- 某行创建失败：后续关联和工时回填跳过
- 某行关联失败：工时回填跳过
- 周一维护中任务未找到：该行跳过，但提醒仍输出

## 测试

需要覆盖：

1. `run-weekly-manpower` 解析器与 CLI 分发
2. `run-weekly-manpower` 的步骤短路逻辑
3. `monday-manpower-maintenance` 解析器与 CLI 分发
4. `monday-manpower-maintenance` 的提醒输出
5. README 文案测试

## 验证

实现后执行：

```powershell
cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task
$env:PYTHONPATH='.'
pytest tests/test_manpower_api.py -q
```

并执行静态检索：

```powershell
cd F:\automation-toolkit
rg -n "run-weekly-manpower|monday-manpower-maintenance|reminder_message" python-tools\universal_Automation-Create-Task
```
