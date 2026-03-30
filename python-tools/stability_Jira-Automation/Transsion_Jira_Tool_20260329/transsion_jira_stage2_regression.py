#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Transsion Jira 第二阶段回归增强入口
---------------------------------

按设计文档实现：导出历史单 -> 强命中比对 -> 决策分流 -> 执行动作 -> 记录结果。
"""

from __future__ import annotations

import argparse
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
    assign_issue_to_user,
    build_field_name_lookup,
    build_issue_fields,
    clean_cell_value,
    connect_to_jira,
    find_first_value,
    get_create_meta_fields,
    resolve_bug_severity_attachment_name,
    resolve_project_key,
    resolve_user_name,
    transition_issue_to_open,
)
from transsion_jira_regression_processor import RegressionProcessor

logger = logging.getLogger(__name__)

CONFIG_DIR = CURRENT_DIR / "config"
LOG_DIR = CURRENT_DIR / "log"
RESULT_DIR = CURRENT_DIR / "result"
DEFAULT_CONFIG_FILE = CONFIG_DIR / "transsion_jira_defaults.json"
DEFAULT_REGRESSION_CONFIG = CONFIG_DIR / "regression_rules.json"
DEFAULT_SEVERITY_RULES = CONFIG_DIR / "问题等级定级表.xls"
DEFAULT_BUG_SEVERITY_IMAGE_DIR = CONFIG_DIR / "bug_severity_priority_image"

def setup_logging() -> None:
    LOG_DIR.mkdir(parents=True, exist_ok=True)
    logging.basicConfig(
        level=logging.INFO,
        format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
        handlers=[
            logging.StreamHandler(),
            logging.FileHandler(LOG_DIR / "transsion_jira_stage2_regression.log", encoding="utf-8"),
        ],
    )

def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Transsion Jira 第二阶段回归增强工具")
    parser.add_argument("--add-excel-file", dest="excel_file", required=True, help="上传模板 Excel 路径")
    parser.add_argument("--jira-username", dest="jira_username", default=os.getenv("JIRA_USERNAME"), help="Jira 用户名")
    parser.add_argument("--jira-password", dest="jira_password", default=os.getenv("JIRA_PASSWORD"), help="Jira 密码")
    parser.add_argument("--jira-server", dest="jira_server", default=None, help="Jira 服务地址")
    parser.add_argument("--config-file", dest="config_file", default=str(DEFAULT_CONFIG_FILE), help="默认配置路径")
    parser.add_argument("--regression-config", dest="regression_config", default=str(DEFAULT_REGRESSION_CONFIG), help="回归规则路径")
    parser.add_argument("--severity-rules-file", dest="severity_rules_file", default=str(DEFAULT_SEVERITY_RULES), help="问题等级规则表路径")
    parser.add_argument("--bug-severity-image-dir", dest="bug_severity_image_dir", default=str(DEFAULT_BUG_SEVERITY_IMAGE_DIR), help="问题严重定义附件图片目录")
    parser.add_argument("--dry-run", action="store_true", help="仅校验决策，不执行 Jira 动作")
    return parser.parse_args()

def get_meta_bundle(jira, project_key, issue_type_name, meta_cache):
    cache_key = (project_key, issue_type_name)
    if cache_key in meta_cache:
        return meta_cache[cache_key]
    create_fields = get_create_meta_fields(jira, project_key, issue_type_name)
    bundle = {
        "create_fields": create_fields,
        "field_name_lookup": build_field_name_lookup(create_fields),
        "allowed_values": {} # 简化处理
    }
    # 这里我们其实需要 allowed_values 来做校验，但为了速度先简化
    from transsion_batch_jira_common import extract_allowed_values
    bundle["allowed_values"] = extract_allowed_values(create_fields)
    meta_cache[cache_key] = bundle
    return bundle

def run_regression_flow(args: argparse.Namespace) -> int:
    defaults = load_defaults(args.config_file)
    priority_mapping_config = load_priority_mapping_from_rules_excel(args.severity_rules_file)
    jira_server = args.jira_server or defaults.get("jira_server")
    
    if not args.jira_username or not args.jira_password:
        logger.error("需要提供 Jira 用户名和密码")
        return 1

    df = read_excel_smart(args.excel_file)
    logger.info("已读取输入 Excel %d 条", len(df))

    jira = connect_to_jira(jira_server, args.jira_username, args.jira_password)
    current_user = str(jira.current_user() or "").strip()
    logger.info("Jira 连接成功，当前用户: %s", current_user)

    processor = RegressionProcessor(args.regression_config, jira)
    
    # 1. 同步历史问题
    exported_count = processor.sync_historical_issues()
    
    # 2. 逐行处理
    meta_cache = {}
    user_cache = {}
    project_cache = {}
    
    # 确定本轮版本 (从 Excel 里的第一行 Versions 取)
    current_version = ""
    if "Versions" in df.columns and not df.empty:
        current_version = str(df.iloc[0]["Versions"]).strip()
    
    logger.info("本轮版本识别为: %s", current_version)

    success_count = 0
    failed_count = 0

    for index, row in df.iterrows():
        row_dict = row.to_dict()
        logger.info("正在处理第 %d 行: %s", index + 1, row_dict.get("Summary"))
        
        # 决策
        decision = processor.process_row(index + 1, row_dict, current_version)
        action = decision["action"]
        jira_key = decision["matched_jira_key"]
        
        logger.info("决策动作: %s, 命中单号: %s", action, jira_key)

        try:
            if args.dry_run:
                decision["success"] = 1
                decision["result_message"] = "[DRY_RUN] " + str(decision.get("result_message") or "")
            elif action == "CREATE_NEW" or action == "RECREATE":
                # 执行建单逻辑 (复用现有逻辑)
                new_key = execute_create_new(jira, row, defaults, priority_mapping_config, meta_cache, user_cache, project_cache, current_user, args)
                decision["matched_jira_key"] = new_key
                decision["success"] = 1
                decision["result_message"] = "New issue created"
            elif action == "UPDATE_OPEN":
                execute_update_open(jira, jira_key, row, decision, defaults, priority_mapping_config, meta_cache, user_cache, project_cache, current_user, args)
                decision["success"] = 1
                # 更新本地计数
                processor.update_local_state(jira_key, decision["new_count"], current_version)
            elif action == "COMMENT_WAIT_FIX":
                msg = f"当前版本 {current_version} 出现，待新版本验证。\n\n" + row.get("PS", "")
                jira.add_comment(jira_key, msg)
                decision["success"] = 1
                decision["comment_status"] = "SUCCESS"
            elif action == "COMMENT_WONT_FIX":
                msg = f"当前版本 {current_version} 仍出现，但按不修复类问题保留原结论。\n\n" + row.get("PS", "")
                jira.add_comment(jira_key, msg)
                decision["success"] = 1
                decision["comment_status"] = "SUCCESS"
            elif action == "MANUAL_REVIEW":
                decision["success"] = 1 # 决策本身是成功的，只是标记为人工审核
            
            if decision["success"]:
                success_count += 1
            else:
                failed_count += 1
                
        except Exception as e:
            logger.exception("处理第 %d 行失败", index + 1)
            decision["success"] = 0
            decision["reason"] = str(e)
            failed_count += 1

        # 记录执行结果
        processor.record_execution_result(decision)

    # 3. 回归 PASS 处理
    pass_results = processor.handle_regression_pass(current_version)
    for p in pass_results:
        key = p["jira_key"]
        act = p["action"]
        cnt = p["new_pass_count"]
        msg = f"已回归验证 {cnt} 个版本 PASS。"
        if not args.dry_run:
            try:
                jira.add_comment(key, msg)
                if act == "CLOSE":
                    # 执行关单流转 (需要找到关闭对应的 Transition ID)
                    # 这里先简化处理
                    logger.info("单号 %s 达到 PASS 阈值，建议执行关单", key)
            except Exception as e:
                logger.error("回归 PASS 评论失败 %s: %s", key, e)

    # 4. 完成运行
    processor.finish_run(current_version, exported_count, len(df), success_count, failed_count)
    
    # 5. 生成 Excel 报表
    generate_excel_summary(processor.db_path, processor.run_id)
    
    return 0 if failed_count == 0 else 1

def execute_create_new(jira, row, defaults, priority_config, meta_cache, user_cache, project_cache, current_user, args):
    project_key = str(resolve_project_key(jira, find_first_value(row, "Project", defaults.get("project_key")), project_cache))
    issue_type_name = str(find_first_value(row, "Issue Type", defaults.get("issue_type", "故障")))
    bundle = get_meta_bundle(jira, project_key, issue_type_name, meta_cache)
    
    issue_fields = build_issue_fields(
        jira_client=jira,
        row=row,
        defaults=defaults,
        create_fields=bundle["create_fields"],
        allowed_values=bundle["allowed_values"],
        severity_to_priority_mapping=priority_config.get("severity_to_priority", {}),
        priority_alias_mapping=priority_config.get("priority_aliases", {}),
        user_cache=user_cache,
        project_cache=project_cache,
        create_assignee_override=current_user,
    )
    
    new_issue = jira.create_issue(fields=issue_fields)
    issue_key = new_issue.key
    
    # 附件/流转/负责人回写 (逻辑同 create_transsion_jira_batch_from_excel.py)
    # ...
    # 为了简化，我们可以把这些逻辑封装到 transsion_batch_jira_common.py
    # 或者直接在这里写。为了保证完整性，我在这里写。
    
    ps_text = find_first_value(row, "PS")
    if clean_cell_value(ps_text):
        jira.add_comment(issue_key, str(ps_text))

    attachment_name = resolve_bug_severity_attachment_name(
        row,
        priority_config.get("severity_to_priority", {}),
        priority_config.get("priority_aliases", {}),
    )
    if attachment_name:
        attachment_path = Path(args.bug_severity_image_dir) / attachment_name
        if attachment_path.exists():
            with open(attachment_path, "rb") as fp:
                jira.add_attachment(issue=issue_key, attachment=fp, filename=attachment_path.name)
    
    transition_issue_to_open(jira, issue_key)
    
    target_assignee = resolve_user_name(jira, find_first_value(row, "Assignee"), user_cache)
    if target_assignee and current_user and target_assignee != current_user:
        assign_issue_to_user(jira, issue_key, target_assignee)
    
    return issue_key

def execute_update_open(jira, jira_key, row, decision, defaults, priority_config, meta_cache, user_cache, project_cache, current_user, args):
    # 更新 Summary, Description, Priority
    project_key = str(resolve_project_key(jira, find_first_value(row, "Project", defaults.get("project_key")), project_cache))
    issue_type_name = str(find_first_value(row, "Issue Type", defaults.get("issue_type", "故障")))
    bundle = get_meta_bundle(jira, project_key, issue_type_name, meta_cache)

    issue_fields = build_issue_fields(
        jira_client=jira,
        row=row,
        defaults=defaults,
        create_fields=bundle["create_fields"],
        allowed_values=bundle["allowed_values"],
        severity_to_priority_mapping=priority_config.get("severity_to_priority", {}),
        priority_alias_mapping=priority_config.get("priority_aliases", {}),
        user_cache=user_cache,
        project_cache=project_cache,
        create_assignee_override=None # 不修改负责人
    )
    
    # 更新字段 (Summary, Description, Priority)
    update_fields = {
        "summary": issue_fields["summary"],
        "description": issue_fields["description"],
        "priority": issue_fields["priority"]
    }
    jira.issue(jira_key).update(fields=update_fields)
    
    # 追加评论 (PS)
    ps_text = find_first_value(row, "PS")
    if clean_cell_value(ps_text):
        jira.add_comment(jira_key, str(ps_text))
    
    # 上传附件
    attachment_name = resolve_bug_severity_attachment_name(
        row,
        priority_config.get("severity_to_priority", {}),
        priority_config.get("priority_aliases", {}),
    )
    if attachment_name:
        attachment_path = Path(args.bug_severity_image_dir) / attachment_name
        if attachment_path.exists():
            with open(attachment_path, "rb") as fp:
                jira.add_attachment(issue=jira_key, attachment=fp, filename=attachment_path.name)

def generate_excel_summary(db_path: Path, run_id: str):
    import sqlite3
    with sqlite3.connect(db_path) as conn:
        df = pd.read_sql_query("SELECT * FROM execution_results WHERE run_id = ?", conn, params=(run_id,))
        RESULT_DIR.mkdir(parents=True, exist_ok=True)
        out_path = RESULT_DIR / f"regression_summary_{run_id}.xlsx"
        df.to_excel(out_path, index=False)
        logger.info("Excel 摘要报告已生成: %s", out_path)

def main():
    setup_logging()
    args = parse_args()
    try:
        sys.exit(run_regression_flow(args))
    except Exception:
        logger.exception("程序异常退出")
        sys.exit(1)

if __name__ == "__main__":
    main()
