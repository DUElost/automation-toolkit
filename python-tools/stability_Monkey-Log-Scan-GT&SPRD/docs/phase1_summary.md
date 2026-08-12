# 第一阶段交付总结（V1.0，2026-08-05）

工程：`stability_Monkey-Log-Scan-GT&SPRD`
定位：稳定性日志采集（定期扫描 → 报错检测 → 按需导出 → 每问题一文件夹），
为第二阶段（汇总去重 → 去重前/后 Excel → jira 流水线）提供输入。

## 1. 功能全景

```
定期扫描（60s 轮询，单台；多设备架构已支持）
├─ 报错检测（多源互补，uniview 为主）
│   ├─ dropbox 14 类增量（计数状态）
│   ├─ 平台源增量（/data/anr、/data/tombstones、/data/ylog、crash-dump.log）
│   └─ uniview 异常监控（展锐 AEE 等价物：9 类 FAULT 事件，毫秒级时间点）
├─ 场景映射（ANR/FC/NE/System_Server/KP/MSP/SSP/SR/SWT/Jank/Assert/WCN）
├─ 按需导出（事件触发，后台线程不阻塞轮询）
│   ├─ dropbox 详情（每条目，无 ylog 分段覆盖则舍弃）
│   ├─ ANR trace / tombstone（平台源包装进问题包）
│   ├─ ylog（lastkernel/dmesg/fwreboot/crash-dump + ap 时间窗段）
│   ├─ uniview 聚合包 tar.gz（30+ 系统状态，不解包）
│   ├─ bugreport（关联问题包 + 冷却白名单）
│   └─ meminfo 快照
└─ 每问题一个文件夹
    {device}/{type}_{ts}/
    ├─ {type}_{ts}_summary.txt          # 基础信息+堆栈+关键信息
    ├─ detail.txt                     # dropbox 详情
    ├─ {eid}-{ts}.tar.gz / unievent_info.json  # uniview 聚合包（第二阶段解包）+ 事件元信息
    ├─ anr_trace.txt / tombstone.txt   # 平台源原始素材
    ├─ bugreport.zip / meminfo.txt     # 事件快照
    └─ ylog_ap/                        # 关联 ap 时间窗段
```

## 2. 关键机制

| 机制 | 说明 |
|---|---|
| 增量状态 | dropbox 计数（`output_{device}.json`）+ 平台源文件指纹（`output_{device}_platform.json`，按文件独立） |
| 冷启动隔离 | 首次部署只拉存量，不触发场景动作（避免误报） |
| bugreport 冷却 | `cooldown_event_types` 白名单内受 `cooldown_minutes` 限制；白名单外每次触发都导 |
| uniview 接入 | `unievent_info` 事件行增量（seen 计数）；tar.gz 时间戳双变体精确匹配归档；无包事件仅记录 |
| 问题包合并 | 同秒对齐（dropbox 包 + uniview tar 补充）；uniview 独有类型（Jank/Assert/WCN/Boot Category）以 uniview 类型建包 |
| 时间戳归一 | kick_datetime 兼容 `-`/`:` 分隔 → `YYYY-MM-DD-HHMMSS` |

## 3. 验证记录（真实设备 Z2581/MyOS16，2026-08-04/05）

| 报错类型 | 触发方式 | 验证结果 |
|---|---|---|
| FC | am crash（compass/systemui） | 条目+summary+bugreport+meminfo 全链路 ✅ |
| NE | kill -SEGV sensors | tombstone 包装 + SYSTEM_TOMBSTONE 条目 + uniview 聚合包 ✅ |
| ANR | am hang 间接 / launcher half | trace 包装 + Jank 记录 + summary ✅ |
| SWT | am hang | watchdog 条目（1.2MB）+ uniview SWT 包（6MB）✅ |
| SR | am hang 重启 | SYSTEM_RESTART + fwreboot + uniview Reboot ✅ |
| KP | sysrq（8-4 实测） | init_fatal_panic 证据；MyOS16 无 dropbox 条目（限制） |

测试：31 passed（dropbox/平台源/summary/uniview/config/时间工具）。

## 4. 已知限制

1. MSP/SSP（modem panic）：无法软件触发（需 modem 工程指令）；uniview Assert/WCN 可记录部分
2. KP：MyOS16 不写 dropbox 条目、ylog 不记录强制重启——仅属性证据 + uniview Reboot 记录
3. 多设备：架构支持，单台验证完成，未做多台联调
4. Jank/Assert/WCN 若无聚合 tar 仅事件记录（uniview 未生成包时）

## 5. 第二阶段输入（就绪）

- 问题包数据集：`data/phase1_dataset_v2`（问题包形态，22 个问题）
- summary.txt：每问题基础信息+堆栈+关键信息（汇总去重的直接输入）
- uniview 聚合包：exp_main/exp_detail 待第二阶段解包提取
- 参照：MTK Start-Log-Scan（模式驱动+Excel+去重）、Y 盘金标准（33→12 条去重语义）、
  反编译产物（ExpClass 分类 ANR/JE/NE/KE/SWT）

## 6. 文档索引

| 文档 | 内容 |
|---|---|
| `docs/platform_diff_analysis.md` | 平台差异 + 官方对照表 + 事件驱动 + uniview 机制与接入 |
| `docs/mtk_reference.md` | MTK 工具机制 + 日志类型对比 + 路径映射 + 第二阶段参照 |
| `README.md` | 使用说明 + 输出结构 |
