#Requires -Version 5.1
param(
    [int]$TaskTimes = 0,
    [string]$Tester = "",
    [switch]$Start
)

$ErrorActionPreference = "Stop"
. (Join-Path $PSScriptRoot "lib.ps1")

if (-not (Get-Command adb -ErrorAction SilentlyContinue)) {
    throw "adb not found in PATH"
}

$root = Get-MtbfRoot
$apkDir = Join-Path $root "apk"
$configDir = Join-Path $root "config"
$runtaskSrc = Join-Path $configDir "runtask.xml"
$runtaskWork = Join-Path $env:TEMP "mtbf-runtask-$PID.xml"

$cfg = Read-MtbfConfig -Root $root
if ($TaskTimes -le 0) { $TaskTimes = [int]$cfg["task.times"] }
if (-not $Tester) { $Tester = $cfg["tester.name"] }
$autoStart = $Start -or ($cfg["auto.start"] -eq "true")

Copy-Item $runtaskSrc $runtaskWork -Force
if ($TaskTimes -gt 0) {
    Write-MtbfStep "Set task times=$TaskTimes"
    Set-RuntaskTimes -RuntaskPath $runtaskWork -Times $TaskTimes
}

Install-MtbfApks -ApkDir $apkDir
Push-MtbfConfig -ConfigDir $configDir -RuntaskPath $runtaskWork
Test-MtbfSystemUid
Set-MtbfPrefs -Tester $Tester

Write-Host "`nDeploy complete." -ForegroundColor Green
adb shell dumpsys package com.ape.offlinescriptmanager 2>&1 | Select-String "sharedUser|versionName" | ForEach-Object { $_.Line.Trim() }

if ($autoStart) {
    Write-MtbfStep "Auto start task"
    Start-MtbfTask
    Write-Host "Task started. Results: /sdcard/results/realresult/" -ForegroundColor Green
} else {
    Write-Host "Start manually: scripts\run.bat" -ForegroundColor Yellow
}
