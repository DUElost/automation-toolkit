# stability_Monkey-Log-Scan-GT

高通（GT）/ 展锐（SPRD）平台稳定性**日志采集**工具（第一阶段，V1.0）：常驻监控 adb 设备，
定期扫描 + 报错检测 + **按报错类型按需导出关联日志** + **每问题一个文件夹**（研发直接访问）。
与 monkey 压测**解耦**（独立触发）。

**检测信号**（多源互补，uniview 为主）：
- dropbox 14 类增量（ANR/Crash/Native/Watchdog/Kernel Panic/Tombstone 等）
- 平台源增量（`/data/anr/` trace、`/data/tombstones/`、`/data/ylog/`、`/sdcard/crash-dump.log`）
- **uniview 异常监控**（展锐 AEE 等价物，毫秒级时间点 + 聚合包）

**按需导出**（事件驱动，后台线程）：dropbox 详情 / ANR trace / tombstone /
ylog（lastkernel/dmesg/fwreboot/ylog ap 时间窗）/ **uniview 聚合包**（30+ 系统状态）/
bugreport（冷却白名单）/ meminfo 快照。

**每问题一个文件夹**（`{device}/{type}_{ts}/`）：summary.txt（基础信息+堆栈+
关键信息）+ detail + anr_trace/tombstone + bugreport + meminfo + uniview 聚合包（tar.gz）+ ylog 分段引用（ylog.txt）。

## 环境要求

- Python 3.9+
- adb 已加入 PATH

## 使用

```bash
python scan_log_gt.py -p D:\logs
```

| 参数 | 说明 |
|------|------|
| `-p` | 保存目录（必填） |
| `-i` | 轮询间隔秒数（默认 60，取 config.json） |
| `-m` | 平台（`auto` 自动探测 / `sprd` / `qcom` / `mtk` / `none`；默认 auto） |

独立触发 AIMonkey 压测（与采集解耦）：

```bash
python -m modules.monkey.monkey_test -d <device>
```

停止设备上的 monkey：

```bash
python stopAIMonkey.py
```

## 配置（config.json）

- `general`：轮询间隔
- `dropbox.types`：14 类问题的目录映射（新增问题类型只需在此加条目）
- `platform.<name>.sources`：平台额外日志源（`wrap` 支持 `anr`/`tombstone` 包装与 `raw` 原样；
  `single_file`/`recursive` 指定枚举方式；指纹增量去重）——见 `docs/platform_diff_analysis.md`
- `monkey`：AIMonkey 资源目录与设备端路径（独立触发时使用）

## 目录结构

```
scan_log_gt.py            # 主入口
config.json               # 配置
modules/common/           # adb 封装、日志、路径、命令执行
modules/analyse/          # dropbox 问题分析器（配置驱动）
modules/monkey/           # AIMonkey 部署
tools/monkey/             # 设备端运行时资源（apk/jar/so/脚本/黑名单）
test/                     # pytest
logs/                     # 运行日志（自动生成）
```

## 功能（第一阶段完整形态）

1. **定期扫描**（60s 轮询，单台；多设备并发已具备）
2. **报错检测**：dropbox 14 类增量 + 平台源增量 → 官方场景映射（ANR/FC/NE/KP/SR/MSP/SSP）
3. **按需导出**（事件触发，后台线程）：
   - dropbox 详情（每条目，取舍：无 ylog 分段覆盖则舍弃）
   - ANR trace / tombstone / ylog（平台源增量指纹）
   - bugreport（条目关联命名 + 冷却白名单，参照 MTK）
   - meminfo 快照
   - ylog ap 时间窗段（异常前后各 2 段，参照 MTK correlated_mobilelogs）
4. **每报错汇总 txt**：问题包内 `{type}_{ts}_summary.txt`（基础信息 + 堆栈 + 关键信息）——第二阶段汇总去重的输入

## 输出结构（每问题一个文件夹）

```
<保存目录>/<版本>/
├─ {device}/
│   ├─ ylog/                          # 设备 ylog（归设备，同版本多设备不混）
│   │   ├─ lastkernel.log / dmesg.log / crash-dump.log
│   │   ├─ fwreboot/ / sysdump/ / modem/
│   │   └─ {seq}-{MMdd_HHmmss}....ylog  # ap 分段（事件上下文，多包共享一份）
│   ├─ {type}_{ts}/                   # 一个问题一个文件夹（研发直接访问）
│   │   ├─ {type}_{ts}_summary.txt    # 基础信息+堆栈+关键信息
│   │   ├─ {eid}-{ts}.tar.gz          # uniview 聚合包（不解包，30+ 系统状态）
│   │   ├─ unievent_info.json         # uniview 事件元信息（proc/时间/原因）
│   │   ├─ detail.txt                 # dropbox 详情（JE/NE 原文）
│   │   ├─ ylog.txt                   # ylog 分段引用（../ylog/{段}.ylog）
│   │   ├─ anr_trace.txt 或 tombstone.txt（平台源，如有）
│   │   ├─ bugreport.zip（事件关联导出，如有）
│   │   └─ meminfo.txt（事件快照，如有）
│   └─ rom_ram.json                   # 设备 ROM/RAM（SN 对应，第二阶段读取）
├─ output_{device}.json               # dropbox 计数状态
└─ output_{device}_platform.json      # 平台源指纹状态
```

## 已知说明

- 状态文件 `output_<设备>.json`（dropbox 计数）+ `output_<设备>_platform.json`（平台源指纹）
- 冷启动（首次部署）只拉存量，不触发场景动作
- 设备端脚本 `tools/monkey/MonkeyTestAi.sh` 内含 MTK 遗留命令（aee/mtk_battery_cmd），在 GT 平台上执行失败无害，后续可清理
- 详见 `docs/platform_diff_analysis.md`（平台差异+事件驱动）与 `docs/mtk_reference.md`（MTK 对照）
## 数据集

- 最新：data/phase1_dataset_v13（两设备：6R0A57SSAE6000218 52 包 / 6R0A77SSDE6000033 15 包；多版本 MyOS16.0.0 / MyOS16.0.1）
- 历史版本已清理；新运行请用最新导出目录（问题包形态）
- Reboot 事件仅保留异常重启（reboot_reason != normalboot，uniview 会记录每次正常开机）
- 输出结构：`{保存目录}/{版本}/{设备}/{类型}-{时间}/`（问题包直接放设备目录，ylog/ 归设备，tar.gz 在包根，rom_ram.json 按设备）
