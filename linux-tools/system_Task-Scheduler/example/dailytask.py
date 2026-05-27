#!/usr/bin/env python3
"""示例定时任务 —— 使用 taskmgr 管理"""

import os
import platform
import subprocess
import sys
from datetime import datetime

TASKMGR_HOME = os.environ.get("TASKMGR_HOME", os.path.expanduser("~/scripts"))


def notify(title: str, subtitle: str = "", message: str = "") -> None:
    body = f"{subtitle}\n{message}".strip()
    subprocess.run(
        ["notify-send", title, body],
        check=False,
    )


def main() -> None:
    print(f"[{datetime.now()}] 定时任务开始执行……")

    try:
        result = (
            f"主机: {platform.node()}\n"
            f"系统: {platform.platform()}\n"
            f"Python: {sys.version.split()[0]}"
        )
        print(result)
        success = True
    except Exception as exc:
        print(f"错误: {exc}", file=sys.stderr)
        success = False

    if success:
        notify(
            title="定时任务完成",
            subtitle=datetime.now().strftime("%Y-%m-%d %H:%M"),
            message="dailytask 执行成功",
        )
        print("通知已发送")
    else:
        notify(
            title="定时任务失败",
            subtitle=datetime.now().strftime("%Y-%m-%d %H:%M"),
            message="请检查日志",
        )
        sys.exit(1)


if __name__ == "__main__":
    main()
