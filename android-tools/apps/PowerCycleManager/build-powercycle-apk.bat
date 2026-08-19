@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0build-powercycle-apk.ps1" %*
