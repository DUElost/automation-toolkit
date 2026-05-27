# system_Task-Scheduler (Linux)

Linux systemd 用户定时任务管理器，与 macOS `macos-tools/system_Task-Scheduler/taskmgr` 命令对齐。

## 依赖

- systemd（支持 `systemctl --user`）
- bash
- 可选：`libnotify-bin`（`notify-send`，用于执行后桌面通知）

```bash
# Debian/Ubuntu
sudo apt install libnotify-bin

# Fedora
sudo dnf install libnotify
```

## 安装

```bash
# 添加到 PATH
export PATH="$PATH:/path/to/automation-toolkit/linux-tools/system_Task-Scheduler"

# 确保用户级 systemd 可用（多数桌面环境默认已启用）
systemctl --user status
```

若希望**未登录时也运行**定时任务，可启用 lingering（需 root）：

```bash
sudo loginctl enable-linger "$USER"
```

## 快速开始

```bash
# 交互式创建每天 9:00 执行的任务
taskmgr add mytask
# 调度方式 [1=每天, 2=指定时间一次, 3=N分钟后一次] [1]:
# Hour   (0-23) [9]:
# Minute (0-59) [0]:
# 启动命令: python3 ~/my_script.py
# 执行后发送桌面通知? [Y/n]: y

taskmgr list
taskmgr start mytask
taskmgr delay mytask 5
taskmgr log mytask
```

## 全部命令

| 命令 | 说明 |
|------|------|
| `taskmgr list` | 列出所有任务及其状态 |
| `taskmgr status [name]` | 查看任务详情 |
| `taskmgr log <name>` | 查看最近 30 行日志 |
| `taskmgr add [name]` | 交互式创建新任务 |
| `taskmgr edit <name>` | 修改任务命令 |
| `taskmgr start <name>` | 立即触发一次 |
| `taskmgr delay <name> <m>` | N 分钟后延时触发 |
| `taskmgr cancel <name>` | 取消待执行的延时 |
| `taskmgr stop <name>` | 暂停定时调度 |
| `taskmgr enable <name>` | 恢复定时调度 |
| `taskmgr remove <name>` | 删除任务 |
| `taskmgr cleanup [logs]` | 清理无 systemd 单元的孤儿配置 |

## 调度方式（add 交互）

| 选项 | 说明 |
|------|------|
| `1` 每天 | 与 macOS 相同，按 Hour/Minute |
| `2` 指定时间一次 | 输入 `yyyy-MM-dd HH:mm:ss` |
| `3` N 分钟后一次 | 输入分钟数 |

## 支持的命令

任意 shell 命令：`python3 ~/a.py`、`node ~/b.js`、`bash ~/c.sh` 等。

日志默认写入 `~/scripts/<任务名>.log`（可用 `TASKMGR_HOME` 修改）。

## 真实环境实验

```bash
cd /path/to/automation-toolkit/linux-tools/system_Task-Scheduler

taskmgr add time-print-test
# 选 3 → 2 分钟后
# 启动命令: python3 ./example/print_current_time.py

taskmgr status time-print-test
# 等待约 2 分钟
taskmgr log time-print-test
taskmgr remove time-print-test
```

### WSL 一键冒烟测试

在 Windows WSL2（已启用 systemd）下可运行：

```bash
bash /mnt/d/Tinno_auto/automation-toolkit/linux-tools/system_Task-Scheduler/scripts/wsl-smoke-test.sh
```

通过后会输出 `SMOKE_OK`，并验证 `taskmgr add` → `start` → 日志含 `[scheduled] current time:` → `remove` 全流程。

## 环境变量

| 变量 | 默认值 | 说明 |
|------|--------|------|
| `TASKMGR_HOME` | `~/scripts` | 任务日志目录 |
| `TASKMGR_RUNTIME` | `~/.taskmgr_delays` | 延时 PID 存储 |
| `XDG_CONFIG_HOME` | `~/.config` | systemd 用户单元目录 |

## 与 macOS / Windows 的差异

| 平台 | 调度后端 | 通知 |
|------|----------|------|
| macOS | launchd | terminal-notifier（执行后） |
| Linux | systemd user timer | notify-send（执行后，可选） |
| Windows | 任务计划程序 | Toast（执行前提醒） |

## 文件布局

| 路径 | 说明 |
|------|------|
| `tasks/<name>.meta` | 任务元数据（本地，已 gitignore） |
| `~/.config/systemd/user/automation-toolkit-*.timer` | systemd 定时器 |
| `~/.config/systemd/user/automation-toolkit-*.service` | systemd 服务 |
| `$TASKMGR_HOME/<name>.log` | 标准输出日志 |
| `$TASKMGR_HOME/<name>.err` | 标准错误日志 |
