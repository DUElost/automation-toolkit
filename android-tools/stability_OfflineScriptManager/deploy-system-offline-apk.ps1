#Requires -Version 5.1
param(
    [string]$ApkPath = (Join-Path $PSScriptRoot "OfflineScriptManager.apk")
)

$ErrorActionPreference = "Stop"

function Write-Step([string]$Msg) {
    Write-Host "`n==> $Msg" -ForegroundColor Cyan
}

if (-not (Test-Path $ApkPath)) {
    throw "APK not found: $ApkPath. Run build-offline-apk.bat first (sign.mode=platform)."
}

Write-Step "adb root"
adb root | Out-Null
Start-Sleep -Seconds 2

Write-Step "Stop old app and install platform-signed APK"
adb shell am force-stop com.ape.offlinescriptmanager | Out-Null
adb uninstall com.ape.offlinescriptmanager 2>$null | Out-Null
adb install -r $ApkPath
if ($LASTEXITCODE -ne 0) {
    throw "adb install failed"
}

Write-Step "Push runtask.xml and grant storage"
$runtask = Join-Path $PSScriptRoot "runtask.xml"
if (Test-Path $runtask) {
    adb push $runtask /sdcard/runtask.xml
}
adb shell appops set com.ape.offlinescriptmanager MANAGE_EXTERNAL_STORAGE allow

Write-Step "Verify system uid"
$info = adb shell dumpsys package com.ape.offlinescriptmanager 2>&1 | Out-String
if ($info -notmatch "sharedUser=SharedUserSetting.*android\.uid\.system") {
    throw "sharedUser is not android.uid.system - check sign.mode=platform and remove.shared.user.id=false"
}
$info | Select-String "sharedUser|versionName|codePath" | ForEach-Object { $_.Line.Trim() }

Write-Host "`nDeploy done (pm install, no /system remount needed on erofs)." -ForegroundColor Green
Write-Host "Start: adb shell am start -n com.ape.offlinescriptmanager/com.ape.offlinescriptmanager.batterytool.BatteryActivity"
