#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
LarkIntegration
---------------

本模块并未调用真实的飞书 API，而是提供一个统一入口，负责：
1. 维护包名 → 模块 → 经办人的映射关系
2. 提供黑/白名单过滤
3. 为后续步骤生成组件映射日志
"""

from __future__ import annotations

import logging
from pathlib import Path
from typing import Dict, Iterable, List, Optional

import pandas as pd

logger = logging.getLogger(__name__)


class LarkIntegration:
    """封装包名与模块映射逻辑。"""

    def __init__(self, config: Optional[Dict[str, object]] = None):
        config = config or {}
        repo_root = Path(__file__).resolve().parents[2]
        self.mapping_path = Path(config.get("package_mapping_path") or (repo_root / "config" / "包名与模块&经办人对应表.xls"))
        self.blacklist = set(config.get("package_blacklist", []) or [])
        self.whitelist = set(config.get("package_whitelist", []) or [])
        self._package_to_module: Dict[str, str] = {}
        self._module_to_assignee: Dict[str, str] = {}
        self._load_mapping()

    # ------------------------------------------------------------------
    # 基本操作
    # ------------------------------------------------------------------
    def _load_mapping(self) -> None:
        if not self.mapping_path.exists():
            logger.warning("包名映射表不存在: %s", self.mapping_path)
            return
        df = pd.read_excel(self.mapping_path)
        for _, row in df.iterrows():
            package = str(row.get("包名") or "").strip()
            module = str(row.get("模块") or "").strip() or package
            assignee = str(row.get("经办人") or "").strip() or ""
            if not package:
                continue
            self._package_to_module[package] = module
            if assignee:
                self._module_to_assignee.setdefault(module, assignee)
        logger.info("包名映射加载完成，记录数=%d", len(self._package_to_module))

    # ------------------------------------------------------------------
    # 对外方法
    # ------------------------------------------------------------------
    def filter_by_blacklist(self, packages: Iterable[str]) -> List[str]:
        packages = list(packages)
        if not self.blacklist:
            return packages
        filtered = [pkg for pkg in packages if pkg not in self.blacklist]
        logger.debug("黑名单过滤: %d -> %d", len(packages), len(filtered))
        return filtered

    def filter_by_whitelist(self, packages: Iterable[str]) -> List[str]:
        packages = list(packages)
        if not self.whitelist:
            return packages
        filtered = [pkg for pkg in packages if pkg in self.whitelist]
        logger.debug("白名单过滤: %d -> %d", len(packages), len(filtered))
        return filtered

    def get_module_by_package(self, package: str) -> str:
        return self._package_to_module.get(package, package)

    def get_assignee_by_module(self, module: str) -> Optional[str]:
        return self._module_to_assignee.get(module)

    def resolve_package(self, package: str) -> Dict[str, Optional[str]]:
        module = self.get_module_by_package(package)
        return {
            "module": module,
            "assignee": self.get_assignee_by_module(module),
        }

    def build_component_mapping(self, packages: Iterable[str]) -> Dict[str, List[str]]:
        """生成包名到模块的映射日志，便于对齐 Jenkins 输出。"""
        mapping: Dict[str, List[str]] = {}
        for package in packages:
            module = self.get_module_by_package(package)
            mapping.setdefault(module, []).append(package)
        for module, pkgs in mapping.items():
            logger.info("组件映射 %s <- %s", module, pkgs)
        return mapping
