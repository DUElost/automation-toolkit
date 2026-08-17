# Android Tools

Android 测试相关工具集。

## 工具列表

| 工具 | 说明 |
|------|------|
| [stability_OfflineScriptManager](stability_OfflineScriptManager/) | MTBF 离线老化：OfflineScriptManager APK 自编译、系统签名部署 |
| [stability_MTBF-Test](stability_MTBF-Test/) | MTBF 离线老化：**执行包**（APK + XML + 一键 deploy/run） |

## 目录结构

```
android-tools/
├── vendor/                              # 共享构建依赖
│   ├── apktool/
│   ├── jadx/
│   ├── platform-sign/
│   └── uber-apk-signer.jar
└── stability_OfflineScriptManager/      # 离线脚本管理器（自编译）
└── stability_MTBF-Test/                 # MTBF 离线执行包（APK + XML）
    ├── app-config.properties
    ├── build-offline-apk.bat
    ├── deploy-system-offline-apk.bat
    ├── deploy-and-run.bat               # 安装 + 配置 + 立即开跑
    ├── runtask.xml
    └── OfflineScriptManager-build/      # apktool 工程
```

## 快速开始（OfflineScriptManager）

```bat
cd F:\automation-toolkit\android-tools\stability_OfflineScriptManager

:: 1. 编辑 app-config.properties（有效期、platform 签名路径）
:: 2. 构建
build-offline-apk.bat

:: 3. 部署到设备（system uid）
deploy-system-offline-apk.bat

:: 4. 可选：改循环次数并立即开跑（例：试跑 1 轮）
deploy-and-run.bat -TaskTimes 1 -Tester tester
```

### deploy-and-run 参数

| 参数 | 说明 |
|------|------|
| `-TaskTimes N` | 修改 `runtask.xml` 中 `<runtask times="N">` 后 push |
| `-Tester name` | 写入测试员姓名到 SharedPreferences |
| `-SkipInstall` | 跳过 APK 安装，仅 push 配置并启动 |

## 前置条件

- Java 8+、`adb` 在 PATH
- 平台签名：`app-config.properties` 中配置 `platform.pk8` / `platform.x509.pem`
- 设备端已安装测试 APK 与 `UiAutomatorTestData.xml`（首次需 PC 在线完成前置）
