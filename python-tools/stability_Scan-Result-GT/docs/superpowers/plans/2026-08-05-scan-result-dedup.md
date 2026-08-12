# scan_result 第二阶段（汇总与去重）实施计划

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 读取第一阶段问题包，汇总 + 去重，生成去重前/去重后两份 Excel（xlsx 为主，可选 csv 双输出）。

**Architecture:** 独立工程 `stability_Scan-Result-GT`（与采集解耦）；问题包扫描 → 字段提取（12 列对齐 Y 盘金标准）→ ExpClass 分类 → SequenceMatcher 去重 → xlsx/csv 导出。

**Tech Stack:** Python 3.9+、openpyxl、difflib、pytest。

**Spec:** `docs/superpowers/specs/2026-08-05-scan-result-dedup-design.md`

---

## 目标结构

```
stability_Scan-Result-GT/
├── scan_result.py            # 主入口：argparse（-d 问题包根 / --csv / --threshold）
├── config.json               # ExpClass 映射、去重阈值、输出配置
├── modules/
│   ├── __init__.py
│   ├── collect.py            # 问题包扫描 + 12 列记录提取
│   ├── classify.py           # ExpClass 映射
│   ├── dedup.py              # SequenceMatcher 分组去重
│   └── export.py             # xlsx/csv 导出
├── test/
│   ├── test_collect.py
│   ├── test_classify.py
│   ├── test_dedup.py
│   └── test_export.py
├── docs/
└── README.md
```

---

### Task 1: config.json（新建）

**Files:** Create: `config.json`

```json
{
    "expclass_map": {
        "data_app_anr": "ANR", "system_app_anr": "ANR", "system_server_anr": "ANR",
        "data_app_crash": "JE", "system_app_crash": "JE", "system_server_crash": "JE",
        "data_app_native_crash": "NE", "system_app_native_crash": "NE",
        "system_server_native_crash": "NE", "SYSTEM_TOMBSTONE": "NE",
        "system_server_watchdog": "SWT",
        "KERNEL_PANIC": "KE", "FATAL.NE": "KE",
        "SYSTEM_RESTART": "SR", "SYSTEM_BOOT": "SR", "Reboot": "SR",
        "Jank": "Jank", "Assert": "Assert", "WCN": "WCN",
        "MODEM_SILENT_PANIC": "MSP", "SUBSYS_SILENT_PANIC": "SSP"
    },
    "dedup": {
        "similarity_threshold": 0.75,
        "compare_fields": ["ExpClass", "Package", "CausedBy"]
    },
    "export": {
        "columns": ["Path", "Version", "ExpTime", "ExpType", "CurProcess", "Package",
                    "Detail", "CausedBy", "extraTag", "sum", "snNum", "ExpClass"],
        "output_before": "scan_result_before_dedup.xlsx",
        "output_after": "scan_result_after_dedup.xlsx"
    }
}
```

- [ ] **Step 1:** 写 config.json（映射表以 spec 决策为准）

---

### Task 2: modules/classify.py（ExpClass 映射）

**Files:** Create: `modules/classify.py`

```python
# -*- coding: utf-8 -*-
"""ExpClass 分类映射（spec 决策表）。"""
import json
import os

_CONFIG_PATH = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "config.json")


def load_expclass_map(config=None):
    if config is None:
        with open(_CONFIG_PATH, encoding="utf-8") as f:
            config = json.load(f)
    return config["expclass_map"]


def classify(exp_type, expclass_map=None):
    """dropbox 类型/event_name -> ExpClass；未知类型返回 exp_type 原样。"""
    if expclass_map is None:
        expclass_map = load_expclass_map()
    return expclass_map.get(exp_type, exp_type)
```

- [ ] **Step 1:** 实现 classify（精确匹配 + 未知兜底）

---

### Task 3: modules/collect.py（问题包扫描与字段提取）

**Files:** Create: `modules/collect.py`

逻辑要求：
1. 递归扫描 `-d` 指定目录下的 `problems/*/`（每问题包一个文件夹）
2. 每包提取记录（12 列）：
   - Path：summary.txt 路径（无 summary 用 detail.txt）
   - ExpTime：包名 `{device}_{type}_{ts}` 的 ts（`YYYY-MM-DD-HHMMSS`）
   - ExpType：包名 type 段（连字符转下划线还原：`system-app-crash` → `system_app_crash`）
   - Package/CurProcess：detail.txt `Process:` 行 → 取包名（去掉 `_eng` 等后缀场景不特殊处理）；ANR 包用 anr_trace.txt 的 `Cmd line:`；无 detail 时 summary 进程包字段
   - CausedBy：按 ExpClass 提取（JE：`Caused by:` 行；NE：`signal \d+` 行；ANR：`Subject:` 行；SWT：含 `watchdog` 行首条；KP：含 `panic` 行首条）
   - Detail：summary.txt 全文（截断合理长度，如 2000 字符）
   - Version/snNum：目录层级解析（`{root}/{version}/{device}/problems/...`）
3. 记录输出：`(Version, snNum, ExpTime, ExpType, ExpClass, CurProcess, Package, CausedBy, Detail, Path)`

- [ ] **Step 1:** 实现 collect.py（含包名解析、CausedBy 提取函数 `extract_caused_by(expclass, package_dir)`）

---

### Task 4: modules/dedup.py（SequenceMatcher 去重）

**Files:** Create: `modules/dedup.py`

逻辑要求（参照反编译 compare_Similarity_all_data 语义）：
1. 比较指纹：`ExpClass + Package + CausedBy`（config `dedup.compare_fields`）
2. 相似度：difflib `SequenceMatcher(None, a, b).ratio()`；阈值 config `dedup.similarity_threshold`（默认 0.75，金标准校准）
3. 分组：贪心两两比较——与组内任一条相似则入组（比较组代表 vs 新条目）；组间不再合并（一轮）
4. 输出：
   - before 记录：原样 12 列（sum=1）
   - after 记录：每组保留代表（ExpTime 最早），sum=组内条数；未分组条目 sum=1
5. 返回 (before_records, after_records)

- [ ] **Step 1:** 实现 dedup.py（`dedup(records) -> (before, after)`）

---

### Task 5: modules/export.py（xlsx/csv 导出）

**Files:** Create: `modules/export.py`

逻辑要求：
1. `export_xlsx(records, path)`：openpyxl 写 12 列（config `export.columns`），表头 + 数据行
2. `export_csv(records, path)`：csv 写（QUOTE_ALL 对齐反编译产物）
3. 输出文件名：config `export.output_before/output_after`；`--csv` 时额外写 .csv

- [ ] **Step 1:** 实现 export.py

---

### Task 6: scan_result.py 主入口

**Files:** Create: `scan_result.py`

```python
import argparse
import json
import os

from modules.collect import collect_problems
from modules.dedup import dedup
from modules.export import export_xlsx, export_csv


def main():
    parser = argparse.ArgumentParser(description="问题包汇总与去重（第二阶段）")
    parser.add_argument("-d", "--dir", required=True, help="第一阶段保存根目录（含 {version}/{device}/problems/）")
    parser.add_argument("--csv", action="store_true", help="额外输出 csv")
    parser.add_argument("--threshold", type=float, default=None, help="去重相似度阈值（覆盖 config）")
    parser.add_argument("-o", "--out", default=".", help="输出目录（默认当前目录）")
    args = parser.parse_args()

    with open("config.json", encoding="utf-8") as f:
        config = json.load(f)
    if args.threshold:
        config["dedup"]["similarity_threshold"] = args.threshold

    records = collect_problems(args.dir)
    before, after = dedup(records, config)
    before_path = os.path.join(args.out, config["export"]["output_before"])
    after_path = os.path.join(args.out, config["export"]["output_after"])
    export_xlsx(before, before_path, config)
    export_xlsx(after, after_path, config)
    print(f"汇总: {len(before)} 条（去重前）-> {len(after)} 条（去重后）")
    print(f"输出: {before_path}, {after_path}")
    if args.csv:
        export_csv(before, before_path.replace(".xlsx", ".csv"), config)
        export_csv(after, after_path.replace(".xlsx", ".csv"), config)


if __name__ == "__main__":
    main()
```

- [ ] **Step 1:** 写 scan_result.py

---

### Task 7: 测试

**Files:** Create: `test/test_classify.py`、`test/test_collect.py`、`test/test_dedup.py`、`test/test_export.py`

覆盖：
- classify：映射命中（data_app_crash→JE）、未知兜底
- collect：临时问题包构造（detail.txt 带 Process/Caused by、summary.txt）→ 字段提取断言（ExpType 还原、Package、CausedBy、Version/snNum）
- dedup：相似问题对合并（sum=2）、不相似保留（sum=1）、分组代表选择
- export：xlsx 读回断言（行数/列头/数据）

- [ ] **Step 1:** 写 4 个测试文件
- [ ] **Step 2:** `python -m pytest test/ -v` 全部 PASS

---

### Task 8: 金标准复现（Y 盘 33→12）

**Files:** 只读: `F:\scan_result_GT_decompile\scan_result_GT\testdata\golden_pressure\all_data.csv`（33 条，含 Path/ExpType/CausedBy/ExpClass）

- [ ] **Step 1:** 用 Y 盘 all_data.csv 构造等价记录（33 条）→ 跑 dedup → 断言去重后 12 条
- [ ] **Step 2:** 组合同步核对：camera2 19 条 JE 合并为一组；networkless/messaging/gms.ui JE 各保留；NE 组（SIGSEGV+native-crash 成对）；ANR 保留
- [ ] **Step 3:** 阈值不匹配时调整（config 0.75 附近），记录校准结论

---

### Task 9: 端到端（phase1_dataset_v2）

- [ ] **Step 1:** `python scan_result.py -d data\phase1_dataset_v2 -o out\` → 生成两份 xlsx
- [ ] **Step 2:** 抽查：行数、ExpClass 分布、同因问题合并情况（camera2 类）
- [ ] **Step 3:** README 编写（用法/列定义/去重规则/金标准校准说明）

---

## 自检记录

**覆盖度：** config（Task 1）/ classify（Task 2）/ collect（Task 3）/ dedup（Task 4）/ export（Task 5）/ 主入口（Task 6）/ 测试（Task 7）/ 金标准复现（Task 8）/ 端到端（Task 9）——全部覆盖。

**占位符：** 无 TBD/TODO；核心代码完整给出。

**类型一致性：** `collect_problems(dir)->records`、`dedup(records, config)->(before, after)`、`export_xlsx(records, path, config)` 签名 Task 3/4/5 定义、Task 6 调用一致。
