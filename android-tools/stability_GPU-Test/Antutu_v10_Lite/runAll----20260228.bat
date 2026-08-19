@echo off
rem 兼容旧路径：转发到 GPU 专项统一入口
cd /d "%~dp0.."
call "%~dp0..\runAll----20260228.bat" %*
