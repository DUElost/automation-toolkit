#!/bin/bash
# ============================================================================
# 打包 APK 并通过 Ansible 分发安装到所有节点
# ============================================================================
# 用法:
#   ./batch_install.sh <extracted_apks目录> [--limit <IP>]
#
# 示例:
#   ./batch_install.sh ../extracted_apks
#   ./batch_install.sh ../extracted_apks --limit 172.21.10.36
#   ./batch_install.sh ../extracted_apks --limit 172.21.15.1,172.21.15.2
# ============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ANSIBLE_CONFIG="${ANSIBLE_CONFIG:-${SCRIPT_DIR}/ansible.cfg}"
export ANSIBLE_CONFIG

# ------------------------------------------------------------------
# 参数解析
# ------------------------------------------------------------------
APK_DIR=""
LIMIT=""
EXTRA_ARGS=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --limit)
      LIMIT="$2"
      shift 2
      ;;
    *)
      if [ -z "$APK_DIR" ]; then
        APK_DIR="$1"
      else
        EXTRA_ARGS+=("$1")
      fi
      shift
      ;;
  esac
done

if [ -z "$APK_DIR" ]; then
  echo "用法: $0 <extracted_apks目录> [--limit IP]"
  echo ""
  echo "示例:"
  echo "  $0 ../extracted_apks"
  echo "  $0 ../extracted_apks --limit 172.21.10.36"
  exit 1
fi

APK_DIR="$(cd "$APK_DIR" 2>/dev/null && pwd || echo "$APK_DIR")"
APK_DIR_NAME="$(basename "$APK_DIR")"

if [ ! -d "$APK_DIR" ]; then
  echo "[错误] APK 目录不存在: $APK_DIR"
  exit 1
fi

# 统计应用数量
app_count=$(find "$APK_DIR" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l)
if [ "$app_count" -eq 0 ]; then
  echo "[错误] APK 目录下没有应用子目录: $APK_DIR"
  exit 1
fi

# 远端路径：/home/android/apks/<提取目录名>（按型号区分，各自独立 SHA256 校验）
APK_DEST_DIR="/home/android/apks/${APK_DIR_NAME}"

echo "============================================"
echo "  批量 APK 分发安装"
echo "============================================"
echo "  APK 目录 : $APK_DIR"
echo "  远端路径 : $APK_DEST_DIR"
echo "  应用数量 : $app_count"
echo ""

# ------------------------------------------------------------------
# 打包
# ------------------------------------------------------------------
TMP_DIR="${SCRIPT_DIR}/.build"
rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"

ARCHIVE_NAME="apks_$(date +%Y%m%d_%H%M%S).tar.gz"
ARCHIVE_PATH="${TMP_DIR}/${ARCHIVE_NAME}"

echo "[1/3] 打包 APK 目录..."
# 需要进入 APK_DIR 的父目录，让 tar 内部路径不包含绝对路径
tar -czf "$ARCHIVE_PATH" -C "$(dirname "$APK_DIR")" "$(basename "$APK_DIR")"

ARCHIVE_SIZE=$(du -h "$ARCHIVE_PATH" | cut -f1)
ARCHIVE_SHA256=$(sha256sum "$ARCHIVE_PATH" | awk '{print $1}')

echo "       压缩包: $ARCHIVE_PATH"
echo "       大小:   $ARCHIVE_SIZE"
echo "       SHA256: $ARCHIVE_SHA256"
echo ""

# ------------------------------------------------------------------
# 构建 ansible-playbook 命令
# ------------------------------------------------------------------
echo "[2/3] 执行 Ansible 分发安装..."

LIMIT_ARG=""
if [ -n "$LIMIT" ]; then
  LIMIT_ARG="--limit $LIMIT"
  echo "       限定节点: $LIMIT"
fi

cd "$SCRIPT_DIR"

set +e
ansible-playbook -i inventory.ini batch_install_apks.yml \
  -e "apk_archive_src=${ARCHIVE_PATH}" \
  -e "apk_archive_sha256=${ARCHIVE_SHA256}" \
  -e "apk_dest_dir=${APK_DEST_DIR}" \
  $LIMIT_ARG \
  -v \
  "${EXTRA_ARGS[@]}"
ANSIBLE_RC=$?
set -e

echo ""

# ------------------------------------------------------------------
# 结果
# ------------------------------------------------------------------
echo "[3/3] 清理..."
rm -rf "$TMP_DIR"

if [ $ANSIBLE_RC -eq 0 ]; then
  echo "       状态: 全部成功"
else
  echo "       状态: 存在失败（rc=$ANSIBLE_RC），请向上查看 FAIL 行定位具体设备和应用"
fi

echo ""
echo "============================================"
echo "  完成"
echo "============================================"

exit $ANSIBLE_RC
