#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""版本号解析与比较工具。"""

from __future__ import annotations

from dataclasses import dataclass
import re
from typing import Iterable, List, Optional, Tuple

_VERSION_PATTERN = re.compile(r"\d+")
# 匹配 V551A-15-250730V29 格式中的时间戳部分 (YYMMDD)
_TIMESTAMP_PATTERN = re.compile(r"(\d{6})V?\d*$")
# 备用：匹配任意 6 位以上数字
_FALLBACK_TIMESTAMP_PATTERN = re.compile(r"(\d{6,})")


def _extract_version_timestamp(version: str | None) -> Optional[int]:
    """
    从版本号中提取时间戳。
    
    支持格式：
    - V551A-15-250730V29 → 提取 250730
    - V551A-15-250811V35 → 提取 250811
    """
    if not version:
        return None
    version_str = str(version)
    
    # 优先匹配末尾的 YYMMDD 格式 (如 250730V29 中的 250730)
    match = _TIMESTAMP_PATTERN.search(version_str)
    if match:
        return int(match.group(1))
    
    # 备用：查找所有 6 位以上数字，取最后一个
    matches = _FALLBACK_TIMESTAMP_PATTERN.findall(version_str)
    if matches:
        # 取最后一个匹配的前 6 位作为时间戳
        last_match = matches[-1]
        return int(last_match[:6])
    
    return None


def _parse_version_numbers(version: str | None) -> List[int]:
    if not version:
        return []
    return [int(part) for part in _VERSION_PATTERN.findall(str(version))]


def compare_versions(a: str | None, b: str | None) -> int:
    """
    比较版本号；返回 1 表示 a>b，0 表示相等，-1 表示 a<b。
    
    优先使用时间戳比较（针对 V551A-15-250730V29 格式），
    时间戳无法提取时回退到数字序列比较。
    """
    # 优先使用时间戳比较
    ts_a = _extract_version_timestamp(a)
    ts_b = _extract_version_timestamp(b)
    
    if ts_a is not None and ts_b is not None:
        if ts_a > ts_b:
            return 1
        if ts_a < ts_b:
            return -1
        return 0
    
    # 回退到数字序列比较
    nums_a = _parse_version_numbers(a)
    nums_b = _parse_version_numbers(b)
    for x, y in zip(nums_a, nums_b):
        if x > y:
            return 1
        if x < y:
            return -1
    if len(nums_a) > len(nums_b):
        return 1 if any(n > 0 for n in nums_a[len(nums_b):]) else 0
    if len(nums_a) < len(nums_b):
        return -1 if any(n > 0 for n in nums_b[len(nums_a):]) else 0
    return 0


class VersionOutcome:
    IS_NEWER_OR_EQUAL = "IS_NEWER_OR_EQUAL"
    IS_OLDER = "IS_OLDER"


@dataclass
class VersionComparisonResult:
    """版本比较结果，提供可读的原因与回退标记。"""

    outcome: str
    current_timestamp: Optional[int]
    fix_timestamp: Optional[int]
    reason: str
    fallback_used: bool = False

    @property
    def is_newer_or_equal(self) -> bool:
        return self.outcome == VersionOutcome.IS_NEWER_OR_EQUAL


class VersionComparator:
    """
    独立的“黑盒”版本比较器。

    根据版本号中的时间戳/构建号进行比对，解析失败时默认按复现处理，
    以避免漏判复现问题。
    """

    def __init__(self, fallback_outcome: str = VersionOutcome.IS_NEWER_OR_EQUAL):
        self.fallback_outcome = fallback_outcome

    def compare(self, current_version: Optional[str], fix_version: Optional[str]) -> VersionComparisonResult:
        """
        返回 IS_NEWER_OR_EQUAL (复现) 或 IS_OLDER (历史遗留)。
        """
        try:
            current_ts = self._extract_timestamp(current_version)
            fix_ts = self._extract_timestamp(fix_version)
            if current_ts is not None and fix_ts is not None:
                outcome = (
                    VersionOutcome.IS_NEWER_OR_EQUAL
                    if current_ts >= fix_ts
                    else VersionOutcome.IS_OLDER
                )
                return VersionComparisonResult(
                    outcome=outcome,
                    current_timestamp=current_ts,
                    fix_timestamp=fix_ts,
                    reason="timestamp-compare",
                )

            # 回退到数字切分对比，保持向后兼容
            basic_compare = compare_versions(current_version, fix_version)
            outcome = (
                VersionOutcome.IS_NEWER_OR_EQUAL if basic_compare >= 0 else VersionOutcome.IS_OLDER
            )
            return VersionComparisonResult(
                outcome=outcome,
                current_timestamp=current_ts,
                fix_timestamp=fix_ts,
                reason="fallback-numeric-compare",
                fallback_used=True,
            )
        except Exception as exc:  # pragma: no cover - 防御性兜底
            return VersionComparisonResult(
                outcome=self.fallback_outcome,
                current_timestamp=None,
                fix_timestamp=None,
                reason=f"fallback-error:{exc}",
                fallback_used=True,
            )

    def latest(self, versions: Iterable[Optional[str]]) -> Optional[str]:
        """
        在一组版本字符串中挑选“最新”（时间戳/构建号最大）的版本。
        """
        latest_version: Optional[str] = None
        for version in versions:
            if not version:
                continue
            if latest_version is None:
                latest_version = version
                continue
            result = self.compare(version, latest_version)
            if result.is_newer_or_equal:
                latest_version = version
        return latest_version

    @staticmethod
    def _extract_timestamp(version: Optional[str]) -> Optional[int]:
        """使用模块级函数提取时间戳。"""
        return _extract_version_timestamp(version)
