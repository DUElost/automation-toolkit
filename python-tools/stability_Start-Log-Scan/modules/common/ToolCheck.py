# -*- coding: utf-8 -*-
"""外部二进制自检：扫描开始前确认将要调用的工具存在且可执行。

v2.1.0 的 Linux 二进制在 git 中丢了可执行位，部署后 aee_extract 每次都
Permission denied，整机队报表静默退化为 failed-dbg 兜底行。自检失败时扫描
必须以非 0 退出，不产出报表。只依赖标准库。
"""
import os

REASON_MISSING = "missing"
REASON_NOT_EXECUTABLE = "not_executable"


def check_executables(paths):
    """返回 [(path, reason)]；全部可用时为空列表。"""
    problems = []
    for path in paths:
        if not path or not os.path.isfile(path):
            problems.append((path, REASON_MISSING))
        elif not os.access(path, os.X_OK):
            problems.append((path, REASON_NOT_EXECUTABLE))
    return problems
