$ErrorActionPreference = "Stop"

$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$logDir = Join-Path $scriptRoot "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null

$dateStamp = Get-Date -Format "yyyy-MM-dd"
$logFile = Join-Path $logDir "verify_resolved_issues_$dateStamp.log"
$pythonCommand = (Get-Command python -ErrorAction Stop).Source
$pythonArgs = @(
    "verify_resolved_issues.py",
    "--project-keys", "X6852OS16", "X6851OS16", "X6851BOS16", "T1103OS163",
    "--reporter", "dailv.tinno", "qimingwang.tinno"
)

Push-Location $scriptRoot
try {
    "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] START" | Tee-Object -FilePath $logFile -Append
    "Working directory: $scriptRoot" | Tee-Object -FilePath $logFile -Append
    "Command: python $($pythonArgs -join ' ')" | Tee-Object -FilePath $logFile -Append

    & $pythonCommand @pythonArgs 2>&1 | Tee-Object -FilePath $logFile -Append
    $exitCode = $LASTEXITCODE

    "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] END ExitCode=$exitCode" | Tee-Object -FilePath $logFile -Append
    exit $exitCode
}
finally {
    Pop-Location
}


