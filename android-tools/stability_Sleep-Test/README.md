# stability_Sleep-Test

休眠唤醒专项测试**执行包**（亮屏 60s / 灭屏 300s，离线自动化）。

APK 基于 [ATTS](D:\Tinno_auto\ATTS)（`com.tinno.autotesttool`）裁剪开发，源码维护见 [apps/SleepTestManager](../apps/SleepTestManager/)。

## 目录结构

```
stability_Sleep-Test/
├── apk/
│   └── AutoTestTool.apk          # platform 签名
├── scripts/
│   ├── deploy.bat / deploy.ps1     # 安装 + 写 prefs + 可选自动开跑
│   ├── run.bat / run.ps1           # 更新配置并启动
│   └── stop.bat / stop.ps1         # 停止并关闭 auto_resume
├── test-config.properties          # 次数、亮屏/灭屏时间
└── README.md
```

## 前置条件

| 项目 | 要求 |
|------|------|
| PC | `adb` 在 PATH（仅部署阶段需要，开跑后可拔线） |
| 设备 | 工程机 / platform 签名匹配 |
| APK | 普通应用即可；deploy 会授权悬浮窗以便后台拉起透明亮屏 Activity |
| 锁屏 | 建议关闭待机锁屏 |
| ZTE 后台 | 安装成功后 deploy 会把智能优化三项（自启动 / 关联启动 / 后台运行）写成 **允许**；需 `adb root` |

## 快速开始

### 1. 构建 APK（首次）

```bat
cd F:\automation-toolkit\android-tools\apps\SleepTestManager
build-sleep-apk.bat
```

### 2. 编辑配置

`test-config.properties`：

```properties
test.times=100           # 循环次数
wake.seconds=60          # 亮屏保持时间（秒）
sleep.seconds=300        # 灭屏休眠时间（秒）
auto.start=true
auto.resume=true
```

### 3. 部署并开跑

```bat
cd F:\automation-toolkit\android-tools\stability_Sleep-Test\scripts
deploy.bat
deploy.bat -TestTimes 200 -WakeSeconds 60 -SleepSeconds 300 -Tester "Rin"
```

部署完成后可断开 USB，设备将自动循环：**灭屏 → 闹钟唤醒 → 亮屏保持 → 灭屏**。

### 4. 停止

```bat
scripts\stop.bat
```

## 测试逻辑

| 阶段 | 时长 | 行为 |
|------|------|------|
| 亮屏 | `wake.seconds`（默认 60s） | 保持屏幕点亮 |
| 灭屏 | `sleep.seconds`（默认 300s） | 缩短灭屏超时 |
| 亮屏唤醒 | — | 透明 `WakeUpActivity`（`showWhenLocked` + `turnScreenOn`） |

逻辑不涉及 `REBOOT` / 模拟电源键。

## 结果与日志

| 路径 | 说明 |
|------|------|
| `/sdcard/Android/data/com.tinno.autotesttool/files/SleepTest/sleep_test_result.txt` | 结果日志 |
| `adb logcat -s AutoTestTool_` | 运行日志 |

拉取结果：

```bat
adb pull /sdcard/Android/data/com.tinno.autotesttool/files/SleepTest ./results
```

## 验证

```bat
adb shell dumpsys activity services com.tinno.autotesttool | findstr SleepTestService
```

## 与 apps/SleepTestManager 的分工

| | stability_Sleep-Test | apps/SleepTestManager |
|---|---|---|
| 用途 | **跑测试** | **改 ATTS / 重编译 APK** |
| 典型用户 | 测试工程师 | 开发 / 维护 |

## 常见问题

**Q: 灭屏后无法唤醒？**  
A: deploy 会授权 `SYSTEM_ALERT_WINDOW`，并在 ZTE 上将智能优化三项设为允许。请确认闹钟已触发（状态栏可能出现系统闹钟图标）。非 ZTE 机型请自行把应用加入电池白名单。

**Q: 与开关机测试 APK 冲突？**  
A: 同一 `com.tinno.autotesttool` 包名，部署会覆盖安装。两个模块可共存于同一 APK，但 deploy 脚本各自独立。

**Q: 拔线后服务被杀？**  
A: 开启 `auto.resume=true`，看门狗每 5 分钟续跑；开机后 `BootCompletedReceiver` 也会恢复。
