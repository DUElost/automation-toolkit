#!/bin/sh


checkInterval=600
monkey_process_name="com.android.commands.monkey"
logfile="/sdcard/Monkeylog.txt"
echo "" > $logfile

function logger(){
    content=$1
    echo -e "`date +%Y/%m/%d-%H:%M:%S` - ${content} "
    echo -e "`date +%Y/%m/%d-%H:%M:%S` - ${content} " >> $logfile
}


logger "Start Monkey now!!!"
nohup /data/local/tmp/aim  --pkg-blacklist-file   /sdcard/blacklist.txt  --smartuiautomator true --hprof --ignore-crashes --ignore-security-exceptions --ignore-timeouts --kill-process-after-error  --throttle 650 --runtime-minutes  10080   --switchuimode -v >/dev/null 2>&1 &
logger "Start MonkeySettings"
mkdir /sdcard/systeminfo
mkdir /sdcard/systeminfo_mem
rm -rf /sdcard/systeminfo_mem/*
# 配置息屏时间为 1999999999 -> 不息屏
settings put system screen_off_timeout 1999999999
sleep 3
# 停止
#logger "Close MTK log"
#am broadcast -a com.debug.loggerui.ADB_CMD -e cmd_name stop --ei cmd_target 127 --receiver-foreground  --receiver-include-background
#sleep 10
#rm -rf /sdcard/mtklog/*
#sleep 3
#rm -rf /data/aee_exp/*
#sleep 3
#rm -rf /data/vendor/aee_exp/*
#sleep 3
#rm -rf /data/vendor/mtklog/aee_exp/*
#sleep 3
#rm -rf /data/debuglogger/*
#sleep 3
logger "dumpsys activity appops on"
dumpsys activity appops on
sleep 3
setprop persist.vendor.connsys.coredump.mode 2
sleep 3
am broadcast -a com.debug.loggerui.ADB_CMD -e cmd_name switch_taglog --ei cmd_target 1 --receiver-foreground  --receiver-include-background
sleep 3
am broadcast -a com.debug.loggerui.ADB_CMD -e cmd_name set_auto_start_1 --ei cmd_target 1 --receiver-foreground  --receiver-include-background
sleep 3
am broadcast -a com.debug.loggerui.ADB_CMD -e cmd_name set_total_log_size_10240 --ei cmd_target 1 --receiver-foreground  --receiver-include-background
sleep 3
aee -m 3
sleep 3
aee -d 99
sleep 3
aee -n 99
sleep 3
echo 1 0 > /proc/mtk_battery_cmd/current_cmd
sleep 3
logger "Open mobilelog"
am broadcast -a com.debug.loggerui.ADB_CMD -e cmd_name start --ei cmd_target 1 --receiver-foreground  --receiver-include-background
sleep 3
setprop sys.audio.monkeycontrl 1
sleep 3
dumpsys activity audiomuteops on
sleep 3

while true
do
    ps -ef | grep ${monkey_process_name} | grep -v grep
    if [ $? -eq 0 ]
    then
		    logger "Monkey is running!!!"
		    logger "检查手机正在运行Monkey数"
		    monkey_pid_list=`ps -e | grep ${monkey_process_name} | awk '{print $2}'`
		    pid_count=1
		    for monkey_pid in ${monkey_pid_list}
		    do
			      if [ $pid_count -eq 1 ]
			      then
				        logger "手机第${pid_count}个Monkey pid：${monkey_pid}，保留"
			      else
				        logger "手机第${pid_count}个Monkey pid：${monkey_pid}，kill"
				        kill -9 ${monkey_pid}
			      fi
			      pid_count=$(($pid_count+1))
		    done
		    logger "获取手机运行信息"
			rm -rf /sdcard/systeminfo/*
		    echo `date +%Y/%m/%d-%H:%M:%S` >> /sdcard/systeminfo/usagestats.txt
		    dumpsys usagestats >> /sdcard/systeminfo/usagestats.txt
		    echo `date +%Y/%m/%d-%H:%M:%S` >> /sdcard/systeminfo/zoneinfo.txt
		    cat /proc/zoneinfo >> /sdcard/systeminfo/zoneinfo.txt
		    sleep 1
		    echo `date +%Y/%m/%d-%H:%M:%S` >> /sdcard/systeminfo/zraminfo.txt
		    cat /proc/zraminfo >> /sdcard/systeminfo/zraminfo.txt
		    sleep 1
		    echo `date +%Y/%m/%d-%H:%M:%S` >> /sdcard/systeminfo/meminfo.txt
		    cat /proc/meminfo >> /sdcard/systeminfo/meminfo.txt
		    sleep 1
		    echo `date +%Y/%m/%d-%H:%M:%S` >> /sdcard/systeminfo/ion_mm_heap.txt
		    cat /sys/kernel/debug/ion/ion_mm_heap >> /sdcard/systeminfo/ion_mm_heap.txt
		    sleep 1
		    echo `date +%Y/%m/%d-%H:%M:%S` >> /sdcard/systeminfo/slabtrace.txt
		    cat /proc/mtk_memcfg/slabtrace >> /sdcard/systeminfo/slabtrace.txt
		    sleep 1
		    echo `date +%Y/%m/%d-%H:%M:%S` >> /sdcard/systeminfo/slabinfo.txt
		    cat /proc/slabinfo >> /sdcard/systeminfo/slabinfo.txt
		    sleep 1
		    echo `date +%Y/%m/%d-%H:%M:%S` >> /sdcard/systeminfo/dumpsysmeminfo.txt
		    dumpsys -t 30 meminfo >> /sdcard/systeminfo/dumpsysmeminfo.txt
			sleep 1
			echo `date +%Y/%m/%d-%H:%M:%S` >> /sdcard/systeminfo_mem/dumpsysmeminfo_Total_RSS.txt
			dumpsys meminfo | grep -A 6 "Total RSS by process:" >> /sdcard/systeminfo_mem/dumpsysmeminfo_Total_RSS.txt
			sleep 5
    else
		    logger "告警!!! 手机没有发现monkey进程，尝试获取system_server进程"
		    ps -e | grep system_server | grep -v grep
		    if [ $? -eq 0 ]
		    then
			      logger "手机 system_server 存在，再次确认monkey进程"
			      ps -ef | grep ${monkey_process_name} | grep -v grep
			      if [ $? -eq 0 ]
			      then
				        logger "再次验证后，monkey正在运行"
			      else
				        logger "告警!!! 手机没有运行Monkey测试! 重新启动Monkey测试."
				        dumpsys activity appops on
				        sleep 3
				        nohup /data/local/tmp/aim  --pkg-blacklist-file   /sdcard/blacklist.txt --smartuiautomator true --hprof --ignore-crashes --ignore-security-exceptions  --ignore-timeouts  --throttle 650 --runtime-minutes  10080   --switchuimode -v >/dev/null 2>&1 &
					    fi
		    else
			      logger "手机system_server 不存在，PS结果异常，不做Monkey重启处理"
		    fi
	  fi
    sleep ${checkInterval}
done


