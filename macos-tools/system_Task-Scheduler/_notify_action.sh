#!/bin/bash
# 通知点击后打开终端显示日志（由 taskmgr 通知调用）
name="$1"
TASKMGR_HOME="${TASKMGR_HOME:-$HOME/scripts}"
logfile="$TASKMGR_HOME/${name}.log"
tmpfile="/tmp/taskmgr_${name}_log.command"

cat > "$tmpfile" <<CMDEOF
#!/bin/bash
clear
echo "=== ${name} ==="
echo
tail -30 "${logfile}"
echo
echo "--- 按回车关闭 ---"
read
CMDEOF

chmod +x "$tmpfile"
open -a Terminal "$tmpfile"
