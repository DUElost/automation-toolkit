#Requires -Version 5.1
<#
  MSSV 完成看门狗（PC 端）：
  - 重启后重新推送并启动设备端 completion-watch.sh
  - PC 端持久化 maxCurrent，达到 count 后自动停止
#>
param(
    [string]$Serial = ""
)

$ErrorActionPreference = "SilentlyContinue"
. (Join-Path $PSScriptRoot "lib.ps1")

$marker = "/data/local/tmp/mssv-pcycle-active"
$logPath = "/data/com.unisoc.mssv/sleepreboot/sleepreboot.log"
$pidFile = Join-Path $env:TEMP "mssv-watchdog-$Serial.pid"
$stopFile = Join-Path $env:TEMP "mssv-watchdog-$Serial.stop"
$maxFile = Join-Path $env:TEMP "mssv-watchdog-$Serial.max"
Set-Content -Path $pidFile -Value $PID -Encoding ASCII

$maxCurrent = 0
if (Test-Path $maxFile) {
    $saved = Get-Content $maxFile -Raw -ErrorAction SilentlyContinue
    if ($saved -match '(\d+)') { $maxCurrent = [int]$Matches[1] }
}

function Save-MaxCurrent {
    param([int]$Value)
    Set-Content -Path $maxFile -Value $Value -Encoding ASCII
}

function Invoke-Adb {
    param([string]$ShellCmd)
    if ($Serial) { return & adb -s $Serial shell $ShellCmd 2>$null }
    return & adb shell $ShellCmd 2>$null
}

function Invoke-AdbHost {
    param([string[]]$HostArgs)
    if ($Serial) { return & adb -s $Serial @HostArgs 2>$null }
    return & adb @HostArgs 2>$null
}

function Ensure-AdbRoot {
    Invoke-AdbHost @("root") | Out-Null
    Start-Sleep -Seconds 2
}

function Wait-AdbDevice {
    for ($i = 0; $i -lt 60; $i++) {
        $state = Invoke-AdbHost @("get-state")
        if ($state -match "device") { return $true }
        Start-Sleep -Seconds 3
    }
    return $false
}

function Test-ShouldStop {
    return (Test-Path $stopFile)
}

function Test-MarkerActive {
    $out = Invoke-Adb "test -f $marker && echo yes"
    return ($out -match "yes")
}

function Get-SuccessCount {
    $n = Invoke-Adb "grep -c 'CODE:0 RESULT:Success' $logPath 2>/dev/null"
    $text = if ($n -is [array]) { ($n | Out-String).Trim() } else { [string]$n }
    if ($text -match '^(\d+)$') { return [int]$Matches[1] }
    return 0
}

function Write-WatchdogLog {
    param([string]$Message)
    $line = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') $Message"
    Add-Content -Path (Join-Path $env:TEMP "mssv-watchdog-$Serial.log") -Value $line -Encoding UTF8
}

function Get-MssvCounts {
    $xml = Invoke-Adb "cat /data/data/com.unisoc.mssv/shared_prefs/sleep_reboot.xml 2>/dev/null"
    $text = if ($xml -is [array]) { ($xml | Out-String) } else { [string]$xml }
    $cur = 0; $cnt = 0
    if ($text -match 'name="current_count"\s+value="(\d+)"') { $cur = [int]$Matches[1] }
    if ($text -match '<int name="count"\s+value="(\d+)"') { $cnt = [int]$Matches[1] }
    $peak = Invoke-Adb "cat /data/local/tmp/mssv-pcycle-peak 2>/dev/null"
    $peakText = if ($peak -is [array]) { ($peak | Out-String).Trim() } else { [string]$peak }
    if ($peakText -match '(\d+)') { $cur = [Math]::Max($cur, [int]$Matches[1]) }
    $target = Invoke-Adb "cat /data/local/tmp/mssv-pcycle-active 2>/dev/null"
    $targetText = if ($target -is [array]) { ($target | Out-String).Trim() } else { [string]$target }
    if ($targetText -match '(\d+)') { $cnt = [Math]::Max($cnt, [int]$Matches[1]) }
    $state = $text -match 'name="state"\s+value="false"'
    return @{ current = $cur; total = $cnt; success = (Get-SuccessCount); stateOff = $state }
}

function Test-ShouldFinalize {
    param($Counts, [int]$Max)
    if ($Counts.total -le 0) { return $false }
    if ($Max -ge $Counts.total) { return $true }
    if ($Counts.current -ge $Counts.total) { return $true }
    if ($Counts.success -ge $Counts.total) { return $true }
    if ($Counts.stateOff -and $Max -ge ($Counts.total - 1) -and $Counts.success -ge ($Counts.total - 1)) { return $true }
    return $false
}

function Ensure-DeviceWatcher {
    $running = Invoke-Adb "pgrep -f mssv-completion-watch.sh"
    if ($running) { return }
    Ensure-AdbRoot
    if ($Serial) { $env:ANDROID_SERIAL = $Serial }
    Start-MssvCompletionWatcher
}

function Finalize-MssvComplete {
    param([int]$Current, [int]$Total)
    Write-Host "[mssv-watchdog $Serial] test complete ($Current/$Total) -> stop MSSV" -ForegroundColor Green
    Set-Content -Path $stopFile -Value "stop" -Encoding ASCII
    if ($Serial) { $env:ANDROID_SERIAL = $Serial }
    Ensure-AdbRoot
    Complete-MssvPowerCycleTest
    Remove-Item $maxFile -Force -ErrorAction SilentlyContinue
    Remove-Item $pidFile -Force -ErrorAction SilentlyContinue
}

while (-not (Test-ShouldStop)) {
    try {
        if (Wait-AdbDevice) {
            Ensure-AdbRoot
            $counts = Get-MssvCounts
            $newMax = [Math]::Max($maxCurrent, $counts.current)
            if ($newMax -gt $maxCurrent) {
                $maxCurrent = $newMax
                Save-MaxCurrent -Value $maxCurrent
                Invoke-Adb "echo $maxCurrent > /data/local/tmp/mssv-pcycle-peak"
            }
            if (Test-ShouldFinalize -Counts $counts -Max $maxCurrent) {
                Write-WatchdogLog "finalize max=$maxCurrent cur=$($counts.current) total=$($counts.total) succ=$($counts.success)"
                Finalize-MssvComplete -Current ([Math]::Max($maxCurrent, $counts.current)) -Total $counts.total
                break
            }
            if (-not (Test-MarkerActive)) {
                Write-WatchdogLog "marker gone max=$maxCurrent total=$($counts.total)"
                if ($maxCurrent -ge $counts.total -and $counts.total -gt 0) { break }
            } else {
                Ensure-DeviceWatcher
            }
            Write-WatchdogLog "poll max=$maxCurrent cur=$($counts.current)/$($counts.total) succ=$($counts.success)"
        }
    } catch {
        Write-WatchdogLog "error: $_"
    }
    Start-Sleep -Seconds 3
}

Remove-Item $pidFile -Force -ErrorAction SilentlyContinue
