#Requires -Version 5.1
param(
    [string]$Mode = "",
    [string]$Serial = "",
    [switch]$Force,
    [switch]$All
)

$ErrorActionPreference = "Stop"
. (Join-Path $PSScriptRoot "lib.ps1")

Remove-Item Env:ANDROID_SERIAL -ErrorAction SilentlyContinue

if (-not (Get-Command adb -ErrorAction SilentlyContinue)) {
    throw "adb not found in PATH"
}

$resolvedMode = $Mode
if (-not $resolvedMode) {
    $resolvedMode = Get-MtbfLastMode
}

$serialArg = $Serial
if ($All) { $serialArg = "all" }

$serials = @(Resolve-MtbfDevices -Serial $serialArg -Interactive:(-not [bool]$serialArg))
Invoke-MtbfStopMulti -Serials $serials -Mode $resolvedMode -Force:$Force

Write-Host "`nMTBF task stopped. mode=$resolvedMode devices=$($serials -join ', ')" -ForegroundColor Green
