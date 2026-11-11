#!/usr/bin/env bash
# 15.4 共享盘（CIFS）挂载脚本【模板】—— 不含任何凭据
#
# 用法：复制为 mount_sonic_tinno.sh，chmod 700，并填入**本机私有**的凭据后使用。
#      凭据只落盘在 agent 主机上，绝不提交进仓库（真实口令见各主机现场 /home/android/memleak/）。
#
# 为什么需要它：监测脚本的 hprof 与 meminfo 时序要双写到中心共享盘；watchdog 会每 5 分钟
#      检查挂载存活，掉线即调用本脚本重挂。
set -uo pipefail

# ── 需在复制件里填好的三项 ────────────────────────────────────────────
SHARE="${SONIC_TINNO_SHARE:-//<NAS_IP>/<share>/<path>}"   # 例 //10.0.0.4/jxtinno/sonic_tinno
SMB_USER="${SONIC_TINNO_USER:-<smb_username>}"
MP="${SONIC_TINNO_MOUNT:-/home/android/sonic_agent/logs/ftp_log/sonic_tinno}"
# sudo 口令：优先从环境变量读，绝不在文件里写明文
sudo -v 2>/dev/null || { [ -n "${MEMLEAK_SUDO_PASS:-}" ] && printf '%s\n' "$MEMLEAK_SUDO_PASS" | sudo -S -p '' true; }

mkdir -p "$MP"
if findmnt -T "$MP" | grep -q cifs; then
  echo "ALREADY_MOUNTED $MP"
  exit 0
fi

# 口令经环境变量传给 mount，不出现在命令行 argv（避免被 ps 读取）
SMBPW="$SONIC_TINNO_PASS" sudo -S -p '' /usr/bin/busybox mount -t cifs \
  -o "username=$SMB_USER,password=\$SMBPW,dir_mode=0777,file_mode=0777" "$SHARE" "$MP" \
  && echo "MOUNT_OK $MP" || echo "MOUNT_FAIL rc=$?"

findmnt -T "$MP" | tail -1
