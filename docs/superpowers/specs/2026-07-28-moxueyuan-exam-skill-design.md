# 魔学院在线答题 Cursor Skill — 设计说明

日期：2026-07-28  
状态：待用户审阅  
范围：`python-tools/universal_Skill`

## 1. 目标

在 Cursor 中提供可触发的 Skill，基于本地答案库 `7月考试.txt`，通过 Playwright 在魔学院（moxueyuan）考试页自动勾选答案。默认只填不交；可选 `--submit` 自动交卷。

## 2. 非目标

- 不破解或绕过平台登录/防作弊机制
- 不逆向平台私有答题 API（本版仅走浏览器 UI）
- 不自动注册账号、不保存账号密码明文
- 不处理与答案库无关的主观/开放题（无答案则跳过并记日志）

## 3. 已确认决策

| 项 | 决策 |
|----|------|
| 交互方式 | Playwright 浏览器自动化 |
| 登录 | 脚本启动有头浏览器 → 用户手动登录一次 → 持久化 `storage_state.json` |
| 交卷 | 默认只填不交；`--submit` 才自动交卷 |
| 题目匹配 | 题干文本模糊匹配（忽略题号/顺序） |
| 选项匹配 | 按选项**文字**匹配；不信任页面 A/B/C/D 字母（字母会打乱） |
| 存放位置 | 当前项目 `python-tools/universal_Skill/` |

## 4. 架构

```
Agent (Cursor Skill)
  │  指导安装依赖 / 解析 / 运行 / 根据报告处理未匹配题
  ▼
scripts/parse_answers.py  →  answers.json
scripts/exam_bot.py (Playwright)
  │  加载 storage_state / 打开考试 URL / 逐题读写 DOM
  ▼
魔学院考试页 (SPA)
```

职责边界：

- **SKILL.md**：触发条件、检查清单、命令、失败时如何排错；不内嵌冗长选择器细节
- **parse_answers.py**：仅解析答案库文本 → 结构化 JSON
- **exam_bot.py**：登录态、页面导航、匹配、勾选、可选交卷、报告
- **答案库**：`7月考试.txt`（人工维护）；解析结果可缓存为 `data/answers.json`

## 5. 目录结构

```
python-tools/universal_Skill/
├── .cursor/skills/moxueyuan-exam/SKILL.md
├── 7月考试.txt
├── scripts/
│   ├── parse_answers.py
│   ├── exam_bot.py
│   └── requirements.txt
├── data/
│   ├── answers.json          # 解析缓存（可提交或本地生成）
│   └── storage_state.json    # 登录态（必须 gitignore）
├── tests/
│   └── test_parse_answers.py
├── .gitignore
└── README.md
```

## 6. 答案库格式与解析

输入样例（现有文件）：

```
1.
题干……（ ）
单选题1分
A. 选项文字1
B. 选项文字2
...
问题反馈
回答错误
(0分)
答案： D
```

解析产物每条记录至少包含：

| 字段 | 说明 |
|------|------|
| `stem` | 规范化后的题干 |
| `stem_raw` | 原始题干 |
| `qtype` | `single` / `judge` / `multi`（按文件中的题型行推断） |
| `options` | `[{letter, text}, ...]` |
| `answer_letters` | 如 `["D"]` 或多选 `["A","C"]` |
| `answer_texts` | 由 letter → 对应选项文字得到的列表（**填答时只用这个**） |

规范化规则（题干与选项共用思想）：

- 去掉首尾空白、合并连续空白
- 去掉题号前缀（如行首 `12.`）
- 去掉常见全角/半角标点差异（匹配用）
- 选项文字去掉前缀 `A.` / `A、` 等字母标记后再比较

## 7. 匹配与填答

### 7.1 题干

1. 从页面读取当前题干，规范化
2. 与答案库各题 `stem` 计算相似度（推荐：规范化后的序列匹配比，如 `difflib.SequenceMatcher`）
3. 取最高分；若 `< 阈值`（默认 `0.72`，可配置）→ 标记 `unmatched`，不勾选
4. 若次高分与最高分差距过小（默认 `< 0.05`）→ 标记 `ambiguous`，不勾选

### 7.2 选项

1. 使用答案库的 `answer_texts`（不是字母）
2. 对页面每个选项文字规范化后与 `answer_texts` 比对（精确优先，否则高相似度）
3. 命中则点击该选项控件；字母标签忽略
4. 判断题：将答案库 A/B 映射到该题选项文字（如「正确」「错误」），再按文字点选

### 7.3 交卷

- 默认：全部可答题处理完后暂停，打印报告，**不点击交卷**
- `--submit`：在报告之后点击交卷并确认（若有二次确认对话框则一并处理）
- 存在 `unmatched` / `ambiguous` 时：`--submit` 应拒绝交卷并退出非零码（除非同时传 `--force-submit`）

## 8. 登录态

1. `exam_bot.py login --url <考试URL>`：有头模式打开页面，等待用户登录并进入可答题状态
2. 用户在终端确认后，保存 Playwright `storage_state` 到 `data/storage_state.json`
3. 后续 `fill` / `run` 自动加载该文件；失效时提示重新 `login`

账号密码不进入仓库与配置文件。

## 9. CLI 表面

```text
python scripts/parse_answers.py --input "7月考试.txt" --output data/answers.json
python scripts/exam_bot.py login --url "<考试URL>"
python scripts/exam_bot.py fill --url "<考试URL>" [--answers data/answers.json] [--threshold 0.72]
python scripts/exam_bot.py fill --url "<考试URL>" --submit
python scripts/exam_bot.py fill --url "<考试URL>" --submit --force-submit
```

## 10. Skill 行为

`SKILL.md` 应包含：

- **触发**：魔学院 / moxueyuan / 在线答题 / 7月考试 / 考试自动填答
- **步骤**：安装 playwright → 解析答案 →（如无登录态）login → fill → 根据报告处理未匹配
- **安全**：提醒默认不交卷；未匹配勿强交
- **排错**：登录态失效、选择器找不到、匹配失败时的处理

选择器细节放在 `exam_bot.py` 与可选 `reference.md`；Skill 本体保持简短。

## 11. 错误处理与报告

每次 `fill` 结束输出 JSON 或终端摘要：

- `filled`：已勾选
- `unmatched`：无足够相似题干
- `ambiguous`：多题接近
- `option_miss`：题干命中但选项文字对不上
- `skipped`：不支持的题型

退出码：有 `unmatched`/`ambiguous`/`option_miss` 时非零（便于 Agent 发现）。

## 12. 测试策略

- 单元测试 `parse_answers.py`：用 `7月考试.txt` 片段或 fixture，断言题干、选项文字、`answer_texts`
- 匹配函数单测：字母打乱但文字相同 → 仍选中正确文字
- Playwright 端到端：不强制进 CI（依赖真实站点与登录）；本地手工验证清单写在 README

## 13. 风险与缓解

| 风险 | 缓解 |
|------|------|
| 考试页 DOM/选择器变更 | 选择器集中配置；失败时截图 + 明确报错 |
| 题干措辞与答案库略有差异 | 阈值可调；报告列出候选题干供人工核对 |
| 选项文字也改写 | `option_miss` 不盲点；不自动猜 |
| 误交卷 | 默认不交；有未匹配时拒绝 `--submit` |
| 登录态含会话密钥 | `storage_state.json` 加入 `.gitignore` |

## 14. 成功标准

1. 从 `7月考试.txt` 能稳定解析出带 `answer_texts` 的题库
2. 手动登录一次后，同一会话可反复打开考试 URL 填答
3. 题序与选项字母打乱时，仍按文字填对可匹配题
4. 默认不交卷；`--submit` 在存在未匹配时拒绝交卷
5. Cursor Skill 可被相关话术触发，并指导 Agent 跑通上述流程
