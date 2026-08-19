@echo off
setlocal enabledelayedexpansion


if "%~1"=="" (
    echo No parameters were passed to the script.
    set adb_prefix=adb
) else (
    echo The first parameter is: %1
    set adb_prefix=adb -s %1
)

pushd %~dp0

%adb_prefix% shell  setenforce 0
%adb_prefix% shell mkdir -p /data/local/tmp/hprof
%adb_prefix% shell mkdir -p /sdcard/Auto
%adb_prefix% shell svc power stayon true
%adb_prefix% shell settings put system screen_off_timeout 600000
%adb_prefix% shell settings get  system screen_off_timeout
%adb_prefix% shell settings put system pointer_location 1
%adb_prefix% shell am broadcast -a com.debug.loggerui.ADB_CMD -e cmd_name start ^
 -e cmd_name set_log_size_100000 --ei cmd_target 1 -n com.debug.loggerui/.framework.LogReceiver

%adb_prefix% shell rm -rf /sdcard/Auto/*
%adb_prefix% shell rm -rf /data/aee_exp/*
%adb_prefix% shell rm -rf /data/vendor/aee_exp/*
%adb_prefix% shell rm -rf /data/local/tmp/hprof/*
%adb_prefix% shell rm -rf /data/hprof/*

%adb_prefix% install -r -g -t -d scripts-debug.apk
%adb_prefix% install -r -g -t -d scripts-debug-androidTest.apk
%adb_prefix% install -r -g -t -d antutu_benchmark_v10_3d.apk
%adb_prefix% push run_stress_gpu.sh /sdcard/Auto/run_stress_gpu.sh
%adb_prefix% shell chmod +x /sdcard/Auto/run_stress_gpu.sh
popd
pause