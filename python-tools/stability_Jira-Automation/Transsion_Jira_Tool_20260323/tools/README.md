# Transsion JIRA 必解标签工具

该工具用于在 `http://jira.transsion.com` 上，将指定项目中 **提单人(report) 的问题单**里
“必解标签”为空的条目设置为 **Not MP Block**。

## 依赖

- Python 3.10+
- 已安装依赖：`jira`, `python-dotenv`

## 使用方式

进入仓库根目录执行：

```bash
python set_not_mp_block.py \
  --project-key KO5OS16AEE KO5OS16BEE \
  --jira-username your_login \
  --jira-password "your_password" \
  --report-username target.reporter
```

多项目批量更新示例：

```bash
python set_not_mp_block.py \
  --project-key X6852OS16 X6851OS16 X6851BOS16 \
  --report-username dailv.tinno qimingwang.tinno \
  --priority-name Critical \
  --update-all
```

## 参数说明

- `--project-key` / `-p`：项目 Key，支持多个值（必填）
- `--jira-username` / `-u`：登录用账号（可选，缺省读取 `.env`）
- `--jira-password` / `-w`：登录用密码（可选，缺省读取 `.env`）
- `--report-username` / `-r`：提单人用户名（可选，支持多个值，缺省使用 currentUser）
- `--priority-name`：优先级名称（可选，支持多个值）
- `--exclude-priority-name`：排除的优先级名称（可选，支持多个值）
- `--component-name`：模块名称（可选，不填写则不限制模块）
- `--update-all`：更新所有“必解标签为空”的问题单（默认只更新最新一条）

## 其他工具

### set_mp_block.py

将 **最新一条**（或批量）“必解标签为空”且满足筛选条件的问题单设置为 `MP Block`。

示例：

```bash
python Transsion_Jira_Tool_20260323/tools/set_mp_block.py \
  --project-key KO5OS16AEE \
  --jira-username your_login \
  --jira-password "your_password" \
  --report-username target.reporter
```

多项目示例：

```bash
python Transsion_Jira_Tool_20260323/tools/set_mp_block.py \
  --project-key KO5OS16AEE KO5OS16BEE \
  --jira-username your_login \
  --jira-password "your_password" \
  --report-username target.reporter \
  --update-all
```

多报告人示例：

```bash
python Transsion_Jira_Tool_20260323/tools/set_mp_block.py \
  --project-key KO5OS16AEE KO5OS16BEE \
  --jira-username your_login \
  --jira-password "your_password" \
  --report-username dailv.tinno qimingwang.tinno \
  --priority-name Blocker \
  --update-all
```

参数：

- `--project-key` / `-p`：项目 Key，支持多个值（必填）
- `--jira-username` / `-u`：登录用账号（可选，缺省读取 `.env`）
- `--jira-password` / `-w`：登录用密码（可选，缺省读取 `.env`）
- `--report-username` / `-r`：提单人用户名（可选，支持多个值，缺省使用 currentUser）
- `--priority-name`：优先级名称（可选，支持多个值）
- `--exclude-priority-name`：排除的优先级名称（可选，支持多个值）
- `--component-name`：模块名称（可选，不填写则不限制模块）
- `--update-all`：更新所有“必解标签为空”的问题单（默认只更新最新一条）

### set_mandatory_label_by_rule.py

按内置规则批量设置 A/B 类问题的必解标签：

- `Blocker`（A 类）全部设置为 `MP Block`
- `Critical`（B 类）中，`ExpClass` 为 `JE` 或 `NE` 且 `Total Number >= 20` 的设置为 `MP Block`
- `Critical`（B 类）中，`ExpClass = ANR` 且 `Total Number >= 50` 的设置为 `MP Block`
- 其余能解析出 `Total Number` 的 B 类问题，仅对“必解标签为空”的问题设置为 `Not MP Block`
- 如果这类 B 类问题的“必解标签”已有值，则跳过处理，并在日志中输出“已有值”
- 如果摘要里没有 `Total Number`，该问题记为失败，不执行 Jira 更新
- 解决结果为 `不能修复`、`无法再次复现`、`Platform Limit` 的问题直接跳过，不设置必解标签

脚本结束前会对“本次处理范围内的项目 + 报告人”的所有 A/B 类问题做断言校验：

- 必解标签不能为空
- 必解标签不能存在多个值

示例：

```bash
python Transsion_Jira_Tool_20260323/tools/set_mandatory_label_by_rule.py \
  --project-key X6852OS16 X6851OS16 X6851BOS16 X1103AEE \
  --jira-username your_login \
  --jira-password "your_password" \
  --report-username dailv.tinno qimingwang.tinno
```

Dry-run 预演：

```bash
python Transsion_Jira_Tool_20260323/tools/set_mandatory_label_by_rule.py \
  --project-key X6852OS16 X6851OS16 X6851BOS16 X1103AEE \
  --report-username dailv.tinno qimingwang.tinno \
  --dry-run
```

参数：

- `--project-key` / `-p`：项目 Key，支持多个值（必填）
- `--jira-username` / `-u`：登录用账号（可选，缺省读取 `.env`）
- `--jira-password` / `-w`：登录用密码（可选，缺省读取 `.env`）
- `--report-username` / `-r`：提单人用户名（可选，支持多个值，缺省使用 currentUser）
- `--component-name`：模块名称（可选，不填写则不限制模块）
- `--dry-run`：只预览将要设置的标签，不执行 Jira 更新；断言阶段仅做多标签预检

### set_not_mp_block_is_empty.py

将 **最新一条**（或批量）已设置 `Not MP Block` 且满足筛选条件的问题单清空“必解标签”。

示例：

```bash
python Transsion_Jira_Tool_20260323/tools/set_not_mp_block_is_empty.py \
  --project-key KO5OS16AEE \
  --jira-username dailv.tinno \
  --jira-password "your_password" \
  --report-username xiaohongli.tinno \
  --priority-name "Major" \
  --component-name "3RD_Stability"
```

参数：

- `--priority-name`：优先级名称（可选，不填写则不限制优先级）
- `--component-name`：模块名称（可选，不填写则不限制模块）
- `--update-all`：清空所有符合条件的问题单（默认只处理最新一条）

### set_not_mp_block_not_major.py

将 **最新一条**（或批量）“必解标签为空”且 **优先级不是 `Major`** 的问题单设置为 `Not MP Block`。

示例：

```bash
python Transsion_Jira_Tool_20260323/tools/set_not_mp_block_not_major.py \
  --project-key KO5OS16AEE \
  --jira-username dailv.tinno \
  --jira-password "your_password" \
  --report-username xiaohongli.tinno \
  --component-name "3RD_Stability" \
  --update-all
```

参数：

- `--component-name`：模块名称（可选，不填写则不限制模块）
- `--update-all`：更新所有“必解标签为空”且非 Major 的问题单（默认只处理最新一条）

### verify_resolved_issues.py

将指定多个项目中状态为 `Resolved` 的问题，通过 `VerifyIssue` 流转到 `Verified`，
并统一备注：`按照原单测试步骤验证。`

示例：

```bash
python Transsion_Jira_Tool_20260323/tools/verify_resolved_issues.py \
  --project-keys KO5OS16AEE KO5OS16BEE \
  --jira-username your_login \
  --jira-password "your_password" \
  --reporter target.reporter
```

多个报告人：

```bash
python Transsion_Jira_Tool_20260323/tools/verify_resolved_issues.py \
  --project-keys KO5OS16AEE KO5OS16BEE \
  --jira-username your_login \
  --jira-password "your_password" \
  --reporter user.one user.two
```

兼容旧参数名：

```bash
python Transsion_Jira_Tool_20260323/tools/verify_resolved_issues.py \
  --project-keys KO5OS16AEE KO5OS16BEE \
  --jira-username your_login \
  --jira-password "your_password" \
  --report-username target.reporter
```

参数：

- `--project-keys` / `-p`：项目 Key，支持多个值（必填）
- `--jira-username` / `-u`：登录用账号（可选，缺省读取 `.env`）
- `--jira-password` / `-w`：登录用密码（可选，缺省读取 `.env`）
- `--reporter` / `--report-username` / `-r`：提单人用户名（必填，支持多个值）
- `--dry-run`：只预览将要流转的问题单，不执行 Jira 状态更新

Dry-run 示例：

```bash
python verify_resolved_issues.py \
  --project-keys KO5OS16AEE KO5OS16BEE \
  --reporter target.reporter \
  --dry-run
```

### remove_verify_comment.py

删除错误写入的备注：`按照原单测试步骤验证。`

单条模式：

```bash
python Transsion_Jira_Tool_20260323/tools/remove_verify_comment.py \
  --issue-key KO5OS16AEE-100 \
  --jira-username your_login \
  --jira-password "your_password"
```

批量模式：

```bash
python Transsion_Jira_Tool_20260323/tools/remove_verify_comment.py \
  --project-keys KO5OS16AEE KO5OS16BEE \
  --update-all \
  --jira-username your_login \
  --jira-password "your_password"
```

行为说明：

- 每个问题单只删除内容完全等于 `按照原单测试步骤验证。` 的最新一条评论
- 单条模式只处理 `--issue-key` 指定的问题单
- 批量模式必须同时提供 `--project-keys` 和 `--update-all`
- 批量模式只检索状态为 `Resolved` 或 `Verified`，且最近 1 天内有更新的问题单

参数：

- `--issue-key` / `-i`：单条问题单号
- `--project-keys` / `-p`：项目 Key，支持多个值，配合批量模式使用
- `--update-all`：批量处理所有匹配的问题单
- `--jira-username` / `-u`：登录用账号（可选，缺省读取 `.env`）
- `--jira-password` / `-w`：登录用密码（可选，缺省读取 `.env`）

## 示例

只更新最新一条（默认）：

```bash
python Transsion_Jira_Tool_20260323/tools/set_not_mp_block.py \
  --project-key KO5OS16AEE \
  --jira-username dailv.tinno \
  --jira-password "your_password" \
  --report-username dailv.tinno
```

更新所有“必解标签为空”的问题单：

```bash
python Transsion_Jira_Tool_20260323/tools/set_not_mp_block.py \
  --project-key KO5OS16AEE KO5OS16BEE \
  --jira-username dailv.tinno \
  --jira-password "your_password" \
  --report-username dailv.tinno \
  --update-all
```

按优先级与模块筛选后批量更新：

```bash
python Transsion_Jira_Tool_20260323/tools/set_not_mp_block.py \
  --project-key KO5OS16AEE \
  --jira-username dailv.tinno \
  --jira-password "your_password" \
  --report-username xiaohongli.tinno \
  --priority-name "Major" \
  --component-name "3RD_Stability" \
  --update-all
```

按多个优先级筛选（JQL: `priority in (...)`）：

```bash
python Transsion_Jira_Tool_20260323/tools/set_not_mp_block.py \
  --project-key KO5OS16AEE \
  --jira-username dailv.tinno \
  --jira-password "your_password" \
  --report-username xiaohongli.tinno \
  --priority-name Blocker Critical \
  --update-all
```

## .env 可选配置

如果不想在命令行输入账号密码，可以在仓库根目录 `.env` 中配置：

```
JIRA_USERNAME=your_login
JIRA_PASSWORD=your_password
```

## Windows 定时任务

已提供以下脚本用于通过 Windows 任务计划程序每天 `09:00` 自动执行 `verify_resolved_issues.py`：

- `verify_resolved_config.json`：项目 Key、reporter 与 dry-run 配置
- `run_verify_resolved_issues.ps1`
- `register_verify_resolved_task.ps1`

### 前置条件

先在 `tools/` 目录或仓库根目录创建 `.env`：

```env
JIRA_USERNAME=your_login
JIRA_PASSWORD=your_password
```

按需编辑 `verify_resolved_config.json`：

```json
{
  "project_keys": ["X6852OS16", "X6851OS16"],
  "reporters": ["your_login"],
  "dry_run": false
}
```

### 手工执行启动器

```powershell
powershell -ExecutionPolicy Bypass -File .\run_verify_resolved_issues.ps1
```

预演模式（不写入 Jira）：

```powershell
powershell -ExecutionPolicy Bypass -File .\run_verify_resolved_issues.ps1 -DryRun
```

日志会写到：

- `logs\verify_resolved_issues_YYYY-MM-DD.log`

### 注册每天 09:00 任务

```powershell
powershell -ExecutionPolicy Bypass -File .\register_verify_resolved_task.ps1
```

注册后的任务名为：

- `TranssionJiraVerifyResolvedIssuesDaily`

如果注册时报“拒绝访问”或任务计划程序相关错误，请使用有权限的 PowerShell 会话重新执行。

### 手工触发已注册任务

```powershell
schtasks /Run /TN "TranssionJiraVerifyResolvedIssuesDaily"
```

### 查看任务是否存在

```powershell
schtasks /Query /TN "TranssionJiraVerifyResolvedIssuesDaily"
```

## 行为说明

- 工具通过 JQL `"必解标签" is EMPTY` 直接筛选空标签问题单。
- 可通过 `--priority-name` / `--exclude-priority-name` / `--component-name` 进行额外筛选（同时提供时会一起生效）。
- `--priority-name` 与 `--exclude-priority-name` 均支持多个值。
- 默认只处理最新的一条空标签单；加上 `--update-all` 会批量更新。
