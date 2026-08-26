#Requires -Version 5.1
param(
    [int]$TestTimes = 0,
    [int]$WakeSeconds = 0,
    [int]$SleepSeconds = 0,
    [string]$Tester = "",
    [switch]$ResetCount
)

$ErrorActionPreference = "Stop"
. (Join-Path $PSScriptRoot "lib.ps1")

if (-not (Get-Command adb -ErrorAction SilentlyContinue)) {
    throw "adb not found in PATH"
}

$root = Get-SleepTestRoot
$cfg = Read-SleepTestConfig -Root $root

if ($TestTimes -le 0) { $TestTimes = [int]$cfg["test.times"] }
if ($WakeSeconds -le 0) { $WakeSeconds = [int]$cfg["wake.seconds"] }
if ($SleepSeconds -le 0) { $SleepSeconds = [int]$cfg["sleep.seconds"] }
if (-not $Tester) { $Tester = $cfg["tester.name"] }
$autoResume = ($cfg["auto.resume"] -eq "true")

Run-SleepTest -TestTimes $TestTimes -WakeSeconds $WakeSeconds -SleepSeconds $SleepSeconds `
    -Tester $Tester -AutoResume:$autoResume -ResetCount:$ResetCount
