@echo off
setlocal
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0deploy-system-offline-apk.ps1" %*
if errorlevel 1 (
    echo.
    echo [ERROR] 系统安装失败
    pause
    exit /b 1
)
echo.
pause
