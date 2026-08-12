# -*- coding: utf-8 -*-
"""导出 .xls（MTK 风格：Result_None_None_MonkeyAEE_SPRD_{ts}(_org).xls，15 列）。

列：Id Path Version ExpTime ExpClass ExpType CurProcess Package Detail CausedBy
    extraTag Count Activity DeviceCount Rom_Ram
"""

import re


def _clean(value):
    """清洗 XML 非法控制字符（dump_report 等二进制填充残留 \x00 等）。"""
    if isinstance(value, str):
        return re.sub(r"[\x00-\x08\x0b\x0c\x0e-\x1f]", "", value)
    return value


def _row_values(rec, columns, config):
    """记录 -> 15 列值（Id 序号 / Count=sum / Activity / DeviceCount / Rom_Ram）。"""
    export = config.get("export", {})
    values = []
    for c in columns:
        if c == "Id":
            values.append(None)  # 行号由导出器填充
        elif c == "Count":
            values.append(rec.get("sum", 1))
        elif c == "Activity":
            values.append(rec.get("Activity") or export.get("activity", "None"))
        elif c == "DeviceCount":
            values.append(rec.get("DeviceCount", 1))
        elif c == "Rom_Ram":
            values.append(rec.get("Rom_Ram") or export.get("rom_ram", "/"))
        else:
            values.append(_clean(rec.get(c, "")))
    return values


# MTK 列宽（twips）：Id/Path/Version/ExpTime/ExpClass/ExpType/CurProcess/Package/
# Detail/CausedBy/extraTag/Count/Activity/DeviceCount/Rom_Ram（2026-08-11 人工调整版）
_MTK_COL_WIDTHS = [1378, 19790, 6734, 4588, 1988, 3997, 5021, 5809,
                   29991, 29991, 6990, 2461, 6084, 2776, 4765]
_MTK_HEADER_HEIGHT = 249


def _mtk_styles(wb):
    """MTK 样式：表头 Times New Roman 加粗蓝色，数据 Calibri，垂直居中。"""
    import xlwt

    head = xlwt.easyxf("font: name Times New Roman, height 200, bold on, colour_index 12")
    head.alignment.vert = xlwt.Alignment.VERT_CENTER
    data = xlwt.easyxf("font: name Calibri, height 200")
    data.alignment.vert = xlwt.Alignment.VERT_CENTER
    return head, data


def export_xls(records, path, config, start_id=1):
    """写 MTK 风格 .xls（xlwt）；Id 从 start_id 递增，样式/列宽对齐 MTK。"""
    import xlwt

    columns = config.get("export", {}).get("columns", [])
    wb = xlwt.Workbook()
    ws = wb.add_sheet("aeeexp")
    head_style, data_style = _mtk_styles(wb)
    for c, name in enumerate(columns):
        ws.write(0, c, name, head_style)
    ws.row(0).height = _MTK_HEADER_HEIGHT
    for c, width in enumerate(_MTK_COL_WIDTHS[:len(columns)]):
        ws.col(c).width = width
    for row_idx, rec in enumerate(records):
        values = _row_values(rec, columns, config)
        for c, v in enumerate(values):
            if c == 0:
                v = start_id + row_idx
            ws.write(row_idx + 1, c, v, data_style)
    wb.save(path)
    return path
