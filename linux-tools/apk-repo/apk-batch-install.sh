#!/usr/bin/env bash
# 从 NFS 挂载的 APK 仓库批量安装到多台 Android 设备
# 部署路径：源站 /data/apk-repo/scripts/ ，节点 /mnt/apk-repo/scripts/

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
APPS_DIR="${APK_REPO_DIR:-$REPO_ROOT/incoming}"
CACHE_ROOT="${APK_CACHE_ROOT:-${XDG_CACHE_HOME:-$HOME/.cache}/apk-repo}"
LOG_DIR="${APK_LOG_DIR:-}"
RETRIES="${APK_INSTALL_RETRIES:-3}"

declare -a APP_NAMES=()
declare -a DEVICE_SERIALS=()
INSTALL_ALL=0
PARALLEL_DEVICES=0
DRY_RUN=0
CONTINUE_ON_ERROR=0
LIST_FILE=""

usage() {
  cat <<'EOF'
用法: apk-batch-install.sh [选项]

从 /mnt/apk-repo/incoming 批量安装 APK 到本节点已连接的多台 Android 设备。

选项:
  -a, --app NAME          安装指定应用目录（可重复）
  -l, --list FILE         从文件读取应用目录列表（每行一个，# 开头为注释）
  -A, --all               安装 incoming 下全部应用
  -d, --device SERIAL     指定设备序列号（可重复；默认本节点全部在线设备）
  -p, --parallel-devices  多设备并行安装（默认逐设备串行）
  -n, --dry-run           只打印计划，不执行安装
  -c, --continue-on-error 某个应用/设备失败后继续
  -h, --help              显示帮助

环境变量:
  APK_REPO_DIR          应用目录，默认 <repo>/incoming
  APK_CACHE_ROOT        本地缓存，默认 ~/.cache/apk-repo
  APK_LOG_DIR           日志目录，默认 <scripts>/logs（不可写时用 ~/logs/apk-repo）
  APK_INSTALL_RETRIES   失败重试次数，默认 3

示例:
  apk-batch-install.sh -a cn_xender -a com_whatsapp
  apk-batch-install.sh -l /mnt/apk-repo/scripts/apps.example.txt
  apk-batch-install.sh -A
  apk-batch-install.sh -a cn_xender -d DEVICE1 -d DEVICE2 -p
  apk-batch-install.sh -l batch.txt -c

依赖: adb, mount.nfs 已挂载, rsync 或 cp
EOF
}

log() {
  printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*"
}

die() {
  log "ERROR: $*"
  exit 1
}

init_log_dir() {
  if [[ -n "$LOG_DIR" ]]; then
    mkdir -p "$LOG_DIR"
    return
  fi
  if mkdir -p "$SCRIPT_DIR/logs" 2>/dev/null; then
    LOG_DIR="$SCRIPT_DIR/logs"
    return
  fi
  LOG_DIR="${HOME}/logs"
  mkdir -p "$LOG_DIR"
}

ensure_repo_ready() {
  if [[ ! -d "$APPS_DIR" ]]; then
    if mountpoint -q /mnt/apk-repo 2>/dev/null || mount /mnt/apk-repo 2>/dev/null; then
      REPO_ROOT="/mnt/apk-repo"
      APPS_DIR="$REPO_ROOT/incoming"
    fi
  fi

  if [[ ! -d "$APPS_DIR" ]]; then
    # 兼容：尚未迁移时回退到 apps/
    if [[ -d "$REPO_ROOT/apps" ]]; then
      APPS_DIR="$REPO_ROOT/apps"
    else
      die "应用目录不存在: $REPO_ROOT/incoming （请先挂载 NFS: sudo mount /mnt/apk-repo）"
    fi
  fi

  command -v adb >/dev/null 2>&1 || die "未找到 adb，请安装: apt install android-tools-adb"
  init_log_dir
  mkdir -p "$CACHE_ROOT"
}

read_list_file() {
  local file="$1"
  [[ -f "$file" ]] || die "列表文件不存在: $file"
  while IFS= read -r line || [[ -n "$line" ]]; do
    line="${line%%#*}"
    line="$(echo "$line" | xargs)"
    [[ -n "$line" ]] || continue
    APP_NAMES+=("$line")
  done <"$file"
}

discover_app_dirs() {
  find "$APPS_DIR" -mindepth 1 -type f -name '*.apk' -printf '%h\n' 2>/dev/null | sort -u
}

collect_apps() {
  if [[ "$INSTALL_ALL" -eq 1 ]]; then
    local appdir rel
    while IFS= read -r appdir; do
      [[ -n "$appdir" ]] || continue
      rel="${appdir#"$APPS_DIR"/}"
      APP_NAMES+=("$rel")
    done < <(discover_app_dirs)
  fi

  if [[ ${#APP_NAMES[@]} -eq 0 ]]; then
    local hint="目录: $APPS_DIR"
    if [[ -d "$REPO_ROOT/apps" ]] && [[ -n "$(ls -A "$REPO_ROOT/apps" 2>/dev/null)" ]]; then
      hint+="；检测到旧目录 apps/ 有内容，请迁移到 incoming 或运行 import-apks.sh"
    elif [[ -d "$APPS_DIR" ]] && [[ -z "$(ls -A "$APPS_DIR" 2>/dev/null)" ]]; then
      hint+="；incoming 为空，请从 Windows 上传 APK"
    else
      hint+="；可尝试先运行 import-apks.sh 展平/合并分片"
    fi
    die "未找到可安装应用（$hint）"
  fi

  # 去重
  mapfile -t APP_NAMES < <(printf '%s\n' "${APP_NAMES[@]}" | awk '!seen[$0]++')
}

collect_devices() {
  if [[ ${#DEVICE_SERIALS[@]} -eq 0 ]]; then
    mapfile -t DEVICE_SERIALS < <(adb devices | awk 'NR>1 && $2=="device" {print $1}')
  fi

  if [[ ${#DEVICE_SERIALS[@]} -eq 0 ]]; then
    die "无在线 Android 设备（adb devices）"
  fi
}

sync_app_cache() {
  local app="$1"
  local src="$APPS_DIR/$app"
  local dest="$CACHE_ROOT/$app"

  [[ -d "$src" ]] || return 1

  mkdir -p "$dest"
  if command -v rsync >/dev/null 2>&1; then
    rsync -a --delete "$src/" "$dest/"
  else
    rm -rf "$dest"
    mkdir -p "$dest"
    cp -a "$src/." "$dest/"
  fi
  return 0
}

list_apks() {
  local app="$1"
  find "$CACHE_ROOT/$app" -maxdepth 1 -name '*.apk' | sort
}

install_to_device() {
  local app="$1"
  local serial="$2"
  local attempt=1
  local apk_count
  mapfile -t apks < <(list_apks "$app")

  apk_count=${#apks[@]}
  [[ "$apk_count" -gt 0 ]] || return 1

  while [[ "$attempt" -le "$RETRIES" ]]; do
    if [[ "$apk_count" -eq 1 ]]; then
      if adb -s "$serial" install -r "${apks[0]}"; then
        return 0
      fi
    else
      if adb -s "$serial" install-multiple "${apks[@]}"; then
        return 0
      fi
    fi
    log "重试 $attempt/$RETRIES: $app -> $serial"
    sleep 2
    ((attempt++)) || true
  done
  return 1
}

run_for_device() {
  local serial="$1"
  local app failed=0 ok=0

  log "设备 $serial 开始安装 (${#APP_NAMES[@]} 个应用)"
  for app in "${APP_NAMES[@]}"; do
    if [[ ! -d "$APPS_DIR/$app" ]]; then
      log "SKIP 不存在: $app ($serial)"
      ((failed++)) || true
      [[ "$CONTINUE_ON_ERROR" -eq 1 ]] && continue
      return 1
    fi

    if [[ "$DRY_RUN" -eq 1 ]]; then
      log "DRY-RUN: $app -> $serial"
      continue
    fi

    if ! sync_app_cache "$app"; then
      log "FAIL 缓存失败: $app ($serial)"
      ((failed++)) || true
      [[ "$CONTINUE_ON_ERROR" -eq 1 ]] && continue
      return 1
    fi

    if install_to_device "$app" "$serial"; then
      log "OK: $app -> $serial"
      ((ok++)) || true
    else
      log "FAIL: $app -> $serial"
      ((failed++)) || true
      [[ "$CONTINUE_ON_ERROR" -eq 1 ]] && continue
      return 1
    fi
  done

  log "设备 $serial 完成: 成功 $ok, 失败 $failed"
  [[ "$failed" -eq 0 ]]
}

write_summary() {
  local summary_file="$LOG_DIR/last-run.summary"
  {
    echo "time=$(date -Iseconds)"
    echo "repo_root=$REPO_ROOT"
    echo "apps_dir=$APPS_DIR"
    echo "app_count=${#APP_NAMES[@]}"
    echo "device_count=${#DEVICE_SERIALS[@]}"
    printf 'apps=%s\n' "${APP_NAMES[*]}"
    printf 'devices=%s\n' "${DEVICE_SERIALS[*]}"
  } >"$summary_file"
}

main() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -a|--app)
        [[ $# -ge 2 ]] || die "$1 需要参数"
        APP_NAMES+=("$2")
        shift 2
        ;;
      -l|--list)
        [[ $# -ge 2 ]] || die "$1 需要参数"
        LIST_FILE="$2"
        shift 2
        ;;
      -A|--all)
        INSTALL_ALL=1
        shift
        ;;
      -d|--device)
        [[ $# -ge 2 ]] || die "$1 需要参数"
        DEVICE_SERIALS+=("$2")
        shift 2
        ;;
      -p|--parallel-devices)
        PARALLEL_DEVICES=1
        shift
        ;;
      -n|--dry-run)
        DRY_RUN=1
        shift
        ;;
      -c|--continue-on-error)
        CONTINUE_ON_ERROR=1
        shift
        ;;
      -h|--help)
        usage
        exit 0
        ;;
      *)
        die "未知参数: $1"
        ;;
    esac
  done

  ensure_repo_ready
  [[ -n "$LIST_FILE" ]] && read_list_file "$LIST_FILE"
  collect_apps
  collect_devices

  local log_file="$LOG_DIR/run-$(date '+%Y%m%d-%H%M%S').log"
  exec > >(tee -a "$log_file") 2>&1

  log "APK 批量安装开始"
  log "仓库: $REPO_ROOT"
  log "应用数: ${#APP_NAMES[@]}, 设备数: ${#DEVICE_SERIALS[@]}"
  log "日志: $log_file"

  local rc=0
  if [[ "$PARALLEL_DEVICES" -eq 1 && ${#DEVICE_SERIALS[@]} -gt 1 ]]; then
    local pids=() serial
    for serial in "${DEVICE_SERIALS[@]}"; do
      (
        if ! run_for_device "$serial"; then
          exit 1
        fi
      ) &
      pids+=($!)
    done
    for pid in "${pids[@]}"; do
      if ! wait "$pid"; then
        rc=1
      fi
    done
  else
    local serial
    for serial in "${DEVICE_SERIALS[@]}"; do
      if ! run_for_device "$serial"; then
        rc=1
        [[ "$CONTINUE_ON_ERROR" -eq 1 ]] || break
      fi
    done
  fi

  write_summary
  if [[ "$rc" -eq 0 ]]; then
    log "全部完成"
  else
    log "完成，存在失败项"
  fi
  exit "$rc"
}

main "$@"
