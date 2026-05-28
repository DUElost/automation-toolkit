#!/usr/bin/env bash
# 从 NFS 挂载的 APK 仓库批量安装到多台 Android 设备
# 部署路径：源站 /data/apk-repo/scripts/ ，节点 /mnt/apk-repo/scripts/

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
APPS_DIR="${APK_REPO_DIR:-$REPO_ROOT/incoming}"
CACHE_ROOT="${APK_CACHE_ROOT:-${XDG_CACHE_HOME:-$HOME/.cache}/apk-repo}"
RETRIES="${APK_INSTALL_RETRIES:-3}"

declare -a APP_NAMES=()
declare -a DEVICE_SERIALS=()
INSTALL_ALL=0
PARALLEL_DEVICES=0
MAX_JOBS="${APK_MAX_PARALLEL:-5}"
DRY_RUN=0
CONTINUE_ON_ERROR=0
SKIP_CACHE=0
LIST_FILE=""
FOLDER=""
CACHE_JOBS="${APK_CACHE_PARALLEL:-4}"

STATS_OK=""
STATS_FAIL=""
STATS_LOCK=""
CACHE_SKIP=""

usage() {
  cat <<'EOF'
用法: apk-batch-install.sh [选项]

从 /mnt/apk-repo/incoming 批量安装 APK 到本节点已连接的多台 Android 设备。
终端仅输出错误与最终汇总，不写日志文件。

选项:
  -a, --app NAME          安装指定应用目录（可重复）
  -f, --folder PATH       安装指定文件夹下全部应用（相对 incoming 或绝对路径）
  -l, --list FILE         从文件读取应用目录列表（每行一个，# 开头为注释）
  -A, --all               安装 incoming 下全部应用
  -d, --device SERIAL     指定设备序列号（可重复；默认本节点全部在线设备）
  -p, --parallel-devices  多设备并行安装（默认逐设备串行）
  -P, --parallel          同 --parallel-devices
  -j, --jobs N           并行时最多同时 N 台设备（默认 5；0 表示不限制）
  -n, --dry-run           只打印计划，不执行安装
  -c, --continue-on-error 某个应用/设备失败后继续
  -S, --skip-cache        跳过 NFS→本地缓存（沿用 ~/.cache/apk-repo 已有内容）
  -h, --help              显示帮助

环境变量:
  APK_REPO_DIR          应用目录，默认 <repo>/incoming
  APK_CACHE_ROOT        本地缓存，默认 ~/.cache/apk-repo
  APK_CACHE_PARALLEL    缓存 rsync 并行数，默认 4（各应用目录互不冲突）
  APK_INSTALL_RETRIES   失败重试次数，默认 3
  APK_MAX_PARALLEL      并行设备上限，默认 5（等同 -j 5）

示例:
  apk-batch-install.sh -a cn_xender -a com_whatsapp
  apk-batch-install.sh -f downloaded_apks_Infinix_X6852_Android16_0522
  apk-batch-install.sh -f /mnt/apk-repo/incoming/downloaded_apks_Infinix_X6852_Android16_0522 -c
  apk-batch-install.sh -l /mnt/apk-repo/scripts/apps.example.txt
  apk-batch-install.sh -A
  apk-batch-install.sh -f batch_dir -d DEVICE1 -d DEVICE2 -p
  apk-batch-install.sh -f batch_dir -P -j 5 -c
  apk-batch-install.sh -f batch_dir -P -j 0 -c
  apk-batch-install.sh -l batch.txt -c

依赖: adb, mount.nfs 已挂载, rsync 或 cp
EOF
}

err() {
  printf '[错误] %s\n' "$*" >&2
}

die() {
  err "$*"
  exit 1
}

init_stats() {
  STATS_OK="$(mktemp)"
  STATS_FAIL="$(mktemp)"
  STATS_LOCK="$(mktemp)"
  CACHE_SKIP="$(mktemp)"
  trap 'rm -f "$STATS_OK" "$STATS_FAIL" "$STATS_LOCK" "$CACHE_SKIP"' EXIT
}

record_success() {
  local app="$1" serial="$2"
  (
    flock -x 200
    printf '%s\t%s\n' "$app" "$serial" >>"$STATS_OK"
  ) 200>"$STATS_LOCK"
}

record_failure() {
  local app="$1" serial="$2" reason="${3:-}"
  (
    flock -x 200
    printf '%s\t%s\t%s\n' "$app" "$serial" "$reason" >>"$STATS_FAIL"
  ) 200>"$STATS_LOCK"
}

print_summary() {
  local app_count=${#APP_NAMES[@]}
  local device_count=${#DEVICE_SERIALS[@]}
  local total_tasks=$((app_count * device_count))
  local ok_count=0 fail_count=0
  local -a failed_apps=()

  [[ -f "$STATS_OK" ]] && ok_count=$(wc -l <"$STATS_OK" | tr -d ' ')
  [[ -f "$STATS_FAIL" ]] && fail_count=$(wc -l <"$STATS_FAIL" | tr -d ' ')

  if [[ -f "$STATS_FAIL" && "$fail_count" -gt 0 ]]; then
    mapfile -t failed_apps < <(cut -f1 "$STATS_FAIL" | sort -u)
  fi

  echo ""
  echo "========== 安装汇总 =========="
  echo "应用数:   $app_count"
  echo "设备数:   $device_count"
  echo "安装任务: $total_tasks"
  echo "成功:     $ok_count"
  echo "失败:     $fail_count"
  if [[ "$fail_count" -gt 0 ]]; then
    echo "失败应用 (${#failed_apps[@]}):"
    local app
    for app in "${failed_apps[@]}"; do
      echo "  $app"
    done
    echo "失败明细:"
    while IFS=$'\t' read -r app serial reason; do
      if [[ -n "$reason" ]]; then
        echo "  $app -> $serial ($reason)"
      else
        echo "  $app -> $serial"
      fi
    done <"$STATS_FAIL"
  fi
  echo "=============================="
}

ensure_repo_ready() {
  if [[ ! -d "$APPS_DIR" ]]; then
    if mountpoint -q /mnt/apk-repo 2>/dev/null || mount /mnt/apk-repo 2>/dev/null; then
      REPO_ROOT="/mnt/apk-repo"
      APPS_DIR="$REPO_ROOT/incoming"
    fi
  fi

  if [[ ! -d "$APPS_DIR" ]]; then
    if [[ -d "$REPO_ROOT/apps" ]]; then
      APPS_DIR="$REPO_ROOT/apps"
    else
      die "应用目录不存在: $REPO_ROOT/incoming （请先挂载 NFS: sudo mount /mnt/apk-repo）"
    fi
  fi

  command -v adb >/dev/null 2>&1 || die "未找到 adb，请安装: apt install android-tools-adb"
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
  local root="${1:-$APPS_DIR}"
  find "$root" -mindepth 1 -type f -name '*.apk' -printf '%h\n' 2>/dev/null | sort -u
}

resolve_folder() {
  local input="$1"
  if [[ -d "$input" ]]; then
    cd "$input" && pwd
    return
  fi
  if [[ -d "$APPS_DIR/$input" ]]; then
    cd "$APPS_DIR/$input" && pwd
    return
  fi
  if [[ -d "$REPO_ROOT/$input" ]]; then
    cd "$REPO_ROOT/$input" && pwd
    return
  fi
  die "文件夹不存在: $input"
}

add_apps_from_dirs() {
  local appdir rel
  while IFS= read -r appdir; do
    [[ -n "$appdir" ]] || continue
    if [[ "$appdir" == "$APPS_DIR" ]]; then
      continue
    fi
    rel="${appdir#"$APPS_DIR"/}"
    [[ -n "$rel" ]] || continue
    APP_NAMES+=("$rel")
  done
}

collect_from_folder() {
  local folder
  folder="$(resolve_folder "$1")"

  if find "$folder" -maxdepth 1 -name '*.apk' -print -quit | grep -q .; then
    local rel="${folder#"$APPS_DIR"/}"
    [[ -n "$rel" ]] || rel="$(basename "$folder")"
    APP_NAMES+=("$rel")
    return
  fi

  add_apps_from_dirs < <(discover_app_dirs "$folder")
}

collect_apps() {
  if [[ -n "$FOLDER" ]]; then
    collect_from_folder "$FOLDER"
  fi

  if [[ "$INSTALL_ALL" -eq 1 ]]; then
    add_apps_from_dirs < <(discover_app_dirs "$APPS_DIR")
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
    die "未找到可安装应用（$hint）。使用 -a / -f / -l / -A"
  fi

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
  local lock_dir="$CACHE_ROOT/.locks"
  local lock_file="$lock_dir/$(echo "$app" | tr '/ ' '__').lock"

  [[ -d "$src" ]] || return 1

  mkdir -p "$dest" "$lock_dir"
  do_sync() {
    if command -v rsync >/dev/null 2>&1; then
      rsync -a --delete "$src/" "$dest/" 2>/dev/null
    else
      rm -rf "$dest"
      mkdir -p "$dest"
      cp -a "$src/." "$dest/"
    fi
  }

  if command -v flock >/dev/null 2>&1; then
    (
      flock -x 200
      do_sync
    ) 200>"$lock_file"
  else
    do_sync
  fi
  return 0
}

list_apks() {
  local app="$1"
  find "$CACHE_ROOT/$app" -maxdepth 1 -name '*.apk' | sort
}

is_cache_failed() {
  [[ -f "$CACHE_SKIP" ]] && grep -Fxq "$1" "$CACHE_SKIP" 2>/dev/null
}

mark_cache_failed() {
  echo "$1" >>"$CACHE_SKIP"
}

prepare_one_cache() {
  local app="$1"

  if [[ ! -d "$APPS_DIR/$app" ]]; then
    err "应用不存在: $app"
    mark_cache_failed "$app"
    return 2
  fi

  if ! sync_app_cache "$app"; then
    err "缓存失败: $app"
    mark_cache_failed "$app"
    return 1
  fi
  return 0
}

prepare_all_caches() {
  local total=${#APP_NAMES[@]}
  local app idx=0 failed=0 rc=0 running=0 jobs="$CACHE_JOBS"

  if [[ "$SKIP_CACHE" -eq 1 ]]; then
    return 0
  fi

  if [[ "$jobs" -le 1 || "$total" -le 1 ]]; then
    for app in "${APP_NAMES[@]}"; do
      if ! prepare_one_cache "$app"; then
        ((failed++)) || true
        [[ "$CONTINUE_ON_ERROR" -eq 1 ]] && continue
        return 1
      fi
    done
  else
    for app in "${APP_NAMES[@]}"; do
      while (( running >= jobs )); do
        wait -n || rc=1
        ((running--)) || true
      done
      (
        prepare_one_cache "$app"
      ) &
      ((running++)) || true
    done
    while (( running > 0 )); do
      if wait -n; then
        :
      else
        rc=1
        ((failed++)) || true
      fi
      ((running--)) || true
    done
  fi

  if [[ "$failed" -gt 0 && "$CONTINUE_ON_ERROR" -eq 0 ]]; then
    return 1
  fi
  return 0
}

install_to_device() {
  local app="$1"
  local serial="$2"
  local attempt=1
  local apk_count out
  mapfile -t apks < <(list_apks "$app")

  apk_count=${#apks[@]}
  if [[ "$apk_count" -eq 0 ]]; then
    record_failure "$app" "$serial" "本地无 APK 文件"
    err "无 APK: $app -> $serial"
    return 1
  fi

  while [[ "$attempt" -le "$RETRIES" ]]; do
    if [[ "$apk_count" -eq 1 ]]; then
      if out="$(adb -s "$serial" install -r "${apks[0]}" 2>&1)"; then
        record_success "$app" "$serial"
        return 0
      fi
    else
      if out="$(adb -s "$serial" install-multiple "${apks[@]}" 2>&1)"; then
        record_success "$app" "$serial"
        return 0
      fi
    fi
    ((attempt++)) || true
    [[ "$attempt" -le "$RETRIES" ]] && sleep 2
  done

  record_failure "$app" "$serial" "${out:-adb 安装失败}"
  err "安装失败: $app -> $serial"
  printf '%s\n' "$out" >&2
  return 1
}

run_for_device() {
  local serial="$1"
  local app failed=0

  for app in "${APP_NAMES[@]}"; do
    if [[ ! -d "$APPS_DIR/$app" ]]; then
      record_failure "$app" "$serial" "应用目录不存在"
      err "应用不存在: $app -> $serial"
      ((failed++)) || true
      [[ "$CONTINUE_ON_ERROR" -eq 1 ]] && continue
      return 1
    fi

    if [[ "$DRY_RUN" -eq 1 ]]; then
      continue
    fi

    if is_cache_failed "$app"; then
      record_failure "$app" "$serial" "缓存失败"
      ((failed++)) || true
      [[ "$CONTINUE_ON_ERROR" -eq 1 ]] && continue
      return 1
    fi

    if install_to_device "$app" "$serial"; then
      :
    else
      ((failed++)) || true
      [[ "$CONTINUE_ON_ERROR" -eq 1 ]] && continue
      return 1
    fi
  done

  [[ "$failed" -eq 0 ]]
}

run_devices_parallel() {
  local max_jobs="$1"
  local serial running=0
  local rc=0

  if [[ "$max_jobs" -eq 0 ]]; then
    local pids=() pid
    for serial in "${DEVICE_SERIALS[@]}"; do
      (
        if ! run_for_device "$serial"; then exit 1; fi
      ) &
      pids+=($!)
    done
    for pid in "${pids[@]}"; do
      wait "$pid" || rc=1
    done
    return "$rc"
  fi

  for serial in "${DEVICE_SERIALS[@]}"; do
    while (( running >= max_jobs )); do
      wait -n || rc=1
      ((running--)) || true
    done
    (
      if ! run_for_device "$serial"; then exit 1; fi
    ) &
    ((running++)) || true
  done
  while (( running > 0 )); do
    wait -n || rc=1
    ((running--)) || true
  done
  return "$rc"
}

main() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -a|--app)
        [[ $# -ge 2 ]] || die "$1 需要参数"
        APP_NAMES+=("$2")
        shift 2
        ;;
      -f|--folder)
        [[ $# -ge 2 ]] || die "$1 需要参数"
        FOLDER="$2"
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
      -p|-P|--parallel-devices|--parallel)
        PARALLEL_DEVICES=1
        shift
        ;;
      -j|--jobs)
        [[ $# -ge 2 ]] || die "$1 需要参数"
        [[ "$2" =~ ^[0-9]+$ ]] || die "-j 需要非负整数"
        MAX_JOBS="$2"
        shift 2
        ;;
      -n|--dry-run)
        DRY_RUN=1
        shift
        ;;
      -c|--continue-on-error)
        CONTINUE_ON_ERROR=1
        shift
        ;;
      -S|--skip-cache)
        SKIP_CACHE=1
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

  init_stats
  ensure_repo_ready
  [[ -n "$LIST_FILE" ]] && read_list_file "$LIST_FILE"
  collect_apps
  collect_devices

  local rc=0
  if [[ "$DRY_RUN" -eq 0 ]]; then
    prepare_all_caches || rc=1
  fi

  if [[ "$rc" -eq 0 ]]; then
    if [[ "$PARALLEL_DEVICES" -eq 1 && ${#DEVICE_SERIALS[@]} -gt 1 ]]; then
      run_devices_parallel "$MAX_JOBS" || rc=1
    else
      local serial
      for serial in "${DEVICE_SERIALS[@]}"; do
        if ! run_for_device "$serial"; then
          rc=1
          [[ "$CONTINUE_ON_ERROR" -eq 1 ]] || break
        fi
      done
    fi
  fi

  print_summary
  exit "$rc"
}

main "$@"
