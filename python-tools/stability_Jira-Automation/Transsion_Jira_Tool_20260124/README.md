# Transsion JIRA 必解标签工具

该工具用于在 `http://jira.transsion.com` 上，将指定项目中 **提单人(report) 的问题单**里
“必解标签”为空的条目设置为 **Not MP Block**。

## 依赖

- Python 3.10+
- 已安装依赖：`jira`, `python-dotenv`

## 使用方式

进入仓库根目录执行：

```bash
python Transsion_Jira_Tool_20260124/set_not_mp_block.py \
  --project-key KO5OS16AEE \
  --jira-username your_login \
  --jira-password "your_password" \
  --report-username target.reporter
```

## 参数说明

- `--project-key` / `-p`：项目 Key（必填）
- `--jira-username` / `-u`：登录用账号（可选，缺省读取 `.env`）
- `--jira-password` / `-w`：登录用密码（可选，缺省读取 `.env`）
- `--report-username` / `-r`：提单人用户名（可选，缺省使用 currentUser）
- `--priority-name`：优先级名称（可选，支持多个值）
- `--component-name`：模块名称（可选，不填写则不限制模块）
- `--update-all`：更新所有“必解标签为空”的问题单（默认只更新最新一条）

## 其他工具

### set_not_mp_block_is_empty.py

将 **最新一条**（或批量）已设置 `Not MP Block` 且满足筛选条件的问题单清空“必解标签”。

示例：

```bash
python Transsion_Jira_Tool_20260124/set_not_mp_block_is_empty.py \
  --project-key KO5OS16AEE \
  --jira-username dailv.tinno \
  --jira-password "59e-LJB-KbB-Hbb" \
  --report-username xiaohongli.tinno \
  --priority-name "Major" \
  --component-name "3RD_Stability"
```

参数：

- `--priority-name`：优先级名称（可选，不填写则不限制优先级）
- `--component-name`：模块名称（可选，不填写则不限制模块）
- `--update-all`：清空所有符合条件的问题单（默认只处理最新一条）

## 示例

只更新最新一条（默认）：

```bash
python Transsion_Jira_Tool_20260124/set_not_mp_block.py \
  --project-key KO5OS16AEE \
  --jira-username dailv.tinno \
  --jira-password "59e-LJB-KbB-Hbb" \
  --report-username dailv.tinno
```

更新所有“必解标签为空”的问题单：

```bash
python Transsion_Jira_Tool_20260124/set_not_mp_block.py \
  --project-key KO5OS16AEE \
  --jira-username dailv.tinno \
  --jira-password "59e-LJB-KbB-Hbb" \
  --report-username dailv.tinno \
  --update-all
```

按优先级与模块筛选后批量更新：

```bash
python Transsion_Jira_Tool_20260124/set_not_mp_block.py \
  --project-key KO5OS16AEE \
  --jira-username dailv.tinno \
  --jira-password "59e-LJB-KbB-Hbb" \
  --report-username xiaohongli.tinno \
  --priority-name "Major" \
  --component-name "3RD_Stability" \
  --update-all
```

按多个优先级筛选（JQL: `priority in (...)`）：

```bash
python Transsion_Jira_Tool_20260124/set_not_mp_block.py \
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

## 行为说明

- 工具只会更新“必解标签为空”的问题单。
- 可通过 `--priority-name` / `--component-name` 进行额外筛选（同时提供时会一起生效）。
- `--priority-name` 支持多个值，会自动生成 `priority in (...)`。
- 默认只处理最新的一条；加上 `--update-all` 会批量更新。
*** End Patch}"}]}`}
