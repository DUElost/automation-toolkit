# Motorola edart EKLAMUC 项目组件列表

## 概述
- **项目**: EKLAMUC (Lamu26)
- **组件总数**: 74 个
- **获取时间**: 2025-01-13

## 组件分类

### 📷 Camera 相关组件
1. **Camera app** - CAM应用
2. **Camera driver** - CAM驱动&HAL
3. **Camera KP** - Camera器件
4. **Camera tuning** - CAM画质
5. **Camera tuning YSX** - CAM tuning issue yuanshixin
6. **Camera - Code Out of ODC** - ODC外的摄像头代码

### 📱 应用层组件
7. **Core - AOSP Launcher** - moto launcher问题跟踪
8. **SW_APP_Faceunlock** - 人脸解锁
9. **SW_APP_GMS** - GMS应用/主线集成
10. **SW_APP_Launcher** - 桌面布局、小组件、应用列表
11. **SW_APP_Localizaiton** - 本地化
12. **SW_APP_OTHER_SYSTEM_APPS** - 其他系统应用
13. **SW_APP_PAI** - PAI确认、配置验证
14. **SW_APP_Platform** - 应用平台
15. **SW_APP_Preloads** - 应用集成、预设应用
16. **SW_APP_Settings** - 设置中的功能开关
17. **SW_APP_Stability** - 应用崩溃、无响应
18. **SW_APP_SystemUI** - 状态栏、导航栏、通知、QS
19. **SW_APP_Third_Apk** - 三方应用问题分析

### 🔧 BSP (板级支持包) 组件
20. **SW_BSP_Audio** - 音频功能和效果问题
21. **SW_BSP_BT** - 蓝牙配对、传输、通话
22. **SW_BSP_Charger** - 电池显示、充电功能
23. **SW_BSP_Common** - BSP公共问题
24. **SW_BSP_Fingerprint** - 指纹识别
25. **SW_BSP_GPS** - 卫星定位、网络定位
26. **SW_BSP_LCD** - 显示功能和效果问题
27. **SW_BSP_Memory** - UFS大小、读写速度
28. **SW_BSP_NFC** - 读卡功能
29. **SW_BSP_SDCard** - SDCARD兼容性
30. **SW_BSP_Security** - fuse、认证、写key等
31. **SW_BSP_Sensor** - 传感器(加速度计、光线计等)
32. **SW_BSP_Stability** - Dump、内核崩溃等问题
33. **SW_BSP_Thermal** - 热管理
34. **SW_BSP_TP** - 触摸功能和效果
35. **SW_BSP_USB** - USB连接相关
36. **SW_BSP_Vib** - 振动功能和效果
37. **SW_BSP_WIFI** - WiFi扫描、连接、上网

### 🛠️ 硬件相关组件
38. **HW_ANT** - 天线
39. **HW_AudioTunning** - 音频调优
40. **HW_BB** - 基带
41. **HW_BSP** - BSP硬件
42. **HW_Charger** - 充电器硬件
43. **HW_LCD** - LCD显示屏
44. **HW_Sensor** - 传感器硬件
45. **HW_Thermal** - 热管理硬件
46. **HW_TP** - 触摸屏硬件

### 📶 通信组件
47. **SW_Modem** - 卡识别、信号、VoLTE等
48. **SW_Telephony** - APN、呼叫、数据业务

### 🚀 系统和性能组件
49. **SW_Performance** - 屏幕卡顿、流畅度问题
50. **SW_Platform** - MTK平台问题
51. **SW_PowerConsumption** - 待机时长、功耗
52. **SW_XTS** - XTS问题
53. **OTA** - 空中升级
54. **SW_FW_Audio** - 铃声预设、杜比功能
55. **SW_FW_Display** - 固件显示
56. **SW_FW_OTA** - 固件OTA问题分析
57. **SW_FW_SYSTEM** - 界面实现、系统重启、崩溃

### 🏭 制造和工厂组件
58. **SW_Factory** - 生产apk功能问题
59. **SW_Factory Req** - 生产apk功能需求开发
60. **DFS_BSP** - DFS BSP
61. **DFS_Tool** - DFS工具
62. **EKTM** - EKTM
63. **FIT - Retest** - FIT复测

### 📋 管理和测试组件
64. **Triage** - 问题分类
65. **Check List** - 检查清单
66. **Build Signing** - 构建签名

### 🌍 区域组件
67. **APAC** - 亚太地区
68. **EMEA** - 欧洲、中东、非洲
69. **LATAM** - 拉丁美洲

### 📋 合规和需求组件
70. **Carrier Compliance and RFIs** - 运营商合规和RFI
71. **Carriers compliance & RFIs** - 运营商合规和RFI (用于CDM或RFI CR)
72. **CUSTOMERREQ** - 客户需求
73. **Product - GPD - Lamu** - 产品GPD Lamu
74. **Services - Instrumentation** - 服务仪表化 (moto care问题)
75. **SW_Certifaction** - 认证问题 (OSS/Aptx/Dolby)

## 统计信息
- **有负责人的组件**: 大部分组件都有指定负责人
- **可分配的组件**: 大部分组件都可以分配问题
- **有描述的组件**: 约50%的组件有详细描述

## 使用建议

### 在创建JIRA问题时：
1. **选择最相关的组件**: 根据问题具体表现选择对应组件
2. **Camera问题**: 根据具体层次选择app、driver、tuning等
3. **应用问题**: 选择对应的SW_APP_*组件
4. **硬件问题**: 选择对应的HW_*组件
5. **通信问题**: 选择SW_Modem或SW_Telephony

### 组件负责人分配：
- 大部分组件都设置了组件负责人
- 问题会自动分配给组件负责人
- 可以在Excel文件中查看具体的负责人信息

## 文件说明
- **Excel文件**: `motorola_eklamuc_components_*.xlsx` - 包含完整的组件信息表
- **JSON文件**: `motorola_eklamuc_components_*.json` - 原始API数据
- **Names Only工作表**: 仅包含组件名称，便于复制使用

---
*数据来源: Motorola edart JIRA系统 EKLAMUC项目*
*更新时间: 2025-01-13*