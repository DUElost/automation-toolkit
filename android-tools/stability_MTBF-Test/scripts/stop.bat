@echo off
setlocal
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0stop.ps1" %*
if errorlevel 1 (
    echo.
    echo [ERROR] stop failed
    pause
    exit /b 1
)
echo.
pause
