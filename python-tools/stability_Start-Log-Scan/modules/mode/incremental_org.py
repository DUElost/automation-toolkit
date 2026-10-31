# -*- coding: utf-8 -*-
"""相对上次 _org.xls，按 Path 差集做增量过滤。"""
import os
import re

from modules.common.Excel import AeeExcelData, read_aee_rlt_excel

# Result_..._MonkeyAEE_SH_YYYYMMDD_HHMMSS_org.xls
# Result_..._MonkeyAEE_SH_YYYYMMDD_HHMMSS_HHMMSS_org.xls（文件锁定时的额外时间戳）
_ORG_TS_PATTERN = re.compile(
    r"_(\d{8})_(\d{6})(?:_\d{6})?_org\.xls$", re.IGNORECASE)

_DISCARD_VERSIONS = frozenset({
    "discard_dbg_version",
    "discard_ota_ke_dbg_version",
    "discard_db_file_map_exception",
})


def find_latest_org_excel(result_dir):
    """在结果目录中找时间戳最新的 *_org.xls；找不到返回 None。"""
    if not result_dir or not os.path.isdir(result_dir):
        return None
    candidates = []
    for name in os.listdir(result_dir):
        if not name.lower().endswith("_org.xls"):
            continue
        match = _ORG_TS_PATTERN.search(name)
        if not match:
            continue
        ts_key = match.group(1) + match.group(2)
        # 有额外时间戳时用完整文件名排序，保证同秒冲突时仍可比较
        candidates.append((ts_key, name, os.path.join(result_dir, name)))
    if not candidates:
        return None
    candidates.sort(key=lambda item: (item[0], item[1]))
    return candidates[-1][2]


def load_org_paths(org_excel_path):
    """读取 _org.xls 中的 Path 集合。"""
    path_set = set()
    for aee_data in read_aee_rlt_excel(org_excel_path):
        attrs = aee_data.get_aee_attrs()
        if attrs and attrs[0] not in (None, ""):
            path_set.add(str(attrs[0]))
    return path_set


def is_discard_org_row(attrs):
    if not attrs or len(attrs) < 2:
        return False
    return attrs[1] in _DISCARD_VERSIONS


def filter_org_rows_by_new_paths(org_list, prev_paths, exclude_discard=True):
    """保留 Path 不在 prev_paths 中的 org 行；默认排除 discard 行。"""
    prev_paths = prev_paths or set()
    delta = []
    for row in org_list or []:
        if not row:
            continue
        if exclude_discard and is_discard_org_row(row):
            continue
        path = str(row[0]) if row[0] is not None else ""
        if path and path not in prev_paths:
            delta.append(row)
    return delta


def attrs_to_aee_excel_data(attrs):
    """将 org 行 attrs 转成可再次走 _aee_to_data_list 的对象。"""
    return AeeExcelData(
        attrs[0],
        attrs[1],
        attrs[2],
        attrs[3],
        attrs[4],
        attrs[5],
        attrs[6],
        attrs[7],
        attrs[8],
        attrs[9] if len(attrs) > 9 else "",
        attrs[11] if len(attrs) > 11 else None,
        count=(attrs[10] if len(attrs) > 10 else 1),
        device_id=(attrs[12] if len(attrs) > 12 else None),
        rom_ram=(attrs[14] if len(attrs) > 14 else ""),
    )
