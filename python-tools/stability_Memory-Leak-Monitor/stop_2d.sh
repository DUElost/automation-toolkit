#!/usr/bin/env bash
# 唯一允许的手动提前停止方式：精确 PID + cmdline 白名单，不用 pkill -f、不杀进程组
set -uo pipefail
BASE=/home/android/memleak
touch $BASE/STOP_REQUESTED
for f in watchdog.pid run.pid; do
  p=$(cat "$BASE/$f" 2>/dev/null || true); [ -z "$p" ] && continue
  [ "$p" = "1" ] && { echo "REFUSE pid=1"; continue; }
  cmd=$(tr '\0' ' ' < /proc/$p/cmdline 2>/dev/null)
  case "$cmd" in *timeout*|*watchdog*|*memleak*) ;; *) echo "REFUSE pid=$p cmd=$cmd"; continue;; esac
  kill -TERM "$p" 2>/dev/null && echo "TERM $p ($cmd)"
done
# 监控进程收到 SIGTERM 后会做 monkey 收尾（停压测+清设备），给足 150s
for i in $(seq 1 30); do
  if ! ps -C python3 -o cmd --no-headers 2>/dev/null | grep -q "[m]emleak_monitor_2d.py"; then
    echo "MONITOR_EXITED (含 monkey 收尾)"; exit 0
  fi
  sleep 5
done
echo "STILL_RUNNING (150s 未退出)"
