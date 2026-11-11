#!/usr/bin/env bash
# 看门狗：只负责 15.4 挂载存活与容量水位告警；不重启监控进程（避免批次计时清零造成全量重拉）
set -uo pipefail
BASE=/home/android/memleak
MP=/home/android/sonic_agent/logs/ftp_log/sonic_tinno
mkdir -p "$BASE/logs"
echo "$(date -Iseconds) watchdog start pid=$$ end=$(date -d @$(( $(date +%s) + 174600 )) +%m-%d_%H:%M)" >> "$BASE/logs/watchdog.log"
dl=$(cat "$BASE/deadline_epoch" 2>/dev/null || true); [ -z "$dl" ] && dl=$(( $(date +%s) + 174600 ))
END=$(( dl + 3600 ))   # 2026-10-23: 跟随监控 deadline + 1h 宽限（原硬编码 48.5h）
while [ "$(date +%s)" -lt "$END" ]; do
  [ -f "$BASE/STOP_REQUESTED" ] && break
  if ! findmnt -T "$MP" 2>/dev/null | grep -q cifs; then
    echo "$(date -Iseconds) MOUNT_MISSING 重挂 15.4" >> "$BASE/logs/watchdog.log"
    bash "$BASE/mount_sonic_tinno.sh" >> "$BASE/logs/watchdog.log" 2>&1
  fi
  avail_gb=$(df -BG --output=avail "$MP" 2>/dev/null | tail -1 | tr -dc 0-9)
  used_pct=$(df --output=pcent "$MP" 2>/dev/null | tail -1 | tr -dc 0-9)
  echo "$(date -Iseconds) avail=${avail_gb}GB used=${used_pct}% monitor=$(kill -0 "$(cat $BASE/run.pid 2>/dev/null)" 2>/dev/null && echo alive || echo DEAD)" >> "$BASE/logs/watchdog.log"
  sleep 300
done
echo "$(date -Iseconds) watchdog exit" >> "$BASE/logs/watchdog.log"
