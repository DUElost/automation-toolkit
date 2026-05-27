# system_Task-Scheduler

macOS launchd 定时任务管理器，一个文件，零配置，管理所有定时任务。

## 安装

```bash
# 1. 添加到 PATH
export PATH="$PATH:/path/to/automation-toolkit/macos-tools/system_Task-Scheduler"

# 2. 安装依赖
brew install terminal-notifier
```

## 快速开始

```bash
# 创建每天 9:00 执行的任务
taskmgr add mytask
# 调度方式 [1=每天, 4=每N小时] [1]:
# Hour   (0-23) [9]: 9
# Minute (0-59) [0]: 0
# 启动命令: python3 ~/my_script.py
# 执行后发送通知? [Y/n]: y

# 每 3 小时执行一次
taskmgr add hourly-task
# 调度方式: 4
# 间隔小时数 [3]: 3

# 查看所有任务
taskmgr list

# 立即触发一次
taskmgr start mytask

# 5 分钟后执行
taskmgr delay mytask 5
```

## 全部命令

| 命令 | 说明 |
|------|------|
| `taskmgr list` | 列出所有任务及其状态 |
| `taskmgr status [name]` | 查看任务详情 |
| `taskmgr log <name>` | 查看最近 30 行日志 |
| `taskmgr add <name>` | 交互式创建新任务 |
| `taskmgr edit <name>` | 编辑任务脚本或修改命令 |
| `taskmgr start <name>` | 立即触发一次 |
| `taskmgr delay <name> <m>` | N 分钟后延时触发 |
| `taskmgr cancel <name>` | 取消待执行的延时 |
| `taskmgr stop <name>` | 暂停定时调度 |
| `taskmgr enable <name>` | 恢复定时调度 |
| `taskmgr remove <name>` | 删除任务 |

## 支持的命令

任意可执行命令：`python3 ~/a.py`、`node ~/b.js`、`curl https://...`、`bash ~/c.sh` 等。

选择发送通知后，点击通知弹窗会自动打开终端显示日志。

## 环境变量

| 变量 | 默认值 | 说明 |
|------|--------|------|
| `TASKMGR_HOME` | `~/scripts` | 任务脚本/日志存储目录 |
| `TASKMGR_RUNTIME` | `~/.taskmgr_delays` | 运行时状态目录 |
| `TERMINAL_NOTIFIER` | 自动检测 | terminal-notifier 路径 |
