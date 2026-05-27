[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$TaskName,

    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$FilePath,

    [Parameter()]
    [string]$Arguments = "",

    [Parameter()]
    [string]$WorkDir,

    [Parameter()]
    [ValidatePattern("^\d{2}:\d{2}$")]
    [string]$DailyAt,

    [Parameter()]
    [object]$RunAt,

    [Parameter()]
    [ValidateRange(0, 1440)]
    [int]$ReminderMinutes = 10,

    [Parameter()]
    [switch]$WakeToRun,

    [Parameter()]
    [switch]$ReplaceExisting
)

$ErrorActionPreference = "Stop"

function Convert-ToDateTime {
    param(
        [Parameter()]
        [AllowNull()]
        [object]$InputValue
    )

    if ($null -eq $InputValue) {
        return $null
    }

    if ($InputValue -is [datetime]) {
        return [datetime]$InputValue
    }

    $text = [string]$InputValue
    if ([string]::IsNullOrWhiteSpace($text)) {
        return $null
    }

    $formats = @(
        "yyyy-MM-dd HH:mm:ss",
        "yyyy-MM-dd HH:mm",
        "yyyy/MM/dd HH:mm:ss",
        "yyyy/MM/dd HH:mm",
        "MM/dd/yyyy HH:mm:ss",
        "MM/dd/yyyy HH:mm"
    )

    foreach ($format in $formats) {
        $parsedValue = [datetime]::MinValue
        if ([datetime]::TryParseExact($text, $format, [System.Globalization.CultureInfo]::InvariantCulture, [System.Globalization.DateTimeStyles]::None, [ref]$parsedValue)) {
            return $parsedValue
        }
    }

    $fallbackValue = [datetime]::MinValue
    if ([datetime]::TryParse($text, [ref]$fallbackValue)) {
        return $fallbackValue
    }

    throw "RunAt value is invalid: $text"
}

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

function Ensure-Directory {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    if (-not (Test-Path -LiteralPath $Path)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
    }
}

function Get-RunnerArguments {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateSet("remind", "execute")]
        [string]$Mode,

        [Parameter(Mandatory = $true)]
        [string]$RunnerPath,

        [Parameter(Mandatory = $true)]
        [string]$ConfigPath
    )

    return '-NoProfile -ExecutionPolicy Bypass -File "{0}" -Mode {1} -ConfigPath "{2}"' -f $RunnerPath, $Mode, $ConfigPath
}

function New-TaskTrigger {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateSet("execute", "remind")]
        [string]$Mode,

        [Parameter(Mandatory = $true)]
        [ValidateSet("Daily", "Once")]
        [string]$ScheduleType,

        [Parameter()]
        [string]$TimeText,

        [Parameter()]
        [AllowNull()]
        [object]$DateTimeValue,

        [Parameter()]
        [int]$ReminderOffsetMinutes = 0
    )

    if ($ScheduleType -eq "Daily") {
        $baseTime = [datetime]::Today.Add([timespan]::ParseExact($TimeText, "hh\:mm", $null))
        $triggerTime = if ($Mode -eq "remind") { $baseTime.AddMinutes(-$ReminderOffsetMinutes) } else { $baseTime }
        return New-ScheduledTaskTrigger -Daily -At $triggerTime
    }

    $resolvedDateTimeValue = Convert-ToDateTime -InputValue $DateTimeValue

    if ($null -eq $resolvedDateTimeValue) {
        throw "DateTimeValue is required when ScheduleType is Once."
    }

    $onceTime = if ($Mode -eq "remind") { $resolvedDateTimeValue.AddMinutes(-$ReminderOffsetMinutes) } else { $resolvedDateTimeValue }
    return New-ScheduledTaskTrigger -Once -At $onceTime
}

if (-not (Get-Command -Name Register-ScheduledTask -ErrorAction SilentlyContinue)) {
    throw "ScheduledTasks module is not available on this system."
}

$resolvedRunAt = Convert-ToDateTime -InputValue $RunAt

$scheduleType = $null
if (-not [string]::IsNullOrWhiteSpace($DailyAt) -and $null -ne $resolvedRunAt) {
    throw "DailyAt and RunAt cannot be used together."
}
elseif (-not [string]::IsNullOrWhiteSpace($DailyAt)) {
    $scheduleType = "Daily"
}
elseif ($null -ne $resolvedRunAt) {
    $scheduleType = "Once"
}
else {
    throw "Either DailyAt or RunAt must be provided."
}

if ($scheduleType -eq "Once" -and $resolvedRunAt -le (Get-Date)) {
    throw "RunAt must be a future time."
}

$resolvedFilePath = (Resolve-Path -LiteralPath $FilePath).Path
$resolvedWorkDir = if ([string]::IsNullOrWhiteSpace($WorkDir)) {
    Split-Path -Path $resolvedFilePath -Parent
}
else {
    (Resolve-Path -LiteralPath $WorkDir).Path
}

$runnerPath = Join-Path -Path $PSScriptRoot -ChildPath "Run-ScheduledTool.ps1"
if (-not (Test-Path -LiteralPath $runnerPath)) {
    throw "Runner script was not found: $runnerPath"
}

$taskKey = Get-TaskKey -Name $TaskName
$taskDisplayName = Get-TaskDisplayName -Name $TaskName
if ([string]::IsNullOrWhiteSpace($taskDisplayName)) {
    throw "TaskName becomes empty after normalization."
}

$taskPrefix = "AutomationToolkit-{0}" -f $taskDisplayName
$mainTaskName = "{0}-Execute" -f $taskPrefix
$remindTaskName = "{0}-Reminder" -f $taskPrefix

$configDir = Join-Path -Path $PSScriptRoot -ChildPath "tasks"
$logDir = Join-Path -Path $PSScriptRoot -ChildPath ("logs\{0}" -f $taskKey)
Ensure-Directory -Path $configDir
Ensure-Directory -Path $logDir

$configPath = Join-Path -Path $configDir -ChildPath ("{0}.json" -f $taskKey)
$scheduleLabel = if ($scheduleType -eq "Daily") {
    "Daily $DailyAt"
}
else {
    $resolvedRunAt.ToString("yyyy-MM-dd HH:mm")
}

$config = [ordered]@{
    taskName = $TaskName
    taskKey = $taskKey
    filePath = $resolvedFilePath
    arguments = $Arguments
    workDir = $resolvedWorkDir
    logDir = $logDir
    reminderMinutes = $ReminderMinutes
    schedule = @{
        type = $scheduleType
        label = $scheduleLabel
    }
    createdAt = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
}

if ($PSCmdlet.ShouldProcess($configPath, "Write generated task config")) {
    $config | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath $configPath -Encoding UTF8
}

if ($ReplaceExisting) {
    if ($PSCmdlet.ShouldProcess($mainTaskName, "Remove existing execute task before replace")) {
        Unregister-ScheduledTask -TaskName $mainTaskName -Confirm:$false -ErrorAction SilentlyContinue
    }

    if ($PSCmdlet.ShouldProcess($remindTaskName, "Remove existing reminder task before replace")) {
        Unregister-ScheduledTask -TaskName $remindTaskName -Confirm:$false -ErrorAction SilentlyContinue
    }
}

$registerExecuteTask = $PSCmdlet.ShouldProcess($mainTaskName, "Register execute scheduled task")
$registerReminderTask = $false
if ($ReminderMinutes -gt 0) {
    $registerReminderTask = $PSCmdlet.ShouldProcess($remindTaskName, "Register reminder scheduled task")
}

if ($registerExecuteTask -or $registerReminderTask) {
    $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument (Get-RunnerArguments -Mode "execute" -RunnerPath $runnerPath -ConfigPath $configPath) -WorkingDirectory $resolvedWorkDir
    $executeTrigger = New-TaskTrigger -Mode "execute" -ScheduleType $scheduleType -TimeText $DailyAt -DateTimeValue $resolvedRunAt

    $currentUser = if ([string]::IsNullOrWhiteSpace($env:USERDOMAIN)) {
        $env:USERNAME
    }
    else {
        "{0}\{1}" -f $env:USERDOMAIN, $env:USERNAME
    }

    $principal = New-ScheduledTaskPrincipal -UserId $currentUser -LogonType Interactive -RunLevel Limited
    $settings = New-ScheduledTaskSettingsSet `
        -AllowStartIfOnBatteries `
        -DontStopIfGoingOnBatteries `
        -StartWhenAvailable `
        -MultipleInstances IgnoreNew `
        -WakeToRun:$WakeToRun
}

if ($registerExecuteTask) {
    Register-ScheduledTask `
        -TaskName $mainTaskName `
        -Action $action `
        -Trigger $executeTrigger `
        -Principal $principal `
        -Settings $settings `
        -Description ("Automation Toolkit execute task: {0}" -f $TaskName) `
        -Force | Out-Null
}

if ($registerReminderTask) {
    $remindAction = New-ScheduledTaskAction -Execute "powershell.exe" -Argument (Get-RunnerArguments -Mode "remind" -RunnerPath $runnerPath -ConfigPath $configPath) -WorkingDirectory $resolvedWorkDir
    $remindTrigger = New-TaskTrigger -Mode "remind" -ScheduleType $scheduleType -TimeText $DailyAt -DateTimeValue $resolvedRunAt -ReminderOffsetMinutes $ReminderMinutes

    Register-ScheduledTask `
        -TaskName $remindTaskName `
        -Action $remindAction `
        -Trigger $remindTrigger `
        -Principal $principal `
        -Settings $settings `
        -Description ("Automation Toolkit reminder task: {0}" -f $TaskName) `
        -Force | Out-Null
}

[pscustomobject]@{
    TaskName = $TaskName
    ExecuteTask = $mainTaskName
    ReminderTask = if ($ReminderMinutes -gt 0) { $remindTaskName } else { "Disabled" }
    Schedule = $scheduleLabel
    ReminderMinutes = $ReminderMinutes
    ConfigPath = $configPath
    LogDir = $logDir
}
