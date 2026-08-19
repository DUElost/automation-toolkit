# Android Tools

Android 测试相关工具集。

## 工具列表

| 类型 | 路径 | 说明 |
|------|------|------|
| APK 构建 | [apps/OfflineScriptManager](apps/OfflineScriptManager/) | MTBF 离线调度器 APK 自编译 |
| APK 构建 | [apps/PowerCycleManager](apps/PowerCycleManager/) | 开关机测试 APK 构建（基于 ATTS） |
| 测试执行 | [stability_MTBF-Test](stability_MTBF-Test/) | MTBF 离线老化执行包 |
| 测试执行 | [stability_PowerCycle-Test](stability_PowerCycle-Test/) | 开关机专项执行包 |

## 目录结构

```
android-tools/
├── vendor/                    # 共享构建依赖（apktool / jadx / 签名工具）
├── apps/                      # APK 源码与构建
│   ├── OfflineScriptManager/
│   └── PowerCycleManager/
├── stability_MTBF-Test/       # MTBF 执行包
└── stability_PowerCycle-Test/ # 开关机执行包
```

## 快速开始

### 构建 OfflineScriptManager APK

```bat
cd F:\automation-toolkit\android-tools\apps\OfflineScriptManager
build-offline-apk.bat
```

构建产物复制到 `stability_MTBF-Test/apk/` 后，在测试包中部署：

```bat
cd F:\automation-toolkit\android-tools\stability_MTBF-Test\scripts
deploy.bat
```

### 构建开关机 APK

```bat
cd F:\automation-toolkit\android-tools\apps\PowerCycleManager
build-powercycle-apk.bat
```

产物自动输出到 `stability_PowerCycle-Test/apk/AutoTestTool.apk`。

## 前置条件

- Java 8+、`adb` 在 PATH
- 平台签名：`app-config.properties` 中配置 `platform.pk8` / `platform.x509.pem`
- 设备端已安装测试 APK 与配置文件（首次需 PC 在线完成前置）
