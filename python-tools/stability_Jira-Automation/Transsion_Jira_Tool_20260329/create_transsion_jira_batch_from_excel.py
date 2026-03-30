#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Transsion Jira 批量建单脚本
--------------------------

读取当前目录生成的上传模板 Excel，并在 jira.transsion.com 对应项目中批量创建问题。
"""

from __future__ import annotations

import argparse
import json
import logging
import os
import sys
import time
from datetime import datetime
from pathlib import Path
from typing import Any, Dict, List, Tuple

import pandas as pd
from jira.exceptions import JIRAError

CURRENT_DIR = Path(__file__).resolve().parent
if str(CURRENT_DIR) not in sys.path:
    sys.path.insert(0, str(CURRENT_DIR))

from transsion_upload_template_common import load_defaults, load_priority_mapping_from_rules_excel, read_excel_smart
from transsion_batch_jira_common import (
    EXCEL_FIELD_CANDIDATES,
    assign_issue_to_user,
    build_field_name_lookup,
    build_issue_fields,
    clean_cell_value,
    connect_to_jira,
    extract_allowed_values,
    find_first_value,
    get_create_meta_fields,
    resolve_bug_severity_attachment_name,
    resolve_project_key,
    resolve_user_name,
    transition_issue_to_open,
)

logger = logging.getLogger(__name__)

CONFIG_DIR = CURRENT_DIR / "config"
LOG_DIR = CURRENT_DIR / "log"
RESULT_DIR = CURRENT_DIR / "result"
DEFAULT_CONFIG_FILE = CONFIG_DIR / "transsion_jira_defaults.json"
DEFAULT_SEVERITY_RULES = CONFIG_DIR / "问题等级定级表.xls"
DEFAULT_BUG_SEVERITY_IMAGE_DIR = CONFIG_DIR / "bug_severity_priority_image"
DEFAULT_INPUT_FILE = CURRENT_DIR / "JIRA_Upload_List_Transsion_开关机专项_20260325_115150.xlsx"


def setup_logging() -> None:
    LOG_DIR.mkdir(parents=True, exist_ok=True)
    logging.basicConfig(
        level=logging.INFO,
        format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
        handlers=[
            logging.StreamHandler(),
            logging.FileHandler(LOG_DIR / "create_transsion_jira_batch_from_excel.log", encoding="utf-8"),
        ],
    )


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Transsion Jira 批量建单脚本")
    parser.add_argument("--add-excel-file", dest="excel_file", default=str(DEFAULT_INPUT_FILE), help="上传模板 Excel 路径")
    parser.add_argument("--jira-username", dest="jira_username", default=os.getenv("JIRA_USERNAME"), help="Jira 用户名")
    parser.add_argument("--jira-password", dest="jira_password", default=os.getenv("JIRA_PASSWORD"), help="Jira 密码")
    parser.add_argument("--jira-server", dest="jira_server", default=None, help="Jira 服务地址")
    parser.add_argument("--config-file", dest="config_file", default=str(DEFAULT_CONFIG_FILE), help="默认配置路径")
    parser.add_argument(
        "--severity-rules-file",
        dest="severity_rules_file",
        default=str(DEFAULT_SEVERITY_RULES),
        help="问题等级规则表路径，第二阶段会从同一份表读取等级到 Jira 优先级映射",
    )
    parser.add_argument(
        "--bug-severity-image-dir",
        dest="bug_severity_image_dir",
        default=str(DEFAULT_BUG_SEVERITY_IMAGE_DIR),
        help="问题严重定义附件图片目录",
    )
    parser.add_argument(
        "--wait-between-issues",
        dest="wait_between_issues",
        type=float,
        default=None,
        help="每条问题处理完成后，下一条开始前的强制等待秒数；0 表示不等待",
    )
    parser.add_argument("--dry-run", action="store_true", help="仅校验数据，不实际建单")
    parser.add_argument("--validate-metadata", action="store_true", help="打印项目元数据后退出")
    parser.add_argument("--add-comments", action="store_true", help="创建成功后把 PS 列追加为评论")
    return parser.parse_args()


def validate_upload_excel(df: pd.DataFrame) -> bool:
    required_fields = [
        "project",
        "issue_type",
        "summary",
        "description",
        "priority",
        "components",
        "versions",
        "assignee",
        "reporter",
        "risk",
        "issue_source",
        "issue_category",
        "issue_nature",
        "affect_project",
        "case_no",
    ]
    missing = []
    for field_name in required_fields:
        if not any(column in df.columns for column in EXCEL_FIELD_CANDIDATES[field_name]):
            missing.append(field_name)
    if missing:
        logger.error("上传模板缺少必要列: %s", missing)
        logger.error("当前列: %s", list(df.columns))
        return False
    return True


def get_meta_bundle(
    jira_client,
    project_key: str,
    issue_type_name: str,
    meta_cache: Dict[Tuple[str, str], Dict[str, Any]],
) -> Dict[str, Any]:
    cache_key = (project_key, issue_type_name)
    if cache_key in meta_cache:
        return meta_cache[cache_key]

    create_fields = get_create_meta_fields(jira_client, project_key, issue_type_name)
    if not create_fields:
        raise RuntimeError(f"无法读取项目 {project_key} / {issue_type_name} 的 create meta")

    bundle = {
        "create_fields": create_fields,
        "field_name_lookup": build_field_name_lookup(create_fields),
        "allowed_values": extract_allowed_values(create_fields),
    }
    meta_cache[cache_key] = bundle
    return bundle


def log_required_fields(project_key: str, issue_type_name: str, create_fields: Dict[str, Any]) -> None:
    logger.info("项目 %s / %s 的必填字段:", project_key, issue_type_name)
    for field_id, info in create_fields.items():
        if info.get("required"):
            logger.info("  - %s (%s)", info.get("name", field_id), field_id)


def run_batch_create(args: argparse.Namespace) -> int:
    defaults = load_defaults(args.config_file)
    priority_mapping_config = load_priority_mapping_from_rules_excel(args.severity_rules_file)
    jira_server = args.jira_server or defaults.get("jira_server")
    wait_between_issues = float(
        args.wait_between_issues
        if args.wait_between_issues is not None
        else defaults.get("default_wait_between_issues_seconds", 5)
    )
    if not args.jira_username or not args.jira_password:
        logger.error("需要提供 Jira 用户名和密码")
        return 1

    df = read_excel_smart(args.excel_file)
    logger.info("已读取上传模板 %d 条，列: %s", len(df), list(df.columns))
    if not validate_upload_excel(df):
        return 1

    jira = connect_to_jira(jira_server, args.jira_username, args.jira_password)
    current_user = str(jira.current_user() or "").strip()
    logger.info("Jira 连接成功，当前用户: %s", current_user)

    meta_cache: Dict[Tuple[str, str], Dict[str, Any]] = {}
    user_cache: Dict[str, str] = {}
    project_cache: Dict[str, str] = {}
    results: List[Dict[str, Any]] = []

    if args.validate_metadata:
        seen: set[Tuple[str, str]] = set()
        for _, row in df.iterrows():
            project_key = str(resolve_project_key(jira, find_first_value(row, "project", defaults.get("project_key")), project_cache))
            issue_type_name = str(find_first_value(row, "issue_type", defaults.get("issue_type", "故障")))
            cache_key = (project_key, issue_type_name)
            if cache_key in seen:
                continue
            seen.add(cache_key)
            bundle = get_meta_bundle(jira, project_key, issue_type_name, meta_cache)
            log_required_fields(project_key, issue_type_name, bundle["create_fields"])
            logger.info("字段名映射: %s", json.dumps(bundle["field_name_lookup"], ensure_ascii=False))
        return 0

    for index, row in df.iterrows():
        project_key = str(resolve_project_key(jira, find_first_value(row, "project", defaults.get("project_key")), project_cache))
        issue_type_name = str(find_first_value(row, "issue_type", defaults.get("issue_type", "故障")))
        summary = find_first_value(row, "summary", "未指定概要")

        try:
            bundle = get_meta_bundle(jira, project_key, issue_type_name, meta_cache)
            target_assignee_raw = find_first_value(row, "assignee", defaults.get("default_assignee"))
            target_assignee = resolve_user_name(
                jira,
                target_assignee_raw,
                user_cache,
                fallback=defaults.get("default_assignee"),
            )
            issue_fields = build_issue_fields(
                jira_client=jira,
                row=row,
                defaults=defaults,
                create_fields=bundle["create_fields"],
                allowed_values=bundle["allowed_values"],
                severity_to_priority_mapping=priority_mapping_config.get("severity_to_priority", {}),
                priority_alias_mapping=priority_mapping_config.get("priority_aliases", {}),
                user_cache=user_cache,
                project_cache=project_cache,
                create_assignee_override=current_user,
            )
            logger.info("第 %d 行准备处理: [%s] %s", index + 1, project_key, summary)

            if args.dry_run:
                results.append(
                    {
                        "row": index + 1,
                        "status": "DRY_RUN",
                        "project": project_key,
                        "summary": summary,
                        "issue_key": None,
                        "error": None,
                    }
                )
                continue

            new_issue = jira.create_issue(fields=issue_fields)
            issue_key = new_issue.key
            logger.info("第 %d 行创建成功: %s", index + 1, issue_key)

            if args.add_comments:
                ps_text = find_first_value(row, "ps")
                if clean_cell_value(ps_text):
                    jira.add_comment(issue_key, str(ps_text))
                    logger.info("第 %d 行已追加评论", index + 1)

            attachment_name = resolve_bug_severity_attachment_name(
                row,
                priority_mapping_config.get("severity_to_priority", {}),
                priority_mapping_config.get("priority_aliases", {}),
            )
            if attachment_name:
                attachment_path = Path(args.bug_severity_image_dir) / attachment_name
                if attachment_path.exists():
                    with open(attachment_path, "rb") as fp:
                        jira.add_attachment(issue=issue_key, attachment=fp, filename=attachment_path.name)
                    logger.info("第 %d 行已上传问题严重定义附件: %s", index + 1, attachment_path.name)
                else:
                    logger.warning("第 %d 行缺少问题严重定义附件: %s", index + 1, attachment_path)
            else:
                logger.warning("第 %d 行无法根据 Risk/Priority 解析严重定义附件", index + 1)

            transitioned, transition_message = transition_issue_to_open(jira, issue_key)
            if transitioned:
                logger.info("第 %d 行已执行状态流转: %s", index + 1, transition_message)
            else:
                logger.warning("第 %d 行状态流转跳过: %s", index + 1, transition_message)

            if target_assignee and current_user and target_assignee != current_user:
                assigned, assign_message = assign_issue_to_user(jira, issue_key, target_assignee)
                if assigned:
                    logger.info("第 %d 行已回写模块负责人: %s", index + 1, assign_message)
                else:
                    logger.warning("第 %d 行回写模块负责人失败: %s", index + 1, assign_message)

            results.append(
                {
                    "row": index + 1,
                    "status": "SUCCESS",
                    "project": project_key,
                    "summary": summary,
                    "issue_key": issue_key,
                    "error": None,
                }
            )
        except JIRAError as exc:
            error_text = getattr(exc, "text", "") or str(exc)
            logger.error("第 %d 行 Jira 创建失败: %s", index + 1, error_text)
            results.append(
                {
                    "row": index + 1,
                    "status": "FAILED",
                    "project": project_key,
                    "summary": summary,
                    "issue_key": None,
                    "error": error_text,
                }
            )
        except Exception as exc:
            logger.exception("第 %d 行处理失败", index + 1)
            results.append(
                {
                    "row": index + 1,
                    "status": "FAILED",
                    "project": project_key,
                    "summary": summary,
                    "issue_key": None,
                    "error": str(exc),
                }
            )

        if not args.dry_run and wait_between_issues > 0 and index < len(df) - 1:
            logger.info("第 %d 行处理完成，等待 %.1f 秒后继续下一条", index + 1, wait_between_issues)
            time.sleep(wait_between_issues)

    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    RESULT_DIR.mkdir(parents=True, exist_ok=True)
    result_path = RESULT_DIR / f"transsion_jira_batch_create_result_{timestamp}.json"
    with open(result_path, "w", encoding="utf-8") as fp:
        json.dump(results, fp, ensure_ascii=False, indent=2)
    logger.info("结果已写入: %s", result_path)

    success_count = sum(1 for item in results if item["status"] in {"SUCCESS", "DRY_RUN"})
    failed_count = sum(1 for item in results if item["status"] == "FAILED")
    logger.info("处理完成，总计=%d 成功/校验通过=%d 失败=%d", len(results), success_count, failed_count)
    return 0 if failed_count == 0 else 1


def main() -> int:
    setup_logging()
    args = parse_args()
    return run_batch_create(args)


if __name__ == "__main__":
    sys.exit(main())
