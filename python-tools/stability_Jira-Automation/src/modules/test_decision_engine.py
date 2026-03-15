#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""调试脚本：查看待处理问题的 test_environment/caused_by/normalized_summary。"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path
from typing import List, Dict

# 保证可以以独立脚本方式运行
MODULE_ROOT = Path(__file__).resolve().parent
if str(MODULE_ROOT) not in sys.path:
    sys.path.insert(0, str(MODULE_ROOT))
REPO_ROOT = MODULE_ROOT.parent
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from modules.config_loader import ConfigLoader  # type: ignore
from modules.excel_parser import ExcelParser  # type: ignore
from modules.data_normalizer import DataNormalizer  # type: ignore
from modules.lark_integration import LarkIntegration  # type: ignore
from main import apply_filters, prepare_pending_issues  # type: ignore


def collect_pending_issues(excel_path: str, config_path: str) -> List[Dict[str, object]]:
    config_loader = ConfigLoader(config_path)
    excel_parser = ExcelParser()
    normalizer = DataNormalizer()
    lark = LarkIntegration(config_loader.get_lark_config())

    raw_rows = excel_parser.parse_excel(excel_path)
    normalized_rows = normalizer.batch_normalize(raw_rows)
    filtered_rows = apply_filters(lark, normalized_rows)
    return prepare_pending_issues(lark, filtered_rows)


def main() -> None:
    parser = argparse.ArgumentParser(description="调试 DecisionEngine 输入字段")
    parser.add_argument("--excel", required=True, help="Excel 原始文件路径")
    parser.add_argument("--config", default=".env", help="配置文件路径 (默认 .env)")
    args = parser.parse_args()

    pending = collect_pending_issues(args.excel, args.config)
    if not pending:
        print("未获取到待处理问题")
        return

    print("共收集到 %d 条待处理记录:" % len(pending))
    for issue in pending:
        print("- row=%s pkg=%s module=%s" % (issue.get("row_number"), issue.get("package_name"), issue.get("module")))
        print("  test_environment: %s" % issue.get("test_environment"))
        print("  caused_by      : %s" % issue.get("caused_by"))
        print("  normalized_sum : %s" % issue.get("normalized_summary"))
        print("  jira_summary   : %s" % issue.get("jira_summary"))
        print("  jira_description 开头: %s" % str(issue.get("jira_description", ""))[:80])


if __name__ == "__main__":
    main()
