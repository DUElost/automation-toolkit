# universal_Skill — 魔学院考试自动填答

基于 `7月考试.txt` 答案库，用 Playwright 在魔学院考试页按**题干 + 选项文字**自动勾选。

## 安装

```bash
cd python-tools/universal_Skill
pip install -r scripts/requirements.txt
playwright install chromium
```

## 使用

```bash
python scripts/parse_answers.py --input "7月考试.txt" --output data/answers.json
python scripts/exam_bot.py login --url "<考试URL>"
python scripts/exam_bot.py fill --url "<考试URL>"
# 可选交卷（有未匹配题时会拒绝，除非 --force-submit）
python scripts/exam_bot.py fill --url "<考试URL>" --submit
```

## 注意

- `data/storage_state.json` 含会话信息，已 gitignore，勿提交。
- 默认只填不交。
- 单测：`pytest tests -v`
