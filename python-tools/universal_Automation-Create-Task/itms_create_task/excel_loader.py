# -*- coding: utf-8 -*-
"""
Excel/CSV 表单数据读取。
"""

import csv
import json
from datetime import date, datetime
from pathlib import Path
from typing import Any, Dict, List, Optional

from openpyxl import load_workbook


FIELD_ALIASES = {
    "项目名": "project_name",
    "项目名称": "project_name",
    "project": "project_name",
    "project_name": "project_name",
    "主计划": "main_plan_name",
    "主计划名": "main_plan_name",
    "主计划名称": "main_plan_name",
    "main_plan_name": "main_plan_name",
    "组件": "testsuite_component_name",
    "测试组件": "testsuite_component_name",
    "模块": "testsuite_component_name",
    "testsuite_component_name": "testsuite_component_name",
    "任务类型": "task_type",
    "task_type": "task_type",
    "任务子类型": "task_sub_type",
    "测试子类型": "task_sub_type",
    "task_sub_type": "task_sub_type",
    "子计划名称": "sub_plan_name",
    "子计划名": "sub_plan_name",
    "sub_plan_name": "sub_plan_name",
    "owner": "owner_name",
    "owner_name": "owner_name",
    "负责人": "owner_name",
    "开始日期": "start_date",
    "开始时间": "start_time",
    "start_date": "start_date",
    "start_time": "start_time",
    "结束日期": "end_date",
    "结束时间": "end_time",
    "end_date": "end_date",
    "end_time": "end_time",
    "备注": "remark",
    "remark": "remark",
    "项目版本": "project_version",
    "project_version": "project_version",
    "样机标签": "project_label",
    "标签": "project_label",
    "project_label": "project_label",
    "样机阶段": "prototype_stage",
    "prototype_stage": "prototype_stage",
    "样机数量": "prototype_num",
    "prototype_num": "prototype_num",
}


def load_form_rows(file_path: str, sheet_name: Optional[str] = None, header_row: int = 1) -> List[Dict[str, Any]]:
    """读取 Excel 或 CSV 中的多行表单数据。"""
    path = Path(file_path)
    suffix = path.suffix.lower()

    if suffix in (".xlsx", ".xlsm"):
        return _load_excel_rows(path, sheet_name=sheet_name, header_row=header_row)
    if suffix == ".csv":
        return _load_csv_rows(path)

    raise ValueError("暂不支持的文件类型: %s" % suffix)


def _load_excel_rows(path: Path, sheet_name: Optional[str], header_row: int) -> List[Dict[str, Any]]:
    """读取 Excel。"""
    workbook = load_workbook(filename=str(path), read_only=True, data_only=True)
    if sheet_name:
        if sheet_name not in workbook.sheetnames:
            raise ValueError("未找到工作表: %s" % sheet_name)
        sheet = workbook[sheet_name]
    else:
        sheet = workbook[workbook.sheetnames[0]]

    rows = list(sheet.iter_rows(values_only=True))
    if len(rows) < header_row:
        return []

    headers = [_normalize_header(item) for item in rows[header_row - 1]]
    results: List[Dict[str, Any]] = []

    for row in rows[header_row:]:
        item: Dict[str, Any] = {}
        has_value = False
        for index, header in enumerate(headers):
            if not header:
                continue
            value = row[index] if index < len(row) else None
            normalized = _normalize_value(value)
            if normalized not in (None, ""):
                has_value = True
            item[header] = normalized
        if has_value:
            results.append(_drop_empty_values(item))

    return results


def _load_csv_rows(path: Path) -> List[Dict[str, Any]]:
    """读取 CSV。"""
    results: List[Dict[str, Any]] = []
    with open(path, "r", encoding="utf-8-sig", newline="") as file_obj:
        reader = csv.DictReader(file_obj)
        for row in reader:
            item = {}
            has_value = False
            for key, value in row.items():
                header = _normalize_header(key)
                if not header:
                    continue
                normalized = _normalize_value(value)
                if normalized not in (None, ""):
                    has_value = True
                item[header] = normalized
            if has_value:
                results.append(_drop_empty_values(item))
    return results


def _normalize_header(value: Any) -> Optional[str]:
    """标准化表头。"""
    if value is None:
        return None
    text = str(value).strip()
    if not text:
        return None
    return FIELD_ALIASES.get(text, FIELD_ALIASES.get(text.lower(), text))


def _normalize_value(value: Any) -> Any:
    """标准化单元格值。"""
    if value is None:
        return None
    if isinstance(value, datetime):
        if value.hour == 0 and value.minute == 0 and value.second == 0:
            return value.strftime("%Y-%m-%d")
        return value.strftime("%Y-%m-%d %H:%M:%S")
    if isinstance(value, date):
        return value.strftime("%Y-%m-%d")
    if isinstance(value, bool):
        return value
    if isinstance(value, (int, float)):
        if isinstance(value, float) and value.is_integer():
            return int(value)
        return value

    text = str(value).strip()
    if not text:
        return None

    if text.startswith("{") or text.startswith("["):
        try:
            return json.loads(text)
        except json.JSONDecodeError:
            return text
    return text


def _drop_empty_values(item: Dict[str, Any]) -> Dict[str, Any]:
    """删除空值字段。"""
    return {key: value for key, value in item.items() if value not in (None, "")}
