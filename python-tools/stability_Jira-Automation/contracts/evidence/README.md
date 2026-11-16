# B8 G8 独立复核证据（b8-g8-attribution-v1）

本目录保存 Transsion / Tinno 两套工具使用**同一探针**生成的脱敏证据。
数据全部为模拟工作簿、模拟 manifest 与模拟 Jira；不包含真实 Jira 地址、
账号、Cookie、P12 或生产数据。

- 探针：[`../probes/b8g8_review_probe.py`](../probes/b8g8_review_probe.py)
- 完整报告：[`b8g8_probe_reports.json`](./b8g8_probe_reports.json)
- 产物样本：[`sample_attribution.json`](./sample_attribution.json)、
  [`sample_batch_result.json`](./sample_batch_result.json)
- 反例基线：`24f86c895740ebf735533b1914047118fd6544de`
- 复跑命令：

```bash
python contracts/probes/b8g8_review_probe.py \
  --repo-root <repo> --tool transsion \
  --workspace /tmp/probe-trans --report /tmp/probe-trans.json

python contracts/probes/b8g8_review_probe.py \
  --repo-root <repo> --tool tinno \
  --workspace /tmp/probe-tinno --report /tmp/probe-tinno.json
```

基线复跑时把 `--repo-root` 指向 `24f86c8` 的 worktree 即可；探针本身在当前分支。

## 红绿对照

| 场景 | Transsion 基线 | Transsion 新 HEAD | Tinno 基线 | Tinno 新 HEAD |
|---|---|---|---|---|
| 新建 + 匹配 + 失败 | 绿 | 绿 | 红（审计 JSON 未落工作区） | 绿 |
| 清空 Occurrence IDs | 红（回落 manifest，产生关联） | 绿 | 红（回落 manifest，产生关联） | 绿 |
| 小数标识 7.5 / 101.5 | 红（截断为 7 / 101） | 绿 | 红（截断为 7 / 101） | 绿 |
| AutoFilter 隐藏行 | 红（隐藏行仍建单） | 绿 | 红（隐藏行仍建单） | 绿 |
| 显式删行 | 绿 | 绿 | 绿 | 绿 |
| 重排 | 绿 | 绿 | 绿 | 绿 |
| 重复发生 | 绿 | 绿 | 绿 | 绿 |
| 相对 `--output-dir` | 红（摘要写脚本目录） | 绿 | 红（摘要/审计写脚本目录） | 绿 |
| 绝对 `--output-dir` | 绿 | 绿 | 红（审计写脚本目录） | 绿 |
| 自动工作区（cwd） | 绿 | 绿 | 红（审计写脚本目录） | 绿 |
| 双工作区隔离 | 红（回归缓存写脚本目录） | 绿 | 红（审计/回归缓存写脚本目录） | 绿 |
| 旧默认行为 | 绿 | 绿 | 绿 | 绿 |
| 第一阶段清单落工作区 | 绿 | 绿 | 绿 | 绿 |

## 本次修复的关键点

1. **清空 Occurrence IDs 不再回填**：列存在但单元格为空时返回
   `EMPTY_OCCURRENCE_IDS`，写 `empty_occurrence_ids` gap，不生成 link。
2. **小数标识严格拒绝**：`7.5` / `101.5` 不再 `int(float(...))` 截断，
   返回 `INVALID_SIGNATURE_ID` / `INVALID_OCCURRENCE_ID`。
3. **AutoFilter 隐藏行**：两套建单入口在读取工作簿后识别隐藏行，
   不调用 Jira、不写 link，结果记 `SKIPPED` + `autofilter_hidden`。
4. **输出目录**：相对路径按进程 cwd 解析；摘要 XLSX、Tinno 审计 JSON、
   批量结果与 `attribution.json` 全部落本次工作区；SQLite 缓存在工作区模式下
   也改为工作区内，双工作区不串写。
5. **旧行为**：无 manifest 且未指定 `--output-dir` 时仍写脚本目录 `result/`，
   不生成归因产物。
