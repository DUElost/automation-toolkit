@echo off
setlocal enabledelayedexpansion

rem GPU 专项统一停止入口：停止所有已连接设备上的 GPU 压测
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

echo Stopping GPU stress test on %device_count% device^(s^)...
for %%d in (%devices_list%) do call :stop_device %%d

echo.
echo All devices processed.
pause
exit /b 0

:stop_device
set "device=%~1"
echo.
echo [%device%] Stopping instrument, test framework, and Antutu...

rem UiAutomator / Transsion test framework
adb -s %device% shell am force-stop com.transsion.testcaserepository 2>nul
adb -s %device% shell am force-stop com.transsion.testcaserepository.test 2>nul
adb -s %device% shell am force-stop com.tinno.reliabilityuiautomatortest 2>nul
adb -s %device% shell am force-stop com.tinno.reliabilityuiautomatortest.test 2>nul

rem Antutu (Lite / Full) - GPU 压测实际跑在安兔兔进程里，仅停框架不会结束测试
adb -s %device% shell am force-stop com.antutu.benchmark.full.lite 2>nul
adb -s %device% shell am force-stop com.antutu.benchmark.full 2>nul

rem nohup 后台 am instrument 可能挂在 shell 下
adb -s %device% shell "pkill -f 'am instrument' 2>/dev/null; pkill -f TestStressGpu 2>/dev/null; pkill -f AndroidJUnitRunner 2>/dev/null; true" 2>nul

adb -s %device% shell "ps -A 2>/dev/null | grep -E 'testcaserepository|reliabilityuiautomatortest|antutu|instrument|AndroidJUnit' || echo (no related process)"
echo [%device%] Done.
goto :eof
