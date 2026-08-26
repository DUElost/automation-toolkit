# stability_MTBF-Test

MTBF 离线老化测试**执行包**（仅含运行所需 APK/JAR、XML 与部署脚本，不含 apktool 源码工程）。

完整 OfflineScriptManager 自编译请使用 [apps/OfflineScriptManager](../apps/OfflineScriptManager/)。

交互选套参照 [stability_GPU-Test](../stability_GPU-Test/)：在 `suites/task/` 选任务 XML，按 XML 内 `<apk>` 从 `suites/apk/` 安装对应 APK。

## 两种离线模式

| 模式 | 调度器 | 前提 | 适用 |
|------|--------|------|------|
| **jar** | `shared/jar/sevice.jar` → `/data/local/tmp` + `dalvikvm` | **adb root** | 无匹配 platform 密钥的机型（如 ZTE） |
| **apk** | `shared/apk/OfflineScriptManager.apk` | **platform / system uid** 签名 | Tinno 等有密钥机型 |

`runAll.bat` 会先选模式，再选 APK 族与任务。

## 目录结构

```
stability_MTBF-Test/
├── runAll.bat                        # 交互：模式 → APK 族 → 任务（推荐入口）
├── suites/
│   ├── apk/                          # APK 池（各任务共用）
│   │   ├── ReliabilityUiautomatorTest.apk
│   │   ├── ReliabilityUiautomatorTestTest.apk
│   │   └── ...
│   └── task/                         # 用例集（每份 XML = 一套可选任务）
├── shared/
│   ├── apk/OfflineScriptManager.apk  # 模式 apk
│   └── jar/sevice.jar                # 模式 jar（与 552 平台 OfflineRun 同款）
├── config/                           # UiAutomatorTestData.xml 等共用配置
├── scripts/
│   ├── deploy.bat / deploy.ps1       # -Mode jar|apk
│   ├── run.bat / run.ps1
│   └── stop.bat / stop.ps1
├── test-config.properties
└── README.md
```

## 选套流程（三阶段）

1. **选模式**：`jar offline` / `OfflineScriptManager (apk)`
2. **选 APK 族**（`suites/apk/` 中存在的 `*Test.apk`）
3. **选任务 XML**：只显示 `<apk name="...">` 与所选 APK 一致的项

jar 模式：任务 XML 推到 `/data/local/tmp/runtask.xml`，并启动 Sevice。  
apk 模式：任务 XML 推到 `/sdcard/runtask.xml`，启动 RunTaskService。

## 快速开始

### 1. 准备物料

- `suites/apk/`：测试 APK
- `shared/jar/sevice.jar` 或 `shared/apk/OfflineScriptManager.apk`（按模式）
- `config/UiAutomatorTestData.xml`：WiFi / 账号
- `test-config.properties`：`task.times`、`auto.start` 等

### 2. 交互选套（推荐）

```bat
cd F:\automation-toolkit\android-tools\stability_MTBF-Test
runAll.bat
```

一键（跳过菜单）：

```bat
runAll.bat -Mode jar -Serial all -Suite "模拟老化(仿RM老化+MTBF)_Trassion_2023_8_23"
```

### 3. 命令行指定

```bat
cd scripts
deploy.bat -Mode jar -Suite "模拟老化(仿RM老化+MTBF)_Trassion_2023_8_23"
deploy.bat -Mode jar -Serial all -Suite "模拟老化(仿RM老化+MTBF)_Trassion_2023_8_23"
deploy.bat -Mode jar -Serial 6R0A77SSDE6000033,AYXDNX6710000135 -Suite "模拟老化(仿RM老化+MTBF)_Trassion_2023_8_23"
deploy.bat -Mode apk -Suite "版测700_X6838" -TaskTimes 1 -Tester "Rin"
deploy.ps1 -ListSuites
run.bat -Mode jar -Serial all -Suite "版测700_X6838"
stop.bat -Mode jar -Serial all
```

`-Suite` 填 **不含 `.xml` 的文件名**（与 `suites/task/` 下一致）。  
多机：交互选设备支持 `1,2` / `A=全部`；命令行 `-Serial all` 或 `-Serial id1,id2`（**逐台顺序**部署启动，避免并行 adb 冲突）。

## 结果与日志

| 路径 | 说明 |
|------|------|
| `/sdcard/results/realresult/` | Pass/Fail 汇总 |
| `/sdcard/results/Log/` | 运行日志 |
| `/sdcard/results/record_data/` | 电量等 |

```bat
adb pull /sdcard/results ./results
adb logcat -s TestRunner
```

## 常见问题

**Q: jar 与 apk 怎么选？**  
A: 能装上 system 签名 OfflineScriptManager → 用 apk；装不上（`SHARED_USER_INCOMPATIBLE`）且有 root → 用 jar。

**Q: jar 模式报 whoami 不是 root？**  
A: 需要 `adb root` 成功。用户版 ROM 无 root 时无法用 jar 离线。

**Q: 任务 XML 根节点是 `<task>` 可以吗？**  
A: 可以。脚本推送时会改成 `<runtask>`，并注入 `androidx.test.runner.AndroidJUnitRunner`。

**Q: 如何新增用例集？**  
A: 把平台导出的任务 XML 放到 `suites/task/`，确保引用的 `*Test.apk` 及配对宿主 APK 已在 `suites/apk/`。

**Q: 服务在跑但手机像没在测 / 每条不到 1 秒全 Fail?**  
A: 常见原因是 runner 不匹配。脚本推送时会自动注入 androidx runner。若仍失败，检查 WiFi 配置与：

```bat
adb shell pm list instrumentation | findstr reliability
adb shell "grep -m 3 runner /data/local/tmp/runtask.xml"
adb shell "grep -m 3 runner /sdcard/runtask.xml"
adb logcat -s TestRunner
```
