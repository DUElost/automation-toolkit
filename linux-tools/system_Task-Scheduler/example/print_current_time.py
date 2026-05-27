"""定时实验脚本：打印当前系统时间（供 taskmgr / systemd 验证）"""

from datetime import datetime
import sys


def main() -> None:
    now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    print(f"[scheduled] current time: {now}")
    sys.stdout.flush()


if __name__ == "__main__":
    main()
