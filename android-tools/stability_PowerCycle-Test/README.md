# stability_PowerCycle-Test

开关机 / 重启专项测试**执行包**（对齐 MTBF 的 deploy/run/stop 模式）。

APK 基于 [ATTS](D:\Tinno_auto\ATTS)（`com.tinno.autotesttool`）裁剪开发，源码维护见 [apps/PowerCycleManager](../apps/PowerCycleManager/)。

## 目录结构

```
stability_PowerCycle-Test/
├── apk/
│   └── AutoTestTool.apk          # platform 签名 / system uid
├── scripts/
│   ├── deploy.bat / deploy.ps1   # 安装 + 写 prefs + 可选自动开跑
│   ├── run.bat / run.ps1         # 更新配置并启动
│   └── stop.bat / stop.ps1       # 停止并关闭 auto_resume
├── test-config.properties        # 次数、模式、等待时间
└── README.md
```

## 前置条件

| 项目 | 要求 |
|------|------|
| PC | `adb` 在 PATH，建议 `adb root` 可用 |
| 设备 | 工程机 / TINNO platform 签名匹配 |
| APK | platform 签名；**system uid 推荐**（工程机 platform 签名非 system 也可能可 reboot） |
| 锁屏 | 建议关闭待机锁屏，否则弹窗/结果可能不可见 |

## 快速开始

### 1. 构建 APK（首次）

```bat
cd F:\automation-toolkit\android-tools\apps\PowerCycleManager
build-powercycle-apk.bat
```

### 2. 编辑配置

`test-config.properties`：

```properties
test.times=100           # 循环次数
test.mode=reboot         # reboot | poweroff
power.off.minutes=1      # 真关机等待分钟（poweroff 模式）
wait.seconds=3           # 每次开机后等待再执行
auto.start=true
auto.resume=true
```

### 3. 部署并开跑

```bat
cd F:\automation-toolkit\android-tools\stability_PowerCycle-Test\scripts
deploy.bat
deploy.bat -TestTimes 50 -Mode reboot -Tester "Rin"
```

### 4. 停止

```bat
scripts\stop.bat
```

等价于：写入 `auto_resume=false` + `running=false` → 尝试优雅停止服务 → **始终 force-stop 应用**。

`-Force` 仅在服务仍存活时用于报错提示。

## 测试模式

| 模式 | 行为 |
|------|------|
| `reboot` | `PowerManager.reboot()` 软重启（推荐，兼容性好） |
| `poweroff` | 真关机 + RTC 闹钟唤醒（需平台支持定时开机） |

## 结果与日志

| 路径 | 说明 |
|------|------|
| `/sdcard/Android/data/com.tinno.autotesttool/files/PowerCycle/powercycle_result.txt` | 结果日志（推荐，Android 11+ 无需额外授权） |
| `/sdcard/AutoTestTool/PowerCycle/powercycle_result.txt` | 旧路径（需 `WRITE_EXTERNAL_STORAGE` / 所有文件访问） |
| `adb logcat -s AutoTestTool_` | 运行日志 |

拉取结果：

```bat
adb pull /sdcard/AutoTestTool/PowerCycle ./results
```

## 验证

```bat
adb shell dumpsys package com.tinno.autotesttool | findstr sharedUser
adb shell dumpsys activity services com.tinno.autotesttool | findstr PowerCycleService
```

## 与 apps/PowerCycleManager 的分工

| | stability_PowerCycle-Test | apps/PowerCycleManager |
|---|---|---|
| 用途 | **跑测试** | **改 ATTS / 重编译 APK** |
| 典型用户 | 测试工程师 | 开发 / 维护 |

## 常见问题

**Q: SHARED_USER_INCOMPATIBLE?**  
A: 需用 `build-powercycle-apk.bat` 以 platform 签名构建。

**Q: reboot 模式与 poweroff 区别?**  
A: reboot 不经过完整掉电；poweroff 用于验证真关机/闹钟开机链路。

**Q: Android 16 前台服务?**  
A: 已使用 `foregroundServiceType=mediaPlayback`，避免 dataSync 6 小时上限。
