# system_Task-Scheduler (Linux)

systemd 用户定时器封装，CLI 与 macOS `taskmgr` 对齐。

## Architecture

```
taskmgr (bash CLI)
  ├── cmd_list/status/log     — 读取 tasks/*.meta + systemctl --user
  ├── cmd_add/edit/remove     — 写 meta + 生成 .service/.timer
  ├── cmd_start/delay/cancel  — systemctl start / 后台 sleep
  ├── cmd_stop/enable         — disable/enable timer
  └── cmd_cleanup             — 删除无 timer 的孤儿 meta

_run_task.sh                  — systemd ExecStart：执行命令、写日志、notify-send
_notify_action.sh             — 可选：打开终端查看日志
example/                      — print_current_time.py、dailytask.py
```

## Design Decisions

- **systemd user timer over cron**：支持 `Persistent=true` 补跑、与桌面会话集成更好
- **automation-toolkit- 前缀**：统一单元命名空间，避免与系统服务冲突
- **tasks/*.meta**：bash `source` 可读的配置，避免 jq 依赖
- **Delay via background sleep**：与 macOS 相同，不污染 timer 单元

## Dependencies

- Linux + systemd
- bash
- 可选 libnotify (`notify-send`)

## Changelog

- 2026-05-26: Initial Linux port — list, add, edit, remove, start, stop, enable, delay, cancel, log, status, cleanup
