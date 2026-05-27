#!/usr/bin/env bash
# 由 systemd 调用，执行托管任务并写日志/通知

set -euo pipefail

NAME="${1:-}"
if [[ -z "$NAME" ]]; then
    echo "usage: _run_task.sh <task-name>" >&2
    exit 1
fi

TOOL_DIR="$(cd "$(dirname "$0")" && pwd)"
TASKMGR_HOME="${TASKMGR_HOME:-$HOME/scripts}"
META_FILE="$TOOL_DIR/tasks/${NAME}.meta"

if [[ ! -f "$META_FILE" ]]; then
    echo "meta file not found: $META_FILE" >&2
    exit 1
fi

# shellcheck disable=SC1090
source "$META_FILE"

LOG_OUT="$TASKMGR_HOME/${NAME}.log"
LOG_ERR="$TASKMGR_HOME/${NAME}.err"
mkdir -p "$TASKMGR_HOME"

timestamp() { date '+%Y-%m-%d %H:%M:%S'; }

{
    echo "[$(timestamp)] Task started: $NAME"
    echo "[$(timestamp)] Command: $command"
} >>"$LOG_OUT"

set +e
(
    cd "${work_dir:-$HOME}" || exit 1
    bash -lc "$command"
) >>"$LOG_OUT" 2>>"$LOG_ERR"
rc=$?
set -e

{
    echo "[$(timestamp)] Task finished: $NAME; exit=$rc"
} >>"$LOG_OUT"

if [[ "${notify:-0}" == "1" ]] && command -v notify-send >/dev/null 2>&1; then
    if [[ "$rc" -eq 0 ]]; then
        notify-send "$NAME 完成" "执行成功 $(date '+%H:%M')" 2>/dev/null || true
    else
        notify-send "$NAME 失败" "退出码: $rc" 2>/dev/null || true
    fi
fi

exit "$rc"
