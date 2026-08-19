rem Confidential
@echo off
setlocal enabledelayedexpansion

rem GPU 专项统一执行入口：按设备运存自动选择 Antutu_v10_Lite / Antutu_v10
set "SCRIPT_DIR=%~dp0"
cd /d "%SCRIPT_DIR%"
set "current_path=%SCRIPT_DIR%"
set "LITE_DIR=%SCRIPT_DIR%Antutu_v10_Lite"
set "FULL_DIR=%SCRIPT_DIR%Antutu_v10"
set "CONFIG_FILE=%SCRIPT_DIR%gpu_tool_config.ini"

call :load_config

:mainloop
cls
echo Current working directory: %current_path%
echo Tool mapping: RAM ^<=%LITE_MAX_GB%GB -^> Antutu_v10_Lite, RAM ^>%LITE_MAX_GB%GB -^> Antutu_v10

rem Get connected devices
set "device_count=0"
set "devices_list="
for /f "tokens=1" %%a in ('adb devices ^| findstr /r /c:"^.*device$"') do (
    set /a device_count+=1
    set "devices_list=!devices_list! %%a"
)

if %device_count% equ 0 (
    echo No devices detected!
    pause
    exit /b 1
)

echo.
echo Current connected devices (%device_count%):
for %%d in (%devices_list%) do (
    call :get_ram_gb %%d
    if not defined ram_gb (
        echo - %%d  RAM=unknown  -^> cannot select tool
        set "has_unknown_ram=1"
    ) else (
        call :select_tool !ram_gb!
        echo - %%d  RAM=!ram_gb!GB  -^> !tool_label!
    )
)
if defined has_unknown_ram (
    echo.
    echo ERROR: Failed to detect RAM for one or more devices.
    echo Please check adb connection, then rescan.
    pause
    goto mainloop
)

:confirm
echo.
set "confirm=Y"
set "loop=2000"
set /p confirm="Confirm to start GPU stress test for all devices? (Y/N/Q): "
set /p loop="Confirm loop time? (Default 2000): "
echo %loop%
if /i "%confirm%"=="Y" goto proceed
if /i "%confirm%"=="N" (
    echo.
    echo Rescanning devices...
    timeout /t 2 >nul
    goto mainloop
)
if /i "%confirm%"=="Q" exit /b
echo Invalid option. Please enter Y, N, or Q.
goto confirm

:proceed
for %%d in (%devices_list%) do (
    set "device=%%d"
    call :get_ram_gb !device!
    call :select_tool !ram_gb!

    echo @echo off > "%temp%\adb_run_!device!.bat"
    echo setlocal enabledelayedexpansion >> "%temp%\adb_run_!device!.bat"
    echo echo Processing device: !device! ^(!tool_label! / !ram_gb!GB^) >> "%temp%\adb_run_!device!.bat"

    echo adb -s !device! wait-for-device >> "%temp%\adb_run_!device!.bat"
    echo adb -s !device! root >> "%temp%\adb_run_!device!.bat"
    echo ping -n 3 127.0.0.1^>nul >> "%temp%\adb_run_!device!.bat"
    echo adb -s !device! shell "settings put global development_settings_enabled 1" >> "%temp%\adb_run_!device!.bat"
    echo ping -n 3 127.0.0.1^>nul >> "%temp%\adb_run_!device!.bat"
    echo adb -s !device! shell "mkdir /sdcard/Auto" >> "%temp%\adb_run_!device!.bat"
    echo ping -n 3 127.0.0.1^>nul >> "%temp%\adb_run_!device!.bat"
    echo adb -s !device! shell "mkdir /sdcard/Auto" >> "%temp%\adb_run_!device!.bat"

    echo ping -n 3 127.0.0.1^>nul >> "%temp%\adb_run_!device!.bat"
    echo adb -s !device! shell "cmd wifi set-wifi-enabled disabled" >> "%temp%\adb_run_!device!.bat"
    echo ping -n 3 127.0.0.1^>nul >> "%temp%\adb_run_!device!.bat"
    echo adb -s !device! shell "cmd connectivity airplane-mode enable" >> "%temp%\adb_run_!device!.bat"

    echo adb -s !device! uninstall com.tinno.reliabilityuiautomatortest >> "%temp%\adb_run_!device!.bat"
    echo adb -s !device! uninstall com.tinno.reliabilityuiautomatortest.test >> "%temp%\adb_run_!device!.bat"
    echo adb -s !device! uninstall com.transsion.testcaserepository >> "%temp%\adb_run_!device!.bat"
    echo adb -s !device! uninstall com.transsion.testcaserepository.test >> "%temp%\adb_run_!device!.bat"
    echo ping -n 3 127.0.0.1^>nul >> "%temp%\adb_run_!device!.bat"

    echo adb -s !device! install -r -g "!tool_dir!\scripts-debug.apk" >> "%temp%\adb_run_!device!.bat"
    echo adb -s !device! install -r -g "!tool_dir!\scripts-debug-androidTest.apk" >> "%temp%\adb_run_!device!.bat"
    echo adb -s !device! install -r -g "!tool_dir!\!antutu_apk!" >> "%temp%\adb_run_!device!.bat"
    echo ping -n 2 127.0.0.1^>nul >> "%temp%\adb_run_!device!.bat"

    echo adb -s !device! shell settings put system screen_off_timeout 1999999999 >> "%temp%\adb_run_!device!.bat"
    echo ping -n 3 127.0.0.1^>nul >> "%temp%\adb_run_!device!.bat"
    echo adb -s !device! shell locksettings set-disabled true >> "%temp%\adb_run_!device!.bat"
    echo ping -n 3 127.0.0.1^>nul >> "%temp%\adb_run_!device!.bat"
    echo adb -s !device! shell input keyevent  82 >> "%temp%\adb_run_!device!.bat"
    echo ping -n 3 127.0.0.1^>nul >> "%temp%\adb_run_!device!.bat"
    echo adb -s !device! shell input keyevent  82 >> "%temp%\adb_run_!device!.bat"
    echo ping -n 3 127.0.0.1^>nul >> "%temp%\adb_run_!device!.bat"
    echo adb -s !device! shell input keyevent  82 >> "%temp%\adb_run_!device!.bat"
    echo ping -n 3 127.0.0.1^>nul >> "%temp%\adb_run_!device!.bat"

    echo adb -s !device! shell rm -rf /data/aee_exp/* >> "%temp%\adb_run_!device!.bat"
    echo ping -n 9 127.0.0.1^>nul >> "%temp%\adb_run_!device!.bat"
    echo adb -s !device! shell rm -rf /data/vendor/aee_exp/* >> "%temp%\adb_run_!device!.bat"
    echo ping -n 9 127.0.0.1^>nul >> "%temp%\adb_run_!device!.bat"
    echo adb -s !device! shell rm -rf /data/debuglogger/* >> "%temp%\adb_run_!device!.bat"
    echo ping -n 9 127.0.0.1^>nul >> "%temp%\adb_run_!device!.bat"
    echo adb -s !device! shell dumpsys activity appops on >> "%temp%\adb_run_!device!.bat"

    echo adb -s !device! shell am broadcast -a com.debug.loggerui.ADB_CMD -e cmd_name switch_taglog --ei cmd_target 1 --receiver-foreground  --receiver-include-background >> "%temp%\adb_run_!device!.bat"
    echo ping -n 3 127.0.0.1^>nul >> "%temp%\adb_run_!device!.bat"
    echo adb -s !device! shell am broadcast -a com.debug.loggerui.ADB_CMD -e cmd_name set_auto_start_1 --ei cmd_target 1 --receiver-foreground  --receiver-include-background >> "%temp%\adb_run_!device!.bat"
    echo ping -n 3 127.0.0.1^>nul >> "%temp%\adb_run_!device!.bat"
    echo adb -s !device! shell am broadcast -a com.debug.loggerui.ADB_CMD -e cmd_name set_total_log_size_10240 --ei cmd_target 1 --receiver-foreground  --receiver-include-background >> "%temp%\adb_run_!device!.bat"
    echo ping -n 3 127.0.0.1^>nul >> "%temp%\adb_run_!device!.bat"
    echo adb -s !device! shell echo 1 0 ^> /proc/mtk_battery_cmd/current_cmd >> "%temp%\adb_run_!device!.bat"
    echo ping -n 3 127.0.0.1^>nul >> "%temp%\adb_run_!device!.bat"
    echo adb -s !device! shell am broadcast -a com.debug.loggerui.ADB_CMD -e cmd_name start --ei cmd_target 3 --receiver-foreground  --receiver-include-background >> "%temp%\adb_run_!device!.bat"

    echo ping -n 2 127.0.0.1^>nul >> "%temp%\adb_run_!device!.bat"
    echo adb -s !device! shell input keyevent 3 >> "%temp%\adb_run_!device!.bat"
    echo adb -s !device! shell setprop sys.audio.monkeycontrl 1 >> "%temp%\adb_run_!device!.bat"

    echo adb -s !device! shell "nohup am instrument -w -m -e listener com.transsion.common.TestCaseRunListener -e debug false -e loop %loop% -e class com.transsion.testcaserepository.stressgpu.TestStressGpuExecute#test_StressSpecial_GPUTest_!test_id! com.transsion.testcaserepository.test/androidx.test.runner.AndroidJUnitRunner ^> /sdcard/Auto/test_log.txt 2^>^&1 ^&" >> "%temp%\adb_run_!device!.bat"

    echo ping -n 3 127.0.0.1^>nul >> "%temp%\adb_run_!device!.bat"
    echo adb -s !device! shell "ps | grep com.tinno.reliabilityuiautomatortest" >> "%temp%\adb_run_!device!.bat"

    echo echo Processing completed for !device! >> "%temp%\adb_run_!device!.bat"
    echo del /f /q "%temp%\adb_run_!device!.bat" >nul 2>&1 >> "%temp%\adb_run_!device!.bat"
    echo exit >> "%temp%\adb_run_!device!.bat"
)

for %%d in (%devices_list%) do (
    start "ADB_RUN_%%d" cmd /c "%temp%\adb_run_%%d.bat"
)

echo.
echo ========================================================================
echo                 ALL PROCESSES STARTED
echo ========================================================================
echo.
echo All devices are being processed in separate windows.
echo You can check the individual windows for progress information.
echo When all windows close, the process will be complete.
echo.
pause
exit /b

:load_config
set "LITE_MAX_GB=8"
if not exist "%CONFIG_FILE%" goto :eof
for /f "usebackq tokens=1,* delims==" %%a in ("%CONFIG_FILE%") do (
    set "cfg_key=%%a"
    set "cfg_val=%%b"
    if not "!cfg_key:~0,1!"==";" (
        if /i "!cfg_key!"=="lite_max_gb" set "LITE_MAX_GB=!cfg_val!"
    )
)
goto :eof

:get_ram_gb
set "target_device=%~1"
set "ram_gb="
set "ddr_prop="
for /f "delims=" %%r in ('adb -s %target_device% shell getprop ro.boot.ddrsize 2^>nul') do set "ddr_prop=%%r"
set "ddr_prop=!ddr_prop: =!"
if defined ddr_prop call :parse_ddr_size "!ddr_prop!" ram_gb
if defined ram_gb goto :eof
for /f "tokens=2" %%m in ('adb -s %target_device% shell cat /proc/meminfo 2^>nul ^| findstr /b "MemTotal:"') do set "mem_kb=%%m"
if not defined mem_kb goto :eof
set /a ram_gb=(mem_kb + 524288) / 1048576
if !ram_gb! lss 1 set /a ram_gb=1
goto :eof

:parse_ddr_size
set "ddr_raw=%~1"
set "%~2="
set "last_char=!ddr_raw:~-1!"
if /i "!last_char!"=="G" (
    set /a %~2=!ddr_raw:~0,-1!
    goto :eof
)
if /i "!last_char!"=="M" (
    set /a %~2=!ddr_raw:~0,-1! / 1024
)
goto :eof

:select_tool
set "check_ram=%~1"
set "tool_dir="
set "antutu_apk="
set "test_id="
set "tool_label="
if not defined check_ram goto :eof
if %check_ram% leq %LITE_MAX_GB% (
    set "tool_dir=%LITE_DIR%"
    set "antutu_apk=Antutu_3D_Lite_10.2.9.apk"
    set "test_id=002"
    set "tool_label=Antutu_v10_Lite"
) else (
    set "tool_dir=%FULL_DIR%"
    set "antutu_apk=antutu_benchmark_v10_3d.apk"
    set "test_id=001"
    set "tool_label=Antutu_v10"
)
goto :eof
