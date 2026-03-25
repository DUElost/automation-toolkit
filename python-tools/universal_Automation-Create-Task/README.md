# ITMS 子计划创建工具

该工具用于自动化在 ITMS 平台创建测试子计划，执行策略为：

1. 优先使用接口调用
2. 若接口未完成录制或调用失败，则自动回退到 UI 自动化

当前默认项目与页面地址已按需求预置为 `T726A` 及对应 ITMS 页面，但所有关键参数都可通过配置覆盖。

当前版本已支持“动态项目上下文解析”：

1. 按项目名解析 `projectId / suiteId / jiraKey`
2. 按主计划名与测试组件名解析 `taskmaincontentId`
3. 优先读取该主计划下最新一个已有子计划作为模板
4. 只覆盖你本次真正需要填写的字段

## 目录结构

```text
universal_Automation-Create-Task/
├─ itms_create_task/
├─ examples/
├─ main.py
├─ requirements.txt
└─ README.md
```

## 安装

```powershell
cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task
pip install -r requirements.txt
playwright install chromium
```

如果你使用的是当前公司镜像，`playwright` 可用上限看起来是 `1.48.0`，因此这里已经固定为该版本，避免继续出现安装失败。

## 推荐使用流程

### 1. 首次登录并保存登录态

```powershell
python main.py auth --config examples\itms_config.example.json
```

说明：

- 会启动浏览器，请手动完成登录
- 登录完成后，在终端按回车，脚本会保存 `storage_state`

如果你后续要接飞书定时触发，建议改成“自动续登录”模式，而不是继续依赖手动 `auth`。

配置方式：

1. 在配置文件 `auth` 段中开启 `auto_relogin`
2. 配置登录页 URL 和用户名/密码/提交按钮 selector
3. 通过环境变量提供账号密码，不要写进 JSON

PowerShell 示例：

```powershell
$env:ITMS_USERNAME="你的账号"
$env:ITMS_PASSWORD="你的密码"
python main.py run --config examples\itms_config.example.json --excel examples\sub_plan_form_template.xlsx
```

说明：

- 当检测到 `storage_state` 缺失或失效时，脚本会自动打开浏览器重新登录并保存新的 `storage_state`
- 这要求你已经确认过登录页的 selector
- 定时任务场景建议把 `browser.headless` 改为 `true`
- 建议使用专用 ITMS 账号，不要使用个人账号

### 2. 录制一次真实创建动作，生成接口线索

```powershell
python main.py discover --config examples\itms_config.example.json
```

说明：

- 脚本会打开浏览器并开始记录接口
- 请手动走一次“添加子计划”并提交
- 完成后回到终端按回车
- 录制结果会输出到 `.runtime/` 目录

### 3. 按表单数据执行自动创建

```powershell
python main.py run --config examples\itms_config.example.json --form examples\sub_plan_form.example.json
```

默认逻辑：

- 若 `.runtime/itms_create_sub_plan_api.json` 存在，则先尝试接口
- 若接口调用失败，则自动回退到 UI 自动化

也支持直接从 Excel/CSV 读取多行输入：

```powershell
python main.py run --config examples\itms_config.example.json --excel examples\sub_plan_form_template.xlsx
```

可选参数：

- `--sheet`：指定 Excel 工作表名
- `--header-row`：指定表头所在行，默认第 1 行

### 4. 查看当前项目的候选值与上下文

```powershell
python main.py inspect-options --config examples\itms_config.example.json --form examples\sub_plan_form.example.json
```

说明：

- 会输出当前项目、主计划内容、项目版本、样机标签、测试类型子项、配件、参考机、物料等
- 同时保存到 `.runtime/itms_context_snapshot.json`

### 5. 强制只走 UI 自动化

```powershell
python main.py ui --config examples\itms_config.example.json --form examples\sub_plan_form.example.json
```

## 配置说明

`examples/itms_config.example.json` 中主要有三类内容：

- 基础页面地址与默认项目参数
- 浏览器与登录态路径
- API 录制输出路径与 UI 字段绑定规则

其中 `ui.field_bindings` 为最重要的可调部分。由于我当前无法访问你们内网页面的真实 DOM，这里实现的是“标签/文本优先、显式 selector 兜底”的策略。若默认标签无法命中，可直接在配置里补 `selector`。

## 表单数据说明

`examples/sub_plan_form.example.json` 用于承载这次要创建的子计划字段，例如：

- `sub_plan_name`
- `owner_name`
- `start_date`
- `end_date`
- `remark`
- `testsuite_component_name`
- `task_type`
- `task_sub_type`

如果你要批量创建，推荐直接使用：

- [sub_plan_form_template.xlsx](F:/automation-toolkit/python-tools/universal_Automation-Create-Task/examples/sub_plan_form_template.xlsx)
- [sub_plan_form_template.csv](F:/automation-toolkit/python-tools/universal_Automation-Create-Task/examples/sub_plan_form_template.csv)

优先使用 `.xlsx`，Excel 直接打开更稳。`.csv` 也可用，但不同机器上的 Excel 仍可能按本地编码猜测，出现显示异常。

接口模式下，这些字段会用于覆盖已录制请求体中的占位内容；UI 模式下，则会映射到表单控件。

当前默认实现会自动把：

- `start_date` 转成 `start_time`，默认补 `09:00:00`
- `end_date` 转成 `end_time`，默认补 `18:00:00`

如果你想精确到时分秒，也可以直接在表单 JSON 中传 `start_time`、`end_time`。

## 已知限制

1. 当前无法在本地直接访问 `itms.tinno.com`，因此真实接口地址、字段名、DOM 结构仍需在你本机上首次录制确认。
2. 若“模块 Owner 为当前登录用户”在页面中不是纯文本匹配，需要在配置中补充更明确的行定位 selector。
3. 若表单存在复杂联动字段，建议先跑 `discover` 录制一次成功创建，再补充 `api.body_overrides` 或 `ui.field_bindings`。
4. 若切换到其他项目、其他主计划，且页面 URL 不同，请同步更新配置中的直达 URL，或将 `ui.prefer_direct_urls` 改为 `false` 让脚本走页面导航。
5. 如果目标主计划下还没有任何历史子计划，工具会回退到项目配置接口拼默认值；这种场景下建议先执行一次 `inspect-options` 检查默认值是否符合预期。
6. 如果接口返回“该项目已存在同名计划名称，请更改”，这属于业务错误，工具不会再回退 UI；请直接修改 Excel/JSON 里的 `sub_plan_name`。
7. 如果接口返回 `errno=501`，通常表示 `storage_state` 对应的登录态已经失效；若已配置 `auth.auto_relogin=true` 且 selector 正确，脚本会自动重新登录，否则需要重新执行 `python main.py auth --config examples\itms_config.example.json`。
