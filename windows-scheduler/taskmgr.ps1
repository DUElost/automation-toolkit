# taskmgr — Windows 计划任务管理 CLI（对齐 macOS system_Task-Scheduler/taskmgr）
# 用法: .\taskmgr.ps1 {list|add|edit|remove|start|stop|log|status|delay|cancel|enable} [name] [args]

[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [string]$Command = "help",

    [Parameter(Position = 1)]
    [string]$Name,

    [Parameter(Position = 2)]
    [string]$ExtraArg
)

$ErrorActionPreference = "Stop"

$ScriptRootDir = $PSScriptRoot
$TasksDir = Join-Path $ScriptRootDir "tasks"
$RuntimeDir = Join-Path $ScriptRootDir "runtime"
$RegisterScript = Join-Path $ScriptRootDir "Register-ScheduledTool.ps1"
$UnregisterScript = Join-Path $ScriptRootDir "Unregister-ScheduledTool.ps1"

function Write-Ok {
    param([string]$Message)
    Write-Host ("✅ {0}" -f $Message)
}

function Write-Die {
    param([string]$Message)
    Write-Host ("❌ {0}" -f $Message) -ForegroundColor Red
    exit 1
}

function Ensure-Directory {
    param([string]$Path)
    if (-not (Test-Path -LiteralPath $Path)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
    }
}

function Get-TaskKey {
    param([Parameter(Mandatory = $true)][string]$TaskNameValue)

    $normalized = ($TaskNameValue -replace "[^a-zA-Z0-9_.-]", "_").Trim("._-")
    $sha1 = [System.Security.Cryptography.SHA1]::Create()
    try {
        $hashBytes = $sha1.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($TaskNameValue))
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
    param([Parameter(Mandatory = $true)][string]$TaskNameValue)
    return (($TaskNameValue -replace '[\\/:*?"<>|]', "_").Trim())
}

function Get-ScheduledTaskNames {
    param([Parameter(Mandatory = $true)][string]$TaskNameValue)

    $displayName = Get-TaskDisplayName -TaskNameValue $TaskNameValue
    return @{
        Execute = "AutomationToolkit-{0}-Execute" -f $displayName
        Reminder = "AutomationToolkit-{0}-Reminder" -f $displayName
    }
}

function Get-ConfigPathByName {
    param([Parameter(Mandatory = $true)][string]$TaskNameValue)

    $taskKey = Get-TaskKey -TaskNameValue $TaskNameValue
    return Join-Path $TasksDir ("{0}.json" -f $taskKey)
}

function Split-CommandLine {
    param([Parameter(Mandatory = $true)][string]$Line)

    $result = New-Object System.Collections.Generic.List[string]
    $current = New-Object System.Text.StringBuilder
    $inQuote = $false

    for ($index = 0; $index -lt $Line.Length; $index++) {
        $char = $Line[$index]
        if ($char -eq '"') {
            $inQuote = -not $inQuote
            [void]$current.Append($char)
            continue
        }

        if (-not $inQuote -and $char -eq ' ') {
            if ($current.Length -gt 0) {
                $result.Add($current.ToString().Trim('"'))
                [void]$current.Clear()
            }
            continue
        }

        [void]$current.Append($char)
    }

    if ($current.Length -gt 0) {
        $result.Add($current.ToString().Trim('"'))
    }

    return ,$result.ToArray()
}

function Resolve-ToolPath {
    param([Parameter(Mandatory = $true)][string]$PathText)

    $expanded = $PathText -replace '^~', $env:USERPROFILE
    if (-not [System.IO.Path]::IsPathRooted($expanded)) {
        $candidate = Join-Path (Get-Location) $expanded
        if (Test-Path -LiteralPath $candidate) {
            $expanded = $candidate
        }
    }

    if (-not (Test-Path -LiteralPath $expanded)) {
        throw "路径不存在: $PathText"
    }

    return (Resolve-Path -LiteralPath $expanded).Path
}

function ConvertFrom-LaunchCommand {
    param([Parameter(Mandatory = $true)][string]$CommandText)

    $command = $CommandText.Trim()
    if ([string]::IsNullOrWhiteSpace($command)) {
        throw "命令不能为空"
    }

    $parts = Split-CommandLine -Line $command
    if ($parts.Count -eq 0) {
        throw "命令不能为空"
    }

    $interpreters = @{
        python = $true
        python3 = $true
        py = $true
        node = $true
        nodejs = $true
    }

    $first = $parts[0].ToLowerInvariant()
    if ($interpreters.ContainsKey($first) -and $parts.Count -ge 2) {
        $scriptPath = Resolve-ToolPath -PathText $parts[1]
        $argumentText = if ($parts.Count -gt 2) { ($parts[2..($parts.Count - 1)] -join " ") } else { "" }
        return @{
            FilePath = $scriptPath
            Arguments = $argumentText
            WorkDir = Split-Path -Path $scriptPath -Parent
        }
    }

    if ($first -in @("powershell", "pwsh") -and $parts.Count -ge 2) {
        $scriptIndex = 1
        if ($parts[1] -eq "-File" -and $parts.Count -ge 3) {
            $scriptIndex = 2
        }

        $scriptPath = Resolve-ToolPath -PathText $parts[$scriptIndex]
        $tailStart = $scriptIndex + 1
        $argumentText = if ($parts.Count -gt $tailStart) { ($parts[$tailStart..($parts.Count - 1)] -join " ") } else { "" }
        return @{
            FilePath = $scriptPath
            Arguments = $argumentText
            WorkDir = Split-Path -Path $scriptPath -Parent
        }
    }

    $directPath = Resolve-ToolPath -PathText $parts[0]
    $extension = [System.IO.Path]::GetExtension($directPath).ToLowerInvariant()
    $supported = @(".py", ".ps1", ".bat", ".cmd", ".exe")
    if ($extension -notin $supported) {
        throw "暂不支持直接执行该类型，请改用 python/node/powershell 包裹，或指定 .py/.ps1/.bat/.exe"
    }

    return @{
        FilePath = $directPath
        Arguments = if ($parts.Count -gt 1) { ($parts[1..($parts.Count - 1)] -join " ") } else { "" }
        WorkDir = Split-Path -Path $directPath -Parent
    }
}

function Get-TaskConfigEntries {
    Ensure-Directory -Path $TasksDir
    $entries = @()

    foreach ($file in Get-ChildItem -LiteralPath $TasksDir -Filter "*.json" -File | Sort-Object Name) {
        try {
            $config = Get-Content -LiteralPath $file.FullName -Raw | ConvertFrom-Json
            $entries += [pscustomobject]@{
                Config = $config
                Path = $file.FullName
            }
        }
        catch {
            continue
        }
    }

    return $entries
}

function Get-TaskConfigPath {
    param([Parameter(Mandatory = $true)][string]$TaskNameValue)

    foreach ($entry in Get-TaskConfigEntries) {
        if ([string]$entry.Config.taskName -eq $TaskNameValue) {
            return $entry.Path
        }
    }

    return $null
}

function Get-TaskConfig {
    param([Parameter(Mandatory = $true)][string]$TaskNameValue)

    foreach ($entry in Get-TaskConfigEntries) {
        if ([string]$entry.Config.taskName -eq $TaskNameValue) {
            return $entry.Config
        }
    }

    Write-Die "任务 '$TaskNameValue' 不存在"
}

function Get-AllTaskConfigs {
    return (Get-TaskConfigEntries | ForEach-Object { $_.Config })
}

function Get-DelayInfo {
    param([Parameter(Mandatory = $true)][string]$TaskNameValue)

    $taskKey = Get-TaskKey -TaskNameValue $TaskNameValue
    $pidFile = Join-Path $RuntimeDir ("{0}.pid" -f $taskKey)
    if (-not (Test-Path -LiteralPath $pidFile)) {
        return $null
    }

    $line = (Get-Content -LiteralPath $pidFile -Raw).Trim()
    if ([string]::IsNullOrWhiteSpace($line)) {
        Remove-Item -LiteralPath $pidFile -Force -ErrorAction SilentlyContinue
        return $null
    }

    $parts = $line -split '\s+', 3
    if ($parts.Count -lt 3) {
        Remove-Item -LiteralPath $pidFile -Force -ErrorAction SilentlyContinue
        return $null
    }

    $processId = [int]$parts[0]
    $deadlineText = $parts[2]
    if (-not (Get-Process -Id $processId -ErrorAction SilentlyContinue)) {
        Remove-Item -LiteralPath $pidFile -Force -ErrorAction SilentlyContinue
        return $null
    }

    return @{
        ProcessId = $processId
        Deadline = $deadlineText
    }
}

function Get-TaskStatusText {
    param(
        [Parameter(Mandatory = $true)][string]$ExecuteTaskName
    )

    $task = Get-ScheduledTask -TaskName $ExecuteTaskName -ErrorAction SilentlyContinue
    if ($null -eq $task) {
        return "未注册"
    }

    switch ($task.State) {
        "Running" { return "运行中" }
        "Disabled" { return "已停用" }
        default { return "已启用" }
    }
}

function Get-ScheduleLabel {
    param($Config)

    $label = [string]$Config.schedule.label
    if ($Config.schedule.type -eq "Daily") {
        if ($label -match '^Daily\s+(\d{2}:\d{2})$') {
            return "每天 $($Matches[1])"
        }
        return $label
    }

    if ($Config.schedule.type -eq "Once") {
        return "一次性 $label"
    }

    return $label
}

function Invoke-RegisterFromConfig {
    param(
        [Parameter(Mandatory = $true)]$Config,
        [switch]$ReplaceExisting
    )

    $registerArgs = @{
        TaskName = [string]$Config.taskName
        FilePath = [string]$Config.filePath
        Arguments = [string]$Config.arguments
        WorkDir = [string]$Config.workDir
        ReminderMinutes = [int]$Config.reminderMinutes
        ReplaceExisting = [bool]$ReplaceExisting
    }

    if ($Config.schedule.type -eq "Daily") {
        if ([string]$Config.schedule.label -match '^Daily\s+(\d{2}:\d{2})$') {
            $registerArgs.DailyAt = $Matches[1]
        }
        else {
            throw "无法从配置恢复 DailyAt: $($Config.schedule.label)"
        }
    }
    elseif ($Config.schedule.type -eq "Once") {
        $registerArgs.RunAt = [string]$Config.schedule.label
    }
    else {
        throw "未知调度类型: $($Config.schedule.type)"
    }

    & $RegisterScript @registerArgs | Out-Null
}

function Show-RecentLog {
    param(
        [Parameter(Mandatory = $true)][string]$LogDir,
        [int]$LineCount = 5
    )

    if (-not (Test-Path -LiteralPath $LogDir)) {
        return
    }

    $latestLog = Get-ChildItem -LiteralPath $LogDir -Filter "*.log" -File |
        Sort-Object LastWriteTime -Descending |
        Select-Object -First 1

    if ($null -eq $latestLog) {
        return
    }

    Get-Content -LiteralPath $latestLog.FullName -Tail $LineCount
}

function Invoke-CmdList {
    $configs = Get-AllTaskConfigs
    if ($configs.Count -eq 0) {
        Write-Host "暂无托管任务"
        return
    }

    Write-Host ("{0,-20} {1,-10} {2,-12} {3}" -f "NAME", "STATUS", "DELAY", "SCHEDULE")
    Write-Host ("{0,-20} {1,-10} {2,-12} {3}" -f "----", "------", "----------", "--------")

    foreach ($config in $configs | Sort-Object taskName) {
        $taskNames = Get-ScheduledTaskNames -TaskNameValue ([string]$config.taskName)
        $status = Get-TaskStatusText -ExecuteTaskName $taskNames.Execute
        $delayInfo = Get-DelayInfo -TaskNameValue ([string]$config.taskName)
        $delayText = if ($null -ne $delayInfo) { $delayInfo.Deadline } else { "-" }
        $scheduleText = Get-ScheduleLabel -Config $config
        Write-Host ("{0,-20} {1,-10} {2,-12} {3}" -f $config.taskName, $status, $delayText, $scheduleText)
    }
}

function Invoke-CmdStatus {
    param([string]$TaskNameValue)

    if ([string]::IsNullOrWhiteSpace($TaskNameValue)) {
        Invoke-CmdList
        return
    }

    $config = Get-TaskConfig -TaskNameValue $TaskNameValue
    $taskNames = Get-ScheduledTaskNames -TaskNameValue $TaskNameValue
    $configPath = Get-TaskConfigPath -TaskNameValue $TaskNameValue

    Write-Host "=== $TaskNameValue ==="
    Write-Host ("配置  : {0}" -f $configPath)
    Write-Host ("目标  : {0}" -f $config.filePath)
    Write-Host ("参数  : {0}" -f ($(if ([string]::IsNullOrWhiteSpace($config.arguments)) { "(无)" } else { $config.arguments })))
    Write-Host ("日志  : {0}" -f $config.logDir)
    Write-Host ("状态  : {0}" -f (Get-TaskStatusText -ExecuteTaskName $taskNames.Execute))
    Write-Host ("调度  : {0}" -f (Get-ScheduleLabel -Config $config))
    Write-Host ("提醒  : 提前 {0} 分钟" -f $config.reminderMinutes)

    $executeTask = Get-ScheduledTask -TaskName $taskNames.Execute -ErrorAction SilentlyContinue
    if ($null -ne $executeTask) {
        $taskInfo = Get-ScheduledTaskInfo -TaskName $taskNames.Execute -ErrorAction SilentlyContinue
        if ($null -ne $taskInfo -and $taskInfo.NextRunTime) {
            Write-Host ("下次  : {0}" -f $taskInfo.NextRunTime)
        }
    }

    $delayInfo = Get-DelayInfo -TaskNameValue $TaskNameValue
    if ($null -ne $delayInfo) {
        Write-Host ("延时  : {0} (PID={1})" -f $delayInfo.Deadline, $delayInfo.ProcessId)
    }
}

function Invoke-CmdLog {
    param([string]$TaskNameValue)

    if ([string]::IsNullOrWhiteSpace($TaskNameValue)) {
        Write-Die "请指定任务名"
    }

    $config = Get-TaskConfig -TaskNameValue $TaskNameValue
    $logDir = [string]$config.logDir
    if (-not (Test-Path -LiteralPath $logDir)) {
        Write-Host "暂无日志"
        return
    }

    $latestLog = Get-ChildItem -LiteralPath $logDir -Filter "*.log" -File |
        Sort-Object LastWriteTime -Descending |
        Select-Object -First 1

    if ($null -eq $latestLog) {
        Write-Host "暂无日志"
        return
    }

    Get-Content -LiteralPath $latestLog.FullName -Tail 30
}

function Read-HostDefault {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Prompt,

        [Parameter()]
        [string]$DefaultValue = ""
    )

    $inputValue = Read-Host $Prompt
    if ([string]::IsNullOrWhiteSpace($inputValue)) {
        return $DefaultValue
    }

    return $inputValue
}

function Read-YesNoDefault {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Prompt,

        [Parameter()]
        [switch]$DefaultYes
    )

    $defaultLabel = if ($DefaultYes) { "Y/n" } else { "y/N" }
    $inputValue = Read-HostDefault -Prompt ("{0} [{1}]" -f $Prompt, $defaultLabel) -DefaultValue $(if ($DefaultYes) { "y" } else { "n" })
    return $inputValue -match '^[Yy]'
}

function Invoke-CmdAdd {
    param([string]$TaskNameValue)

    if ([string]::IsNullOrWhiteSpace($TaskNameValue)) {
        $TaskNameValue = Read-Host "任务名称 (Task name)"
        if ([string]::IsNullOrWhiteSpace($TaskNameValue)) {
            Write-Die "任务名称不能为空"
        }
    }

    $configPath = Get-TaskConfigPath -TaskNameValue $TaskNameValue
    if (-not [string]::IsNullOrWhiteSpace($configPath) -and (Test-Path -LiteralPath $configPath)) {
        Write-Die "任务 '$TaskNameValue' 已存在"
    }

    Write-Host "创建新定时任务: $TaskNameValue"
    Write-Host "-------------------------"

    $scheduleChoice = Read-HostDefault -Prompt "调度方式 [1=每天, 2=指定时间一次, 3=N分钟后一次] [1]" -DefaultValue "1"
    $dailyAt = $null
    $runAt = $null
    $scheduleSummary = ""

    switch ($scheduleChoice) {
        "2" {
            $defaultRunAt = (Get-Date).AddHours(1).ToString("yyyy-MM-dd HH:mm:ss")
            $runAtInput = Read-HostDefault -Prompt ("执行时间 (yyyy-MM-dd HH:mm:ss) [{0}]" -f $defaultRunAt) -DefaultValue $defaultRunAt
            try {
                $runAt = [datetime]::ParseExact($runAtInput, "yyyy-MM-dd HH:mm:ss", $null)
            }
            catch {
                $runAt = [datetime]::Parse($runAtInput)
            }

            if ($runAt -le (Get-Date)) {
                Write-Die "执行时间必须是未来时间"
            }

            $scheduleSummary = $runAt.ToString("yyyy-MM-dd HH:mm:ss")
        }
        "3" {
            $minutesInput = Read-Host "多少分钟后执行"
            if ([string]::IsNullOrWhiteSpace($minutesInput) -or $minutesInput -notmatch '^\d+$' -or [int]$minutesInput -le 0) {
                Write-Die "请提供有效的分钟数"
            }

            $runAt = (Get-Date).AddMinutes([int]$minutesInput)
            $scheduleSummary = ("{0} 分钟后（约 {1}）" -f $minutesInput, $runAt.ToString("HH:mm:ss"))
        }
        default {
            $hour = [int](Read-HostDefault -Prompt "Hour   (0-23) [9]" -DefaultValue "9")
            $minute = [int](Read-HostDefault -Prompt "Minute (0-59) [0]" -DefaultValue "0")
            if ($hour -lt 0 -or $hour -gt 23 -or $minute -lt 0 -or $minute -gt 59) {
                Write-Die "时间格式无效"
            }

            $dailyAt = "{0:D2}:{1:D2}" -f $hour, $minute
            $scheduleSummary = ("每天 {0}" -f $dailyAt)
        }
    }

    Write-Host "示例: python3 .\tool\main.py | node .\tool\task.js | .\tool\Start.bat"
    $commandInput = Read-Host "启动命令"
    if ([string]::IsNullOrWhiteSpace($commandInput)) {
        Write-Die "命令不能为空"
    }

    $launchPlan = ConvertFrom-LaunchCommand -CommandText $commandInput

    $wantReminder = Read-YesNoDefault -Prompt "执行前提前提醒?" -DefaultYes
    $reminderMinutes = 0
    if ($wantReminder) {
        $reminderMinutes = [int](Read-HostDefault -Prompt "提前提醒分钟数 [10]" -DefaultValue "10")
        if ($null -ne $runAt) {
            $minutesUntilRun = ($runAt - (Get-Date)).TotalMinutes
            if ($reminderMinutes -ge $minutesUntilRun) {
                $adjustedReminder = [Math]::Max(0, [int][Math]::Floor($minutesUntilRun) - 1)
                if ($adjustedReminder -ne $reminderMinutes) {
                    Write-Host ("提醒时间早于当前时间，已自动调整为 {0} 分钟" -f $adjustedReminder)
                    $reminderMinutes = $adjustedReminder
                }
            }
        }
    }

    $registerParams = @{
        TaskName = $TaskNameValue
        FilePath = $launchPlan.FilePath
        Arguments = $launchPlan.Arguments
        WorkDir = $launchPlan.WorkDir
        ReminderMinutes = $reminderMinutes
        ReplaceExisting = $true
    }

    if ($null -ne $dailyAt) {
        $registerParams.DailyAt = $dailyAt
    }
    else {
        $registerParams.RunAt = $runAt.ToString("yyyy-MM-dd HH:mm:ss")
    }

    & $RegisterScript @registerParams | Out-Null

    Write-Ok ("任务 '{0}' 已创建，{1} 执行" -f $TaskNameValue, $scheduleSummary)
    Write-Host ("  修改命令: taskmgr edit {0}" -f $TaskNameValue)
    Write-Host ("  查看日志: taskmgr log  {0}" -f $TaskNameValue)
    Write-Host ("  手动触发: taskmgr start {0}" -f $TaskNameValue)
}

function Invoke-CmdEdit {
    param([string]$TaskNameValue)

    if ([string]::IsNullOrWhiteSpace($TaskNameValue)) {
        Write-Die '用法: taskmgr edit <name>'
    }

    $config = Get-TaskConfig -TaskNameValue $TaskNameValue
    $configPath = Get-TaskConfigPath -TaskNameValue $TaskNameValue
    $currentCommand = if ([string]::IsNullOrWhiteSpace($config.arguments)) {
        [string]$config.filePath
    }
    else {
        "{0} {1}" -f $config.filePath, $config.arguments
    }

    Write-Host ("当前命令: {0}" -f $currentCommand)
    $newCommand = Read-Host "新命令 (留空不修改)"
    if ([string]::IsNullOrWhiteSpace($newCommand)) {
        return
    }

    $launchPlan = ConvertFrom-LaunchCommand -CommandText $newCommand
    $config.filePath = $launchPlan.FilePath
    $config.arguments = $launchPlan.Arguments
    $config.workDir = $launchPlan.WorkDir
    $config | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath $configPath -Encoding UTF8

    Invoke-RegisterFromConfig -Config $config -ReplaceExisting
    Write-Ok "命令已更新"
}

function Invoke-CmdStart {
    param([string]$TaskNameValue)

    if ([string]::IsNullOrWhiteSpace($TaskNameValue)) {
        Write-Die "请指定任务名"
    }

    $config = Get-TaskConfig -TaskNameValue $TaskNameValue
    $taskNames = Get-ScheduledTaskNames -TaskNameValue $TaskNameValue
    $executeTask = Get-ScheduledTask -TaskName $taskNames.Execute -ErrorAction SilentlyContinue
    if ($null -eq $executeTask) {
        Write-Die "启动失败，任务是否已注册？"
    }

    Start-ScheduledTask -TaskName $taskNames.Execute
    Start-Sleep -Seconds 2
    Show-RecentLog -LogDir ([string]$config.logDir) -LineCount 5
    Write-Ok ("{0} 已触发" -f $TaskNameValue)
}

function Invoke-CmdDelay {
    param(
        [string]$TaskNameValue,
        [string]$MinutesText
    )

    if ([string]::IsNullOrWhiteSpace($TaskNameValue)) {
        Write-Die '用法: taskmgr delay <name> <分钟数>'
    }

    if ([string]::IsNullOrWhiteSpace($MinutesText) -or $MinutesText -notmatch '^\d+$' -or [int]$MinutesText -le 0) {
        Write-Die "请提供有效的分钟数"
    }

    $config = Get-TaskConfig -TaskNameValue $TaskNameValue
    $taskNames = Get-ScheduledTaskNames -TaskNameValue $TaskNameValue
    $executeTask = Get-ScheduledTask -TaskName $taskNames.Execute -ErrorAction SilentlyContinue
    if ($null -eq $executeTask) {
        Write-Die "任务 '$TaskNameValue' 未注册到计划任务"
    }

    $minutes = [int]$MinutesText
    Ensure-Directory -Path $RuntimeDir
    $taskKey = Get-TaskKey -TaskNameValue $TaskNameValue
    $pidFile = Join-Path $RuntimeDir ("{0}.pid" -f $taskKey)

    $existingDelay = Get-DelayInfo -TaskNameValue $TaskNameValue
    if ($null -ne $existingDelay) {
        Stop-Process -Id $existingDelay.ProcessId -Force -ErrorAction SilentlyContinue
        Remove-Item -LiteralPath $pidFile -Force -ErrorAction SilentlyContinue
    }

    $deadline = (Get-Date).AddMinutes($minutes)
    $deadlineText = $deadline.ToString("HH:mm")
    $seconds = $minutes * 60
    $escapedTaskName = $taskNames.Execute.Replace("'", "''")
    $delayScript = "Start-Sleep -Seconds $seconds; Start-ScheduledTask -TaskName '$escapedTaskName'"

    $process = Start-Process `
        -FilePath "powershell.exe" `
        -ArgumentList @("-NoProfile", "-WindowStyle", "Hidden", "-Command", $delayScript) `
        -PassThru `
        -WindowStyle Hidden

    "{0} {1} {2}" -f $process.Id, ($deadline.ToString("yyyy-MM-dd HH:mm:ss")), $deadlineText |
        Set-Content -LiteralPath $pidFile -Encoding ASCII

    Write-Ok ("{0} 将在 {1} 分钟后执行（约 {2}）" -f $TaskNameValue, $minutes, $deadlineText)
}

function Invoke-CmdCancel {
    param(
        [string]$TaskNameValue,
        [switch]$Quiet
    )

    if ([string]::IsNullOrWhiteSpace($TaskNameValue)) {
        Write-Die '用法: taskmgr cancel <name>'
    }

    $taskKey = Get-TaskKey -TaskNameValue $TaskNameValue
    $pidFile = Join-Path $RuntimeDir ("{0}.pid" -f $taskKey)
    $delayInfo = Get-DelayInfo -TaskNameValue $TaskNameValue
    if ($null -eq $delayInfo) {
        if (-not $Quiet) {
            Write-Host "没有待执行的延时"
        }
        return
    }

    Stop-Process -Id $delayInfo.ProcessId -Force -ErrorAction SilentlyContinue
    Remove-Item -LiteralPath $pidFile -Force -ErrorAction SilentlyContinue
    Write-Ok ("{0} 延时已取消" -f $TaskNameValue)
}

function Invoke-CmdStop {
    param([string]$TaskNameValue)

    if ([string]::IsNullOrWhiteSpace($TaskNameValue)) {
        Write-Die "请指定任务名"
    }

    Get-TaskConfig -TaskNameValue $TaskNameValue | Out-Null
    $taskNames = Get-ScheduledTaskNames -TaskNameValue $TaskNameValue

    foreach ($scheduledName in @($taskNames.Execute, $taskNames.Reminder)) {
        if (Get-ScheduledTask -TaskName $scheduledName -ErrorAction SilentlyContinue) {
            Disable-ScheduledTask -TaskName $scheduledName | Out-Null
        }
    }

    Write-Ok ("{0} 已停用" -f $TaskNameValue)
}

function Invoke-CmdEnable {
    param([string]$TaskNameValue)

    if ([string]::IsNullOrWhiteSpace($TaskNameValue)) {
        Write-Die "请指定任务名"
    }

    Get-TaskConfig -TaskNameValue $TaskNameValue | Out-Null
    $taskNames = Get-ScheduledTaskNames -TaskNameValue $TaskNameValue

    foreach ($scheduledName in @($taskNames.Execute, $taskNames.Reminder)) {
        if (Get-ScheduledTask -TaskName $scheduledName -ErrorAction SilentlyContinue) {
            Enable-ScheduledTask -TaskName $scheduledName | Out-Null
        }
    }

    Write-Ok ("{0} 已启用" -f $TaskNameValue)
}

function Invoke-CmdRemove {
    param([string]$TaskNameValue)

    if ([string]::IsNullOrWhiteSpace($TaskNameValue)) {
        Write-Die '用法: taskmgr remove <name>'
    }

    Invoke-CmdCancel -TaskNameValue $TaskNameValue -Quiet
    & $UnregisterScript -TaskName $TaskNameValue -RemoveGeneratedFiles | Out-Null
    Write-Ok ("{0} 已删除" -f $TaskNameValue)
}

function Test-ScheduledTaskExists {
    param([Parameter(Mandatory = $true)][string]$ScheduledTaskName)

    return $null -ne (Get-ScheduledTask -TaskName $ScheduledTaskName -ErrorAction SilentlyContinue)
}

function Invoke-CmdCleanup {
    param(
        [switch]$RemoveLogs
    )

    $configs = Get-TaskConfigEntries
    if ($configs.Count -eq 0) {
        Write-Host "没有可清理的配置"
        return
    }

    $removedNames = New-Object System.Collections.Generic.List[string]
    foreach ($entry in $configs) {
        $config = $entry.Config
        $taskName = [string]$config.taskName
        $taskNames = Get-ScheduledTaskNames -TaskNameValue $taskName
        $executeExists = Test-ScheduledTaskExists -ScheduledTaskName $taskNames.Execute
        $reminderExists = Test-ScheduledTaskExists -ScheduledTaskName $taskNames.Reminder

        if ($executeExists -or $reminderExists) {
            continue
        }

        if (Test-Path -LiteralPath $entry.Path) {
            Remove-Item -LiteralPath $entry.Path -Force
        }

        if ($RemoveLogs) {
            $logDir = [string]$config.logDir
            if (-not [string]::IsNullOrWhiteSpace($logDir) -and (Test-Path -LiteralPath $logDir)) {
                Remove-Item -LiteralPath $logDir -Recurse -Force -ErrorAction SilentlyContinue
            }
        }

        [void]$removedNames.Add($taskName)
    }

    if ($removedNames.Count -eq 0) {
        Write-Host "没有发现孤儿配置"
        return
    }

    $suffix = if ($RemoveLogs) { "（含日志目录）" } else { "" }
    Write-Ok ("已清理 {0} 个孤儿配置{1}: {2}" -f $removedNames.Count, $suffix, ($removedNames -join ", "))
}

function Invoke-CmdHelp {
    Write-Host "taskmgr — Windows 计划任务管理器"
    Write-Host ""
    Write-Host "  taskmgr list              列出所有任务"
    Write-Host "  taskmgr status [name]     查看任务详情"
    Write-Host '  taskmgr log    <name>     查看运行日志'
    Write-Host '  taskmgr start  <name>     立即触发一次'
    Write-Host '  taskmgr delay  <name> <m> N 分钟后延时执行'
    Write-Host '  taskmgr cancel <name>     取消待执行的延时'
    Write-Host '  taskmgr stop   <name>     停用调度'
    Write-Host '  taskmgr enable <name>     启用调度'
    Write-Host '  taskmgr add    [name]     交互式创建新任务'
    Write-Host '  taskmgr edit   <name>     修改任务命令'
    Write-Host '  taskmgr remove <name>     删除任务'
    Write-Host '  taskmgr cleanup [logs]    清理无计划任务的孤儿配置'
    Write-Host ""
    Write-Host "快速开始:"
    Write-Host "  cd automation-toolkit"
    Write-Host "  taskmgr add mytask"
    Write-Host ""
    Write-Host "说明:"
    Write-Host "  - 与 macOS taskmgr 命令对齐，底层使用 Windows 任务计划程序"
    Write-Host "  - add 直接回车可选默认值；提醒为执行前 Toast/msg"
}

Ensure-Directory -Path $TasksDir
Ensure-Directory -Path $RuntimeDir

switch ($Command.ToLowerInvariant()) {
    "list" { Invoke-CmdList }
    "status" { Invoke-CmdStatus -TaskNameValue $Name }
    "log" { Invoke-CmdLog -TaskNameValue $Name }
    "add" { Invoke-CmdAdd -TaskNameValue $Name }
    "edit" { Invoke-CmdEdit -TaskNameValue $Name }
    "start" { Invoke-CmdStart -TaskNameValue $Name }
    "delay" { Invoke-CmdDelay -TaskNameValue $Name -MinutesText $ExtraArg }
    "cancel" { Invoke-CmdCancel -TaskNameValue $Name }
    "stop" { Invoke-CmdStop -TaskNameValue $Name }
    "enable" { Invoke-CmdEnable -TaskNameValue $Name }
    "remove" { Invoke-CmdRemove -TaskNameValue $Name }
    "rm" { Invoke-CmdRemove -TaskNameValue $Name }
    "cleanup" { Invoke-CmdCleanup -RemoveLogs:($ExtraArg -eq "logs") }
    default { Invoke-CmdHelp }
}
