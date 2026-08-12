# BPM 登录并进入 EHR — 设计说明

日期：2026-08-12  
状态：已确认  
范围：`python-tools/universal_Skill_task`

## 目标

本阶段仅验证可行性，成功标准如下：

1. 使用账号密码自动登录 `https://bpm.tinno.com`
2. 进入 BPM 首页后，点击首页「EHR」入口
3. 经 SSO 自动进入 EHR（无需二次登录）
4. 控制台明确输出成功/失败；失败时保留截图便于排查

后续 EHR 内业务操作不在本阶段范围，将另开需求。

## 决策

| 项 | 选择 |
|----|------|
| 技术方案 | Playwright 同步 API，有界面 Chromium（方案 1） |
| EHR 入口 | BPM 首页门户图标/菜单「EHR」，点击后 SSO 进入 |
| 凭据 | 本地 `.env` / 环境变量；不写进源码、不提交 git |
| 登录态 | 本阶段不持久化；每次运行重新登录 |
| 无头模式 | 不做（先有界面确认可行性） |

## 模块结构

```text
python-tools/universal_Skill_task/
├── requirements.txt      # playwright（及 python-dotenv）
├── .env.example          # 占位，无真实密码
├── .gitignore            # .env、artifacts/、__pycache__/
├── config.py             # BPM_URL / BPM_USERNAME / BPM_PASSWORD
├── browser.py            # 启动有界面 Chromium
├── bpm_login.py          # 打开登录页 → 填账号密码 → 提交并等待首页
├── navigate_ehr.py       # 首页定位并点击 EHR，等待进入 EHR
└── main.py               # 串联流程并打印结果
```

原则：登录与进入 EHR 分离，便于后续追加业务步骤。

## 流程

1. 读取配置（缺凭据则立即失败并提示）
2. 启动有界面浏览器，打开 BPM 登录页
3. 填写账号、密码并提交
4. 等待进入 BPM 首页
5. 定位并点击「EHR」入口（可能同页跳转或新标签页）
6. 等待 EHR 页面加载（URL/标题等可识别特征）
7. 输出成功；浏览器保持打开一段时间（可配置，默认约 15 秒）便于肉眼确认

## 配置

| 变量 | 说明 | 默认 |
|------|------|------|
| `BPM_URL` | BPM 登录入口 | `https://bpm.tinno.com` |
| `BPM_USERNAME` | 登录账号 | 必填 |
| `BPM_PASSWORD` | 登录密码 | 必填 |
| `KEEP_OPEN_SECONDS` | 成功后保持浏览器秒数 | `15` |

## 成功 / 失败判定

**成功**

- 已离开登录页并进入 BPM 首页
- 点击 EHR 后进入 EHR 相关页面（URL 或标题含可识别标识；实现时按实测页面微调）

**失败**

- 超时、找不到登录控件或 EHR 入口
- 疑似验证码 / 二次验证：明确报错为「需人工介入」，不盲目重试
- 失败时截图保存到 `artifacts/`，并打印当前 URL

## 运行方式（Windows）

```powershell
cd python-tools\universal_Skill_task
pip install -r requirements.txt
python -m playwright install chromium
# 复制 .env.example 为 .env 并填入账号密码后：
python main.py
```

## 非目标（本阶段不做）

- EHR 内具体业务（请假、考勤、审批等）
- 无头模式、登录态持久化、多账号并发
- 破解验证码或绕过二次验证

## 风险与假设

- 假设账号密码即可登录 BPM（无强制验证码/二次验证）；若实测相反，本阶段以明确报错 + 截图为止，再决定是否加人机协作步骤
- EHR 入口文案/DOM 以实现时页面为准；选择器集中在 `navigate_ehr.py`，避免散落
- 公司站点可能仅内网可达；运行环境需能访问 `bpm.tinno.com`
