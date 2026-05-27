#!/usr/bin/env bash
set -euo pipefail

TOOL_DIR="$(cd "$(dirname "$0")/.." && pwd)"
export PATH="$TOOL_DIR:$PATH"
export TASKMGR_HOME="${TASKMGR_HOME:-/tmp/taskmgr-interval-$$}"

TASK_NAME="interval-2h-test"
taskmgr remove "$TASK_NAME" 2>/dev/null || true

{
    echo "4"
    echo "2"
    echo "0"
    echo "python3 ${TOOL_DIR}/example/print_current_time.py"
    echo "n"
} | taskmgr add "$TASK_NAME"

taskmgr list
grep '^OnCalendar=' "$HOME/.config/systemd/user/automation-toolkit-interval-2h-test.timer"

taskmgr remove "$TASK_NAME"
echo "INTERVAL_TEST_OK"
