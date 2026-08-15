# -*- coding: utf-8 -*-
"""事件快照落点：只写入已成功建包目录。"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from scan_log_gt import ScanLogGT


def _scanner():
    return ScanLogGT(
        config={"dropbox": {"types": {
            "data_app_crash": {},
            "data_app_native_crash": {},
        }}, "general": {"polling_interval_seconds": 60, "state_prefix": "output"}},
        output_root="/tmp",
        platform="sprd",
    )


def test_resolve_uses_success_info_package(tmp_path):
    s = _scanner()
    pkg = os.path.join(str(tmp_path), "dev", "SYSTEM-TOMBSTONE_2026-08-12-141318")
    os.makedirs(pkg)
    infos = [{"package_dir": pkg, "ts": "2026-08-12 14:13:18"}]
    prefix, ts = s._resolve_snapshot_target(
        "dev", str(tmp_path), ["data_app_native_crash"], infos)
    assert prefix == "SYSTEM-TOMBSTONE_2026-08-12-141318"
    assert ts == "2026-08-12 14:13:18"


def test_resolve_skips_when_dropbox_failed_no_package(tmp_path):
    """dropbox 有增量但本轮未建包：不发明空壳名、不误挂。"""
    s = _scanner()
    # 故意放一个旧包，确认不会回落到它
    os.makedirs(os.path.join(str(tmp_path), "dev", "old-pkg_2026-01-01-000000"))
    prefix, ts = s._resolve_snapshot_target(
        "dev", str(tmp_path), ["data_app_crash"], [])
    assert prefix is None and ts is None


def test_resolve_platform_only_uses_latest(tmp_path):
    s = _scanner()
    older = os.path.join(str(tmp_path), "dev", "Assert_2026-01-01-000000")
    newer = os.path.join(str(tmp_path), "dev", "Jank_2026-08-01-120000")
    os.makedirs(older)
    os.makedirs(newer)
    os.utime(older, (1, 1))
    os.utime(newer, None)
    prefix, ts = s._resolve_snapshot_target(
        "dev", str(tmp_path), ["102200004"], [])
    assert prefix == "Jank_2026-08-01-120000"
    assert ts is None
