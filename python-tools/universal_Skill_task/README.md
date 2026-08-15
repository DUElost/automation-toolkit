# universal_Skill_task — BPM → EHR 可行性脚本

用 Playwright（有界面）登录 [BPM](https://bpm.tinno.com)，进入门户主页后点击右下角 EHR 入口，经 SSO 进入 EHR。

## 准备

```powershell
cd python-tools\universal_Skill_task
pip install -r requirements.txt
python -m playwright install chromium
copy .env.example .env
# 编辑 .env，填写 BPM_USERNAME / BPM_PASSWORD
```

## 运行

```powershell
python main.py
```

成功时控制台输出：

```text
[OK] BPM login success url=https://bpm.tinno.com/
[OK] EHR opened url=https://ehr.tinno.com/... title=Vantop
```

失败时在 `artifacts/` 留截图，并打印当前 URL。

## 流程说明

1. 打开 `https://bpm.tinno.com`，浏览器弹出**个人数字证书**选择框，脚本自动确认
2. 登录页默认是企业微信扫码，脚本切到密码登录并提交账号密码
3. 登录后落在工时提报界面，脚本点击顶栏「门户」进入主页
4. 在右下角「导航」面板点击 EHR，新标签页经 SSO 打开 EHR，无需二次登录

## 关于证书弹窗

站点要求个人数字证书。证书弹窗是浏览器原生窗口，Playwright 无法操作，脚本改为在导航期间向浏览器窗口发送回车确认（见 `cert_dialog.py`），仅在导航期间生效，避免误触页面。

彻底免弹窗需要企业策略 `AutoSelectCertificateForUrls`，本机 `HKCU\Software\Policies` 被组策略锁定，需**管理员**写入 HKLM 后才可用：

```powershell
# 以管理员身份运行 PowerShell
reg add "HKLM\SOFTWARE\Policies\Chromium\AutoSelectCertificateForUrls" /v 1 /t REG_SZ /d "{\"pattern\":\"https://[*.]tinno.com\",\"filter\":{\"ISSUER\":{\"CN\":\"TINNO CA\"}}}" /f
```

写入后浏览器会静默选用该证书；脚本的回车兜底逻辑仍可保留，互不冲突。

## 安全

- 真实密码只放本地 `.env`，勿提交 git
- 本仓库 `.gitignore` 已忽略 `.env` 与 `artifacts/*`

## 加班只读决策（dry-run）

```powershell
python main_overtime_dry_run.py
```

流程：登录 BPM → 进 EHR → 我的考勤（昨日打卡）→ 首页 → 加班查询 → 输出决策日志到控制台与 `artifacts/overtime_decision_*.log`。

**禁止提交加班申请。** 代码内 `ALLOW_SUBMIT_OVERTIME=False`。

## 加班预填（不提交） / 带 `--ALLOW` 直接提交

```powershell
# 只预填，人工核对后按 Enter（默认）
python main_overtime_prefill.py --reason "V552AA项目稳定性挂测"

# 预填后直接点「提交」（--ALLOW = 同意提交）
python main_overtime_prefill.py --reason "V552AA项目稳定性挂测" --ALLOW
```

行为：

1. 登录后处理**最近 7 个自然日（不含今天）**，从早到晚逐日决策
2. 仅当某日 `action=APPLY` 时打开「加班申请」并预填加班日期、起止时间、事由
3. `SKIP_*` 只写日志，自动进入下一天
4. **无 `--ALLOW`**：不点提交，预填后停住等 Enter
5. **有 `--ALLOW`**：预填后立即点击「提交」，再处理下一天

人工核对截图：`artifacts/overtime_prefill_*_filled_YYYYMMDD.png`（提交后另有 `*_submitted_*`）

## 飞书汇总通知

在 `.env` 中配置群机器人 Webhook（飞书群 → 设置 → 群机器人 → 自定义机器人）：

```env
FEISHU_WEBHOOK_URL=https://open.feishu.cn/open-apis/bot/v2/hook/xxxx
FEISHU_SECRET=          # 可选，开启签名校验时填写
```

`main_overtime_prefill.py` 跑完后发送一条飞书卡片：触发时间、各账号决策明细、汇总结果。

## 多账号（一个任务串行执行）

每个账号独立启动浏览器 → 登录 BPM → 读 EHR → 关闭浏览器，再处理下一个账号。全部完成后**只发一条飞书卡片**。

```powershell
copy accounts.yaml.example accounts.yaml
# 编辑 accounts.yaml，填写各账号 id / username / password

python main_overtime_prefill.py --no-prompt --decisions-only `
  --accounts-file accounts.yaml `
  --reason account1:"V552AA项目挂测" `
  --reason account2:"XX项目挂测"
```

开发阶段可用同一账号跑两遍验证串行流程：

```powershell
copy accounts.dev.yaml.example accounts.yaml
# 两个 id 填相同 username/password，事由用 --reason account1:... --reason account2:...
```

- `--reason <id>:事由` 与 `accounts.yaml` 中的 `id` 对应；也可用 `--reason "统一事由"`（单账号或作默认值）
- 未配置 `--accounts-file` 时，仍使用 `.env` 单账号（飞书卡片显示邮箱，不再出现 `default`）

## 每天 10:00 定时 + 飞书通知

推荐在仓库根目录用自带 `taskmgr` 注册（需 10:00 时电脑已开机且已登录）：

```powershell
cd F:\automation-toolkit
taskmgr add ehr-overtime-daily
# 调度方式: 1（每天）
# Hour: 10
# Minute: 0
# 启动命令:
#   python .\python-tools\universal_Skill_task\main_overtime_prefill.py --decisions-only --no-prompt
# 工作目录请选: python-tools\universal_Skill_task（或在命令里写全路径）
```

说明：

- `--decisions-only`：只读考勤/加班并决策，**不预填、不提交**（适合每日早报）
- `--no-prompt`：无人值守，不等待 Enter
- 若要预填但不提交，去掉 `--decisions-only`，仍保留 `--no-prompt`
- **不要**在定时任务里加 `--ALLOW`，自动提交需人工确认后再手动执行

管理：

```powershell
taskmgr list
taskmgr start ehr-overtime-daily    # 立即试跑
taskmgr log ehr-overtime-daily      # 查看调度日志
taskmgr remove ehr-overtime-daily   # 删除任务
```

也可用底层脚本注册（等价）：

```powershell
.\windows-scheduler\Register-ScheduledTool.ps1 `
  -TaskName "ehr-overtime-daily" `
  -FilePath "python" `
  -Arguments ".\python-tools\universal_Skill_task\main_overtime_prefill.py --decisions-only --no-prompt" `
  -WorkDir ".\python-tools\universal_Skill_task" `
  -DailyAt "10:00" `
  -ReplaceExisting
```
