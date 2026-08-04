import subprocess

def get_connected_devices():
    """获取所有连接的设备ID"""
    result = subprocess.run(['adb', 'devices'], capture_output=True, text=True)
    devices = []
    for line in result.stdout.splitlines()[1:]:
        if line.strip():
            device_id = line.split()[0]
            devices.append(device_id)
    return devices

def kill_process_on_device(device_id, process_name):
    """在指定设备上杀掉指定名称的进程"""
    try:
        # 使用 adb shell ps 列出所有进程
        result = subprocess.run(['adb', '-s', device_id, 'shell', 'ps -ef'], capture_output=True, text=True)
        processes = result.stdout.splitlines()

        # 查找指定进程的 PID
        for process in processes:
            if process_name in process:
                columns = process.split()
                pid = columns[1]  # PID 通常是列表中的第二个元素
                # 杀掉该进程
                subprocess.run(['adb', '-s', device_id, 'shell', 'kill -9', pid])
                print(f"[{device_id}] Killed process {process_name} with PID {pid}")
                return

        print(f"[{device_id}] No process found with name {process_name}")

    except Exception as e:
        print(f"[{device_id}] An error occurred: {e}")

def main():
    # 要杀掉的进程列表
    process_names = [
        "com.transsion.MkWatchdog",
        "com.android.commands.monkey.transsion",
        "/data/local/tmp/MonkeyTest.sh"
    ]

    # 获取所有连接的设备
    devices = get_connected_devices()
    if not devices:
        print("No devices connected.")
        return

    for device_id in devices:
        for process_name in process_names:
            kill_process_on_device(device_id, process_name)

if __name__ == '__main__':
    main()