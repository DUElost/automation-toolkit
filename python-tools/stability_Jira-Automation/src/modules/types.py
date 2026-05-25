#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
类型定义模块
------------

定义系统中使用的数据结构，提升代码可读性和类型安全。
"""

from __future__ import annotations

from dataclasses import dataclass, field
from typing import Any, Dict, List, Optional, TypedDict


class PendingIssueDict(TypedDict, total=False):
    """待处理问题数据结构"""
    id: int
    action: str
    similarity_score: Optional[float]
    match_type: Optional[str]
    matched_jira_key: Optional[str]
    package_name: str
    module: Optional[str]
    affect_project: Optional[str]
    key_information: Optional[str]
    exp_class: Optional[str]
    exp_type: Optional[str]
    cur_process: Optional[str]
    version: Optional[str]
    detail: str
    caused_by: str
    count: int
    device_count: int
    normalized_summary: str
    test_environment: str
    bug_severity: str
    priority: Optional[str]
    assignee: Optional[str]
    jira_summary: Optional[str]
    jira_description: Optional[str]
    ps: Optional[str]
    source_file: Optional[str]
    row_number: Optional[int]
    raw_data: Optional[Dict[str, Any]]


class JiraIssueDict(TypedDict, total=False):
    """JIRA 问题数据结构"""
    id: int
    jira_key: str
    status: str
    summary: str
    normalized_summary: str
    test_environment: str
    raw_caused_by: str
    assignee: Optional[str]
    bug_severity: str
    priority: str
    description: Optional[str]
    package_name: str
    exp_class: Optional[str]
    exp_type: Optional[str]
    cur_process: Optional[str]
    version: Optional[str]
    count: int
    device_count: int
    source_file: Optional[str]
    raw_data: Optional[Dict[str, Any]]
    fix_version: Optional[str]
    build_version: Optional[str]
    regression_pass_count: int
    verified_versions: Optional[str]


class ExecutionStatsDict(TypedDict):
    """执行统计数据结构"""
    processed: int
    created: int
    updated: int
    failed: int
    regression_closed: int


class ProcessResultDict(TypedDict):
    """处理结果数据结构"""
    success: bool
    processed_count: int
    success_count: int
    error_count: int
    regression_closed: List[str]
    errors: List[str]
    error: Optional[str]


@dataclass
class RetryConfig:
    """重试配置"""
    max_attempts: int = 3
    base_delay: float = 1.0
    max_delay: float = 30.0
    exponential_base: float = 2.0


@dataclass
class SimilarityThresholds:
    """相似度阈值配置"""
    env_threshold: float = 0.99
    cause_threshold: float = 0.90
    summary_threshold: float = 0.85
    
    @classmethod
    def from_dict(cls, data: Dict[str, Any]) -> "SimilarityThresholds":
        return cls(
            env_threshold=float(data.get("env_threshold", 0.99)),
            cause_threshold=float(data.get("cause_threshold", 0.90)),
            summary_threshold=float(data.get("summary_threshold", 0.85)),
        )


@dataclass
class ExecutorConfig:
    """执行器配置"""
    dry_run: bool = False
    max_workers: int = 3
    batch_size: int = 10
    retry_config: RetryConfig = field(default_factory=RetryConfig)
    regression_cycles: int = 2
    affect_project: Optional[str] = None
    
    @classmethod
    def from_dict(cls, data: Dict[str, Any]) -> "ExecutorConfig":
        retry_data = data.get("retry", {})
        return cls(
            dry_run=bool(data.get("dry_run", False)),
            max_workers=int(data.get("max_workers", 3)),
            batch_size=int(data.get("batch_size", 10)),
            retry_config=RetryConfig(
                max_attempts=int(retry_data.get("max_attempts", 3)),
                base_delay=float(retry_data.get("base_delay", 1.0)),
                max_delay=float(retry_data.get("max_delay", 30.0)),
            ),
            regression_cycles=int(data.get("regression_cycles", 2)),
            affect_project=data.get("affect_project"),
        )
