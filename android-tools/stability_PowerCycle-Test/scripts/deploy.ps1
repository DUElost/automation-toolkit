#Requires -Version 5.1
param(
    [int]$TestTimes = 0,
    [string]$Mode = "",
    [int]$PowerOffMinutes = 0,
    [int]$WaitSeconds = 0,
    [string]$Tester = "",
    [switch]$Start
)

$ErrorActionPreference = "Stop"
. (Join-Path $PSScriptRoot "lib.ps1")

if (-not (Get-Command adb -ErrorAction SilentlyContinue)) {
    throw "adb not found in PATH"
}

$root = Get-PowerCycleRoot
$apkDir = Join-Path $root "apk"
$cfg = Read-PowerCycleConfig -Root $root

if ($TestTimes -le 0) { $TestTimes = [int]$cfg["test.times"] }
if (-not $Mode) { $Mode = $cfg["test.mode"] }
if ($PowerOffMinutes -le 0) { $PowerOffMinutes = [int]$cfg["power.off.minutes"] }
if ($WaitSeconds -le 0) { $WaitSeconds = [int]$cfg["wait.seconds"] }
if (-not $Tester) { $Tester = $cfg["tester.name"] }
$autoStart = $Start -or ($cfg["auto.start"] -eq "true")
$autoResume = ($cfg["auto.resume"] -eq "true")

$backend = Resolve-PowerCycleBackend -Cfg $cfg
Write-PowerCycleStep "Power cycle backend: $backend"

if ($backend -eq "mssv") {
    Deploy-PowerCycle-Mssv -Cfg $cfg -TestTimes $TestTimes -Mode $Mode `
        -WaitSeconds $WaitSeconds -AutoResume:$autoResume -AutoStart:$autoStart
} else {
    Deploy-PowerCycle-AutoTestTool -Cfg $cfg -ApkDir $apkDir -TestTimes $TestTimes -Mode $Mode `
        -PowerOffMinutes $PowerOffMinutes -WaitSeconds $WaitSeconds -Tester $Tester `
        -AutoResume:$autoResume -AutoStart:$autoStart
}
