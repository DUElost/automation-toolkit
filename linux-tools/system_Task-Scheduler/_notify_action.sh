#!/usr/bin/env bash
# 通知点击后尝试打开终端查看日志（桌面环境可选）

NAME="${1:-}"
TASKMGR_HOME="${TASKMGR_HOME:-$HOME/scripts}"
LOG_FILE="$TASKMGR_HOME/${NAME}.log"

if [[ ! -f "$LOG_FILE" ]]; then
    echo "暂无日志: $LOG_FILE"
    exit 0
fi

if command -v x-terminal-emulator >/dev/null 2>&1; then
    x-terminal-emulator -e bash -lc "clear; echo '=== ${NAME} ==='; tail -30 '${LOG_FILE}'; echo; read -rp '按回车关闭...'"
elif command -v gnome-terminal >/dev/null 2>&1; then
    gnome-terminal -- bash -lc "clear; echo '=== ${NAME} ==='; tail -30 '${LOG_FILE}'; echo; read -rp '按回车关闭...'"
elif command -v konsole >/dev/null 2>&1; then
    konsole -e bash -lc "clear; echo '=== ${NAME} ==='; tail -30 '${LOG_FILE}'; echo; read -rp '按回车关闭...'"
else
    tail -30 "$LOG_FILE"
fi
