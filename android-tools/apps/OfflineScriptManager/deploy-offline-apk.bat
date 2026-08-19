@echo off
REM 部署离线 APK 模式到已连接设备
setlocal
cd /d "%~dp0"

set ADB=adb
where adb >nul 2>&1 || (
    echo [ERROR] 未找到 adb，请确保 Android SDK platform-tools 在 PATH 中
    pause
    exit /b 1
)

echo == 检查设备 ==
%ADB% devices
for /f "skip=1 tokens=1" %%d in ('%ADB% devices') do (
    if not "%%d"=="" if not "%%d"=="List" set DEVICE=%%d
)
if not defined DEVICE (
    echo [ERROR] 未检测到已连接设备
    pause
    exit /b 1
)
echo 使用设备: %DEVICE%

echo.
echo == 授予存储权限（Android 11+ 必需）==
%ADB% shell appops set com.ape.offlinescriptmanager MANAGE_EXTERNAL_STORAGE allow
%ADB% shell pm grant com.ape.offlinescriptmanager android.permission.READ_EXTERNAL_STORAGE 2>nul
%ADB% shell pm grant com.ape.offlinescriptmanager android.permission.WRITE_EXTERNAL_STORAGE 2>nul

echo.
echo == 推送 runtask.xml 到 /sdcard/ ==
if not exist "runtask.xml" (
    echo [ERROR] 缺少 runtask.xml
    pause
    exit /b 1
)
%ADB% push "runtask.xml" /sdcard/runtask.xml

echo.
echo == 安装 OfflineScriptManager.apk ==
if not exist "OfflineScriptManager.apk" (
    echo [ERROR] 缺少 OfflineScriptManager.apk，请先运行 build-offline-apk.bat
    pause
    exit /b 1
)
%ADB% install -r "OfflineScriptManager.apk"

echo.
echo == 启动 BatteryActivity ==
%ADB% shell am start -n com.ape.offlinescriptmanager/com.ape.offlinescriptmanager.batterytool.BatteryActivity

echo.
echo == 检查进程 ==
timeout /t 2 >nul
%ADB% shell ps -A | findstr offlinescriptmanager

echo.
echo 部署完成。断开 adb 后设备可独立运行。
echo.
echo 使用提示:
echo   1. 先在 BATTERY PERCENTAGE 页打开 Data collection switch
echo   2. 在 FUNCTION TEST 页填写测试员姓名，点击右下角 FAB 启动任务
echo   3. 或通过 adb 启动: am start-foreground-service -a ...RunTaskService.action.start -n ...RunTaskService
echo.
echo 结果目录: /sdcard/results/realresult/  /sdcard/results/log/
pause
