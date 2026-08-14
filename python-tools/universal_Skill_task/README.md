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

## 加班预填（不提交）

```powershell
python main_overtime_prefill.py
```

行为：

1. 与 dry-run 相同：登录 → 读考勤/加班查询 → 写决策日志
2. 仅当 `action=APPLY` 时打开「加班申请」并预填加班日期、起止时间、事由「待确认」（表单无可见类别字段，不填）
3. **不会**点击提交/保存；`ALLOW_SUBMIT_OVERTIME` 必须为 `False`
4. 预填后浏览器保持打开，终端按 Enter 后退出

人工核对截图：`artifacts/overtime_prefill_*.png`
