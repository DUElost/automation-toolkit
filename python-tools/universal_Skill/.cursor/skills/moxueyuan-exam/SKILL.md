---
name: moxueyuan-exam
description: Fill Tinno moxueyuan online exams using local answer bank (7月考试.txt) via Playwright. Pre-login uses PC 扫码登录 (tinno.study.moxueyuan.com/login); fill supports exam QR (--qr). Use when the user mentions 魔学院、moxueyuan、扫码登录、扫码考试、在线答题、或 7月考试.txt.
---

# 魔学院在线答题

## 何时使用

用户要对照本地答案库自动勾选魔学院考试题；预先登录用 PC 扫码登录页，答题入口可用二维码图片。

## 工作目录

`python-tools/universal_Skill`

## 检查清单

```
- [ ] pip install -r scripts/requirements.txt
- [ ] python scripts/parse_answers.py --input "7月考试.txt" --output data/answers.json
- [ ] 预先登录：python scripts/exam_bot.py login
      （打开 https://tinno.study.moxueyuan.com/login ，扫码登录）
- [ ] 填答：python scripts/exam_bot.py fill --qr exam_entry_qr.png
- [ ] 阅读 data/last_report.json；默认不交卷，浏览器保持打开
```

## 规则

1. **登录**：默认 PC 页 `https://tinno.study.moxueyuan.com/login`（扫码登录）。
2. **填答**：`--qr` 解码答题二维码后归一到 `study.../task/exam/questions/<id>`。
3. 选项按文字匹配；默认不交卷；缺登录态时自动打开 PC 登录页。
4. 不要索要或保存账号密码。

## 命令

```bash
python scripts/exam_bot.py login
python scripts/exam_bot.py fill --qr exam_entry_qr.png
python scripts/qr_decode.py --image exam_entry_qr.png
```
