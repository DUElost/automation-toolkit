# Windows 定时提醒与执行

这个目录提供一个通用的 Windows 定时调度能力，用于在指定时间先提醒、再自动执行仓库里的工具脚本。

## 推荐入口：taskmgr（与 macOS 对齐）

在仓库根目录直接使用（无需记长路径）：

```powershell
cd D:\Tinno_auto\automation-toolkit
taskmgr add mytask
taskmgr list
taskmgr start mytask
taskmgr delay mytask 5
taskmgr log mytask
```

也可进入本目录后运行 `taskmgr.bat`，效果相同。

### 交互式新建（与 macOS 一致）

```powershell
taskmgr add mytask
# 调度方式 [1=每天, 2=指定时间一次, 3=N分钟后一次, 4=每N小时] [1]:  ← 直接回车 = 每天
# Hour   (0-23) [9]:
# Minute (0-59) [0]:
# 启动命令: python .\python-tools\performance_SMT_ResultFiller\main.py
# 执行前提前提醒? [Y/n]:
# 提前提醒分钟数 [10]:
```

任务名也可在交互中输入：

```powershell
taskmgr add
# 任务名称 (Task name): mytask
# ...
```

| 命令 | 说明 |
|------|------|
| `taskmgr list` | 列出所有任务及其状态 |
| `taskmgr status [name]` | 查看任务详情 |
| `taskmgr log <name>` | 查看最近 30 行日志 |
| `taskmgr add [name]` | 交互式创建（每日 / 一次性 / N 分钟后） |
| `taskmgr edit <name>` | 修改任务命令 |
| `taskmgr start <name>` | 立即触发一次 |
| `taskmgr delay <name> <m>` | N 分钟后延时触发 |
| `taskmgr cancel <name>` | 取消待执行的延时 |
| `taskmgr stop <name>` | 暂停定时调度 |
| `taskmgr enable <name>` | 恢复定时调度 |
| `taskmgr remove <name>` | 删除任务 |
| `taskmgr cleanup [logs]` | 清理孤儿 JSON 配置 |

与 macOS 的差异：

- Windows 为**执行前提醒**（Toast / `msg.exe`），macOS 为**执行后通知**
- Windows `add` 额外支持「指定时间一次」和「N 分钟后一次」（macOS 用 `delay` 实现类似效果）

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

## 高级用法（脚本注册）

需要 `-WakeToRun` 或在 CI 中注册时，仍可使用底层脚本：

```powershell
.\windows-scheduler\Register-ScheduledTool.ps1 `
  -TaskName "日志扫描" `
  -FilePath ".\python-tools\stability_Start-Log-Scan\start_log_scan.py" `
  -WorkDir ".\python-tools\stability_Start-Log-Scan" `
  -DailyAt "09:30" `
  -ReminderMinutes 10 `
  -ReplaceExisting
```

参数说明：`TaskName`、`FilePath`、`Arguments`、`WorkDir`、`DailyAt`、`RunAt`、`EveryHours`、`ReminderMinutes`、`WakeToRun`、`ReplaceExisting`。`DailyAt`、`RunAt`、`EveryHours` 三选一。

```powershell
# 每 3 小时执行
.\windows-scheduler\Register-ScheduledTool.ps1 `
  -TaskName "周期巡检" `
  -FilePath ".\python-tools\stability_Start-Log-Scan\start_log_scan.py" `
  -WorkDir ".\python-tools\stability_Start-Log-Scan" `
  -EveryHours 3 `
  -ReminderMinutes 10 `
  -ReplaceExisting
```

## 查看结果

运行日志位于：

```text
windows-scheduler/logs/<任务名规范化后的键>/
```

## 删除任务

```powershell
taskmgr remove 日志扫描
```

## 注意事项

- 提醒依赖桌面会话，若任务在无人登录场景下运行，提醒可能降级为 `msg.exe` 或日志记录
- 对每日任务，如果提醒时间跨到前一天，例如 `00:05` 执行且提前 `10` 分钟提醒，则提醒会在前一天 `23:55` 触发
- Python 工具若依赖虚拟环境，建议把 `FilePath` 指向虚拟环境里的 `python.exe`，并把脚本放进 `Arguments`

## 真实环境实验：定时打印当前时间

```powershell
cd D:\Tinno_auto\automation-toolkit
taskmgr add time-print-test
# 调度方式: 3          ← N 分钟后一次
# 多少分钟后执行: 2
# 启动命令: python .\windows-scheduler\examples\print_current_time.py
# 执行前提前提醒? Y
# 提前提醒分钟数: 1

taskmgr status time-print-test
# 等待约 2 分钟后
taskmgr log time-print-test
taskmgr remove time-print-test
```

实验脚本：`examples/print_current_time.py`
