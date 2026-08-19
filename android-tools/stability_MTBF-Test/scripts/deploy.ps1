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
$autoResume = ($cfg["auto.resume"] -eq "true")

Copy-Item $runtaskSrc $runtaskWork -Force
if ($TaskTimes -gt 0) {
    Write-MtbfStep "Set task times=$TaskTimes"
    Set-RuntaskTimes -RuntaskPath $runtaskWork -Times $TaskTimes
} else {
    Write-MtbfStep "Keep runtask.xml times from config/runtask.xml"
}

Install-MtbfApks -ApkDir $apkDir
Push-MtbfConfig -ConfigDir $configDir -RuntaskPath $runtaskWork
Test-MtbfSystemUid
Set-MtbfDeviceStability
Set-MtbfPrefs -Tester $Tester -AutoResume:$autoResume

Write-Host "`nDeploy complete." -ForegroundColor Green
adb shell dumpsys package com.ape.offlinescriptmanager 2>&1 | Select-String "sharedUser|versionName" | ForEach-Object { $_.Line.Trim() }

if ($autoStart) {
    Write-MtbfStep "Auto start task"
    Start-MtbfTask
    if (Test-RunTaskServiceRunning) {
        Write-Host "Task started. Auto-resume=$autoResume. Results: /sdcard/results/realresult/" -ForegroundColor Green
    } else {
        Write-Warning "RunTaskService may not be running. Check: adb shell dumpsys activity services com.ape.offlinescriptmanager"
    }
} else {
    Write-Host "Start manually: scripts\run.bat" -ForegroundColor Yellow
}
