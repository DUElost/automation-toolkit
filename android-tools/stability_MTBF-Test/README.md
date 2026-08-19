# stability_MTBF-Test

MTBF 离线老化测试**执行包**（仅含运行所需 APK、XML 与部署脚本，不含 apktool 源码工程）。

完整 APK 自编译与修改请使用 [apps/OfflineScriptManager](../apps/OfflineScriptManager/)。

## 目录结构

```
stability_MTBF-Test/
├── apk/                              # 安装包
│   ├── OfflineScriptManager.apk      # 离线调度器（需 platform 签名 / system uid）
│   ├── ReliabilityUiautomatorTest.apk
│   └── ReliabilityUiautomatorTestTest.apk
├── config/                           # 设备端配置
│   ├── runtask.xml                   # 离线任务（约 130 个 testpoint）
│   ├── UiAutomatorTestData.xml       # WiFi / 账号等全局参数
│   └── uiautomatorconfig             # 占位符配置（参考用）
├── scripts/
│   ├── deploy.bat / deploy.ps1       # 安装 APK + 推送配置
│   ├── run.bat / run.ps1             # 启动离线任务（已部署前提下）
│   └── stop.bat / stop.ps1           # 停止任务并关闭自动续跑
├── test-config.properties            # 循环次数、测试员、是否自动开跑
└── README.md
```

## 前置条件

| 项目 | 要求 |
|------|------|
| PC | `adb` 在 PATH，建议 `adb root` 可用 |
| 设备 | 工程机 / 已授权 adb；TINNO platform 签名匹配 |
| OfflineScriptManager | 必须为 **system uid** 版（本包内 APK 已满足） |
| 网络 / 账号 | 按实机修改 `config/UiAutomatorTestData.xml` 中 WiFi 等 |

> **注意：** `runtask.xml` 不含 `proviouspoint` 前置步骤。首次换机需确保测试资源（第三方 App、音频等）已按 MTBF 平台在线任务要求提前部署。

## 快速开始

### 1. 编辑配置（首次必做）

**`test-config.properties`**

```properties
task.times=1          # 整套循环次数（试跑建议 1，正式老化可改 1000）
tester.name=tester
auto.start=false      # deploy 后是否自动开跑
```

**`config/UiAutomatorTestData.xml`** — 修改 WiFi、账号等为实机环境。

### 2. 一键部署（7 天连续老化）

```bat
cd F:\automation-toolkit\android-tools\stability_MTBF-Test\scripts
deploy.bat
```

默认 `test-config.properties` 已按 **7 天连续运行** 配置：

| 配置项 | 默认值 | 说明 |
|--------|--------|------|
| `task.times` | `100` | 整套循环次数（单轮约 6~8h，100 轮可覆盖 7 天有余） |
| `auto.start` | `true` | 部署后自动开跑 |
| `auto.resume` | `true` | 开机恢复 + 30 分钟看门狗自动拉起 `RunTaskService` |

**部署后请保持设备插电**，然后可拔掉 USB，设备自主执行。

等价于：

1. 安装 3 个 APK（含带看门狗的 OfflineScriptManager）
2. push `runtask.xml`、`UiAutomatorTestData.xml` → `/sdcard/`
3. 设置屏幕常亮、禁用锁屏、写入自动续跑 prefs
4. 校验 `sharedUser=android.uid.system` 并启动任务

带参数示例：

```bat
deploy.bat -TaskTimes 100 -Tester "Rin"
deploy.bat -TaskTimes 0          rem 使用 config/runtask.xml 原始 times（默认 1000）
```

### 3. 启动测试

若 `auto.start=false`，部署后执行：

```bat
run.bat
run.bat -TaskTimes 1 -Tester tester
run.bat -RedeployConfig    rem 重新 push 全部 config 后再启动
```

启动后可拔掉 USB，设备自主执行。

### 4. 停止任务

```bat
scripts\stop.bat
scripts\stop.bat -Force    rem 优雅停止失败时强制杀进程
```

等价于：

1. 将 `auto_resume` 设为 `false`（防止看门狗 30 分钟后再次拉起）
2. 发送 `RunTaskService.action.stop` 优雅停止
3. 必要时 `force-stop` OfflineScriptManager

手动命令（备用）：

```bat
adb shell am startservice -n com.ape.offlinescriptmanager/com.ape.offlinescriptmanager.view.RunTaskService -a com.ape.offlinescriptmanager.view.RunTaskService.action.stop
```

## 结果与日志

| 路径 | 说明 |
|------|------|
| `/sdcard/results/realresult/` | 用例 Pass/Fail 汇总 XML |
| `/sdcard/results/Log/` | 运行日志 |
| `/sdcard/results/record_data/` | 电量等采集数据 |

拉取结果：

```bat
adb pull /sdcard/results ./results
```

## 验证是否在真实执行

```bat
adb shell dumpsys package com.ape.offlinescriptmanager | findstr sharedUser
adb logcat -s TestRunner
```

- `sharedUser` 应为 `android.uid.system/1000`  
- 单条用例耗时应为 **数十秒**，不是几百毫秒  
- logcat 应出现 `TestRunner: started/finished`，无 `Permission Denial`

## 更新 APK

| 文件 | 更新方式 |
|------|----------|
| `OfflineScriptManager.apk` | 在 `apps/OfflineScriptManager` 执行 `build-offline-apk.bat`，复制产物到本目录 `apk/` |
| 测试 APK | 从 MTBF 平台 `data/jar/` 或新版本用例包替换 `apk/` 下两个 Reliability*.apk |
| `runtask.xml` | 从平台任务 XML 转换，或从 `apps/OfflineScriptManager` 同步 |

## 与 apps/OfflineScriptManager 的分工

| | stability_MTBF-Test | apps/OfflineScriptManager |
|---|---|---|
| 用途 | **跑测试** | **改 APK / 重编译** |
| 体积 | 小（仅执行物） | 大（smali 工程 + 反编译源码） |
| 典型用户 | 测试工程师 | 开发 / 维护人员 |

## 常见问题

**Q: 安装 OfflineScriptManager 失败 `SHARED_USER_INCOMPATIBLE`?**  
A: APK 非 platform 签名。请用 `apps/OfflineScriptManager` 以 `sign.mode=platform` 重新构建后覆盖 `apk/OfflineScriptManager.apk`。

**Q: 界面一直 Pass 但每条不到 1 秒?**  
A: 未获得 system uid，instrument 权限不足。检查签名与 `dumpsys package` 的 `sharedUser`。

**Q: 如何改循环次数?**  
A: 改 `test-config.properties` 的 `task.times`，或 `deploy/run` 加 `-TaskTimes N`（会 patch `runtask.xml` 的 `<runtask times="...">`）。

**Q: Android 15/16 跑一夜后 OfflineScriptManager 进程消失?**  
A: 旧版 APK 若声明 `foregroundServiceType=dataSync`，会在 **24h 内累计运行 6h** 后被系统强杀。请用最新 `apps/OfflineScriptManager` 构建（已移除 dataSync + `onTimeout` 兜底 + `MtbfAutoResumeReceiver` 看门狗），覆盖 `apk/OfflineScriptManager.apk` 后 `deploy.bat`。

**Q: 如何连续跑 7 天?**  
A: 使用默认 `test-config.properties`（`task.times=100`、`auto.resume=true`），执行 `deploy.bat` 后插电并拔线即可。看门狗每 30 分钟检查 `RunTaskService`，异常退出会自动拉起；重启后 `BOOT_COMPLETED` 也会自动恢复。

**Q: 需要手点 App 吗?**  
A: 不需要。`run.bat` 会通过 adb 写 prefs 并启动 `RunTaskService`。
