#Requires -Version 5.1

$script:SleepTestPkg = "com.tinno.autotesttool"
$script:SleepTestService = "com.mediatek.schpwronoff.sleeptest.SleepTestService"
$script:SleepTestActivity = "com.mediatek.schpwronoff.sleeptest.SleepTestActivity"
$script:SleepTestPrefs = "sleep_test_runner"

function Get-SleepTestRoot {
    return (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
}

function Read-SleepTestConfig {
    param([string]$Root = (Get-SleepTestRoot))
    $cfg = @{
        "test.times"    = 100
        "wake.seconds"  = 60
        "sleep.seconds" = 300
        "tester.name"   = "tester"
        "auto.start"    = "false"
        "auto.resume"   = "true"
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

function Write-SleepTestStep([string]$Msg) {
    Write-Host "`n==> $Msg" -ForegroundColor Cyan
}

function Get-SleepTestAppUid {
    $info = adb shell dumpsys package $script:SleepTestPkg 2>&1 | Out-String
    if ($info -match "sharedUser=SharedUserSetting.*android\.uid\.system") { return 1000 }
    if ($info -match '\buserId=(\d+)') { return [int]$Matches[1] }
    if ($info -match '\buid=(\d+)') { return [int]$Matches[1] }
    throw "Cannot resolve uid for $script:SleepTestPkg"
}

function Test-AdbRoot {
    adb root 2>$null | Out-Null
    Start-Sleep -Seconds 1
    $id = adb shell id 2>&1 | Out-String
    return ($id -match 'uid=0')
}

function Get-SleepTestPrefsXml {
    $rel = "shared_prefs/$script:SleepTestPrefs.xml"
    $out = cmd /c "adb shell run-as $script:SleepTestPkg cat $rel 2>nul"
    if (-not $out) { return "" }
    $text = if ($out -is [array]) { ($out | Out-String).Trim() } else { $out.ToString().Trim() }
    if ($text -and $text -notmatch "Permission denied|No such file|run-as:") {
        return $text
    }
    return ""
}

function Repair-SleepTestPrefsOwnership {
    if (Get-SleepTestPrefsXml) { return }
    if (-not (Test-AdbRoot)) { return }
    Write-SleepTestStep "Repair prefs ownership"
    $prefFile = "/data/data/$script:SleepTestPkg/shared_prefs/$script:SleepTestPrefs.xml"
    adb shell "rm -f $prefFile" 2>$null | Out-Null
}

function Push-SleepTestPrefsXml {
    param([string]$XmlContent)
    $tmpLocal = Join-Path $env:TEMP "sleep_test_runner-$PID.xml"
    $prefDir = "/data/data/$script:SleepTestPkg/shared_prefs"
    $prefFile = "$prefDir/$script:SleepTestPrefs.xml"
    [System.IO.File]::WriteAllText($tmpLocal, $XmlContent, (New-Object System.Text.UTF8Encoding $false))

    if (Test-AdbRoot) {
        $uid = Get-SleepTestAppUid
        adb shell "mkdir -p $prefDir" 2>$null | Out-Null
        adb push $tmpLocal $prefFile | Out-Null
        if ($LASTEXITCODE -ne 0) { throw "adb push prefs failed" }
        if ($uid -eq 1000) {
            adb shell "chown system:system $prefFile && chmod 660 $prefFile" 2>$null | Out-Null
        } else {
            adb shell "chown ${uid}:${uid} $prefFile && chmod 660 $prefFile" 2>$null | Out-Null
        }
        Remove-Item $tmpLocal -Force -ErrorAction SilentlyContinue
        return
    }

    adb shell run-as $script:SleepTestPkg "mkdir -p shared_prefs" 2>$null | Out-Null
    Get-Content $tmpLocal -Raw -Encoding UTF8 | adb shell run-as $script:SleepTestPkg "sh -c 'cat > shared_prefs/$($script:SleepTestPrefs).xml'" 2>$null | Out-Null
    if ($LASTEXITCODE -ne 0) { throw "run-as write prefs failed" }
    Remove-Item $tmpLocal -Force -ErrorAction SilentlyContinue
}

function Update-SleepTestPrefsField {
    param(
        [string]$Xml,
        [string]$Name,
        [string]$Value,
        [ValidateSet("int", "string", "boolean")]
        [string]$Type
    )
    $replacement = switch ($Type) {
        "int"     { "<int name=`"$Name`" value=`"$Value`"/>" }
        "string"  { "<string name=`"$Name`">$Value</string>" }
        "boolean" { "<boolean name=`"$Name`" value=`"$Value`"/>" }
    }
    if ($Xml -match "name=`"$Name`"") {
        return ($Xml -replace "<(int|string|boolean) name=`"$Name`"[^/]*/>", $replacement)
    }
    return $Xml -replace "</map>", "    $replacement`n</map>"
}

function Set-SleepTestPrefs {
    param(
        [int]$TestTimes,
        [int]$WakeSeconds,
        [int]$SleepSeconds,
        [string]$Tester,
        [bool]$AutoResume = $true,
        [bool]$ResetCount = $false
    )
    Write-SleepTestStep "Write sleep_test_runner prefs"
    Repair-SleepTestPrefsOwnership

    $currentCount = 0
    if (-not $ResetCount) {
        $existing = Get-SleepTestPrefsXml
        if ($existing -match 'name="current_count" value="(\d+)"') {
            $currentCount = [int]$Matches[1]
        }
    }

    $resumeVal = if ($AutoResume) { "true" } else { "false" }
    @"
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <int name="test_times" value="$TestTimes"/>
    <int name="current_count" value="$currentCount"/>
    <int name="wake_seconds" value="$WakeSeconds"/>
    <int name="sleep_seconds" value="$SleepSeconds"/>
    <boolean name="auto_resume" value="$resumeVal"/>
    <boolean name="running" value="false"/>
    <string name="phase">idle</string>
    <string name="tester_name">$Tester</string>
</map>
"@ | ForEach-Object { Push-SleepTestPrefsXml -XmlContent $_ }
}

function Set-ZteAppSmartOptimizeAllowed {
    $ztePkg = "com.zte.heartyservice.strategy"
    $pathOut = adb shell "pm path $ztePkg" 2>$null | Out-String
    if ($pathOut -notmatch "package:") { return }

    Write-SleepTestStep "Set ZTE Smart Optimize to Allowed (auto-start / secondary / background)"
    if (-not (Test-AdbRoot)) {
        Write-Warning "adb root required to write ZTE UserStrategy.db"
        return
    }

    $pkg = $script:SleepTestPkg
    $db = "/data/user/0/$ztePkg/databases/UserStrategy.db"
    $shLocal = Join-Path $env:TEMP "sleeptest-zte-allow-$PID.sh"
    $shRemote = "/data/local/tmp/sleeptest-zte-allow.sh"
    $sh = @"
if [ ! -f "$db" ]; then
  echo "UserStrategy.db not found"
  exit 0
fi
sqlite3 "$db" "INSERT INTO app_settings (pkg_name, editable, locked, self_start_mode, related_start_mode, bg_run_mode, app_user_install) SELECT '$pkg', 1, 0, 3, 3, 3, 1 WHERE NOT EXISTS (SELECT 1 FROM app_settings WHERE pkg_name='$pkg');"
sqlite3 "$db" "UPDATE app_settings SET self_start_mode=3, related_start_mode=3, bg_run_mode=3 WHERE pkg_name='$pkg';"
sqlite3 "$db" "SELECT pkg_name,self_start_mode,related_start_mode,bg_run_mode FROM app_settings WHERE pkg_name='$pkg';"
"@
    [System.IO.File]::WriteAllText($shLocal, $sh.Replace("`r`n", "`n"), (New-Object System.Text.UTF8Encoding $false))
    adb push $shLocal $shRemote | Out-Null
    Remove-Item $shLocal -Force -ErrorAction SilentlyContinue
    $result = adb shell "sh $shRemote" 2>&1 | Out-String
    $result = $result.Trim()
    if ($result -match "$([regex]::Escape($pkg))\|3\|3\|3") {
        Write-Host "ZTE modes = Allowed (3/3/3)" -ForegroundColor Green
    } else {
        Write-Warning "ZTE Smart Optimize write result: $result"
    }
}

function Set-SleepTestDeviceStability {
    Write-SleepTestStep "Apply device stability settings (allow screen off)"
    adb root 2>$null | Out-Null
    Start-Sleep -Seconds 1
    # 休眠测试必须允许灭屏：关闭 USB 常亮
    adb shell svc power stayon false 2>$null | Out-Null
    adb shell settings put global stay_on_while_plugged_in 0 2>$null | Out-Null
    adb shell settings put system screen_off_timeout 1800000 2>$null | Out-Null
    adb shell appops set $script:SleepTestPkg WRITE_SETTINGS allow 2>$null | Out-Null
    adb shell appops set $script:SleepTestPkg SYSTEM_ALERT_WINDOW allow 2>$null | Out-Null
    adb shell dumpsys deviceidle whitelist +$script:SleepTestPkg 2>$null | Out-Null
    adb shell cmd appops set $script:SleepTestPkg RUN_ANY_IN_BACKGROUND allow 2>$null | Out-Null
    adb shell locksettings set-disabled true 2>$null | Out-Null
}

function Grant-SleepTestStorage {
    Write-SleepTestStep "Grant storage permissions"
    adb shell pm grant $script:SleepTestPkg android.permission.READ_EXTERNAL_STORAGE 2>$null | Out-Null
    adb shell pm grant $script:SleepTestPkg android.permission.WRITE_EXTERNAL_STORAGE 2>$null | Out-Null
    adb root 2>$null | Out-Null
    Start-Sleep -Seconds 1
    adb shell cmd appops set $script:SleepTestPkg MANAGE_EXTERNAL_STORAGE allow 2>$null | Out-Null
}

function Install-SleepTestApk {
    param([string]$ApkDir)
    $apk = Join-Path $ApkDir "AutoTestTool.apk"
    if (-not (Test-Path $apk)) {
        throw "APK not found: $apk. Run apps\SleepTestManager\build-sleep-apk.bat first."
    }
    Write-SleepTestStep "Install AutoTestTool (platform sign)"
    adb shell am force-stop $script:SleepTestPkg 2>$null | Out-Null
    adb uninstall $script:SleepTestPkg 2>$null | Out-Null
    adb install -r $apk
    if ($LASTEXITCODE -ne 0) { throw "install AutoTestTool.apk failed" }
    Set-ZteAppSmartOptimizeAllowed
}

function Test-SleepTestServiceRunning {
    $out = adb shell "dumpsys activity services $script:SleepTestPkg 2>/dev/null" 2>&1 | Out-String
    return ($out -match "SleepTestService")
}

function Set-SleepTestStopFlags {
    Write-SleepTestStep "Set auto_resume=false, running=false"
    Repair-SleepTestPrefsOwnership
    $xml = Get-SleepTestPrefsXml
    if (-not $xml) {
        $xml = @"
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <boolean name="auto_resume" value="false"/>
    <boolean name="running" value="false"/>
</map>
"@
    } else {
        $xml = Update-SleepTestPrefsField -Xml $xml -Name "auto_resume" -Value "false" -Type "boolean"
        $xml = Update-SleepTestPrefsField -Xml $xml -Name "running" -Value "false" -Type "boolean"
    }
    Push-SleepTestPrefsXml -XmlContent $xml
}

function Start-SleepTestTask {
    adb shell am force-stop $script:SleepTestPkg 2>$null | Out-Null

    $xml = Get-SleepTestPrefsXml
    if ($xml) {
        $xml = Update-SleepTestPrefsField -Xml $xml -Name "running" -Value "true" -Type "boolean"
        Push-SleepTestPrefsXml -XmlContent $xml
    }

    adb shell am start -n "$script:SleepTestPkg/$script:SleepTestActivity" 2>$null | Out-Null
    Start-Sleep -Seconds 2
    adb shell am start-foreground-service -n "$script:SleepTestPkg/$script:SleepTestService" -a com.tinno.autotesttool.action.SLEEP_TEST_START 2>$null | Out-Null
    Start-Sleep -Seconds 2
    adb shell am broadcast -a com.tinno.autotesttool.action.SLEEP_TEST_KEEPALIVE -n "$script:SleepTestPkg/com.mediatek.schpwronoff.sleeptest.SleepTestKeepAliveReceiver" 2>$null | Out-Null
}

function Start-SleepTestWakeWatchdog {
    $serial = ""
    $line = cmd /c "adb devices 2>nul" | Select-String "^\S+\s+device$" | Select-Object -First 1
    if ($line) { $serial = ($line.ToString() -split "\s+")[0] }
    Stop-SleepTestWakeWatchdog
    $watchdog = Join-Path $PSScriptRoot "wake-watchdog.ps1"
    Write-SleepTestStep "Start PC WakeUpActivity watchdog (screen-off alarms dropped on this OEM)"
    Start-Process powershell -WindowStyle Hidden -ArgumentList @(
        "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", $watchdog, "-Serial", $serial
    ) | Out-Null
}

function Stop-SleepTestWakeWatchdog {
    Get-ChildItem (Join-Path $env:TEMP "sleeptest-watchdog-*.stop") -ErrorAction SilentlyContinue | ForEach-Object {
        Set-Content -Path $_.FullName -Value "stop" -Encoding ASCII
    }
}

function Stop-SleepTestTask {
    param([switch]$Force)

    Stop-SleepTestWakeWatchdog
    Set-SleepTestStopFlags

    if (Test-SleepTestServiceRunning) {
        Write-SleepTestStep "Stop SleepTestService gracefully"
        adb shell am startservice -n "$script:SleepTestPkg/$script:SleepTestService" -a com.tinno.autotesttool.action.SLEEP_TEST_STOP
        Start-Sleep -Seconds 3
    }

    Write-SleepTestStep "Force stop AutoTestTool"
    adb shell am force-stop $script:SleepTestPkg 2>$null | Out-Null
    Start-Sleep -Seconds 1

    if ($Force -and (Test-SleepTestServiceRunning)) {
        throw "Failed to stop SleepTestService"
    }
}

function Deploy-SleepTest {
    param(
        [string]$ApkDir,
        [int]$TestTimes,
        [int]$WakeSeconds,
        [int]$SleepSeconds,
        [string]$Tester,
        [bool]$AutoResume,
        [bool]$AutoStart
    )
    Install-SleepTestApk -ApkDir $ApkDir
    Set-SleepTestDeviceStability
    Grant-SleepTestStorage
    Set-SleepTestPrefs -TestTimes $TestTimes -WakeSeconds $WakeSeconds -SleepSeconds $SleepSeconds `
        -Tester $Tester -AutoResume:$AutoResume -ResetCount $true
    Write-Host "`nDeploy complete." -ForegroundColor Green
    adb shell dumpsys package $script:SleepTestPkg 2>&1 | Select-String "versionName|sharedUser" | ForEach-Object { $_.Line.Trim() }
    if ($AutoStart) {
        Write-SleepTestStep "Auto start sleep wakeup test"
        Start-SleepTestTask
        if (Test-SleepTestServiceRunning) {
            Write-Host "Test started. Wake=${WakeSeconds}s Sleep=${SleepSeconds}s Times=$TestTimes" -ForegroundColor Green
            Write-Host "Results: /sdcard/Android/data/$script:SleepTestPkg/files/SleepTest/sleep_test_result.txt" -ForegroundColor Green
        } else {
            Write-Warning "SleepTestService may not be running."
        }
    } else {
        Write-Host "Start manually: scripts\run.bat" -ForegroundColor Yellow
    }
}

function Run-SleepTest {
    param(
        [int]$TestTimes,
        [int]$WakeSeconds,
        [int]$SleepSeconds,
        [string]$Tester,
        [bool]$AutoResume,
        [switch]$ResetCount
    )
    Grant-SleepTestStorage
    Set-ZteAppSmartOptimizeAllowed
    Set-SleepTestPrefs -TestTimes $TestTimes -WakeSeconds $WakeSeconds -SleepSeconds $SleepSeconds `
        -Tester $Tester -AutoResume:$AutoResume -ResetCount:($ResetCount.IsPresent)
    Write-SleepTestStep "Start sleep wakeup test (offline)"
    Start-SleepTestTask
    if (Test-SleepTestServiceRunning) {
        Write-Host "`nTest started. Results: /sdcard/Android/data/$script:SleepTestPkg/files/SleepTest/" -ForegroundColor Green
    } else {
        Write-Warning "SleepTestService may not be running."
    }
}
