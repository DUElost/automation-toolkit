@echo off
setlocal
rem MTBF 离线老化入口
rem 无参数：交互选 模式 → 设备 → APK 族 → 任务
rem 有参数：直接透传给 deploy.ps1，例如：
rem   runAll.bat -Mode jar -Serial all -Suite "模拟老化(仿RM老化+MTBF)_Trassion_2023_8_23"
cd /d "%~dp0\scripts"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\deploy.ps1" %*
if errorlevel 1 (
    echo.
    echo [ERROR] deploy failed
    pause
    exit /b 1
)
echo.
pause
