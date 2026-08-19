#Requires -Version 5.1

$script:PowerCyclePkg = "com.tinno.autotesttool"
$script:PowerCycleService = "com.mediatek.schpwronoff.powercycle.PowerCycleService"
$script:PowerCycleActivity = "com.mediatek.schpwronoff.powercycle.PowerCycleActivity"
$script:PowerCyclePrefs = "powercycle_runner"

$script:MssvPkg = "com.unisoc.mssv"
$script:MssvSleepRebootActivity = "com.unisoc.mssv/.view.SleepRebootActivity"
$script:MssvSleepRebootService = "com.unisoc.mssv/.service.SleepRebootService"
$script:MssvSleepRebootAction = "com.unisoc.mssv.intent.action.SLEEP_REBOOT"
$script:MssvPrefsName = "sleep_reboot"
$script:MssvResultLog = "/data/com.unisoc.mssv/sleepreboot/sleepreboot.log"
$script:MssvCompletionWatcherSh = "/data/local/tmp/mssv-completion-watch.sh"
$script:MssvCompletionWatcherPid = "/data/local/tmp/mssv-completion-watch.pid"

function Get-PowerCycleRoot {
    return (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
}

function Read-PowerCycleConfig {
    param([string]$Root = (Get-PowerCycleRoot))
    $cfg = @{
        "test.times"        = 100
        "test.mode"         = "reboot"
        "power.off.minutes" = 1
        "wait.seconds"      = 3
        "tester.name"       = "tester"
        "auto.start"        = "false"
        "auto.resume"       = "true"
        "backend"           = "auto"
        "mssv.apk.path"     = ""
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

function Write-PowerCycleStep([string]$Msg) {
    Write-Host "`n==> $Msg" -ForegroundColor Cyan
}

function Get-PowerCycleAppUid {
    $info = adb shell dumpsys package $script:PowerCyclePkg 2>&1 | Out-String
    if ($info -match "sharedUser=SharedUserSetting.*android\.uid\.system") { return 1000 }
    if ($info -match '\buserId=(\d+)') { return [int]$Matches[1] }
    if ($info -match '\buid=(\d+)') { return [int]$Matches[1] }
    throw "Cannot resolve uid for $script:PowerCyclePkg"
}

function Test-PowerCycleSystemUid {
    $info = adb shell dumpsys package $script:PowerCyclePkg 2>&1 | Out-String
    if ($info -match "sharedUser=SharedUserSetting.*android\.uid\.system") {
        Write-Host "  sharedUser=android.uid.system (OK)" -ForegroundColor Green
        return $true
    }
    $uid = Get-PowerCycleAppUid
    Write-Warning "AutoTestTool is not system uid (uid=$uid). Platform-signed userdebug builds may still reboot; formal devices require system uid."
    return $false
}

function Test-PowerCycleRebootPermission {
    $info = adb shell dumpsys package $script:PowerCyclePkg 2>&1 | Out-String
    if ($info -match "android\.permission\.REBOOT: granted=true") {
        Write-Host "  REBOOT permission: granted" -ForegroundColor Green
        return $true
    }
    $hasSu = cmd /c "adb shell which su 2>nul"
    if ($hasSu) {
        Write-Warning "REBOOT not granted on this device. Will use su fallback (userdebug). For production, install with matching platform sign."
        return $false
    }
    throw "REBOOT not granted and su not available. Use matching platform-signed system APK for this device model."
}

function Install-PowerCycleApk {
    param([string]$ApkDir)
    $apk = Join-Path $ApkDir "AutoTestTool.apk"
    if (-not (Test-Path $apk)) {
        throw "APK not found: $apk. Run apps\PowerCycleManager\build-powercycle-apk.bat first."
    }
    Write-PowerCycleStep "Install AutoTestTool (platform sign)"
    adb shell am force-stop $script:PowerCyclePkg 2>$null | Out-Null
    adb uninstall $script:PowerCyclePkg 2>$null | Out-Null
    adb install -r $apk
    if ($LASTEXITCODE -ne 0) { throw "install AutoTestTool.apk failed" }
}

function Get-PowerCyclePrefsXml {
    $rel = "shared_prefs/$script:PowerCyclePrefs.xml"
    $out = cmd /c "adb shell run-as $script:PowerCyclePkg cat $rel 2>nul"
    if (-not $out) { return "" }
    $text = if ($out -is [array]) { ($out | Out-String).Trim() } else { $out.ToString().Trim() }
    if ($text -and $text -notmatch "Permission denied|No such file|run-as:") {
        return $text
    }
    return ""
}

function Repair-PowerCyclePrefsOwnership {
    if (Get-PowerCyclePrefsXml) { return }
    if (-not (Test-AdbRoot)) { return }

    Write-PowerCycleStep "Repair prefs ownership (remove stale system-owned file)"
    $prefFile = "/data/data/$script:PowerCyclePkg/shared_prefs/$script:PowerCyclePrefs.xml"
    adb shell "rm -f $prefFile" 2>$null | Out-Null
}

function Test-AdbRoot {
    adb root 2>$null | Out-Null
    Start-Sleep -Seconds 1
    $id = adb shell id 2>&1 | Out-String
    return ($id -match 'uid=0')
}

function Push-PowerCyclePrefsXml {
    param([string]$XmlContent)
    $tmpLocal = Join-Path $env:TEMP "powercycle_runner-$PID.xml"
    $prefDir = "/data/data/$script:PowerCyclePkg/shared_prefs"
    $prefFile = "$prefDir/$script:PowerCyclePrefs.xml"

    [System.IO.File]::WriteAllText($tmpLocal, $XmlContent, (New-Object System.Text.UTF8Encoding $false))

    if (Test-AdbRoot) {
        $uid = Get-PowerCycleAppUid
        adb shell "mkdir -p $prefDir" 2>$null | Out-Null
        adb push $tmpLocal $prefFile | Out-Null
        if ($LASTEXITCODE -ne 0) { throw "adb push prefs to $prefFile failed" }
        if ($uid -eq 1000) {
            adb shell "chown system:system $prefFile && chmod 660 $prefFile" 2>$null | Out-Null
        } else {
            adb shell "chown ${uid}:${uid} $prefFile && chmod 660 $prefFile" 2>$null | Out-Null
        }
        Remove-Item $tmpLocal -Force -ErrorAction SilentlyContinue
        return
    }

    adb shell run-as $script:PowerCyclePkg "mkdir -p shared_prefs" 2>$null | Out-Null
    Get-Content $tmpLocal -Raw -Encoding UTF8 | adb shell run-as $script:PowerCyclePkg "sh -c 'cat > shared_prefs/$($script:PowerCyclePrefs).xml'" 2>$null | Out-Null
    if ($LASTEXITCODE -ne 0) { throw "run-as write prefs failed (no adb root); enable adb root or use debuggable build" }
    Remove-Item $tmpLocal -Force -ErrorAction SilentlyContinue
}

function Update-PowerCyclePrefsField {
    param(
        [string]$Xml,
        [string]$Name,
        [string]$Value,
        [ValidateSet("int", "string", "boolean")]
        [string]$Type
    )
    $pattern = "name=`"$Name`" value=`"[^`"]*`""
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

function Set-PowerCyclePrefs {
    param(
        [int]$TestTimes,
        [string]$Mode,
        [int]$PowerOffMinutes,
        [int]$WaitSeconds,
        [string]$Tester,
        [bool]$AutoResume = $true,
        [bool]$ResetCount = $false
    )
    Write-PowerCycleStep "Write powercycle_runner prefs (app-owned via run-as)"
    Repair-PowerCyclePrefsOwnership

    $currentCount = 0
    if (-not $ResetCount) {
        $existing = Get-PowerCyclePrefsXml
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
    <string name="mode">$Mode</string>
    <int name="power_off_minutes" value="$PowerOffMinutes"/>
    <int name="wait_seconds" value="$WaitSeconds"/>
    <boolean name="auto_resume" value="$resumeVal"/>
    <boolean name="running" value="false"/>
    <string name="tester_name">$Tester</string>
</map>
"@ | ForEach-Object { Push-PowerCyclePrefsXml -XmlContent $_ }
}

function Set-PowerCycleDeviceStability {
    Write-PowerCycleStep "Apply device stability settings"
    adb root 2>$null | Out-Null
    Start-Sleep -Seconds 1
    adb shell svc power stayon true 2>$null | Out-Null
    adb shell settings put system screen_off_timeout 2147483647 2>$null | Out-Null
    adb shell settings put global stay_on_while_plugged_in 7 2>$null | Out-Null
    adb shell locksettings set-disabled true 2>$null | Out-Null
}

function Grant-PowerCycleStorage {
    Write-PowerCycleStep "Grant storage permissions (result log)"
    adb shell pm grant $script:PowerCyclePkg android.permission.READ_EXTERNAL_STORAGE 2>$null | Out-Null
    adb shell pm grant $script:PowerCyclePkg android.permission.WRITE_EXTERNAL_STORAGE 2>$null | Out-Null
    adb root 2>$null | Out-Null
    Start-Sleep -Seconds 1
    adb shell cmd appops set $script:PowerCyclePkg MANAGE_EXTERNAL_STORAGE allow 2>$null | Out-Null

    $info = adb shell dumpsys package $script:PowerCyclePkg 2>&1 | Out-String
    if ($info -match 'WRITE_EXTERNAL_STORAGE: granted=true') {
        Write-Host "  WRITE_EXTERNAL_STORAGE: granted" -ForegroundColor Green
    } else {
        Write-Warning "WRITE_EXTERNAL_STORAGE grant failed; results use app external dir"
    }
}

function Test-PowerCycleServiceRunning {
    $out = adb shell "dumpsys activity services $script:PowerCyclePkg 2>/dev/null" 2>&1 | Out-String
    return ($out -match "PowerCycleService")
}

function Set-PowerCycleStopFlags {
    Write-PowerCycleStep "Set auto_resume=false, running=false"
    Repair-PowerCyclePrefsOwnership

    $xml = Get-PowerCyclePrefsXml
    if (-not $xml) {
        $xml = @"
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <boolean name="auto_resume" value="false"/>
    <boolean name="running" value="false"/>
</map>
"@
    } else {
        $xml = Update-PowerCyclePrefsField -Xml $xml -Name "auto_resume" -Value "false" -Type "boolean"
        $xml = Update-PowerCyclePrefsField -Xml $xml -Name "running" -Value "false" -Type "boolean"
    }
    Push-PowerCyclePrefsXml -XmlContent $xml
}

function Get-AdbSerialArg {
    $serial = cmd /c "adb devices 2>nul" | Select-String "^\S+\s+device$" | ForEach-Object { ($_ -split "\s+")[0] } | Select-Object -First 1
    return $serial
}

function Start-PowerCyclePcWatchdog {
    $serial = Get-AdbSerialArg
    if (-not $serial) { return }

    $info = adb shell dumpsys package $script:PowerCyclePkg 2>&1 | Out-String
    if ($info -match "android\.permission\.REBOOT: granted=true") { return }

    Stop-PowerCyclePcWatchdog
    $pidFile = Join-Path $env:TEMP "powercycle-watchdog-$serial.pid"
    $watchdog = Join-Path $PSScriptRoot "pc-watchdog.ps1"
    Write-PowerCycleStep "Start PC reboot watchdog (device lacks REBOOT permission)"
    Start-Process powershell -WindowStyle Hidden -ArgumentList @(
        "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", $watchdog, "-Serial", $serial
    ) | Out-Null
    Set-Content -Path $pidFile -Value "started" -Encoding ASCII
    Write-Host "  Watchdog: polls /sdcard/Android/data/com.tinno.autotesttool/files/.powercycle_reboot_request -> adb reboot" -ForegroundColor Yellow
    Write-Host "  Keep USB connected. stop.bat will terminate watchdog." -ForegroundColor Yellow
}

function Stop-PowerCyclePcWatchdog {
    Get-ChildItem (Join-Path $env:TEMP "powercycle-watchdog-*.pid") -ErrorAction SilentlyContinue | ForEach-Object {
        Remove-Item $_.FullName -Force -ErrorAction SilentlyContinue
    }
}

function Resume-PowerCycleTaskAfterBoot {
    param([string]$Serial = "")

    $adbArgs = @()
    if ($Serial) { $adbArgs += @("-s", $Serial) }

    $xml = Get-PowerCyclePrefsXml
    if (-not $xml) { return $false }
    if ($xml -notmatch 'name="running" value="true"') { return $false }
    if ($xml -notmatch 'name="auto_resume" value="true"') { return $false }

    $current = 0
    $total = 0
    if ($xml -match 'name="current_count" value="(\d+)"') { $current = [int]$Matches[1] }
    if ($xml -match 'name="test_times" value="(\d+)"') { $total = [int]$Matches[1] }
    if (Test-PowerCycleServiceRunning) { return $false }

    Write-Host "[watchdog $Serial] resume power cycle ($current/$total)" -ForegroundColor Yellow
    & adb @adbArgs shell am start -n "$script:PowerCyclePkg/$script:PowerCycleActivity" 2>$null | Out-Null
    Start-Sleep -Seconds 2
    & adb @adbArgs shell am start-foreground-service -n "$script:PowerCyclePkg/$script:PowerCycleService" -a com.tinno.autotesttool.action.POWER_CYCLE_START 2>$null | Out-Null
    return $true
}

function Start-PowerCycleTask {
    adb shell am force-stop $script:PowerCyclePkg 2>$null | Out-Null

    $xml = Get-PowerCyclePrefsXml
    if ($xml) {
        $xml = Update-PowerCyclePrefsField -Xml $xml -Name "running" -Value "true" -Type "boolean"
        Push-PowerCyclePrefsXml -XmlContent $xml
    }

    # 部分机型（Z2582）后台 start-foreground-service 会被 AutoLaunch 拦截，需先拉起 Activity
    adb shell am start -n "$script:PowerCyclePkg/$script:PowerCycleActivity" 2>$null | Out-Null
    Start-Sleep -Seconds 2
    adb shell am start-foreground-service -n "$script:PowerCyclePkg/$script:PowerCycleService" -a com.tinno.autotesttool.action.POWER_CYCLE_START 2>$null | Out-Null
    Start-Sleep -Seconds 2
    adb shell am broadcast -a com.tinno.autotesttool.action.POWER_CYCLE_KEEPALIVE -n "$script:PowerCyclePkg/com.mediatek.schpwronoff.powercycle.PowerCycleAutoResumeReceiver" 2>$null | Out-Null
}

function Stop-PowerCycleTask {
    param([switch]$Force)

    Set-PowerCycleStopFlags
    Stop-PowerCyclePcWatchdog

    if (Test-PowerCycleServiceRunning) {
        Write-PowerCycleStep "Stop PowerCycleService gracefully"
        adb shell am startservice -n "$script:PowerCyclePkg/$script:PowerCycleService" -a com.tinno.autotesttool.action.POWER_CYCLE_STOP
        Start-Sleep -Seconds 3
    }

    Write-PowerCycleStep "Force stop AutoTestTool"
    adb shell am force-stop $script:PowerCyclePkg 2>$null | Out-Null
    Start-Sleep -Seconds 1

    if ($Force -and (Test-PowerCycleServiceRunning)) {
        throw "Failed to stop PowerCycleService. Reboot device or: adb shell am force-stop $script:PowerCyclePkg"
    }
}

# --- MSSV backend (Z2582 / Unisoc offline reboot) ---

function Test-MssvInstalled {
    $out = adb shell pm path $script:MssvPkg 2>&1 | Out-String
    return ($out -match "package:")
}

function Test-MssvRebootGranted {
    if (-not (Test-MssvInstalled)) { return $false }
    $info = adb shell dumpsys package $script:MssvPkg 2>&1 | Out-String
    return ($info -match "android\.permission\.REBOOT: granted=true")
}

function Test-AutoTestToolRebootGranted {
    $info = adb shell dumpsys package $script:PowerCyclePkg 2>&1 | Out-String
    if ($info -notmatch "package:") { return $false }
    return ($info -match "android\.permission\.REBOOT: granted=true")
}

function Resolve-PowerCycleBackend {
    param([hashtable]$Cfg)

    $mode = if ($Cfg["backend"]) { $Cfg["backend"].ToLower() } else { "auto" }
    switch ($mode) {
        "mssv" { return "mssv" }
        "autotesttool" { return "autotesttool" }
        "auto" {
            if ((Test-MssvRebootGranted) -and -not (Test-AutoTestToolRebootGranted)) {
                return "mssv"
            }
            return "autotesttool"
        }
        default { throw "Unknown backend: $mode (use auto|mssv|autotesttool)" }
    }
}

function Install-MssvApk {
    param([string]$ApkPath)
    if (-not $ApkPath -or -not (Test-Path $ApkPath)) {
        if (Test-MssvInstalled) { return }
        throw "MSSV not installed. Set mssv.apk.path in test-config.properties"
    }
    Write-PowerCycleStep "Install MSSV ($script:MssvPkg)"
    adb shell am force-stop $script:MssvPkg 2>$null | Out-Null
    adb install -r $ApkPath
    if ($LASTEXITCODE -ne 0) { throw "install MSSV apk failed: $ApkPath" }
    if (-not (Test-MssvRebootGranted)) {
        throw "MSSV installed but REBOOT not granted; check platform signature"
    }
}

function Get-MssvPrefsXml {
    if (-not (Test-AdbRoot)) { return "" }
    $prefFile = "/data/data/$script:MssvPkg/shared_prefs/$($script:MssvPrefsName).xml"
    $out = adb shell "cat $prefFile 2>/dev/null" 2>&1 | Out-String
    if ($out -match "No such file|Permission denied") { return "" }
    return $out.Trim()
}

function Push-MssvPrefsXml {
    param([string]$XmlContent)
    if (-not (Test-AdbRoot)) {
        throw "MSSV offline mode requires adb root (to write system app prefs)"
    }
    $tmpLocal = Join-Path $env:TEMP "mssv_sleep_reboot-$PID.xml"
    $prefDir = "/data/data/$script:MssvPkg/shared_prefs"
    $prefFile = "$prefDir/$($script:MssvPrefsName).xml"
    [System.IO.File]::WriteAllText($tmpLocal, $XmlContent, (New-Object System.Text.UTF8Encoding $false))
    adb shell "mkdir -p $prefDir" 2>$null | Out-Null
    adb push $tmpLocal $prefFile | Out-Null
    if ($LASTEXITCODE -ne 0) { throw "adb push MSSV prefs failed" }
    adb shell "chown system:system $prefFile && chmod 660 $prefFile" 2>$null | Out-Null
    Remove-Item $tmpLocal -Force -ErrorAction SilentlyContinue
}

function Set-MssvSleepRebootPrefs {
    param(
        [int]$TestTimes,
        [int]$WaitSeconds,
        [bool]$AutoResume = $true,
        [bool]$ResetCount = $false,
        [bool]$Running = $false
    )
    Write-PowerCycleStep "Write MSSV sleep_reboot prefs (adb root)"
    $currentCount = 0
    if (-not $ResetCount) {
        $existing = Get-MssvPrefsXml
        if ($existing -match 'name="current_count" value="(\d+)"') {
            $currentCount = [int]$Matches[1]
        }
    }
    $stateVal = if ($Running) { "true" } else { "false" }
    $autoStartVal = if ($AutoResume) { "true" } else { "false" }
    $sleepSec = [Math]::Max(0, $WaitSeconds)
    $wakeSec = [Math]::Max(0, $WaitSeconds)
    @"
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <int name="count" value="$TestTimes"/>
    <int name="current_count" value="$currentCount"/>
    <int name="sleep_time" value="$sleepSec"/>
    <int name="wake_time" value="$wakeSec"/>
    <boolean name="sensor" value="false"/>
    <boolean name="usb" value="true"/>
    <boolean name="state" value="$stateVal"/>
    <boolean name="auto_start" value="$autoStartVal"/>
</map>
"@ | ForEach-Object { Push-MssvPrefsXml -XmlContent $_ }
}

function Test-MssvPowerCycleRunning {
    $out = adb shell "dumpsys activity services $script:MssvPkg 2>/dev/null" 2>&1 | Out-String
    return ($out -match "SleepRebootService")
}

function Get-MssvPowerCycleStatus {
    $xml = Get-MssvPrefsXml
    $status = @{
        current_count = 0
        test_times    = 0
        running       = $false
        auto_resume   = $false
        completed     = $false
    }
    if (-not $xml) { return $status }
    if ($xml -match 'name="current_count" value="(\d+)"') { $status.current_count = [int]$Matches[1] }
    if ($xml -match 'name="count" value="(\d+)"') { $status.test_times = [int]$Matches[1] }
    if ($xml -match 'name="state" value="true"') { $status.running = $true }
    if ($xml -match 'name="auto_start" value="true"') { $status.auto_resume = $true }
    if ($status.test_times -gt 0 -and $status.current_count -ge $status.test_times) {
        $status.completed = $true
    }
    return $status
}

function Stop-MssvCompletionWatcher {
    adb shell "rm -f $script:MssvCompletionWatcherPid" 2>$null | Out-Null
    adb shell "pkill -f mssv-completion-watch.sh" 2>$null | Out-Null
}

function Set-MssvPowerCycleActiveMarker {
    param([int]$TestTimes)
    adb shell "echo $TestTimes > /data/local/tmp/mssv-pcycle-active" 2>$null | Out-Null
    adb shell "echo 0 > /data/local/tmp/mssv-pcycle-peak" 2>$null | Out-Null
    adb shell "mkdir -p /data/com.unisoc.mssv/sleepreboot && : > $script:MssvResultLog" 2>$null | Out-Null
}

function Clear-MssvPowerCycleActiveMarker {
    adb shell "rm -f /data/local/tmp/mssv-pcycle-active /data/local/tmp/mssv-pcycle-peak" 2>$null | Out-Null
    $serial = Get-AdbSerialArg
    if ($serial) {
        Remove-Item (Join-Path $env:TEMP "mssv-watchdog-$serial.max") -Force -ErrorAction SilentlyContinue
    }
}

function Start-MssvPcWatchdog {
    $serial = Get-AdbSerialArg
    if (-not $serial) { return }
    Stop-MssvPcWatchdog
    $stopFile = Join-Path $env:TEMP "mssv-watchdog-$serial.stop"
    Remove-Item $stopFile -Force -ErrorAction SilentlyContinue
    Remove-Item (Join-Path $env:TEMP "mssv-watchdog-$serial.max") -Force -ErrorAction SilentlyContinue
    $watchdog = Join-Path $PSScriptRoot "mssv-watchdog.ps1"
    Start-Process powershell -WindowStyle Hidden -ArgumentList @(
        "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", $watchdog, "-Serial", $serial
    ) | Out-Null
    Write-Host "  MSSV PC watchdog: auto stop after target count (survives reboot)" -ForegroundColor Yellow
}

function Stop-MssvPcWatchdog {
    $serial = Get-AdbSerialArg
    if ($serial) {
        Set-Content -Path (Join-Path $env:TEMP "mssv-watchdog-$serial.stop") -Value "stop" -Encoding ASCII
    }
    Get-ChildItem (Join-Path $env:TEMP "mssv-watchdog-*.stop") -ErrorAction SilentlyContinue | ForEach-Object {
        Set-Content -Path $_.FullName -Value "stop" -Encoding ASCII
    }
    Start-Sleep -Seconds 2
    Get-ChildItem (Join-Path $env:TEMP "mssv-watchdog-*.pid") -ErrorAction SilentlyContinue | ForEach-Object {
        Remove-Item $_.FullName -Force -ErrorAction SilentlyContinue
    }
}

function Start-MssvCompletionWatcher {
    if (-not (Test-AdbRoot)) { return }
    Stop-MssvCompletionWatcher

    $sh = @'
#!/system/bin/sh
MARKER=/data/local/tmp/mssv-pcycle-active
PEAKFILE=/data/local/tmp/mssv-pcycle-peak
PREFS=/data/data/com.unisoc.mssv/shared_prefs/sleep_reboot.xml
PIDFILE=/data/local/tmp/mssv-completion-watch.pid
LOG=/data/com.unisoc.mssv/sleepreboot/sleepreboot.log
TARGET=$(cat "$MARKER" 2>/dev/null)
[ -n "$TARGET" ] || exit 0
PEAK=$(cat "$PEAKFILE" 2>/dev/null)
[ -n "$PEAK" ] || PEAK=0
echo $PEAK > "$PEAKFILE"
echo $$ > "$PIDFILE"
while [ -f "$PIDFILE" ]; do
  sleep 3
  [ -f "$PREFS" ] || continue
  CUR=$(grep '<int name="current_count"' "$PREFS" | head -1 | sed 's/.*value=//;s/[^0-9]*//g')
  CNT=$(grep '<int name="count"' "$PREFS" | head -1 | sed 's/.*value=//;s/[^0-9]*//g')
  [ -n "$CNT" ] && [ "$CNT" -gt 0 ] || CNT=$TARGET
  [ -n "$CUR" ] || CUR=0
  PEAK=$(cat "$PEAKFILE" 2>/dev/null)
  [ -n "$PEAK" ] || PEAK=0
  if [ "$CUR" -gt "$PEAK" ]; then PEAK=$CUR; echo $PEAK > "$PEAKFILE"; fi
  SUCC=0
  if [ -f "$LOG" ]; then
    SUCC=$(grep -c 'CODE:0 RESULT:Success' "$LOG" 2>/dev/null)
    [ -n "$SUCC" ] || SUCC=0
  fi
  if [ "$CNT" -gt 0 ]; then
    if [ "$PEAK" -ge "$CNT" ] || [ "$SUCC" -ge "$CNT" ]; then
    rm -f "$MARKER"
    SLP=$(grep 'name="sleep_time"' "$PREFS" | head -1 | sed 's/.*value="//;s/".*//')
    WAK=$(grep 'name="wake_time"' "$PREFS" | head -1 | sed 's/.*value="//;s/".*//')
    [ -n "$SLP" ] || SLP=3
    [ -n "$WAK" ] || WAK=3
    am force-stop com.unisoc.mssv
    cat > "$PREFS" <<EOF
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <int name="count" value="$CNT"/>
    <int name="current_count" value="$PEAK"/>
    <int name="sleep_time" value="$SLP"/>
    <int name="wake_time" value="$WAK"/>
    <boolean name="sensor" value="false"/>
    <boolean name="usb" value="true"/>
    <boolean name="state" value="false"/>
    <boolean name="auto_start" value="false"/>
</map>
EOF
    chown system:system "$PREFS"
    chmod 660 "$PREFS"
    mkdir -p "$(dirname "$LOG")"
    echo "$(date '+%Y-%m-%d %H:%M:%S') finished result=PASS ($PEAK/$CNT)" >> "$LOG"
    am force-stop com.unisoc.mssv
    sleep 1
    am force-stop com.unisoc.mssv
    rm -f "$PIDFILE" "$MARKER" "$PEAKFILE"
    exit 0
    fi
  fi
done
'@
    $tmpLocal = Join-Path $env:TEMP "mssv-completion-watch.sh"
    [System.IO.File]::WriteAllText($tmpLocal, $sh.Replace("`r`n", "`n"), (New-Object System.Text.UTF8Encoding $false))
    adb push $tmpLocal $script:MssvCompletionWatcherSh | Out-Null
    adb shell "chmod 755 $script:MssvCompletionWatcherSh" 2>$null | Out-Null
    adb shell "nohup su 0 sh $script:MssvCompletionWatcherSh >/dev/null 2>&1 &" 2>$null | Out-Null
    Remove-Item $tmpLocal -Force -ErrorAction SilentlyContinue
    Write-Host "  MSSV completion watcher: auto stop when current_count >= count" -ForegroundColor Yellow
}

function Start-MssvPowerCycleTask {
    adb shell am force-stop $script:MssvPkg 2>$null | Out-Null
    $xml = Get-MssvPrefsXml
    if ($xml) {
        $xml = Update-PowerCyclePrefsField -Xml $xml -Name "state" -Value "true" -Type "boolean"
        Push-MssvPrefsXml -XmlContent $xml
    }
    adb shell am start -a $script:MssvSleepRebootAction -n $script:MssvSleepRebootActivity 2>$null | Out-Null
    Start-Sleep -Seconds 2
    adb shell am start-foreground-service -n $script:MssvSleepRebootService 2>$null | Out-Null
    Start-MssvCompletionWatcher
    Start-MssvPcWatchdog
}

function Complete-MssvPowerCycleTest {
    $peakText = adb shell "cat /data/local/tmp/mssv-pcycle-peak 2>/dev/null" 2>&1 | Out-String
    $targetText = adb shell "cat /data/local/tmp/mssv-pcycle-active 2>/dev/null" 2>&1 | Out-String
    Clear-MssvPowerCycleActiveMarker
    adb shell am force-stop $script:MssvPkg 2>$null | Out-Null
    $xml = Get-MssvPrefsXml
    $cur = 0; $cnt = 0; $slp = 3; $wak = 3
    if ($xml -match 'name="current_count"\s+value="(\d+)"') { $cur = [int]$Matches[1] }
    if ($xml -match 'name="count"\s+value="(\d+)"') { $cnt = [int]$Matches[1] }
    if ($xml -match 'name="sleep_time"\s+value="(\d+)"') { $slp = [int]$Matches[1] }
    if ($xml -match 'name="wake_time"\s+value="(\d+)"') { $wak = [int]$Matches[1] }
    if ($peakText -match '(\d+)') { $cur = [Math]::Max($cur, [int]$Matches[1]) }
    if ($targetText -match '(\d+)') { $cnt = [Math]::Max($cnt, [int]$Matches[1]) }
    if ($cnt -le 0) { $cnt = [Math]::Max($cur, 1) }
    if ($cur -lt $cnt) { $cur = $cnt }
    @"
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <int name="count" value="$cnt"/>
    <int name="current_count" value="$cur"/>
    <int name="sleep_time" value="$slp"/>
    <int name="wake_time" value="$wak"/>
    <boolean name="sensor" value="false"/>
    <boolean name="usb" value="true"/>
    <boolean name="state" value="false"/>
    <boolean name="auto_start" value="false"/>
</map>
"@ | ForEach-Object { Push-MssvPrefsXml -XmlContent $_ }
    adb shell "mkdir -p /data/com.unisoc.mssv/sleepreboot" 2>$null | Out-Null
    $finishLine = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') finished result=PASS ($cur/$cnt)"
    adb shell "echo '$finishLine' >> $script:MssvResultLog" 2>$null | Out-Null
    adb shell am force-stop $script:MssvPkg 2>$null | Out-Null
    Stop-MssvCompletionWatcher
    Clear-MssvPowerCycleActiveMarker
}

function Stop-MssvPowerCycleTask {
    Write-PowerCycleStep "Stop MSSV sleep/reboot test"
    Stop-MssvPcWatchdog
    Complete-MssvPowerCycleTest
}

function Deploy-PowerCycle-Mssv {
    param(
        [hashtable]$Cfg,
        [int]$TestTimes,
        [string]$Mode,
        [int]$WaitSeconds,
        [bool]$AutoResume,
        [bool]$AutoStart
    )
    if ($Mode -eq "poweroff") {
        Write-Warning "MSSV backend only supports reboot-like sleep/reboot; using reboot semantics"
    }
    $mssvApk = $Cfg["mssv.apk.path"]
    if (-not (Test-MssvInstalled)) {
        if ($mssvApk) { Install-MssvApk -ApkPath $mssvApk }
        else { throw "MSSV ($script:MssvPkg) not installed. Set mssv.apk.path in test-config.properties" }
    }
    if (-not (Test-MssvRebootGranted)) {
        throw "MSSV lacks REBOOT permission on this device"
    }
    if (-not (Test-AdbRoot)) {
        throw "MSSV offline mode requires adb root"
    }
    Write-Host "  Backend: MSSV (offline reboot, no PC watchdog)" -ForegroundColor Green
    Set-PowerCycleDeviceStability
    Set-MssvSleepRebootPrefs -TestTimes $TestTimes -WaitSeconds $WaitSeconds `
        -AutoResume:$AutoResume -ResetCount $true -Running $false
    Write-Host "`nDeploy complete (MSSV)." -ForegroundColor Green
    adb shell dumpsys package $script:MssvPkg 2>&1 | Select-String "versionName|sharedUser|REBOOT: granted" | ForEach-Object { $_.Line.Trim() }
    if ($AutoStart) {
        Write-PowerCycleStep "Auto start MSSV sleep/reboot test"
        Set-MssvPowerCycleActiveMarker -TestTimes $TestTimes
        Start-MssvPowerCycleTask
        $st = Get-MssvPowerCycleStatus
        Write-Host "Test started. Times=$TestTimes Wait=${WaitSeconds}s Auto-resume=$AutoResume" -ForegroundColor Green
        Write-Host "Results: $script:MssvResultLog" -ForegroundColor Green
        Write-Host "Status: $($st.current_count)/$($st.test_times) running=$($st.running)" -ForegroundColor Green
    } else {
        Write-Host "Start manually: scripts\run.bat" -ForegroundColor Yellow
    }
}

function Deploy-PowerCycle-AutoTestTool {
    param(
        [hashtable]$Cfg,
        [string]$ApkDir,
        [int]$TestTimes,
        [string]$Mode,
        [int]$PowerOffMinutes,
        [int]$WaitSeconds,
        [string]$Tester,
        [bool]$AutoResume,
        [bool]$AutoStart
    )
    Install-PowerCycleApk -ApkDir $ApkDir
    $null = Test-PowerCycleSystemUid
    $null = Test-PowerCycleRebootPermission
    Set-PowerCycleDeviceStability
    Grant-PowerCycleStorage
    Set-PowerCyclePrefs -TestTimes $TestTimes -Mode $Mode -PowerOffMinutes $PowerOffMinutes `
        -WaitSeconds $WaitSeconds -Tester $Tester -AutoResume:$AutoResume -ResetCount $true
    Write-Host "`nDeploy complete (AutoTestTool)." -ForegroundColor Green
    adb shell dumpsys package $script:PowerCyclePkg 2>&1 | Select-String "sharedUser|versionName" | ForEach-Object { $_.Line.Trim() }
    if ($AutoStart) {
        Write-PowerCycleStep "Auto start power cycle test"
        if (-not (Test-AutoTestToolRebootGranted)) { Start-PowerCyclePcWatchdog }
        Start-PowerCycleTask
        if (Test-PowerCycleServiceRunning) {
            Write-Host "Test started. Mode=$Mode Times=$TestTimes Auto-resume=$AutoResume" -ForegroundColor Green
            Write-Host "Results: /sdcard/Android/data/$script:PowerCyclePkg/files/PowerCycle/powercycle_result.txt" -ForegroundColor Green
        } else {
            Write-Warning "PowerCycleService may not be running."
        }
    } else {
        Write-Host "Start manually: scripts\run.bat" -ForegroundColor Yellow
    }
}

function Run-PowerCycle-Mssv {
    param(
        [int]$TestTimes,
        [int]$WaitSeconds,
        [bool]$AutoResume,
        [switch]$ResetCount
    )
    if (-not (Test-AdbRoot)) { throw "MSSV offline mode requires adb root" }
    Set-MssvPowerCycleActiveMarker -TestTimes $TestTimes
    Set-MssvSleepRebootPrefs -TestTimes $TestTimes -WaitSeconds $WaitSeconds `
        -AutoResume:$AutoResume -ResetCount:($ResetCount.IsPresent) -Running $false
    Write-PowerCycleStep "Start MSSV sleep/reboot test (offline)"
    Start-MssvPowerCycleTask
    $st = Get-MssvPowerCycleStatus
    Write-Host "`nTest started (MSSV offline). $($st.current_count)/$($st.test_times)" -ForegroundColor Green
    Write-Host "Results: $script:MssvResultLog" -ForegroundColor Green
}

function Run-PowerCycle-AutoTestTool {
    param(
        [int]$TestTimes,
        [string]$Mode,
        [int]$PowerOffMinutes,
        [int]$WaitSeconds,
        [string]$Tester,
        [bool]$AutoResume,
        [switch]$ResetCount
    )
    Grant-PowerCycleStorage
    Set-PowerCyclePrefs -TestTimes $TestTimes -Mode $Mode -PowerOffMinutes $PowerOffMinutes `
        -WaitSeconds $WaitSeconds -Tester $Tester -AutoResume:$AutoResume -ResetCount:($ResetCount.IsPresent)
    if (-not (Test-AutoTestToolRebootGranted)) { Start-PowerCyclePcWatchdog }
    Write-PowerCycleStep "Start power cycle test"
    Start-PowerCycleTask
    if (Test-PowerCycleServiceRunning) {
        Write-Host "`nTest started. Results: /sdcard/Android/data/$script:PowerCyclePkg/files/PowerCycle/" -ForegroundColor Green
    } else {
        Write-Warning "PowerCycleService may not be running."
    }
}

function Stop-PowerCycleAll {
    param([switch]$Force)
    Stop-MssvPcWatchdog
    Stop-MssvCompletionWatcher
    $marker = adb shell "test -f /data/local/tmp/mssv-pcycle-active && echo yes" 2>&1 | Out-String
    $mssvPrefs = Get-MssvPrefsXml
    $mssvActive = (Test-MssvInstalled) -and (
        (Test-MssvPowerCycleRunning) -or
        ($marker -match "yes") -or
        ($mssvPrefs -match 'name="state" value="true"') -or
        ($mssvPrefs -match 'name="auto_start" value="true"')
    )
    if ($mssvActive) {
        Stop-MssvPowerCycleTask
    } else {
        Clear-MssvPowerCycleActiveMarker
    }
    if ((adb shell dumpsys package $script:PowerCyclePkg 2>&1 | Out-String) -match "package:") {
        Set-PowerCycleStopFlags
        if (Test-PowerCycleServiceRunning) {
            Write-PowerCycleStep "Stop PowerCycleService gracefully"
            adb shell am startservice -n "$script:PowerCyclePkg/$script:PowerCycleService" -a com.tinno.autotesttool.action.POWER_CYCLE_STOP
            Start-Sleep -Seconds 2
        }
        adb shell am force-stop $script:PowerCyclePkg 2>$null | Out-Null
    }
    Stop-PowerCyclePcWatchdog
}
