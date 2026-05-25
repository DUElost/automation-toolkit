# system_Task-Scheduler

macOS launchd 定时任务管理器。一个纯 bash 脚本，通过 `com.userscript.*` 命名空间管理 launchd plist。

## Architecture

```
taskmgr (CLI entry, ~300 lines bash)
  ├── cmd_list()      — 列出任务（状态/调度/延时）
  ├── cmd_status()    — 单任务详情
  ├── cmd_log()       — 查看日志
  ├── cmd_add()       — 交互式创建（命令 + 可选通知）
  ├── cmd_edit()      — 编辑脚本或修改命令
  ├── cmd_start()     — 立即触发（launchctl start）
  ├── cmd_delay()     — N 分钟后延时触发（后台 sleep + launchctl start）
  ├── cmd_cancel()    — 取消延时
  ├── cmd_stop()      — 停用调度（launchctl unload）
  ├── cmd_enable()    — 启用调度（launchctl load）
  └── cmd_remove()    — 删除任务

_notify_action.sh      — 通知点击处理：生成 .command 文件，open -a Terminal
example/dailytask.py   — 示例 Python 任务脚本
```

## Design Decisions

- **launchd over cron**: launchd 支持唤醒后补执行，是 macOS 原生方案
- **com.userscript 前缀**: 统一命名空间，便于批量识别托管任务
- **terminal-notifier over osascript**: osascript 在 launchd 环境无法连接窗口服务器
- **Wrapper Script Pattern**: 非通知任务直接执行命令；通知任务包壳为 bash 脚本，执行后调 terminal-notifier
- **Delay via background sleep**: 不在 plist 中添加一次性 StartInterval，避免重复调度

## File Layout

| 路径 | 说明 |
|------|------|
| `$TASKMGR_HOME/<name>.py` | Python 任务脚本 (taskmgr add 自动生成) |
| `$TASKMGR_HOME/<name>.sh` | 通知包装脚本 |
| `$TASKMGR_HOME/<name>.log` | stdout 日志 |
| `$TASKMGR_HOME/<name>.err` | stderr 日志 |
| `$LAUNCH_DIR/com.userscript.<name>.plist` | launchd 调度配置 |
| `$TASKMGR_RUNTIME/<name>.pid` | 延时任务 PID + 截止时间 |

## Configuration

环境变量（均有合理默认值）：

| 变量 | 默认值 | 说明 |
|------|--------|------|
| `TASKMGR_HOME` | `~/scripts` | 任务脚本和日志存储目录 |
| `TASKMGR_RUNTIME` | `~/.taskmgr_delays` | 延时 PID 存储 |
| `TERMINAL_NOTIFIER` | 自动检测 | terminal-notifier 路径 |

## Dependencies

- macOS (launchd)
- `terminal-notifier` (`brew install terminal-notifier`)
- Python 3 (仅示例任务需要，taskmgr 本身不依赖)

## Changelog

- 2026-05-24: Initial version — list, add, edit, remove, start, stop, enable, delay, cancel, log, status
