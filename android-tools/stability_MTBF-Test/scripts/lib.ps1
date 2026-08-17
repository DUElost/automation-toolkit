#Requires -Version 5.1

function Get-MtbfRoot {
    return (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
}

function Read-MtbfConfig {
    param([string]$Root = (Get-MtbfRoot))
    $cfg = @{
        "task.times"   = 1
        "tester.name"  = "tester"
        "auto.start"   = "false"
    }
    $path = Join-Path $Root "test-config.properties"
    if (-not (Test-Path $path)) { return $cfg }
    Get-Content $path -Encoding UTF8 | ForEach-Object {
        $line = $_.Trim()
        if ($line -and -not $line.StartsWith("#") -and $line -match '^([^=]+)=(.*)$') {
            $cfg[$Matches[1].Trim()] = $Matches[2].Trim()
        }
    }
    return $cfg
}

function Write-MtbfStep([string]$Msg) {
    Write-Host "`n==> $Msg" -ForegroundColor Cyan
}

function Set-RuntaskTimes {
    param([string]$RuntaskPath, [int]$Times)
    if ($Times -le 0) { return }
    $xml = Get-Content $RuntaskPath -Raw -Encoding UTF8
    $xml = $xml -replace '(<runtask\b[^>]*\btimes=")\d+(")', "`${1}$Times`${2}"
    Set-Content -Path $RuntaskPath -Value $xml -Encoding UTF8 -NoNewline
}

function Install-MtbfApks {
    param([string]$ApkDir)
    Write-MtbfStep "Install test APKs"
    adb install -r (Join-Path $ApkDir "ReliabilityUiautomatorTest.apk")
    if ($LASTEXITCODE -ne 0) { throw "install ReliabilityUiautomatorTest.apk failed" }
    adb install -r (Join-Path $ApkDir "ReliabilityUiautomatorTestTest.apk")
    if ($LASTEXITCODE -ne 0) { throw "install ReliabilityUiautomatorTestTest.apk failed" }

    Write-MtbfStep "Install OfflineScriptManager (platform/system)"
    adb shell am force-stop com.ape.offlinescriptmanager 2>$null | Out-Null
    adb uninstall com.ape.offlinescriptmanager 2>$null | Out-Null
    adb install -r (Join-Path $ApkDir "OfflineScriptManager.apk")
    if ($LASTEXITCODE -ne 0) { throw "install OfflineScriptManager.apk failed" }
}

function Push-MtbfConfig {
    param([string]$ConfigDir, [string]$RuntaskPath)
    Write-MtbfStep "Push config to /sdcard/"
    adb push (Join-Path $ConfigDir "UiAutomatorTestData.xml") /sdcard/UiAutomatorTestData.xml
    adb push $RuntaskPath /sdcard/runtask.xml
    adb shell appops set com.ape.offlinescriptmanager MANAGE_EXTERNAL_STORAGE allow
}

function Set-MtbfPrefs {
    param([string]$Tester)
    Write-MtbfStep "Write app prefs (data collection + tester)"
    adb root | Out-Null
    Start-Sleep -Seconds 2
    $prefDir = "/data/data/com.ape.offlinescriptmanager/shared_prefs"
    adb shell "mkdir -p $prefDir"
    adb shell "printf '<?xml version=\"1.0\" encoding=\"utf-8\" standalone=\"yes\" ?><map><boolean name=\"isUpdating\" value=\"true\"/></map>' > $prefDir/update_data.xml"
    adb shell "printf '<?xml version=\"1.0\" encoding=\"utf-8\" standalone=\"yes\" ?><map><string name=\"task_creator\">$Tester</string></map>' > $prefDir/test_task_data.xml"
    adb shell "chown system:system $prefDir/update_data.xml $prefDir/test_task_data.xml"
    adb shell "chmod 660 $prefDir/update_data.xml $prefDir/test_task_data.xml"
}

function Start-MtbfTask {
    adb shell am force-stop com.ape.offlinescriptmanager 2>$null | Out-Null
    adb shell am start -n com.ape.offlinescriptmanager/com.ape.offlinescriptmanager.batterytool.BatteryActivity | Out-Null
    Start-Sleep -Seconds 2
    adb shell am start-foreground-service -n com.ape.offlinescriptmanager/com.ape.offlinescriptmanager.view.RunTaskService -a com.ape.offlinescriptmanager.view.RunTaskService.action.start
}

function Test-MtbfSystemUid {
    $info = adb shell dumpsys package com.ape.offlinescriptmanager 2>&1 | Out-String
    if ($info -notmatch "sharedUser=SharedUserSetting.*android\.uid\.system") {
        throw "OfflineScriptManager is not system uid. Use platform-signed APK from stability_OfflineScriptManager build."
    }
}
