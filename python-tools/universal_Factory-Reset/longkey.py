import subprocess
import re
import time

def get_power_event_node():
    """扫描设备输出，自动定位电源键对应的 event 节点"""
    try:
        # 获取所有输入设备的详细信息
        output = subprocess.check_output("adb shell getevent -p", shell=True).decode('utf-8')
        
        # 匹配设备路径和按键位图
        # 我们寻找包含 0074 (KEY_POWER) 的设备块
        device_blocks = output.split("add device")
        for block in device_blocks:
            if "0074" in block:
                # 提取设备路径，例如 /dev/input/event2
                match = re.search(r'(/dev/input/event\d+)', block)
                if match:
                    return match.group(1)
    except Exception as e:
        print(f"检测失败: {e}")
    return None

def adb_long_press_power(duration=6):
    node = get_power_event_node()
    if not node:
        print("未发现电源键节点，请确保设备已连接并开启 ADB。")
        return

    print(f"检测到电源键节点: {node}")
    print(f"正在执行长按 ({duration}s)...")

    # 构建一连串命令通过单个 shell 会话执行，减少延迟
    commands = [
        f"sendevent {node} 1 116 1", # Down
        f"sendevent {node} 0 0 0",   # Sync
        f"sleep {duration}",         # Wait
        f"sendevent {node} 1 116 0", # Up
        f"sendevent {node} 0 0 0"    # Sync
    ]
    
    full_cmd = f"adb shell \"{' && '.join(commands)}\""
    subprocess.run(full_cmd, shell=True)
    print("操作完成。")

if __name__ == "__main__":
    adb_long_press_power()