#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Transsion Jira 按模块批量修正经办人脚本
-------------------------------------

根据 Jira 问题单的 Components，
将指定项目库下、命中手动指定模块的问题经办人修正为手动指定的负责人。
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
from typing import Any, Dict, List, Optional, Tuple

from jira.exceptions import JIRAError

CURRENT_DIR = Path(__file__).resolve().parent
if str(CURRENT_DIR) not in sys.path:
    sys.path.insert(0, str(CURRENT_DIR))

from transsion_batch_jira_common import assign_issue_to_user, connect_to_jira, resolve_user_name
from transsion_upload_template_common import clean_cell_value, load_defaults

logger = logging.getLogger(__name__)

CONFIG_DIR = CURRENT_DIR / "config"
LOG_DIR = CURRENT_DIR / "log"
RESULT_DIR = CURRENT_DIR / "result"
DEFAULT_CONFIG_FILE = CONFIG_DIR / "transsion_jira_defaults.json"


def setup_logging() -> None:
    LOG_DIR.mkdir(parents=True, exist_ok=True)
    logging.basicConfig(
        level=logging.INFO,
        format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
        handlers=[
            logging.StreamHandler(),
            logging.FileHandler(LOG_DIR / "update_transsion_jira_assignee_by_component.log", encoding="utf-8"),
        ],
    )


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="根据模块批量修正 Transsion Jira 经办人")
    parser.add_argument("--project-key", required=True, help="目标 Jira 项目库 Key，例如 X6851OS16")
    parser.add_argument("--jira-username", dest="jira_username", default=os.getenv("JIRA_USERNAME"), help="Jira 用户名")
    parser.add_argument("--jira-password", dest="jira_password", default=os.getenv("JIRA_PASSWORD"), help="Jira 密码")
    parser.add_argument("--jira-server", dest="jira_server", default=None, help="Jira 服务地址")
    parser.add_argument("--config-file", dest="config_file", default=str(DEFAULT_CONFIG_FILE), help="默认配置路径")
    parser.add_argument("--set-module", dest="manual_module", required=True, help="手动指定模块名，仅处理包含该模块的问题")
    parser.add_argument("--set-assignee", dest="manual_assignee", required=True, help="手动指定该模块对应的经办人")
    parser.add_argument(
        "--jql",
        dest="jql",
        default=None,
        help="自定义 JQL；不传时默认使用 project=<项目库> AND statusCategory != Done",
    )
    parser.add_argument(
        "--max-results",
        dest="max_results",
        type=int,
        default=500,
        help="最多处理的问题数量，默认 500",
    )
    parser.add_argument(
        "--wait-between-issues",
        dest="wait_between_issues",
        type=float,
        default=None,
        help="每条问题处理完成后，下一条开始前的等待秒数；0 表示不等待",
    )
    parser.add_argument("--dry-run", action="store_true", help="仅输出将要修改的结果，不实际更新 Jira")
    return parser.parse_args()


def build_default_jql(project_key: str) -> str:
    return f'project = "{project_key}" AND statusCategory != Done ORDER BY created DESC'


def search_issues_by_jql(jira_client, jql: str, max_results: int) -> List[Any]:
    issues: List[Any] = []
    start_at = 0
    page_size = min(100, max_results)
    while len(issues) < max_results:
        batch = jira_client.search_issues(
            jql,
            startAt=start_at,
            maxResults=min(page_size, max_results - len(issues)),
            fields="summary,assignee,components,status",
        )
        if not batch:
            break
        issues.extend(list(batch))
        start_at += len(batch)
        if len(batch) < page_size:
            break
    return issues


def resolve_issue_component_names(issue: Any) -> List[str]:
    components = getattr(issue.fields, "components", []) or []
    names: List[str] = []
    for component in components:
        component_name = str(getattr(component, "name", "") or "").strip()
        if component_name:
            names.append(component_name)
    return names


def resolve_target_owner(component_names: List[str], manual_module: str, manual_assignee: str) -> Tuple[Optional[str], str]:
    if not component_names:
        return None, "问题单未填写 Components"
    manual_module_text = str(manual_module or "").strip()
    if manual_module_text not in component_names:
        return None, f"问题单模块未命中手动指定模块: {manual_module_text}"
    return str(manual_assignee or "").strip(), "OK"


def build_result_item(issue: Any, status: str, target_assignee: Optional[str], detail: str) -> Dict[str, Any]:
    current_assignee = str(getattr(getattr(issue.fields, "assignee", None), "name", "") or "").strip()
    return {
        "issue_key": issue.key,
        "summary": str(getattr(issue.fields, "summary", "") or ""),
        "status": status,
        "components": resolve_issue_component_names(issue),
        "current_assignee": current_assignee,
        "target_assignee": target_assignee,
        "detail": detail,
    }


def run_update(args: argparse.Namespace) -> int:
    defaults = load_defaults(args.config_file)
    jira_server = args.jira_server or defaults.get("jira_server")
    wait_between_issues = float(
        args.wait_between_issues
        if args.wait_between_issues is not None
        else defaults.get("default_wait_between_issues_seconds", 5)
    )

    if not args.jira_username or not args.jira_password:
        logger.error("需要提供 Jira 用户名和密码")
        return 1
    manual_module = str(clean_cell_value(args.manual_module) or "").strip()
    manual_assignee = str(clean_cell_value(args.manual_assignee) or "").strip()
    logger.info("手动指定模块: %s", manual_module)
    logger.info("手动指定经办人: %s", manual_assignee)

    jira = connect_to_jira(jira_server, args.jira_username, args.jira_password)
    logger.info("Jira 连接成功，当前用户: %s", jira.current_user())

    jql = args.jql or build_default_jql(args.project_key)
    issues = search_issues_by_jql(jira, jql, args.max_results)
    logger.info("JQL: %s", jql)
    logger.info("共读取到 %d 条问题", len(issues))

    user_cache: Dict[str, str] = {}
    results: List[Dict[str, Any]] = []

    for index, issue in enumerate(issues):
        try:
            component_names = resolve_issue_component_names(issue)
            target_owner_raw, owner_message = resolve_target_owner(component_names, manual_module, manual_assignee)
            if not target_owner_raw:
                logger.warning("第 %d 条跳过 %s: %s", index + 1, issue.key, owner_message)
                results.append(build_result_item(issue, "SKIPPED", None, owner_message))
                continue

            target_assignee = resolve_user_name(jira, target_owner_raw, user_cache, fallback=None)
            if not target_assignee:
                detail = f"负责人未能解析为 Jira 用户: {target_owner_raw}"
                logger.warning("第 %d 条跳过 %s: %s", index + 1, issue.key, detail)
                results.append(build_result_item(issue, "SKIPPED", None, detail))
                continue

            current_assignee = str(getattr(getattr(issue.fields, "assignee", None), "name", "") or "").strip()
            if current_assignee == target_assignee:
                detail = "当前经办人已正确，无需修改"
                logger.info("第 %d 条跳过 %s: %s", index + 1, issue.key, detail)
                results.append(build_result_item(issue, "UNCHANGED", target_assignee, detail))
                continue

            if args.dry_run:
                detail = f"将从 {current_assignee or '<空>'} 修改为 {target_assignee}"
                logger.info("第 %d 条 dry-run %s: %s", index + 1, issue.key, detail)
                results.append(build_result_item(issue, "DRY_RUN", target_assignee, detail))
                continue

            assigned, assign_message = assign_issue_to_user(jira, issue.key, target_assignee)
            if assigned:
                detail = f"{owner_message}; 已修改为 {assign_message}"
                logger.info("第 %d 条修改成功 %s: %s", index + 1, issue.key, detail)
                results.append(build_result_item(issue, "UPDATED", target_assignee, detail))
            else:
                detail = f"{owner_message}; 修改失败: {assign_message}"
                logger.warning("第 %d 条修改失败 %s: %s", index + 1, issue.key, detail)
                results.append(build_result_item(issue, "FAILED", target_assignee, detail))
        except JIRAError as exc:
            error_text = getattr(exc, "text", "") or str(exc)
            logger.error("第 %d 条处理失败 %s: %s", index + 1, issue.key, error_text)
            results.append(build_result_item(issue, "FAILED", None, error_text))
        except Exception as exc:
            logger.exception("第 %d 条处理异常 %s", index + 1, issue.key)
            results.append(build_result_item(issue, "FAILED", None, str(exc)))

        if not args.dry_run and wait_between_issues > 0 and index < len(issues) - 1:
            logger.info("第 %d 条处理完成，等待 %.1f 秒后继续下一条", index + 1, wait_between_issues)
            time.sleep(wait_between_issues)

    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    RESULT_DIR.mkdir(parents=True, exist_ok=True)
    result_path = RESULT_DIR / f"transsion_jira_assignee_update_result_{timestamp}.json"
    with open(result_path, "w", encoding="utf-8") as fp:
        json.dump(
            {
                "project_key": args.project_key,
                "jql": jql,
                "manual_module": manual_module,
                "manual_assignee": manual_assignee,
                "results": results,
            },
            fp,
            ensure_ascii=False,
            indent=2,
        )
    logger.info("结果已写入: %s", result_path)

    updated_count = sum(1 for item in results if item["status"] == "UPDATED")
    dry_run_count = sum(1 for item in results if item["status"] == "DRY_RUN")
    unchanged_count = sum(1 for item in results if item["status"] == "UNCHANGED")
    skipped_count = sum(1 for item in results if item["status"] == "SKIPPED")
    failed_count = sum(1 for item in results if item["status"] == "FAILED")
    logger.info(
        "处理完成，总计=%d 更新=%d dry-run=%d 未变化=%d 跳过=%d 失败=%d",
        len(results),
        updated_count,
        dry_run_count,
        unchanged_count,
        skipped_count,
        failed_count,
    )
    return 0 if failed_count == 0 else 1


def main() -> int:
    setup_logging()
    args = parse_args()
    return run_update(args)


if __name__ == "__main__":
    sys.exit(main())
