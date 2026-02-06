import os
import subprocess
import time
import concurrent.futures
import xml.etree.ElementTree as ET
from colorama import init, Fore, Back, Style

apps = []

# 相对路径
# file_path = "app_com/apps.txt"

#with open(file_path, 'r') as file:
#    for line in file:
#        apps.append(line.strip())

commands = [
    "settings put global development_settings_enabled 1"
    "am broadcast -a com.debug.loggerui.ADB_CMD -e cmd_name stop --ei cmd_target 1 -n com.debug.loggerui/.framework.LogReceiver",
    "am broadcast -a com.debug.loggerui.ADB_CMD -e cmd_name set_sublog_5_0 --ei cmd_target 1 -n com.debug.loggerui/.framework.LogReceiver",
    "am broadcast -a com.debug.loggerui.ADB_CMD -e cmd_name set_log_size_61440 --ei cmd_target 1 -n com.debug.loggerui/.framework.LogReceiver",
    "am broadcast -a com.debug.loggerui.ADB_CMD -e cmd_name start --ei cmd_target 1 -n com.debug.loggerui/.framework.LogReceiver",
    "am start -n com.debug.loggerui/com.debug.loggerui.MainActivity"
]
# 定义要执行的函数
def test_log(device, commands):
    adb_command = f"adb -s {device} shell settings put global development_settings_enabled 1"
    subprocess.run(adb_command, shell=True)
    for command in commands:
        subprocess.run(["adb", "-s", device, "shell", command], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)



def tap_screen(device, x, y):
    subprocess.run(['adb', '-s', device, 'shell', 'input', 'tap', str(x), str(y)])

def check_and_turn_on_screen(device):
    power_output = subprocess.check_output(['adb', '-s', device, 'shell', 'dumpsys', 'power']).decode('utf-8')
    holding_display_suspend_blocker = [line for line in power_output.split('\n') if
                                       'mHoldingDisplaySuspendBlocker' in line]
    if holding_display_suspend_blocker and holding_display_suspend_blocker[0].split('=')[1].strip() == 'false':
        subprocess.run(['adb', '-s', device, 'shell', 'input', 'keyevent', '26'])
        print(f"设备 {device} 屏幕已亮起")
    else:
        print(f"设备 {device} 屏幕已经亮着，无需操作")


def set_screen_timeout(device, timeout_minutes):
    # 将分钟转换为毫秒
    timeout_ms = timeout_minutes * 60 * 1000
    # 使用adb命令设置屏幕超时时间
    subprocess.run(['adb', '-s', device, 'shell', 'settings', 'put', 'system', 'screen_off_timeout', str(timeout_ms)])
    subprocess.run(['adb', '-s', device, 'shell', 'cmd', 'overlay', 'enable', 'com.android.internal.systemui.navbar.gestural'])
    print(f"设备 {device} 屏幕超时时间已设置为{Fore.RED}{timeout_minutes}{Style.RESET_ALL}分钟")


def open_app(package_name, device):
    # 将命令输出重定向到DEVNULL，即隐藏输出
    subprocess.run(
        ['adb', '-s', device, 'shell', 'monkey', '-p', package_name, '-c', 'android.intent.category.LAUNCHER', '1'],
        stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)


def fill_memory(device, percentage):
    # 计算需要填充的内存大小（以MB为单位）
    total_memory = int(
        subprocess.check_output(['adb', '-s', device, 'shell', 'cat', '/proc/meminfo']).decode('utf-8').split(
            'MemTotal:')[1].split()[0])
    memory_to_fill = int(total_memory * (percentage / 100))

    # 发送广播来填充内存
    subprocess.run(
        ['adb', '-s', device, 'shell', 'am', 'broadcast', '-a', 'com.example.FILL_MEMORY', '--ei', 'MEMORY_SIZE',
         str(memory_to_fill)])

def get_storage_info(device):
    result = subprocess.check_output(f"adb -s {device} shell df /sdcard", shell=True).decode()
    lines = result.strip().split("\n")
    storage_info = lines[1].split()
    total_storage = int(storage_info[1]) // 1024  # 转换为MB
    used_storage = int(storage_info[2]) // 1024  # 转换为MB
    available_storage = int(storage_info[3]) // 1024  # 转换为MB
    use_percentage = int(storage_info[4][:-1])  # 去掉百分号
    return total_storage, used_storage, available_storage, use_percentage

def fill_storage_to_percentage(percentage, device):
    # 检查文件是否存在，如果存在则先删除
    subprocess.run(f"adb -s {device} shell if [ -f /sdcard/fill_storage ]; then rm /sdcard/fill_storage; fi", shell=True)

    total_storage, used_storage, available_storage, use_percentage = get_storage_info(device)
    # 增加10%存储使用百分比
    use_percentage = Memory_use
    # 增加10%已使用存储空间
    used_storage = total_storage * (Memory_use/100)

    target_storage = round(total_storage * percentage // 100 - total_storage * Memory_use // 100)

    remaining_storage = total_storage - used_storage

    count_num = target_storage // 16

    #print(f"Total storage: {total_storage} MB")
    #print(f"Used storage: {used_storage} MB")
    #print(f"Available storage: {available_storage} MB")
    print(f"{Fore.YELLOW}Remaining storage: {Fore.BLUE}{remaining_storage} {Style.RESET_ALL}MB")
    print(f"{Fore.YELLOW}Use percentage: {Fore.BLUE}{use_percentage}{Style.RESET_ALL}%")
    print(f"{Fore.YELLOW}Target storage to fill: {Fore.BLUE}{target_storage} {Style.RESET_ALL}MB")

    # 填充新的存储块
    subprocess.run(f"adb -s {device} shell dd if=/dev/zero of=/sdcard/fill_storage bs=16M count={count_num}", shell=True)
    subprocess.run(f"adb -s {device} shell cat /sdcard/fill_storage > /dev/null", shell=True)

    print(f"Storage filled to {percentage}%")

def find_text_coordinate(text, device):
    #休眠
    time.sleep(3)
    # 使用subprocess模块执行adb shell uiautomator dump命令
    subprocess.run(['adb', '-s', device, 'shell', 'uiautomator', 'dump'], capture_output=True, text=True)
    time.sleep(2)
    # 使用adb shell命令获取文件内容，并指定编码格式为utf-8
    result = subprocess.run(['adb', '-s', device, 'shell', 'cat', '/sdcard/window_dump.xml'], capture_output=True,
                            text=True, encoding='utf-8')
    # 检查命令执行结果
    if result.returncode == 0:
        xml_content = result.stdout
        # 解析XML文本
        tree = ET.ElementTree(ET.fromstring(xml_content))
        # 遍历XML树，查找指定Text的节点
        for element in tree.iter('node'):
            if element.get('text') == text:
                bounds = element.get('bounds')
                # 提取坐标值
                bounds = bounds.strip('[]').split('][')
                left_x, top_y = map(int, bounds[0].split(','))
                right_x, bottom_y = map(int, bounds[1].split(','))
                # 计算中间值
                mid_x = (left_x + right_x) // 2
                mid_y = (top_y + bottom_y) // 2
                # 使用ADB命令在手机屏幕上点击指定坐标
                subprocess.run(['adb', '-s', device, 'shell', f'input tap {mid_x} {mid_y}'])
                return mid_x, mid_y

    else:
        print('Error occurred while reading file.')
        return None

def find_Contain_text_coordinate(text, device):
    #休眠
    time.sleep(3)
    # 使用subprocess模块执行adb shell uiautomator dump命令
    subprocess.run(['adb', '-s', device, 'shell', 'uiautomator', 'dump'], capture_output=True, text=True)
    time.sleep(2)
    # 使用adb shell命令获取文件内容，并指定编码格式为utf-8
    result = subprocess.run(['adb', '-s', device, 'shell', 'cat', '/sdcard/window_dump.xml'], capture_output=True,
                            text=True, encoding='utf-8')
    # 检查命令执行结果
    if result.returncode == 0:
        xml_content = result.stdout
        # 解析XML文本
        tree = ET.ElementTree(ET.fromstring(xml_content))
        # 遍历XML树，查找指定Text的节点
        for element in tree.iter('node'):
            if text in element.get('text'):
                bounds = element.get('bounds')
                # 提取坐标值
                bounds = bounds.strip('[]').split('][')
                left_x, top_y = map(int, bounds[0].split(','))
                right_x, bottom_y = map(int, bounds[1].split(','))
                # 计算中间值
                mid_x = (left_x + right_x) // 2
                mid_y = (top_y + bottom_y) // 2
                # 使用ADB命令在手机屏幕上点击指定坐标
                subprocess.run(['adb', '-s', device, 'shell', f'input tap {mid_x} {mid_y}'])
                return mid_x, mid_y

    else:
        print('Error occurred while reading file.')
        return None

def find_text_case_insensitive(text, device):
    """不修改原函数的大小写不敏感适配器"""
    # 常见的大小写变体组合
    variants = [
        text,                  # 原文本 "Set Virtual RAM"
        text.lower(),          # "set virtual ram"
        text.title(),          # "Set Virtual Ram"
        text.upper(),          # "SET VIRTUAL RAM"
        text.capitalize(),     # "Set virtual ram"
    ]
    
    # 去重（避免重复查找相同字符串）
    variants = list(set(variants))
    
    # 尝试所有变体
    for variant in variants:
        result = find_Contain_text_coordinate(variant, device)
        if result:
            return result
    return None

def find_parent_child_text(anchor_text, device, child_index=1):
    """
    基于锚点文本找到父类，然后获取父类下指定索引的子元素的text值
    
    Args:
        anchor_text: 锚点文本，用于定位父类
        device: 设备ID
        child_index: 子元素索引（从0开始，默认为1表示第二个元素）
    
    Returns:
        子元素的text值，如果找不到则返回None
    """
    
    # 休眠
    time.sleep(3)
    # 使用subprocess模块执行adb shell uiautomator dump命令
    subprocess.run(['adb', '-s', device, 'shell', 'uiautomator', 'dump'], capture_output=True, text=True)
    time.sleep(2)
    # 使用adb shell命令获取文件内容，并指定编码格式为utf-8
    result = subprocess.run(['adb', '-s', device, 'shell', 'cat', '/sdcard/window_dump.xml'], capture_output=True,
                            text=True, encoding='utf-8')
    
    if result.returncode == 0:
        xml_content = result.stdout
        # 解析XML文本
        tree = ET.ElementTree(ET.fromstring(xml_content))
        
        # 先找到锚点元素
        anchor_element = None
        for element in tree.iter('node'):
            if element.get('text') == anchor_text:
                anchor_element = element
                break
        
        if anchor_element is None:
            print(f"Anchor text '{anchor_text}' not found")
            return None
        
        # 获取锚点元素的所有兄弟节点（在同一父节点下的所有子节点）
        parent_map = {c: p for p in tree.iter() 
                     for c in p}
        
        # 找到锚点元素的父节点
        parent = parent_map.get(anchor_element)
        
        if parent is None:
            print("Could not find parent of anchor element")
            return None
        
        # 获取父节点下的所有子节点
        children = list(parent)
        
        if len(children) <= 1:
            print(f"Parent has only {len(children)} children, need at least 2")
            return None
        
        # 检查子节点索引是否有效
        if child_index >= len(children):
            print(f"Child index {child_index} is out of range. Total children: {len(children)}")
            return None
        
        # 获取指定索引的子元素
        target_element = children[child_index]
        text_value = target_element.get('text')
        
        print(f"Found {len(children)} children in parent")
        print(f"Child {child_index} text: {text_value}")
        
        return text_value

def Select_text_Memory(text, device):
    Screen_on(device)
    time.sleep(2)
    board_output = subprocess.check_output(f'adb shell getprop ro.product.board').decode('utf-8').strip()
    if board_output in {"Infinix-X6726B", "TECNO-CL7"}:
        time.sleep(2)
        subprocess.run(['adb', '-s', device, 'shell', 'pm', 'clear', 'com.android.settings'], stdout=subprocess.DEVNULL)
        time.sleep(2)
        subprocess.run(['adb', 'shell', 'am', 'start', 'com.android.settings/com.android.settings.Settings'],
                       stdout=subprocess.DEVNULL)
        time.sleep(5)
        # for i in range(5):
        #     subprocess.run(['adb', '-s',  'shell', 'input', 'swipe', '350', '1200', '350', '400', '100'])
        #     time.sleep(2)
        find_Contain_text_coordinate('My Phone', device)
        time.sleep(3)
        find_Contain_text_coordinate('RAM', device)
        time.sleep(3)
        find_text_case_insensitive('Set Virtual RAM', device)
        time.sleep(3)
        print(f"{Fore.BLUE}Found {text} in Select_text_Memory")
        find_Contain_text_coordinate(text.replace("GB", " GB"), device)
        text = text.replace("GB", " GB")
        print(f"{Fore.BLUE}Found {text} in Select_text_Memory")
        time.sleep(3)
        find_Contain_text_coordinate('Modify and restart', device)
    elif board_output in {"Infinix-X1302", "TECNO-T1102W", "TECNO-T1102"}:
        time.sleep(2)
        subprocess.run(['adb', '-s', device, 'shell', 'pm', 'clear', 'com.android.settings'], stdout=subprocess.DEVNULL)
        time.sleep(2)
        subprocess.run(['adb', '-s', device, 'shell', 'am', 'start', 'com.android.settings/com.android.settings.Settings'], stdout=subprocess.DEVNULL)
        time.sleep(5)
        for i in range(5):
            subprocess.run(['adb', '-s', device, 'shell', 'input', 'swipe', '350', '1100', '350', '400', '100'])
            time.sleep(2)
        find_text_coordinate('System', device)
        time.sleep(3)
        find_text_coordinate('MemFusion', device)
        time.sleep(3)
        find_text_coordinate('MemFusion', device)
        time.sleep(3)
        find_text_coordinate('Set virtual RAM', device)
        time.sleep(3)
        print(f"{Fore.BLUE}Found {text} in Select_text_Memory")
        find_text_coordinate(text.replace("GB", "G"), device)
        time.sleep(3)
        find_text_coordinate('OK', device)
    elif board_output in {"Infinix-X1102B"}:
        time.sleep(2)
        subprocess.run(['adb', '-s', device, 'shell', 'pm', 'clear', 'com.android.settings'], stdout=subprocess.DEVNULL)
        time.sleep(2)
        subprocess.run(['adb', '-s', device, 'shell', 'am', 'start', 'com.android.settings/com.android.settings.Settings'], stdout=subprocess.DEVNULL)
        time.sleep(5)
        find_text_coordinate('Storage', device)
        time.sleep(3)
        find_text_coordinate('MemFusion', device)
        time.sleep(3)
        find_text_coordinate('Set virtual RAM', device)
        time.sleep(3)
        print(f"{Fore.BLUE}Found {text} in Select_text_Memory")
        find_Contain_text_coordinate(text, device)
        time.sleep(3)
        find_Contain_text_coordinate('Modify and restart', device)
    elif board_output in {"TECNO-KO5"}:
        time.sleep(2)
        subprocess.run(['adb', '-s', device, 'shell', 'pm', 'clear', 'com.android.settings'], stdout=subprocess.DEVNULL)
        time.sleep(2)
        subprocess.run(['adb', '-s', device, 'shell', 'am', 'start', 'com.android.settings/com.android.settings.Settings'], stdout=subprocess.DEVNULL)
        time.sleep(5)
        find_Contain_text_coordinate('TECNO SPARK 50 Pro', device)
        time.sleep(3)
        find_Contain_text_coordinate('RAM', device)
        time.sleep(3)
        find_text_case_insensitive('Set Virtual RAM', device)
        time.sleep(3)
        print(f"{Fore.BLUE}Found {text} in Select_text_Memory")
        find_Contain_text_coordinate(text.replace("GB", " GB"), device)
        text = text.replace("GB", " GB")
        print(f"{Fore.BLUE}Found {text} in Select_text_Memory")
        time.sleep(3)
        find_Contain_text_coordinate('Modify and restart', device)
    else:
        subprocess.run(['adb', '-s', device, 'shell', 'am', 'start', 'com.android.settings/com.android.settings.Settings'], stdout=subprocess.DEVNULL)
        time.sleep(5)
        for i in range(5):
            subprocess.run(['adb', '-s', device, 'shell', 'input', 'swipe', '350', '1100', '350', '400', '100'])
            time.sleep(2)
        find_text_coordinate('Special Function ', device)
        find_text_coordinate('Special Function', device)
        find_text_coordinate('MemFusion', device)
        find_text_coordinate('Set virtual RAM', device)
        find_text_coordinate(text, device)
        find_text_coordinate('Modify and restart', device)

def OOBE_Phone(device):
    find_text_coordinate('Next', device)
    find_text_coordinate('Indonesia', device)
    find_text_coordinate('Next', device)
    find_text_coordinate('Skip', device)
    find_text_coordinate('Skip', device)
    find_text_coordinate('I have read and agreed to the above terms', device)
    find_text_coordinate('Next', device)
    find_text_coordinate('More', device)
    find_text_coordinate('More', device)
    find_text_coordinate('Accept', device)
    find_text_coordinate('Skip', device)
    find_text_coordinate('Skip', device)
    time.sleep(5)
    tap_screen(device, 750, 1500)
    time.sleep(5)
    find_text_coordinate('Next', device)
    time.sleep(5)
    tap_screen(device, 500, 1800)
def Reset_Phone(count, device):
    for i in range(count):
        board_output = subprocess.check_output(f'adb shell getprop ro.product.board').decode('utf-8').strip()
        if board_output in {"Infinix-X1302", "TECNO-T1102W", "TECNO-T1102"}:
            # 构建工厂重置的ADB Shell命令
            adb_command = f"adb -s {device} root"
            # 使用subprocess模块执行ADB Shell命令
            subprocess.run(adb_command, shell=True, stdout=subprocess.DEVNULL)
            # 执行恢复出厂设置
            reset_cmd = ('adb shell am broadcast -a android.intent.action.FACTORY_RESET '
                         '--receiver-foreground -p android '
                         '-es "android.intent.extra.REASON" "ExitRetailModeConfirmed" '
                         '-ez "android.intent.extra.WIPE_EXTERNAL_STORAGE" true '
                         '-ez "com.android.internal.intent.extra.WIPE_ESIMS" true')
            # 使用subprocess模块执行ADB Shell命令
            subprocess.run(reset_cmd, shell=True, stdout=subprocess.DEVNULL)
        else:
            # 构建工厂重置的ADB Shell命令
            adb_command = f"adb -s {device} root"
            # 使用subprocess模块执行ADB Shell命令
            subprocess.run(adb_command, shell=True, stdout=subprocess.DEVNULL)
            # 构建工厂重置的ADB Shell命令
            adb_command = f"adb -s {device} shell am broadcast -a android.intent.action.FACTORY_RESET --receiver-foreground -p android -es \"android.intent.extra.REASON\" \"ExitRetailModeConfirmed\" -ez \"android.intent.extra.WIPE_EXTERNAL_STORAGE\" true -ez \"com.android.internal.intent.extra.WIPE_ESIMS\" true"
            # 使用subprocess模块执行ADB Shell命令
            subprocess.run(adb_command, shell=True, stdout=subprocess.DEVNULL)
        print(f"{Fore.BLUE}{device}{Fore.YELLOW}正在恢复出厂设置{Fore.GREEN}......{Style.RESET_ALL}")
        time.sleep(200)
        check_and_turn_on_screen(device)
        set_screen_timeout(device, 2)
        OOBE_Phone(device)
def Reset_Phone_Skip(count, device):
    for i in range(count):
        board_output = subprocess.check_output(f'adb shell getprop ro.product.board').decode('utf-8').strip()
        if board_output in {"Infinix-X1302", "TECNO-T1102W", "TECNO-T1102"}:
            # 构建工厂重置的ADB Shell命令
            adb_command = f"adb -s {device} root"
            # 使用subprocess模块执行ADB Shell命令
            subprocess.run(adb_command, shell=True, stdout=subprocess.DEVNULL)
            # 执行恢复出厂设置
            reset_cmd = ('adb shell am broadcast -a android.intent.action.FACTORY_RESET '
                         '--receiver-foreground -p android '
                         '-es "android.intent.extra.REASON" "ExitRetailModeConfirmed" '
                         '-ez "android.intent.extra.WIPE_EXTERNAL_STORAGE" true '
                         '-ez "com.android.internal.intent.extra.WIPE_ESIMS" true')
            # 使用subprocess模块执行ADB Shell命令
            subprocess.run(reset_cmd, shell=True, stdout=subprocess.DEVNULL)
        elif board_output in {"Infinix-X1102B"}:
            Screen_on(device)
            time.sleep(2)
            subprocess.run(['adb', '-s', device, 'shell', 'pm', 'clear', 'com.android.settings'], stdout=subprocess.DEVNULL)
            time.sleep(2)
            subprocess.run(['adb', '-s', device, 'shell', 'am', 'start', 'com.android.settings/com.android.settings.Settings'], stdout=subprocess.DEVNULL)
            time.sleep(5)
            for i in range(5):
                subprocess.run(['adb', '-s', device, 'shell', 'input', 'swipe', '350', '1100', '350', '400', '100'])
                time.sleep(2)
            find_text_coordinate('System', device)
            time.sleep(3)
            for i in range(3):
                subprocess.run(['adb', '-s', device, 'shell', 'input', 'swipe', '1100', '1100', '1100', '400', '100'])
                time.sleep(2)
            find_text_coordinate('Reset options', device)
            time.sleep(3)
            find_text_coordinate('Erase all data (factory reset)', device)
            time.sleep(5)
            find_text_coordinate('Erase all data', device)
            time.sleep(5)
            find_text_coordinate('Erase all data', device)
        else:
            # 构建工厂重置的ADB Shell命令
            adb_command = f"adb -s {device} root"
            # 使用subprocess模块执行ADB Shell命令
            subprocess.run(adb_command, shell=True, stdout=subprocess.DEVNULL)
            # 构建工厂重置的ADB Shell命令
            adb_command = f"adb -s {device} shell am broadcast -a android.intent.action.FACTORY_RESET --receiver-foreground -p android -es \"android.intent.extra.REASON\" \"ExitRetailModeConfirmed\" -ez \"android.intent.extra.WIPE_EXTERNAL_STORAGE\" true -ez \"com.android.internal.intent.extra.WIPE_ESIMS\" true"
            # 使用subprocess模块执行ADB Shell命令
            subprocess.run(adb_command, shell=True, stdout=subprocess.DEVNULL)
        print(f"{Fore.BLUE}{device}{Fore.YELLOW}正在恢复出厂设置{Fore.GREEN}......{Style.RESET_ALL}")
        time.sleep(200)
        check_and_turn_on_screen(device)
        set_screen_timeout(device, 2)
        adb_command = f"adb -s {device} shell settings put secure user_setup_complete 1"
        # 使用subprocess模块执行ADB Shell命令
        subprocess.run(adb_command, shell=True)
        adb_command = f"adb -s {device} shell settings put global device_provisioned 1"
        # 使用subprocess模块执行ADB Shell命令
        subprocess.run(adb_command, shell=True)
        adb_command = f"adb -s {device} shell settings put system system_locales en-US"
        # 使用subprocess模块执行ADB Shell命令
        subprocess.run(adb_command, shell=True)
        time.sleep(2)
        adb_command = f"adb -s {device} shell input keyevent 4"
        # 使用subprocess模块执行ADB Shell命令
        subprocess.run(adb_command, shell=True)


def Reboot_Phone(count, device):
    for i in range(count):
        # 构建工厂重置的ADB Shell命令
        adb_command = f"adb -s {device} reboot"
        # 使用subprocess模块执行ADB Shell命令
        subprocess.run(adb_command, shell=True)


def check_memfusion_swapfile(memory_value, device):
    time.sleep(2)
    mismatch_found = False
    board_output = subprocess.check_output(f'adb shell getprop ro.product.board').decode('utf-8').strip()
    if board_output in {"Infinix-X1302", "TECNO-T1102W", "TECNO-T1102"}:
        Screen_on(device)
        subprocess.run(['adb', '-s', device, 'shell', 'pm', 'clear', 'com.android.settings'], stdout=subprocess.DEVNULL)
        time.sleep(2)
        subprocess.run(['adb', '-s', device, 'shell', 'am', 'start', 'com.android.settings/com.android.settings.Settings'], stdout=subprocess.DEVNULL)
        time.sleep(5)
        for i in range(5):
            subprocess.run(['adb', '-s', device, 'shell', 'input', 'swipe', '350', '1100', '350', '400', '100'])
            time.sleep(2)
        find_text_coordinate('System', device)
        time.sleep(2)
        find_text_coordinate('MemFusion', device)
        time.sleep(2)
        find_text_coordinate('MemFusion', device)
        time.sleep(8)
        # 调用函数，以"Set virtual RAM"为锚点，获取父类的第二个元素（索引1）的text值
        swapfile_value = find_parent_child_text("Set virtual RAM", device, child_index=1)
        time.sleep(2)
        # 判断 memfusion_ui_enable 和 swapfile_size_mb 是否满足条件
        if swapfile_value and memory_value in swapfile_value:
            print(f"属性值检查{Fore.BLUE}PASS: {Fore.BLUE}size_mb为{swapfile_value}{Style.RESET_ALL}")
        else:
            mismatch_found = True
            actual_value = swapfile_value if swapfile_value else '未知'
            print(f"属性值检查{Fore.RED}FAIL: 设置的值为{Fore.RED}{memory_value}, 但手机实际的值为{Fore.BLUE}{actual_value}{Style.RESET_ALL}")
    elif board_output in {"TECNO-KO5"}:
        target_value = memory_value
        # 将内存数值转换为MB单位
        if 'GB' in target_value:
            cleaned_value = target_value.replace('GB', '').strip()
            target_value = str(int(float(cleaned_value) * 1024))  # 1GB = 1024MB
        # 获取 memfusion_ui_enable 属性值
        result_memfusion = subprocess.run(['adb', '-s', device, 'shell', 'getprop', 'persist.odm.tr_memfusion.ui.show'], capture_output=True, text=True)
        memfusion_value = result_memfusion.stdout.strip()
        # 获取 swapfile_size_mb 属性值
        result_swapfile = subprocess.run(['adb', '-s', device, 'shell', 'getprop', 'persist.odm.tr_memfusion.swapfile_size_mb'], capture_output=True, text=True)
        swapfile_value = result_swapfile.stdout.strip()
        # 判断 memfusion_ui_enable 和 swapfile_size_mb 是否满足条件
        if 'true' in memfusion_value and target_value in swapfile_value:
            print(f"属性值检查{Fore.BLUE}PASS: {Fore.GREEN}ui_enable为{memfusion_value}, {Fore.BLUE}且size_mb为{swapfile_value}{Style.RESET_ALL}")
        else:
            mismatch_found = True
            print(f"属性值检查{Fore.RED}FAIL: {Fore.GREEN}ui_enable为{memfusion_value}，设置的值为{Fore.RED}{memory_value}, 但手机实际的值为{Fore.BLUE}{swapfile_value}{Style.RESET_ALL}")
    else:
        target_value = memory_value
        # 将内存数值转换为MB单位
        if 'GB' in target_value:
            cleaned_value = target_value.replace('GB', '').strip()
            target_value = str(int(float(cleaned_value) * 1024))  # 1GB = 1024MB
        # 获取 memfusion_ui_enable 属性值
        result_memfusion = subprocess.run(['adb', '-s', device, 'shell', 'getprop', 'persist.vendor.memfusion_ui_enable'], capture_output=True, text=True)
        memfusion_value = result_memfusion.stdout.strip()
        # 获取 swapfile_size_mb 属性值
        result_swapfile = subprocess.run(['adb', '-s', device, 'shell', 'getprop', 'persist.vendor.swapfile_size_mb'], capture_output=True, text=True)
        swapfile_value = result_swapfile.stdout.strip()
        # 判断 memfusion_ui_enable 和 swapfile_size_mb 是否满足条件
        if 'true' in memfusion_value and target_value in swapfile_value:
            print(f"属性值检查{Fore.BLUE}PASS: {Fore.GREEN}ui_enable为{memfusion_value}, {Fore.BLUE}且size_mb为{swapfile_value}{Style.RESET_ALL}")
        else:
            mismatch_found = True
            print(f"属性值检查{Fore.RED}FAIL: {Fore.GREEN}ui_enable为{memfusion_value}，设置的值为{Fore.RED}{memory_value}, 但手机实际的值为{Fore.BLUE}{swapfile_value}{Style.RESET_ALL}")
    return mismatch_found


def check_boot_reason_for_keyword(output, keyword):
    return keyword.lower() in output.lower()

def get_boot_reason_with_keyword(device):
    process = subprocess.Popen(['adb', '-s', device, 'shell', 'getprop', 'sys.boot.reason'], stdout=subprocess.PIPE)
    output, _ = process.communicate()
    return output.decode('utf-8')


def check_db_history_keywords(device):
    keywords = ["Kernel (KE)", "HWT", "HW Reboot"]
    try:
        output = subprocess.check_output(
            ['adb', '-s', device, 'shell', 'cat', '/data/vendor/aee_exp/db_history'],
            stderr=subprocess.STDOUT
        )
    except subprocess.CalledProcessError as exc:
        error_msg = exc.output.decode('utf-8', errors='ignore') if exc.output else ''
        print(f"Log检查{Fore.YELLOW}WARN: {Fore.GREEN}{device}     {Fore.YELLOW}无法读取db_history，{error_msg.strip()}{Style.RESET_ALL}")
        return False

    content = output.decode('utf-8', errors='ignore')
    hit_keywords = [keyword for keyword in keywords if keyword in content]
    if hit_keywords:
        keyword_text = '、'.join(hit_keywords)
        print(f"Log检查{Fore.RED}FAIL: {Fore.GREEN}{device},     {Fore.YELLOW}db_history出现关键词: {keyword_text}{Style.RESET_ALL}")
        return True

    print(f"Log检查{Fore.BLUE}PASS: {Fore.GREEN}{device},     {Fore.YELLOW}db_history未发现目标关键词.{Style.RESET_ALL}")
    return False


def check_kernel(device):
    output = get_boot_reason_with_keyword(device)
    has_kernel_keyword = check_boot_reason_for_keyword(output, 'kernel')
    if has_kernel_keyword:
        print(f"Reboot_reason检查{Fore.RED}FAIL: {Fore.GREEN}{device}     {Fore.YELLOW}Found 'kernel' in the boot reason!{Style.RESET_ALL}")
    else:
        print(f"Reboot_reason重启检查{Fore.BLUE}PASS: {Fore.GREEN}{device}     {Fore.YELLOW}No 'kernel' in the boot reason.{Style.RESET_ALL}")
    return has_kernel_keyword

def Screen_on(device):
    check_and_turn_on_screen(device)
    time.sleep(2)
    for i in range(5):
        subprocess.run(['adb', '-s', device, 'shell', 'input', 'keyevent', '82'])
        time.sleep(2)
    # subprocess.run(['adb', '-s', device, 'shell', 'input', 'swipe', '500', '1500', '500', '800', '80'])
    subprocess.run(['adb', '-s', device, 'shell', 'input', 'swipe', '350', '1100', '350', '800', '100'])
    time.sleep(2)
    subprocess.run(['adb', '-s', device, 'shell', 'input', 'swipe', '350', '1100', '350', '800', '100'])
    time.sleep(2)

def Memory_Tow(memory_value, device):
    Screen_on(device)
    Select_text_Memory(memory_value, device)
    time.sleep(60)
    attr_issue = check_memfusion_swapfile(memory_value, device)
    reboot_issue = check_kernel(device)
    db_issue = check_db_history_keywords(device)
    if maybe_export_logs(device, attr_issue, reboot_issue, db_issue):
        time.sleep(10)
def Memory_Three(memory_value, device):
    Reset_Phone(1, device)
    time.sleep(60)
    check_and_turn_on_screen(device)
    attr_issue = check_memfusion_swapfile(memory_value, device)
    reboot_issue = check_kernel(device)
    db_issue = check_db_history_keywords(device)
    if maybe_export_logs(device, attr_issue, reboot_issue, db_issue):
        time.sleep(10)
def Memory_Three_Skip_OOBE(memory_value, device):
    Reset_Phone_Skip(1, device)
    time.sleep(60)
    check_and_turn_on_screen(device)
    attr_issue = check_memfusion_swapfile(memory_value, device)
    reboot_issue = check_kernel(device)
    db_issue = check_db_history_keywords(device)
    if maybe_export_logs(device, attr_issue, reboot_issue, db_issue):
        time.sleep(10)

def pull_log(device):
    # 使用subprocess模块执行ADB Shell命令
    adb_command = f"adb -s {device} shell am broadcast -a com.debug.loggerui.ADB_CMD -e cmd_name stop --ei cmd_target 1 -n com.debug.loggerui/.framework.LogReceiver"
    subprocess.run(adb_command, shell=True)
    time.sleep(10)
    # 获取当前时间戳
    db_history_current_time = time.strftime("%Y-%m-%d_%H-%M-%S", time.localtime())
    # 创建文件夹路径
    db_history_path = os.path.join('log', db_history_current_time)
    os.makedirs(db_history_path, exist_ok=True)
    # 执行adb pull命令导出文件
    subprocess.run(['adb', '-s', device, 'pull', '/data/debuglogger', db_history_path])


def maybe_export_logs(device, attr_issue=False, reboot_issue=False, db_issue=False):
    issues = []
    if attr_issue:
        issues.append("属性值不匹配")
    if reboot_issue:
        issues.append("Reboot_Reason异常")
    if db_issue:
        issues.append("db_history包含关键字")

    if issues:
        reason_text = '、'.join(issues)
        print(f"{Fore.YELLOW}检测到{reason_text}，开始导出日志...{Style.RESET_ALL}")
        pull_log(device)
        return True
    return False


    #################################################################
def before(device):
    # 开log
    test_log(device, commands)
    # 亮屏操作
    Screen_on(device)
    set_screen_timeout(device, 30)
    # 循环打开所有应用
    #print(f"{Fore.BLUE}{device}{Fore.YELLOW}正在打开应用{Fore.GREEN}......{Style.RESET_ALL}")
    #for app in apps:
    #    open_app(app, device)
    #    time.sleep(5)  # 等待5秒

    print(f"设备 {device} {Fore.BLUE}所有应用已打开")
    # 存储填充
    # fill_storage_to_percentage(fill_percentage, device)

def Gear_one(device, Memory_set):
    Reboot_Phone(1, device)
    time.sleep(50)
    attr_issue = check_memfusion_swapfile(Memory_set, device)
    reboot_issue = check_kernel(device)
    db_issue = check_db_history_keywords(device)
    if maybe_export_logs(device, attr_issue, reboot_issue, db_issue):
        time.sleep(10)


    #################################################################
######################################################################################################################
def handle_device(device, loop_count, switch_value):
    # 根据开关变量选择执行的内容
    if switch_value == 1:
        # 第一步----三个挡各重启500次（adb reboot）  前置操作
        before(device)
        # 第一步------------默认档位
        for _ in range(loop_count):
            Gear_one(device, Memory_init)
        # 第二步------------切换档位
        for Memory in Memory_list:
            Screen_on(device)
            Select_text_Memory(Memory, device)
            time.sleep(50)
            for _ in range(loop_count):
                Gear_one(device, Memory)
    elif switch_value == 2:
        # 第一步----三个挡各切换500次（adb reboot）
        #before(device, fill_percentage)
        for _ in range(loop_count):
            for Memory in Memory_list:
                Memory_Tow(Memory, device)
            Memory_Tow(Memory_init, device)
    elif switch_value == 3:
        # 第一步 - -----------默认档位
        #for _ in range(loop_count):
        #    before(device)
        #    time.sleep(60)
        #    Memory_Three_Skip_OOBE(Memory_init, device)
        # 第二步- -----------切换档位
        for Memory in Memory_list:
            for _ in range(loop_count):
                before(device)
                #Select_text_Memory(Memory, device)
                #time.sleep(60)
                #Memory_Three_Skip_OOBE(Memory, device)
                print(f"{Fore.CYAN}--- 开始测试内存档位: {Memory}, 第 {i+1}/{loop_count} 轮 ---{Style.RESET_ALL}")
            
                # 步骤 1: 恢复出厂设置，并跳过开机引导。
                print(f"{Fore.YELLOW}步骤 1: 恢复出厂设置以确保环境干净...{Style.RESET_ALL}")
                Reset_Phone_Skip(1, device)
                print(f"{Fore.GREEN}恢复出厂设置完成。{Style.RESET_ALL}")
                time.sleep(10) # 等待系统稳定

                # 步骤 2: 设置目标内存档位，此操作会触发手机重启。
                print(f"{Fore.YELLOW}步骤 2: 正在设置内存档位为 {Memory}...{Style.RESET_ALL}")
                # 'before'函数可能不再需要，因为我们刚恢复了出厂设置。
                # 如果需要开启log等操作，可以取消下面这行的注释。
                # before(device)
                Select_text_Memory(Memory, device)

                # 步骤 3: 等待手机因设置档位而重启。
                print(f"{Fore.YELLOW}步骤 3: 等待手机重启... (约60秒){Style.RESET_ALL}")
                time.sleep(60) # 为重启和系统启动提供充足时间

                # 步骤 4: 检查内存档位是否已正确应用。
                print(f"{Fore.YELLOW}步骤 4: 验证内存档位设置结果...{Style.RESET_ALL}")
                check_and_turn_on_screen(device)
                attr_issue = check_memfusion_swapfile(Memory, device)
                reboot_issue = check_kernel(device)
                db_issue = check_db_history_keywords(device)
                if maybe_export_logs(device, attr_issue, reboot_issue, db_issue):
                    time.sleep(10)
                print(f"{Fore.CYAN}--- {Memory} 档位测试完成 ---{Style.RESET_ALL}\n")
    else:
        print("无效的开关值")



# 获取连接的设备列表
devices_output = subprocess.run('adb devices', shell=True, capture_output=True, text=True).stdout.strip().split('\n')[
                 1:]
devices = [device.split('\t')[0] for device in devices_output]

d = 1
#确认操作手机
for device in devices:
    print(f"{d}.{device}")
    d += 1

# 获取手机序列号
device = str(input(f"{Fore.CYAN}请输入手机SN：{Style.RESET_ALL}"))

#初始状态确认
# 显示带颜色的选项提示信息
print(f"{Fore.YELLOW}*开始录了手机内存融合档位信息{Style.RESET_ALL}")

# 获取开关变量
Memory_init = str(input(f"请输入默认档位："))

Memory_list = []
i = 1
while True:
    Memory_str = str(input(f"输入第{i}个可切换的内存档位（{Fore.RED}按回车结束输入{Style.RESET_ALL}）："))
    if Memory_str == "":
        break
    Memory_list.append(Memory_str)
    i += 1

# 显示带颜色的选项提示信息
print(f"{Fore.YELLOW}*开始录了手机内存初始占用信息{Style.RESET_ALL}")

# 获取开关变量
#Memory_use = int(input(f"请输入内存初始占用百分比："))

#print(f"{Fore.BLUE}*已录了手机初始信息，请确认以下信息{Style.RESET_ALL}")


#print(f"手机默认内存融合为{Fore.BLUE}{Memory_init}{Style.RESET_ALL}，  可切换的内存档位为：{Fore.BLUE}{Memory_list}{Style.RESET_ALL}")

#print(f"手机当前所用内存为{Fore.BLUE}{Memory_use}{Style.RESET_ALL}%")

# 添加等待用户输入
input(f"{Fore.CYAN}信息确认无误后，按任意键继续...{Style.RESET_ALL}")

# 显示带颜色的选项提示信息
print("1. 三个挡位reboot重启")
print("2. 三个挡位auto重启")
print("3. 三个挡位各恢复出厂设置")

# 获取开关变量
switch_value = int(input(f"{Fore.CYAN}请输入开关值：{Style.RESET_ALL}"))

# 显示带颜色的填充百分比提示信息
#print("可输入任意数字进行填充")
#fill_percentage = int(input(f"{Fore.CYAN}请输入填充百分比：{Style.RESET_ALL}"))

# 显示带颜色的循环次数提示信息
print("可输入任意数字进行循环")
loop_count = int(input(f"{Fore.CYAN}请输入循环次数：{Style.RESET_ALL}"))


# # 使用ThreadPoolExecutor并发处理每个设备
# with concurrent.futures.ThreadPoolExecutor() as executor:
#     for device in devices:
#         executor.submit(handle_device, device, fill_percentage, loop_count, switch_value)

handle_device(device, loop_count, switch_value)

# 添加等待用户输入
input("按任意键继续...")

