#Requires -Version 5.1
param(
    [switch]$Force
)

$ErrorActionPreference = "Stop"
. (Join-Path $PSScriptRoot "lib.ps1")

if (-not (Get-Command adb -ErrorAction SilentlyContinue)) {
    throw "adb not found in PATH"
}

Stop-SleepTestTask -Force:$Force
Write-Host "`nSleep wakeup test stopped." -ForegroundColor Green
