# B8 G8 厂商 Jira 工具归因契约（b8-g8-attribution-v1）

本目录是 Transsion 与 Tinno 两套 Jira 工具共用的**唯一契约来源**。两套工具各自保留一份
实现（`jira_attribution.py`），内容逐行一致，仅 `TOOL_NAME` 不同；测试会校验两份实现
除该常量外完全相同，避免契约漂移。

- 契约版本：`b8-g8-attribution-v1`
- 平台输入 manifest：`stp.jira_delivery_input/v1`
- 工具归因产物：`stp.jira_attribution/v1`
- 机器可读定义：[attribution-contract-v1.json](./attribution-contract-v1.json)

## 1. 稳定标识

| 字段 | 来源 | 用途 |
|---|---|---|
| `signature_id` | 平台 `manifest.issues[].signature_id` | 问题签名，来自交付版本登记范围 |
| `occurrence_id` | 平台 `manifest.attribution_candidates[].occurrence_id` | 一次具体发生，工具只透传 |
| `occurrence_key` | 平台生成（设备侧事实 sha256） | 审计与去重，工具不改写 |

只有 `(signature_id, occurrence_id)` 同时出现在 `attribution_candidates` 中，工具才会
把 Jira key 关联到该发生。缺失、无效、越界或重复的标识只写入 `gaps`，绝不猜配行序。

一个清单项合并多个发生时，工作簿保留完整集合：

```text
Signature ID | Occurrence IDs          | Occurrence Keys              | Occurrence Count
7            | [101, 102, 103]         | ["k101", "k102", "k103"]     | 3
```

## 2. 工作簿列

生成清单在原有列之后追加以下列（旧输入/旧输出模式不追加）：

| 列 | 说明 |
|---|---|
| `Signature ID` | 平台签名 ID |
| `Occurrence IDs` | JSON 数组，清单项合并的全部发生 ID，升序 |
| `Occurrence Keys` | JSON 数组，与 Occurrence IDs 对齐 |
| `Occurrence Count` | 发生数量 |
| `Attribution Status` | 见下表 |
| `Attribution Note` | 诊断说明；合并项记录被合并的 Excel 行 |
| `Source Excel Row` | 生成清单时输入工作簿的物理行号（含表头，从 1 开始） |

人工复核可重排、筛选、删除行；标识随行移动，平台只按标识回写，不依赖行号。

### Attribution Status

| 状态 | 含义 | 是否关联 Jira key |
|---|---|---|
| `OK` | 标识齐全且命中登记范围 | 是 |
| `MERGED` | 同一 signature 的多行合并，保留完整发生集合 | 是 |
| `MISSING_SIGNATURE_ID` | 行没有平台标识 | 否 |
| `INVALID_SIGNATURE_ID` | 标识不是整数 | 否 |
| `UNKNOWN_SIGNATURE_ID` | 标识不在本次 manifest 登记范围 | 否 |
| `NO_OCCURRENCE` | manifest 中该 signature 没有发生 | 否 |
| `INVALID_OCCURRENCE_ID` | Occurrence IDs 含非整数 | 否 |
| `OUT_OF_SCOPE_OCCURRENCE_ID` | 发生不属于该 signature 的登记集合 | 否 |
| `DUPLICATE_OCCURRENCE_ID` | 同一发生出现在多个清单项 | 否（该行不建单） |

## 3. 命令行用法

### 3.1 平台隔离工作区（推荐）

平台把 `manifest.json` 与输入 xls 放进 `{STP_DEDUP_WORK_DIR}/jira_workspaces/{console_run_id}/`
并以该目录为 `cwd` 启动工具。工具自动识别 `cwd/manifest.json`：

```bash
# Transsion 第一阶段
python generate_transsion_jira_upload_list.py \
  --add-main-excel ./delivery_1096_mtk_v2_create.xls \
  --set-test-case Monkey专项 --assignee-auto

# Transsion 第二阶段
python create_transsion_jira_batch_from_excel.py \
  --add-excel-file ./JIRA_Upload_List_Transsion_Monkey专项_*.xlsx \
  --jira-username <user> --jira-password <password>

# Tinno 第一阶段
python generate_tinno_jira_upload_list.py \
  --add-main-excel ./delivery_1096_mtk_v2_create.xls --set-project-key VFFCA

# Tinno 第二阶段
python create_tinno_jira_batch_from_excel.py \
  --add-excel-file ./JIRA_Upload_List_Tinno_Monkey专项_*.xlsx \
  --jira-cookie-jsessionid <JSESSIONID> --jira-cookie-xsrf-token <XSRF> \
  --jira-p12-path <p12> --jira-p12-password <password>
```

平台也可显式指定目录：

```bash
--output-dir /path/to/workspace --attribution-manifest /path/to/workspace/manifest.json
```

### 3.2 独立运行（旧行为）

不传 `--output-dir`，且当前目录没有 `manifest.json` 时：

- 清单与结果仍写脚本目录 `result/`；
- 不新增归因列，不生成归因产物；
- 旧参数、默认输入与 stdout 行为不变。

## 4. 输出落点

显式 `--output-dir` 或平台工作区模式：

```text
<workspace>/
├── manifest.json                     # 平台提供（只读）
├── JIRA_Upload_List_*.xlsx           # 第一阶段清单（含归因列）
├── attribution_input.json            # 第一阶段归因产物（stage=generate）
├── attribution.json                  # 第二阶段归因产物（stage=create，平台读取）
└── result/
    ├── {vendor}_jira_batch_create_result_*.json
    └── {vendor}_jira_batch_create_summary_*.xlsx
```

`attribution.json` 结构：

```json
{
  "schema": "stp.jira_attribution/v1",
  "contract_version": "b8-g8-attribution-v1",
  "tool": "transsion",
  "stage": "create",
  "run": {"run_id": "...", "plan_run_id": 1096, "delivery_version_no": 2},
  "items": [{"row": 1, "workbook_row": 2, "signature_id": 7,
             "occurrence_ids": [101, 102], "attribution_status": "OK",
             "status": "SUCCESS", "issue_key": "X6851OS16-1234"}],
  "links": [{"issue_key": "X6851OS16-1234", "signature_id": 7,
             "occurrence_id": 101, "occurrence_key": "k101",
             "evidence_source": "vendor_attribution_json"}],
  "gaps": []
}
```

平台侧 `record_jira_run_completion` 读取 `links`，并用 `manifest.attribution_candidates`
复核每个 `(signature_id, occurrence_id)`；越界或缺失写入 `JiraRun.attribution_gaps`。
结果 JSON 亦带 `signature_id` / `occurrence_id` / `occurrence_ids`，供只读消费。

## 5. 样本

- [manifest.sample.json](./samples/manifest.sample.json)
- [attribution_input.sample.json](./samples/attribution_input.sample.json)
- [attribution.sample.json](./samples/attribution.sample.json)
- [jira_batch_create_result.sample.json](./samples/jira_batch_create_result.sample.json)

## 6. 验证

```bash
# Transsion
cd Transsion_Jira_Tool_20260323 && python -m pytest test/test_jira_attribution.py -q

# Tinno
cd Tinno_Jira_Tool_20260520 && python -m unittest discover -s test -p "test_jira_attribution.py"
```
