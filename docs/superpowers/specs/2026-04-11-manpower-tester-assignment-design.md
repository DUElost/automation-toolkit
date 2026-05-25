# 人力预估创建与测试人员关联设计

## 背景

当前 `universal_Automation-Create-Task` 已支持通过 `create-manpower` 调用 `POST /api/task/hrestimate/create` 批量创建人力预估任务，并支持通过 `build-manpower-csv` 从“本周项目计划表.xlsx”生成带时间戳的批量 CSV。

新的业务需求是在批量创建任务后，为每条新建的人力预估任务关联测试人员。源 Excel 已新增 `测试人员` 列，单元格格式为中文名或测试账号，多个值使用英文逗号分隔，例如 `张三,李四`。

已确认的接口/数据基础如下：
- 已确认创建接口：`POST /api/task/hrestimate/create`
- 权限中存在测试人员关联接口：`POST /api/task/hrestimate/update/tester`
- 用户列表接口 `GET /api/user/list?status=1` 可返回 `id`、`username`、`nickname`
- 当前抓包没有 `update/tester` 的现成请求样本，因此第一版实现必须保持保守、可排错、可单独复跑

## 目标

实现一套“代码层职责分离、脚本层可一体执行”的人力预估任务编排方案：
- `create-manpower` 继续只负责创建人力预估任务
- `assign-manpower-testers` 新增为独立命令，只负责给已存在的人力预估任务关联测试人员
- `run-manpower` 新增为编排命令，基于同一份 Excel/CSV 先创建，再关联测试人员

## 非目标

本次不实现以下内容：
- 不改造现有 `create-manpower` 的职责边界
- 不做 UI 自动化关联测试人员
- 不做测试人员的模糊匹配、拼音匹配或工号匹配
- 不做创建成功后的自动回滚
- 不做多种分隔符兼容，第一版只支持英文逗号

## 方案对比

### 方案 A：把测试人员关联直接塞进 `create-manpower`

优点：用户只执行一个命令。

缺点：创建与关联耦合，失败边界不清楚；任何关联异常都会污染现有稳定的创建链路；不利于补跑。

### 方案 B：新增 `assign-manpower-testers`，同时新增 `run-manpower` 负责编排

优点：职责清晰，创建链路保持稳定；既能单独执行，也能一体执行；后续排错和补跑成本最低。

缺点：CLI 命令数会增加，需要维护一层编排逻辑。

### 方案 C：只新增 `assign-manpower-testers`，由用户手动串联两条命令

优点：实现最简单。

缺点：日常使用步骤更多；脚本没法直接利用创建接口返回的任务 ID，需要二次定位任务。

## 结论

采用方案 B。

代码层将创建与测试人员关联拆分成两个独立能力；脚本层新增 `run-manpower` 编排命令，在同一轮执行里复用创建返回的任务 ID，避免再次查询列表定位任务。

## 输入与数据模型

### Excel / CSV 输入

`build-manpower-csv` 生成的 CSV 将新增一列：
- `testerNames`

字段来源：
- `testerNames` = Excel `测试人员` 列原样写入

其他字段维持现状：
- `projectName` = `项目编号`
- `taskName` = `项目` + `：` + `本周计划`
- `site` = `南昌`
- `groupType` = `系统`
- `beginDate` / `endDate` = 本周周一 / 周日
- `standardWorkHours` = `人力投入 * 8`

### 测试人员解析规则

`testerNames` 解析规则固定如下：
1. 按英文逗号 `,` 分割
2. 去掉每个名字的首尾空格
3. 过滤空项
4. 去重，保持原顺序
5. 对每个名字依次匹配：
   - 先精确匹配 `username`
   - 再精确匹配 `nickname`
6. 如果匹配到 0 人，当前行关联失败
7. 如果匹配到多名用户，当前行关联失败，不自动猜测

允许的输入示例：
- `张三`
- `TNNC01`
- `张三,李四`
- `TNNC01,TNTest01`

## 命令设计

### `create-manpower`

保持现状，不增加职责。

### `assign-manpower-testers`

新增命令，输入支持 `--form` 或 `--excel`。

行为：
- 读取表单数据
- 若某行没有 `testerNames`，则输出“跳过关联”结果
- 调 `GET /api/user/list?status=1` 拉取启用用户列表
- 将 `testerNames` 解析成测试人员用户 ID 列表
- 定位目标任务：
  - 如果输入行中已有 `estimateId`，优先直接使用
  - 否则根据 `projectName + taskName + beginDate + endDate + leaderId` 查询当前登录人相关的人力预估任务并精确定位
- 调 `POST /api/task/hrestimate/update/tester` 完成关联

### `run-manpower`

新增编排命令，输入支持 `--form` 或 `--excel`。

行为：
- 逐行调用创建能力
- 若创建失败，该行不执行关联
- 若创建成功且无 `testerNames`，则该行整体成功，标记“未配置测试人员，跳过关联”
- 若创建成功且有 `testerNames`，则直接使用创建响应返回的任务 `id` 执行关联
- 每行结果同时输出：
  - `create_result`
  - `assign_result`

## 组件设计

### `excel_loader.py`

扩展 `build_manpower_csv_from_weekly_plan`：
- 将 Excel 的 `测试人员` 列映射为 CSV 的 `testerNames`
- 若 `测试人员` 列缺失，则视为设计错误并报错，因为当前业务表已明确包含该列

### `manpower_api.py`

保留现有创建能力，新增以下能力：
- 获取用户列表并构建索引
- 解析 `testerNames` -> 用户 ID 列表
- 根据条件定位已存在的人力预估任务
- 调用 `POST /api/task/hrestimate/update/tester`
- 新增统一的成功/失败结果结构，便于编排层复用

### `workflow.py`

新增命令：
- `assign-manpower-testers`
- `run-manpower`

命令职责：
- `assign-manpower-testers` 只编排“定位任务 + 关联人员”
- `run-manpower` 编排“创建 + 关联”

## 接口策略

### 用户列表

使用：
- `GET /api/user/list?status=1`

只使用返回中的必要字段：
- `id`
- `username`
- `nickname`
- `status`

实现中不得打印或持久化不必要的敏感字段。

### 创建接口

沿用现有：
- `POST /api/task/hrestimate/create`

### 测试人员关联接口

使用：
- `POST /api/task/hrestimate/update/tester`

由于没有现成抓包样本，第一版实现遵循以下原则：
- 请求体只发送任务 ID 与测试人员 ID 列表的最小必要字段
- 失败时保留请求体摘要与服务端错误，便于二次调试
- 所有异常都转成结构化结果返回，不因单行失败中断整批执行

### 已有任务定位

当 `assign-manpower-testers` 独立运行且输入中没有 `estimateId` 时：
- 调 `GET /api/auth/info` 获取当前用户 `leaderId`
- 调 `GET /api/task/hrestimate/list` 按周和 `leaderId` 查询
- 以 `projectName`、`taskName`、`beginDate`、`endDate` 做精确匹配
- 0 条命中则失败
- 多条命中则失败，不自动猜测

## 错误处理

单行失败不影响其他行。

典型失败场景：
- `testerNames` 中某个名称找不到用户
- `testerNames` 中某个名称匹配到多个用户
- 独立关联模式下找不到目标任务
- 独立关联模式下目标任务匹配到多条
- `update/tester` 接口返回非 200 或 `errno != 0`

对于“创建成功但关联失败”的情况：
- 不回滚已创建任务
- 输出中必须保留已创建任务 ID
- 便于后续单独重跑 `assign-manpower-testers`

## 输出结构

### `assign-manpower-testers`

每行输出：
- `row_index`
- `input`
- `task_match_result`
- `tester_resolve_result`
- `assign_result`

### `run-manpower`

每行输出：
- `row_index`
- `input`
- `create_result`
- `assign_result`

其中：
- 如果未配置测试人员，`assign_result` 返回跳过状态
- 如果创建失败，`assign_result` 返回未执行状态

## 测试策略

至少覆盖以下场景：
- `build-manpower-csv` 能输出 `testerNames` 列
- 单个中文名匹配 `nickname`
- 单个账号匹配 `username`
- 多个测试人员按逗号解析
- 名称去重与空白清洗
- 用户未找到时报错
- 用户重名时报错
- `run-manpower` 在创建成功后传递任务 ID 给关联步骤
- `assign-manpower-testers` 在独立模式下能通过查询定位任务
- 关联接口失败时，批处理继续执行并保留错误详情

## 风险与约束

主要风险是 `POST /api/task/hrestimate/update/tester` 的请求体字段尚未通过抓包完全证实。

因此实现上必须满足：
- 关联逻辑与创建逻辑彻底解耦
- 单独命令可重复执行
- 请求体尽量最小化
- 错误信息保留足够上下文，便于用一次真实失败结果快速校正字段
