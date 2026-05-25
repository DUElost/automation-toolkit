Transsion_Jira_Tool_20260323 使用说明
====================================

1、工具目标
本目录提供一套面向 Transsion Jira 的两阶段自动提单流程：

- 第一阶段：原始结果 Excel -> Transsion Jira 上传模板
- 第二阶段：上传模板 -> Jira 建单

当前已完成：

- 第一阶段脚本可运行
- 第二阶段脚本可运行
- 第二阶段已完成元数据校验与 dry-run 验证


2、目录内核心文件

脚本：
- generate_transsion_jira_upload_list.py
- create_transsion_jira_batch_from_excel.py

公共模块：
- transsion_upload_template_common.py
- transsion_batch_jira_common.py

默认输入：
- Result_None_None_MonkeyAEE_SH_20260323.xls
- config/transsion_jira_defaults.json
- config/affect_project_mapping.json
- config/包名与模块&经办人对应表_transsion.xlsx
- config/问题等级定级表.xls
- config/问题出现概率评级表.xlsx
- config/稳定性专项汇总.xlsx
- config/bug_severity_priority_image
- config/backup/包名与compent 对应_Transsion.txt

默认输出目录：
- log
  所有脚本运行日志统一写入该目录
- result
  第一阶段生成的 Jira 上传模板，以及第二阶段/辅助脚本输出的 JSON 结果文件统一写入该目录


3、第一阶段：生成上传模板

脚本：
- generate_transsion_jira_upload_list.py

作用：
- 读取原始 Monkey 结果
- 原始结果存在 `TestCase` 列时，优先按每行 `TestCase` 解析测试专项
- 根据包名映射、正则映射、问题等级规则生成 Jira 上传模板
- 自动写入 Project、Affect Project、Summary、Description、Components、Priority 等字段

usage:
python generate_transsion_jira_upload_list.py
						--add-main-excel MAIN_EXCEL_PATH
						--set-project-key PROJECT_KEY
						--set-test-case TEST_CASE
						--set-output OUTPUT_PATH
						--set-affect-project AFFECT_PROJECT
						--set-environment ENVIRONMENT
						--set-case-no CASE_NO
						--affect-project-mapping-file AFFECT_PROJECT_MAPPING_FILE
						--severity-rules-file SEVERITY_RULES_FILE
						--probability-rules-file PROBABILITY_RULES_FILE
						--test-summary-file TEST_SUMMARY_FILE
						--summary-tags TAG1 TAG2 TAG3

常用参数：
- --add-main-excel
  原始结果 Excel 路径，默认：Result_None_None_MonkeyAEE_SH_20260323.xls
- --set-test-case
  默认测试项名称或编号，默认：开关机专项
  当原始结果表不存在 `TestCase` 列，或该行 `TestCase` 为空时，回退使用这个参数
  支持两种填写方式：
  1. 与 `稳定性专项汇总.xlsx` 中 `测试项` 列完全匹配，例如：开关机专项
  2. 填写 `稳定性专项汇总.xlsx` 中的 `编号`，例如：0 代表 Monkey专项，3 代表 开关机专项
- --summary-tags
  概要附加标签，默认：OP MR GKI
- --set-environment
  默认 Environment，默认：PR1-A1
- --set-case-no
  默认用例编号，默认：NA
- --affect-project-mapping-file
  Affect Project 统一映射文件
  单个机型条目同时包含：
  1. `jira_project`：第一阶段模板中的 `Project`
  2. `affect_project`：第一阶段模板中的 `Affect Project`
  3. `monkey_project`：当测试项为 `Monkey专项` 时，第一阶段模板中的 `Project`
- --severity-rules-file
  问题等级规则表路径，当前同一份 xls 同时包含：
  1. 报错类型/次数 -> 问题等级 的规则
  2. 问题等级 -> Jira Priority 的映射
- --probability-rules-file
  问题出现概率评级表路径
  当前用于控制是否添加 `【偶现】` 标签，以及标题中的概率词语
- --test-summary-file
  稳定性专项汇总表路径
  当前用于提供专项测试总次数，以及 Description 中 `A)Preconditions` 的测试步骤
  第一阶段会同时校验 `TestCase` 或 `--set-test-case` 是否能在这张表中按“测试项全名”或“编号”匹配到合法专项

示例：
python generate_transsion_jira_upload_list.py

python generate_transsion_jira_upload_list.py --add-main-excel Result_None_None_MonkeyAEE_SH_20260323.xls --set-test-case 开关机专项 --summary-tags OP

python generate_transsion_jira_upload_list.py --add-main-excel Result_None_None_MonkeyAEE_SH_20260323.xls --set-test-case 3 --summary-tags OP

原始结果表 `TestCase` 列说明：
- 如果原始结果表包含 `TestCase` 列，脚本会优先读取该列作为每行的测试专项
- `TestCase` 支持两种格式：
  1. 完全填写 `稳定性专项汇总.xlsx` 中的 `测试项`
  2. 填写 `稳定性专项汇总.xlsx` 中的 `编号`
- 如果某行 `TestCase` 不合法，脚本会直接报错并跳过该行
- 如果整份文件解析出的测试专项只有一个，输出文件名会自动带上该专项名；如果存在多个专项，输出文件名会使用 `多专项`


4、第一阶段输出模板字段

输出 Excel 主要字段如下：
- Project
- Issue Type
- Summary
- Description
- Priority
- Severity Level
- Severity Rule
- Assignee
- Reporter
- Components
- Versions
- Environment
- Risk
- Test Total Count
- Issue Source
- Issue Category
- Issue Nature
- Affect Project
- Case No
- Clients
- Fix Way
- Focus
- Importance
- Security Level
- Opener
- PS

字段补充说明：
- `Affect Project` 由 `config\affect_project_mapping.json` 统一映射生成
- `Case No` 当前固定输出为 `NA`，不再读取原始结果表中的 `Activity`
- `Exp Class` 在模板中会按展示值标准化输出，例如 `Native (NE) -> NE`、`Java (JE) -> JE`
- `Device Count` 会优先读取原始结果表中的 `Device Count/DeviceCount/device_count` 列；若原始表未提供，再按 `DeviceId` 做兼容回退
- `PS` 当前会额外追加日志服务器访问说明，标题以 Jira 粗体格式输出
- 出于安全要求，日志服务器密码不会写死在代码中；如需在 `PS` 中显示真实密码，请先设置环境变量 `TRANSSION_LOG_SERVER_PASSWORD`
- 也可以在本地维护 `config\local_ps_whitelist.json` 作为白名单；仅当 `allow_embed_log_server_password=true` 时，脚本才会把其中的 `log_server_password` 写入 `PS`


5、第二阶段：批量建单

脚本：
- create_transsion_jira_batch_from_excel.py

作用：
- 读取上传模板 Excel
- 连接 http://jira.transsion.com
- 按每行 Project / Issue Type 动态读取 create meta
- 校验 Components、Versions、Affect Project、优先级与自定义字段选项
- 建单时会把模板中的 `Exp Class` 写入 `customfield_14202`
- 只提交当前 create meta 中允许创建的字段，避免把不在建单界面上的可选字段一起提交导致 400
- 创建成功后支持追加评论与上传“问题严重定义”附件
- 创建成功后会自动尝试把问题从 `Submitted` 流转到 `Open/开放`
- 创建问题时会先把经办人设置为当前登录提交人，流转到 `Open/开放` 后再按模板中的模块负责人回写
- 每条问题完成“建单+备注+附件+流转+回写负责人”这一整套动作后，会强制等待一段时间再处理下一条，避免 Jira 服务器短时间内被连续请求压满
- 支持 validate-metadata、dry-run、实际建单、追加评论

usage:
python create_transsion_jira_batch_from_excel.py
						--add-excel-file EXCEL_FILE
						--jira-username JIRA_USERNAME
						--jira-password JIRA_PASSWORD
						--jira-server JIRA_SERVER
						--config-file CONFIG_FILE
						--severity-rules-file SEVERITY_RULES_FILE
						--bug-severity-image-dir BUG_SEVERITY_IMAGE_DIR
						--wait-between-issues WAIT_BETWEEN_ISSUES
						--validate-metadata
						--dry-run
						--add-comments
						--disable-regression

第二阶段参数说明：
- --add-excel-file
  上传模板 Excel 路径
- --jira-username
  Jira 登录用户名
- --jira-password
  Jira 登录密码
- --jira-server
  Jira 服务地址，不传时默认读取 config/transsion_jira_defaults.json 中的 jira_server
- --config-file
  默认配置文件路径，不传时默认读取 config/transsion_jira_defaults.json
- --severity-rules-file
  问题等级规则表路径，默认读取 config/问题等级定级表.xls
  第二阶段会从同一份 xls 的 `等级优先级映射` sheet 读取问题等级和 Jira Priority 的映射关系
- --bug-severity-image-dir
  问题严重定义附件图片目录，默认读取 config/bug_severity_priority_image
  实际建单成功后，脚本会按 `Risk + 问题等级规则表中的等级->Jira Priority映射` 自动选择对应图片并上传
- --wait-between-issues
  每条问题处理完成后，开始下一条前的强制等待秒数
  不传时默认读取 config/transsion_jira_defaults.json 中的 `default_wait_between_issues_seconds`
  当前默认值为 5 秒，传 `0` 可关闭等待
- 状态流转说明
  当前项目实测会在建单后先处于 `Submitted`
  脚本会在评论和附件处理完成后，自动查找指向 `Open/开放` 的可用 transition 并执行
  为避免模块负责人没有建单审核权限，脚本会在建单时先使用当前登录用户作为 Assignee，流转完成后再回写模板中的目标 Assignee
- 第二阶段新增回归配置
  - 配置文件：`config/regression_rules.json`
  - 读取模块：`transsion_regression_models.py`
  - `regression.enabled` 用于控制是否启用第二阶段新增的回归验证链路，默认 `true`
  - 执行前会先按 `jira_export.jql` 导出历史问题单到本地 SQLite
  - `matching.required_exact_fields` 固定要求 `affect_project`、`environment`、`exp_class`
  - `matching.cause_similarity_threshold` 默认值为 `0.9`
  - `regression.required_regression_pass_versions` 默认值为 `2`
  - `output.sqlite_path` 默认写入 `result/regression_cache/<Project>.db`
  - `output.excel_summary_dir` 默认写入 `result`
  - `status_rules` 用于定义回归状态归类，后续第二阶段回归比对会按该配置统一判断状态
  - `open_like` 命中后不会重复提单，会沿用历史单并覆盖更新 `Summary/Description/Priority`
  - `resolved_fixed` 且本轮未命中时，会按 `required_regression_pass_versions` 做回归 PASS 计数；达到阈值后会尝试执行关单流转
  - 回归 PASS 真实执行时会自动追加备注：
    - `Monkey专项` 沿用原格式：`已回归验证{pass_count}个版本PASS，已测试版本：{version_text}`
    - 其他专项使用固定多行模板：

```text
验证结果：PASS
测试次数：0/1000
验证步骤：{对应测试专项}
验证版本：{测试版本}
样机标识：PR1
应用版本：/
测试人员及联系方式：吕代+18379465576
备注：已回归验证{pass_count}个版本PASS，已测试版本：{version_text}
```
  - `resolved_fixed` 但 `fixVersion` 为空，或当前版本已达到/超过 `fixVersion` 且再次命中时，会在结果中标记 `MANUAL_REVIEW`
  - 每次运行都会同时输出 JSON 结果、SQLite 明细和 Excel 摘要
  - 当 `regression.enabled=false` 时，脚本会完全跳过历史单导出、强命中、PASS/关单、SQLite 和 Excel 摘要，只保留原有第二阶段建单流程和 JSON 结果
- --validate-metadata
  只读取 Jira 项目的 create meta 并打印必填字段、字段名映射，不创建问题
  适用场景：第一次接入新项目、确认字段 ID、确认问题类型是否存在、确认必填项是否变化
- --dry-run
  读取上传模板并做完整字段校验，但不实际创建问题
  适用场景：在真实提单前确认 Components、Versions、Affect Project、优先级和自定义字段值都能通过
  dry-run 同样会执行历史单匹配和 PASS 判定，并输出 JSON/SQLite/Excel 结果，但不会实际修改 Jira 或累计本地 PASS 状态
- --add-comments
  实际建单成功后，把模板中的 PS 列追加为评论
- --disable-regression
  单次执行时临时关闭第二阶段新增的回归验证功能
  优先级高于 `config/regression_rules.json` 里的 `regression.enabled`
  开启后会跳过历史单导出、强命中、PASS/关单、SQLite 和 Excel 摘要，仅保留原有第二阶段建单流程和 JSON 结果
- --regression-project
  进入“回归验证模式”，指定要处理的 Jira 项目 Key
- --regression-specialty
  回归验证模式下指定专项，支持重复传多个
- --current-version
  回归验证模式下显式指定当前验证版本
- --history-reporter
  回归验证模式下按 reporter 粗筛历史问题

示例：
python create_transsion_jira_batch_from_excel.py --add-excel-file JIRA_Upload_List_Transsion_开关机专项_20260325_120728.xlsx --jira-username your_user --jira-password your_password --validate-metadata

python create_transsion_jira_batch_from_excel.py --add-excel-file JIRA_Upload_List_Transsion_开关机专项_20260325_120728.xlsx --jira-username your_user --jira-password your_password --dry-run

python create_transsion_jira_batch_from_excel.py --add-excel-file JIRA_Upload_List_Transsion_开关机专项_20260325_120728.xlsx --jira-username your_user --jira-password your_password --add-comments

python create_transsion_jira_batch_from_excel.py --regression-project X6851OS16 --regression-specialty 休眠唤醒专项 --regression-specialty Monkey专项 --current-version X6851-16.3.0.021(OP001PF001AZ)_SU --history-reporter dailv.tinno --jira-username your_user --jira-password your_password --dry-run

模式互斥说明：
- 传 `--add-excel-file` 时走 Excel 模式
- 传 `--regression-project` 时走回归验证模式
- 两种模式参数不能同时使用


5.1、辅助脚本：按模块批量修正经办人

脚本：
- update_transsion_jira_assignee_by_component.py

作用：
- 指定一个项目库 Key
- 手动指定一个模块和一个经办人
- 批量把 Jira 问题单中命中该模块的问题，经办人改成手动指定的人

默认规则：
- 默认 JQL：`project = "<项目库>" AND statusCategory != Done`
- 如果问题单没有 `Components`，会跳过
- 如果问题单 `Components` 中不包含手动指定模块，会跳过
- 如果当前经办人已经正确，不会重复修改

参数：
- --project-key
  目标项目库 Key，必传
- --jira-username
  Jira 登录用户名
- --jira-password
  Jira 登录密码
- --jira-server
  Jira 服务地址，不传时默认读取 config/transsion_jira_defaults.json
- --set-module
  手动指定一个模块名，仅处理包含该模块的问题
- --set-assignee
  手动指定该模块对应的经办人
- --jql
  自定义查询条件；不传时使用默认 JQL
- --max-results
  最多处理的问题数量，默认 500
- --wait-between-issues
  每条问题处理完成后，开始下一条前的等待秒数；不传时默认读取 config/transsion_jira_defaults.json 中的 `default_wait_between_issues_seconds`
- --dry-run
  只输出将要修改的目标经办人，不实际更新 Jira

示例：
python update_transsion_jira_assignee_by_component.py --project-key X6851OS16 --jira-username your_user --jira-password your_password --dry-run

python update_transsion_jira_assignee_by_component.py --project-key X6851OS16 --jira-username your_user --jira-password your_password --wait-between-issues 5

python update_transsion_jira_assignee_by_component.py --project-key X6851OS16 --jira-username your_user --jira-password your_password --set-module Framework_other --set-assignee dailv.tinno --dry-run


6、当前映射文件说明

config/affect_project_mapping.json
作用：
- 机型前缀 -> `Project + Affect Project` 统一映射
- 若配置了 `monkey_project`，则当测试项解析为 `Monkey专项` 时，`Project` 会切到对应 Monkey 库

当前示例：
- X6726B -> jira_project: X6726BO151, affect_project: X6726B
- X6851 -> jira_project: X6851OS16, affect_project: X6851-P865
- X6851B -> jira_project: X6851BOS16, affect_project: X6851B-P865, monkey_project: X6851B6AEE
- X6852 -> jira_project: X6852OS16, affect_project: X6852OS16

说明：
- 有些项目的 Jira 项目 Key 与页面名称不同
- 有些项目的 Affect Project 选项值也不等于机型前缀
- 标准流程下，第二阶段直接读取第一阶段生成好的上传模板，不再额外重写 `Affect Project`
- 因此这两份映射文件必须分开维护

config/问题等级定级表.xls
作用：
- sheet `aeeexp`
  报错类型/次数 -> 问题等级
- sheet `等级优先级映射`
  问题等级 -> Jira Priority
  Priority 别名 -> Jira Priority 标准名称

当前示例：
- S -> 紧急
- A -> 严重
- B -> 重要
- C -> 次要

说明：
- 不同 Jira 系统的 Priority 命名可能不同
- 如果后续接入新 Jira 系统，优先调整 `等级优先级映射` sheet，而不是直接改脚本
- 旧的 config/severity_priority_mapping.json 已废弃，当前脚本不再读取

补充说明：
- 第一阶段模板会额外输出 `Severity Level` 和 `Severity Rule`
- `Severity Level` 表示根据定级规则命中的问题等级
- `Severity Rule` 表示具体命中的规则或回退规则，便于人工核对为什么会生成当前 Priority

config/问题出现概率评级表.xlsx
作用：
- 概率等级 -> 是否添加 `【偶现】` 标签
- 概率等级 -> 标题正文附加词语

当前示例：
- once -> 加 `【偶现】`，正文使用 `小概率`
- occasional -> 加 `【偶现】`，正文使用 `概率性`
- often -> 加 `【偶现】`，正文使用 `大概率`
- must -> 不加 `【偶现】`，正文不加概率词语

当前阈值逻辑：
- 只出现 1 次 -> once
- count / 测试总次数 < 3/20 -> occasional
- 3/20 <= count / 测试总次数 < 1 -> often
- count >= 测试总次数 -> must

config/稳定性专项汇总.xlsx
作用：
- `测试总次数` 用于计算问题出现概率
- `测试步骤` 用于填充 Description 的 `A)Preconditions`

Environment 字段说明：
- 上传模板中的 `Environment` 当前写入原始明细中的：
  - `异常包名：...`
  - `异常进程：...`
- 如果原始明细中未提取到这两行，则回退为原来的默认 Environment 文本

config/bug_severity_priority_image
作用：
- 第二阶段建单成功后上传“问题严重定义”附件
- 文件命名规则：`{Risk}-{Severity}.png`
- 示例：`Once-Major.png`、`Often-Critical.png`、`Must-Block.png`


7、当前验证结论

基于以下命令已完成验证：

第一阶段：
python generate_transsion_jira_upload_list.py --add-main-excel Result_None_None_MonkeyAEE_SH_20260323.xls --set-test-case 开关机专项 --summary-tags OP

第二阶段：
python create_transsion_jira_batch_from_excel.py --add-excel-file JIRA_Upload_List_Transsion_开关机专项_20260325_120728.xlsx --jira-username dailv.tinno --jira-password <password> --validate-metadata

python create_transsion_jira_batch_from_excel.py --add-excel-file JIRA_Upload_List_Transsion_开关机专项_20260325_120728.xlsx --jira-username dailv.tinno --jira-password <password> --dry-run

验证结果：
- 第一阶段已成功生成模板
- 最新模板文件：
  JIRA_Upload_List_Transsion_开关机专项_20260325_210224.xlsx
- 第二阶段已成功读取 X6851OS16 / 故障 的 create meta
- 第二阶段 dry-run 已通过
- Priority 映射已并入 config/问题等级定级表.xls
- 第一阶段已接入问题出现概率评级表与稳定性专项汇总表
- 第二阶段已具备严重定义附件自动解析能力
- 当前尚未执行真实建单


8、后续扩展建议

新增项目时，优先维护以下文件：
- config/affect_project_mapping.json
- config/包名与模块&经办人对应表_transsion.xlsx
- config/问题等级定级表.xls
- config/问题出现概率评级表.xlsx
- config/稳定性专项汇总.xlsx
- config/bug_severity_priority_image

如果只是新增项目映射，通常不需要改代码。

如果出现以下情况，需要补配置而不是改脚本：
- 新机型对应新的 Jira 项目 Key
- Affect Project 下拉值与机型前缀不一致
- 模块名称发生变化
- 经办人发生变化
- 问题等级规则发生变化
- 概率标签或标题附加词语发生变化
- 专项测试步骤或测试总次数发生变化

