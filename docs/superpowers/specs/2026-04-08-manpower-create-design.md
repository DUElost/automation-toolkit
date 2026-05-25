# 人力预估接口自动提交设计

## 背景

`python-tools/universal_Automation-Create-Task` 当前已经具备以下基础能力：

- 通过 Playwright 登录 ITMS 并保存 `storage_state`
- 基于 `storage_state` 构造 Playwright 上下文和 `requests.Session`
- 通过 `discover-manpower` 录制人力预估页面真实提交流程

已确认的人力预估创建接口如下：

- `POST http://itms.tinno.com/api/task/hrestimate/create`

已确认的关键数据来源如下：

- 当前登录用户 ID 可通过 `GET /api/auth/info` 获取
- `leaderId` 与当前登录用户 `userId` 一致
- `groupType` 候选值可通过 `GET /api/fieldoption/list?type=TESTGROUP...` 获取
- 项目候选值可通过 `GET /api/project/list` 或 `GET /api/project/list?jiraType=Tinno` 获取

当前还没有足够证据支持自动推导业务工时规则，因此本次不尝试猜测 `standardWorkHours` 的业务算法。

## 目标

新增一个“人力预估接口自动提交”能力，支持：

1. 复用现有登录态直接调用 `POST /api/task/hrestimate/create`
2. 自动获取当前登录用户 `userId` 并填入 `leaderId`
3. 从 JSON 或 Excel 读取人力预估表单输入
4. 自动生成 `daterange`
5. 自动按日期范围拆分 `weekList`
6. 自动提交并输出创建结果

## 非目标

本次不做以下内容：

- 不实现 UI 自动点击提报
- 不支持指定其他负责人
- 不自动推导 `standardWorkHours`
- 不根据工作日、节假日或班次计算工时
- 不做复杂候选值联想或智能纠错

## 方案选择

### 方案 A：接口直提 MVP

特点：

- 当前登录用户固定作为负责人
- `standardWorkHours` 由表单显式传入
- 自动生成 `leaderId / daterange / weekList`

优点：

- 最贴合当前已知接口事实
- 实现简单，错误面最小
- 不需要依赖脆弱的 UI 自动化

缺点：

- 第一版不支持指定其他负责人
- 工时规则需要用户明确给出

### 方案 B：接口直提增强版

特点：

- 自动推导每周工时
- 尝试支持更多负责人和业务规则

优点：

- 更接近最终形态

缺点：

- 当前缺少足够证据，容易把业务规则猜错
- 一旦猜错，提交就是错数据

### 方案 C：UI 自动化提报

特点：

- 用 Playwright 直接模拟页面操作

优点：

- 表面上更接近人工流程

缺点：

- 已有稳定创建接口时没有必要
- 速度慢、稳定性差、维护成本高

### 最终选择

采用方案 A。

也就是：

- 直接做接口版 MVP
- 只支持当前登录用户作为负责人
- `standardWorkHours` 明确由用户输入
- `weekList` 只做结构拆分，不做工时推导

## 第一版边界

### 支持

- 单条 JSON 提交
- Excel/CSV 多行批量提交
- 单周或跨周日期范围
- 当前登录用户作为 `leaderId`
- 自动生成 `daterange`
- 自动拆分 `weekList`

### 暂不支持

- 指定其他负责人姓名后自动查 `leaderId`
- 自动按工作日或节假日换算工时
- 对项目名、组别做模糊纠错
- 用 UI 回退提交

## 请求体设计

### 直接来自表单的字段

- `projectName`
- `taskName`
- `site`
- `groupType`
- `beginDate`
- `endDate`
- `standardWorkHours`

### 自动生成的字段

#### `leaderId`

通过 `GET /api/auth/info` 返回的当前登录用户 `userId` 自动填充。

#### `daterange`

由 `beginDate` 和 `endDate` 生成 UTC ISO 时间数组。

示例：

- `beginDate = 2026-04-06`
- `endDate = 2026-04-12`

生成：

```json
[
  "2026-04-05T16:00:00.000Z",
  "2026-04-11T16:00:00.000Z"
]
```

这对应北京时间零点转 UTC 的结果。

#### `weekList`

按自然周拆分日期区间，每段生成：

- `year`
- `week`
- `splitBeginDate`
- `splitEndDate`
- `standardWorkHours`

第一版规则：

- 每个周段都使用同一个输入的 `standardWorkHours`
- 不做按工作日数分摊

示例：

```json
[
  {
    "year": "2026",
    "week": 15,
    "splitBeginDate": "2026-04-06",
    "splitEndDate": "2026-04-12",
    "standardWorkHours": 32
  }
]
```

## 命令设计

新增命令：

```powershell
python main.py create-manpower --config examples\manpower_config.example.json --form examples\manpower_form.example.json
```

后续也支持：

```powershell
python main.py create-manpower --config examples\manpower_config.example.json --excel examples\manpower_form_template.xlsx
```

命令职责：

1. 读取专项配置
2. 读取 JSON/Excel 表单数据
3. 复用登录态创建 `requests.Session`
4. 调用 `api/auth/info` 获取当前用户
5. 组装创建请求体
6. 调用 `POST /api/task/hrestimate/create`
7. 输出接口结果

## 文件边界

### 修改

- `python-tools/universal_Automation-Create-Task/itms_create_task/workflow.py`
  - 新增 `create-manpower` 命令分发
- `python-tools/universal_Automation-Create-Task/README.md`
  - 新增人力预估接口提交说明

### 新增

- `python-tools/universal_Automation-Create-Task/itms_create_task/manpower_api.py`
  - 人力预估创建客户端
  - 当前用户解析
  - `daterange` 生成
  - `weekList` 生成
  - 创建接口调用
- `python-tools/universal_Automation-Create-Task/examples/manpower_form.example.json`
  - 单条样例输入
- `python-tools/universal_Automation-Create-Task/examples/manpower_form_template.csv`
  - 批量导入模板
- `python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`
  - 请求体生成与命令分发测试

### 复用

- `python-tools/universal_Automation-Create-Task/itms_create_task/auth.py`
- `python-tools/universal_Automation-Create-Task/itms_create_task/config_loader.py`
- `python-tools/universal_Automation-Create-Task/itms_create_task/excel_loader.py`

## 组件设计

### 1. `ManpowerApiClient`

职责：

- 基于现有登录态发起接口请求
- 查询当前登录用户信息
- 构造人力预估创建请求体
- 调用创建接口并返回标准化结果

建议暴露方法：

- `get_current_user()`
- `build_request_payload(form_data)`
- `create_estimate(form_data)`

### 2. 日期与周拆分辅助方法

职责：

- 将 `beginDate/endDate` 转为 UTC `daterange`
- 按自然周拆分 `weekList`

这些方法应保持纯函数，便于单元测试。

### 3. CLI 分发

职责：

- 解析 `create-manpower`
- 读取表单行
- 逐行提交
- 打印每行结果

行为上参考现有 `api / run / ui` 命令，不引入新的复杂调度模型。

## 数据流

整体数据流如下：

1. CLI 读取配置和输入表单
2. `ItmsAuthManager` 基于 `storage_state` 建立会话
3. `ManpowerApiClient` 调用 `api/auth/info`
4. 获取 `userId` 作为 `leaderId`
5. 根据表单生成：
   - 基础字段
   - `daterange`
   - `weekList`
6. 调用 `POST /api/task/hrestimate/create`
7. 返回标准化结果给 CLI
8. CLI 打印 JSON 输出

## 错误处理

### 登录态失效

行为：

- 沿用现有 `ItmsAuthManager` 校验与刷新逻辑
- 若失效且不能自动续登，直接报错

### 表单缺字段

行为：

- 若缺少 `projectName / taskName / site / groupType / beginDate / endDate / standardWorkHours`
  直接报错，不发请求

### 日期非法

行为：

- 若 `beginDate > endDate`，直接报错
- 若日期格式非法，直接报错

### 接口业务错误

行为：

- 保留接口返回文本
- 标准化输出 `success: false`
- 不吞掉后端错误信息

## 测试策略

### 单元测试

重点覆盖：

- `leaderId` 使用当前登录用户 `userId`
- `daterange` 生成正确
- 单周 `weekList` 生成正确
- 跨周 `weekList` 拆分正确
- 缺字段时抛错
- `create-manpower` CLI 能正确分发

### 联调验证

在用户本机上执行：

```powershell
python main.py create-manpower --config examples\manpower_config.example.json --form examples\manpower_form.example.json
```

验收标准：

- 能成功读取当前登录用户 `userId`
- 能成功调用 `POST /api/task/hrestimate/create`
- 提交后接口返回成功

## 风险与取舍

### 风险 1：`standardWorkHours` 真实业务规则未知

取舍：

- 第一版不猜
- 改为显式输入

### 风险 2：跨周工时是否需要分摊未知

取舍：

- 第一版每个周段都写相同的 `standardWorkHours`
- 若后续验证不符，再根据真实规则调整

### 风险 3：指定他人负责人流程未知

取舍：

- 第一版仅支持当前登录用户
- 后续如需扩展，再基于 `api/user/list` 或 `api/user/info/read` 增加负责人解析

## 决策结论

本次实现“人力预估接口自动提交”的第一版 MVP，策略如下：

- 直接走 `POST /api/task/hrestimate/create`
- 自动用当前登录用户 `userId` 作为 `leaderId`
- 自动生成 `daterange`
- 自动拆分 `weekList`
- `standardWorkHours` 由表单显式传入
- 不做 UI 自动化回退
