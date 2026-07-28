# universal_Skill — 魔学院考试自动填答

基于本地答案库（如 `7月考试.txt`），用 Playwright 在魔学院（moxueyuan）考试页按**题干 + 选项文字**自动勾选。

支持：
- **预先登录**：默认打开 `https://tinno.study.moxueyuan.com/login`，在 Playwright 窗口内**扫码登录**
- **扫码填答**：`--qr` 传入答题入口二维码；解码后自动转到 PC 答题页 `study.../questions/<id>`
- 登录态缺失/失效时，`fill` 会先引导 PC 扫码登录再填答

> **注意区分两种「扫码」**  
> - **登录扫码**：PC 登录页 `https://tinno.study.moxueyuan.com/login` 上的扫码登录（企业微信/微信等）  
> - **答题入口二维码**：考试通知图里的二维码（如 `exam_entry_qr.png`），用于进入某场考试，不是登录页本身  

实机验证（Tinno 魔学院考试）：60/60 填答正确，提交后全部 Pass。

---

## 前置环境

| 项 | 要求 |
|----|------|
| OS | Windows 10/11（当前已验证）；macOS/Linux 理论上可用，需自备 Chromium |
| Python | 3.8+（已验证 3.11） |
| 网络 | 能访问魔学院域名（含 `tinno.m.moxueyuan.com` / `tinno.study.moxueyuan.com`） |
| 账号 | 魔学院有效账号；登录须在**脚本弹出的 Playwright 窗口**完成（不要用日常 Chrome） |
| 答案库 | `7月考试.txt`（或同格式文本） |
| 入口二维码 | 推荐 `exam_entry_qr.png`（模块根目录）；也可使用原始「扫码参加考试」PNG |

### 安装依赖

```powershell
cd python-tools\universal_Skill

# 建议使用虚拟环境（可选）
python -m venv .venv
.\.venv\Scripts\Activate.ps1

pip install -r scripts\requirements.txt

# 推荐安装 Playwright Chromium（下载失败时可跳过，脚本会回退本机已有浏览器）
python -m playwright install chromium
```

依赖：

- `playwright`：浏览器自动化
- `opencv-python-headless`：二维码解码
- `pytest`：单测

### 目录结构（常用）

```text
python-tools/universal_Skill/
├── 7月考试.txt                 # 答案库
├── exam_entry_qr.png           # 答题入口二维码（推荐路径，ASCII 文件名）
├── README.md
├── .cursor/skills/moxueyuan-exam/SKILL.md
├── scripts/
│   ├── requirements.txt
│   ├── qr_decode.py            # 二维码 → URL
│   ├── parse_answers.py
│   ├── matching.py
│   ├── exam_bot.py             # login / fill（支持 --qr / --url）
│   ├── verify_live.py
│   └── verify_fill.py
├── tests/
├── data/                       # 本地生成（gitignore）
│   ├── answers.json
│   ├── storage_state.json      # 登录态，勿提交
│   └── last_report.json
└── .gitignore
```

---

## 推荐流程：PC 扫码登录 + 答题二维码填答

在 `python-tools/universal_Skill` 下执行。

### 1. 解析答案库

```powershell
python scripts\parse_answers.py --input "7月考试.txt" --output data\answers.json
```

### 2. 预先登录（PC 扫码登录页）

默认打开：`https://tinno.study.moxueyuan.com/login`（支持扫码登录）

```powershell
python scripts\exam_bot.py login
# 等价于：
# python scripts\exam_bot.py login --url https://tinno.study.moxueyuan.com/login
```

1. 弹出 Playwright 浏览器并打开 PC 登录页  
2. 在窗口内使用「扫码登录」完成认证  
3. 成功后写入 `data\storage_state.json`

### 3. 扫答题二维码填答

答题入口二维码（如 `exam_entry_qr.png`）解码后多为移动端分享链，脚本会自动归一到 PC 答题页：

`https://tinno.study.moxueyuan.com/task/exam/questions/<id>`

```powershell
python scripts\exam_bot.py fill --qr exam_entry_qr.png
```

行为：

- 有登录态：直接打开 PC 答题页填答  
- 无/失效：先打开 PC 扫码登录页引导登录，再填答  
- **默认不交卷**；填完浏览器保持打开，便于手动交卷（`--close` 可立即关闭）

仅查看答题二维码内容：

```powershell
python scripts\qr_decode.py --image exam_entry_qr.png
```

### 4. 同会话核验（可选）

```powershell
python scripts\verify_live.py
```

### 5. 单测

```powershell
python -m pytest tests -v
```

---

## 也支持直接传考试 URL

`--qr` 与 `--url` 在 `fill` 上二选一：

```powershell
python scripts\exam_bot.py fill --url "https://tinno.study.moxueyuan.com/task/exam/questions/7720452"
```

常用可选参数：

```powershell
python scripts\exam_bot.py fill --qr exam_entry_qr.png --dump
python scripts\exam_bot.py fill --qr exam_entry_qr.png --threshold 0.72
python scripts\exam_bot.py fill --qr exam_entry_qr.png --submit
python scripts\exam_bot.py fill --qr exam_entry_qr.png --close
```

---

## 匹配规则（简要）

1. 题干模糊匹配；同干题用选项文字集合消歧  
2. 选项按文字勾选，忽略页面 A/B/C 字母乱序  
3. 支持单选 / 判断 / 多选  

---

## 常见问题

| 现象 | 处理 |
|------|------|
| 二维码解码失败 | 确认图片清晰完整；`pip install opencv-python-headless` |
| 中文文件名在终端乱码 | 使用 `exam_entry_qr.png` |
| 打开答题页又跳回登录 | 重新执行 `python scripts\exam_bot.py login`（PC 扫码登录页） |
| 答题二维码是移动端链接 | 正常：`fill --qr` 会自动转到 `study.../questions/<id>` |
| Chromium 下载失败 | 脚本会回退本机 Playwright Chromium；或重试 `python -m playwright install chromium` |
| 填完浏览器被关掉 | 去掉 `--close`（默认保持打开） |

---

## 安全注意

- `data\storage_state.json` 含 Cookie，已 gitignore，**禁止提交**
- 不要在仓库保存账号密码

---

## Cursor Skill

`.cursor/skills/moxueyuan-exam/SKILL.md`  

提到魔学院 / 扫码考试 / `--qr` / `7月考试.txt` 时按该 Skill 执行。
