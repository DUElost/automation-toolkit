#!/usr/bin/env bash
# 一次性任务执行后注销 systemd 单元并移除 meta（保留日志）

set -euo pipefail

NAME="${1:-}"
if [[ -z "$NAME" ]]; then
    exit 0
fi

TOOL_DIR="$(cd "$(dirname "$0")" && pwd)"
SYSTEMD_USER_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user"
TASKMGR_HOME="${TASKMGR_HOME:-$HOME/scripts}"
META_FILE="$TOOL_DIR/tasks/${NAME}.meta"

if [[ ! -f "$META_FILE" ]]; then
    exit 0
fi

# shellcheck disable=SC1090
source "$META_FILE"

if [[ "${schedule_type:-}" != "once" ]]; then
    exit 0
fi

_unit_slug() {
    local task_name="$1"
    local safe
    safe=$(echo "$task_name" | sed 's/[^a-zA-Z0-9._-]/_/g' | tr '[:upper:]' '[:lower:]')
    safe="${safe#_}"
    safe="${safe%_}"
    if [[ -z "$safe" ]]; then
        safe="task-$(printf '%s' "$task_name" | md5sum | awk '{print substr($1,1,8)}')"
    fi
    echo "$safe"
}

UNIT="automation-toolkit-$(_unit_slug "${task_name:-$NAME}")"

if command -v systemctl >/dev/null 2>&1; then
    systemctl --user disable --now "${UNIT}.timer" 2>/dev/null || true
    systemctl --user reset-failed "${UNIT}.service" 2>/dev/null || true
fi

rm -f "$SYSTEMD_USER_DIR/${UNIT}.timer" "$SYSTEMD_USER_DIR/${UNIT}.service"
rm -f "$META_FILE"

if command -v systemctl >/dev/null 2>&1; then
    systemctl --user daemon-reload 2>/dev/null || true
fi

LOG_OUT="$TASKMGR_HOME/${NAME}.log"
mkdir -p "$TASKMGR_HOME"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Once task unregistered from scheduler (one-shot completed)" >>"$LOG_OUT"
