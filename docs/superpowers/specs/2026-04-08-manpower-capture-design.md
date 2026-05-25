# 人力预估页面专项采集设计

## 背景

当前仓库中的 `python-tools/universal_Automation-Create-Task` 已具备以下基础能力：

- 通过 Playwright 打开 ITMS 页面并保存 `storage_state`
- 复用 `storage_state` 构造后续浏览器上下文与 `requests.Session`
- 在人工操作期间监听网络请求并落盘

但现有实现强绑定“测试子计划创建”业务：

- `discover` 默认入口页面与提示文案面向“添加子计划”
- 候选请求筛选关键词面向 `plan/sub/create/add/content`
- UI 和 API 后续处理逻辑都依赖主计划、测试组件、子计划等字段模型

本次需求不是要立即实现“自动提报人力预估”，而是先让工具具备对目标页面进行专项采集的能力，为后续自动执行提供真实依据。

目标页面为：

- `http://itms.tinno.com/#/manpowerhub/manpower/task?tab=taskhrmy`

页面路径为：

- 人力管理
- 任务人力
- 我的预估任务管理
- 添加任务

## 目标

新增一个“人力预估页面专项采集”能力，支持：

1. 拉起目标页面并复用现有登录态
2. 在人工完成一次“添加任务并提交”的过程中录制网络请求
3. 将全量抓包结果和最可能的提交请求单独落盘
4. 为后续自动化实现沉淀真实入口、请求、字段线索

## 非目标

本次不做以下内容：

- 不实现人力预估表单自动填写
- 不实现人力预估自动提交
- 不抽象成完整通用录制框架
- 不改造现有子计划创建 API 逻辑
- 不自动提取完整 DOM 结构或完整 selector 地图

## 方案选择

本次采用“专项采集器 + 轻量复用内核”的方案，而不是直接做完整通用框架。

### 备选方案

#### 方案 A：直接做完整通用录制框架

优点：

- 后续支持其他 ITMS 页面时复用性高

缺点：

- 当前只有一个明确页面需求，抽象容易建立在猜测上
- 现有代码明显偏业务化，抽象成本高
- 会延长拿到首批真实情报的时间

#### 方案 B：只做人力预估专项采集器

优点：

- 交付最快
- 能直接服务当前目标

缺点：

- 如果后续出现第二个类似页面，可能需要重复改造

#### 方案 C：轻量复用录制内核 + 人力预估专项入口

优点：

- 当前需求可快速落地
- 不会过度设计
- 后续若有第二个页面，具备最基本的复用基础

缺点：

- 比纯专项脚本多一层轻量抽象

### 最终选择

采用方案 C。

也就是：

- 不做完整通用框架
- 不写一次性脚本
- 只把“录制会话”能力抽成足够薄的公共层
- 在此之上新增“人力预估页面专项采集”命令和配置

## 总体架构

### 1. 认证层

继续复用现有 `itms_create_task/auth.py`：

- 负责保存 `storage_state`
- 负责校验登录态是否有效
- 负责基于 `storage_state` 创建 Playwright 上下文和 `requests.Session`

这一层不改变职责。

### 2. 录制层

在 `itms_create_task/discovery.py` 中保留现有“子计划 discover”逻辑，同时补一个更轻量的录制入口：

- 根据指定入口 URL 打开页面
- 监听 `fetch / xhr / document`
- 收集请求、响应、请求体、状态码
- 按配置关键词筛选候选提交请求
- 写出全量与候选产物

录制层只关心“采集”，不关心业务字段拼装。

### 3. 专项配置层

新增单独配置文件描述“人力预估专项采集”：

- 页面入口 URL
- 页面名称
- 候选请求关键词
- 输出路径
- 人工操作提示文案

不与现有子计划配置混用，避免语义污染。

### 4. CLI 层

继续以 `main.py -> workflow.py` 为统一入口，新增一个面向专项采集的命令。

命令只负责：

- 读取配置
- 构建认证与录制对象
- 启动专项采集
- 打印候选请求摘要

## 文件边界

### 保持不变

- `python-tools/universal_Automation-Create-Task/main.py`
- `python-tools/universal_Automation-Create-Task/itms_create_task/auth.py`

### 修改

- `python-tools/universal_Automation-Create-Task/itms_create_task/workflow.py`
  - 新增专项采集命令解析与分发
- `python-tools/universal_Automation-Create-Task/itms_create_task/discovery.py`
  - 新增可按入口 URL 和关键词工作的录制能力

### 新增

- `python-tools/universal_Automation-Create-Task/examples/manpower_config.example.json`
  - 人力预估专项采集配置

如后续现有 `models.py` 无法自然承载专项采集配置，再额外补充一个轻量配置模型；若仅需最小字段，则优先复用已有基础字段，避免扩散改动。

## CLI 设计

新增命令：

```powershell
python main.py discover-manpower --config examples\manpower_config.example.json
```

执行语义：

1. 加载专项配置
2. 复用已有 `storage_state`
3. 打开 `taskhrmy` 目标页
4. 提示用户手工完成一次“添加任务并提交”
5. 用户回到终端按回车
6. 保存抓包结果与候选请求
7. 终端输出候选请求摘要

## 配置设计

专项配置仅保留采集所需字段，不引入子计划语义。

建议字段：

```json
{
  "base_url": "http://itms.tinno.com",
  "entry_url": "http://itms.tinno.com/#/manpowerhub/manpower/task?tab=taskhrmy",
  "page_name": "我的预估任务管理",
  "browser": {
    "headless": false,
    "slow_mo_ms": 150,
    "timeout_ms": 20000,
    "storage_state_path": ".runtime/itms_storage_state.json"
  },
  "auth": {
    "auto_relogin": false,
    "login_url": "http://itms.tinno.com/#/workbench",
    "username_env": "ITMS_USERNAME",
    "password_env": "ITMS_PASSWORD",
    "username_selector": "",
    "password_selector": "",
    "submit_selector": "",
    "success_url_contains": "#/workbench",
    "success_wait_ms": 15000
  },
  "capture": {
    "discovery_output_path": ".runtime/manpower_task_capture.json",
    "candidate_output_path": ".runtime/manpower_task_candidate.json",
    "create_keywords": [
      "manpower",
      "task",
      "estimate",
      "save",
      "submit",
      "create",
      "add"
    ]
  }
}
```

设计原则：

- `entry_url` 明确指定专项入口
- `capture` 与现有 `api` 语义分开，避免误解为“后续必然走接口模式”
- 复用同一份 `storage_state_path`，减少状态管理复杂度

## 输出产物设计

输出三类结果：

### 1. 登录态文件

- `examples/.runtime/itms_storage_state.json`

用途：

- 后续继续复用同一登录态

### 2. 全量抓包文件

- `examples/.runtime/manpower_task_capture.json`

内容：

- 本次录制期间命中的全部候选网络请求
- 每项包含 `method / url / headers / post_data / response_status / response_body`

用途：

- 回溯页面交互链路
- 手工核对“最终提交请求”是否被正确筛出

### 3. 候选提交请求文件

- `examples/.runtime/manpower_task_candidate.json`

内容：

- 从全量抓包中筛出的最可能提交请求

用途：

- 作为后续自动执行实现的直接输入线索

## 录制流程设计

运行专项采集命令后，流程如下：

1. 读取专项配置
2. 构建浏览器上下文，带入 `storage_state`
3. 打开 `entry_url`
4. 对页面挂接响应监听器
5. 仅记录：
   - `document`
   - `fetch`
   - `xhr`
6. 仅保留 `base_url` 下的请求
7. 提示用户在页面中完成：
   - 进入“我的预估任务管理”
   - 点击“添加任务”
   - 完成表单填写
   - 点击提交并确认
8. 用户按回车结束录制
9. 写出全量抓包
10. 依据关键词、HTTP 方法、是否存在请求体筛出候选请求
11. 写出候选请求文件
12. 控制台打印候选摘要

## 候选请求筛选规则

候选提交请求筛选遵循以下规则：

1. 仅考虑 `POST / PUT / PATCH`
2. URL 必须命中 `capture.create_keywords`
3. 必须存在请求体
4. 默认取最后一个最符合条件的请求作为候选

这个规则与现有 `discover` 的筛选思想一致，但词表切换为面向人力预估页面。

如果候选为空：

- 保留全量抓包
- 控制台给出明确提示
- 允许后续人工从抓包文件中回看

## 错误处理

### 登录态缺失

行为：

- 若缺少 `storage_state`，沿用现有 `auth` 机制报错或重新登录

### 页面打不开

行为：

- 直接抛出异常并保留终端错误信息
- 不吞掉导航失败原因

### 候选请求未识别

行为：

- 视为“采集成功但筛选失败”
- 保留全量抓包供后续人工分析

### 录制期间用户未完成操作

行为：

- 仍正常结束录制
- 产物为空或候选为空属于合法结果

## 测试与验证

本次优先验证“采集链路可工作”，不是验证业务提交成功。

建议验证分两层：

### 1. 静态验证

- CLI 能识别新命令
- 专项配置能被正确加载
- 输出路径能创建

### 2. 人工联调验证

步骤：

1. 执行专项采集命令
2. 人工完成一次真实“添加任务并提交”
3. 检查是否生成：
   - `manpower_task_capture.json`
   - `manpower_task_candidate.json`
4. 检查候选请求是否包含请求体

验收标准：

- 工具能稳定打开目标页面
- 录制文件能落盘
- 至少能拿到完整抓包
- 候选请求筛选失败时，也必须保留全量抓包

## 后续扩展边界

本次设计为后续能力留出扩展点，但不提前实现：

- 基于候选请求做真实接口回放
- 补充页面元素快照采集
- 支持更多 ITMS 页面专项采集
- 将专项采集器进一步提升为通用录制框架

是否进入这些扩展，取决于本次 `taskhrmy` 录制结果是否稳定，以及后续是否出现第二个类似页面需求。

## 风险与取舍

### 风险 1：当前环境无法直接访问目标页面

已知现象：

- 当前助手环境尝试直连目标地址时返回 `net::ERR_BLOCKED_BY_CLIENT`

取舍：

- 设计上仍按用户本机可访问 ITMS 的前提推进
- 工具必须允许在用户本机上运行并完成真实录制

### 风险 2：URL 关键词不一定足够准确

取舍：

- 首版保留全量抓包作为兜底
- 候选筛选不作为唯一结果

### 风险 3：页面可能存在二次确认或多次提交请求

取舍：

- 先用“最后一个符合条件的写请求”作为首选候选
- 若实际发现不稳定，再迭代更细的筛选策略

## 决策结论

本次不做完整通用录制框架。

本次要做的是：

- 在现有 `universal_Automation-Create-Task` 中新增一个“人力预估页面专项采集”能力
- 复用登录态与网络录制基础能力
- 新增独立命令、独立配置、独立输出产物
- 专注为后续自动执行沉淀真实页面信息与提交线索
