# Google Play 更新检测与 APK 提取工具

> 用于稳定性挂测场景：先在 1 台设备上通过 Google Play 更新所有应用，再提取变更的 APK 分发到其余 99 台样机。

## 原理

Google Play 在本地维护了 3 个 SQLite 数据库（需要 root 权限读取）：

| 数据库 | 表 | 作用 |
|--------|-----|------|
| `install_queue.db` | `install_requests` | 待更新队列，`reason=bulk_update` 即为 Play 计划更新的应用（**瞬态表**，Play 处理后清空） |
| `localappstate.db` | `appstate` | 每个应用的状态，含 `desired_version`、`update_discovered_version_code`（**持久表**，全量 Play 管理应用） |
| `auto_update.db` | `auto_update` | 每个应用的自动更新开关状态 |

`install_requests` 是瞬态表，Play Store 处理完批量更新后会清空。工具检测到队列不足 5 条时，自动回退到 `appstate` 表作为数据源（含所有 Play Store 管理的应用，通常 20-30 个）。

工具通过读取这些数据库 + 版本快照 diff 来精确获知哪些应用被更新了。

## 环境要求

- Python 3.8+
- ADB 已配置在 PATH 中
- 设备已 root（`adb root` 可用）
- 设备已安装 Google Play 服务

## 快速开始

```bash
# 1. 检查待更新应用（预知有哪些应用需要更新）
python playstore_update_extract.py check

# 2. 完整流程（推荐）：快照 → 用户手动更新 → diff → 提取 APK
python playstore_update_extract.py full-flow
```

## 命令详解

### check — 检查待更新应用

读取 Play Store 的 `install_queue.db` 和 `localappstate.db`，列出待更新 / Play 管理的应用。

```bash
python playstore_update_extract.py check                # 检查待更新 / Play 管理应用
python playstore_update_extract.py check --verbose      # 同时显示 auto_update 配置
python playstore_update_extract.py check --save pkgs.txt  # 保存包名列表，供后续 pull 使用
```

**注意**：`install_queue.db` 是瞬态表，Play Store 处理批量更新后会清空。工具在队列不足 5 条时自动回退到 `appstate` 表（持久表），读取所有 Play Store 管理的应用。建议先打开 Play Store 进入「我的应用」页面触发检查。

### snapshot — 创建版本快照

记录当前所有已安装包的包名和版本号。

```bash
python playstore_update_extract.py snapshot --label before_update
python playstore_update_extract.py snapshot --label after_update
```

### diff — 对比快照

对比两次快照，输出发生变更的应用及新旧版本号。

```bash
python playstore_update_extract.py diff snapshots/snapshot_before_*.json snapshots/snapshot_after_*.json
```

### extract — 提取 APK

根据 diff 结果，将变更应用的完整 APK 目录（含 split APK）提取到本地。

```bash
python playstore_update_extract.py extract diff_20260428_210000.json
python playstore_update_extract.py extract diff_20260428_210000.json --output ./my_apks
python playstore_update_extract.py extract diff_20260428_210000.json --dry-run  # 预览不实际提取
```

提取时会自动检测 Chrome/WebView 的 Trichrome Library 共享库依赖，并一并提取。

### pull — 直接按包名提取 APK（不依赖快照）

更新前保存包名列表，更新后直接按列表提取。支持自动补齐共享库依赖。

```bash
# 步骤 1: 更新前检测并保存包名
python playstore_update_extract.py check --save pkgs.txt

# 步骤 2: 在设备上通过 Google Play 手动「全部更新」

# 步骤 3: 更新后直接提取（自动检测 Trichrome Library 等共享库）
python playstore_update_extract.py pull --from-file pkgs.txt

# 也可直接指定包名
python playstore_update_extract.py pull com.android.chrome com.google.android.youtube

# 指定输出目录
python playstore_update_extract.py pull --from-file pkgs.txt --output ./my_apks

# 预览模式（不实际提取）
python playstore_update_extract.py pull --from-file pkgs.txt --dry-run
```

输出目录默认按设备型号自动命名，如 `extracted_apks_Infinix-X6851_Android16/`。可通过 `--output` 指定自定义目录。

### full-flow — 完整流程（推荐）

交互式引导完成全部步骤：

1. 检查设备连接与 root 权限
2. 读取 Play Store 待更新队列（含 `appstate` 回退）
3. 创建更新前版本快照
4. **提示用户在 Play Store 中手动执行「全部更新」**
5. 创建更新后快照 → 自动 diff → 自动提取 APK（含共享库依赖）

```bash
python playstore_update_extract.py full-flow
python playstore_update_extract.py full-flow --output ./my_apks
python playstore_update_extract.py full-flow --dry-run     # 跳过实际 APK 提取
```

输出目录默认按设备型号自动命名，如 `extracted_apks_Infinix-X6851_Android16/`。

## 输出目录结构

```
extracted_apks_Infinix-X6851_Android16/
├── device_info.json            # 提取源设备信息（型号/Android版本/提取时间）
├── com_android_chrome/
│   ├── base.apk
│   ├── split_chrome.apk
│   ├── split_config.zh.apk
│   └── metadata.json           # 包名/版本号/源路径
├── com_android_vending/
│   ├── base.apk
│   ├── split_config.arm64_v8a.apk
│   └── metadata.json
├── com_google_android_trichromelibrary/   # 共享库（自动检测提取）
│   ├── base.apk
│   └── metadata.json
└── ...
```

`metadata.json` 记录原始版本号，供 Ansible 安装后进行版本校验（确认安装是否实际生效）。

## 批量分发安装到所有样机

### 单设备安装（split APK 合集）

对于含多个 split APK 的应用，使用 `install-multiple`：

```bash
adb install-multiple -r -g extracted_apks/com_android_chrome/*.apk
```

| 参数 | 含义 |
|------|------|
| `-r` | 覆盖安装（replace） |
| `-g` | 授予所有运行时权限 |
| `-d` | 允许版本降级 |

### 多节点批量安装（Ansible）

通过 `ssh/` 目录下的 Ansible 配置，将 APK 分发到局域网内所有 Linux 主控节点，
并由每个节点在其连接的 Android 设备上自动执行安装。

**前置条件：**
- WSL 中已安装 `ansible`
- `ssh/inventory.ini` 中配置了所有目标 Linux 主机

**用法：**

```bash
# 在 WSL 中执行
cd ssh/

# 全量分发到所有节点
bash batch_install.sh ../extracted_apks

# 先在一台节点上验证
bash batch_install.sh ../extracted_apks --limit 172.21.10.36

# 限定多台
bash batch_install.sh ../extracted_apks --limit 172.21.15.1,172.21.15.2
```

**工作流程：**
1. 将 `extracted_apks/` 打包为 tar.gz，计算 SHA256
2. 通过 Ansible 并行推送至所有 Linux 主控节点（含完整性校验）
3. 每个节点根据 SHA256 判断是否需要更新（已同步则跳过）
4. 解压后遍历 USB 连接的 Android 设备
5. 对每个设备的每个应用执行 `adb install-multiple`（split APK 安装）
6. **版本校验**：对比安装前后版本号，输出 UPGRADED / ALREADY_SAME / FAIL / VANISHED 四类结果
7. 汇总报告每个主机的安装统计

## 注意事项

- 需要 root 权限读取 `/data/data/com.android.vending/databases/`
- 仅支持 Android 设备，测试通过的最低 SDK 版本为 26
- Play Store 数据库结构可能因版本不同有差异，如遇问题请反馈
- 某些系统应用（如 GMS、WebView）更新后可能需要重启设备才能生效
- **提取和安装必须在同型号设备上进行**（不同型号的 split APK 包含不同的 ABI/密度配置，无法交叉安装）

## 已知限制

### Chrome / Trichrome Library 依赖

Chrome（`com.android.chrome`）和 WebView 在 Android 10+ 上使用 **Trichrome** 共享库架构。Play Store 更新 Chrome 时会联动更新 `com.google.android.trichromelibrary`。

Trichrome Library 作为共享库安装，不注册为常规包（`pm path` 查不到）。工具已处理此情况：

- **提取侧**：自动检测 Chrome/WebView 依赖 → 先尝试 `pm path` → 失败后回退到 `/data/app/` 文件系统搜索。已验证可正常发现并提取。
- **安装侧**：Ansible playbook 将 Trichrome Library 排在安装队列最前面，确保其先于 Chrome 安装。

### 交叉安装

提取的 split APK 包含特定 ABI / 屏幕密度配置。**提取和安装必须在同型号设备上进行**，不同型号的设备会因 split 配置不匹配而导致 `INSTALL_FAILED_MISSING_SPLIT`。
