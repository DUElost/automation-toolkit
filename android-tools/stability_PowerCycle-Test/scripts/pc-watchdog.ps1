#Requires -Version 5.1
param(
    [string]$Serial = "",
    [string]$RequestFile = "/sdcard/Android/data/com.tinno.autotesttool/files/.powercycle_reboot_request"
)

$ErrorActionPreference = "SilentlyContinue"
. (Join-Path $PSScriptRoot "lib.ps1")

$pidFile = Join-Path $env:TEMP "powercycle-watchdog-$Serial.pid"
Set-Content -Path $pidFile -Value $PID -Encoding ASCII

function Invoke-AdbShell {
    param([string]$ShellCmd)
    if ($Serial) {
        return & adb -s $Serial shell $ShellCmd 2>$null
    }
    return & adb shell $ShellCmd 2>$null
}

function Invoke-AdbHost {
    param([string[]]$HostArgs)
    if ($Serial) {
        return & adb -s $Serial @HostArgs 2>$null
    }
    return & adb @HostArgs 2>$null
}

function Wait-AdbDeviceOnline {
    for ($i = 0; $i -lt 40; $i++) {
        $state = Invoke-AdbHost @("get-state")
        if ($state -match "device") { return $true }
        Start-Sleep -Seconds 3
    }
    return $false
}

while (Test-Path $pidFile) {
    $flag = Invoke-AdbShell "cat $RequestFile"
    $text = if ($flag -is [array]) { ($flag | Out-String) } else { [string]$flag }
    $text = $text.Trim()
    if ($text.Length -gt 0 -and $text -notmatch "No such file|Permission denied|cat:") {
        Write-Host "[watchdog $Serial] reboot requested -> adb reboot"
        Invoke-AdbShell "rm -f $RequestFile" | Out-Null
        Invoke-AdbHost @("reboot") | Out-Null
        if (Wait-AdbDeviceOnline) {
            Start-Sleep -Seconds 8
            Resume-PowerCycleTaskAfterBoot -Serial $Serial | Out-Null
        }
        Start-Sleep -Seconds 5
    } else {
        $state = Invoke-AdbHost @("get-state")
        if ($state -match "device") {
            Resume-PowerCycleTaskAfterBoot -Serial $Serial | Out-Null
        }
    }
    Start-Sleep -Seconds 3
}
