#Requires -Version 5.1
param(
    [string]$Suite = "",
    [string]$Mode = "",
    [string]$Serial = "",
    [int]$TaskTimes = 0,
    [string]$Tester = "",
    [switch]$Start,
    [switch]$NonInteractive,
    [switch]$ListSuites
)

$ErrorActionPreference = "Stop"
. (Join-Path $PSScriptRoot "lib.ps1")

# Avoid inherited ANDROID_SERIAL limiting / confusing multi-device flows
Remove-Item Env:ANDROID_SERIAL -ErrorAction SilentlyContinue

if (-not (Get-Command adb -ErrorAction SilentlyContinue)) {
    throw "adb not found in PATH"
}

if ($ListSuites) {
    $suites = @(Get-MtbfSuites)
    if ($suites.Count -eq 0) {
        Write-Host "No suites found under suites/task/" -ForegroundColor Yellow
        exit 0
    }
    $families = @(Get-MtbfAvailableApkFamilies -Suites $suites)
    Show-MtbfApkFamilyMenu -Families $families
    foreach ($f in $families) {
        $filtered = @(Filter-MtbfSuitesByInstrumentApk -Suites $suites -InstrumentName $f.InstrumentName)
        Write-Host ""
        Write-Host "---- $($f.Label) -> $($filtered.Count) XML ----" -ForegroundColor Cyan
        Show-MtbfSuiteMenu -Suites $filtered -InstrumentName $f.InstrumentName -Mode $(if ($Mode) { $Mode } else { "apk" })
    }
    exit 0
}

$resolvedMode = $null
if ($Mode) {
    $resolvedMode = Normalize-MtbfMode -Mode $Mode
} elseif ($NonInteractive) {
    $resolvedMode = Resolve-MtbfMode -Mode "" -AllowEmpty
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

    Write-Host ""
    Write-Host "Selected mode   : $resolvedMode" -ForegroundColor Green
    Write-Host "Selected device : $($serials -join ', ')" -ForegroundColor Green
    if ($selected.SelectedIndex) {
        Write-Host ("Selected index  : {0}" -f $selected.SelectedIndex) -ForegroundColor Green
    }
    Write-Host "Selected task   : $($selected.TaskName)" -ForegroundColor Green
    Write-Host "  file: $($selected.FileName)" -ForegroundColor DarkGray
    Write-Host "  path: $($selected.TaskXmlPath)" -ForegroundColor DarkGray
    Write-Host "  apk:  $($selected.InstrumentNames -join ', ')" -ForegroundColor DarkGray
    $missing = Test-MtbfSuiteApks -Suite $selected -RequireTestApks -Mode $resolvedMode
    if ($missing.Count -gt 0) {
        throw "Cannot deploy. Missing: $($missing -join ', '). Put files in: $($selected.ApkDir) / shared/"
    }

    $confirmed = Confirm-MtbfAction -Prompt "Confirm deploy this task on $($serials.Count) device(s)? (Y/N/Q)"
    if ($null -eq $confirmed) {
        Write-Host "Cancelled." -ForegroundColor Yellow
        exit 0
    }
    if (-not $confirmed) {
        Write-Host "Cancelled." -ForegroundColor Yellow
        exit 0
    }
}

Invoke-MtbfForEachDeviceParallel -Serials $serials -SuiteId $selected.Id -Action deploy `
    -Mode $resolvedMode -TaskTimes $TaskTimes -Tester $Tester -Start:$Start
