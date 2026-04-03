#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Transsion Jira 上传模板生成脚本
------------------------------

默认读取当前目录下的开关机专项原始结果和 config 目录内的映射表，生成 Transsion Jira 上传模板。
"""

from __future__ import annotations

import argparse
import logging
import os
import sys
from datetime import datetime
from pathlib import Path
from typing import List

import pandas as pd

CURRENT_DIR = Path(__file__).resolve().parent
if str(CURRENT_DIR) not in sys.path:
    sys.path.insert(0, str(CURRENT_DIR))

from transsion_upload_template_common import (
    clean_cell_value,
    load_component_regex_mapping,
    load_affect_project_mapping,
    load_defaults,
    load_package_owner_mapping,
    load_priority_mapping_from_rules_excel,
    load_probability_rating_mapping,
    load_severity_rules,
    split_affect_project_mapping,
    load_test_case_summary,
    prepare_issue_record,
    read_excel_smart,
    resolve_test_case_name,
)

logger = logging.getLogger(__name__)

CONFIG_DIR = CURRENT_DIR / "config"
BACKUP_DIR = CONFIG_DIR / "backup"
LOG_DIR = CURRENT_DIR / "log"
RESULT_DIR = CURRENT_DIR / "result"
DEFAULT_MAIN_EXCEL = CURRENT_DIR / "Result_None_None_MonkeyAEE_SH_20260323.xls"
DEFAULT_CONFIG_FILE = CONFIG_DIR / "transsion_jira_defaults.json"
DEFAULT_AFFECT_PROJECT_MAPPING = CONFIG_DIR / "affect_project_mapping.json"
DEFAULT_PACKAGE_MAPPING = CONFIG_DIR / "包名与模块&经办人对应表_transsion.xlsx"
DEFAULT_SEVERITY_RULES = CONFIG_DIR / "问题等级定级表.xls"
DEFAULT_PROBABILITY_RULES = CONFIG_DIR / "问题出现概率评级表.xlsx"
DEFAULT_TEST_CASE_SUMMARY = CONFIG_DIR / "稳定性专项汇总.xlsx"
DEFAULT_COMPONENT_REGEX = BACKUP_DIR / "包名与compent 对应_Transsion.txt"
DEFAULT_OUTPUT_PREFIX = "JIRA_Upload_List_Transsion"


def setup_logging() -> None:
    LOG_DIR.mkdir(parents=True, exist_ok=True)
    logging.basicConfig(
        level=logging.INFO,
        format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
        handlers=[
            logging.StreamHandler(),
            logging.FileHandler(LOG_DIR / "generate_transsion_jira_upload_list.log", encoding="utf-8"),
        ],
    )


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="生成 Transsion Jira 上传模板")
    parser.add_argument("--add-main-excel", dest="main_excel_path", default=str(DEFAULT_MAIN_EXCEL), help="原始结果 Excel 路径")
    parser.add_argument("--set-project-key", dest="project_key", default=None, help="目标 Jira 项目 Key")
    parser.add_argument("--set-test-case", dest="test_case", default="开关机专项", help="默认测试项名称或编号")
    parser.add_argument("--set-output", dest="output_path", default=None, help="输出 Excel 路径")
    parser.add_argument("--set-affect-project", dest="affect_project", default=None, help="默认 Affect Project")
    parser.add_argument("--set-environment", dest="environment", default="PR1-A1", help="默认 Environment")
    parser.add_argument("--set-case-no", dest="case_no", default="NA", help="默认用例编号")
    parser.add_argument("--set-reporter", dest="reporter", default=None, help="默认 Reporter")
    parser.add_argument("--set-assignee", dest="assignee", default=None, help="默认 Assignee")
    parser.add_argument("--summary-tags", nargs="*", default=["OP", "MR", "GKI"], help="概要中的附加标签")
    parser.add_argument("--config-file", dest="config_file", default=str(DEFAULT_CONFIG_FILE), help="默认配置路径")
    parser.add_argument(
        "--affect-project-mapping-file",
        dest="affect_project_mapping_file",
        default=str(DEFAULT_AFFECT_PROJECT_MAPPING),
        help="Affect Project 统一映射文件，包含 Jira 项目 Key 和 Affect Project 模板值",
    )
    parser.add_argument("--package-mapping-file", dest="package_mapping_file", default=str(DEFAULT_PACKAGE_MAPPING), help="包名与模块&经办人对应表路径")
    parser.add_argument("--severity-rules-file", dest="severity_rules_file", default=str(DEFAULT_SEVERITY_RULES), help="问题等级规则表路径")
    parser.add_argument("--probability-rules-file", dest="probability_rules_file", default=str(DEFAULT_PROBABILITY_RULES), help="问题出现概率评级表路径")
    parser.add_argument("--test-summary-file", dest="test_summary_file", default=str(DEFAULT_TEST_CASE_SUMMARY), help="稳定性专项汇总表路径")
    parser.add_argument("--component-regex-file", dest="component_regex_file", default=str(DEFAULT_COMPONENT_REGEX), help="正则模块映射文件路径")
    return parser.parse_args()


def build_upload_rows(args: argparse.Namespace) -> tuple[List[dict], List[str]]:
    defaults = load_defaults(args.config_file)
    if args.project_key:
        defaults["project_key"] = args.project_key

    affect_project_mapping = load_affect_project_mapping(args.affect_project_mapping_file)
    project_key_mapping, affect_project_value_mapping, monkey_project_mapping = split_affect_project_mapping(affect_project_mapping)
    priority_mapping_config = load_priority_mapping_from_rules_excel(args.severity_rules_file)
    affect_project_override = str(args.affect_project or "").strip()
    if defaults.get("project_key") and affect_project_override:
        project_key_mapping.setdefault(affect_project_override, defaults["project_key"])
        affect_project_value_mapping.setdefault(affect_project_override, affect_project_override)

    package_mapping = load_package_owner_mapping(args.package_mapping_file)
    regex_mapping = load_component_regex_mapping(args.component_regex_file)
    severity_rules = load_severity_rules(args.severity_rules_file)
    probability_rating_mapping = load_probability_rating_mapping(args.probability_rules_file)
    test_case_summary_mapping = load_test_case_summary(args.test_summary_file)
    main_df = read_excel_smart(args.main_excel_path)

    logger.info("读取原始结果成功，共 %d 条，列: %s", len(main_df), list(main_df.columns))

    rows: List[dict] = []
    resolved_test_cases: List[str] = []
    for index, row in main_df.iterrows():
        if not clean_cell_value(row.get("ExpClass")) and not clean_cell_value(row.get("Package")):
            logger.info("跳过第 %d 行：关键字段为空", index + 1)
            continue

        try:
            resolved_test_case = resolve_test_case_name(
                raw_test_case=row.get("TestCase"),
                default_test_case=args.test_case,
                test_case_summary_mapping=test_case_summary_mapping,
                source_label=f"第 {index + 1} 行 TestCase",
            )
            issue_row = prepare_issue_record(
                raw_row=row,
                test_case=resolved_test_case,
                defaults=defaults,
                project_key_mapping=project_key_mapping,
                affect_project_value_mapping=affect_project_value_mapping,
                monkey_project_mapping=monkey_project_mapping,
                severity_to_priority_mapping=priority_mapping_config.get("severity_to_priority", {}),
                severity_rules=severity_rules,
                probability_rating_mapping=probability_rating_mapping,
                test_case_summary_mapping=test_case_summary_mapping,
                package_owner_mapping=package_mapping,
                regex_mapping=regex_mapping,
                summary_tags=args.summary_tags,
                default_affect_project=args.affect_project,
                environment_override=args.environment,
                default_case_no=args.case_no,
                default_reporter=args.reporter,
                default_assignee=args.assignee,
            )
            rows.append(issue_row)
            resolved_test_cases.append(resolved_test_case)
        except Exception:
            logger.exception("第 %d 行生成上传模板失败", index + 1)
    return rows, resolved_test_cases


def save_upload_list(rows: List[dict], output_path: str) -> None:
    columns_order = [
        "Project",
        "Issue Type",
        "Summary",
        "Description",
        "Priority",
        "Severity Level",
        "Severity Rule",
        "Assignee",
        "Reporter",
        "Components",
        "Versions",
        "Environment",
        "Risk",
        "Test Total Count",
        "Issue Source",
        "Issue Category",
        "Issue Nature",
        "Affect Project",
        "Case No",
        "Clients",
        "Fix Way",
        "Focus",
        "Importance",
        "Security Level",
        "Opener",
        "PS",
        "Exp Class",
        "CausedBy",
        "Package",
        "Count",
        "Device Count",
    ]
    df = pd.DataFrame(rows)
    for column in columns_order:
        if column not in df.columns:
            df[column] = ""
    df = df[columns_order]
    df.to_excel(output_path, index=False, engine="openpyxl")


def main() -> int:
    setup_logging()
    args = parse_args()

    logger.info("开始生成 Transsion Jira 上传模板")
    logger.info("原始结果: %s", os.path.abspath(args.main_excel_path))
    logger.info("Affect Project 统一映射表: %s", os.path.abspath(args.affect_project_mapping_file))
    logger.info("包名映射表: %s", os.path.abspath(args.package_mapping_file))
    logger.info("等级规则表: %s", os.path.abspath(args.severity_rules_file))
    logger.info("问题出现概率评级表: %s", os.path.abspath(args.probability_rules_file))
    logger.info("稳定性专项汇总表: %s", os.path.abspath(args.test_summary_file))

    rows, resolved_test_cases = build_upload_rows(args)
    if not rows:
        logger.error("没有生成任何上传记录")
        return 1

    output_path = args.output_path
    if not output_path:
        RESULT_DIR.mkdir(parents=True, exist_ok=True)
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        unique_test_cases = sorted({test_case for test_case in resolved_test_cases if test_case})
        output_case_name = unique_test_cases[0] if len(unique_test_cases) == 1 else "多专项"
        output_path = str(RESULT_DIR / f"{DEFAULT_OUTPUT_PREFIX}_{output_case_name}_{timestamp}.xlsx")

    save_upload_list(rows, output_path)
    logger.info("上传模板已生成: %s", os.path.abspath(output_path))
    logger.info("成功处理 %d 条记录", len(rows))
    return 0


if __name__ == "__main__":
    sys.exit(main())
