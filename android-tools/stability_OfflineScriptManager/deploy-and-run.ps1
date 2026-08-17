#Requires -Version 5.1
param(
    [string]$ApkPath = (Join-Path $PSScriptRoot "OfflineScriptManager.apk"),
    [string]$RuntaskPath = (Join-Path $PSScriptRoot "runtask.xml"),
    [int]$TaskTimes = 0,
    [string]$Tester = "tester",
    [switch]$SkipInstall
)

$ErrorActionPreference = "Stop"

function Write-Step([string]$Msg) {
    Write-Host "`n==> $Msg" -ForegroundColor Cyan
}

if (-not (Get-Command adb -ErrorAction SilentlyContinue)) {
    throw "adb not found in PATH"
}

if ($TaskTimes -gt 0) {
    Write-Step "Patch runtask.xml times=$TaskTimes"
    if (-not (Test-Path $RuntaskPath)) { throw "runtask.xml not found: $RuntaskPath" }
    $xml = Get-Content $RuntaskPath -Raw -Encoding UTF8
    $xml = $xml -replace '(<runtask\b[^>]*\btimes=")\d+(")', "`${1}$TaskTimes`${2}"
    Set-Content -Path $RuntaskPath -Value $xml -Encoding UTF8 -NoNewline
}

if (-not $SkipInstall) {
    & (Join-Path $PSScriptRoot "deploy-system-offline-apk.ps1") -ApkPath $ApkPath
} else {
    Write-Step "Skip install, push runtask only"
    if (Test-Path $RuntaskPath) {
        adb push $RuntaskPath /sdcard/runtask.xml
    }
    adb shell appops set com.ape.offlinescriptmanager MANAGE_EXTERNAL_STORAGE allow
}

Write-Step "Write SharedPreferences (data collection + tester)"
adb root | Out-Null
Start-Sleep -Seconds 2
$prefDir = "/data/data/com.ape.offlinescriptmanager/shared_prefs"
adb shell "mkdir -p $prefDir"
adb shell "printf '<?xml version=\"1.0\" encoding=\"utf-8\" standalone=\"yes\" ?><map><boolean name=\"isUpdating\" value=\"true\"/></map>' > $prefDir/update_data.xml"
adb shell "printf '<?xml version=\"1.0\" encoding=\"utf-8\" standalone=\"yes\" ?><map><string name=\"task_creator\">$Tester</string></map>' > $prefDir/test_task_data.xml"
adb shell "chown system:system $prefDir/update_data.xml $prefDir/test_task_data.xml"
adb shell "chmod 660 $prefDir/update_data.xml $prefDir/test_task_data.xml"

Write-Step "Start offline task"
adb shell am force-stop com.ape.offlinescriptmanager 2>$null | Out-Null
adb shell am start -n com.ape.offlinescriptmanager/com.ape.offlinescriptmanager.batterytool.BatteryActivity | Out-Null
Start-Sleep -Seconds 2
adb shell am start-foreground-service -n com.ape.offlinescriptmanager/com.ape.offlinescriptmanager.view.RunTaskService -a com.ape.offlinescriptmanager.view.RunTaskService.action.start

Write-Host "`nTask started. Results: /sdcard/results/realresult/" -ForegroundColor Green
Write-Host "Stop: adb shell am startservice -n com.ape.offlinescriptmanager/com.ape.offlinescriptmanager.view.RunTaskService -a com.ape.offlinescriptmanager.view.RunTaskService.action.stop"
