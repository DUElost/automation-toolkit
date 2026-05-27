#!/usr/bin/env bash
# WSL / Linux 冒烟测试（非交互环境可运行）
set -euo pipefail

TOOL_DIR="$(cd "$(dirname "$0")/.." && pwd)"
export PATH="$TOOL_DIR:$PATH"
export TASKMGR_HOME="${TASKMGR_HOME:-/tmp/taskmgr-smoke-$$}"

TASK_NAME="time-wsl-smoke"
cd "$TOOL_DIR"

chmod +x "$TOOL_DIR/taskmgr" "$TOOL_DIR/_run_task.sh" "$TOOL_DIR/_notify_action.sh"

taskmgr remove "$TASK_NAME" 2>/dev/null || true

{
    echo "3"
    echo "2"
    echo "python3 ${TOOL_DIR}/example/print_current_time.py"
    echo "n"
} | taskmgr add "$TASK_NAME"

taskmgr list
taskmgr status "$TASK_NAME"
taskmgr start "$TASK_NAME"
sleep 1
taskmgr log "$TASK_NAME"

if ! grep -q '\[scheduled\] current time:' "$TASKMGR_HOME/${TASK_NAME}.log"; then
    echo "SMOKE_FAIL: log missing scheduled output" >&2
    exit 1
fi

taskmgr remove "$TASK_NAME"
echo "SMOKE_OK"
