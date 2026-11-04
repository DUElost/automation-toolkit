# -*- coding: utf-8 -*-
"""AEE 去重 golden 语料：覆盖 filtered / singleton / similarity 各分支。

只用合成数据，不含真实日志。golden 文件由改造前的代码生成，
改造后必须逐字节一致（见 tests/test_aee_dedup_golden.py）。
"""
import hashlib
import json
import os
import tempfile
from pathlib import Path

PKG = "com.android.systemui"
PKG2 = "com.android.phone"
NPE = ("java.lang.NullPointerException: Attempt to invoke virtual method "
       "'int android.view.View.getId()' on a null object reference\n"
       "\tat com.android.systemui.qs.QSPanel.onClick(QSPanel.java:{line})\n"
       "\tat android.view.View.performClick(View.java:7448)")
NE = ("signal 11 (SIGSEGV), code 1 (SEGV_MAPERR), fault addr 0x{addr}\n"
      "#00 pc 000{pc} /system/lib64/libgui.so (android::Surface::lock+{off})")


def _row(i, path, exp_class, exp_type, process, package, caused_by, device="SN{}", version="NX2-V1.0.0"):
    return [path, version, "2026-11-01 10:00:{:02d}".format(i % 60), exp_class, exp_type,
            process, package, "detail-{}".format(i), caused_by, "", 1, "MainActivity",
            device.format(i % 4), False, "8+256"]


def corpus_rows():
    rows = []
    base = "/mnt/stp-log/devices/1193/SN{}/db.{:02d}/__exp_main.txt"

    def add(*a, **k):
        rows.append(_row(len(rows), base.format(len(rows) % 4, len(rows)), *a, **k))

    # similarity：同类同包，仅数字/地址不同 → 应并组
    add("Java (JE)", "system_app_crash", PKG, PKG, NPE.format(line=101))
    add("Java (JE)", "system_app_crash", PKG, PKG, NPE.format(line=202))
    add("Java (JE)", "system_app_crash", PKG, PKG, NPE.format(line=303))
    # 同 CausedBy、不同包 → 不并组
    add("Java (JE)", "system_app_crash", PKG2, PKG2, NPE.format(line=101))
    # 同 CausedBy、不同类 → 不并组
    add("Native (NE)", "SIGABRT", PKG, PKG, NPE.format(line=101))
    # NE 相似
    add("Native (NE)", "SIGSEGV", PKG, PKG, NE.format(addr="dead", pc="1234", off=12))
    add("Native (NE)", "SIGSEGV", PKG, PKG, NE.format(addr="beef", pc="5678", off=44))
    # 完全不同的 CausedBy
    add("Java (JE)", "system_app_crash", PKG, PKG, "java.lang.IllegalStateException: totally different message here")
    # singleton：fatal + detailToBeDone
    rows.append(_row(len(rows), "/mnt/stp-log/devices/1193/SN1/fatal/db.fatal.00/__exp_main.txt",
                     "Java (JE)", "system_app_crash", PKG, PKG, "detailToBeDone"))
    rows.append(_row(len(rows), "/mnt/stp-log/devices/1193/SN2/fatal/db.fatal.01/__exp_main.txt",
                     "Java (JE)", "system_app_crash", PKG, PKG, "detailToBeDone"))
    # 非 fatal 行，CausedBy 与 singleton 代表相似 → 并入 singleton 组
    add("Java (JE)", "system_app_crash", PKG, PKG, "detailToBeDone")
    # filtered：白名单外
    add("Java (JE)", "data_app_crash", "com.thirdparty.app", "com.thirdparty.app", "java.lang.RuntimeException: x")
    # filtered：各类 CausedBy 关键字
    add("Java (JE)", "system_app_crash", PKG, PKG, "invalid_combo_wifi something")
    add("Java (JE)", "system_app_crash", PKG, PKG, "unknown_app_crash something")
    add("Java (JE)", "system_app_crash", PKG, PKG, "nfc_too_close something")
    add("ANR", "system_app_anr", PKG, PKG, "anr when screen off")
    add("ANR", "system_app_anr", PKG, PKG, "can not find pid")
    # filtered：预分析丢弃包名
    add("Java (JE)", "system_app_crash", PKG, "discard_dbg", "whatever")
    # filtered：emergency（T 以后）
    add("Java (JE)", "system_app_crash", PKG, "com.android.emergency", "boom", version="NX2-V1.0.0-T")
    # filtered：AD10 + PR0 camera
    rows.append(_row(len(rows), "/mnt/stp-log/devices/AD10/PR0/SN3/db.99/__exp_main.txt",
                     "Java (JE)", "system_app_crash", PKG, "com.mediatek.camera", "cam"))
    # None 字段归一化
    add(None, None, PKG, None, None)
    add("ANR", "system_app_anr", PKG, PKG, "ANR in com.android.systemui\nReason: Input dispatching timed out " + "x" * 50)
    add("ANR", "system_app_anr", PKG, PKG, "ANR in com.android.systemui\nReason: Input dispatching timed out " + "x" * 52)
    # 超长 CausedBy（截断 10000）
    add("Kernel (KE)", "KE", PKG, PKG, "kernel panic " + "a" * 12000)
    add("Kernel (KE)", "KE", PKG, PKG, "kernel panic " + "a" * 11000)
    return rows


def platform_rows():
    rows = corpus_rows()
    base = "/mnt/stp-log/devices/1193/SN0/db.p{:02d}/__exp_main.txt"
    rows.append(_row(90, base.format(90), "Native (NE)", "SIGSEGV", "com.other", "com.other", "segv"))
    rows.append(_row(91, base.format(91), "Java (JE)", "data_app_crash", "com.other", "com.other", "data app"))
    rows.append(_row(92, base.format(92), "Java (JE)", "system_app_crash", "com.other", "com.other", "sys app other"))
    return rows


def fuzz_rows():
    rows = corpus_rows()
    base = "/mnt/stp-log/devices/1193/SN0/db.f{:02d}/__exp_main.txt"
    r = _row(80, base.format(80), "Native (NE)", "SIGSEGV", PKG, PKG, "fuzz ne")
    r[7] = "... liblspatch.so ..."
    rows.append(r)
    r = _row(81, base.format(81), "Java (JE)", "system_app_crash", PKG, PKG, "fuzz je")
    r[7] = "Caused by: java.lang.ClassNotFoundException: Foo"
    rows.append(r)
    return rows


def factory_rows():
    rows = corpus_rows()
    rows.append(_row(70, "/mnt/stp-log/devices/1193/SN0/API/db.a70/__exp_main.txt",
                     "Java (JE)", "system_app_crash", PKG, PKG, "api dump"))
    return rows


SCENARIOS = {
    # name: (scan_mode 常量名, scan_type, rows 工厂)
    "aee_shanghai": ("SCAN_MODE_AEE", "shanghai", corpus_rows),
    "platform": ("SCAN_MODE_PLATFORM", "shanghai", platform_rows),
    "fuzz": ("SCAN_MODE_FUZZ", "shanghai", fuzz_rows),
    "factory": ("SCAN_MODE_AEE", "factory", factory_rows),
}


def to_objs(rows):
    from modules.common.Excel import AeeExcelData
    return [AeeExcelData(r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[11],
                         count=r[10], device_id=r[12], rom_ram=r[14]) for r in rows]


def make_scanner(config_dir, scan_mode, scan_type):
    from modules.common import GlobalAttrs
    from modules.mode.DedupOrgExcel import DedupOrgExcel
    org = Path(config_dir) / "dummy_org.xls"
    scanner = DedupOrgExcel(str(org), "factory" if scan_type == "factory" else "shanghai", config_dir=config_dir)
    scanner._prepare_context()
    scanner._scan_mode = getattr(GlobalAttrs, scan_mode)
    return scanner


def write_config(config_dir):
    pk = "\n".join([PKG, PKG2, "com.android.emergency", "com.mediatek.camera", "CurProcessNone"]) + "\n"
    for name, content in (("pkglist.txt", pk), ("pkglist_factory.txt", pk), ("blacklist.txt", ""),
                          ("report_history.txt", "")):
        (Path(config_dir) / name).write_text(content, encoding="utf-8")


def _jsonable(v):
    if isinstance(v, set):
        return sorted(v)
    return v


def run_scenario(name, work_dir):
    from modules.common.Excel import Excel
    scan_mode, scan_type, factory = SCENARIOS[name]
    config_dir = Path(work_dir) / ("cfg_" + name)
    config_dir.mkdir(parents=True, exist_ok=True)
    write_config(config_dir)
    scanner = make_scanner(str(config_dir), scan_mode, scan_type)
    org, final, deleted = scanner._aee_to_data_list(to_objs(factory()))
    out = {"org": [[_jsonable(c) for c in r] for r in org],
           "final": [[_jsonable(c) for c in r] for r in final],
           "deleted": list(deleted)}
    hashes = {}
    for kind, data, dedup in (("org", org, False), ("final", final, True)):
        p = Path(work_dir) / "{}_{}.xls".format(name, kind)
        if data:
            Excel(str(p)).insertResultAee(data, deduplicated=dedup)
            hashes[kind] = hashlib.sha256(p.read_bytes()).hexdigest()
        else:
            hashes[kind] = None
    out["xls_sha256"] = hashes
    return out, scanner


def run_all():
    with tempfile.TemporaryDirectory() as d:
        return {name: run_scenario(name, d)[0] for name in sorted(SCENARIOS)}


GOLDEN_PATH = Path(__file__).resolve().parent / "aee_dedup_golden.json"

if __name__ == "__main__":
    import sys
    root = Path(__file__).resolve().parents[2]
    sys.path.insert(0, str(root))
    GOLDEN_PATH.write_text(json.dumps(run_all(), ensure_ascii=False, indent=1, sort_keys=True), encoding="utf-8")
    print("wrote", GOLDEN_PATH)
