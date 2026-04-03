# Transsion Stage2 Handoff

## 1. 当前目标

当前目录实现的是 Transsion Jira 两阶段工具中的第二阶段增强版：

- 第一阶段：原始结果 Excel -> Jira 上传模板
- 第二阶段：上传模板 -> Jira 建单
- 第二阶段新增能力：
  - Jira 历史单导出
  - 本地 SQLite 比对
  - 强命中判定
  - 状态分流
  - 回归 PASS / 关单
  - Excel 摘要输出

## 2. 当前核心入口

- 主入口：
  [create_transsion_jira_batch_from_excel.py](F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/create_transsion_jira_batch_from_excel.py)
- 公共建单逻辑：
  [transsion_batch_jira_common.py](F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/transsion_batch_jira_common.py)
- 回归配置：
  [regression_rules.json](F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/config/regression_rules.json)
- 使用说明：
  [readme.txt](F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/readme.txt)
- 设计文档：
  [2026-03-29-transsion-stage2-regression-design.md](F:/automation-toolkit/docs/superpowers/specs/2026-03-29-transsion-stage2-regression-design.md)
- 实施计划：
  [2026-03-29-transsion-stage2-regression.md](F:/automation-toolkit/docs/superpowers/plans/2026-03-29-transsion-stage2-regression.md)

## 3. 已确认业务规则

### 3.1 已解决问题定义

- `状态 = 已解决`
- `解决结果 = 已修复`

### 3.2 不修复类解决结果

统一归为 `wont_fix_like`：

- `问题不修改`
- `非问题`
- `Won't Fix`
- `不解决`

### 3.3 open_like 状态

- `Open`
- `开放`
- `Reopened`
- `重新打开`
- `处理中`

`Submitted` 不参与历史状态决策。

### 3.4 强命中规则

必须同时满足：

- `affect_project` 完全一致
- `environment` 完全一致
- `exp_class` 完全一致
- `caused_by` 归一化后相似度 `>= 0.9`

不使用 `components` 和 `summary` 作为主命中条件。

### 3.5 状态动作

- `open_like`
  - 不提新单
  - 更新原单 `Summary/Description/Priority`
  - 追加主备注
  - 如有 `PS` 且 `--add-comments=true`，追加 `PS` 评论
- `已解决 + 已修复 + 当前版本 < fixVersion`
  - 只备注“待新版本验证”
- `已解决 + 已修复 + fixVersion 为空`
  - `MANUAL_REVIEW`
- `已解决 + 已修复 + 当前版本 >= fixVersion` 且本轮再次命中
  - `MANUAL_REVIEW`
- `wont_fix_like`
  - 不提单、不改状态，只追加保留原结论备注
- `已关闭 + 非 wont_fix_like`
  - 重新提单
- 未命中历史单
  - 新建单

### 3.6 回归 PASS 规则

候选必须同时满足：

- 历史单 `状态=已解决`
- 历史单 `解决结果=已修复`
- 本轮未命中
- `fixVersion` 有值
- `current_version >= fixVersion`
- 当前版本此前没有记过 PASS

达到阈值前：

- `REGRESSION_PASS_PROGRESS`

达到阈值后：

- `REGRESSION_PASS_CLOSE`

默认阈值：

- `required_regression_pass_versions = 2`

## 4. 当前关键开关

### 4.1 配置开关

在 [regression_rules.json](F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/config/regression_rules.json) 中：

```json
"regression": {
  "enabled": true,
  "required_regression_pass_versions": 2
}
```

当 `enabled=false` 时：

- 不导出历史 Jira 单
- 不做强命中
- 不做 PASS / 关单
- 不初始化 SQLite
- 不输出 Excel 摘要
- 仅保留原有第二阶段建单流程和 JSON 结果

### 4.2 命令行临时开关

主入口支持：

```bash
--disable-regression
```

它的优先级高于配置文件里的 `regression.enabled`。

### 4.3 Components 兜底规则

在 [transsion_batch_jira_common.py](F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/transsion_batch_jira_common.py) 中：

- 原始 `Components` 合法：直接使用
- 原始 `Components` 无效：尝试回退到 `ODM处理`
- `ODM处理` 也不存在：报错同时包含
  - 原始无效值
  - 尝试回退 `ODM处理` 失败

## 5. 当前实现状态

已完成：

- 回归配置模型与校验
- SQLite 持久化
- Jira 快照导出
- 强命中判定
- 状态动作执行
- PASS / 关单后处理
- Excel 摘要输出
- 配置开关 `regression.enabled`
- 命令行临时开关 `--disable-regression`
- Components 无效值兜底到 `ODM处理`

当前没有待实现的大项，但仍需按实际 Jira 项目元数据确认：

- `ODM处理` 是否在目标项目的合法 Components 列表中
- 关闭状态流转在实际项目中是否有可用 transition

## 6. 常用执行命令

### 6.1 关闭回归功能执行 dry-run

```powershell
python .\create_transsion_jira_batch_from_excel.py --add-excel-file .\result\你的Excel.xlsx --jira-username xxx --jira-password xxx --dry-run --disable-regression
```

### 6.2 开启回归功能执行 dry-run

```powershell
python .\create_transsion_jira_batch_from_excel.py --add-excel-file .\result\你的Excel.xlsx --jira-username xxx --jira-password xxx --dry-run
```

## 7. 常用验证命令

### 7.1 入口与配置开关

```powershell
python -m pytest F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_regression_config.py F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_batch_entry.py -q
```

### 7.2 Components 兜底规则

```powershell
python -m pytest F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_batch_common.py -q
```

### 7.3 相关回归

```powershell
python -m pytest F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_batch_common.py F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_batch_entry.py F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_regression_executor.py F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_regression_pass.py -q
```

## 8. 新窗口接手建议

新窗口建议先读取以下文件，再继续工作：

1. [handoff_transsion_stage2.md](F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/handoff_transsion_stage2.md)
2. [readme.txt](F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/readme.txt)
3. [create_transsion_jira_batch_from_excel.py](F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/create_transsion_jira_batch_from_excel.py)
4. [transsion_batch_jira_common.py](F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/transsion_batch_jira_common.py)

建议新窗口首句直接写：

```text
先读取 F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\handoff_transsion_stage2.md，再继续当前任务
```
