@echo off
setlocal
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0taskmgr.ps1" %*
