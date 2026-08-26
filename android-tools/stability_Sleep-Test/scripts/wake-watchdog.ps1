#Requires -Version 5.1
param([string]$Serial = "")

$ErrorActionPreference = "Continue"
$pkg = "com.tinno.autotesttool"
$wakeActivity = "$pkg/com.mediatek.schpwronoff.sleeptest.WakeUpActivity"
$adb = @()
if ($Serial) { $adb = @("-s", $Serial) }

$stopFile = Join-Path $env:TEMP ("sleeptest-watchdog-" + ($(if ($Serial) { $Serial } else { "default" })) + ".stop")
Remove-Item $stopFile -Force -ErrorAction SilentlyContinue

$sleepSeenAt = $null
$sleepSeconds = 45

function Get-Prefs {
    $out = & adb @adb shell "run-as $pkg cat shared_prefs/sleep_test_runner.xml 2>/dev/null"
    if ($out -is [array]) { return ($out | Out-String) }
    return [string]$out
}

while (-not (Test-Path $stopFile)) {
    $xml = Get-Prefs
    if (-not $xml) {
        Start-Sleep -Seconds 3
        continue
    }
    if ($xml -match 'name="running" value="false"') { break }
    $times = 0
    $cur = 0
    if ($xml -match 'name="test_times" value="(\d+)"') { $times = [int]$Matches[1] }
    if ($xml -match 'name="current_count" value="(\d+)"') { $cur = [int]$Matches[1] }
    if ($xml -match 'name="sleep_seconds" value="(\d+)"') { $sleepSeconds = [int]$Matches[1] }
    if ($times -gt 0 -and $cur -ge $times) { break }

    $sleeping = $xml -match 'name="phase">sleep</string>'
    if ($sleeping) {
        if ($null -eq $sleepSeenAt) { $sleepSeenAt = Get-Date }
        $elapsed = ((Get-Date) - $sleepSeenAt).TotalSeconds
        if ($elapsed -ge ($sleepSeconds - 2)) {
            Write-Host ("[sleeptest-watchdog] start WakeUpActivity ({0}/{1})" -f $cur, $times)
            & adb @adb shell am start -n $wakeActivity | Out-Null
            $sleepSeenAt = $null
            Start-Sleep -Seconds 5
        }
    } else {
        $sleepSeenAt = $null
    }
    Start-Sleep -Seconds 2
}

Remove-Item $stopFile -Force -ErrorAction SilentlyContinue
