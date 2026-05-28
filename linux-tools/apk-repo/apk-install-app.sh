#!/usr/bin/env bash
# 单应用安装快捷入口，内部调用 apk-batch-install.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BATCH="$SCRIPT_DIR/apk-batch-install.sh"

APP="${1:-}"
SERIAL="${2:-}"

if [[ -z "$APP" ]]; then
  echo "用法: apk-install-app.sh <应用目录名> [设备序列号]" >&2
  echo "示例: apk-install-app.sh cn_xender" >&2
  echo "示例: apk-install-app.sh com_whatsapp ABC123456789" >&2
  exit 1
fi

[[ -x "$BATCH" ]] || chmod +x "$BATCH"

if [[ -n "$SERIAL" ]]; then
  exec "$BATCH" --app "$APP" --device "$SERIAL"
else
  exec "$BATCH" --app "$APP"
fi
