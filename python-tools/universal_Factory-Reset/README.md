# Factory-Reset_Universal 自动化脚本说明

## 项目简介
- 针对安卓设备的工厂重置/重启/待机唤醒等耐久性测试，支持多设备并行。
- 通过 `adb`、`uiautomator2`（可选）驱动，结合 `config.json` 的可配置参数运行。
- 入口脚本：`Reboot_reset_ALL.py`，支持交互式与命令行参数化两种模式。

## 环境准备
- Python 3.8+，已安装 `adb` 并加入 PATH。
- 依赖：`colorama`、`uiautomator2`（可选，缺失时自动降级 ADB 方案）。  
  安装示例：`pip install -r requirements.txt`（如未提供 requirements，可执行 `pip install colorama uiautomator2 -i https://pypi.tuna.tsinghua.edu.cn/simple`）。
- 设备需开启开发者模式与 USB 调试；多设备场景请确保序列号可区分。

## 配置文件（config.json）要点
- `general.default_loop_count`：默认循环次数（无参数时使用）。
- `timings`：设备就绪、重启等待等超时/间隔。
- `adb_commands`：工厂重置、跳过 OOBE、屏幕超时等指令模板。
- `monkey`：ADB reboot 后运行的 monkey 命令与速率。
- `reboot_buttons`：不同品牌在系统电源菜单中的“重启”按钮定位信息。
- `test_modes`：测试项名称与描述（1~6）。

## 测试模式（-m/--mode）
1. 工厂重置单项：调用系统 FACTORY_RESET，随后用 `OOBE.bat` 跳过开机向导。
2. UI 长按电源键重启：模拟长按电源键并点击“重启”。
3. ADB reboot：ADB 重启，进入桌面后执行 5 分钟 monkey。
4. 顺序执行全部：依次执行 1→2→3。
5. 关机/开机循环：`setprop sys.powerctl shutdown` 关机，人工上电后继续循环。
6. 待机唤醒：电源键息屏，等待后再亮屏并解锁，循环执行。

## 运行方式
- 交互式：`python Reboot_reset_ALL.py`
- 参数化（推荐批处理/CI）：
  - `-m/--mode`：1~6 或 `all`（等同模式 4）。
  - `-l/--loop`：循环次数，未提供则用 `config.json` 默认值。
  - `-d/--device`：指定设备序列号，可重复多次；缺省为全部已连接设备。
  - `--no-pause`：脚本结束不等待按键退出。

### 示例
- 顺序跑全部测试，使用默认循环：  
  `python Reboot_reset_ALL.py --mode all --no-pause`
- 只跑 UI 重启 500 次，指定两台设备：  
  `python Reboot_reset_ALL.py -m 2 -l 500 -d 1234567890ABCDEF -d emulator-5554 --no-pause`
- 仅 ADB reboot，循环次数使用默认：  
  `python Reboot_reset_ALL.py -m 3 --no-pause`

## 日志与输出
- 终端彩色日志展示时间戳与设备序列号。
- 设备侧检查脚本与日志目录：`/data/local/tmp/device_check/`（如使用 MTK 设备检查功能）。
- 本地 `log/` 目录可存储扩展日志（若脚本其他部分有写入）。

## 常见问题
- 未检测到设备：检查 USB 连接、驱动与 `adb devices` 输出。
- `uiautomator2` 导入失败：脚本会自动降级 ADB 控制；需 UI 级点击时建议安装 `uiautomator2`。
- 模式参数错误：请使用 1~6 或 `all`，缺失会提示并退出。

## 开发者提示
- 所有新代码与注释请使用中文，遵循仓库 AGENTS 规则。
- 如需扩展测试模式，可在 `config.json` 添加新配置，并在 `handle_device` 中增加分支逻辑。

