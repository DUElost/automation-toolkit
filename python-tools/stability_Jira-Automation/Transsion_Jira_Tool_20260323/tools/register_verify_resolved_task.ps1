$ErrorActionPreference = "Stop"

$taskName = "TranssionJiraVerifyResolvedIssuesDaily"
$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$runnerPath = Join-Path $scriptRoot "run_verify_resolved_issues.ps1"
$schtasksPath = (Get-Command schtasks -ErrorAction Stop).Source

if (-not (Test-Path -LiteralPath $runnerPath)) {
    throw "Runner script not found: $runnerPath"
}

$taskAction = 'powershell.exe -ExecutionPolicy Bypass -File "' + $runnerPath + '"'

& $schtasksPath /Create `
    /TN $taskName `
    /TR $taskAction `
    /SC DAILY `
    /ST 09:00 `
    /F

if ($LASTEXITCODE -ne 0) {
    throw "Task creation or update failed. schtasks exit code: $LASTEXITCODE"
}

Write-Host "Task created or updated: $taskName"
Write-Host "Config file: $(Join-Path $scriptRoot 'verify_resolved_config.json')"
Write-Host "Dry-run trigger: powershell -ExecutionPolicy Bypass -File `"$runnerPath`" -DryRun"
Write-Host "Manual trigger command: schtasks /Run /TN `"$taskName`""
