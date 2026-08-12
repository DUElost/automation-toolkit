# -*- coding: utf-8 -*-
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from modules.analyse.summary_builder import (
    build_summary,
    _extract_java_stack,
    _extract_native_backtrace,
    _extract_dropbox_head,
)

JE_DETAIL = [
    "2026-08-05 11:01:44 data_app_crash (text, 1181 bytes)",
    "Process: com.zte.cn.compass",
    "PID: 20690",
    "UID: 10443",
    "Timestamp: 2026-08-05 11:01:44.275+0800",
    "Subject: shell-induced crash",
    "",
    "android.app.RemoteServiceException: shell-induced crash",
    "  at android.app.ActivityThread.throwRemoteServiceException(ActivityThread.java:2712)",
    "  at android.os.Handler.dispatchMessage(Handler.java:110)",
]

NE_DETAIL = [
    "*** *** *** ***",
    "Cmdline: system_server",
    "pid: 1642, tid: 1642",
    "signal 11 (SIGSEGV), code 0",
    "backtrace:",
    "      #00 pc 00000000000dddc8 /apex/.../libc.so",
    "      #01 pc 000000000007e7ec /system/lib64/libbinder.so",
]


def test_extract_java_stack_real_format():
    stack = _extract_java_stack(JE_DETAIL)
    assert stack
    assert "RemoteServiceException" in stack[0]
    assert any("at android.app" in l for l in stack)


def test_extract_java_stack_fatal_exception():
    detail = ["FATAL EXCEPTION: main", "Process: com.foo", "  at com.foo.Main.run()"]
    stack = _extract_java_stack(detail)
    assert stack[0] == "FATAL EXCEPTION: main"


def test_extract_native_backtrace():
    bt = _extract_native_backtrace(NE_DETAIL)
    assert any("signal 11" in l for l in bt)
    assert any("backtrace:" in l for l in bt)
    assert any("libbinder.so" in l for l in bt)


def test_extract_dropbox_head():
    head = _extract_dropbox_head(JE_DETAIL)
    assert any("Process:" in l for l in head)
    assert any("PID:" in l for l in head)
    assert any("Timestamp:" in l for l in head)


def test_build_summary_file(tmp_path):
    path = build_summary(
        device="SN1",
        type_name="data_app_crash",
        ts="2026-08-05 11:01:44",
        package="com.zte.cn.compass",
        scenes=["FC"],
        detail_lines=JE_DETAIL,
        extra_sources={"dropbox_detail": JE_DETAIL},
        out_dir=str(tmp_path),
    )
    assert path and os.path.exists(path)
    text = open(path, encoding="utf-8").read()
    assert "报错汇总" in text
    assert "类型: data_app_crash" in text
    assert "com.zte.cn.compass" in text
    assert "RemoteServiceException" in text
    assert "--- 基础信息 ---" in text
    assert "--- 堆栈 (JE) ---" in text


def test_build_summary_anr_scene(tmp_path):
    path = build_summary(
        device="SN1",
        type_name="system_app_anr",
        ts="2026-08-05 11:00:00",
        package="com.android.systemui",
        scenes=["ANR"],
        detail_lines=["Subject: Input dispatching timed out", "Process: com.android.systemui"],
        extra_sources={"anr_trace": ['"main" prio=5 tid=1 Native', "  | sysTid=1234 nice=-2"]},
        out_dir=str(tmp_path),
    )
    text = open(path, encoding="utf-8").read()
    assert "--- 主线程堆栈 (ANR) ---" in text
    assert '"main" prio=' in text
