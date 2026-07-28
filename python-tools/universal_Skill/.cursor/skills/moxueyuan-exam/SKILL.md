---
name: moxueyuan-exam
description: Fill Tinno moxueyuan online exams using local answer bank (7月考试.txt) via Playwright. Use when the user mentions 魔学院、moxueyuan、在线答题、考试自动填答、或 7月考试.txt.
---

# 魔学院在线答题

## 何时使用

用户要对照本地答案库自动勾选魔学院考试题（题序/选项字母可能打乱）。

## 工作目录

`python-tools/universal_Skill`

## 检查清单

复制并跟踪：

```
- [ ] pip install -r scripts/requirements.txt && playwright install chromium
- [ ] python scripts/parse_answers.py --input "7月考试.txt" --output data/answers.json
- [ ] 若无 data/storage_state.json：python scripts/exam_bot.py login --url "<考试URL>"
- [ ] python scripts/exam_bot.py fill --url "<考试URL>"
- [ ] 阅读 data/last_report.json，处理 unmatched/ambiguous/option_miss
- [ ] 仅当用户明确要求且报告无问题：再加 --submit
```

## 规则

1. **选项按文字匹配**，忽略页面 A/B/C/D 字母。
2. **默认不交卷**。填完后浏览器保持打开供核对；只有用户明确要求才用 `--submit`。若报告有问题，不要加 `--force-submit`，除非用户再次明确同意。自动化场景需要立即关浏览器时加 `--close`。
3. 登录态失效时重跑 `login`，不要索要或保存账号密码。
4. 页面抽题失败时：`fill --dump`，根据 `data/screenshots/page.html` 调整 `exam_bot.py` 中 `EXTRACT_QUESTIONS_JS`。

## 命令

```bash
python scripts/parse_answers.py --input "7月考试.txt" --output data/answers.json
python scripts/exam_bot.py login --url "https://tinno.study.moxueyuan.com/task/exam/questions/..."
python scripts/exam_bot.py fill --url "https://tinno.study.moxueyuan.com/task/exam/questions/..."
python scripts/exam_bot.py fill --url "..." --submit
```
