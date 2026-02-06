# Automation Toolkit

自动化测试工具集 - 统一管理各类测试工具和小脚本

## 项目结构

```
automation-toolkit/
├── python-tools/          # Python 工具集
│   ├── performance_SMT_ResultFiller/    # SMT 性能测试结果填充
│   ├── performance_Top300_ResultFiller/  # Top300 应用启动时间数据填充
│   ├── system_MemoryFusion/             # 内存融合工具
│   └── universal_Factory-Reset/         # 通用恢复出厂设置工具
├── android-tools/         # Android 工具集（规划中）
├── java-platforms/        # Java 平台（规划中）
├── node-scripts/          # Node.js 脚本（规划中）
├── shared/                # 共享资源
└── docs/                  # 统一文档（规划中）
```

## 工具索引

### Python 工具

| 工具名称 | 说明 | 路径 |
|---------|------|------|
| Performance SMT Result Filler | SMT 性能测试结果自动填充 Excel（动效丢帧/滑动丢帧） | [python-tools/performance_SMT_ResultFiller/](python-tools/performance_SMT_ResultFiller/) |
| Performance Top300 Result Filler | Top300 应用启动时间数据自动填充 Excel | [python-tools/performance_Top300_ResultFiller/](python-tools/performance_Top300_ResultFiller/) |
| MemoryFusion | 内存融合工具 | [python-tools/system_MemoryFusion/](python-tools/system_MemoryFusion/) |
| Factory Reset | 通用恢复出厂设置工具 | [python-tools/universal_Factory-Reset/](python-tools/universal_Factory-Reset/) |

## 快速开始

### Windows

```powershell
# 进入工具目录
cd python-tools\performance_SMT_ResultFiller
# 或
cd python-tools\performance_Top300_ResultFiller

# 安装依赖
pip install -r requirements.txt

# 运行工具
python main.py
# 或双击 Start.bat
```

### Linux/Mac

```bash
# 进入工具目录
cd python-tools/performance_SMT_ResultFiller
# 或
cd python-tools/performance_Top300_ResultFiller

# 安装依赖
pip install -r requirements.txt

# 运行工具
python main.py
```

## 环境要求

- **Python**: 3.8+
- **依赖管理**: pip

## 版本

v0.1.0 | 更新时间：2026-02-06

## 许可证

Internal Use - Tinno Auto
