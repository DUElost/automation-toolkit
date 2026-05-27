param(
    [string]$Serial = "11914404BG102162",
    [string]$Root = ".\downloaded_apks_Infinix X6852_Android16",
    [switch]$AllowDowngrade
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$rootPath = (Resolve-Path $Root).Path
$appDirs = Get-ChildItem $rootPath -Directory | Sort-Object Name

if (-not $appDirs) {
    throw "No app directories found under: $rootPath"
}

$success = 0
$fail = 0

foreach ($dir in $appDirs) {
    $apks = Get-ChildItem $dir.FullName -Filter *.apk | Sort-Object Name
    if (-not $apks) {
        continue
    }

    $args = @("-s", $Serial, "install-multiple", "-r", "-g")
    if ($AllowDowngrade) {
        $args += "-d"
    }
    $args += ($apks | ForEach-Object { $_.FullName })

    Write-Host ""
    Write-Host "Installing $($dir.Name) ..." -ForegroundColor Cyan

    & adb @args
    if ($LASTEXITCODE -eq 0) {
        $success += 1
    } else {
        $fail += 1
        Write-Host "Failed: $($dir.Name)" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Done: $success success, $fail failed" -ForegroundColor Green
