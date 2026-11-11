#!/usr/bin/env bash
# 48h 内存泄露监控启动器：nohup 后台 + 到点自动停止（timeout），不自动重启
set -uo pipefail
BASE=/home/android/memleak
SCRIPT=$BASE/memleak_monitor_2d.py
MP=/home/android/sonic_agent/logs/ftp_log/sonic_tinno
DURATION=${DURATION:-172800}          # 48h
mkdir -p "$BASE/logs"
rm -f "$BASE/STOP_REQUESTED"   # 重启时清除停止标记，避免看门狗误自退
if [ ! -e "$MP/.mount_check" ]; then
  if ! findmnt -T "$MP" | grep -q cifs; then echo "ABORT: 15.4 cifs 未挂载"; exit 1; fi
fi
# 注意：不能用 pgrep -f "<脚本名>" 判断实例——它会同时匹配 timeout 包装进程。
if ps -C python3 -o cmd --no-headers 2>/dev/null | grep -q "[m]emleak_monitor_2d.py"; then
  echo "ALREADY_RUNNING (python 实例存在)"; exit 0
fi
setsid nohup timeout -k 120 "$DURATION" python3 -u "$SCRIPT" >>"$BASE/logs/console_$(date +%Y%m%d_%H%M%S).out" 2>&1 </dev/null &
echo $! > $BASE/run.pid
echo $(( $(date +%s) + DURATION )) > $BASE/deadline_epoch
date -Iseconds > $BASE/started_at
echo "STARTED pid=$(cat $BASE/run.pid) duration=${DURATION}s deadline=$(date -d @$(( $(date +%s) + DURATION )) -Iseconds)"

# v5.2: 无条件重启看门狗（stop_2d.sh 会 TERM 它，条件式补拉会在"将死未死"时误判）
for p in $(pgrep -f "[w]atchdog[.]sh"); do kill -TERM "$p" 2>/dev/null; done
sleep 1
setsid nohup bash $BASE/watchdog.sh >/dev/null 2>&1 </dev/null &
echo $! > $BASE/watchdog.pid
echo "WATCHDOG_RESTARTED pid=$(cat $BASE/watchdog.pid)"
