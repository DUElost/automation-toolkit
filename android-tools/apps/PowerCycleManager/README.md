# PowerCycleManager

开关机测试 APK 的**构建与源码镜像**（方案 A：基于 ATTS 二次开发）。

测试执行见 [stability_PowerCycle-Test](../../stability_PowerCycle-Test/)。

## 架构

```
D:\Tinno_auto\ATTS                          ← 主开发工程（Gradle）
    └── app/src/.../powercycle/             ← 开关机核心模块（新增）

apps/PowerCycleManager/
    ├── app-config.properties               ← 构建参数
    ├── build-powercycle-apk.bat/.ps1       ← 编译 + platform 签名
    └── powercycle-apk-src/                 ← 与 ATTS 同步的 Java 源码镜像
```

## 新增模块（`com.mediatek.schpwronoff.powercycle`）

| 类 | 职责 |
|----|------|
| `PowerCycleService` | 循环执行 reboot / shutdown，前台服务保活 |
| `PowerCycleActivity` | Launcher 入口，显示进度 |
| `BootCompletedReceiver` | 开机自动续跑 |
| `PowerCycleAutoResumeReceiver` | 闹钟唤醒 / 看门狗 |
| `PowerCyclePrefs` | 与 PC 端 `powercycle_runner.xml` 对齐 |

逻辑参考 MTBFTool `RebootService`，常量与结果目录沿用 ATTS `GlobalUtils` / `Constant`。

## 构建

1. 确认 `app-config.properties` 中 `atts.project.dir` 指向 ATTS 工程
2. 确认 `platform.pk8` / `platform.x509.pem` 与目标设备匹配
3. 运行：

```bat
build-powercycle-apk.bat
```

产物输出到 `../../stability_PowerCycle-Test/apk/AutoTestTool.apk`。

## 源码同步

在 ATTS 中修改 `powercycle` 包后，可将变更复制到 `powercycle-apk-src/` 纳入版本管理：

```bat
xcopy /E /Y D:\Tinno_auto\ATTS\app\src\main\java\com\mediatek\schpwronoff\powercycle ^
  F:\automation-toolkit\android-tools\apps\PowerCycleManager\powercycle-apk-src\
```

## Manifest 变更摘要

- Launcher 改为 `PowerCycleActivity`（移除 NativeCrashActivity 为默认入口）
- 声明 `PowerCycleService`（`foregroundServiceType=mediaPlayback`）
- 注册 `BOOT_COMPLETED` 与闹钟/看门狗 Receiver
- 权限：`REBOOT`、`SHUTDOWN`、`FOREGROUND_SERVICE_MEDIA_PLAYBACK`

## 后续裁剪建议

ATTS 仍含消息测试、Native Crash、Matrix 等历史模块。稳定后可逐步删除无关 Activity/依赖，减小 APK 体积。
