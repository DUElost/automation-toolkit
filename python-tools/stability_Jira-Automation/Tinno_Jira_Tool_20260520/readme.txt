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

当前明确暂不启用的能力：

- duplicate 跟随链路默认禁用
  - 代码保留
  - 配置默认关闭
  - 后续若 Tinno Jira 支持再恢复

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
  - `enable_duplicate_followups=false`
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
- `config/稳定性专项汇总.xlsx`
  第一阶段专项识别配置


4、常用命令

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
  - 仅在真实执行时生效
  - 新建问题单成功后，会把 Excel 中 `PS` 列追加为评论
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
  - 新建问题单后按 `--add-comments` 追加 `PS` 评论
  - 严格版本项目按配置比较版本
- 暂不启用
  - duplicate 跟随关闭
- 尚待真实项目补证
  - `VFFCA` 已解决单真实回归验证
  - Tinno 各项目 fixVersions / 关单流转的项目化差异


7、当前建议

1. 第一阶段继续以真实 `VFFCA` Monkey 数据生成上传模板，作为统一入口。
2. 第二阶段建单完成后，优先使用真实 `VFFCA` 已解决单跑一轮 full dry-run 审计。
3. 审计结果确认无误后，再做真实 PASS / FAIL 备注与关单验证。
4. duplicate 链路保持关闭，等 Tinno Jira 明确支持后再单独恢复。
