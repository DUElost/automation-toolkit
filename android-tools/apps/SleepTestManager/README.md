# SleepTestManager

休眠唤醒测试 APK 的**构建与源码镜像**（基于 ATTS `WakeUpService` 二次开发）。

测试执行见 [stability_Sleep-Test](../../stability_Sleep-Test/)。

## 架构

```
D:\Tinno_auto\ATTS                          ← 主开发工程（Gradle）
    └── app/src/.../sleeptest/              ← 休眠唤醒核心模块

apps/SleepTestManager/
    ├── app-config.properties
    ├── build-sleep-apk.bat/.ps1            ← 同步源码 + 编译 + platform 签名
    └── sleep-apk-src/                      ← Java 源码镜像
```

## 新增模块（`com.mediatek.schpwronoff.sleeptest`）

| 类 | 职责 |
|----|------|
| `SleepTestService` | 亮屏/灭屏循环，前台服务保活 |
| `SleepTestActivity` | 状态页入口 |
| `WakeUpActivity` | 透明 Activity，`showWhenLocked` + `turnScreenOn` 请求系统亮屏 |
| `SleepTestAlarmReceiver` | 灭屏后定时唤醒 |
| `SleepTestBootReceiver` | 开机自动续跑 |
| `SleepTestKeepAliveReceiver` | 看门狗续跑 |
| `SleepTestPrefs` | 与 PC 端 `sleep_test_runner.xml` 对齐 |

逻辑参考 ATTS `WakeUpService`，默认 **亮屏 60s / 灭屏 300s**。亮屏不依赖 system uid / `INJECT_EVENTS`。

## 构建

```bat
build-sleep-apk.bat
```

产物输出到 `../../stability_Sleep-Test/apk/AutoTestTool.apk`。

## 权限说明

不涉及 `REBOOT`。灭屏用 `SCREEN_OFF_TIMEOUT`；亮屏用透明 `WakeUpActivity`：

- `WAKE_LOCK`
- `SYSTEM_ALERT_WINDOW`（后台启动 Activity，deploy 脚本会 `appops` 授权）
- `AlarmManager.setAlarmClock` 在 Doze 后拉起唤醒

## Manifest 变更摘要

- 声明 `SleepTestService`（`foregroundServiceType=mediaPlayback`）
- 注册透明 `WakeUpActivity`（`showWhenLocked` / `turnScreenOn`）
- 注册 `SleepTestAlarmReceiver` / `SleepTestBootReceiver` / `SleepTestKeepAliveReceiver`
