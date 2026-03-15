#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
DataNormalizer
--------------

把 Excel 原始数据转换为统一的、易于决策引擎消费的结构。主要工作：
1. 生成规范化 Summary / Description
2. 根据异常类型 & 次数套用问题等级规则
3. 提供测试环境、关键信息等统一字段
"""

from __future__ import annotations

import logging
import os
import re
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

import pandas as pd

from .jira_issue_template import (
    build_description,
    build_environment,
    build_ps,
    build_summary,
    map_severity_to_priority,
)

logger = logging.getLogger(__name__)


@dataclass
class SeverityRule:
    level: str
    keyword: str
    operator: str
    threshold: int

    def matches(self, record: Dict[str, Any]) -> bool:
        text = " ".join(
            filter(
                None,
                [
                    str(record.get("exp_class", "")),
                    str(record.get("exp_type", "")),
                    str(record.get("detail", "")),
                ],
            )
        ).lower()
        if self.keyword.lower() not in text:
            return False

        count = int(record.get("count") or 0)
        if self.operator == ">=":
            return count >= self.threshold
        if self.operator == ">":
            return count > self.threshold
        if self.operator == "<=":
            return count <= self.threshold
        if self.operator == "<":
            return count < self.threshold
        if self.operator == "=":
            return count == self.threshold
        return True


class SeverityEngine:
    """根据配置表判定问题等级。"""

    COUNT_PATTERN = re.compile(r"(>=|<=|>|<|=)\s*(\d+)")

    def __init__(self, rules_path: Optional[str] = None):
        repo_root = Path(__file__).resolve().parents[2]
        self.rules_path = Path(rules_path) if rules_path else repo_root / "config" / "问题等级定级表.xls"
        self.rules: List[SeverityRule] = []
        self._load_rules()

    def _load_rules(self) -> None:
        if not self.rules_path.exists():
            logger.warning("问题等级定级表缺失: %s", self.rules_path)
            self.rules = []
            return
        df = pd.read_excel(self.rules_path)
        rules: List[SeverityRule] = []
        for _, row in df.iterrows():
            level = str(row.get("问题等级") or "").strip()
            keyword = str(row.get("报错类型") or "").strip()
            requirement = str(row.get("次数要求") or "").strip()
            if not level or not keyword:
                continue
            operator, threshold = self._parse_requirement(requirement)
            rules.append(SeverityRule(level=level, keyword=keyword, operator=operator, threshold=threshold))
        self.rules = rules
        logger.info("加载问题等级规则 %d 条", len(rules))

    def evaluate(self, record: Dict[str, Any]) -> Tuple[str, str]:
        for rule in self.rules:
            if rule.matches(record):
                return rule.level, f"{rule.keyword} {rule.operator} {rule.threshold}"
        return "C", "default"

    def _parse_requirement(self, text: str) -> Tuple[str, int]:
        if not text:
            return ">=", 0
        match = self.COUNT_PATTERN.search(text)
        if match:
            return match.group(1), int(match.group(2))
        # 兼容 ">0次" 等写法
        digits = re.findall(r"\d+", text)
        if digits:
            return ">=", int(digits[0])
        return ">=", 0


class DataNormalizer:
    """将原始记录转换为业务字段。"""

    def __init__(self, severity_rules_path: Optional[str] = None):
        self.severity_engine = SeverityEngine(severity_rules_path)
        self.reporter = os.getenv("JIRA_REPORTER", "dailv.tinno")

    def batch_normalize(self, rows: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
        normalized = []
        for row in rows:
            try:
                normalized.append(self.normalize(row))
            except Exception:  # pragma: no cover - 防御性，详细日志供排查
                logger.exception("标准化失败 row=%s", row)
        return normalized

    def normalize(self, row: Dict[str, Any]) -> Dict[str, Any]:
        severity, reason = self.severity_engine.evaluate(row)
        package = row.get("package") or "unknown.package"
        exp_class = row.get("exp_class") or "Unknown"
        count = int(row.get("count") or 0)
        issue_context = {
            "package": package,
            "exp_class": exp_class,
            "exp_type": row.get("exp_type") or "Unknown",
            "cur_process": row.get("cur_process") or package,
            "version": row.get("version") or "UNKNOWN_VERSION",
            "detail": row.get("detail") or "",
            "path": row.get("path") or "",
            "count": count,
            "device_count": int(row.get("device_count") or 0),
            "key_information": row.get("caused_by") or "",
            "caused_by": row.get("caused_by") or "",
        }
        summary = build_summary(issue_context)
        environment = build_environment(issue_context)
        ps_content = build_ps(issue_context, reporter=self.reporter)
        priority = map_severity_to_priority(severity)

        normalized = {
            "package": package,
            "exp_class": issue_context["exp_class"],
            "exp_type": issue_context["exp_type"],
            "cur_process": issue_context["cur_process"],
            "version": issue_context["version"],
            "detail": issue_context["detail"],
            "caused_by": row.get("caused_by") or "",
            "count": count,
            "device_count": issue_context["device_count"],
            "normalized_summary": summary,
            "test_environment": environment,
            "bug_severity": severity,
            "severity_reason": reason,
            "jira_summary": summary,
            "jira_description": build_description(issue_context),
            "source_file": row.get("source_file") or row.get("path"),
            "row_number": row.get("row_number", 0),
            "priority": priority,
            "ps": ps_content,
            "path": issue_context["path"],
            "affect_project": row.get("affect_project") or "",
            "key_information": row.get("caused_by") or "",
        }
        return normalized
