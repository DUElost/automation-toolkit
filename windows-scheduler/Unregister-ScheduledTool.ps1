[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$TaskName,

    [Parameter()]
    [switch]$RemoveGeneratedFiles
)

$ErrorActionPreference = "Stop"

function Get-TaskKey {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name
    )

    $normalized = ($Name -replace "[^a-zA-Z0-9_.-]", "_").Trim("._-")
    $sha1 = [System.Security.Cryptography.SHA1]::Create()
    try {
        $hashBytes = $sha1.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($Name))
    }
    finally {
        $sha1.Dispose()
    }

    $hash = -join ($hashBytes | Select-Object -First 6 | ForEach-Object { $_.ToString("x2") })
    if ([string]::IsNullOrWhiteSpace($normalized)) {
        return "task-{0}" -f $hash
    }

    return "{0}-{1}" -f $normalized, $hash
}

function Get-TaskDisplayName {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name
    )

    return (($Name -replace '[\\/:*?"<>|]', "_").Trim())
}

$taskKey = Get-TaskKey -Name $TaskName
$taskDisplayName = Get-TaskDisplayName -Name $TaskName
$mainTaskName = "AutomationToolkit-{0}-Execute" -f $taskDisplayName
$remindTaskName = "AutomationToolkit-{0}-Reminder" -f $taskDisplayName
$configPath = Join-Path -Path (Join-Path -Path $PSScriptRoot -ChildPath "tasks") -ChildPath ("{0}.json" -f $taskKey)
$logDir = Join-Path -Path $PSScriptRoot -ChildPath ("logs\{0}" -f $taskKey)

if ($PSCmdlet.ShouldProcess($mainTaskName, "Remove execute scheduled task")) {
    Unregister-ScheduledTask -TaskName $mainTaskName -Confirm:$false -ErrorAction SilentlyContinue
}

if ($PSCmdlet.ShouldProcess($remindTaskName, "Remove reminder scheduled task")) {
    Unregister-ScheduledTask -TaskName $remindTaskName -Confirm:$false -ErrorAction SilentlyContinue
}

if ($RemoveGeneratedFiles) {
    if (Test-Path -LiteralPath $configPath) {
        if ($PSCmdlet.ShouldProcess($configPath, "Remove generated task config")) {
            Remove-Item -LiteralPath $configPath -Force
        }
    }

    if (Test-Path -LiteralPath $logDir) {
        if ($PSCmdlet.ShouldProcess($logDir, "Remove generated task log directory")) {
            Remove-Item -LiteralPath $logDir -Recurse -Force
        }
    }
}

[pscustomobject]@{
    TaskName = $TaskName
    ExecuteTask = $mainTaskName
    ReminderTask = $remindTaskName
    ConfigPath = $configPath
    LogDir = $logDir
    RemovedGeneratedFiles = [bool]$RemoveGeneratedFiles
}
