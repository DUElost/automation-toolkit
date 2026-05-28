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
    echo "[$(timestamp)] WorkDir: ${work_dir:-$HOME}"
    echo "[$(timestamp)] Command: $command"
} >>"$LOG_OUT"

set +e
(
    cd "${work_dir:-$HOME}" || exit 1
    bash -lc "$command"
) >>"$LOG_OUT" 2>>"$LOG_ERR"
rc=$?
set -e

if [[ "$rc" -ne 0 ]]; then
    if [[ -s "$LOG_ERR" ]] && grep -q "could not be found" "$LOG_ERR" 2>/dev/null; then
        {
            echo "[$(timestamp)] Hint: playbook/script not found? Check WorkDir: taskmgr status $NAME"
        } >>"$LOG_OUT"
    else
        {
            echo "[$(timestamp)] Hint: command exit=$rc (ansible 等非 0 可能表示部分主机失败，详见上方输出)"
        } >>"$LOG_OUT"
    fi
fi

{
    echo "[$(timestamp)] Task finished: $NAME; exit=$rc"
} >>"$LOG_OUT"

if [[ "$rc" -ne 0 && -s "$LOG_ERR" ]]; then
    {
        echo "[$(timestamp)] stderr:"
        tail -30 "$LOG_ERR"
    } >>"$LOG_OUT"
fi

if [[ "${schedule_type:-}" == "once" ]]; then
    bash "$TOOL_DIR/_finalize_once.sh" "$NAME" || true
fi

if [[ "${notify:-0}" == "1" ]] && command -v notify-send >/dev/null 2>&1; then
    if [[ "$rc" -eq 0 ]]; then
        notify-send "$NAME 完成" "执行成功 $(date '+%H:%M')" 2>/dev/null || true
    else
        notify-send "$NAME 失败" "退出码: $rc" 2>/dev/null || true
    fi
fi

# 业务命令退出码已写入日志；对 systemd 返回 0，表示「已投递执行」
exit 0
