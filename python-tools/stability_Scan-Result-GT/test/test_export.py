# -*- coding: utf-8 -*-
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from modules.export import export_xls

CONFIG = {
    "export": {
        "columns": ["Id", "Path", "Version", "ExpTime", "ExpClass", "ExpType", "CurProcess",
                    "Package", "Detail", "CausedBy", "extraTag", "Count", "Activity",
                    "DeviceCount", "Rom_Ram"],
        "output_before": "before.xls",
        "output_after": "after.xls",
        "rom_ram": "/",
        "activity": "None",
    }
}

RECORDS = [
    {"Path": "/a", "Version": "V1", "ExpTime": "2026-08-05-100000", "ExpType": "x",
     "CurProcess": "com.foo", "Package": "com.foo", "Detail": "d", "CausedBy": "c",
     "extraTag": "", "sum": 2, "snNum": "SN1", "ExpClass": "JE", "DeviceCount": 1},
]


def test_export_xls_mtk_columns(tmp_path):
    path = export_xls(RECORDS, str(tmp_path / "out.xls"), CONFIG)
    import xlrd
    wb = xlrd.open_workbook(path)
    ws = wb.sheet_by_index(0)
    assert ws.name == "aeeexp"
    headers = [ws.cell_value(0, c) for c in range(ws.ncols)]
    assert headers == CONFIG["export"]["columns"]
    assert ws.cell_value(1, 0) == 1.0  # Id 从 1 递增
    assert ws.cell_value(1, 1) == "/a"  # Path
    assert ws.cell_value(1, 5) == "x"   # ExpType
    assert ws.cell_value(1, 11) == 2.0  # Count = sum
    assert ws.cell_value(1, 12) == "None"  # Activity
    assert ws.cell_value(1, 13) == 1.0  # DeviceCount
    assert ws.cell_value(1, 14) == "/"  # Rom_Ram
