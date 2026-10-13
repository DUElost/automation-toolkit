Tinno_Jira_Tool_20260520 使用说明
================================

1、当前定位

本目录基于 `Transsion_Jira_Tool_20260323` 的两阶段结构迁移而来，用于维护
Tinno 独立 Jira 工具，不与 Transsion 工具混用。

当前版本的实际状态：

- 第一阶段已可用
  - 支持原始问题清单生成 Tinno Jira 上传模板
  - 支持从源表 `TestCase` 行识别不同测试专项
  - 支持多专项混合生成上传模板
  - 支持 Tinno 标题、描述、Environment、PS、日志地址展示
- 第二阶段“新建问题单”已可用
  - 支持 P12 + Cookie 认证
  - 支持真实 Tinno 建单
  - 支持建单成功后同步写入本地项目缓存库
  - 支持 PS 备注追加
- 第二阶段“自动回归验证”逻辑已接通
  - 支持历史单导出、匹配、决策、PASS/FAIL 备注、关单预演
  - 支持 full dry-run 审计输出，预演所有涉及到的决策
  - 支持严格版本项目按配置执行 `build_version / fix_version / current_version` 比较
    （详见下文「VFFCA 严格版本比较规则」）
- duplicate 跟随关闭已启用（与 Transsion 对齐）
  - 已关闭主单（resolution 非 Duplicate）可带动重复子单一同关单
  - 配置项 `enable_duplicate_followups=true`

当前仍待真实验证的点：

- `VFFCA` 已解决单的真实端到端回归验证尚未完成
  - 当前已完成单测、本地 dry-run 和 `VCAME --test-mode` 验证
  - 但尚未完成一轮真实 `VFFCA` resolved/fixVersions/build_version 验证


2、目录结构

- `generate_tinno_jira_upload_list.py`
  第一阶段：原始结果 Excel -> Tinno Jira 上传模板
- `create_tinno_jira_batch_from_excel.py`
  第二阶段：上传模板 -> Tinno Jira 建单 / dry-run / 回归验证
- `tinno_upload_template_common.py`
  第一阶段公共逻辑
- `tinno_batch_jira_common.py`
  第二阶段公共建单逻辑
- `tinno_regression_*.py`
  Tinno 回归匹配、决策、报告、缓存逻辑
- `jira_p12_client.py`
  Tinno P12 认证客户端
- `jira_issue_template.py`
  Tinno 已确认的标题、描述、Environment、PS 模板逻辑


3、核心配置

- `config/tinno_jira_defaults.json`
  Tinno 默认服务地址、项目、认证字段、P12 配置、第一阶段默认值
- `config/regression_rules.json`
  回归导出字段、状态规则、严格版本项目、审计输出、缓存目录
  当前关键项：
  - `enable_duplicate_followups=true`
  - `write_audit_report=true`
  - `strict_version_project_keys=["VFFCA"]`
- `config/regression_comment_config.json`
  结构化 PASS / FAIL 备注模板配置
  - `common`
  - `pass_template`
  - `fail_template`
- `config/comment_templates.json`
  兼容保留的备注模板配置资产，当前 Tinno 第二阶段主回归备注已改由
  `regression_comment_config.json` 驱动
- `config/包名与模块&经办人对应表_tinno.xls`
  包名到模块 / 经办人映射
- `config/问题等级定级表.xls`
  严重度/优先级规则
- `config/affect_project_mapping.json`
  第一阶段项目前缀解析与项目映射
- `config/summary_product_mapping.json`
  版本前缀到标题产品名的映射
- `config/module_assignee_mapping.json`
  按 Jira 项目保存的模块经办人，由项目初始化从 Jira 组件写入
- `config/稳定性专项汇总.xlsx`
  第一阶段专项识别配置


4、常用命令

新增项目：初始化客户项目、Jira 关键字，并从 Jira 拉取模块经办人

```powershell
python ".\init_tinno_project.py"
```

也可直接传入关键信息，跳过交互：

```powershell
python ".\init_tinno_project.py" `
  --customer-project "PFDFAA" `
  --jira-key "PFDFAA"
```

多个版本前缀指向同一个 Jira 项目时用逗号分隔，例如 `--customer-project "MLD-LX2,V552AA"`。
认证沿用第二阶段的 Cookie 与 P12。包名仍用 `包名与模块&经办人对应表_tinno.xls` 匹配模块；
模块能对上 Jira 组件时，经办人改用组件上的实际经办人。

试运行写到独立工作区，不修改 `config/` 下的正式文件：

```powershell
python ".\init_tinno_project.py" `
  --workspace ".\result\project_init_workspace" `
  --customer-project "MLD-NX2" `
  --jira-key "PFDFAA" `
  --summary-product "P535AA"
```

`MLD-NX2` 是 Monkey 版本前缀，标题产品名是 `P535AA`，Jira 关键字是 `PFDFAA`。
板型段（如 `LX2`、`NX2`）会保留在前缀里，不会收成 `MLD`。

工作区里会生成 `config/affect_project_mapping.json`、`config/summary_product_mapping.json`
和 `config/module_assignee_mapping.json`。确认结果后再去掉 `--workspace` 写入正式配置。

第一阶段：生成 Tinno 上传模板

```powershell
python ".\generate_tinno_jira_upload_list.py" --add-main-excel ".\resource\Result_xxx.xls"
```

第一阶段：测试模式

```powershell
python ".\generate_tinno_jira_upload_list.py" --test-mode
```

第二阶段：只新建问题单，不做回归决策

```powershell
python ".\create_tinno_jira_batch_from_excel.py" `
  --add-excel-file ".\result\JIRA_Upload_List_Tinno_xxx.xlsx" `
  --jira-cookie-jsessionid "<JSESSIONID>" `
  --jira-cookie-xsrf-token "<XSRF_TOKEN>" `
  --create-only
```

第二阶段：真实建单并把 `PS` 列追加为评论

```powershell
python ".\create_tinno_jira_batch_from_excel.py" `
  --add-excel-file ".\result\JIRA_Upload_List_Tinno_xxx.xlsx" `
  --jira-cookie-jsessionid "<JSESSIONID>" `
  --jira-cookie-xsrf-token "<XSRF_TOKEN>" `
  --add-comments
```

第二阶段：全功能真实 dry-run

```powershell
python ".\create_tinno_jira_batch_from_excel.py" `
  --add-excel-file ".\result\JIRA_Upload_List_Tinno_xxx.xlsx" `
  --jira-cookie-jsessionid "<JSESSIONID>" `
  --jira-cookie-xsrf-token "<XSRF_TOKEN>" `
  --dry-run
```

备注说明：

- `--add-comments`
  - 真实建单默认追加评论；只有明确加上 `--no-add-comments` 时才不追加
  - 仅在真实执行时生效
  - 新建问题单成功后，会把 Excel 中 `PS` 列追加为评论
- labels 字段（新建问题时）
  - labels = 该行测试专项标签 + 固定标签 `稳定性测试`，重复值自动去重
  - 专项标签按上传模板 `Test Case` 列经 `test_case_label_mapping` 解析（如 `MTBF专项`→`MTBF`、`Monkey专项`→`MonkeyAEE`）；无 `Test Case` 列时回退取 Summary 版本号后的专项 token；仍解析不到才使用配置 `labels` 的静态值
  - 固定标签可在配置 `fixed_labels` 中调整（默认 `["稳定性测试"]`）
  - 修复历史问题：此前 labels 始终取配置 `labels` 静态值，所有单均为 `MonkeyAEE`，未跟随对应专项
  - 仅影响新建；命中历史单更新时不改 labels
- 问题等级
  - 按 `config/问题等级定级表.xls` 匹配；报错类型同时对照异常类型、异常子类和包名
  - 多条规则同时命中时，用更长的报错类型
  - 有定级表但一条都对不上时，该行不进入上传模板，并在结束时列出跳过记录
- 历史单备注
  - 当命中历史单且决策需要评论时，脚本会追加结构化 FAIL 备注
  - 当回归 PASS 判定成立时，脚本会追加结构化 PASS 备注
- `--dry-run`
  - 只做字段组装、历史匹配、决策预演和审计输出
  - 不会真实创建 Jira，不会真实追加任何评论或备注

第二阶段：指定项目做回归验证

```powershell
python ".\create_tinno_jira_batch_from_excel.py" `
  --regression-project "VFFCA" `
  --current-version "MLD-LX2-16-260523V6" `
  --regression-specialty "MonkeyAEE" `
  --history-reporter "dai.lv" `
  --jira-cookie-jsessionid "<JSESSIONID>" `
  --jira-cookie-xsrf-token "<XSRF_TOKEN>"
```

第二阶段：测试模式

```powershell
python ".\create_tinno_jira_batch_from_excel.py" --test-mode --create-only --dry-run
python ".\create_tinno_jira_batch_from_excel.py" --test-mode --regression-project VCAME
```

补打历史单 labels（一次性 retro 脚本）

历史缺陷修复前建的单，labels 全部是 MonkeyAEE；可用以下脚本给已建单批量补打
“专项标签 + 稳定性测试”，并默认把恰好等于旧静态默认值的 labels 修正为 Summary
中的真实专项（仅当 labels 恰好是旧默认值时才替换，人工加过的其它标签一律保留）：

```powershell
# 预览（只读，不提交）
python ".\retro_patch_tinno_labels.py" `
  --project VCAME `
  --jira-cookie-jsessionid "<JSESSIONID>" `
  --jira-cookie-xsrf-token "<XSRF_TOKEN>" `
  --dry-run

# 真实执行
python ".\retro_patch_tinno_labels.py" `
  --project VCAME `
  --jira-cookie-jsessionid "<JSESSIONID>" `
  --jira-cookie-xsrf-token "<XSRF_TOKEN>"
```

- `--issue-key VCAME-123`（可重复）只处理指定单；`--jql` 可完全自定义范围
- `--reporter` / `--status` / `--specialty-token MTBF` 用于缩小 JQL 范围；默认只处理 Summary 含 `[自动化]` 的单，`--include-non-auto` 可放开
- `--no-cleanup-legacy` 改为纯追加（保留旧的 MonkeyAEE，只补专项与稳定性测试）
- 已是目标 labels 的单自动跳过（NO_CHANGE），可重复执行；明细写 `result/retro_patch_tinno_labels_audit_*.json`
- 已知限制：Tinno Jira 的 Closed 状态编辑屏幕不含 labels 字段，真实更新会返回 400；
  可用 `--exclude-status Closed` 跳过，或请管理员放开屏幕后重跑


5、输出物说明

- `result/JIRA_Upload_List_Tinno_*.xlsx`
  第一阶段生成的 Tinno 上传模板
- `result/tinno_jira_batch_create_result_*.json`
  第二阶段逐条处理结果
- `result/tinno_jira_batch_create_summary_*.xlsx`
  第二阶段 Excel 摘要
- `result/tinno_jira_batch_create_audit_*.json`
  第二阶段 full dry-run / 回归预演审计输出
  - 统计总数、状态数、动作数、原因数
  - 明细行保存所有预演决策结果
- `result/retro_patch_tinno_labels_audit_*.json`
  retro 补打 labels 的执行审计（old/new labels、动作、状态统计）
- `result/tinno_regression_cache/<Project>.db`
  Tinno 本地项目缓存库
  - 历史单同步快照
  - 建单成功记录
  - `build_version`
  - 回归 PASS 次数与已验证版本


6、第二阶段当前能力边界

- 已支持
  - 新问题创建
  - build_version 随建单成功记录落库
  - 历史单导出并回填到本地项目缓存库
  - 混合专项上传时，历史单匹配按专项隔离，避免不同专项之间串命中
  - `resolution=重复问题` 时按 `当前提单版本 > 历史建单版本` 判断
    - 较新版本仍复现：只追加备注，不重建
    - 非较新版本：跳过，不重建
  - OPEN / WONT_FIX / RESOLVED_FIXED_WAIT_NEW_VERSION / REGRESSION_PASS 等主决策预演
  - PASS / FAIL 结构化备注生成
  - 新建问题单后默认追加 `PS` 评论，可用 `--no-add-comments` 关闭
  - 严格版本项目按配置比较版本（见下）
  - duplicate 跟随关闭：主单关单后关闭其重复子单（resolution=Duplicate 的主单不触发）
- 尚待真实项目补证
  - `VFFCA` 已解决单真实回归验证
  - Tinno 各项目 fixVersions / 关单流转的项目化差异

6.1、VFFCA 严格版本比较规则

实现位置：`tinno_regression_executor.py`

三个版本字段含义：
- `fix_version`：Jira 已解决时开发人员填写的修复版本，LX2/LX3 可能混填或漏填
- `build_version`：建单时从 Monkey 报告写入的历史版本，板型可信
- `current_version`：本轮 Monkey 测试版本，板型可信

比较策略（仅 `strict_version_project_keys` 中的项目，如 VFFCA）：
- `fix_version` ↔ `build_version`：只比构建日期与 V-number，**不区分 LX 板型**
  （因 fix 来自 Jira，板型不可信）
- `current_version` ↔ `fix_version`：只比构建日期与 V-number，**不区分 LX 板型**
- `current_version` ↔ `build_version`：区分 LX2/LX3 板型后再比日期
  （两者均来自测试报告，LX2 与 LX3 视为不同产品分支）

duplicate 跟随关闭补充规则：
- 主单 resolution 为 Duplicate / 重复问题 时不触发
- 重复子单已是关闭状态或 resolution 为 Done/完成 时跳过
- 重复链接关键字含：duplicate、重复、重于 等


7、当前建议

1. 第一阶段继续以真实 `VFFCA` Monkey 数据生成上传模板，作为统一入口。
2. 第二阶段建单完成后，优先使用真实 `VFFCA` 已解决单跑一轮 full dry-run 审计。
3. 审计结果确认无误后，再做真实 PASS / FAIL 备注与关单验证。
4. duplicate 跟随关闭已默认开启；若某项目 Jira 工作流不支持，可在
   `regression_rules.json` 将 `enable_duplicate_followups` 设为 `false`。
