@echo off
setlocal
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0deploy-and-run.ps1" %*
if errorlevel 1 (
    echo.
    echo [ERROR] deploy-and-run failed
    pause
    exit /b 1
)
echo.
pause
