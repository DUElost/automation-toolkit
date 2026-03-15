#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
DecisionEngine
--------------

根据数据库中已有的问题记录，结合环境相似度与根因相似度，决定待处理
问题应走「新建」还是「复用/更新」流程。

优化点：
1. 堆栈签名提取，去除行号和内存地址噪声
2. LRU 缓存替代手动缓存管理
3. 批量预加载候选问题
"""

from __future__ import annotations

import logging
import re
from dataclasses import dataclass
from difflib import SequenceMatcher
from functools import lru_cache
from typing import Any, Dict, List, Optional, Tuple

from .database_manager import DatabaseManager

logger = logging.getLogger(__name__)

# 用于清理堆栈信息中的噪声
_LINE_NUMBER_PATTERN = re.compile(r":\d+")
_MEMORY_ADDRESS_PATTERN = re.compile(r"0x[0-9a-fA-F]+")
_THREAD_ID_PATTERN = re.compile(r"Thread-\d+|thread \d+", re.IGNORECASE)


@dataclass
class DecisionResult:
    """决策结果"""
    action: str
    matched_key: Optional[str]
    similarity_score: float
    environment_similarity: float
    cause_similarity: float
    reason: str


def _extract_stack_signature(stack_trace: str) -> str:
    """
    从堆栈信息中提取签名，去除行号、内存地址等噪声。
    
    这样可以更准确地匹配相同根因的问题，即使行号有变化。
    """
    if not stack_trace:
        return ""
    
    signature = str(stack_trace)
    # 移除行号 (如 :123)
    signature = _LINE_NUMBER_PATTERN.sub("", signature)
    # 移除内存地址 (如 0x7fff5fbff8c0)
    signature = _MEMORY_ADDRESS_PATTERN.sub("", signature)
    # 移除线程 ID
    signature = _THREAD_ID_PATTERN.sub("", signature)
    # 压缩空白
    signature = " ".join(signature.split())
    
    return signature


class DecisionEngine:
    """
    相似度判重 + 动作决策。
    
    优化：
    - 使用堆栈签名提取提高匹配准确性
    - LRU 缓存提升重复查询性能
    - 支持批量预加载候选问题
    """

    # 缓存大小
    CACHE_SIZE = 512

    def __init__(self, db: DatabaseManager, config: Optional[Dict[str, Any]] = None):
        self.db = db
        self.config = config or {}
        thresholds = self.config.get("thresholds") or {}
        self.env_threshold = float(thresholds.get("env_threshold") or self.db.get_config("env_threshold") or 0.99)
        self.cause_threshold = float(thresholds.get("cause_threshold") or self.db.get_config("cause_threshold") or 0.90)
        self.summary_threshold = float(thresholds.get("summary_threshold") or self.db.get_config("summary_threshold") or 0.85)
        self.cache_enabled = bool(self.config.get("cache_enabled"))
        
        # 使用 LRU 缓存
        if self.cache_enabled:
            self._decide_cached = lru_cache(maxsize=self.CACHE_SIZE)(self._decide_impl)
        
        # 批量预加载的候选问题缓存
        self._candidates_cache: Dict[str, List[Dict[str, Any]]] = {}

    # ------------------------------------------------------------------
    # 公开接口
    # ------------------------------------------------------------------
    def decide(self, pending_issue: Dict[str, Any]) -> DecisionResult:
        """
        决定待处理问题的动作（CREATE 或 UPDATE）。
        
        Args:
            pending_issue: 待处理问题数据
            
        Returns:
            DecisionResult 包含动作和匹配信息
        """
        if self.cache_enabled:
            cache_key = (
                pending_issue.get("normalized_summary", ""),
                pending_issue.get("caused_by", ""),
            )
            return self._decide_cached(cache_key, self._freeze_issue(pending_issue))
        return self._decide_impl_direct(pending_issue)
    
    def preload_candidates(self, packages: List[str]) -> None:
        """
        批量预加载候选问题，减少数据库查询次数。
        
        Args:
            packages: 包名列表
        """
        unique_packages = list(set(p for p in packages if p))
        if not unique_packages:
            return
        
        # 批量查询
        candidates = self.db.batch_fetch_issues_by_packages(unique_packages)
        self._candidates_cache.update(candidates)
        logger.info("预加载 %d 个包的候选问题", len(unique_packages))
    
    def clear_cache(self) -> None:
        """清除所有缓存。"""
        self._candidates_cache.clear()
        if self.cache_enabled and hasattr(self, '_decide_cached'):
            self._decide_cached.cache_clear()

    # ------------------------------------------------------------------
    # 内部实现
    # ------------------------------------------------------------------
    @staticmethod
    def _freeze_issue(issue: Dict[str, Any]) -> Tuple:
        """将问题字典转换为可哈希的元组，用于缓存键。"""
        return (
            issue.get("package_name") or issue.get("package", ""),
            issue.get("normalized_summary", ""),
            issue.get("caused_by", ""),
            issue.get("test_environment", ""),
        )
    
    def _decide_impl(self, cache_key: Tuple[str, str], frozen_issue: Tuple) -> DecisionResult:
        """带缓存的决策实现。"""
        package, normalized_summary, caused_by, test_environment = frozen_issue
        issue = {
            "package_name": package,
            "normalized_summary": normalized_summary,
            "caused_by": caused_by,
            "test_environment": test_environment,
        }
        return self._decide_impl_direct(issue)
    
    def _decide_impl_direct(self, pending_issue: Dict[str, Any]) -> DecisionResult:
        """直接决策实现（无缓存）。"""
        package = pending_issue.get("package_name") or pending_issue.get("package")
        
        # 优先使用预加载的缓存
        if package in self._candidates_cache:
            candidates = self._candidates_cache[package]
        else:
            candidates = self.db.fetch_issues_by_package(package)
        
        if not candidates:
            result = DecisionResult("CREATE", None, 0.0, 0.0, 0.0, "no-candidate")
            self._log_decision(result, package)
            return result

        # 提取待处理问题的签名
        pending_env = pending_issue.get("test_environment", "")
        pending_cause = pending_issue.get("caused_by", "")
        pending_summary = pending_issue.get("normalized_summary", "")
        pending_cause_sig = _extract_stack_signature(pending_cause)

        best_candidate = None
        best_score = -1.0
        best_env = 0.0
        best_cause = 0.0
        
        for candidate in candidates:
            # 环境相似度
            env_score = self._similarity(pending_env, candidate.get("test_environment", ""))
            
            # 根因相似度（使用签名提取）
            candidate_cause = candidate.get("raw_caused_by", "")
            candidate_cause_sig = _extract_stack_signature(candidate_cause)
            cause_score = self._similarity(pending_cause_sig, candidate_cause_sig)
            
            # 概要相似度
            summary_score = self._similarity(pending_summary, candidate.get("normalized_summary", ""))
            
            # 加权聚合（根因权重更高）
            aggregated = (env_score * 0.25 + cause_score * 0.5 + summary_score * 0.25)
            
            if aggregated > best_score:
                best_score = aggregated
                best_candidate = candidate
                best_env = env_score
                best_cause = cause_score

        # 判断是否满足阈值
        if (
            best_candidate
            and best_env >= self.env_threshold
            and best_cause >= self.cause_threshold
            and best_score >= self.summary_threshold
        ):
            result = DecisionResult(
                action="UPDATE",
                matched_key=best_candidate["jira_key"],
                similarity_score=best_score,
                environment_similarity=best_env,
                cause_similarity=best_cause,
                reason="similarity_pass",
            )
        else:
            result = DecisionResult(
                action="CREATE",
                matched_key=None,
                similarity_score=best_score if best_candidate else 0.0,
                environment_similarity=best_env,
                cause_similarity=best_cause,
                reason="below_threshold",
            )

        self._log_decision(result, package)
        return result
    
    def _log_decision(self, result: DecisionResult, package: str) -> None:
        """记录决策日志。"""
        logger.info(
            "Decision %s env=%.3f cause=%.3f score=%.3f package=%s matched=%s",
            result.action,
            result.environment_similarity,
            result.cause_similarity,
            result.similarity_score,
            package,
            result.matched_key,
        )

    @staticmethod
    def _similarity(a: str, b: str) -> float:
        """
        计算两个字符串的相似度。
        
        使用 SequenceMatcher，对于精确匹配有快速路径。
        """
        if not a or not b:
            return 0.0
        
        str_a = str(a)
        str_b = str(b)
        
        # 精确匹配快速路径
        if str_a == str_b:
            return 1.0
        
        return SequenceMatcher(None, str_a, str_b).ratio()
