# universal_Skill_task — BPM → EHR 可行性脚本

用 Playwright（有界面）登录 [BPM](https://bpm.tinno.com)，在首页点击 EHR，经 SSO 进入 EHR。

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

成功时控制台输出 `[OK] BPM login success` 与 `[OK] EHR opened`；失败时在 `artifacts/` 留截图。

## 安全

- 真实密码只放本地 `.env`，勿提交 git
- 本仓库 `.gitignore` 已忽略 `.env` 与 `artifacts/*`
