#Requires -Version 5.1
param(
    [int]$TestTimes = 0,
    [string]$Mode = "",
    [int]$PowerOffMinutes = 0,
    [int]$WaitSeconds = 0,
    [string]$Tester = "",
    [switch]$ResetCount
)

$ErrorActionPreference = "Stop"
. (Join-Path $PSScriptRoot "lib.ps1")

if (-not (Get-Command adb -ErrorAction SilentlyContinue)) {
    throw "adb not found in PATH"
}

$root = Get-PowerCycleRoot
$cfg = Read-PowerCycleConfig -Root $root

if ($TestTimes -le 0) { $TestTimes = [int]$cfg["test.times"] }
if (-not $Mode) { $Mode = $cfg["test.mode"] }
if ($PowerOffMinutes -le 0) { $PowerOffMinutes = [int]$cfg["power.off.minutes"] }
if ($WaitSeconds -le 0) { $WaitSeconds = [int]$cfg["wait.seconds"] }
if (-not $Tester) { $Tester = $cfg["tester.name"] }
$autoResume = ($cfg["auto.resume"] -eq "true")

$backend = Resolve-PowerCycleBackend -Cfg $cfg
Write-PowerCycleStep "Power cycle backend: $backend"

if ($backend -eq "mssv") {
    Run-PowerCycle-Mssv -TestTimes $TestTimes -WaitSeconds $WaitSeconds `
        -AutoResume:$autoResume -ResetCount:$ResetCount
} else {
    Run-PowerCycle-AutoTestTool -TestTimes $TestTimes -Mode $Mode -PowerOffMinutes $PowerOffMinutes `
        -WaitSeconds $WaitSeconds -Tester $Tester -AutoResume:$autoResume -ResetCount:$ResetCount
}
