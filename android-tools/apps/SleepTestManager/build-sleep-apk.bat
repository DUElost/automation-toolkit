@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0build-sleep-apk.ps1" %*
