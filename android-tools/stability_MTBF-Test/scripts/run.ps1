#Requires -Version 5.1
param(
    [string]$Suite = "",
    [string]$Mode = "",
    [string]$Serial = "",
    [int]$TaskTimes = 0,
    [string]$Tester = "",
    [switch]$RedeployConfig,
    [switch]$NonInteractive
)

$ErrorActionPreference = "Stop"
. (Join-Path $PSScriptRoot "lib.ps1")

Remove-Item Env:ANDROID_SERIAL -ErrorAction SilentlyContinue

if (-not (Get-Command adb -ErrorAction SilentlyContinue)) {
    throw "adb not found in PATH"
}

$resolvedMode = $null
if ($Mode) {
    $resolvedMode = Normalize-MtbfMode -Mode $Mode
} elseif ($NonInteractive) {
    $resolvedMode = Get-MtbfLastMode
    if (-not $resolvedMode) { $resolvedMode = "apk" }
}

$serials = @()
$selected = $null
if ($Suite) {
    if (-not $resolvedMode) {
        $resolvedMode = Resolve-MtbfMode -Mode $Mode -Interactive:(-not $NonInteractive)
        if (-not $resolvedMode) {
            Write-Host "Cancelled." -ForegroundColor Yellow
            exit 0
        }
    }
    $serials = @(Resolve-MtbfDevices -Serial $Serial -Interactive:(-not $NonInteractive))
    $selected = Resolve-MtbfSuite -SuiteId $Suite
    $selected | Add-Member -NotePropertyName Mode -NotePropertyValue $resolvedMode -Force
} elseif ($NonInteractive) {
    $serials = @(Resolve-MtbfDevices -Serial $Serial)
    $selected = Get-MtbfLastSuite
    if (-not $selected) {
        $all = @(Get-MtbfSuites)
        if ($all.Count -eq 1) {
            $selected = $all[0]
        } else {
            $selected = Resolve-MtbfSuite -SuiteId ""
        }
    }
    $selected | Add-Member -NotePropertyName Mode -NotePropertyValue $resolvedMode -Force
} else {
    $last = Get-MtbfLastSuite
    if ($last) {
        $lastMode = if ($resolvedMode) { $resolvedMode } else { Get-MtbfLastMode }
        Write-Host "Last suite: $($last.DisplayName) [$($last.Id)] mode=$lastMode serial=$(Get-MtbfLastSerial)" -ForegroundColor DarkGray
        $useLast = Confirm-MtbfAction -Prompt "Use last suite? (Y/N/Q)" -Default "Y"
        if ($null -eq $useLast) { exit 0 }
        if ($useLast) {
            $selected = $last
            if (-not $resolvedMode) {
                $resolvedMode = if ($lastMode) { $lastMode } else {
                    Resolve-MtbfMode -Mode "" -Interactive
                }
            }
            if (-not $resolvedMode) { exit 0 }
            $serials = @(Resolve-MtbfDevices -Serial $Serial -Interactive)
            $selected | Add-Member -NotePropertyName Mode -NotePropertyValue $resolvedMode -Force
        }
    }
    if (-not $selected) {
        $selected = Select-MtbfSuiteInteractive -Mode $resolvedMode -Serial $Serial
        if (-not $selected) {
            Write-Host "Cancelled." -ForegroundColor Yellow
            exit 0
        }
        $resolvedMode = $selected.Mode
        if ($selected.PSObject.Properties.Name -contains "Serials" -and $selected.Serials) {
            $serials = @($selected.Serials)
        } else {
            $serials = @(Resolve-MtbfDevices -Serial $selected.Serial -Interactive)
        }
    }
}

Invoke-MtbfForEachDeviceParallel -Serials $serials -SuiteId $selected.Id -Action run `
    -Mode $resolvedMode -TaskTimes $TaskTimes -Tester $Tester -RedeployConfig:$RedeployConfig
