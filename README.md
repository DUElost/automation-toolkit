# Automation Toolkit

自动化测试工具集 - 统一管理各类测试工具和小脚本

## 项目结构

```
automation-toolkit/
├── python-tools/          # Python 工具集
├── android-tools/         # Android 工具集
├── java-platforms/        # Java 平台
├── node-scripts/          # Node.js 脚本
├── shared/                # 共享资源
└── docs/                  # 统一文档
```

## 工具索引

### Python 工具

| 工具名称 | 说明 | 路径 |
|---------|------|------|
| Performance Excel Filler | SMT 性能测试结果自动填充 Excel | [python-tools/performance-excel-filler/](python-tools/performance-excel-filler/) |

## 快速开始

### Windows

```powershell
# 克隆仓库
git clone <repository-url>
cd automation-toolkit

# 查看帮助
.\toolkit.ps1 help
# 或
.\toolkit.bat help

# 安装依赖
.\toolkit.ps1 install-python

# 运行工具
.\toolkit.ps1 run-perf-filler
```

### Linux/Mac

```bash
# 克隆仓库
git clone <repository-url>
cd automation-toolkit

# 查看帮助
make help

# 安装依赖
make install-python

# 运行工具
make run-perf-filler
```

## 版本

v0.1.0

## 许可证

Internal Use - Tinno Auto
