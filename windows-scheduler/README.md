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

`DailyAt` 支持一次传入**多个时间点**（在同一个计划任务里生成多个每日触发器）：

```powershell
# 每天 09:00 / 14:00 / 19:00 各执行一次（单任务、单日志、共享互斥锁）
.\windows-scheduler\Register-ScheduledTool.ps1 `
  -TaskName "silence-android" `
  -FilePath ".\python-tools\stability_Start-Log-Scan\start_log_scan.py" `
  -WorkDir ".\python-tools\stability_Start-Log-Scan" `
  -DailyAt @("09:00", "14:00", "19:00") `
  -ReminderMinutes 0 `
  -ReplaceExisting
```

交互式创建同样支持多时间点，`Hour` 一栏直接填逗号分隔即可（如 `9,14,19`），也支持 `09:00,14:30` 这种带分钟的写法：

```powershell
taskmgr add silence-android
# 调度方式 [1=每天, ...] [1]:
# Hour   (0-23, 多点用逗号分隔如 9,14,19) [9]: 9,14,19
# Minute (0-59) [0]:
```

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

## 在 WSL 中定时执行

Windows 任务计划程序无法直接调度 WSL 内的命令，需要把 `FilePath` 指向 `wsl.exe`，由它进入 WSL 执行：

```powershell
.\windows-scheduler\Register-ScheduledTool.ps1 `
  -TaskName "silence-android" `
  -FilePath "C:\WINDOWS\system32\wsl.exe" `
  -Arguments '-d Ubuntu-22.04 -u rin --cd /mnt/c/Users/dai.lv/Desktop/Stability -e bash -lc "ANSIBLE_CONFIG=./ansible.cfg ANSIBLE_SSH_EXTRA_ARGS=''-o UserKnownHostsFile=/dev/null'' ansible-playbook -i inventory.ini silence_android.yml; rc=$?; pkill -f ''ssh: .*ansible/c[p]'' >/dev/null 2>&1; exit $rc"' `
  -WorkDir "C:\Users\dai.lv\Desktop\Stability" `
  -DailyAt @("09:00", "14:00", "19:00") `
  -ReminderMinutes 0 `
  -ReplaceExisting
```

WSL 场景的关键点：

- **必须用登录 shell**：`pip install --user` 装的 `ansible-playbook` 位于 `~/.local/bin`，只有 `bash -lc`（或 `--shell-type login`）才会把它加进 `PATH`，`bash -c` 找不到。
- **`ANSIBLE_CONFIG` 要显式指定**：`/mnt/c/...` 是世界可写目录，Ansible 会忽略同目录的 `ansible.cfg`（`host_key_checking = False` 失效），无人值守时首次连接新设备会因缺 `known_hosts` 直接失败。
- **`UserKnownHostsFile=/dev/null` 才真绕过主机密钥**：`host_key_checking = False` 只让 Ansible 加 `-o StrictHostKeyChecking=no`，对**新**主机有效；设备重刷后密钥变化仍会 `REMOTE HOST IDENTIFICATION HAS CHANGED` → `UNREACHABLE`（实测 30 台中 3 台）。加上该参数后 unreachable 归零。
- **SSH 多路复用会拖住退出**：`ansible.cfg` 里的 `ControlPersist=30m` 会让 mux 主进程继承 stdout/stderr 句柄并存活 30 分钟，导致 `wsl.exe` 迟迟不结束、计划任务一直停在 Running 并占着互斥锁。上面在 playbook 之后补了一句 `pkill` 清理 master，实测整轮从 25 分钟缩到 66 秒。
- **`pkill` 模式要用 `[p]` 写法**：`'ssh: .*ansible/c[p]'` 而不是 `'ssh: .*ansible/cp'`。后者会匹配到自身命令行（`bash -lc` 里原样包含该串），把父 shell 一起杀掉、丢掉真实退出码；字符类写法只匹配真实进程标题。

### wsl.exe 的几种调用形态（实测对照）

`-e`（`--exec`）的语义是**跳过 wsl 的默认 shell，直接把 argv 交给 execve**，因此没有任何东西再帮你分词。它和「用不用登录 shell」是两个正交维度：

| 写法 | Linux 侧谁解析 | 结果 |
|------|----------------|------|
| `wsl -e "ansible-playbook --version"` | 无 shell，整串=argv[0] | ❌ `execvpe(ansible-playbook --version) failed: No such file or directory` |
| `wsl -e ansible-playbook --version` | 无 shell，直接 exec | ❌ `execvpe(ansible-playbook) failed`（PATH 无 `~/.local/bin`） |
| `wsl ansible-playbook --version` | 默认 shell，非登录（`/bin/bash -c`） | ❌ `command not found`（同 PATH 问题） |
| `wsl --shell-type login ansible-playbook --version` | 默认 shell，登录 | ✅ `[core 2.17.14]` |
| `wsl -e bash -lc "ansible-playbook --version"` | 显式点名登录 bash | ✅ `[core 2.17.14]` ← **本模块采用** |

为什么 `-e` 会找不到 `ansible-playbook`：它实际装在 `/home/rin/.local/bin/`（`pip install --user`），该目录由 `~/.profile:25-26` **仅在登录时**追加到 PATH：

```text
wsl -e <cmd>  /  wsl -e bash -c   →  PATH 前两位 = /usr/local/sbin:/usr/local/bin     （无 .local/bin）
wsl -e bash -lc                   →  PATH 前两位 = /home/rin/.local/bin:/usr/local/sbin
```

> 迷惑点：Windows 侧的 `C:\Users\dai.lv\.local\bin` 会以 `/mnt/c/Users/dai.lv/.local/bin` 混在 PATH 里，看着「像是有」，但那不是 Linux 侧的 `~/.local/bin`。

为什么选 `bash -lc` 而不是更短的 `--shell-type login`：两者都能解析到 ansible，但无人值守还需要 **shell 语法**——`ANSIBLE_CONFIG=` / `ANSIBLE_SSH_EXTRA_ARGS=` 前缀赋值、`rc=$?`、`;` 串联、`pkill` 的引号，都得有明确的 bash 来解析；且显式点名 `bash` 不依赖 `/etc/passwd` 里默认 shell 的设置。

若坚持 `-e` 风格，最小可用形态是「绝对路径二进制 + 参数分开」（实测 `--syntax-check` 通过）：

```powershell
wsl.exe -e /home/rin/.local/bin/ansible-playbook -i /mnt/c/.../inventory.ini /mnt/c/.../silence_android.yml
```

但有两个硬伤：① `-e` 下 `ANSIBLE_CONFIG=xxx` 会被当成程序名去 exec（实测 `execvpe(ANSIBLE_CONFIG=/mnt/.../ansible.cfg) failed`）；② 没有 shell 就无法做 mux 清理，`ControlPersist=30m` 会让任务重新卡回约 25 分钟。

### 注册的 Arguments 逐段拆解

```text
-d Ubuntu-22.04          进哪个发行版（不写则用系统默认）
-u rin                   等价于手动时的 rin@GDZ0711852
--cd /mnt/c/.../Stability 等价于手动的 cd（Windows 侧 WorkingDirectory 再兜一层）
-e                       不让 wsl 跑默认 shell，下面就是我点名的程序
bash -lc "<脚本>"         登录 shell：补 PATH + 解析 ; 与 $? 与 VAR= 赋值
  ├ ANSIBLE_CONFIG=./ansible.cfg               对抗 /mnt/c 世界可写导致的 cfg 被忽略
  ├ ANSIBLE_SSH_EXTRA_ARGS='-o UserKnownHostsFile=/dev/null'  绕过设备重刷后的 host key 冲突
  ├ ansible-playbook -i inventory.ini silence_android.yml
  └ rc=$?; pkill -f 'ssh: .*ansible/c[p]' >/dev/null 2>&1; exit $rc   清 mux + 保留真实退出码
```

注意 PowerShell 单引号字符串内的 `''` 是**转义后的单个单引号**，落到 bash 里才是真正的 `'...'`；整段脚本用双引号包裹，供 `wsl -e bash -lc` 当作一个 argv 传入。

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
- 计划任务以 `LogonType Interactive` 注册，到点执行需要当前用户处于已登录状态（锁屏可以，注销不行）；机器睡眠时靠 `StartWhenAvailable` 唤醒后补跑
- 对每日任务，如果提醒时间跨到前一天，例如 `00:05` 执行且提前 `10` 分钟提醒，则提醒会在前一天 `23:55` 触发
- Python 工具若依赖虚拟环境，建议把 `FilePath` 指向虚拟环境里的 `python.exe`，并把脚本放进 `Arguments`
- 含中文的 `.ps1` 必须存成 **UTF-8 with BOM**：`taskmgr.bat` 走 Windows PowerShell 5.1，在 GBK(936) 代码页下会把无 BOM 的 UTF-8 中文按 ANSI 解码，导致整个脚本连解析都过不了。用编辑工具改 `taskmgr.ps1` 后要确认 BOM 仍在（部分工具重写文件会剥离 BOM，一剥就整文件报语法错），可用 `git diff` 检查：首行不该出现在改动里。
- `FilePath` 必须指向本机已存在的文件（`Resolve-Path` 校验），调用 WSL 时用 `C:\WINDOWS\system32\wsl.exe` 而不是裸 `wsl`

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
