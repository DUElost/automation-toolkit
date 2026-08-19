#Requires -Version 5.1
param(
    [switch]$Force
)

$ErrorActionPreference = "Stop"
. (Join-Path $PSScriptRoot "lib.ps1")

if (-not (Get-Command adb -ErrorAction SilentlyContinue)) {
    throw "adb not found in PATH"
}

Stop-PowerCycleAll -Force:$Force
Write-Host "`nPower cycle test stopped." -ForegroundColor Green
