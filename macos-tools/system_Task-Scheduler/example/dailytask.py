#!/usr/bin/env python3
"""示例定时任务 —— 使用 taskmgr 管理"""

import subprocess
import sys
import os
import platform
from datetime import datetime

TASKMGR_HOME = os.environ.get("TASKMGR_HOME", os.path.expanduser("~/scripts"))
LOG_FILE = os.path.join(TASKMGR_HOME, "dailytask.log")


def notify(title, subtitle="", message=""):
    notifier = os.environ.get("TERMINAL_NOTIFIER", "/opt/homebrew/bin/terminal-notifier")
    args = [
        notifier,
        "-title", title,
        "-subtitle", subtitle,
        "-message", message,
        "-sound", "Glass",
    ]
    subprocess.run(args, check=False)


def main():
    print(f"[{datetime.now()}] 定时任务开始执行……")

    try:
        result = f"主机: {platform.node()}\n系统: {platform.platform()}\nPython: {sys.version.split()[0]}"
        print(result)
        success = True
    except Exception as e:
        print(f"错误: {e}", file=sys.stderr)
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
