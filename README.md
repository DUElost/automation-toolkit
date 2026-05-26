# Automation Toolkit

自动化测试工具集 — 统一管理各类测试工具和小脚本

## 项目结构

```
automation-toolkit/
├── python-tools/                          # Python 工具集
│   ├── performance_SMT_ResultFiller/      # SMT 性能测试结果填充
│   ├── performance_Top300_ResultFiller/   # Top300 应用启动时间数据填充
│   ├── stability_Jira-Automation/        # Jira 自动化
│   ├── stability_Start-Log-Scan/         # 稳定性日志扫描分析
│   ├── stability_PlayStore-Update-Extract/ # Play 商店更新提取
│   ├── stability_FTPserver-Check/        # FTP 服务器日志检查
│   ├── stability_Reboot-Sleep-Reset/     # 重启/睡眠/重置稳定性测试
│   ├── system_MemoryFusion/              # 内存融合工具
│   ├── universal_Automation-Create-Task/  # ITMS 批量创建测试任务
│   ├── universal_Auto-Create-TestReport/ # 自动生成测试报告
│   └── universal_Factory-Reset/          # 通用恢复出厂设置
├── macos-tools/                           # macOS 专属工具
│   └── system_Task-Scheduler/            # launchd 定时任务管理器
├── windows-scheduler/                     # Windows 定时任务管理器
├── android-tools/                         # Android 工具集（规划中）
├── java-platforms/                        # Java 平台（规划中）
├── node-scripts/                          # Node.js 脚本（规划中）
└── shared/                                # 共享资源
    └── python-utils/                      # 共享 Python 工具库
```

## 工具索引

### Python 工具

| 工具名称 | 说明 |
|---------|------|
| [performance_SMT_ResultFiller](python-tools/performance_SMT_ResultFiller/) | SMT 性能测试结果自动填充 Excel |
| [performance_Top300_ResultFiller](python-tools/performance_Top300_ResultFiller/) | Top300 应用启动时间数据填充 |
| [stability_Jira-Automation](python-tools/stability_Jira-Automation/) | Jira 自动化工具 |
| [stability_Start-Log-Scan](python-tools/stability_Start-Log-Scan/) | 稳定性日志扫描分析 |
| [stability_PlayStore-Update-Extract](python-tools/stability_PlayStore-Update-Extract/) | Google Play 应用更新提取 |
| [stability_FTPserver-Check](python-tools/stability_FTPserver-Check/) | FTP 日志检查 |
| [stability_Reboot-Sleep-Reset](python-tools/stability_Reboot-Sleep-Reset/) | 重启/睡眠/重置测试 |
| [system_MemoryFusion](python-tools/system_MemoryFusion/) | 内存融合工具 |
| [universal_Automation-Create-Task](python-tools/universal_Automation-Create-Task/) | ITMS 批量创建测试任务 |
| [universal_Auto-Create-TestReport](python-tools/universal_Auto-Create-TestReport/) | 自动生成测试报告 |
| [universal_Factory-Reset](python-tools/universal_Factory-Reset/) | 通用恢复出厂设置 |

### macOS 工具

| 工具名称 | 说明 |
|---------|------|
| [system_Task-Scheduler](macos-tools/system_Task-Scheduler/) | launchd 定时任务管理器 |

### Windows 工具

| 工具名称 | 说明 |
|---------|------|
| [windows-scheduler](windows-scheduler/) | 任务计划程序定时任务管理器 |

## 快速开始

### macOS 定时任务

```bash
# 添加到 PATH
export PATH="$PATH:/path/to/automation-toolkit/macos-tools/system_Task-Scheduler"

# 安装依赖
brew install terminal-notifier

# 创建任务
taskmgr add mytask
```

### Windows 定时任务

```powershell
cd D:\Tinno_auto\automation-toolkit

# 交互式创建（与 macOS 相同用法）
taskmgr add mytask
taskmgr list
taskmgr start mytask
```

### Windows Python 工具

```powershell
cd python-tools\performance_SMT_ResultFiller
pip install -r requirements.txt
python main.py
```

### Linux/Mac

```bash
cd python-tools/performance_SMT_ResultFiller
pip install -r requirements.txt
python main.py
```

## 环境要求

- **Python**: 3.8+
- **macOS 工具**: terminal-notifier (`brew install terminal-notifier`)

## 版本

v0.2.0 | 更新时间：2026-05-25

## 许可证

Internal Use - Tinno Auto
