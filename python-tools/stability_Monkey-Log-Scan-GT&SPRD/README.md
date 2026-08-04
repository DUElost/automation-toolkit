# stability_Monkey-Log-Scan-GT

高通（GT）/ 展锐（SPRD）平台稳定性工具：常驻监控 adb 设备，自动部署并保活 AIMonkey
压力测试，增量扫描 dropbox 问题（ANR/Crash/Native Crash/Watchdog/Kernel Panic/Tombstone
等 14 类），归档问题详情与问题发生前后的 logcat 到指定目录。

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
| `-s` | 跳过 monkey 检查/启动 |

独立部署 AIMonkey（不进入扫描循环）：

```bash
python -m modules.monkey.monkey_test -d <device>
```

停止设备上的 monkey：

```bash
python stopAIMonkey.py
```

## 配置（config.json）

- `general`：轮询间隔、logcat buffer 与行数
- `dropbox.types`：14 类问题的目录映射（新增问题类型只需在此加条目）
- `monkey`：AIMonkey 资源目录与设备端路径

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

## 已知说明

- 问题归档目录：`<保存目录>/<版本>/<设备>/<类型>/`
- 状态文件 `output_<设备>.json` 记录各问题计数，用于增量扫描
- 设备端脚本 `tools/monkey/MonkeyTestAi.sh` 内含 MTK 遗留命令（aee/mtk_battery_cmd），在 GT 平台上执行失败无害，后续可清理
