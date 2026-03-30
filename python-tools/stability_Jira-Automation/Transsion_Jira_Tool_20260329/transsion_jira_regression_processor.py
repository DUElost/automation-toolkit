#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Transsion Jira 第二阶段回归处理器
------------------------------

负责历史单据导出、本地缓存管理、强命中判定及决策动作分发。
"""

from __future__ import annotations

import json
import logging
import re
import sqlite3
import time
from datetime import datetime
from difflib import SequenceMatcher
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

import pandas as pd
from jira import JIRA
from jira.exceptions import JIRAError

logger = logging.getLogger(__name__)

class RegressionProcessor:
    def __init__(self, config_path: str | Path, jira_client: JIRA):
        self.config_path = Path(config_path)
        self.jira = jira_client
        self.config = self._load_config()
        self.db_path = Path(self.config["output"]["sqlite_path"])
        self.db_path.parent.mkdir(parents=True, exist_ok=True)
        self._init_db()
        self.run_id = datetime.now().strftime("%Y%m%d_%H%M%S")

    def _load_config(self) -> Dict[str, Any]:
        with open(self.config_path, "r", encoding="utf-8") as fp:
            return json.load(fp)

    def _init_db(self) -> None:
        with sqlite3.connect(self.db_path) as conn:
            cursor = conn.cursor()
            # 1. 历史快照表
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS jira_issue_snapshot (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    run_id TEXT,
                    jira_key TEXT,
                    summary TEXT,
                    status TEXT,
                    resolution TEXT,
                    fix_version TEXT,
                    priority TEXT,
                    assignee TEXT,
                    reporter TEXT,
                    affect_project TEXT,
                    environment TEXT,
                    exp_class TEXT,
                    caused_by TEXT,
                    created_at TEXT,
                    updated_at TEXT,
                    raw_payload TEXT
                )
            """)
            # 2. 本地状态表
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS issue_state (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    jira_key TEXT UNIQUE,
                    fingerprint TEXT,
                    status TEXT,
                    resolution TEXT,
                    fix_version TEXT,
                    count INTEGER DEFAULT 0,
                    open_seen_count INTEGER DEFAULT 0,
                    regression_pass_count INTEGER DEFAULT 0,
                    verified_versions TEXT,
                    last_seen_version TEXT,
                    updated_at TEXT
                )
            """)
            # 3. 执行结果表
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS execution_results (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    run_id TEXT,
                    row_number INTEGER,
                    source_summary TEXT,
                    matched_jira_key TEXT,
                    matched_status TEXT,
                    matched_resolution TEXT,
                    fix_version TEXT,
                    action TEXT,
                    success INTEGER,
                    manual_review INTEGER,
                    reason TEXT,
                    old_count INTEGER,
                    new_count INTEGER,
                    comment_status TEXT,
                    ps_comment_status TEXT,
                    result_message TEXT,
                    created_at TEXT
                )
            """)
            # 4. 同步元数据表
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS sync_runs (
                    run_id TEXT PRIMARY KEY,
                    started_at TEXT,
                    finished_at TEXT,
                    jql TEXT,
                    current_version TEXT,
                    exported_issue_count INTEGER,
                    processed_row_count INTEGER,
                    success_count INTEGER,
                    failed_count INTEGER
                )
            """)
            conn.commit()

    def sync_historical_issues(self) -> int:
        export_cfg = self.config["jira_export"]
        if not export_cfg.get("enabled"):
            logger.info("Jira 历史导出已禁用")
            return 0

        jql = export_cfg["jql"]
        max_results = export_cfg.get("max_results", 1000)
        fields = export_cfg["fields"]

        logger.info("开始从 Jira 导出历史问题单，JQL: %s", jql)
        try:
            issues = self.jira.search_issues(jql, maxResults=max_results, fields=fields)
        except JIRAError as e:
            logger.error("Jira 搜索失败: %s", e)
            return 0

        logger.info("成功导出 %d 条历史单据", len(issues))
        
        field_map = self.config["matching"].get("field_mapping", {})
        affect_project_field = field_map.get("affect_project", "customfield_14205")
        exp_class_field = field_map.get("exp_class", "customfield_14202")

        with sqlite3.connect(self.db_path) as conn:
            cursor = conn.cursor()
            for issue in issues:
                fields = issue.fields
                jira_key = issue.key
                summary = fields.summary
                status = fields.status.name
                resolution = fields.resolution.name if fields.resolution else ""
                
                # 处理 fixVersions (数组取最后一个)
                fix_version = ""
                if hasattr(fields, "fixVersions") and fields.fixVersions:
                    fix_version = fields.fixVersions[-1].name
                
                priority = fields.priority.name if fields.priority else ""
                assignee = fields.assignee.name if fields.assignee else ""
                reporter = fields.reporter.name if fields.reporter else ""
                
                # 自定义字段
                affect_project = ""
                if hasattr(fields, affect_project_field):
                    val = getattr(fields, affect_project_field)
                    affect_project = val.value if hasattr(val, "value") else str(val or "")
                
                exp_class = ""
                if hasattr(fields, exp_class_field):
                    val = getattr(fields, exp_class_field)
                    exp_class = val.value if hasattr(val, "value") else str(val or "")
                
                environment = getattr(fields, "environment", "") or ""
                # Description 中可能包含 CausedBy，这里简化处理，认为 CausedBy 在 Description 或特定位置，
                # 但由于 Snapshot 主要是为了匹配，这里尝试从 Description 提取 CausedBy (如果存在)
                description = getattr(fields, "description", "") or ""
                caused_by = self._extract_caused_by(description)

                cursor.execute("""
                    INSERT INTO jira_issue_snapshot (
                        run_id, jira_key, summary, status, resolution, fix_version,
                        priority, assignee, reporter, affect_project, environment,
                        exp_class, caused_by, created_at, updated_at, raw_payload
                    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                """, (
                    self.run_id, jira_key, summary, status, resolution, fix_version,
                    priority, assignee, reporter, affect_project, environment,
                    exp_class, caused_by, fields.created, fields.updated, ""
                ))

                # 更新 issue_state (如果不存在则插入)
                cursor.execute("""
                    INSERT OR IGNORE INTO issue_state (jira_key, status, resolution, fix_version, updated_at)
                    VALUES (?, ?, ?, ?, ?)
                """, (jira_key, status, resolution, fix_version, datetime.now().isoformat()))
                
                cursor.execute("""
                    UPDATE issue_state SET status=?, resolution=?, fix_version=?, updated_at=?
                    WHERE jira_key=?
                """, (status, resolution, fix_version, datetime.now().isoformat(), jira_key))

            conn.commit()
        return len(issues)

    def _extract_caused_by(self, description: str) -> str:
        # 简单从 Description 提取
        if not description:
            return ""
        # 常见格式 K)other: \n CausedBy: ...
        match = re.search(r"CausedBy:\s*(.*)", description, re.IGNORECASE)
        if match:
            return match.group(1).strip()
        return ""

    def find_strong_match(self, row: Dict[str, Any]) -> Optional[Dict[str, Any]]:
        affect_project = str(row.get("Affect Project", "")).strip()
        environment = str(row.get("Environment", "")).strip()
        exp_class = str(row.get("Exp Class", "")).strip()
        current_signature = str(row.get("Caused by Signature", "")).strip()
        
        threshold = self.config["matching"].get("cause_similarity_threshold", 0.9)

        with sqlite3.connect(self.db_path) as conn:
            conn.row_factory = sqlite3.Row
            cursor = conn.cursor()
            # 先按精确字段过滤
            cursor.execute("""
                SELECT * FROM jira_issue_snapshot 
                WHERE run_id = ? AND affect_project = ? AND exp_class = ?
            """, (self.run_id, affect_project, exp_class))
            
            candidates = cursor.fetchall()
            best_match = None
            max_sim = 0.0

            for cand in candidates:
                # 环境比对 (这里通常也是精确匹配)
                if cand["environment"] != environment:
                    continue
                
                # CausedBy 相似度比对
                cand_signature = cand["caused_by"] # 假设存的是原始或已归一化，这里统一归一化再比
                from transsion_upload_template_common import normalize_caused_by_signature
                norm_cand = normalize_caused_by_signature(cand_signature)
                
                sim = SequenceMatcher(None, current_signature, norm_cand).ratio()
                if sim >= threshold and sim > max_sim:
                    max_sim = sim
                    best_match = dict(cand)
            
            return best_match

    def process_row(self, row_idx: int, row: Dict[str, Any], current_version: str) -> Dict[str, Any]:
        matched_issue = self.find_strong_match(row)
        
        result = {
            "run_id": self.run_id,
            "row_number": row_idx,
            "source_summary": row.get("Summary"),
            "matched_jira_key": None,
            "matched_status": None,
            "matched_resolution": None,
            "fix_version": None,
            "action": "CREATE_NEW",
            "success": 0,
            "manual_review": 0,
            "reason": None,
            "old_count": 0,
            "new_count": int(row.get("Count", 0)),
            "comment_status": None,
            "ps_comment_status": None,
            "result_message": None,
            "created_at": datetime.now().isoformat()
        }

        if not matched_issue:
            result["reason"] = "No strong match found"
            return result

        jira_key = matched_issue["jira_key"]
        status = matched_issue["status"]
        resolution = matched_issue["resolution"]
        fix_version = matched_issue["fix_version"]
        
        result.update({
            "matched_jira_key": jira_key,
            "matched_status": status,
            "matched_resolution": resolution,
            "fix_version": fix_version
        })

        rules = self.config["status_rules"]
        
        # 1. 命中 open_like
        if status in rules["open_like_statuses"]:
            result["action"] = "UPDATE_OPEN"
            return self._handle_open_like(result, row, matched_issue)

        # 2. 命中已解决已修复
        if status in rules["resolved_statuses"] and resolution in rules["resolved_fixed_resolutions"]:
            if fix_version and self._is_version_older(current_version, fix_version):
                result["action"] = "COMMENT_WAIT_FIX"
                return self._handle_wait_fix(result, row, matched_issue)
            else:
                result["action"] = "MANUAL_REVIEW"
                result["manual_review"] = 1
                result["reason"] = f"Resolved but current version {current_version} >= fix version {fix_version}"
                return result

        # 3. 命中不修复类
        if resolution in rules["wont_fix_resolutions"]:
            result["action"] = "COMMENT_WONT_FIX"
            return self._handle_wont_fix(result, row, matched_issue)

        # 4. 命中已关闭
        if status in rules["closed_statuses"]:
            if resolution in rules["wont_fix_resolutions"]:
                result["action"] = "COMMENT_WONT_FIX"
                return self._handle_wont_fix(result, row, matched_issue)
            else:
                result["action"] = "RECREATE"
                return result

        result["reason"] = f"Unhandled status/resolution combination: {status}/{resolution}"
        return result

    def _is_version_older(self, v1: str, v2: str) -> bool:
        # 简单字符串比较，实际可能需要更复杂的逻辑
        return v1 < v2

    def _handle_open_like(self, result: Dict[str, Any], row: Dict[str, Any], matched: Dict[str, Any]) -> Dict[str, Any]:
        jira_key = matched["jira_key"]
        # 获取旧计数 (从 issue_state 获取，如果没有则尝试从 Description 提取)
        old_count = self._get_local_count(jira_key)
        current_count = int(row.get("Count", 0))
        new_count = old_count + current_count
        
        result["old_count"] = old_count
        result["new_count"] = new_count
        
        try:
            # 更新 Jira
            # 1. 更新计数相关的字段
            # 注意：这里需要知道具体的字段 ID，或者更新 Description
            # 由于设计文档说覆盖更新 Summary, Description, Priority
            # 我们需要从 row 中构建这些
            # 这里调用 jira.issue(jira_key).update(...)
            
            # 为了保持脚本独立，这里我们只返回动作，由执行脚本统一调用 Jira
            result["success"] = 1
            result["result_message"] = f"Count updated: {old_count} -> {new_count}"
        except Exception as e:
            result["success"] = 0
            result["reason"] = str(e)
        
        return result

    def _handle_wait_fix(self, result: Dict[str, Any], row: Dict[str, Any], matched: Dict[str, Any]) -> Dict[str, Any]:
        result["success"] = 1
        result["result_message"] = "Added comment: 待新版本验证"
        return result

    def _handle_wont_fix(self, result: Dict[str, Any], row: Dict[str, Any], matched: Dict[str, Any]) -> Dict[str, Any]:
        result["success"] = 1
        result["result_message"] = "Added comment: 保留原结论"
        return result

    def _get_local_count(self, jira_key: str) -> int:
        with sqlite3.connect(self.db_path) as conn:
            cursor = conn.cursor()
            cursor.execute("SELECT count FROM issue_state WHERE jira_key = ?", (jira_key,))
            row = cursor.fetchone()
            return row[0] if row else 0

    def update_local_state(self, jira_key: str, new_count: int, version: str) -> None:
        with sqlite3.connect(self.db_path) as conn:
            cursor = conn.cursor()
            cursor.execute("""
                UPDATE issue_state SET count = ?, last_seen_version = ?, updated_at = ?
                WHERE jira_key = ?
            """, (new_count, version, datetime.now().isoformat(), jira_key))
            conn.commit()

    def record_execution_result(self, result: Dict[str, Any]) -> None:
        with sqlite3.connect(self.db_path) as conn:
            cursor = conn.cursor()
            cursor.execute("""
                INSERT INTO execution_results (
                    run_id, row_number, source_summary, matched_jira_key, matched_status,
                    matched_resolution, fix_version, action, success, manual_review,
                    reason, old_count, new_count, comment_status, ps_comment_status,
                    result_message, created_at
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """, (
                result["run_id"], result["row_number"], result["source_summary"],
                result["matched_jira_key"], result["matched_status"], result["matched_resolution"],
                result["fix_version"], result["action"], result["success"], result["manual_review"],
                result["reason"], result["old_count"], result["new_count"],
                result["comment_status"], result["ps_comment_status"],
                result["result_message"], result["created_at"]
            ))
            conn.commit()

    def finish_run(self, current_version: str, exported_count: int, processed_count: int, success_count: int, failed_count: int) -> None:
        with sqlite3.connect(self.db_path) as conn:
            cursor = conn.cursor()
            cursor.execute("""
                INSERT INTO sync_runs (
                    run_id, started_at, finished_at, jql, current_version,
                    exported_issue_count, processed_row_count, success_count, failed_count
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
            """, (
                self.run_id, self.run_id, datetime.now().isoformat(),
                self.config["jira_export"]["jql"], current_version,
                exported_count, processed_count, success_count, failed_count
            ))
            conn.commit()

    def handle_regression_pass(self, current_version: str) -> List[Dict[str, Any]]:
        """处理回归 PASS 逻辑"""
        rules = self.config["status_rules"]
        reg_cfg = self.config["regression"]
        required_pass = reg_cfg.get("required_regression_pass_versions", 2)
        
        pass_results = []
        
        with sqlite3.connect(self.db_path) as conn:
            conn.row_factory = sqlite3.Row
            cursor = conn.cursor()
            
            # 查找本轮未命中的“已解决已修复”且“版本符合”的问题
            # 1. 获取本轮命中的 jira_key
            cursor.execute("SELECT matched_jira_key FROM execution_results WHERE run_id = ? AND matched_jira_key IS NOT NULL", (self.run_id,))
            matched_keys = {row["matched_jira_key"] for row in cursor.fetchall()}
            
            # 2. 从 snapshot 中找所有已解决已修复
            cursor.execute("""
                SELECT * FROM jira_issue_snapshot 
                WHERE run_id = ? AND status IN (%s) AND resolution IN (%s)
            """ % (
                ",".join("?" * len(rules["resolved_statuses"])),
                ",".join("?" * len(rules["resolved_fixed_resolutions"]))
            ), (self.run_id, *rules["resolved_statuses"], *rules["resolved_fixed_resolutions"]))
            
            candidates = cursor.fetchall()
            for cand in candidates:
                jira_key = cand["jira_key"]
                if jira_key in matched_keys:
                    continue
                
                fix_version = cand["fix_version"]
                if not fix_version or self._is_version_older(current_version, fix_version):
                    continue
                
                # 检查本地状态，看该版本是否已 PASS
                cursor.execute("SELECT verified_versions, regression_pass_count FROM issue_state WHERE jira_key = ?", (jira_key,))
                state_row = cursor.fetchone()
                verified_versions = state_row["verified_versions"] or ""
                pass_count = state_row["regression_pass_count"] or 0
                
                if current_version in verified_versions.split(","):
                    continue
                
                # 记录 PASS
                new_pass_count = pass_count + 1
                new_verified = verified_versions + ("," if verified_versions else "") + current_version
                
                cursor.execute("""
                    UPDATE issue_state SET regression_pass_count = ?, verified_versions = ?, updated_at = ?
                    WHERE jira_key = ?
                """, (new_pass_count, new_verified, datetime.now().isoformat(), jira_key))
                
                action = "PASS"
                if new_pass_count >= required_pass:
                    action = "CLOSE"
                
                pass_results.append({
                    "jira_key": jira_key,
                    "action": action,
                    "new_pass_count": new_pass_count
                })
            
            conn.commit()
        return pass_results
