@echo off
setlocal
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0build-offline-apk.ps1" %*
if errorlevel 1 (
    echo.
    echo [ERROR] 构建失败
    pause
    exit /b 1
)
echo.
pause
