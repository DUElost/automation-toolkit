# Org Excel Dedup Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 为 `python-tools/stability_Start-Log-Scan` 新增一个显式触发的离线 `_org.xls` 去重入口，只处理已有 AEE org 文件，不影响现有扫描、合并和导出流程。

**Architecture:** 新增一个独立的 `DedupOrgExcel` 执行类，复用 `read_aee_rlt_excel()` 读取 org 数据，复用 `ScanBase._aee_to_data_list()` 执行现有过滤与去重规则。主入口 `start_log_scan.py` 仅增加一个很薄的 `-dedup_org` 参数分支，只有显式传参时才执行新逻辑，其余分支保持不变。

**Tech Stack:** Python 3.x, argparse, unittest, xlrd/xlwt, 现有 `ScanBase` / `Excel` 模块

---

## File Map

- Modify: `python-tools/stability_Start-Log-Scan/start_log_scan.py`
  - 增加 `-dedup_org` 参数、导入新执行类、在参数解析后增加离线分支
- Create: `python-tools/stability_Start-Log-Scan/modules/mode/DedupOrgExcel.py`
  - 实现单文件离线去重、输入校验、配置准备、结果导出
- Create: `python-tools/stability_Start-Log-Scan/tests/test_dedup_org_excel.py`
  - 覆盖输入校验、默认 `shanghai`、输出命名、去重行为
- Modify: `python-tools/stability_Start-Log-Scan/README.md`
  - 补充离线去重命令示例与输出命名说明

### Task 1: 建立离线去重测试

**Files:**
- Create: `python-tools/stability_Start-Log-Scan/tests/test_dedup_org_excel.py`
- Modify: `python-tools/stability_Start-Log-Scan/modules/mode/DedupOrgExcel.py`

- [ ] **Step 1: 写离线去重测试骨架**

```python
import os
import sys
import tempfile
import unittest
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[1]
if str(PROJECT_ROOT) not in sys.path:
    sys.path.insert(0, str(PROJECT_ROOT))

from modules.common.Excel import Excel
from modules.mode.DedupOrgExcel import DedupOrgExcel


class DedupOrgExcelTest(unittest.TestCase):
    def setUp(self):
        self.temp_dir = tempfile.TemporaryDirectory()
        self.work_dir = Path(self.temp_dir.name)

    def tearDown(self):
        self.temp_dir.cleanup()

    def _write_org_excel(self, file_name="Result_demo_org.xls"):
        org_path = self.work_dir / file_name
        rows = [
            [
                "C:/logs/a/__exp_main.txt",
                "V1",
                "2026-04-04 10:00:00",
                "Java (JE)",
                "NullPointerException",
                "com.demo",
                "com.demo",
                "detail-a",
                "same-caused-by",
                "",
                1,
                "MainActivity",
                "device-1",
            ],
            [
                "C:/logs/b/__exp_main.txt",
                "V1",
                "2026-04-04 10:01:00",
                "Java (JE)",
                "NullPointerException",
                "com.demo",
                "com.demo",
                "detail-b",
                "same-caused-by",
                "",
                1,
                "MainActivity",
                "device-2",
            ],
        ]
        excel = Excel(str(org_path))
        excel.insertResultAee(rows)
        return org_path
```

- [ ] **Step 2: 增加失败测试，覆盖默认 side 和输出命名**

```python
    def test_run_uses_default_shanghai_and_generates_timestamped_file(self):
        org_path = self._write_org_excel()
        runner = DedupOrgExcel(str(org_path))

        output_path = runner.run()

        self.assertTrue(output_path.endswith(".xls"))
        self.assertIn("_dedup_org_", os.path.basename(output_path))
        self.assertTrue(os.path.isfile(output_path))
        self.assertEqual("shanghai", runner._dedup_side)
        self.assertEqual("shanghai", runner._scan_type)
```

- [ ] **Step 3: 增加失败测试，覆盖重复聚合后的文件存在**

```python
    def test_run_deduplicates_duplicate_rows(self):
        org_path = self._write_org_excel()
        runner = DedupOrgExcel(str(org_path))

        output_path = runner.run()

        import xlrd

        workbook = xlrd.open_workbook(output_path)
        sheet = workbook.sheet_by_index(0)
        self.assertEqual(2, sheet.nrows)
        headers = sheet.row_values(0)
        self.assertIn("DeviceCount", headers)
        device_count_index = headers.index("DeviceCount")
        self.assertEqual(2.0, sheet.row_values(1)[device_count_index])
```

- [ ] **Step 4: 增加失败测试，覆盖非法输入**

```python
    def test_run_rejects_non_org_excel_name(self):
        invalid_path = self._write_org_excel(file_name="Result_demo.xls")
        runner = DedupOrgExcel(str(invalid_path))

        with self.assertRaises(ValueError):
            runner.run()
```

- [ ] **Step 5: 运行测试，确认当前失败**

Run:

```bash
cd F:\automation-toolkit\python-tools\stability_Start-Log-Scan
python -m unittest tests.test_dedup_org_excel -v
```

Expected:

```text
ERROR: No module named 'modules.mode.DedupOrgExcel'
```

- [ ] **Step 6: Commit**

```bash
git add python-tools/stability_Start-Log-Scan/tests/test_dedup_org_excel.py
git commit -m "test(stability): add org excel dedup coverage"
```

### Task 2: 实现独立离线去重执行类

**Files:**
- Create: `python-tools/stability_Start-Log-Scan/modules/mode/DedupOrgExcel.py`
- Modify: `python-tools/stability_Start-Log-Scan/tests/test_dedup_org_excel.py`

- [ ] **Step 1: 新建执行类骨架与常量映射**

```python
# -*- coding: utf-8 -*-
import datetime
import os
import socket

from modules.common.Excel import Excel, read_aee_rlt_excel
from modules.common.GlobalAttrs import SCAN_MODE_AEE
from modules.common.Logger import TEST_LOGGER
from modules.common.Path import PathManager
from modules.mode.BaseScan import ScanBase


class DedupOrgExcel(ScanBase):
    SIDE_TO_SCAN_CONFIG = {
        "shanghai": ("shanghai", "pkglist.txt"),
        "factory": ("factory", "pkglist_factory.txt"),
    }

    def __init__(self, org_excel_path, side="shanghai"):
        super(DedupOrgExcel, self).__init__(
            SCAN_MODE_AEE,
            "SH",
            -1,
            None,
            os.path.abspath(os.path.curdir),
            True,
            True,
        )
        self._org_excel_path = os.path.abspath(org_excel_path)
        self._dedup_side = (side or "shanghai").strip().lower()
```

- [ ] **Step 2: 实现最小化的抽象方法与输入校验**

```python
    def _get_scan_dir_failed(self, error_msg):
        raise RuntimeError(error_msg)

    def _init_scan_attrs(self):
        return

    def _scan(self):
        return

    def _validate_input(self):
        if not os.path.isfile(self._org_excel_path):
            raise ValueError(f"org 文件不存在：{self._org_excel_path}")
        file_name = os.path.basename(self._org_excel_path)
        if not file_name.lower().endswith(".xls"):
            raise ValueError(f"仅支持 .xls 文件：{self._org_excel_path}")
        if "_org" not in file_name.lower():
            raise ValueError(f"仅支持包含 _org 的文件名：{self._org_excel_path}")
        if self._dedup_side not in self.SIDE_TO_SCAN_CONFIG:
            raise ValueError(f"side 仅支持 shanghai / factory，当前值：{self._dedup_side}")
```

- [ ] **Step 3: 实现最小配置准备，避免触碰扫描链路**

```python
    def _prepare_context(self):
        self._hostname = socket.gethostname()
        self._platform_system = "windows"
        self._is_network_connected = False
        self._config_file = os.path.join(PathManager.config_folder, "config_aee_tne.json")
        self._load_configs()
        self._scan_type, self._pkglist_file = self.SIDE_TO_SCAN_CONFIG[self._dedup_side]
        self._pkglist = self._get_pkglist(
            self._scan_type, os.path.join(PathManager.config_folder, self._pkglist_file)
        )
        self._blacklist = self._get_blacklist(
            os.path.join(PathManager.config_folder, self._blacklist_file)
        )
        self._report_history_list = self._get_report_history(
            os.path.join(PathManager.config_folder, self._report_history_file)
        )
```

- [ ] **Step 4: 实现输出命名与执行主流程**

```python
    def _build_output_path(self):
        timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
        base_name = os.path.splitext(os.path.basename(self._org_excel_path))[0]
        output_name = f"{base_name}_dedup_org_{timestamp}.xls"
        return os.path.join(os.path.dirname(self._org_excel_path), output_name)

    def run(self):
        self._validate_input()
        self._prepare_context()
        aee_rlt_list = read_aee_rlt_excel(self._org_excel_path)
        _, aee_rlt_list_final, _ = self._aee_to_data_list(aee_rlt_list)
        output_path = self._build_output_path()
        excel = Excel(output_path)
        excel.insertResultAee(aee_rlt_list_final, deduplicated=True)
        TEST_LOGGER.info(f"离线 org 去重结果已生成：{output_path}")
        return output_path
```

- [ ] **Step 5: 运行测试，确认实现通过**

Run:

```bash
cd F:\automation-toolkit\python-tools\stability_Start-Log-Scan
python -m unittest tests.test_dedup_org_excel -v
```

Expected:

```text
Ran 3 tests in <N.NNN>s
OK
```

- [ ] **Step 6: Commit**

```bash
git add python-tools/stability_Start-Log-Scan/modules/mode/DedupOrgExcel.py python-tools/stability_Start-Log-Scan/tests/test_dedup_org_excel.py
git commit -m "feat(stability): add offline org excel dedup runner"
```

### Task 3: 接入命令行入口且保持旧路径零影响

**Files:**
- Modify: `python-tools/stability_Start-Log-Scan/start_log_scan.py`
- Modify: `python-tools/stability_Start-Log-Scan/modules/mode/DedupOrgExcel.py`

- [ ] **Step 1: 在主入口导入离线执行类并增加参数**

```python
from modules.mode.DedupOrgExcel import DedupOrgExcel

parser.add_argument(
    "-dedup_org",
    dest="dedup_org_excel",
    metavar="待去重的 org Excel 文件",
    type=str,
    default=None,
    help="对已有的 AEE _org.xls 执行离线去重",
)
```

- [ ] **Step 2: 在 merge 分支之前增加显式离线去重分支**

```python
        dedup_org_excel = args.dedup_org_excel
        merge_side = args.merge_side

        if dedup_org_excel:
            TEST_LOGGER.info(
                "进入离线 org 去重模式，输入文件：{}，side：{}".format(
                    dedup_org_excel, merge_side
                )
            )
            dedup_runner = DedupOrgExcel(dedup_org_excel, merge_side)
            output_path = dedup_runner.run()
            TEST_LOGGER.info("离线 org 去重输出文件：{}".format(output_path))
            sys.exit(0)
```

- [ ] **Step 3: 确认未传 `-dedup_org` 时原路径无行为变更**

Run:

```bash
cd F:\automation-toolkit\python-tools\stability_Start-Log-Scan
python start_log_scan.py -h
python start_log_scan.py -v
```

Expected:

```text
-h 输出包含 -dedup_org 说明，但原有参数仍然存在
-v 正常退出，无异常
```

- [ ] **Step 4: 运行命令行测试，验证离线入口**

Run:

```bash
cd F:\automation-toolkit\python-tools\stability_Start-Log-Scan
python start_log_scan.py -dedup_org "F:\path\Result_demo_org.xls"
```

Expected:

```text
日志输出包含“进入离线 org 去重模式”
日志输出包含“离线 org 去重输出文件”
同目录生成 *_dedup_org_YYYYMMDD_HHMMSS.xls
```

- [ ] **Step 5: Commit**

```bash
git add python-tools/stability_Start-Log-Scan/start_log_scan.py python-tools/stability_Start-Log-Scan/modules/mode/DedupOrgExcel.py
git commit -m "feat(stability): wire offline org excel dedup command"
```

### Task 4: 更新文档并完成回归验证

**Files:**
- Modify: `python-tools/stability_Start-Log-Scan/README.md`

- [ ] **Step 1: 补充 README 的离线去重说明**

```markdown
## 离线 org 去重

当工具已经生成 `*_org.xls` 后，可使用以下命令对该文件离线去重：

```bash
python start_log_scan.py -dedup_org "F:\path\Result_xxx_org.xls"
python start_log_scan.py -dedup_org "F:\path\Result_xxx_org.xls" -side factory
```

输出文件示例：

`Result_xxx_org_dedup_org_20260404_153000.xls`
```

- [ ] **Step 2: 运行最终验证**

Run:

```bash
cd F:\automation-toolkit\python-tools\stability_Start-Log-Scan
python -m unittest tests.test_dedup_org_excel -v
python start_log_scan.py -h
```

Expected:

```text
单元测试全部通过
帮助信息中包含离线去重参数说明
```

- [ ] **Step 3: 查看改动范围，确认没有误触旧功能**

Run:

```bash
cd F:\automation-toolkit
git diff -- python-tools/stability_Start-Log-Scan/start_log_scan.py python-tools/stability_Start-Log-Scan/modules/mode/DedupOrgExcel.py python-tools/stability_Start-Log-Scan/tests/test_dedup_org_excel.py python-tools/stability_Start-Log-Scan/README.md
```

Expected:

```text
仅出现新增离线去重参数、独立执行类、对应测试和 README 更新
```

- [ ] **Step 4: Commit**

```bash
git add python-tools/stability_Start-Log-Scan/README.md
git commit -m "docs(stability): document offline org excel dedup"
```

## Self-Review

- Spec coverage:
  - `-dedup_org` 入口：Task 3
  - 默认 `shanghai` / 可选 `factory`：Task 2、Task 3
  - 输出 `*_dedup_org_时间戳.xls`：Task 2
  - 只处理现有 `_org.xls`：Task 1、Task 2
  - 不影响其他功能：Task 3、Task 4
- Placeholder scan:
  - 已检查，无 `TODO` / `TBD` / “后续处理” 占位语句
- Type consistency:
  - 统一使用 `DedupOrgExcel.run()` 作为执行入口
  - 统一使用 `dedup_org_excel` 作为命令行参数变量名

