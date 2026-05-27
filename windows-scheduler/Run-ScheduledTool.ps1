[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateSet("remind", "execute")]
    [string]$Mode,

    [Parameter(Mandatory = $true)]
    [string]$ConfigPath
)

$ErrorActionPreference = "Stop"

function Write-TaskLog {
    param(
        [Parameter(Mandatory = $true)]
        [string]$LogDir,

        [Parameter(Mandatory = $true)]
        [string]$Message
    )

    if (-not (Test-Path -LiteralPath $LogDir)) {
        New-Item -ItemType Directory -Path $LogDir -Force | Out-Null
    }

    $logFile = Join-Path -Path $LogDir -ChildPath ("{0}.log" -f (Get-Date -Format "yyyy-MM-dd"))
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -LiteralPath $logFile -Value ("[{0}] {1}" -f $timestamp, $Message)
}

function Get-ToolExecutionPlan {
    param(
        [Parameter(Mandatory = $true)]
        [string]$ToolPath,

        [Parameter()]
        [string]$ArgumentsText = ""
    )

    $extension = [System.IO.Path]::GetExtension($ToolPath).ToLowerInvariant()
    $trimmedArguments = $ArgumentsText.Trim()

    switch ($extension) {
        ".ps1" {
            return @{
                FilePath = "powershell.exe"
                Arguments = ('-NoProfile -ExecutionPolicy Bypass -File "{0}" {1}' -f $ToolPath, $trimmedArguments).Trim()
            }
        }
        ".bat" {
            return @{
                FilePath = "cmd.exe"
                Arguments = ('/c ""{0}"" {1}' -f $ToolPath, $trimmedArguments).Trim()
            }
        }
        ".cmd" {
            return @{
                FilePath = "cmd.exe"
                Arguments = ('/c ""{0}"" {1}' -f $ToolPath, $trimmedArguments).Trim()
            }
        }
        ".py" {
            return @{
                FilePath = "python.exe"
                Arguments = ('"{0}" {1}' -f $ToolPath, $trimmedArguments).Trim()
            }
        }
        default {
            return @{
                FilePath = $ToolPath
                Arguments = $trimmedArguments
            }
        }
    }
}

function Show-ReminderToast {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Title,

        [Parameter(Mandatory = $true)]
        [string]$Message
    )

    try {
        Add-Type -AssemblyName System.Runtime.WindowsRuntime
        [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
        [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null

        $safeTitle = [System.Security.SecurityElement]::Escape($Title)
        $safeMessage = [System.Security.SecurityElement]::Escape($Message)
        $toastXml = @"
<toast scenario="reminder">
  <visual>
    <binding template="ToastGeneric">
      <text>$safeTitle</text>
      <text>$safeMessage</text>
    </binding>
  </visual>
</toast>
"@

        $xml = New-Object Windows.Data.Xml.Dom.XmlDocument
        $xml.LoadXml($toastXml)

        $toast = [Windows.UI.Notifications.ToastNotification]::new($xml)
        $notifier = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier("PowerShell")
        $notifier.Show($toast)
        return $true
    }
    catch {
        return $false
    }
}

if (-not (Test-Path -LiteralPath $ConfigPath)) {
    throw "Task config file was not found: $ConfigPath"
}

$config = Get-Content -LiteralPath $ConfigPath -Raw | ConvertFrom-Json
$toolPath = [string]$config.filePath
$workDir = [string]$config.workDir
$logDir = [string]$config.logDir
$taskName = [string]$config.taskName
$taskKey = [string]$config.taskKey
$argumentsText = [string]$config.arguments

if ([string]::IsNullOrWhiteSpace($logDir)) {
    $logDir = Join-Path -Path $PSScriptRoot -ChildPath "logs"
}

if ($Mode -eq "remind") {
    $reminderMinutes = [int]$config.reminderMinutes
    $message = 'Task "{0}" will run in {1} minute(s). Target: {2}' -f $taskName, $reminderMinutes, $toolPath
    $toastShown = Show-ReminderToast -Title "Automation Toolkit Reminder" -Message $message

    if (-not $toastShown) {
        try {
            msg.exe $env:USERNAME $message | Out-Null
        }
        catch {
            Write-TaskLog -LogDir $logDir -Message ("Reminder display failed. Fallback to log only: {0}" -f $_.Exception.Message)
        }
    }

    Write-TaskLog -LogDir $logDir -Message ("Reminder triggered: {0}" -f $message)
    return
}

if (-not (Test-Path -LiteralPath $toolPath)) {
    Write-TaskLog -LogDir $logDir -Message ("Execution failed. Target file does not exist: {0}" -f $toolPath)
    throw "Target file does not exist: $toolPath"
}

if ([string]::IsNullOrWhiteSpace($workDir)) {
    $workDir = Split-Path -Path $toolPath -Parent
}

$mutexSeed = if ([string]::IsNullOrWhiteSpace($taskKey)) { ($taskName -replace "[^a-zA-Z0-9_.-]", "_") } else { $taskKey }
$mutexName = "AutomationToolkit.{0}" -f $mutexSeed
$mutex = New-Object System.Threading.Mutex($false, $mutexName)
$lockAcquired = $false

try {
    $lockAcquired = $mutex.WaitOne(0)
    if (-not $lockAcquired) {
        Write-TaskLog -LogDir $logDir -Message ("Task is already running. Skip this trigger: {0}" -f $taskName)
        return
    }

    $plan = Get-ToolExecutionPlan -ToolPath $toolPath -ArgumentsText $argumentsText
    $stdoutPath = Join-Path -Path $logDir -ChildPath ("stdout-{0}.tmp" -f [System.Guid]::NewGuid().ToString("N"))
    $stderrPath = Join-Path -Path $logDir -ChildPath ("stderr-{0}.tmp" -f [System.Guid]::NewGuid().ToString("N"))

    Write-TaskLog -LogDir $logDir -Message ("Task started: {0}; Command: {1} {2}" -f $taskName, $plan.FilePath, $plan.Arguments)

    $process = Start-Process -FilePath $plan.FilePath `
        -ArgumentList $plan.Arguments `
        -WorkingDirectory $workDir `
        -PassThru `
        -Wait `
        -RedirectStandardOutput $stdoutPath `
        -RedirectStandardError $stderrPath

    if (Test-Path -LiteralPath $stdoutPath) {
        $stdoutContent = Get-Content -LiteralPath $stdoutPath -Raw
        if (-not [string]::IsNullOrWhiteSpace($stdoutContent)) {
            Write-TaskLog -LogDir $logDir -Message ("stdout:`n{0}" -f $stdoutContent.TrimEnd())
        }
        Remove-Item -LiteralPath $stdoutPath -Force -ErrorAction SilentlyContinue
    }

    if (Test-Path -LiteralPath $stderrPath) {
        $stderrContent = Get-Content -LiteralPath $stderrPath -Raw
        if (-not [string]::IsNullOrWhiteSpace($stderrContent)) {
            Write-TaskLog -LogDir $logDir -Message ("stderr:`n{0}" -f $stderrContent.TrimEnd())
        }
        Remove-Item -LiteralPath $stderrPath -Force -ErrorAction SilentlyContinue
    }

    Write-TaskLog -LogDir $logDir -Message ("Task finished: {0}; ExitCode: {1}" -f $taskName, $process.ExitCode)

    if ($process.ExitCode -ne 0) {
        exit $process.ExitCode
    }
}
finally {
    if ($lockAcquired) {
        $mutex.ReleaseMutex() | Out-Null
    }
    $mutex.Dispose()
}
