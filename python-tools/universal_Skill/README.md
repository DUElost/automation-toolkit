# universal_Skill — 魔学院考试自动填答

基于本地答案库（如 `7月考试.txt`），用 Playwright 在魔学院（moxueyuan）考试页按**题干 + 选项文字**自动勾选。

实机验证（Tinno 魔学院考试）：60/60 填答正确，提交后全部 Pass。

---

## 前置环境

| 项 | 要求 |
|----|------|
| OS | Windows 10/11（当前已验证）；macOS/Linux 理论上可用，需自备 Chromium |
| Python | 3.8+（已验证 3.11） |
| 网络 | 能访问 `tinno.study.moxueyuan.com`；首次若下载 Playwright 浏览器失败，脚本会回退到本机已有 Chromium |
| 账号 | 魔学院有效账号；**首次需在脚本弹出的浏览器窗口内手动登录**（不要用日常 Chrome 窗口） |
| 答案库 | 模块根目录下的 `7月考试.txt`（或同格式文本） |

### 安装依赖

在仓库中进入本模块目录后执行：

```powershell
cd python-tools\universal_Skill

# 建议使用虚拟环境（可选）
python -m venv .venv
.\.venv\Scripts\Activate.ps1

pip install -r scripts\requirements.txt

# 推荐安装 Playwright 自带 Chromium（若下载超时可跳过，脚本会尝试本机已有浏览器）
python -m playwright install chromium
```

依赖说明：

- `playwright`：浏览器自动化
- `pytest`：仅跑单测需要

### 目录结构（常用）

```text
python-tools/universal_Skill/
├── 7月考试.txt                 # 答案库（人工维护）
├── README.md
├── .cursor/skills/moxueyuan-exam/SKILL.md
├── scripts/
│   ├── requirements.txt
│   ├── parse_answers.py        # 解析答案库 → JSON
│   ├── matching.py             # 题干/选项文字匹配
│   ├── exam_bot.py             # 登录 / 填答
│   ├── verify_live.py          # 同会话填答+核对（推荐核验）
│   └── verify_fill.py          # 仅打开页面核验（新会话可能无勾选态）
├── tests/
├── data/                       # 本地生成，多数已 gitignore
│   ├── answers.json
│   ├── storage_state.json      # 登录态（勿提交）
│   ├── last_report.json
│   └── verify_live_report.json
└── .gitignore
```

---

## 执行命令

以下命令均在 `python-tools/universal_Skill` 目录下执行。将 `<考试URL>` 换成实际地址，例如：

`https://tinno.study.moxueyuan.com/task/exam/questions/<id>?resource_relation=`

### 1. 解析答案库

```powershell
python scripts\parse_answers.py --input "7月考试.txt" --output data\answers.json
```

成功时会打印类似：`Wrote 60 items -> data\answers.json`。

### 2. 首次登录（保存会话）

```powershell
python scripts\exam_bot.py login --url "<考试URL>" --wait 300
```

1. 脚本会弹出 **Playwright 浏览器**（不是你日常用的 Chrome）
2. 在该窗口完成登录，并进入考试答题页
3. 脚本轮询登录态（最长 `--wait` 秒，默认约 180–300）
4. 成功后写入 `data\storage_state.json`

登录失效时重新执行本命令即可，不要把账号密码写进配置文件。

### 3. 自动填答（默认不交卷）

```powershell
python scripts\exam_bot.py fill --url "<考试URL>"
```

行为说明：

- 按题干模糊匹配答案库；选项按**文字**勾选（页面 A/B/C 字母乱序不影响）
- 会通过侧栏题号展开单选/判断/多选，尽量覆盖全部题目
- **默认不交卷**；填完后**浏览器保持打开**，便于核对后手动点「交卷」
- 关闭浏览器窗口即结束脚本；终端也可按 Enter 关闭浏览器

常用可选参数：

```powershell
# 填完后立刻关掉浏览器（无人值守）
python scripts\exam_bot.py fill --url "<考试URL>" --close

# 导出页面 HTML/截图，便于排查抽题失败
python scripts\exam_bot.py fill --url "<考试URL>" --dump

# 调整题干相似度阈值（默认 0.72）
python scripts\exam_bot.py fill --url "<考试URL>" --threshold 0.72

# 自动交卷（有未匹配/歧义/选项对不上时会拒绝；需强交再加 --force-submit）
python scripts\exam_bot.py fill --url "<考试URL>" --submit
```

填答摘要写入 `data\last_report.json`（`filled` / `unmatched` / `ambiguous` / `option_miss`）。

### 4. 同会话核验（推荐）

在**同一次浏览器会话**中先填答再读回勾选，与答案库逐题比对：

```powershell
python scripts\verify_live.py
```

脚本内默认使用当前考试 URL；如需改 URL，请编辑 `scripts\verify_live.py` 顶部的 `URL` 常量，或后续再扩展为命令行参数。

成功示例要点：

- 页面进度 `60/60`
- `verify_ok == 60`，`verify_wrong == 0`，`verify_empty == 0`
- 详细报告：`data\verify_live_report.json`
- 浏览器保持打开，便于肉眼复核后手动交卷

> 说明：新开浏览器会话再核验时，勾选态可能未同步（进度会显示 `0/60`）。以 `verify_live.py` 的同会话核验为准。

### 5. 单测

```powershell
python -m pytest tests -v
```

---

## 匹配规则（简要）

1. **题干**：规范化后模糊匹配；同干多题时用「页面选项文字集合」与答案库选项集合消歧
2. **选项**：只用答案文字，不信任页面上的 A/B/C/D（字母会打乱）
3. **题型**：单选 / 判断 / 多选均可；多选按文字多选勾选
4. **交卷**：默认手动；`--submit` 为可选自动交卷

---

## 常见问题

| 现象 | 处理 |
|------|------|
| `Executable doesn't exist` / Chromium 下载失败 | 执行 `python -m playwright install chromium`；或依赖脚本自动回退到 `%LOCALAPPDATA%\ms-playwright\chromium-*\chrome.exe` |
| 打开后仍是登录页 / `islogin=N` | 必须在脚本弹出的窗口登录；重新 `login` |
| `Detected 0 question blocks` | 加 `--dump` 查看 `data\screenshots\page.html`；确认已进入答题页而非仅详情/登录页 |
| 只填了部分题 | 确认侧栏题号可点开 1–60；查看 `last_report.json` |
| 新会话核验全空 | 使用 `verify_live.py` 同会话核验，勿单独用新浏览器读勾选态 |
| 填完浏览器被关掉 | 当前默认保持打开；若加了 `--close` 会退出，去掉即可 |

---

## 安全注意

- `data\storage_state.json` 含登录 Cookie，已在 `.gitignore`，**禁止提交到 Git**
- `data\answers.json`、报告、截图为本地生成物，默认忽略
- 不要在仓库或聊天中保存账号密码明文

---

## Cursor Skill

项目内 Skill：`.cursor/skills/moxueyuan-exam/SKILL.md`  

触发场景：提到魔学院 / moxueyuan / 在线答题 / `7月考试.txt` 时，按该 Skill 清单执行上述命令。
