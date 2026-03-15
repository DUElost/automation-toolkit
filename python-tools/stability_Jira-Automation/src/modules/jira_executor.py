#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
JIRAExecutor
------------

负责将待处理问题写入（或更新）Jira，并维护版本/回归记录。
"""

from __future__ import annotations

import json
import logging
import os
from pathlib import Path
from typing import Any, Dict, List, Optional, Set

from .database_manager import DatabaseManager
from .data_normalizer import SeverityEngine
from .decision_engine import DecisionEngine, DecisionResult
from .jira_issue_template import build_summary, DEFAULT_REPORTER
from .jira_synchronizer import JIRASynchronizer
from .version_utils import compare_versions

logger = logging.getLogger(__name__)

# 配置文件路径
CONFIG_DIR = Path(__file__).parent.parent.parent / "config"
COMMENT_TEMPLATES_FILE = CONFIG_DIR / "comment_templates.json"


def _load_comment_templates() -> Dict[str, Any]:
    """加载备注模板配置"""
    if COMMENT_TEMPLATES_FILE.exists():
        try:
            with open(COMMENT_TEMPLATES_FILE, "r", encoding="utf-8") as f:
                return json.load(f)
        except (json.JSONDecodeError, IOError) as e:
            logger.warning("加载备注模板配置失败: %s，使用默认值", e)
    return {}


def _get_template(config: Dict[str, Any], key: str, default: str) -> str:
    """从配置中获取模板"""
    templates = config.get("templates", {})
    return templates.get(key, {}).get("template", default)


def _get_keywords(config: Dict[str, Any], key: str, default: Set[str]) -> Set[str]:
    """从配置中获取关键字集合"""
    status_keywords = config.get("status_keywords", {})
    keywords = status_keywords.get(key, {}).get("keywords", [])
    return set(keywords) if keywords else default


# 加载配置
_CONFIG = _load_comment_templates()

# 状态关键字（从配置加载，有默认值）
CLOSED_STATUS_KEYWORDS = _get_keywords(_CONFIG, "closed", {"closed", "done", "已关闭", "已关单"})
RESOLVED_STATUS_KEYWORDS = _get_keywords(_CONFIG, "resolved", {"resolved", "已解决", "verified", "已验证"})
WONT_FIX_KEYWORDS = _get_keywords(_CONFIG, "wont_fix", {"won't fix", "wont fix", "不解决", "无法解决", "问题不修改", "非问题"})

# 备注模板（从配置加载，有默认值）
COMMENT_WONT_FIX = _get_template(_CONFIG, "WONT_FIX", "Won't fix待后续补充信息")
COMMENT_REOPEN = _get_template(_CONFIG, "REOPEN", "问题复现Reopen待后续补充信息")
COMMENT_WAIT_NEW = _get_template(_CONFIG, "WAIT_NEW_VERSION", "在历史版本中出现，待新版本验证结果")
COMMENT_CONTINUE = _get_template(_CONFIG, "CONTINUE", "问题继续在新版本中出现，待后续补充信息")
COMMENT_PASS_1 = _get_template(_CONFIG, "REGRESSION_PASS_1", "已回归验证1个版本PASS")
COMMENT_PASS_2 = _get_template(_CONFIG, "REGRESSION_PASS_2", "已回归验证2个版本PASS")

# 回归验证标题过滤条件（从配置加载，有默认值）
_REGRESSION_FILTER = _CONFIG.get("regression_pass_filter", {})
REGRESSION_TITLE_KEYWORDS = _REGRESSION_FILTER.get("title_keywords", ["[自动化]", "[V551A]", "[MonkeyAEE]"])


class VersionManager:
    def __init__(self, db: DatabaseManager, project_key: str):
        self.db = db
        self.project_key = project_key
        # 确保列存在，避免重复 ALTER
        self.db.ensure_column("jira_versions", "affect_project", "TEXT")

    def ensure_versions(self, versions: List[str], affect_project: Optional[str]) -> None:
        self.db.ensure_version_records(versions, self.project_key, affect_project)


class RegressionManager:
    def __init__(self, db: DatabaseManager, required_cycles: int = 2):
        self.db = db
        self.required_cycles = required_cycles

    def record_cycle(self, jira_key: str, version: Optional[str]) -> None:
        if not jira_key or not version:
            return
        self.db.record_regression_result(jira_key, version, status="MONKEYAEE")

    def run(self) -> List[str]:
        closed: List[str] = []
        candidates = self.db.fetch_regression_candidates()
        for issue in candidates:
            jira_key = issue.get("jira_key")
            if not jira_key:
                continue
            cycles = self._count_cycles(jira_key)
            if cycles >= self.required_cycles:
                self.db.update_main_table_record(jira_key, {"status": "Closed"})
                closed.append(jira_key)
        if closed:
            logger.info("批量回归闭环: %s", closed)
        return closed

    def _count_cycles(self, jira_key: str) -> int:
        placeholder = "?" if self.db.db_type == "sqlite" else "%s"
        query = f"SELECT COUNT(*) FROM issue_regressions WHERE jira_key = {placeholder}"
        rows = self.db.execute(query, (jira_key,))
        if not rows:
            return 0
        if isinstance(rows[0], dict):
            return list(rows[0].values())[0]
        return rows[0][0]


class JIRAExecutor:
    def __init__(
        self,
        jira_sync: JIRASynchronizer,
        decision_engine: DecisionEngine,
        db: DatabaseManager,
        config: Optional[Dict[str, Any]] = None,
    ):
        self.jira_sync = jira_sync
        self.decision_engine = decision_engine
        self.db = db
        self.config = config or {}
        self.dry_run = bool(self.config.get("dry_run")) or getattr(jira_sync, "mode", "").lower() == "mock"
        self.version_manager = VersionManager(db, jira_sync.project_key)
        self.regression_manager = RegressionManager(db, self.config.get("regression_cycles", 2))
        self.severity_engine = SeverityEngine()
        self.stats = {
            "processed": 0,
            "created": 0,
            "updated": 0,
            "failed": 0,
            "regression_closed": 0,
        }

    # ------------------------------------------------------------------
    # 备注/描述格式化
    # ------------------------------------------------------------------
    @staticmethod
    def _format_details(issue: Dict[str, Any]) -> str:
        reporter = issue.get("reporter") or os.getenv("JIRA_REPORTER", DEFAULT_REPORTER)
        version = issue.get("version") or "Unknown"
        raw_data = issue.get("raw_data")
        raw_data_dict = raw_data if isinstance(raw_data, dict) else {}
        path = (
            issue.get("path")
            or raw_data_dict.get("path")
            or issue.get("source_file")
            or "N/A"
        )
        duplicate = issue.get("count") or 0
        device_count = issue.get("device_count") or 0
        return "\n".join(
            [
                f"Reporter: {reporter}",
                f"Version: {version}",
                f"Path: {path}",
                f"Duplicate Number: {duplicate}",
                f"Device Count: {device_count}",
            ]
        )

    def _comment_continue(self, issue: Dict[str, Any]) -> str:
        return "\n".join(
            [
                "问题继续在新一轮测试中出现，详情如下：",
                self._format_details(issue),
            ]
        )

    def _comment_reopen(self, issue: Dict[str, Any]) -> str:
        return "\n".join(
            [
                "已解决问题在新一轮测试中出现，需Reopen，详情如下：",
                self._format_details(issue),
            ]
        )

    def _comment_wait_new(self, issue: Dict[str, Any]) -> str:
        return "\n".join(
            [
                "在历史版本中此问题再次出现，详情如下：",
                self._format_details(issue),
                "待新版本验证结果",
            ]
        )

    def _comment_wont_fix(self, issue: Dict[str, Any]) -> str:
        return "\n".join(
            [
                "该Won't fix问题在历史版本中再次出现，详情如下：",
                self._format_details(issue),
            ]
        )

    def process_pending_issues(self, limit: Optional[int] = None) -> Dict[str, Any]:
        issues = self.db.get_pending_issues(limit)
        if not issues:
            logger.info("无待处理问题")
            regression_pass_closed = self._handle_resolved_without_matches(set(), current_version=None)
            self.stats["regression_closed"] = regression_pass_closed
            return {
                "success": True,
                "processed_count": 0,
                "success_count": 0,
                "error_count": 0,
                "error": None,
                "errors": [],
                "regression_closed": regression_pass_closed,
            }

        versions = [issue.get("version") or issue.get("test_environment") for issue in issues if issue.get("version")]
        affect_project = issues[0].get("affect_project") or self.config.get("affect_project") or "UNKNOWN"
        self.version_manager.ensure_versions(versions, affect_project)
        
        # 提取当前回归版本（用于回归 PASS 记录）
        current_version = self._extract_current_version(issues)
        
        # 批量预加载候选问题，减少数据库查询
        packages = list(set(
            issue.get("package_name") or issue.get("package") 
            for issue in issues 
            if issue.get("package_name") or issue.get("package")
        ))
        self.decision_engine.preload_candidates(packages)

        errors: List[str] = []
        matched_keys: set[str] = set()
        for issue in issues:
            try:
                decision = self.decision_engine.decide(issue)
                if decision.action == "CREATE":
                    jira_key, action = self._handle_create(issue, decision)
                else:
                    original_key = decision.matched_key
                    jira_key, action = self._handle_update(issue, decision)
                    if original_key:
                        matched_keys.add(original_key)

                if action == "created":
                    self.stats["created"] += 1
                else:
                    self.stats["updated"] += 1
                self.db.delete_pending_issue(issue["id"])
                self.stats["processed"] += 1
                self.regression_manager.record_cycle(jira_key, issue.get("version"))
            except Exception as exc:  # pragma: no cover - 需要日志排查
                logger.exception("处理问题失败 pending_id=%s: %s", issue.get("id"), exc)
                self.stats["failed"] += 1
                errors.append(f"pending_id={issue.get('id')}: {exc}")

        closed = self.regression_manager.run()
        self.stats["regression_closed"] = len(closed)
        # 传入当前版本，用于版本维度的回归 PASS 记录
        regression_pass_closed = self._handle_resolved_without_matches(matched_keys, current_version=current_version)
        # 合并回归 PASS 关单数量
        self.stats["regression_closed"] += regression_pass_closed

        return {
            "success": self.stats["failed"] == 0,
            "processed_count": self.stats["processed"],
            "success_count": self.stats["processed"] - self.stats["failed"],
            "error_count": self.stats["failed"],
            "regression_closed": closed + [f"(PASS关单: {regression_pass_closed})"] if regression_pass_closed else closed,
            "errors": errors,
            "error": errors[-1] if errors else None,
        }

    def get_execution_stats(self) -> Dict[str, Any]:
        return self.stats.copy()

    # ------------------------------------------------------------------
    # 内部实现
    # ------------------------------------------------------------------
    def _handle_create(self, issue: Dict[str, Any], decision: DecisionResult) -> tuple[str, str]:
        issue.setdefault("fix_version", None)
        issue.setdefault("regression_pass_count", 0)
        # 新建问题时在描述前添加说明块
        prefix = "\n".join(
            [
                "新增问题，详情如下：",
                self._format_details(issue),
                "",
            ]
        )
        issue = issue.copy()
        description = issue.get("jira_description") or ""
        issue["jira_description"] = prefix + description
        fields = self._build_fields(issue)
        if self.dry_run:
            jira_key = f"DRY-{issue['id']}"
            status = "DryRun"
        else:
            response = self.jira_sync.create_issue(fields)
            jira_key = response["key"]
            status = response.get("status", "Open")
            ps_text = issue.get("ps")
            if ps_text:
                try:
                    self.jira_sync.add_comment(jira_key, ps_text)
                except Exception as exc:
                    logger.warning("自动添加备注失败 %s: %s", jira_key, exc)

        payload = self._build_main_table_payload(issue, jira_key, status)
        self.db.insert_issue(payload)
        return jira_key, "created"

    def _handle_update(self, issue: Dict[str, Any], decision: DecisionResult) -> tuple[str, str]:
        jira_key = decision.matched_key or ""
        if not jira_key:
            logger.warning("决策为更新但未找到匹配问题，自动回退为创建")
            return self._handle_create(issue, decision)

        existing_record = self.db.get_issue_by_key(jira_key) or {}
        jira_issue = self._safe_describe_issue(jira_key)
        status_name, resolution_name, jira_fields = self._extract_status_info(jira_issue, existing_record)
        fix_version = self._extract_fix_version(jira_fields, existing_record)
        if fix_version and existing_record.get("fix_version") != fix_version:
            self.db.update_main_table_record(jira_key, {"fix_version": fix_version})

        version_text = issue.get("version")
        if self._is_closed_status(status_name):
            # 已关闭问题的处理逻辑：
            # - 解决结果是"问题不修复"状态 → 忽略，不做任何处理
            # - 解决结果不是"问题不修复"状态 → 重新提单
            if self._is_wont_fix_resolution(resolution_name):
                logger.info("匹配问题 %s 已关闭且解决结果为问题不修复，忽略", jira_key)
                return jira_key, "updated"
            else:
                logger.info("匹配问题 %s 已关闭但解决结果非问题不修复(%s)，重新提单", jira_key, resolution_name)
                return self._handle_create(issue, decision)

        if self._is_wont_fix_status(status_name, resolution_name):
            self._add_comment(jira_key, self._comment_wont_fix(issue))
            self._add_ps_comment(jira_key, issue)
            return jira_key, "updated"

        if self._is_resolved_status(status_name):
            if fix_version and compare_versions(version_text, fix_version) >= 0:
                try:
                    self._update_existing_issue(
                        jira_key,
                        issue,
                        existing_record,
                        current_status=status_name,
                        fix_version=fix_version,
                        comment=self._comment_reopen(issue),
                        reopen=True,
                    )
                except RuntimeError as exc:
                    if self._is_issue_missing(exc):
                        logger.warning("匹配的问题 %s 不存在，改为新建", jira_key)
                        return self._handle_create(issue, decision)
                    raise
            elif fix_version:
                self._add_comment(jira_key, self._comment_wait_new(issue))
                self._add_ps_comment(jira_key, issue)
            else:
                try:
                    self._update_existing_issue(
                        jira_key,
                        issue,
                        existing_record,
                        current_status=status_name,
                        fix_version=None,
                        comment=self._comment_continue(issue),
                        reopen=False,
                    )
                except RuntimeError as exc:
                    if self._is_issue_missing(exc):
                        logger.warning("匹配的问题 %s 不存在，改为新建", jira_key)
                        return self._handle_create(issue, decision)
                    raise
            return jira_key, "updated"

        try:
            self._update_existing_issue(
                jira_key,
                issue,
                existing_record,
                current_status=status_name,
                fix_version=fix_version,
                comment=self._comment_continue(issue),
                reopen=False,
            )
        except RuntimeError as exc:
            if self._is_issue_missing(exc):
                logger.warning("匹配的问题 %s 不存在，改为新建", jira_key)
                return self._handle_create(issue, decision)
            raise
        return jira_key, "updated"

    def _build_fields(self, issue: Dict[str, Any]) -> Dict[str, Any]:
        return {
            "summary": issue.get("jira_summary") or issue.get("normalized_summary"),
            "description": issue.get("jira_description") or "",
            "environment": issue.get("test_environment"),
            "caused_by": issue.get("caused_by"),
             "key_information": issue.get("key_information"),
            "module": issue.get("module"),
            "assignee": issue.get("assignee"),
            "bug_severity": issue.get("bug_severity"),
            "priority": issue.get("priority") or "Medium",
            "labels": issue.get("labels") or ["MonkeyAEE"],
            "package_name": issue.get("package_name") or issue.get("package"),
            "test_environment": issue.get("test_environment"),
            "affect_project": issue.get("affect_project"),
        }

    def _build_main_table_payload(self, issue: Dict[str, Any], jira_key: str, status: str) -> Dict[str, Any]:
        return {
            "jira_key": jira_key,
            "status": status,
            "summary": issue.get("jira_summary"),
            "normalized_summary": issue.get("normalized_summary"),
            "test_environment": issue.get("test_environment"),
            "raw_caused_by": issue.get("caused_by"),
            "assignee": issue.get("assignee"),
            "bug_severity": issue.get("bug_severity"),
            "priority": issue.get("priority") or "Medium",
            "description": issue.get("jira_description"),
            "package_name": issue.get("package_name"),
            "exp_class": issue.get("exp_class"),
            "exp_type": issue.get("exp_type"),
            "cur_process": issue.get("cur_process"),
            "version": issue.get("version"),
            "count": issue.get("count"),
            "device_count": issue.get("device_count"),
            "source_file": issue.get("source_file"),
            "raw_data": issue.get("raw_data"),
            "fix_version": issue.get("fix_version"),
            "regression_pass_count": issue.get("regression_pass_count", 0),
        }

    @staticmethod
    def _is_issue_missing(exc: Exception) -> bool:
        message = str(exc)
        return "问题不存在" in message or " 404" in message or "status=404" in message

    @staticmethod
    def _extract_current_version(issues: List[Dict[str, Any]]) -> Optional[str]:
        """
        从待处理问题列表中提取当前回归版本。
        
        优先使用出现次数最多的版本，或者使用 VersionComparator 选择最新版本。
        """
        from collections import Counter
        from .version_utils import VersionComparator
        
        versions = [issue.get("version") for issue in issues if issue.get("version")]
        if not versions:
            return None
        
        # 统计版本出现次数，取最多的
        version_counts = Counter(versions)
        most_common = version_counts.most_common(1)
        if most_common:
            return most_common[0][0]
        
        # 备用：使用 VersionComparator 选择最新版本
        comparator = VersionComparator()
        return comparator.latest(versions)

    def _safe_describe_issue(self, jira_key: str) -> Optional[Dict[str, Any]]:
        if self.dry_run:
            return None
        try:
            return self.jira_sync.describe_issue(jira_key)
        except Exception as exc:  # pragma: no cover - 防御性
            logger.warning("获取Jira问题详情失败 %s: %s", jira_key, exc)
            return None

    @staticmethod
    def _extract_status_info(jira_issue: Optional[Dict[str, Any]], existing: Dict[str, Any]) -> tuple[str, str, Dict[str, Any]]:
        if jira_issue:
            fields = jira_issue.get("fields", {}) or {}
            status_name = (fields.get("status") or {}).get("name", "") or ""
            resolution_name = (fields.get("resolution") or {}).get("name", "") or ""
            return status_name, resolution_name, fields
        return existing.get("status", ""), existing.get("resolution", ""), {}

    @staticmethod
    def _extract_fix_version(fields: Dict[str, Any], existing: Dict[str, Any]) -> Optional[str]:
        fix_versions = fields.get("fixVersions") or []
        if isinstance(fix_versions, list):
            for version in fix_versions:
                name = version.get("name")
                if name:
                    return name
        return existing.get("fix_version")

    @staticmethod
    def _status_key(name: str) -> str:
        return (name or "").strip().lower()

    def _is_closed_status(self, status: str) -> bool:
        return self._status_key(status) in CLOSED_STATUS_KEYWORDS

    def _is_resolved_status(self, status: str) -> bool:
        return self._status_key(status) in RESOLVED_STATUS_KEYWORDS

    def _is_wont_fix_status(self, status: str, resolution: str) -> bool:
        value = f"{status} {resolution}".lower()
        return any(keyword in value for keyword in WONT_FIX_KEYWORDS)

    def _is_wont_fix_resolution(self, resolution: str) -> bool:
        """判断解决结果是否为"问题不修复"类型"""
        value = (resolution or "").lower()
        return any(keyword in value for keyword in WONT_FIX_KEYWORDS)

    def _prepare_issue_for_update(self, issue: Dict[str, Any], existing: Dict[str, Any]) -> Dict[str, Any]:
        update_issue = issue.copy()
        package_name = update_issue.get("package_name") or update_issue.get("package")
        update_issue["package_name"] = package_name
        existing_count = existing.get("count") or 0
        new_count = (update_issue.get("count") or 0) + existing_count
        update_issue["count"] = new_count
        severity_level, _ = self.severity_engine.evaluate(
            {
                "exp_class": update_issue.get("exp_class"),
                "exp_type": update_issue.get("exp_type"),
                "detail": update_issue.get("detail"),
                "count": new_count,
            }
        )
        update_issue["bug_severity"] = severity_level
        summary_context = {
            "package": package_name,
            "exp_class": update_issue.get("exp_class"),
            "exp_type": update_issue.get("exp_type"),
            "cur_process": update_issue.get("cur_process"),
            "version": update_issue.get("version"),
            "detail": update_issue.get("detail"),
            "path": update_issue.get("path") or update_issue.get("source_file"),
            "count": new_count,
            "device_count": update_issue.get("device_count"),
        }
        summary = build_summary(summary_context)
        update_issue["jira_summary"] = summary
        update_issue["normalized_summary"] = summary
        update_issue["regression_pass_count"] = existing.get("regression_pass_count", 0)
        return update_issue

    def _add_comment(self, jira_key: str, comment: Optional[str]) -> None:
        if not comment:
            return
        if self.dry_run:
            logger.info("[DRY-RUN] 对 %s 发表评论: %s", jira_key, comment)
            return
        try:
            self.jira_sync.add_comment(jira_key, comment)
        except Exception as exc:  # pragma: no cover - 注释失败记录日志
            logger.warning("添加备注失败 %s: %s", jira_key, exc)

    def _add_ps_comment(self, jira_key: str, issue: Dict[str, Any]) -> None:
        ps_text = issue.get("ps")
        if ps_text:
            self._add_comment(jira_key, ps_text)

    def _update_existing_issue(
        self,
        jira_key: str,
        issue: Dict[str, Any],
        existing: Dict[str, Any],
        current_status: str,
        fix_version: Optional[str],
        comment: Optional[str],
        reopen: bool,
    ) -> None:
        prepared_issue = self._prepare_issue_for_update(issue, existing)
        fields = self._build_fields(prepared_issue)
        new_status = current_status or existing.get("status") or "Open"
        if not self.dry_run:
            response = self.jira_sync.update_issue(jira_key, fields)
            new_status = response.get("status", new_status)
            if reopen:
                transition_resp = self.jira_sync.transition_issue(
                    jira_key, "Reopened", comment or COMMENT_REOPEN
                )
                new_status = transition_resp.get("status", "Reopened")
                comment = None  # transition 已处理备注
            if comment:
                self._add_comment(jira_key, comment)
        else:
            if reopen:
                new_status = "Reopened"
            if comment:
                logger.info("[DRY-RUN] 对 %s 发表评论: %s", jira_key, comment)
        self._add_ps_comment(jira_key, issue)
        prepared_issue["fix_version"] = fix_version or prepared_issue.get("fix_version")
        payload = self._build_main_table_payload(prepared_issue, jira_key, new_status)
        if fix_version:
            payload["fix_version"] = fix_version
        self.db.update_main_table_record(jira_key, payload)

    def _handle_resolved_without_matches(self, processed_keys: set[str], current_version: Optional[str] = None) -> int:
        """
        处理已解决但未在本次上传清单中匹配到的问题。
        
        逻辑：
        - 只处理标题同时包含配置中指定关键字的问题（默认：[自动化]、[V551A]、[MonkeyAEE]）
        - 第一次未匹配：备注"已回归验证1个版本PASS"
        - 第二次未匹配：备注"已回归验证2个版本PASS"，然后关单
        
        Args:
            processed_keys: 本次已处理（匹配到）的 JIRA Key 集合
            current_version: 当前回归版本，用于记录版本维度的 PASS
            
        Returns:
            本次关单的问题数量
        """
        import json
        
        closed_count = 0
        
        # 查询所有已解决状态的自动化问题
        rows = self.db.execute(
            "SELECT jira_key, regression_pass_count, status, summary, verified_versions "
            "FROM jira_issues_main "
            "WHERE status IN ('Resolved','已解决','Verified','已验证')"
        ) or []
        
        for row in rows:
            record = dict(row)
            jira_key = record.get("jira_key")
            if not jira_key:
                continue
            
            # 跳过本次已匹配处理的问题
            if jira_key in processed_keys:
                continue
            
            # 检查标题是否同时包含所有必需关键字（从配置加载）
            summary = record.get("summary") or ""
            if not all(keyword in summary for keyword in REGRESSION_TITLE_KEYWORDS):
                logger.debug("问题 %s 标题不符合回归验证条件，跳过: %s", jira_key, summary[:50])
                continue
            
            # 解析已验证版本列表
            verified_versions_raw = record.get("verified_versions") or "[]"
            try:
                verified_versions = json.loads(verified_versions_raw) if isinstance(verified_versions_raw, str) else []
            except (json.JSONDecodeError, TypeError):
                verified_versions = []
            
            if not isinstance(verified_versions, list):
                verified_versions = []
            
            # 如果指定了当前版本，检查是否已对该版本记录过 PASS
            if current_version and current_version in verified_versions:
                logger.debug("问题 %s 已对版本 %s 记录过 PASS，跳过", jira_key, current_version)
                continue
            
            # 已经达到 2 次 PASS 且已关单的跳过
            pass_count = record.get("regression_pass_count") or 0
            if pass_count >= 2:
                continue
            
            # 记录当前版本到已验证列表
            if current_version:
                verified_versions.append(current_version)
            # 去重保留顺序
            seen_versions: List[str] = []
            for ver in verified_versions:
                if ver and ver not in seen_versions:
                    seen_versions.append(ver)
            versions_text = ", ".join(seen_versions) or "未知版本"
            required_cycles = self.regression_manager.required_cycles
            
            # 根据 PASS 次数决定操作
            if pass_count == 0:
                comment = (
                    f"已回归验证1个版本PASS，已测试的版本:\n"
                    f"{versions_text} (MONKEYAEE)\n\n"
                    f"MONKEYAEE 类型的问题要求在 {required_cycles} 轮测试未复现后才能关闭."
                )
                self._add_comment(jira_key, comment)
                new_count = 1
                new_status = record.get("status")
                logger.info("问题 %s 第1次回归PASS (版本: %s)", jira_key, current_version or "未知")
            else:
                comment = (
                    f"已回归验证2个版本PASS，已测试的版本:\n"
                    f"{versions_text} (MONKEYAEE)\n\n"
                    f"MONKEYAEE 类型的问题要求在 {required_cycles} 轮测试未复现后才能关闭."
                )
                self._add_comment(jira_key, comment)
                new_count = 2
                # 第二次 PASS 后关单
                if not self.dry_run:
                    try:
                        self.jira_sync.transition_issue(jira_key, "Closed")
                        new_status = "Closed"
                        closed_count += 1
                        logger.info("问题 %s 第2次回归PASS，已关单 (版本: %s)", jira_key, current_version or "未知")
                    except Exception as exc:  # pragma: no cover
                        logger.warning("关闭问题 %s 失败: %s", jira_key, exc)
                        new_status = record.get("status")
                else:
                    new_status = "Closed"
                    closed_count += 1
                    logger.info("[DRY-RUN] 问题 %s 第2次回归PASS，模拟关单", jira_key)
            
            # 更新数据库记录
            update_data = {
                "regression_pass_count": new_count,
                "verified_versions": json.dumps(verified_versions),
            }
            if new_status:
                update_data["status"] = new_status
            self.db.update_main_table_record(jira_key, update_data)
        
        return closed_count
