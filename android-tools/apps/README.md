# Android Apps（APK 源码与构建）

本目录存放 **APK 源码、apktool 工程与构建脚本**。日常跑测试请使用同级的 `stability_*-Test` 执行包。

| 目录 | 说明 | 测试执行包 |
|------|------|------------|
| [OfflineScriptManager](OfflineScriptManager/) | MTBF 离线调度器 APK 自编译 | [stability_MTBF-Test](../stability_MTBF-Test/) |
| [PowerCycleManager](PowerCycleManager/) | 开关机测试 APK 构建（基于 ATTS） | [stability_PowerCycle-Test](../stability_PowerCycle-Test/) |

共享构建依赖见 [../vendor/](../vendor/)（apktool、jadx、platform 签名工具）。
