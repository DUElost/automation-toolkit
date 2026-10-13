# AGENTS.md

本文件是所有 AI Coding Harness 的最小启动契约。只保留对任何任务都成立的原则；
模块索引、运行命令与业务细节从下方链接读取，不在本文件镜像。

## 总原则

- 先检查代码、测试和当前文档再修改；冲突时以代码与测试为准，并同步权威文档。
- 只改当前任务必需内容，不顺手重构；`stability_Jira-Automation` 下 Transsion / Tinno /
  Moto 三套工具**互不 import**，改动只落在对应子目录。
- 不读取、打印、提交或复制当前任务不需要的凭据（Jira Cookie / P12 / `.env.local` /
  日志服务器密码）；日志与审计输出不得包含它们。
- 对 Jira 的写操作（真实建单、labels 补打等）必须先 `--dry-run` 预览并核对审计输出
  再执行；相关脚本幂等，可安全重复运行，但生产数据可能被他人并行改动，执行前重跑
  dry-run 复核范围。

## 按需入口

全景信息维护在 [`docs/project-guide.md`](docs/project-guide.md) 与模块文档（模块目录内的
`CLAUDE.md` / `readme.txt` 按作用域加载）；本文件只链接、不镜像，更新时只改权威文档，
避免双源漂移。根 `CLAUDE.md` 为 Claude 侧指针薄壳，同样禁止写入正文。

| 需要的内容 | 权威入口 |
|---|---|
| 项目愿景 / 架构总览 / 模块索引 / 变更记录 | [`docs/project-guide.md`](docs/project-guide.md) |
| 运行与开发（各平台环境、启动命令） | [`docs/project-guide.md`](docs/project-guide.md)「运行与开发」 |
| 编码规范 / 命名约定 / gitignore 规则 | [`docs/project-guide.md`](docs/project-guide.md)「编码规范」 |
| 测试策略与 CI | [`docs/project-guide.md`](docs/project-guide.md)「测试策略」＋ `.github/workflows/python-tools.yml` |
| 关键业务规则（SMT 丢帧匹配、Top300 均值、Jira labels/专项映射等） | [`docs/project-guide.md`](docs/project-guide.md)「AI 使用指引」＋对应模块文档 |
| 各工具模块的结构、入口脚本与约定 | 模块目录 `CLAUDE.md` / `readme.txt`（由项目指南「模块索引」注册） |
| Jira 提单工具集总览（三套工具、两阶段流程） | [`python-tools/stability_Jira-Automation/CLAUDE.md`](python-tools/stability_Jira-Automation/CLAUDE.md) |
| Tinno 操作细则（labels 解析链、专项映射、Closed 屏幕限制、retro 脚本） | [`python-tools/stability_Jira-Automation/Tinno_Jira_Tool_20260520/readme.txt`](python-tools/stability_Jira-Automation/Tinno_Jira_Tool_20260520/readme.txt) |
| Transsion / Moto 操作细则 | 各自子目录 `readme.txt` |

## 测试与验证

- Tinno 工具测试：`cd python-tools\stability_Jira-Automation\Tinno_Jira_Tool_20260520` 后
  `.\venv38\Scripts\python.exe -m unittest discover -s test -p "test_*.py"`
  （目录内 venv38 未装 pytest，勿用 `pytest` 直跑）。
- 其余工具按其模块文档与 [`docs/project-guide.md`](docs/project-guide.md)「运行与开发」执行。
- 只报告实际运行过的命令与结果；未完成的检查标为 pending。
