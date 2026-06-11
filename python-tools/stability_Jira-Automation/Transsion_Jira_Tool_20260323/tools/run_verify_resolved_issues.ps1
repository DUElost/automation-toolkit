param(
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"

$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$configPath = Join-Path $scriptRoot "verify_resolved_config.json"
$logDir = Join-Path $scriptRoot "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null

if (-not (Test-Path -LiteralPath $configPath)) {
    throw "Config file not found: $configPath"
}

$config = Get-Content -LiteralPath $configPath -Raw | ConvertFrom-Json
if (-not $config.project_keys -or $config.project_keys.Count -eq 0) {
    throw "verify_resolved_config.json must define project_keys"
}
if (-not $config.reporters -or $config.reporters.Count -eq 0) {
    throw "verify_resolved_config.json must define reporters"
}

$useDryRun = $DryRun.IsPresent -or [bool]$config.dry_run

$dateStamp = Get-Date -Format "yyyy-MM-dd"
$logFile = Join-Path $logDir "verify_resolved_issues_$dateStamp.log"
$pythonCommand = (Get-Command python -ErrorAction Stop).Source
$pythonArgs = @(
    "verify_resolved_issues.py",
    "--project-keys"
) + [string[]]$config.project_keys + @(
    "--reporter"
) + [string[]]$config.reporters

if ($useDryRun) {
    $pythonArgs += "--dry-run"
}

Push-Location $scriptRoot
try {
    "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] START" | Tee-Object -FilePath $logFile -Append
    "Working directory: $scriptRoot" | Tee-Object -FilePath $logFile -Append
    "Config: $configPath" | Tee-Object -FilePath $logFile -Append
    "Command: python $($pythonArgs -join ' ')" | Tee-Object -FilePath $logFile -Append

    & $pythonCommand @pythonArgs 2>&1 | Tee-Object -FilePath $logFile -Append
    $exitCode = $LASTEXITCODE

    "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] END ExitCode=$exitCode" | Tee-Object -FilePath $logFile -Append
    exit $exitCode
}
finally {
    Pop-Location
}
