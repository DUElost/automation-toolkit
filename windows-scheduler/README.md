# Windows 定时提醒与执行

这个目录提供一个通用的 Windows 定时调度能力，用于在指定时间先提醒、再自动执行仓库里的工具脚本。

## 适用场景

- 定时执行 `Start.bat`
- 定时运行某个 `main.py`
- 定时执行 `toolkit.ps1` 或其他 PowerShell 脚本
- 执行前提前几分钟弹出提醒

## 设计说明

- 使用 Windows 原生任务计划程序，不依赖常驻后台进程
- 注册计划任务时生成本地 JSON 配置，避免复杂命令行转义
- 实际执行时自动识别 `.ps1` / `.bat` / `.cmd` / `.py` / `.exe`
- 默认加互斥锁，避免同一个任务重复并发执行
- 运行日志写入 `windows-scheduler/logs/`

## 前置条件

- Windows 10 / 11
- PowerShell 5.1 及以上
- 系统存在 `ScheduledTasks` 模块
- 若执行 Python 脚本，`python.exe` 需已加入 PATH
- 若需要桌面提醒，计划任务需在“用户已登录”场景下运行

## 快速使用

### 1. 每天定时提醒并执行

```powershell
.\windows-scheduler\Register-ScheduledTool.ps1 `
  -TaskName "日志扫描" `
  -FilePath ".\python-tools\stability_Start-Log-Scan\start_log_scan.py" `
  -WorkDir ".\python-tools\stability_Start-Log-Scan" `
  -DailyAt "09:30" `
  -ReminderMinutes 10 `
  -ReplaceExisting
```

效果：

- 每天 `09:20` 先提醒
- 每天 `09:30` 自动执行

### 2. 一次性执行

```powershell
.\windows-scheduler\Register-ScheduledTool.ps1 `
  -TaskName "今晚跑性能填表" `
  -FilePath ".\python-tools\performance_SMT_ResultFiller\main.py" `
  -WorkDir ".\python-tools\performance_SMT_ResultFiller" `
  -RunAt "2026-04-08 20:30:00" `
  -ReminderMinutes 5 `
  -ReplaceExisting
```

### 3. 执行批处理工具

```powershell
.\windows-scheduler\Register-ScheduledTool.ps1 `
  -TaskName "内存融合工具" `
  -FilePath ".\python-tools\system_MemoryFusion\Start.bat" `
  -WorkDir ".\python-tools\system_MemoryFusion" `
  -DailyAt "18:00" `
  -ReminderMinutes 15 `
  -ReplaceExisting
```

## 参数说明

- `TaskName`: 业务任务名称，用于生成计划任务名和日志目录
- `FilePath`: 要执行的目标文件，支持相对路径
- `Arguments`: 传给目标文件的参数字符串
- `WorkDir`: 工作目录，不传则默认使用目标文件所在目录
- `DailyAt`: 每日执行时间，格式 `HH:mm`
- `RunAt`: 一次性执行时间，格式如 `2026-04-08 20:30:00`
- `ReminderMinutes`: 提前提醒分钟数，传 `0` 表示不提醒
- `WakeToRun`: 允许系统唤醒后执行
- `ReplaceExisting`: 已存在同名任务时先覆盖

`DailyAt` 和 `RunAt` 只能二选一。

## 查看结果

注册成功后会输出：

- 实际生成的 Windows 计划任务名称
- 本地配置文件路径
- 日志目录路径

运行日志位于：

```text
windows-scheduler/logs/<任务名规范化后的键>/
```

## 删除任务

推荐直接使用仓库内置的反注册脚本：

```powershell
.\windows-scheduler\Unregister-ScheduledTool.ps1 `
  -TaskName "日志扫描" `
  -RemoveGeneratedFiles
```

如果你只想删掉 Windows 计划任务，保留配置和日志，不传 `-RemoveGeneratedFiles` 即可。

## 注意事项

- 提醒依赖桌面会话，若任务在无人登录场景下运行，提醒可能降级为 `msg.exe` 或日志记录
- 对每日任务，如果提醒时间跨到前一天，例如 `00:05` 执行且提前 `10` 分钟提醒，则提醒会在前一天 `23:55` 触发
- Python 工具若依赖虚拟环境，建议把 `FilePath` 指向虚拟环境里的 `python.exe`，并把脚本放进 `Arguments`
