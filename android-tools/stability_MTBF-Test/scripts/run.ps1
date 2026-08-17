#Requires -Version 5.1
param(
    [int]$TaskTimes = 0,
    [string]$Tester = "",
    [switch]$RedeployConfig
)

$ErrorActionPreference = "Stop"
. (Join-Path $PSScriptRoot "lib.ps1")

if (-not (Get-Command adb -ErrorAction SilentlyContinue)) {
    throw "adb not found in PATH"
}

$root = Get-MtbfRoot
$configDir = Join-Path $root "config"
$runtaskSrc = Join-Path $configDir "runtask.xml"
$runtaskWork = Join-Path $env:TEMP "mtbf-runtask-$PID.xml"

$cfg = Read-MtbfConfig -Root $root
if ($TaskTimes -le 0) { $TaskTimes = [int]$cfg["task.times"] }
if (-not $Tester) { $Tester = $cfg["tester.name"] }

Copy-Item $runtaskSrc $runtaskWork -Force
if ($TaskTimes -gt 0) {
    Write-MtbfStep "Set task times=$TaskTimes"
    Set-RuntaskTimes -RuntaskPath $runtaskWork -Times $TaskTimes
}

if ($RedeployConfig) {
    Push-MtbfConfig -ConfigDir $configDir -RuntaskPath $runtaskWork
} else {
    adb push $runtaskWork /sdcard/runtask.xml
}

Set-MtbfPrefs -Tester $Tester
Write-MtbfStep "Start offline MTBF task"
Start-MtbfTask

Write-Host "`nTask started. Results: /sdcard/results/realresult/" -ForegroundColor Green
Write-Host "Stop: adb shell am startservice -n com.ape.offlinescriptmanager/com.ape.offlinescriptmanager.view.RunTaskService -a com.ape.offlinescriptmanager.view.RunTaskService.action.stop"
