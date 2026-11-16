#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Tinno Jira 上传模板生成脚本
--------------------------

基于 `Transsion_Jira_Tool_20260323` 的目录结构迁移而来，
当前已接入 Tinno 第一阶段上传模板生成逻辑，支持专项识别与多专项输出。
"""

from __future__ import annotations

import argparse
import logging
import os
import sys
from datetime import datetime
from pathlib import Path
from typing import Any, Dict

CURRENT_DIR = Path(__file__).resolve().parent
if str(CURRENT_DIR) not in sys.path:
    sys.path.insert(0, str(CURRENT_DIR))

import jira_attribution
from tinno_upload_template_common import (
    build_upload_rows,
    load_affect_project_mapping,
    load_defaults,
    load_module_assignee_mapping,
    load_package_owner_mapping,
    format_skipped_severity_rows,
    load_severity_rules,
    load_test_case_summary,
    read_excel_smart,
    save_upload_list,
)

logger = logging.getLogger(__name__)

CONFIG_DIR = CURRENT_DIR / "config"
LOG_DIR = CURRENT_DIR / "log"
RESULT_DIR = CURRENT_DIR / "result"
DEFAULT_CONFIG_FILE = CONFIG_DIR / "tinno_jira_defaults.json"
DEFAULT_PACKAGE_MAPPING = CONFIG_DIR / "包名与模块&经办人对应表_tinno.xls"
DEFAULT_SEVERITY_RULES = CONFIG_DIR / "问题等级定级表.xls"
DEFAULT_AFFECT_PROJECT_MAPPING = CONFIG_DIR / "affect_project_mapping.json"
DEFAULT_MODULE_ASSIGNEE_MAPPING = CONFIG_DIR / "module_assignee_mapping.json"
DEFAULT_TEST_CASE_SUMMARY = CONFIG_DIR / "稳定性专项汇总.xlsx"
DEFAULT_LOCAL_ENV_FILE = CURRENT_DIR / ".env.local"
DEFAULT_OUTPUT_PREFIX = "JIRA_Upload_List_Tinno"
DEFAULT_TEST_MODE_MAIN_EXCEL = CURRENT_DIR / "resource" / "Result_None_None_MonkeyAEE_SH_20260521.xls"
DEFAULT_TEST_MODE_PROJECT_KEY = "VCAME"
DEFAULT_TEST_MODE_MODULE = "AUTOTEST"


def load_local_env(env_file: str | Path = DEFAULT_LOCAL_ENV_FILE, override: bool = False) -> None:
    path = Path(env_file)
    if not path.exists():
        return

    for raw_line in path.read_text(encoding="utf-8").splitlines():
        line = raw_line.strip()
        if not line or line.startswith("#"):
            continue
        if line.startswith("export "):
            line = line[7:].strip()
        key, separator, value = line.partition("=")
        if not separator:
            continue
        env_key = key.strip()
        env_value = value.strip()
        if len(env_value) >= 2 and env_value[0] == env_value[-1] and env_value[0] in {"'", '"'}:
            env_value = env_value[1:-1]
        if override or not os.getenv(env_key):
            os.environ[env_key] = env_value


def setup_logging() -> None:
    LOG_DIR.mkdir(parents=True, exist_ok=True)
    logging.basicConfig(
        level=logging.INFO,
        format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
        handlers=[
            logging.StreamHandler(),
            logging.FileHandler(LOG_DIR / "generate_tinno_jira_upload_list.log", encoding="utf-8"),
        ],
    )


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="生成 Tinno Jira 上传模板")
    parser.add_argument("--add-main-excel", dest="main_excel_path", default=None, help="原始结果 Excel 路径")
    parser.add_argument("--set-output", dest="output_path", default=None, help="输出 Excel 路径")
    parser.add_argument("--config-file", dest="config_file", default=str(DEFAULT_CONFIG_FILE), help="默认配置路径")
    parser.add_argument("--package-mapping-file", dest="package_mapping_file", default=str(DEFAULT_PACKAGE_MAPPING), help="包名与模块&经办人映射")
    parser.add_argument("--severity-rules-file", dest="severity_rules_file", default=str(DEFAULT_SEVERITY_RULES), help="问题等级规则表")
    parser.add_argument("--affect-project-mapping-file", dest="affect_project_mapping_file", default=str(DEFAULT_AFFECT_PROJECT_MAPPING), help="Affect Project 映射表")
    parser.add_argument("--summary-product-mapping-file", dest="summary_product_mapping_file", default=None, help="版本前缀到标题产品名的映射；省略时使用 config/summary_product_mapping.json")
    parser.add_argument("--module-assignee-mapping-file", dest="module_assignee_mapping_file", default=None, help="项目模块经办人映射；省略时使用 config/module_assignee_mapping.json")
    parser.add_argument("--test-summary-file", dest="test_summary_file", default=str(DEFAULT_TEST_CASE_SUMMARY), help="稳定性专项汇总表")
    parser.add_argument("--set-project-key", dest="project_key", default=None, help="覆盖目标 Jira 项目 Key")
    parser.add_argument("--set-test-case", dest="test_case", default=None, help="覆盖默认测试专项名称或编号")
    parser.add_argument("--set-reporter", dest="reporter", default=None, help="覆盖 Reporter")
    parser.add_argument("--set-assignee", dest="assignee", default=None, help="覆盖 Assignee")
    parser.add_argument("--test-mode", action="store_true", help="VCAME 测试模式：默认使用测试原始 Excel、AUTOTEST 与当前用户")
    parser.add_argument("--output-dir", dest="output_dir", default=None, help="平台隔离工作区；清单、归因产物写入该目录")
    parser.add_argument("--attribution-manifest", dest="attribution_manifest", default=None, help="平台 manifest.json；省略时在工作区/cwd 自动发现")
    return parser.parse_args()


def resolve_test_mode_user(defaults: Dict[str, Any]) -> str:
    for candidate in (
        os.getenv("JIRA_USERNAME"),
        os.getenv("JIRA_REPORTER"),
        defaults.get("default_reporter"),
        defaults.get("default_assignee"),
    ):
        user_name = str(candidate or "").strip()
        if user_name:
            return user_name
    return "dai.lv"


def apply_test_mode_defaults(args: argparse.Namespace, defaults: Dict[str, Any]) -> None:
    if not bool(getattr(args, "test_mode", False)):
        return
    if not args.main_excel_path:
        args.main_excel_path = str(DEFAULT_TEST_MODE_MAIN_EXCEL)
    if not args.project_key:
        args.project_key = DEFAULT_TEST_MODE_PROJECT_KEY
    if not args.test_case:
        args.test_case = str(defaults.get("default_test_case") or "Monkey专项")
    current_user = resolve_test_mode_user(defaults)
    if not args.reporter:
        args.reporter = current_user
    if not args.assignee:
        args.assignee = current_user


def main() -> int:
    setup_logging()
    load_local_env()
    args = parse_args()

    defaults = load_defaults(args.config_file)
    apply_test_mode_defaults(args, defaults)
    if not args.main_excel_path:
        logger.error("需要提供 --add-main-excel，或使用 --test-mode")
        return 1
    if args.project_key:
        defaults["project_key"] = args.project_key

    main_df = read_excel_smart(args.main_excel_path)
    package_mapping = load_package_owner_mapping(args.package_mapping_file)
    severity_rules = load_severity_rules(args.severity_rules_file)
    affect_project_mapping = load_affect_project_mapping(args.affect_project_mapping_file)
    summary_product_mapping_file = getattr(args, "summary_product_mapping_file", None)
    if summary_product_mapping_file:
        import jira_issue_template

        jira_issue_template.SUMMARY_PRODUCT_MAPPING = jira_issue_template.load_summary_product_mapping(
            summary_product_mapping_file
        )
    module_assignee_mapping = load_module_assignee_mapping(
        getattr(args, "module_assignee_mapping_file", None) or DEFAULT_MODULE_ASSIGNEE_MAPPING
    )
    test_case_summary_mapping = load_test_case_summary(args.test_summary_file)
    search_dirs = []
    if getattr(args, "main_excel_path", None):
        search_dirs.append(Path(args.main_excel_path).resolve().parent)
    if getattr(args, "output_path", None):
        search_dirs.append(Path(args.output_path).resolve().parent)
    if getattr(args, "output_dir", None):
        search_dirs.append(Path(args.output_dir))
    manifest_path = jira_attribution.discover_manifest(
        getattr(args, "attribution_manifest", None), *search_dirs
    )
    index = None
    if manifest_path is not None:
        try:
            index = jira_attribution.load_manifest(manifest_path)
        except jira_attribution.AttributionError as exc:
            logger.error("归因 manifest 不可用，停止生成: %s", exc)
            return 1
        logger.info("归因契约: %s", jira_attribution.CONTRACT_VERSION)
        logger.info("归因 manifest: %s", manifest_path)
        logger.info("本次登记范围: plan_run_id=%s delivery_version_no=%s issue_ids=%s",
                    index.run_meta().get("plan_run_id"),
                    index.run_meta().get("delivery_version_no"),
                    index.run_meta().get("issue_ids"))
    skipped_rows: list = []
    rows = build_upload_rows(
        main_df=main_df,
        defaults=defaults,
        package_mapping=package_mapping,
        severity_rules=severity_rules,
        affect_project_mapping=affect_project_mapping,
        module_assignee_mapping=module_assignee_mapping,
        test_case_summary_mapping=test_case_summary_mapping,
        reporter_override=args.reporter,
        assignee_override=args.assignee,
        project_override=args.project_key,
        module_override=DEFAULT_TEST_MODE_MODULE if bool(getattr(args, "test_mode", False)) else None,
        default_test_case=args.test_case,
        source_excel_path=args.main_excel_path,
        skipped_rows=skipped_rows,
        attribution_enabled=index is not None,
    )
    if not rows and not skipped_rows:
        logger.error("没有生成任何上传记录")
        return 1
    items: list = []
    gaps: list = []
    if index is not None:
        rows, items, gaps = jira_attribution.annotate_rows(rows, index)
        for item in items:
            logger.info(
                "归因: Excel 行 %s signature_id=%s occurrence_ids=%s status=%s",
                item.get("workbook_row"),
                item.get("signature_id"),
                item.get("occurrence_ids"),
                item.get("attribution_status"),
            )
        for gap in gaps:
            logger.warning(
                "归因缺口: kind=%s Excel 行 %s signature_id=%s reason=%s",
                gap.get("kind"),
                gap.get("workbook_row"),
                gap.get("signature_id"),
                gap.get("reason"),
            )
    if not rows:
        logger.info("没有可写入上传模板的记录")
        for line in format_skipped_severity_rows(skipped_rows):
            logger.info("%s", line)
        return 0

    workspace = None
    if getattr(args, "output_dir", None):
        workspace = Path(args.output_dir)
    elif manifest_path is not None:
        workspace = manifest_path.parent
    result_dir = workspace if workspace is not None else RESULT_DIR

    output_path = args.output_path
    resolved_test_cases = sorted(
        {
            str(row.get("Test Case") or "").strip()
            for row in rows
            if str(row.get("Test Case") or "").strip()
        }
    )
    if not output_path:
        result_dir.mkdir(parents=True, exist_ok=True)
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        output_case_name = resolved_test_cases[0] if len(resolved_test_cases) == 1 else "多专项"
        output_path = str(result_dir / f"{DEFAULT_OUTPUT_PREFIX}_{output_case_name}_{timestamp}.xlsx")

    saved = save_upload_list(rows, output_path)
    logger.info("原始结果: %s", os.path.abspath(args.main_excel_path))
    if resolved_test_cases:
        logger.info("识别到测试专项: %s", ", ".join(resolved_test_cases))
    logger.info("上传模板已生成: %s", saved)
    logger.info("成功处理 %d 条记录", len(rows))
    for line in format_skipped_severity_rows(skipped_rows):
        logger.info("%s", line)
    if index is not None and workspace is not None:
        payload = jira_attribution.build_payload(
            stage="generate",
            index=index,
            items=items,
            links=[],
            gaps=gaps,
            run_id=datetime.now().strftime("%Y%m%d_%H%M%S"),
            workspace=workspace,
        )
        artifact_path = jira_attribution.write_payload(
            workspace / "attribution_input.json", payload
        )
        logger.info("归因产物已写入: %s", artifact_path)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
