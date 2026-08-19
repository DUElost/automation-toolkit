#Requires -Version 5.1

function Get-MtbfRoot {
    return (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
}

function Read-MtbfConfig {
    param([string]$Root = (Get-MtbfRoot))
    $cfg = @{
        "task.times"        = 100
        "run.duration.days" = 7
        "tester.name"       = "tester"
        "auto.start"        = "false"
        "auto.resume"       = "true"
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
    param([string]$Tester, [bool]$AutoResume = $true)
    Write-MtbfStep "Write app prefs (data collection + tester)"
    adb root | Out-Null
    Start-Sleep -Seconds 2
    $prefDir = "/data/data/com.ape.offlinescriptmanager/shared_prefs"
    $tmpDir = Join-Path $env:TEMP "mtbf-prefs-$PID"
    if (Test-Path $tmpDir) { Remove-Item $tmpDir -Recurse -Force }
    New-Item -ItemType Directory -Path $tmpDir | Out-Null

    @"
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <boolean name="isUpdating" value="true"/>
</map>
"@ | Set-Content -Path (Join-Path $tmpDir "update_data.xml") -Encoding UTF8 -NoNewline

    @"
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <string name="task_creator">$Tester</string>
</map>
"@ | Set-Content -Path (Join-Path $tmpDir "test_task_data.xml") -Encoding UTF8 -NoNewline

    $resumeVal = if ($AutoResume) { "true" } else { "false" }
    @"
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <boolean name="auto_resume" value="$resumeVal"/>
</map>
"@ | Set-Content -Path (Join-Path $tmpDir "mtbf_runner.xml") -Encoding UTF8 -NoNewline

    adb shell "mkdir -p $prefDir"
    adb push (Join-Path $tmpDir "update_data.xml") "$prefDir/update_data.xml"
    adb push (Join-Path $tmpDir "test_task_data.xml") "$prefDir/test_task_data.xml"
    adb push (Join-Path $tmpDir "mtbf_runner.xml") "$prefDir/mtbf_runner.xml"
    adb shell "chown system:system $prefDir/update_data.xml $prefDir/test_task_data.xml $prefDir/mtbf_runner.xml"
    adb shell "chmod 660 $prefDir/update_data.xml $prefDir/test_task_data.xml $prefDir/mtbf_runner.xml"
    Remove-Item $tmpDir -Recurse -Force
}

function Set-MtbfDeviceStability {
    Write-MtbfStep "Apply device stability settings (7-day MTBF)"
    adb root | Out-Null
    Start-Sleep -Seconds 1
    adb shell svc power stayon true 2>$null | Out-Null
    adb shell settings put system screen_off_timeout 2147483647 2>$null | Out-Null
    adb shell settings put global stay_on_while_plugged_in 7 2>$null | Out-Null
    adb shell locksettings set-disabled true 2>$null | Out-Null
}

function Test-RunTaskServiceRunning {
    $out = adb shell "dumpsys activity services com.ape.offlinescriptmanager 2>/dev/null" 2>&1 | Out-String
    return ($out -match "RunTaskService")
}

function Set-MtbfAutoResume {
    param([bool]$Enabled)
    adb root | Out-Null
    Start-Sleep -Seconds 1
    $prefDir = "/data/data/com.ape.offlinescriptmanager/shared_prefs"
    $tmpFile = Join-Path $env:TEMP "mtbf_runner-$PID.xml"
    $resumeVal = if ($Enabled) { "true" } else { "false" }
    @"
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <boolean name="auto_resume" value="$resumeVal"/>
</map>
"@ | Set-Content -Path $tmpFile -Encoding UTF8 -NoNewline
    adb shell "mkdir -p $prefDir"
    adb push $tmpFile "$prefDir/mtbf_runner.xml"
    adb shell "chown system:system $prefDir/mtbf_runner.xml"
    adb shell "chmod 660 $prefDir/mtbf_runner.xml"
    Remove-Item $tmpFile -Force -ErrorAction SilentlyContinue
}

function Stop-MtbfTask {
    param([switch]$Force)
    Write-MtbfStep "Disable auto-resume (prevent watchdog restart)"
    Set-MtbfAutoResume -Enabled $false

    if (Test-RunTaskServiceRunning) {
        Write-MtbfStep "Stop RunTaskService gracefully"
        adb shell am startservice -n com.ape.offlinescriptmanager/com.ape.offlinescriptmanager.view.RunTaskService -a com.ape.offlinescriptmanager.view.RunTaskService.action.stop
        Start-Sleep -Seconds 3
    } else {
        Write-Host "RunTaskService is not running." -ForegroundColor Yellow
    }

    if ($Force -or (Test-RunTaskServiceRunning)) {
        Write-MtbfStep "Force stop OfflineScriptManager"
        adb shell am force-stop com.ape.offlinescriptmanager 2>$null | Out-Null
        Start-Sleep -Seconds 1
    }

    if (Test-RunTaskServiceRunning) {
        throw "Failed to stop RunTaskService. Try: stop.bat -Force"
    }
}

function Start-MtbfTask {
    adb shell am force-stop com.ape.offlinescriptmanager 2>$null | Out-Null
    adb shell am start -n com.ape.offlinescriptmanager/com.ape.offlinescriptmanager.batterytool.BatteryActivity | Out-Null
    Start-Sleep -Seconds 2
    adb shell am start-foreground-service -n com.ape.offlinescriptmanager/com.ape.offlinescriptmanager.view.RunTaskService -a com.ape.offlinescriptmanager.view.RunTaskService.action.start
    Start-Sleep -Seconds 2
    adb shell am broadcast -a com.ape.offlinescriptmanager.action.MTBF_KEEPALIVE -n com.ape.offlinescriptmanager/.receiver.MtbfAutoResumeReceiver 2>$null | Out-Null
}

function Test-MtbfSystemUid {
    $info = adb shell dumpsys package com.ape.offlinescriptmanager 2>&1 | Out-String
    if ($info -notmatch "sharedUser=SharedUserSetting.*android\.uid\.system") {
        throw "OfflineScriptManager is not system uid. Use platform-signed APK from apps/OfflineScriptManager build."
    }
}
