#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
ExcelParser
-----------

负责读取 Monkey 测试导出的 Excel/CSV 文件，并将其转换为统一的字典列表，
以便后续的数据标准化、映射和判重逻辑使用。该模块仅承担“数据加载”职责，
不会修改任何字段含义。
"""

from __future__ import annotations

import logging
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Dict, Iterable, List, Optional

import pandas as pd

logger = logging.getLogger(__name__)


@dataclass
class ParsedRecord:
    """表示自 Excel 解析出的单行原始数据。"""

    row_number: int
    data: Dict[str, Any]


class ExcelParser:
    """Monkey 结果清单解析器。"""

    COLUMN_MAPPING = {
        "Id": "id",
        "Path": "path",
        "Version": "version",
        "AffectProject": "affect_project",
        "ExpTime": "exp_time",
        "ExpClass": "exp_class",
        "ExpType ": "exp_type",  # 某些导出文件带空格
        "ExpType": "exp_type",
        "CurProcess": "cur_process",
        "Package": "package",
        "Detail": "detail",
        "CausedBy": "caused_by",
        "extraTag": "extra_tag",
        "Count": "count",
        "DeviceCount": "device_count",
    }

    REQUIRED_COLUMNS = {"Version", "ExpClass", "Package", "Detail", "CausedBy"}

    def __init__(self, encoding: str = "utf-8"):
        self.encoding = encoding

    # ------------------------------------------------------------------
    # 对外接口
    # ------------------------------------------------------------------
    def parse_excel(self, excel_path: str) -> List[Dict[str, Any]]:
        """
        解析 Excel 文件并返回字典列表。

        Args:
            excel_path: Excel/xls/xlsx/csv 路径
        """
        path = Path(excel_path)
        if not path.exists():
            raise FileNotFoundError(f"Excel 文件不存在: {path}")

        dataframe = self._load_dataframe(path)
        self._validate_columns(path, dataframe.columns)
        dataframe["__source_file__"] = path.name

        parsed: List[Dict[str, Any]] = []
        for idx, row in dataframe.iterrows():
            normalized = self._normalize_row(
                row.to_dict(),
                row_number=idx + 2,  # +2 对齐 Excel 行号
            )
            parsed.append(normalized)

        logger.info("Excel解析完成: file=%s rows=%d", path.name, len(parsed))
        self._log_basic_stats(parsed)
        return parsed

    # ------------------------------------------------------------------
    # 内部工具
    # ------------------------------------------------------------------
    def _load_dataframe(self, path: Path) -> pd.DataFrame:
        suffix = path.suffix.lower()
        if suffix == ".csv":
            return pd.read_csv(path, encoding=self.encoding)
        if suffix in {".xls", ".xlsx"}:
            engine = "openpyxl" if suffix == ".xlsx" else "xlrd"
            return pd.read_excel(path, engine=engine)
        # 默认尝试 Excel
        try:
            return pd.read_excel(path, engine="openpyxl")
        except Exception:
            return pd.read_excel(path, engine="xlrd")

    def _validate_columns(self, path: Path, columns: Iterable[str]) -> None:
        column_set = set(columns)
        missing = self.REQUIRED_COLUMNS - column_set
        if missing:
            raise ValueError(f"{path.name} 缺少必填列: {sorted(missing)}")

    def _normalize_row(self, row: Dict[str, Any], row_number: int) -> Dict[str, Any]:
        normalized: Dict[str, Any] = {
            "row_number": row_number,
        }

        for raw_key, normalized_key in self.COLUMN_MAPPING.items():
            value = row.get(raw_key)
            if pd.isna(value):
                value = None
            if isinstance(value, str):
                value = value.strip()
            normalized[normalized_key] = value

        normalized["count"] = self._to_int(normalized.get("count"))
        normalized["device_count"] = self._to_int(normalized.get("device_count"))
        normalized["package"] = normalized.get("package") or "unknown.package"
        normalized["exp_class"] = normalized.get("exp_class") or "Unknown"
        normalized["exp_type"] = normalized.get("exp_type") or "Unknown"
        normalized["cur_process"] = normalized.get("cur_process") or normalized["package"]
        normalized["version"] = normalized.get("version") or "UNKNOWN_VERSION"
        normalized["detail"] = normalized.get("detail") or ""
        normalized["caused_by"] = normalized.get("caused_by") or ""
        normalized["extra_tag"] = normalized.get("extra_tag") or ""
        normalized["path"] = normalized.get("path") or ""
        normalized["exp_time"] = normalized.get("exp_time") or ""
        normalized["source_file"] = row.get("__source_file__", "")
        return normalized

    @staticmethod
    def _to_int(value: Any) -> int:
        if value in (None, "", "nan"):
            return 0
        try:
            return int(float(value))
        except (TypeError, ValueError):
            return 0

    def _log_basic_stats(self, rows: List[Dict[str, Any]]) -> None:
        if not rows:
            return
        package_counter: Dict[str, int] = {}
        class_counter: Dict[str, int] = {}

        for item in rows:
            package_counter[item["package"]] = package_counter.get(item["package"], 0) + 1
            class_counter[item["exp_class"]] = class_counter.get(item["exp_class"], 0) + 1

        top_packages = sorted(package_counter.items(), key=lambda kv: kv[1], reverse=True)[:5]
        top_classes = sorted(class_counter.items(), key=lambda kv: kv[1], reverse=True)[:5]
        logger.info("Top包名: %s", ", ".join(f"{pkg}:{cnt}" for pkg, cnt in top_packages))
        logger.info("Top异常类型: %s", ", ".join(f"{cls}:{cnt}" for cls, cnt in top_classes))
