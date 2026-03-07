import os
import subprocess
import time
import json
import concurrent.futures
import xml.etree.ElementTree as ET
import re
import signal
import sys
import random
import argparse
from datetime import datetime
from colorama import init, Fore, Style

U2_IMPORT_ERROR = None
try:
    import uiautomator2 as u2
except Exception as e:
    u2 = None
    U2_IMPORT_ERROR = str(e)

U2_DEVICE_CACHE = {}
U2_INIT_FAILED = set()
U2_IMPORT_WARNED = False

init()

# 全局退出标志
exit_flag = False

def signal_handler(signum, frame):
    """处理Ctrl+C和Ctrl+Z信号"""
    global exit_flag
    exit_flag = True
    print(f"\n{Fore.YELLOW}[{get_timestamp()}] 收到退出信号，正在安全退出...{Style.RESET_ALL}")
    sys.exit(0)

# 注册信号处理
signal.signal(signal.SIGINT, signal_handler)   # Ctrl+C
signal.signal(signal.SIGTERM, signal_handler)  # 终止信号
try:
    signal.signal(signal.SIGBREAK, signal_handler)  # Windows Ctrl+Break
except AttributeError:
    pass  # SIGBREAK 仅在 Windows 上可用

def get_timestamp():
    """获取当前时间戳"""
    return datetime.now().strftime("%Y-%m-%d %H:%M:%S")

def log_print(device, message, color=Fore.WHITE):
    """带时间戳的日志打印"""
    print(f"{color}[{get_timestamp()}] [{device}] {message}{Style.RESET_ALL}")

# 加载配置文件
def get_base_path():
    """获取基础路径（支持打包后运行）"""
    if getattr(sys, 'frozen', False):
        # 打包后运行
        return os.path.dirname(sys.executable)
    else:
        # 开发环境运行
        return os.path.dirname(os.path.abspath(__file__))

def load_config():
    config_path = os.path.join(get_base_path(), 'config.json')
    with open(config_path, 'r', encoding='utf-8') as f:
        return json.load(f)

CONFIG = load_config()

# 开机向导相关关键词（用于识别OOBE界面）
SETUP_WIZARD_KEYWORDS = [
    "setupwizard",
    "setup_wizard",
    "oobe",
    "provision",
    "deviceprovision",
    "initialsetup"
]

# 器件检测相关配置
DEVICE_CHECK_SCRIPT_PATH = "/data/local/tmp/mtk_device_check.sh"
DEVICE_CHECK_LOG_DIR = "/data/local/tmp/device_check"

def get_ro_product_model():
    result = subprocess.run(["adb", "shell", "getprop", "ro.product.model"], capture_output=True, text=True)
    return result.stdout.strip()

def get_device_brand(device):
    """获取设备品牌 ro.product.brand"""
    result = subprocess.run(["adb", "-s", device, "shell", "getprop", "ro.product.brand"], capture_output=True, text=True)
    return result.stdout.strip()

def get_u2_device(device):
    """获取uiautomator2设备对象（失败返回None）"""
    global U2_IMPORT_WARNED
    if u2 is None:
        if not U2_IMPORT_WARNED:
            log_print(device, f"uiautomator2不可用，已降级为ADB方式: {U2_IMPORT_ERROR}", Fore.YELLOW)
            U2_IMPORT_WARNED = True
        return None
    if device in U2_DEVICE_CACHE:
        return U2_DEVICE_CACHE[device]
    if device in U2_INIT_FAILED:
        return None
    try:
        d = u2.connect(device)
        U2_DEVICE_CACHE[device] = d
        return d
    except Exception as e:
        U2_INIT_FAILED.add(device)
        log_print(device, f"uiautomator2连接失败，已降级为ADB方式: {e}", Fore.YELLOW)
        return None

def u2_click_selector(selector, timeout):
    """使用uiautomator2 selector等待并点击"""
    click_exists = getattr(selector, 'click_exists', None)
    if callable(click_exists):
        return bool(click_exists(timeout=timeout))
    if selector.wait(timeout=timeout):
        selector.click()
        return True
    return False

def u2_click_xpath(d, xpath, timeout):
    """使用uiautomator2 xpath等待并点击"""
    xp = d.xpath(xpath)
    click_exists = getattr(xp, 'click_exists', None)
    if callable(click_exists):
        return bool(click_exists(timeout=timeout))
    if xp.wait(timeout=timeout):
        xp.click()
        return True
    return False

def create_device_check_script():
    """创建器件检测脚本内容"""
    return '''#!/system/bin/sh
LOG_DIR="/data/local/tmp/device_check"
BASELINE_FILE="$LOG_DIR/baseline.txt"
CURRENT_FILE="$LOG_DIR/current_$(date +%Y%m%d_%H%M%S).txt"
RESULT_FILE="$LOG_DIR/result_$(date +%Y%m%d_%H%M%S).log"
mkdir -p $LOG_DIR
log_info() { echo "[INFO] $1" | tee -a $RESULT_FILE; }
log_pass() { echo "[PASS] $1" | tee -a $RESULT_FILE; }
log_fail() { echo "[FAIL] $1" | tee -a $RESULT_FILE; }
log_warn() { echo "[WARN] $1" | tee -a $RESULT_FILE; }
echo "========================================" | tee $RESULT_FILE
echo "MTK Device Check - $(date)" | tee -a $RESULT_FILE
echo "Model: $(getprop ro.product.model)" | tee -a $RESULT_FILE
echo "========================================" | tee -a $RESULT_FILE
echo "" | tee -a $RESULT_FILE
log_info "=== 1. Sensor Devices Check ==="
SENSOR_OUTPUT=$(dumpsys sensorservice 2>/dev/null | grep -E '0x[0-9a-f]+\\)')
if echo "$SENSOR_OUTPUT" | grep -i "ACCELEROMETER" | grep -v "UNCALI" | head -1 | grep -q .; then
    ACC_NAME=$(echo "$SENSOR_OUTPUT" | grep -i "ACCELEROMETER" | grep -v "UNCALI" | head -1 | sed 's/.*| //' | awk '{print $1}')
    log_pass "Accelerometer: $ACC_NAME"
else
    log_fail "Accelerometer: NOT FOUND"
fi
if echo "$SENSOR_OUTPUT" | grep -i "GYROSCOPE" | grep -v "UNCALI" | head -1 | grep -q .; then
    GYRO_NAME=$(echo "$SENSOR_OUTPUT" | grep -i "GYROSCOPE" | grep -v "UNCALI" | head -1 | sed 's/.*| //' | awk '{print $1}')
    log_pass "Gyroscope: $GYRO_NAME"
else
    log_fail "Gyroscope: NOT FOUND"
fi
if echo "$SENSOR_OUTPUT" | grep -i "LIGHT" | head -1 | grep -q .; then
    LIGHT_NAME=$(echo "$SENSOR_OUTPUT" | grep -i "LIGHT" | head -1 | sed 's/.*| //' | awk '{print $1}')
    log_pass "Light Sensor: $LIGHT_NAME"
else
    log_fail "Light Sensor: NOT FOUND"
fi
if echo "$SENSOR_OUTPUT" | grep -i "PROXIMITY" | head -1 | grep -q .; then
    PROX_NAME=$(echo "$SENSOR_OUTPUT" | grep -i "PROXIMITY" | head -1 | sed 's/.*| //' | awk '{print $1}')
    log_pass "Proximity Sensor: $PROX_NAME"
else
    log_fail "Proximity Sensor: NOT FOUND"
fi
SENSOR_COUNT=$(echo "$SENSOR_OUTPUT" | grep -c "0x")
log_info "Total sensors: $SENSOR_COUNT"
SAR_FOUND=0
SAR_NAME=""
if echo "$SENSOR_OUTPUT" | grep -i "SAR" | head -1 | grep -q .; then
    SAR_NAME=$(echo "$SENSOR_OUTPUT" | grep -i "SAR" | head -1 | sed 's/.*| //' | awk '{print $1}')
    log_pass "SAR Sensor: $SAR_NAME"
    SAR_FOUND=1
else
    SAR_I2C=$(cat /sys/bus/i2c/devices/*/name 2>/dev/null | grep -i sar | head -1)
    if [ -n "$SAR_I2C" ]; then
        log_pass "SAR Sensor: $SAR_I2C (I2C)"
        SAR_FOUND=1
        SAR_NAME="$SAR_I2C"
    else
        log_info "SAR Sensor: NOT FOUND (optional device)"
    fi
fi
echo "" | tee -a $RESULT_FILE
log_info "=== 2. Camera Devices Check ==="
CAM_I2C_LIST=$(cat /sys/bus/i2c/devices/*/name 2>/dev/null)
if echo "$CAM_I2C_LIST" | grep -q "camera_main$"; then
    log_pass "Main Camera (main1): camera_main"
else
    log_fail "Main Camera (main1): NOT FOUND"
fi
if echo "$CAM_I2C_LIST" | grep -q "camera_main_two"; then
    log_pass "Second Camera (main2): camera_main_two"
else
    log_fail "Second Camera (main2): NOT FOUND"
fi
if echo "$CAM_I2C_LIST" | grep -q "camera_sub$"; then
    log_pass "Front Camera (sub): camera_sub"
else
    log_fail "Front Camera (sub): NOT FOUND"
fi
SENINF_COUNT=$(ls -d /sys/devices/platform/*seninf* 2>/dev/null | wc -l)
if [ $SENINF_COUNT -ge 1 ]; then
    log_pass "Camera SENINF: $SENINF_COUNT found"
else
    log_fail "Camera SENINF: NOT FOUND"
fi
VIDEO_COUNT=$(ls /dev/video* 2>/dev/null | wc -l)
if [ $VIDEO_COUNT -gt 0 ]; then
    log_pass "Video nodes: $VIDEO_COUNT found"
else
    log_fail "Video nodes: NOT FOUND"
fi
echo "" | tee -a $RESULT_FILE
log_info "=== 3. Touch Panel Check ==="
TP_FOUND=0
if [ -d "/sys/devices/platform/touch" ]; then
    log_pass "Touch platform: OK"
    TP_FOUND=1
fi
if [ -d "/sys/devices/platform/mtk-tpd" ]; then
    log_pass "MTK TPD: OK"
    TP_FOUND=1
fi
if [ $TP_FOUND -eq 0 ]; then
    log_fail "Touch platform: NOT FOUND"
fi
TP_INPUT=0
for dev in /dev/input/event*; do
    if [ -e "$dev" ] && getevent -lp $dev 2>/dev/null | grep -q "ABS_MT"; then
        log_pass "Touch input: $dev"
        TP_INPUT=1
        break
    fi
done
if [ $TP_INPUT -eq 0 ]; then
    log_fail "Touch input: NOT FOUND"
fi
echo "" | tee -a $RESULT_FILE
log_info "=== 4. LCD Display Check ==="
MTK_FB_FOUND=0
for fb_path in /sys/devices/platform/mtkfb* /sys/devices/platform/*.mtkfb* /sys/devices/platform/soc/*.mtkfb*; do
    if [ -d "$fb_path" ] 2>/dev/null; then
        log_pass "MTK framebuffer: OK ($fb_path)"
        MTK_FB_FOUND=1
        break
    fi
done
if [ $MTK_FB_FOUND -eq 0 ]; then
    if [ -d /sys/class/graphics/fb0 ]; then
        log_pass "MTK framebuffer: OK (fb0 exists)"
        MTK_FB_FOUND=1
    else
        log_fail "MTK framebuffer: NOT FOUND"
    fi
fi
if [ -d /sys/class/graphics/fb0 ]; then
    FB_NAME=$(cat /sys/class/graphics/fb0/name 2>/dev/null || echo "default")
    log_pass "Framebuffer fb0: $FB_NAME"
else
    DRM_COUNT=$(ls /dev/dri/card* 2>/dev/null | wc -l)
    if [ $DRM_COUNT -gt 0 ]; then
        log_pass "Framebuffer fb0: DRM mode ($DRM_COUNT cards)"
    else
        log_fail "Framebuffer fb0: NOT FOUND"
    fi
fi
echo "" | tee -a $RESULT_FILE
log_info "=== 5. Audio Devices Check ==="
AUDIO_FOUND=0
if [ -d "/sys/devices/platform/11220000.audio" ]; then
    log_pass "Audio codec: OK"
    AUDIO_FOUND=1
fi
PCM_COUNT=$(ls /dev/snd/pcm* 2>/dev/null | wc -l)
if [ $PCM_COUNT -gt 0 ]; then
    log_pass "Audio PCM devices: $PCM_COUNT"
else
    log_fail "Audio PCM devices: NOT FOUND"
fi
echo "" | tee -a $RESULT_FILE
log_info "=== 6. Charger & Power Check ==="
CHARGER_FOUND=0
for node in charger mt_charger lk_charger; do
    if [ -d "/sys/devices/platform/$node" ]; then
        log_pass "Charger: $node"
        CHARGER_FOUND=1
        break
    fi
done
if [ $CHARGER_FOUND -eq 0 ]; then
    log_fail "Charger: NOT FOUND"
fi
POWER_COUNT=$(ls /sys/class/power_supply/ 2>/dev/null | wc -l)
if [ $POWER_COUNT -gt 0 ]; then
    log_pass "Power supplies: $POWER_COUNT"
    if [ -d "/sys/class/power_supply/battery" ]; then
        BAT_CAP=$(cat /sys/class/power_supply/battery/capacity 2>/dev/null)
        BAT_STATUS=$(cat /sys/class/power_supply/battery/status 2>/dev/null)
        log_info "Battery: $BAT_CAP%, $BAT_STATUS"
    fi
else
    log_fail "Power supply: NOT FOUND"
fi
echo "" | tee -a $RESULT_FILE
log_info "=== 7. I2C Devices Summary ==="
I2C_COUNT=$(cat /sys/bus/i2c/devices/*/name 2>/dev/null | grep -v "^i2c-mt65xx$" | grep -v "^ccu_" | wc -l)
if [ $I2C_COUNT -gt 0 ]; then
    log_pass "I2C devices: $I2C_COUNT"
else
    log_fail "I2C devices: NOT FOUND"
fi
echo "" | tee -a $RESULT_FILE
log_info "=== 8. Kernel Error Check ==="
ERROR_COUNT=$(dmesg 2>/dev/null | grep -iE "error|fail" | grep -v "rfkill" | wc -l)
if [ $ERROR_COUNT -gt 20 ]; then
    log_warn "Kernel errors: $ERROR_COUNT (check dmesg)"
else
    log_pass "Kernel errors: $ERROR_COUNT (acceptable)"
fi
echo "" | tee -a $RESULT_FILE
{
    echo "=== Device State - $(date) ==="
    echo "Sensors:"
    dumpsys sensorservice 2>/dev/null | grep -E '0x[0-9a-f]+\\)' | grep -E "ACCELEROMETER|GYROSCOPE|LIGHT|PROXIMITY"
    echo ""
    echo "SAR_FOUND=$SAR_FOUND"
    if [ $SAR_FOUND -eq 1 ]; then
        echo "SAR: $SAR_NAME"
    fi
    echo ""
    echo "I2C Devices:"
    cat /sys/bus/i2c/devices/*/name 2>/dev/null | sort
    echo ""
    echo "Camera:"
    cat /sys/bus/i2c/devices/*/name 2>/dev/null | grep -E "camera_main$|camera_main_two|camera_sub$"
    ls -d /sys/devices/platform/*seninf* 2>/dev/null
    echo ""
    echo "Video:"
    ls /dev/video* 2>/dev/null
    echo ""
    echo "Touch:"
    ls -d /sys/devices/platform/touch* 2>/dev/null
    echo ""
    echo "Display:"
    ls -d /sys/devices/platform/mtkfb* /sys/devices/platform/dispsys 2>/dev/null
} > $CURRENT_FILE
if [ -f $BASELINE_FILE ]; then
    log_info "=== Comparing with Baseline ==="
    BASELINE_SAR=$(grep "SAR_FOUND=" $BASELINE_FILE | cut -d= -f2)
    if [ "$BASELINE_SAR" = "0" ]; then
        grep -v "SAR" $BASELINE_FILE > /tmp/baseline_cmp.txt
        grep -v "SAR" $CURRENT_FILE > /tmp/current_cmp.txt
    else
        cp $BASELINE_FILE /tmp/baseline_cmp.txt
        cp $CURRENT_FILE /tmp/current_cmp.txt
    fi
    if diff /tmp/baseline_cmp.txt /tmp/current_cmp.txt >/dev/null 2>&1; then
        log_pass "All devices match baseline"
    else
        REMOVED=$(diff /tmp/baseline_cmp.txt /tmp/current_cmp.txt 2>/dev/null | grep "^<" | wc -l)
        ADDED=$(diff /tmp/baseline_cmp.txt /tmp/current_cmp.txt 2>/dev/null | grep "^>" | wc -l)
        if [ $REMOVED -gt 0 ]; then
            log_fail "Devices REMOVED: $REMOVED"
        fi
        if [ $ADDED -gt 0 ]; then
            log_warn "Devices ADDED: $ADDED"
        fi
    fi
    rm -f /tmp/baseline_cmp.txt /tmp/current_cmp.txt
else
    cp $CURRENT_FILE $BASELINE_FILE
    log_pass "Baseline created"
fi
echo "" | tee -a $RESULT_FILE
log_info "=== Summary ==="
PASS_COUNT=$(grep -c "\\[PASS\\]" $RESULT_FILE)
FAIL_COUNT=$(grep -c "\\[FAIL\\]" $RESULT_FILE)
WARN_COUNT=$(grep -c "\\[WARN\\]" $RESULT_FILE)
echo "PASS: $PASS_COUNT" | tee -a $RESULT_FILE
echo "FAIL: $FAIL_COUNT" | tee -a $RESULT_FILE
echo "WARN: $WARN_COUNT" | tee -a $RESULT_FILE
echo "" | tee -a $RESULT_FILE
if [ $FAIL_COUNT -eq 0 ]; then
    echo "Result: SUCCESS" | tee -a $RESULT_FILE
    exit 0
else
    echo "Result: FAILED ($FAIL_COUNT failures)" | tee -a $RESULT_FILE
    exit 1
fi
'''

def push_device_check_script(device):
    """推送器件检测脚本到设备"""
    log_print(device, "推送器件检测脚本...", Fore.CYAN)
    script_content = create_device_check_script()
    local_script = f"mtk_device_check_{device}.sh"
    
    try:
        with open(local_script, 'w', encoding='utf-8', newline='\n') as f:
            f.write(script_content)
        
        result = subprocess.run(['adb', '-s', device, 'push', local_script, DEVICE_CHECK_SCRIPT_PATH],
                               capture_output=True, text=True, timeout=30)
        if result.returncode != 0:
            log_print(device, f"推送脚本失败: {result.stderr}", Fore.RED)
            return False
        
        subprocess.run(['adb', '-s', device, 'shell', 'chmod', '755', DEVICE_CHECK_SCRIPT_PATH],
                      capture_output=True, timeout=10)
        
        os.remove(local_script)
        log_print(device, "器件检测脚本推送成功", Fore.GREEN)
        return True
    except Exception as e:
        log_print(device, f"推送脚本异常: {e}", Fore.RED)
        if os.path.exists(local_script):
            os.remove(local_script)
        return False

def run_device_check(device, iteration):
    """运行器件检测并返回结果"""
    log_print(device, f"执行器件检测 (第 {iteration} 次)...", Fore.CYAN)
    
    try:
        result = subprocess.run(['adb', '-s', device, 'shell', DEVICE_CHECK_SCRIPT_PATH],
                               capture_output=True, text=True, timeout=120)
        output = result.stdout
        
        # 分析结果
        pass_count = output.count('[PASS]')
        fail_count = output.count('[FAIL]')
        warn_count = output.count('[WARN]')
        
        # 提取失败项
        failed_items = []
        for line in output.split('\n'):
            if '[FAIL]' in line:
                failed_items.append(line.replace('[FAIL]', '').strip())
        
        log_print(device, f"检测结果: PASS={pass_count}, FAIL={fail_count}, WARN={warn_count}", 
                 Fore.GREEN if fail_count == 0 else Fore.RED)
        
        if failed_items:
            for item in failed_items:
                log_print(device, f"  失败项: {item}", Fore.RED)
        
        return fail_count == 0, {'pass': pass_count, 'fail': fail_count, 'warn': warn_count, 'failed_items': failed_items}
    
    except subprocess.TimeoutExpired:
        log_print(device, "器件检测超时", Fore.RED)
        return False, {'pass': 0, 'fail': 1, 'warn': 0, 'failed_items': ['检测超时']}
    except Exception as e:
        log_print(device, f"器件检测异常: {e}", Fore.RED)
        return False, {'pass': 0, 'fail': 1, 'warn': 0, 'failed_items': [str(e)]}

def clear_device_check_baseline(device):
    """清除设备上的基准文件（用于首次运行）"""
    subprocess.run(['adb', '-s', device, 'shell', 'rm', '-rf', DEVICE_CHECK_LOG_DIR],
                  capture_output=True, timeout=10)

def quick_click_by_text(device, text, timeout=5):
    """快速点击指定text的元素"""
    start_time = time.time()
    while time.time() - start_time < timeout:
        try:
            subprocess.run(['adb', '-s', device, 'shell', 'uiautomator', 'dump'], 
                          capture_output=True, text=True, timeout=3)
            result = subprocess.run(['adb', '-s', device, 'shell', 'cat', '/sdcard/window_dump.xml'],
                                    capture_output=True, text=True, encoding='utf-8', timeout=3)
            if result.returncode == 0:
                xml_content = result.stdout
                tree = ET.ElementTree(ET.fromstring(xml_content))
                for element in tree.iter('node'):
                    if element.get('text') == text:
                        bounds = element.get('bounds')
                        bounds = bounds.strip('[]').split('][')
                        left_x, top_y = map(int, bounds[0].split(','))
                        right_x, bottom_y = map(int, bounds[1].split(','))
                        mid_x = (left_x + right_x) // 2
                        mid_y = (top_y + bottom_y) // 2
                        subprocess.run(['adb', '-s', device, 'shell', f'input tap {mid_x} {mid_y}'])
                        return True
        except:
            pass
        time.sleep(0.5)
    return False

def quick_click_element(device, element_type, element_value, timeout=5):
    """根据类型快速点击元素（支持resource-id、text和text_ignore_case）"""
    if element_type == "resource-id":
        return quick_click_by_resource_id(device, element_value, timeout)
    elif element_type == "text":
        return quick_click_by_text(device, element_value, timeout)
    elif element_type == "text_ignore_case":
        return quick_click_by_text_ignore_case(device, element_value, timeout)
    return False

def check_element_exists_by_type(device, element_type, element_value, timeout=3):
    """根据类型检查元素是否存在（支持resource-id、text和text_ignore_case）"""
    start_time = time.time()
    text_lower = element_value.lower() if element_type == "text_ignore_case" else None
    while time.time() - start_time < timeout:
        try:
            subprocess.run(['adb', '-s', device, 'shell', 'uiautomator', 'dump'],
                          capture_output=True, text=True, timeout=3)
            result = subprocess.run(['adb', '-s', device, 'shell', 'cat', '/sdcard/window_dump.xml'],
                                    capture_output=True, text=True, encoding='utf-8', timeout=3)
            if result.returncode == 0:
                xml_content = result.stdout
                tree = ET.ElementTree(ET.fromstring(xml_content))
                for element in tree.iter('node'):
                    if element_type == "resource-id" and element.get('resource-id') == element_value:
                        return True
                    if element_type == "text" and element.get('text') == element_value:
                        return True
                    if element_type == "text_ignore_case":
                        element_text = element.get('text', '')
                        if element_text and element_text.lower() == text_lower:
                            return True
        except Exception:
            pass
        time.sleep(0.5)
    return False

def wait_and_click_element_by_type(device, element_type, element_value, timeout=5):
    """等待控件出现后立即点击（支持resource-id、text和text_ignore_case）"""
    result = wait_and_click_element_by_type_u2(device, element_type, element_value, timeout)
    if result is True:
        return True
    if result is None:
        return wait_and_click_element_by_type_adb(device, element_type, element_value, timeout)
    return wait_and_click_element_by_type_adb(device, element_type, element_value, min(2, timeout))

def wait_and_click_element_by_type_u2(device, element_type, element_value, timeout=5):
    """使用uiautomator2等待并点击"""
    d = get_u2_device(device)
    if not d:
        return None
    try:
        d.wait_idle(timeout=timeout)
    except Exception:
        pass
    try:
        if element_type == "resource-id":
            selector = d(resourceId=element_value)
            if u2_click_selector(selector, timeout):
                return True
            if u2_click_xpath(d, '//*[@resource-id="{}"]'.format(element_value), timeout):
                return True
            return False
        if element_type == "text":
            selector = d(text=element_value)
            if u2_click_selector(selector, timeout):
                return True
            if u2_click_xpath(d, '//*[@text="{}"]'.format(element_value), timeout):
                return True
            return False
        if element_type == "text_ignore_case":
            pattern = "(?i)^" + re.escape(element_value) + "$"
            selector = d(textMatches=pattern)
            if u2_click_selector(selector, timeout):
                return True
            return False
    except Exception:
        return None
    return False

def wait_and_click_element_by_type_adb(device, element_type, element_value, timeout=5):
    """使用ADB+uiautomator dump等待并点击"""
    start_time = time.time()
    text_lower = element_value.lower() if element_type == "text_ignore_case" else None
    while time.time() - start_time < timeout:
        try:
            subprocess.run(['adb', '-s', device, 'shell', 'uiautomator', 'dump'],
                          capture_output=True, text=True, timeout=3)
            result = subprocess.run(['adb', '-s', device, 'shell', 'cat', '/sdcard/window_dump.xml'],
                                    capture_output=True, text=True, encoding='utf-8', timeout=3)
            if result.returncode == 0:
                xml_content = result.stdout
                tree = ET.ElementTree(ET.fromstring(xml_content))
                for element in tree.iter('node'):
                    matched = False
                    if element_type == "resource-id" and element.get('resource-id') == element_value:
                        matched = True
                    elif element_type == "text" and element.get('text') == element_value:
                        matched = True
                    elif element_type == "text_ignore_case":
                        element_text = element.get('text', '')
                        if element_text and element_text.lower() == text_lower:
                            matched = True
                    if matched:
                        bounds = element.get('bounds')
                        if not bounds:
                            continue
                        bounds = bounds.strip('[]').split('][')
                        left_x, top_y = map(int, bounds[0].split(','))
                        right_x, bottom_y = map(int, bounds[1].split(','))
                        mid_x = (left_x + right_x) // 2
                        mid_y = (top_y + bottom_y) // 2
                        subprocess.run(['adb', '-s', device, 'shell', f'input tap {mid_x} {mid_y}'])
                        return True
        except Exception:
            pass
        time.sleep(0.5)
    return False

def quick_click_by_text_ignore_case(device, text, timeout=5):
    """快速点击指定text的元素（不区分大小写）"""
    start_time = time.time()
    text_lower = text.lower()
    while time.time() - start_time < timeout:
        try:
            subprocess.run(['adb', '-s', device, 'shell', 'uiautomator', 'dump'], 
                          capture_output=True, text=True, timeout=3)
            result = subprocess.run(['adb', '-s', device, 'shell', 'cat', '/sdcard/window_dump.xml'],
                                    capture_output=True, text=True, encoding='utf-8', timeout=3)
            if result.returncode == 0:
                xml_content = result.stdout
                tree = ET.ElementTree(ET.fromstring(xml_content))
                for element in tree.iter('node'):
                    element_text = element.get('text', '')
                    if element_text and element_text.lower() == text_lower:
                        bounds = element.get('bounds')
                        bounds = bounds.strip('[]').split('][')
                        left_x, top_y = map(int, bounds[0].split(','))
                        right_x, bottom_y = map(int, bounds[1].split(','))
                        mid_x = (left_x + right_x) // 2
                        mid_y = (top_y + bottom_y) // 2
                        subprocess.run(['adb', '-s', device, 'shell', f'input tap {mid_x} {mid_y}'])
                        return True
        except:
            pass
        time.sleep(0.5)
    return False

def get_factory_reset_steps(device):
    """根据设备品牌获取恢复出厂设置按钮点击步骤"""
    brand = get_device_brand(device)
    factory_reset_buttons = CONFIG.get('factory_reset_buttons', {})
    
    if brand in factory_reset_buttons:
        return factory_reset_buttons[brand]['steps']
    
    return factory_reset_buttons.get('default', {}).get('steps', [
        {"type": "text_ignore_case", "value": "Erase all data"},
        {"type": "text_ignore_case", "value": "Erase all data"}
    ])

def get_adb_device_state(device):
    """从adb devices中获取设备状态，未找到返回None"""
    try:
        result = subprocess.run(['adb', 'devices'], capture_output=True, text=True)
    except Exception:
        return None
    if result.returncode != 0:
        return None
    for line in result.stdout.splitlines():
        line = line.strip()
        if not line or line.lower().startswith('list of devices'):
            continue
        parts = line.split()
        if parts and parts[0] == device:
            return parts[1] if len(parts) > 1 else ""
    return None

def check_device_disconnected(device, timeout=5):
    """检查设备是否在指定时间内断开连接"""
    start_time = time.time()
    while time.time() - start_time < timeout:
        state = get_adb_device_state(device)
        if state is None:
            return True
        if state.lower() != "device":
            return True
        state_result = subprocess.run(['adb', '-s', device, 'get-state'], capture_output=True, text=True)
        if state_result.returncode != 0:
            return True
        time.sleep(1)
    return False

def save_device_screenshot(device, suffix="debug"):
    """保存设备截图到log目录（便于调试）"""
    try:
        os.makedirs('log', exist_ok=True)
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        filename = f"log/{device}_{suffix}_{timestamp}.png"

        # 在设备上截图
        subprocess.run(
            ['adb', '-s', device, 'shell', 'screencap', '-p', '/sdcard/debug_screenshot.png'],
            capture_output=True, timeout=10
        )
        # 拉取到本地
        subprocess.run(
            ['adb', '-s', device, 'pull', '/sdcard/debug_screenshot.png', filename],
            capture_output=True, timeout=10
        )
        log_print(device, f"截图已保存: {filename}", Fore.CYAN)
        return True
    except Exception as e:
        log_print(device, f"截图保存失败: {e}", Fore.YELLOW)
        return False

def factory_reset_via_ui(device):
    """通过UI方式执行恢复出厂设置"""
    log_print(device, "尝试通过UI方式恢复出厂设置...", Fore.YELLOW)

    # 打开恢复出厂设置页面
    subprocess.run(f"adb -s {device} shell am start -n com.android.settings/.Settings\\$FactoryResetActivity",
                   shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

    # 智能等待页面加载（替代固定 sleep(2)，最长等待20秒）
    log_print(device, "等待设置页面加载...", Fore.CYAN)
    page_loaded = False
    for _ in range(20):  # 最长等待20秒
        try:
            current_focus = get_foreground_activity_line(device)
            if current_focus and ("Settings" in current_focus or "FactoryReset" in current_focus):
                page_loaded = True
                log_print(device, "设置页面已加载", Fore.GREEN)
                break
        except Exception:
            pass
        time.sleep(1)

    if not page_loaded:
        log_print(device, "设置页面加载检测超时，继续尝试点击...", Fore.YELLOW)

    # 获取该品牌对应的恢复出厂设置按钮点击步骤
    reset_steps = get_factory_reset_steps(device)
    log_print(device, f"恢复出厂设置步骤: {len(reset_steps)} 步", Fore.CYAN)
    
    # 执行点击步骤（超时从10s增加到30s，应对高负载设备）
    for step_idx, step in enumerate(reset_steps, start=1):
        time.sleep(1)
        log_print(device, f"点击第{step_idx}步: {step['type']}={step['value']}...")
        if not quick_click_element(device, step['type'], step['value'], timeout=30):
            log_print(device, f"未找到元素: {step['value']}", Fore.RED)
            # 保存截图以便排查问题
            save_device_screenshot(device, f"factory_reset_step{step_idx}_fail")
            return False
    
    return True

def get_reboot_steps(device):
    """根据设备品牌获取重启按钮点击步骤"""
    brand = get_device_brand(device)
    log_print(device, f"设备品牌: {brand}", Fore.CYAN)
    
    reboot_buttons = CONFIG.get('reboot_buttons', {})
    
    # 查找匹配的品牌配置
    if brand in reboot_buttons:
        return reboot_buttons[brand]['steps']
    
    # 使用默认配置
    return reboot_buttons.get('default', {}).get('steps', [
        {"type": "resource-id", "value": "com.android.systemui:id/reset"},
        {"type": "resource-id", "value": "com.android.systemui:id/reset"}
    ])

def tap_screen(device, x, y):
    subprocess.run(['adb', '-s', device, 'shell', 'input', 'tap', str(x), str(y)])

def find_text_scroll_coordinates(text, device, max_scroll=10):
    scroll_count = 0
    while scroll_count < max_scroll:
        result_dump = subprocess.run(
            ['adb', '-s', device, 'shell', 'uiautomator', 'dump'],
            capture_output=True, text=True
        )
        if result_dump.returncode != 0:
            print('Failed to execute uiautomator dump.')
            return None
        time.sleep(1)
        result_cat = subprocess.run(
            ['adb', '-s', device, 'shell', 'cat', '/sdcard/window_dump.xml'],
            capture_output=True, text=True, encoding='utf-8'
        )
        if result_cat.returncode != 0:
            print('Error reading window_dump.xml.')
            return None
        xml_content = result_cat.stdout
        try:
            tree = ET.ElementTree(ET.fromstring(xml_content))
        except ET.ParseError as e:
            print(f'Error parsing XML: {e}')
            return None
        matches = tree.findall(".//node[@text='" + text + "']")
        if matches:
            for element in matches:
                bounds = element.get('bounds')
                mid = extract_coordinates(bounds)
                if mid:
                    tap_coordinate(device, *mid)
                    return mid
            return matches[0].get('bounds')
        scroll(device)
        scroll_count += 1
        print(f'Scrolled {scroll_count} times.')
    print('Reached maximum scroll attempts. Text not found.')
    return None

def extract_coordinates(bounds):
    match = re.match(r'\[(\d+),(\d+)\]\[(\d+),(\d+)\]', bounds)
    if match:
        left_x, top_y, right_x, bottom_y = map(int, match.groups())
        mid_x = (left_x + right_x) // 2
        mid_y = (top_y + bottom_y) // 2
        return (mid_x, mid_y)
    return None

def tap_coordinate(device, x, y):
    subprocess.run(['adb', '-s', device, 'shell', f'input tap {x} {y}'])

def scroll(device):
    screen_info = subprocess.run(['adb', '-s', device, 'shell', 'wm', 'size'], capture_output=True, text=True)
    match = re.search(r'(\d+)x(\d+)', screen_info.stdout)
    if match:
        width, height = map(int, match.groups())
        start_x = width // 2
        start_y = 1020
        end_y = 800
    else:
        start_x, start_y, end_y = 500, 1020, 200
    subprocess.run(['adb', '-s', device, 'shell', 'input', 'swipe', str(start_x), str(start_y), str(start_x), str(end_y), '300'])

def find_text_coordinate(text, device):
    time.sleep(3)
    subprocess.run(['adb', '-s', device, 'shell', 'uiautomator', 'dump'], capture_output=True, text=True)
    time.sleep(2)
    result = subprocess.run(['adb', '-s', device, 'shell', 'cat', '/sdcard/window_dump.xml'],
                            capture_output=True, text=True, encoding='utf-8')
    if result.returncode == 0:
        xml_content = result.stdout
        tree = ET.ElementTree(ET.fromstring(xml_content))
        for element in tree.iter('node'):
            if element.get('text') == text:
                bounds = element.get('bounds')
                bounds = bounds.strip('[]').split('][')
                left_x, top_y = map(int, bounds[0].split(','))
                right_x, bottom_y = map(int, bounds[1].split(','))
                mid_x = (left_x + right_x) // 2
                mid_y = (top_y + bottom_y) // 2
                subprocess.run(['adb', '-s', device, 'shell', f'input tap {mid_x} {mid_y}'])
                return mid_x, mid_y
    else:
        print('Error occurred while reading file.')
        return None


def find_Contain_desc_coordinate(desc, device):
    time.sleep(3)
    subprocess.run(['adb', '-s', device, 'shell', 'uiautomator', 'dump'], capture_output=True, text=True)
    time.sleep(2)
    result = subprocess.run(['adb', '-s', device, 'shell', 'cat', '/sdcard/window_dump.xml'],
                            capture_output=True, text=True, encoding='utf-8')
    if result.returncode == 0:
        xml_content = result.stdout
        tree = ET.ElementTree(ET.fromstring(xml_content))
        for element in tree.iter('node'):
            if desc in element.get('content-desc', ''):
                bounds = element.get('bounds')
                bounds = bounds.strip('[]').split('][')
                left_x, top_y = map(int, bounds[0].split(','))
                right_x, bottom_y = map(int, bounds[1].split(','))
                mid_x = (left_x + right_x) // 2
                mid_y = (top_y + bottom_y) // 2
                subprocess.run(['adb', '-s', device, 'shell', f'input tap {mid_x} {mid_y}'])
                return mid_x, mid_y
    else:
        print('Error occurred while reading file.')
        return None

def find_Contain_text_coordinate(text, device):
    time.sleep(3)
    subprocess.run(['adb', '-s', device, 'shell', 'uiautomator', 'dump'], capture_output=True, text=True)
    time.sleep(2)
    result = subprocess.run(['adb', '-s', device, 'shell', 'cat', '/sdcard/window_dump.xml'],
                            capture_output=True, text=True, encoding='utf-8')
    if result.returncode == 0:
        xml_content = result.stdout
        tree = ET.ElementTree(ET.fromstring(xml_content))
        for element in tree.iter('node'):
            if text in element.get('text', ''):
                bounds = element.get('bounds')
                bounds = bounds.strip('[]').split('][')
                left_x, top_y = map(int, bounds[0].split(','))
                right_x, bottom_y = map(int, bounds[1].split(','))
                mid_x = (left_x + right_x) // 2
                mid_y = (top_y + bottom_y) // 2
                subprocess.run(['adb', '-s', device, 'shell', f'input tap {mid_x} {mid_y}'])
                return mid_x, mid_y
    else:
        print('Error occurred while reading file.')
        return None

def find_res_coordinate(resource, device):
    time.sleep(3)
    subprocess.run(['adb', '-s', device, 'shell', 'uiautomator', 'dump'], capture_output=True, text=True)
    time.sleep(2)
    result = subprocess.run(['adb', '-s', device, 'shell', 'cat', '/sdcard/window_dump.xml'],
                            capture_output=True, text=True, encoding='utf-8')
    if result.returncode == 0:
        xml_content = result.stdout
        tree = ET.ElementTree(ET.fromstring(xml_content))
        for element in tree.iter('node'):
            if element.get('resource-id') == resource:
                bounds = element.get('bounds')
                bounds = bounds.strip('[]').split('][')
                left_x, top_y = map(int, bounds[0].split(','))
                right_x, bottom_y = map(int, bounds[1].split(','))
                mid_x = (left_x + right_x) // 2
                mid_y = (top_y + bottom_y) // 2
                subprocess.run(['adb', '-s', device, 'shell', f'input tap {mid_x} {mid_y}'])
                return mid_x, mid_y
    else:
        print('Error occurred while reading file.')
        return None

def get_power_event_node(device):
    """扫描设备输出，自动定位电源键对应的 event 节点"""
    try:
        output = subprocess.check_output(f"adb -s {device} shell getevent -p", shell=True).decode('utf-8')
        device_blocks = output.split("add device")
        for block in device_blocks:
            if "0074" in block:
                match = re.search(r'(/dev/input/event\d+)', block)
                if match:
                    return match.group(1)
    except Exception as e:
        print(f"检测电源键节点失败: {e}")
    return None

def long_press_power_sendevent(device, duration=3):
    """通过sendevent长按电源键"""
    node = get_power_event_node(device)
    if not node:
        print(f"设备 {device} 未发现电源键节点")
        return False
    print(f"设备 {device} 检测到电源键节点: {node}，执行长按 ({duration}s)...")
    commands = [
        f"sendevent {node} 1 116 1",
        f"sendevent {node} 0 0 0",
        f"sleep {duration}",
        f"sendevent {node} 1 116 0",
        f"sendevent {node} 0 0 0"
    ]
    full_cmd = f"adb -s {device} shell \"{' && '.join(commands)}\""
    subprocess.run(full_cmd, shell=True)
    return True

def check_element_exists(device, resource_id):
    """检查指定resource-id的元素是否存在"""
    subprocess.run(['adb', '-s', device, 'shell', 'uiautomator', 'dump'], capture_output=True, text=True)
    time.sleep(1)
    result = subprocess.run(['adb', '-s', device, 'shell', 'cat', '/sdcard/window_dump.xml'],
                            capture_output=True, text=True, encoding='utf-8')
    if result.returncode == 0:
        return resource_id in result.stdout
    return False

def wait_for_device_disconnect(device, timeout=60):
    """等待设备断开ADB连接"""
    print(f"设备 {device} 等待断开连接...")
    start_time = time.time()
    while time.time() - start_time < timeout:
        state = get_adb_device_state(device)
        if state is None or state.lower() != "device":
            print(f"设备 {device} 已断开连接")
            return True
        time.sleep(2)
    print(f"设备 {device} 等待断开超时")
    return False

def wait_for_device(device, timeout=300):
    """等待设备ADB连接就绪"""
    print(f"设备 {device} 等待ADB连接...")
    start_time = time.time()
    while time.time() - start_time < timeout:
        result = subprocess.run(['adb', 'devices'], capture_output=True, text=True)
        if device in result.stdout and 'device' in result.stdout.split(device)[1].split('\n')[0]:
            print(f"设备 {device} ADB已连接")
            return True
        time.sleep(2)
    print(f"设备 {device} 等待连接超时")
    return False

def wait_for_boot_complete(device, timeout=300):
    """等待设备完全启动（sys.boot_completed=1）"""
    print(f"设备 {device} 等待系统启动完成...")
    start_time = time.time()
    while time.time() - start_time < timeout:
        try:
            result = subprocess.run(
                ['adb', '-s', device, 'shell', 'getprop', 'sys.boot_completed'],
                capture_output=True, text=True, timeout=10
            )
            if result.stdout.strip() == '1':
                print(f"设备 {device} 系统启动完成")
                return True
        except (subprocess.TimeoutExpired, subprocess.CalledProcessError):
            pass
        time.sleep(2)
    print(f"设备 {device} 等待启动超时")
    return False

def check_adb_transport_health(device):
    """检查ADB transport是否健康（通过简单的shell命令测试）"""
    try:
        result = subprocess.run(
            ['adb', '-s', device, 'shell', 'true'],
            capture_output=True, text=True, timeout=5
        )
        return result.returncode == 0
    except (subprocess.TimeoutExpired, subprocess.CalledProcessError):
        return False

def recover_adb_transport(device):
    """尝试恢复ADB transport连接"""
    log_print(device, "尝试恢复ADB transport连接...", Fore.YELLOW)
    try:
        # 方法1: 尝试 adb reconnect
        subprocess.run(['adb', '-s', device, 'reconnect'], capture_output=True, timeout=10)
        time.sleep(2)
        if check_adb_transport_health(device):
            log_print(device, "通过reconnect恢复连接成功", Fore.GREEN)
            return True
    except Exception:
        pass

    try:
        # 方法2: 重启 adb server
        log_print(device, "重启adb server...", Fore.YELLOW)
        subprocess.run(['adb', 'kill-server'], capture_output=True, timeout=5)
        time.sleep(2)
        subprocess.run(['adb', 'start-server'], capture_output=True, timeout=10)
        time.sleep(3)
        if check_adb_transport_health(device):
            log_print(device, "通过重启adb server恢复连接成功", Fore.GREEN)
            return True
    except Exception:
        pass

    log_print(device, "ADB transport恢复失败", Fore.RED)
    return False

def wait_for_system_ready(device, timeout=120, allow_timeout=True):
    """等待系统服务完全就绪"""
    log_print(device, "等待系统服务就绪...")
    start_time = time.time()
    consecutive_failures = 0  # 连续失败计数器

    while time.time() - start_time < timeout:
        try:
            # 检查开机动画是否停止（超时从5s增加到15s，应对高负载设备）
            bootanim = subprocess.run(
                ['adb', '-s', device, 'shell', 'getprop', 'init.svc.bootanim'],
                capture_output=True, text=True, timeout=15
            )
            # 检查包管理器是否就绪（超时从10s增加到20s，应对高负载设备）
            pm_ready = subprocess.run(
                ['adb', '-s', device, 'shell', 'pm', 'path', 'android'],
                capture_output=True, text=True, timeout=20
            )

            if (bootanim.stdout.strip() == 'stopped' and 'package:' in pm_ready.stdout):
                log_print(device, "系统服务已就绪")
                return True
            consecutive_failures = 0  # 成功执行，重置失败计数器
        except (subprocess.TimeoutExpired, subprocess.CalledProcessError) as e:
            consecutive_failures += 1
            log_print(device, f"检测系统服务时出错: {e}", Fore.YELLOW)

            # 连续失败2次时尝试恢复transport
            if consecutive_failures >= 2:
                if recover_adb_transport(device):
                    consecutive_failures = 0  # 恢复成功，重置计数器
                else:
                    # 恢复失败，等待更长时间再重试
                    time.sleep(5)
        except Exception as e:
            consecutive_failures += 1
            log_print(device, f"检测系统服务异常: {e}", Fore.YELLOW)
        time.sleep(2)
    if allow_timeout:
        log_print(device, "等待系统服务就绪超时，继续执行", Fore.YELLOW)
        return True  # 超时后也继续执行，不阻塞流程
    log_print(device, "等待系统服务就绪超时，终止当前流程", Fore.RED)
    return False

def wait_device_ready(device, timeout=300, wait_disconnect=False):
    """等待设备完全就绪（ADB连接 + 系统启动完成）"""
    if wait_disconnect:
        # 先等待设备断开连接
        wait_for_device_disconnect(device, timeout=60)
    wait_for_device(device, timeout)
    wait_for_boot_complete(device, timeout)
    time.sleep(5)  # 额外等待UI完全加载

def get_setting_value(device, namespace, key, timeout=5):
    """获取系统设置值（失败返回None）"""
    try:
        result = subprocess.run(
            ['adb', '-s', device, 'shell', 'settings', 'get', namespace, key],
            capture_output=True, text=True, timeout=timeout
        )
        if result.returncode != 0:
            return None
        value = result.stdout.strip()
        return value if value else None
    except Exception:
        return None

def is_oobe_completed(device):
    """判断开机向导是否完成"""
    user_setup = get_setting_value(device, "secure", "user_setup_complete")
    device_prov = get_setting_value(device, "global", "device_provisioned")
    return user_setup == "1" and device_prov == "1"

def get_foreground_activity_line(device):
    """获取前台Activity信息"""
    try:
        result = subprocess.run(
            ['adb', '-s', device, 'shell', 'dumpsys', 'activity', 'activities'],
            capture_output=True, text=True, timeout=10
        )
        if result.returncode == 0:
            for line in result.stdout.splitlines():
                if "mResumedActivity" in line or "topResumedActivity" in line:
                    return line.strip()
        result = subprocess.run(
            ['adb', '-s', device, 'shell', 'dumpsys', 'window'],
            capture_output=True, text=True, timeout=10
        )
        if result.returncode == 0:
            for line in result.stdout.splitlines():
                if "mCurrentFocus" in line or "mFocusedApp" in line:
                    return line.strip()
    except Exception:
        pass
    return ""

def extract_package_from_activity_line(line):
    """从Activity信息中提取包名"""
    if not line:
        return None
    match = re.search(r"([A-Za-z0-9_\\.]+)/(?:[A-Za-z0-9_\\.\\$]+)", line)
    if match:
        return match.group(1)
    return None

def is_setupwizard_line(line):
    """判断是否处于开机向导界面"""
    if not line:
        return False
    lower_line = line.lower()
    return any(keyword in lower_line for keyword in SETUP_WIZARD_KEYWORDS)

def is_setupwizard_active(device):
    """判断当前前台是否为开机向导"""
    return is_setupwizard_line(get_foreground_activity_line(device))

def get_home_package(device):
    """获取桌面启动器包名"""
    try:
        result = subprocess.run(
            ['adb', '-s', device, 'shell', 'cmd', 'package', 'resolve-activity',
             '-a', 'android.intent.action.MAIN', '-c', 'android.intent.category.HOME'],
            capture_output=True, text=True, timeout=10
        )
        if result.returncode == 0:
            match = re.search(r"packageName=([A-Za-z0-9_\\.]+)", result.stdout)
            if match:
                return match.group(1)
            match = re.search(r"name=([A-Za-z0-9_\\.]+)/(?:[A-Za-z0-9_\\.\\$]+)", result.stdout)
            if match:
                return match.group(1)
        result = subprocess.run(
            ['adb', '-s', device, 'shell', 'pm', 'resolve-activity',
             '-a', 'android.intent.action.MAIN', '-c', 'android.intent.category.HOME'],
            capture_output=True, text=True, timeout=10
        )
        if result.returncode == 0:
            match = re.search(r"packageName=([A-Za-z0-9_\\.]+)", result.stdout)
            if match:
                return match.group(1)
            match = re.search(r"name=([A-Za-z0-9_\\.]+)/(?:[A-Za-z0-9_\\.\\$]+)", result.stdout)
            if match:
                return match.group(1)
    except Exception:
        return None
    return None

def wait_for_home_screen(device, timeout=120):
    """等待进入系统主界面"""
    log_print(device, "等待进入系统主界面...", Fore.CYAN)
    home_pkg = get_home_package(device)
    home_pkg_lower = home_pkg.lower() if home_pkg else None
    start_time = time.time()
    last_focus = ""
    check_and_turn_on_screen(device)
    while time.time() - start_time < timeout:
        focus_line = get_foreground_activity_line(device)
        if focus_line:
            last_focus = focus_line
            if not is_setupwizard_line(focus_line):
                focus_lower = focus_line.lower()
                if home_pkg_lower and home_pkg_lower in focus_lower:
                    log_print(device, "已进入系统主界面", Fore.GREEN)
                    return True
                pkg = extract_package_from_activity_line(focus_line)
                if pkg:
                    pkg_lower = pkg.lower()
                    if home_pkg_lower and pkg_lower == home_pkg_lower:
                        log_print(device, "已进入系统主界面", Fore.GREEN)
                        return True
                    if "launcher" in pkg_lower or "home" in pkg_lower:
                        log_print(device, "已进入系统主界面", Fore.GREEN)
                        return True
                if not home_pkg_lower and ("launcher" in focus_lower or "home" in focus_lower):
                    log_print(device, "已进入系统主界面", Fore.GREEN)
                    return True
        else:
            check_and_turn_on_screen(device)
        subprocess.run(CONFIG['adb_commands']['keyevent_home'].format(device=device),
                      shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        time.sleep(2)
    log_print(device, f"等待系统主界面超时，当前焦点: {last_focus}，HOME包: {home_pkg or '未知'}", Fore.YELLOW)
    return False

def ensure_home_ready(device, timeout=120):
    """确保已完成OOBE并进入桌面"""
    if not is_oobe_completed(device) or is_setupwizard_active(device):
        log_print(device, "检测到开机向导/未完成设置，尝试跳过...", Fore.YELLOW)
        if not skip_oobe_via_adb(device):
            return False
    return wait_for_home_screen(device, timeout)

def ensure_device_ready_for_test(device, reason, require_home=True, timeout=None):
    """确保设备满足专项测试的前置条件"""
    ready_timeout = timeout or CONFIG.get('timings', {}).get('device_ready_timeout', 300)
    boot_timeout = CONFIG.get('timings', {}).get('boot_complete_timeout', ready_timeout)
    log_print(device, f"{reason}，等待设备就绪...", Fore.CYAN)
    if not wait_for_device(device, ready_timeout):
        log_print(device, f"{reason}：ADB未就绪", Fore.RED)
        return False
    if not wait_for_boot_complete(device, boot_timeout):
        log_print(device, f"{reason}：系统启动超时", Fore.RED)
        return False
    if not wait_for_system_ready(device, timeout=ready_timeout, allow_timeout=False):
        log_print(device, f"{reason}：系统服务未就绪", Fore.RED)
        return False
    if require_home and not ensure_home_ready(device, timeout=ready_timeout):
        log_print(device, f"{reason}：未进入桌面", Fore.RED)
        return False
    return True

def is_screen_on_from_power_dump(power_output):
    """基于dumpsys power判断屏幕是否点亮（尽量兼容不同Android版本）"""
    if not power_output:
        return False
    lower = power_output.lower()
    if "mwakefulness=awake" in lower or "mwakefulness=dreaming" in lower:
        return True
    if "minteractive=true" in lower or "mscreenonfully=true" in lower:
        return True
    if re.search(r"display power:.*state=on", lower):
        return True
    return False

def check_and_turn_on_screen(device):
    try:
        power_output = subprocess.check_output(
            ['adb', '-s', device, 'shell', 'dumpsys', 'power'],
            text=True, errors='ignore'
        )
    except Exception:
        power_output = ""
    screen_on = is_screen_on_from_power_dump(power_output)
    if not screen_on:
        subprocess.run(['adb', '-s', device, 'shell', 'input', 'keyevent', '224'],
                       stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        time.sleep(0.5)
        try:
            power_output = subprocess.check_output(
                ['adb', '-s', device, 'shell', 'dumpsys', 'power'],
                text=True, errors='ignore'
            )
        except Exception:
            power_output = ""
        screen_on = is_screen_on_from_power_dump(power_output)
        if not screen_on:
            subprocess.run(['adb', '-s', device, 'shell', 'input', 'keyevent', '26'],
                           stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            time.sleep(0.5)
        print(f"设备 {device} 屏幕已唤醒，尝试解锁")
    else:
        print(f"设备 {device} 屏幕已经亮，尝试解锁")
    subprocess.run(['adb', '-s', device, 'shell', 'locksettings', 'set-disabled', 'true'],
                   stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    subprocess.run(['adb', '-s', device, 'shell', 'wm', 'dismiss-keyguard'],
                   stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    subprocess.run(['adb', '-s', device, 'shell', 'input', 'keyevent', '82'],
                   stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    time.sleep(1)
    subprocess.run(['adb', '-s', device, 'shell', 'input', 'keyevent', '82'],
                   stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

def set_screen_timeout(device, timeout_minutes):
    timeout_ms = timeout_minutes
    subprocess.run(['adb', '-s', device, 'shell', 'settings', 'put', 'system', 'screen_off_timeout', str(timeout_ms)])
    subprocess.run(['adb', '-s', device, 'shell', 'cmd', 'overlay', 'enable', 'com.android.internal.systemui.navbar.gestural'])
    print(f"设备 {device} 屏幕超时时间已设置为{Fore.RED}{timeout_minutes}{Style.RESET_ALL}分钟")

def test_log(device):
    commands = CONFIG['log_commands']
    for command in commands:
        subprocess.run(["adb", "-s", device, "shell", command], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    time.sleep(2)
    subprocess.run(f"adb -s {device} shell input keyevent 3", shell=True)
    time.sleep(CONFIG['timings']['medium_wait'])

def skip_oobe_via_adb(device):
    """通过ADB命令跳过开机向导"""
    # 等待系统服务完全就绪
    if not wait_for_system_ready(device, allow_timeout=False):
        log_print(device, "系统服务未就绪，无法跳过开机向导", Fore.RED)
        return False
    
    oobe_cmds = CONFIG['adb_commands']['skip_oobe']
    subprocess.run(CONFIG['adb_commands']['root'].format(device=device), shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    subprocess.run(oobe_cmds['user_setup_complete'].format(device=device), shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    subprocess.run(oobe_cmds['device_provisioned'].format(device=device), shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    subprocess.run(oobe_cmds['system_locales'].format(device=device), shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    subprocess.run(CONFIG['adb_commands']['keyevent_back'].format(device=device), shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    subprocess.run(oobe_cmds['go_home'].format(device=device), shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    log_print(device, "已跳过开机向导")
    return True


def pull_log(device):
    db_history_current_time = time.strftime("%Y-%m-%d_%H-%M-%S", time.localtime())
    db_history_path = os.path.join('log', db_history_current_time)
    os.makedirs(db_history_path, exist_ok=True)
    subprocess.run(['adb', '-s', device, 'pull', '/data/debuglogger', db_history_path])
    subprocess.run(['adb', '-s', device, 'pull', '/sdcard/monkeytest.txt', db_history_path])
    time.sleep(10)

def run_monkey_timed(device, duration_seconds):
    """执行指定时长的monkey测试，到时间后kill进程"""
    log_print(device, f"开始执行 {duration_seconds} 秒 monkey测试...", Fore.CYAN)
    
    # 设置屏幕常亮（禁用屏幕超时）
    subprocess.run(f"adb -s {device} shell svc power stayon true", shell=True, stdout=subprocess.DEVNULL)
    check_and_turn_on_screen(device)
    
    # 启动monkey（设置一个很大的事件数，让它持续运行）
    monkey_cmd = f"adb -s {device} shell monkey -v -v -v --ignore-crashes --ignore-timeouts --ignore-security-exceptions --kill-process-after-error --pct-trackball 0 --pct-nav 0 --pct-majornav 0 --pct-anyevent 0 --pct-syskeys 0 -s 805169 --throttle 1000 999999999"
    
    # 使用Popen启动monkey进程（非阻塞）
    process = subprocess.Popen(monkey_cmd, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    
    # 等待指定时间
    time.sleep(duration_seconds)
    
    # kill monkey进程
    log_print(device, "Monkey时间到，正在停止...", Fore.YELLOW)
    subprocess.run(f"adb -s {device} shell pkill -f com.android.commands.monkey", shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    subprocess.run(f"adb -s {device} shell am force-stop com.android.commands.monkey", shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    
    # 恢复屏幕超时设置
    subprocess.run(f"adb -s {device} shell svc power stayon false", shell=True, stdout=subprocess.DEVNULL)
    
    # 终止本地进程
    try:
        process.terminate()
        process.wait(timeout=5)
    except:
        pass
    
    log_print(device, f"Monkey测试完成（运行 {duration_seconds} 秒）", Fore.GREEN)

# ==================== 专项测试函数 ====================

def recover_device_after_failure(device, recovery_timeout=300):
    """
    专项失败后的设备恢复机制（宽松模式）

    与常规前置检查的区别：
    1. ADB连接检查超时更长（5分钟）
    2. 系统服务检查允许超时继续（allow_timeout=True）
    3. 即使部分步骤失败也会尝试继续，用于最大化无人看护测试的容错性

    返回：
    - True: 设备恢复成功，可以继续下一轮测试
    - False: 设备无响应（可能死机），应终止所有测试
    """
    log_print(device, "开始【失败专项前置检查】（宽松模式，超时5分钟）...", Fore.CYAN)

    # 阶段1: 等待ADB连接（超时5分钟，适用于设备可能卡死的情况）
    log_print(device, "阶段1: 等待ADB连接（超时5分钟）...", Fore.CYAN)
    if not wait_for_device(device, timeout=recovery_timeout):
        log_print(device, "5分钟内无法连接ADB，设备可能已死机，终止所有测试", Fore.RED)
        return False
    log_print(device, "ADB已连接", Fore.GREEN)

    # 阶段2: 检查系统启动完成
    log_print(device, "阶段2: 检查系统启动完成...", Fore.CYAN)
    if not wait_for_boot_complete(device, timeout=120):
        log_print(device, "系统启动超时，但继续尝试恢复...", Fore.YELLOW)
        # 不返回False，继续尝试

    # 阶段3: 检查系统服务（宽松模式，允许超时继续）
    log_print(device, "阶段3: 检查系统服务（宽松模式）...", Fore.CYAN)
    wait_for_system_ready(device, timeout=60, allow_timeout=True)  # 允许超时继续

    # 阶段4: 跳过开机向导（如果系统服务不就绪也可能成功）
    log_print(device, "阶段4: 尝试跳过开机向导...", Fore.CYAN)
    skip_oobe_result = skip_oobe_via_adb_relaxed(device)  # 使用宽松版本的跳过OOBE
    if not skip_oobe_result:
        log_print(device, "跳过开机向导失败，但继续尝试...", Fore.YELLOW)

    # 阶段5: 等待进入桌面
    log_print(device, "阶段5: 等待进入系统主界面...", Fore.CYAN)
    if not wait_for_home_screen(device, timeout=120):
        log_print(device, "未能进入桌面，但基础恢复已完成", Fore.YELLOW)

    # 基础恢复完成，设备应该可以继续测试
    log_print(device, "【失败专项前置检查】完成，设备已恢复到可测试状态", Fore.GREEN)
    return True

def skip_oobe_via_adb_relaxed(device):
    """
    宽松版本的跳过开机向导（不强制要求系统服务完全就绪）
    用于失败恢复场景，即使系统服务不就绪也尝试跳过OOBE
    """
    oobe_cmds = CONFIG['adb_commands']['skip_oobe']
    try:
        subprocess.run(CONFIG['adb_commands']['root'].format(device=device), shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        subprocess.run(oobe_cmds['user_setup_complete'].format(device=device), shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        subprocess.run(oobe_cmds['device_provisioned'].format(device=device), shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        subprocess.run(oobe_cmds['system_locales'].format(device=device), shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        subprocess.run(CONFIG['adb_commands']['keyevent_back'].format(device=device), shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        subprocess.run(oobe_cmds['go_home'].format(device=device), shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        log_print(device, "已跳过开机向导（宽松模式）", Fore.GREEN)
        return True
    except Exception as e:
        log_print(device, f"跳过开机向导异常: {e}", Fore.YELLOW)
        return False

def factory_reset_test(device, loop_count):
    """恢复出厂设置专项：模拟用户恢复出厂设置，通过内置ADB命令跳过开机向导"""
    global exit_flag
    log_print(device, f"开始执行【恢复出厂设置专项】", Fore.CYAN)
    for i in range(loop_count):
        if exit_flag:
            log_print(device, "检测到退出信号，停止测试", Fore.YELLOW)
            break
        try:
            log_print(device, f"恢复出厂设置 第 {i + 1}/{loop_count} 次", Fore.YELLOW)

            # 常规前置检查（严格模式）
            if not ensure_device_ready_for_test(device, f"恢复出厂设置第 {i + 1} 次前置检查"):
                log_print(device, "常规前置检查失败，启动【失败专项前置检查】...", Fore.YELLOW)

                # 使用容错恢复机制
                if not recover_device_after_failure(device):
                    log_print(device, "设备无法恢复（可能死机），终止所有测试", Fore.RED)
                    return False  # 设备死机，终止所有专项

                # 设备已恢复，跳过本次循环的恢复出厂操作，直接进入下一轮
                log_print(device, "设备已恢复，跳过本次循环，继续下一轮测试", Fore.GREEN)
                continue
            
            # 方法1: 执行标准广播方式恢复出厂设置
            subprocess.run(CONFIG['adb_commands']['root'].format(device=device), shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            subprocess.run(CONFIG['adb_commands']['factory_reset'].format(device=device), shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            log_print(device, "正在恢复出厂设置（广播方式）......", Fore.BLUE)
            
            # 检查10秒内设备是否断开连接（广播方式可能需要几秒才断开）
            if check_device_disconnected(device, timeout=120):
                log_print(device, "广播方式生效，设备已断开", Fore.GREEN)
            else:
                # 再次检查设备是否还在线（离线/未授权也视为已断开）
                state = get_adb_device_state(device)
                if state is None or state.lower() != "device":
                    log_print(device, "设备已断开（延迟断开）", Fore.GREEN)
                else:
                    # 方法2: 广播方式确实失败，使用UI方式
                    log_print(device, "广播方式未生效，切换到UI方式...", Fore.YELLOW)
                    if not factory_reset_via_ui(device):
                        log_print(device, "UI方式恢复出厂设置失败，跳过本次循环", Fore.RED)
                        continue
            
            # 等待设备断开后重新连接并完全就绪
            wait_device_ready(device, wait_disconnect=True)
            if not wait_for_system_ready(device, timeout=CONFIG.get('timings', {}).get('device_ready_timeout', 300), allow_timeout=False):
                log_print(device, "系统服务未就绪，终止恢复出厂设置专项", Fore.RED)
                return False
            check_and_turn_on_screen(device)
            set_screen_timeout(device, CONFIG['general']['screen_timeout_minutes'])
            if not skip_oobe_via_adb(device):
                log_print(device, "跳过开机向导失败，终止恢复出厂设置专项", Fore.RED)
                return False
            if not wait_for_home_screen(device, timeout=CONFIG.get('timings', {}).get('device_ready_timeout', 300)):
                log_print(device, "未进入系统主界面，终止恢复出厂设置专项", Fore.RED)
                return False
            time.sleep(CONFIG['timings']['short_wait'])
            log_print(device, f"恢复出厂设置第 {i + 1} 次完成", Fore.GREEN)
        except Exception as e:
            log_print(device, f"恢复出厂设置第 {i + 1} 次出错: {e}", Fore.RED)
            continue
    return True

def quick_click_by_resource_id(device, resource_id, timeout=5):
    """快速点击指定resource-id的元素（不等待dump完成后再点击）"""
    start_time = time.time()
    while time.time() - start_time < timeout:
        try:
            # 快速dump
            subprocess.run(['adb', '-s', device, 'shell', 'uiautomator', 'dump'], 
                          capture_output=True, text=True, timeout=3)
            result = subprocess.run(['adb', '-s', device, 'shell', 'cat', '/sdcard/window_dump.xml'],
                                    capture_output=True, text=True, encoding='utf-8', timeout=3)
            if result.returncode == 0 and resource_id in result.stdout:
                xml_content = result.stdout
                tree = ET.ElementTree(ET.fromstring(xml_content))
                for element in tree.iter('node'):
                    if element.get('resource-id') == resource_id:
                        bounds = element.get('bounds')
                        bounds = bounds.strip('[]').split('][')
                        left_x, top_y = map(int, bounds[0].split(','))
                        right_x, bottom_y = map(int, bounds[1].split(','))
                        mid_x = (left_x + right_x) // 2
                        mid_y = (top_y + bottom_y) // 2
                        subprocess.run(['adb', '-s', device, 'shell', f'input tap {mid_x} {mid_y}'])
                        return True
        except:
            pass
        time.sleep(0.5)
    return False

def ui_reboot_test(device, loop_count):
    """UI联机重启专项：通过模拟用户操作长按Power键点击重启按钮"""
    global exit_flag
    log_print(device, "开始执行【UI联机重启专项】", Fore.CYAN)

    if not ensure_device_ready_for_test(device, "UI联机重启专项前置检查"):
        log_print(device, "设备未就绪，终止UI联机重启专项", Fore.RED)
        return False
    
    # 推送器件检测脚本
    if not push_device_check_script(device):
        log_print(device, "器件检测脚本推送失败，将跳过器件检测", Fore.YELLOW)
        device_check_enabled = False
    else:
        device_check_enabled = True
        # 清除旧的基准文件，首次运行时创建新基准
        clear_device_check_baseline(device)
    
    # 获取该设备品牌对应的重启按钮点击步骤
    reboot_steps = get_reboot_steps(device)
    log_print(device, f"重启步骤: {len(reboot_steps)} 步", Fore.CYAN)
    
    # 统计
    check_stats = {'total': 0, 'passed': 0, 'failed': 0, 'failed_iterations': []}
    
    for i in range(loop_count):
        if exit_flag:
            log_print(device, "检测到退出信号，停止测试", Fore.YELLOW)
            break
        try:
            log_print(device, f"UI重启 第 {i + 1}/{loop_count} 次", Fore.YELLOW)

            # 常规前置检查（严格模式）
            if not ensure_device_ready_for_test(device, f"UI重启第 {i + 1} 次前置检查"):
                log_print(device, "常规前置检查失败，启动【失败专项前置检查】...", Fore.YELLOW)

                # 使用容错恢复机制
                if not recover_device_after_failure(device):
                    log_print(device, "设备无法恢复（可能死机），终止所有测试", Fore.RED)
                    return False  # 设备死机，终止所有专项

                # 设备已恢复，跳过本次循环的重启操作，直接进入下一轮
                log_print(device, "设备已恢复，跳过本次循环，继续下一轮测试", Fore.GREEN)
                continue
            # 亮屏
            check_and_turn_on_screen(device)
            time.sleep(CONFIG['timings']['short_wait'])
            # 返回桌面
            log_print(device, "返回桌面...")
            subprocess.run(f"adb -s {device} shell input keyevent 3", shell=True)
            time.sleep(CONFIG['timings']['short_wait'])
            
            # 方法1: 使用 adb shell input keyevent --longpress 26 长按电源键
            log_print(device, "尝试使用 keyevent --longpress 长按电源键...")
            subprocess.run(f"adb -s {device} shell input keyevent --longpress 26", shell=True)
            
            # 按配置的步骤点击重启按钮（先检查控件，识别到立即点击）
            first_step = reboot_steps[0]
            log_print(device, f"检查重启控件(等待5秒): {first_step['type']}={first_step['value']}...")
            if wait_and_click_element_by_type(device, first_step['type'], first_step['value'], timeout=5):
                log_print(device, "已发现重启控件并点击", Fore.GREEN)
            else:
                # 方法2: 使用 sendevent 长按电源键
                log_print(device, "未检测到重启弹窗，尝试使用 sendevent 长按电源键...")
                long_press_power_sendevent(device, duration=3)
                if wait_and_click_element_by_type(device, first_step['type'], first_step['value'], timeout=5):
                    log_print(device, "已发现重启控件并点击", Fore.GREEN)
                else:
                    log_print(device, "未能弹出重启弹窗，跳过本次循环", Fore.RED)
                    continue
            time.sleep(CONFIG['timings'].get('ui_load_wait', 3))
            step_failed = False
            for step_idx, step in enumerate(reboot_steps[1:], start=2):
                time.sleep(CONFIG['timings'].get('ui_load_wait', 2))
                log_print(device, f"点击第{step_idx}步: {step['type']}={step['value']}...")
                if wait_and_click_element_by_type(device, step['type'], step['value'], timeout=6):
                    log_print(device, "å·²åç°éå¯æ§ä»¶å¹¶ç¹å»", Fore.GREEN)
                else:
                    log_print(device, f"第{step_idx}步点击失败，跳过本次循环", Fore.RED)
                    step_failed = True
                    break
            if step_failed:
                continue
            
            # 等待设备重启并完全就绪
            time.sleep(3)
            wait_device_ready(device, wait_disconnect=True)
            if not wait_for_system_ready(device, timeout=CONFIG.get('timings', {}).get('device_ready_timeout', 300), allow_timeout=False):
                log_print(device, "系统服务未就绪，终止UI联机重启专项", Fore.RED)
                return False
            if not ensure_home_ready(device, timeout=CONFIG.get('timings', {}).get('device_ready_timeout', 300)):
                log_print(device, "未进入系统主界面，终止UI联机重启专项", Fore.RED)
                return False
            
            # 执行器件检测
            if device_check_enabled:
                check_stats['total'] += 1
                success, result = run_device_check(device, i + 1)
                if success:
                    check_stats['passed'] += 1
                    log_print(device, f"UI重启第 {i + 1} 次完成 - 器件检测通过", Fore.GREEN)
                else:
                    check_stats['failed'] += 1
                    check_stats['failed_iterations'].append(i + 1)
                    log_print(device, f"UI重启第 {i + 1} 次完成 - 器件检测失败", Fore.RED)
            else:
                log_print(device, f"UI重启第 {i + 1} 次完成", Fore.GREEN)
        except Exception as e:
            log_print(device, f"UI重启第 {i + 1} 次出错: {e}", Fore.RED)
            continue
    
    # 输出器件检测统计
    if device_check_enabled and check_stats['total'] > 0:
        log_print(device, f"【UI联机重启专项】器件检测统计:", Fore.MAGENTA)
        log_print(device, f"  总次数: {check_stats['total']}, 通过: {check_stats['passed']}, 失败: {check_stats['failed']}", 
                 Fore.GREEN if check_stats['failed'] == 0 else Fore.RED)
        if check_stats['failed_iterations']:
            log_print(device, f"  失败的迭代: {check_stats['failed_iterations']}", Fore.RED)
    return True

def adb_reboot_test(device, loop_count):
    """ADB reboot重启专项：adb命令重启手机，进到桌面后执行5分钟原生monkey，然后再重启"""
    global exit_flag
    log_print(device, "开始执行【ADB reboot重启专项】", Fore.CYAN)

    if not ensure_device_ready_for_test(device, "ADB reboot重启专项前置检查"):
        log_print(device, "设备未就绪，终止ADB reboot重启专项", Fore.RED)
        return False
    
    # 推送器件检测脚本
    if not push_device_check_script(device):
        log_print(device, "器件检测脚本推送失败，将跳过器件检测", Fore.YELLOW)
        device_check_enabled = False
    else:
        device_check_enabled = True
        # 清除旧的基准文件，首次运行时创建新基准
        clear_device_check_baseline(device)
    
    monkey_duration = CONFIG['general']['monkey_duration_seconds']
    
    # 统计
    check_stats = {'total': 0, 'passed': 0, 'failed': 0, 'failed_iterations': []}
    
    for i in range(loop_count):
        if exit_flag:
            log_print(device, "检测到退出信号，停止测试", Fore.YELLOW)
            break
        log_print(device, f"ADB重启+Monkey 第 {i + 1}/{loop_count} 次", Fore.YELLOW)

        # 常规前置检查（严格模式）
        if not ensure_device_ready_for_test(device, f"ADB重启第 {i + 1} 次前置检查"):
            log_print(device, "常规前置检查失败，启动【失败专项前置检查】...", Fore.YELLOW)

            # 使用容错恢复机制
            if not recover_device_after_failure(device):
                log_print(device, "设备无法恢复（可能死机），终止所有测试", Fore.RED)
                return False  # 设备死机，终止所有专项

            # 设备已恢复，跳过本次循环的ADB重启操作，直接进入下一轮
            log_print(device, "设备已恢复，跳过本次循环，继续下一轮测试", Fore.GREEN)
            continue
        # 执行ADB重启
        subprocess.run(CONFIG['adb_commands']['reboot'].format(device=device), shell=True)
        # 等待设备断开后重新连接并完全就绪
        wait_device_ready(device, wait_disconnect=True)
        if not wait_for_system_ready(device, timeout=CONFIG.get('timings', {}).get('device_ready_timeout', 300), allow_timeout=False):
            log_print(device, "系统服务未就绪，终止ADB reboot重启专项", Fore.RED)
            return False
        if not ensure_home_ready(device, timeout=CONFIG.get('timings', {}).get('device_ready_timeout', 300)):
            log_print(device, "未进入系统主界面，终止ADB reboot重启专项", Fore.RED)
            return False
        # 亮屏并返回桌面
        check_and_turn_on_screen(device)
        time.sleep(3)
        subprocess.run(f"adb -s {device} shell input keyevent 3", shell=True)
        time.sleep(2)
        
        # 执行器件检测
        if device_check_enabled:
            check_stats['total'] += 1
            success, result = run_device_check(device, i + 1)
            if success:
                check_stats['passed'] += 1
                log_print(device, f"器件检测通过", Fore.GREEN)
            else:
                check_stats['failed'] += 1
                check_stats['failed_iterations'].append(i + 1)
                log_print(device, f"器件检测失败", Fore.RED)
        
        # 执行5分钟monkey测试
        run_monkey_timed(device, monkey_duration)
        log_print(device, f"ADB重启+Monkey第 {i + 1} 次完成", Fore.GREEN)
    
    # 输出器件检测统计
    if device_check_enabled and check_stats['total'] > 0:
        log_print(device, f"【ADB reboot重启专项】器件检测统计:", Fore.MAGENTA)
        log_print(device, f"  总次数: {check_stats['total']}, 通过: {check_stats['passed']}, 失败: {check_stats['failed']}", 
                 Fore.GREEN if check_stats['failed'] == 0 else Fore.RED)
        if check_stats['failed_iterations']:
            log_print(device, f"  失败的迭代: {check_stats['failed_iterations']}", Fore.RED)
    return True


def power_on_off_test(device, loop_count, wait_time_after_boot=60):
    """开关机专项：使用adb shell setprop sys.powerctl reboot关机，等待开机后再次重启"""
    global exit_flag
    log_print(device, "开始执行【开关机专项】", Fore.CYAN)

    if not ensure_device_ready_for_test(device, "开关机专项前置检查"):
        log_print(device, "设备未就绪，终止开关机专项", Fore.RED)
        return False
    
    # 推送器件检测脚本
    if not push_device_check_script(device):
        log_print(device, "器件检测脚本推送失败，将跳过器件检测", Fore.YELLOW)
        device_check_enabled = False
    else:
        device_check_enabled = True
        clear_device_check_baseline(device)
    
    # 统计
    check_stats = {'total': 0, 'passed': 0, 'failed': 0, 'failed_iterations': []}
    
    for i in range(loop_count):
        if exit_flag:
            log_print(device, "检测到退出信号，停止测试", Fore.YELLOW)
            break
        try:
            log_print(device, f"开关机 第 {i + 1}/{loop_count} 次", Fore.YELLOW)

            # 常规前置检查（严格模式）
            if not ensure_device_ready_for_test(device, f"开关机第 {i + 1} 次前置检查"):
                log_print(device, "常规前置检查失败，启动【失败专项前置检查】...", Fore.YELLOW)

                # 使用容错恢复机制
                if not recover_device_after_failure(device):
                    log_print(device, "设备无法恢复（可能死机），终止所有测试", Fore.RED)
                    return False

                log_print(device, "设备已恢复，跳过本次循环，继续下一轮测试", Fore.GREEN)
                continue
            
            # 亮屏并返回桌面
            check_and_turn_on_screen(device)
            time.sleep(CONFIG['timings']['short_wait'])
            subprocess.run(f"adb -s {device} shell input keyevent 3", shell=True)
            time.sleep(CONFIG['timings']['short_wait'])
            
            # 使用 adb shell setprop sys.powerctl reboot 关机
            log_print(device, "执行关机命令...", Fore.BLUE)
            subprocess.run(f"adb -s {device} shell setprop sys.powerctl reboot", shell=True)
            
            # 等待设备断开连接
            if not wait_for_device_disconnect(device, timeout=60):
                log_print(device, "设备未能在60秒内断开，跳过本次循环", Fore.RED)
                continue
            
            log_print(device, "设备已关机，等待手动开机...", Fore.YELLOW)
            
            # 等待设备重新连接并完全就绪
            wait_device_ready(device, wait_disconnect=False)
            if not wait_for_system_ready(device, timeout=CONFIG.get('timings', {}).get('device_ready_timeout', 300), allow_timeout=False):
                log_print(device, "系统服务未就绪，终止开关机专项", Fore.RED)
                return False
            if not ensure_home_ready(device, timeout=CONFIG.get('timings', {}).get('device_ready_timeout', 300)):
                log_print(device, "未进入系统主界面，终止开关机专项", Fore.RED)
                return False
            
            # 开机后等待预定时间
            log_print(device, f"开机完成，等待 {wait_time_after_boot} 秒后继续...", Fore.CYAN)
            time.sleep(wait_time_after_boot)
            
            # 执行器件检测
            if device_check_enabled:
                check_stats['total'] += 1
                success, result = run_device_check(device, i + 1)
                if success:
                    check_stats['passed'] += 1
                    log_print(device, f"开关机第 {i + 1} 次完成 - 器件检测通过", Fore.GREEN)
                else:
                    check_stats['failed'] += 1
                    check_stats['failed_iterations'].append(i + 1)
                    log_print(device, f"开关机第 {i + 1} 次完成 - 器件检测失败", Fore.RED)
            else:
                log_print(device, f"开关机第 {i + 1} 次完成", Fore.GREEN)
        except Exception as e:
            log_print(device, f"开关机第 {i + 1} 次出错: {e}", Fore.RED)
            continue
    
    # 输出器件检测统计
    if device_check_enabled and check_stats['total'] > 0:
        log_print(device, f"【开关机专项】器件检测统计:", Fore.MAGENTA)
        log_print(device, f"  总次数: {check_stats['total']}, 通过: {check_stats['passed']}, 失败: {check_stats['failed']}", 
                 Fore.GREEN if check_stats['failed'] == 0 else Fore.RED)
        if check_stats['failed_iterations']:
            log_print(device, f"  失败的迭代: {check_stats['failed_iterations']}", Fore.RED)
    return True


def open_preinstalled_apps_random(device, count=10, interval_seconds=5):
    """随机打开若干预置应用（仅含界面应用），应用间隔指定秒"""
    log_print(device, f"准备随机打开 {count} 个预置应用...", Fore.CYAN)
    try:
        result = subprocess.run(
            ['adb', '-s', device, 'shell', 'pm', 'list', 'packages'],
            capture_output=True, text=True, timeout=30
        )
        if result.returncode != 0:
            log_print(device, "获取应用列表失败", Fore.RED)
            return False
        
        packages = [line.replace('package:', '').strip() for line in result.stdout.splitlines() if line.startswith('package:')]
        
        # 过滤掉系统核心包和无界面类包（粗略过滤）
        exclude_keywords = ['com.android.', 'com.google.android.', 'android', 'system']
        candidate_packages = [pkg for pkg in packages if not any(keyword in pkg for keyword in exclude_keywords)]
        
        if not candidate_packages:
            log_print(device, "未找到可用预置应用", Fore.YELLOW)
            return False
        
        selected = random.sample(candidate_packages, k=min(count, len(candidate_packages)))
        log_print(device, f"随机选中 {len(selected)} 个应用，按 {interval_seconds} 秒间隔启动...", Fore.CYAN)
        
        opened_count = 0
        for pkg in selected:
            try:
                subprocess.run(
                    ['adb', '-s', device, 'shell', 'monkey', '-p', pkg, '-c', 'android.intent.category.LAUNCHER', '1'],
                    capture_output=True, timeout=8
                )
                opened_count += 1
            except Exception:
                log_print(device, f"应用 {pkg} 启动失败，继续下一个", Fore.YELLOW)
            time.sleep(interval_seconds)
        
        log_print(device, f"已尝试打开 {opened_count}/{len(selected)} 个预置应用", Fore.GREEN if opened_count else Fore.YELLOW)
        return opened_count > 0
    except Exception as e:
        log_print(device, f"打开预置应用异常: {e}", Fore.RED)
        return False


def check_screen_off(device):
    """检查设备是否处于息屏状态（兼容不同Android版本字段，含display兜底）"""
    try:
        power_output = subprocess.check_output(
            ['adb', '-s', device, 'shell', 'dumpsys', 'power'],
            text=True, errors='ignore', timeout=10
        )
        lower = power_output.lower()
        # 常见息屏标志词（覆盖老版本 mWakefulness、新版本 Wakefulness/DisplayState 等）
        off_keywords = [
            "mwakefulness=asleep",
            "wakefulness=asleep",
            "mwakefulness=dozing",
            "wakefulness=dozing",
            "minteractive=false",
            "display power: state=off",
            "display state=off",
            "display_state=off",
            "display-state=off",
            "mdisplaypowerstate=off",
            "mscreenon=false",
            "screen_on=false",
        ]
        if any(k in lower for k in off_keywords):
            return True
        if re.search(r"display power:.*state=off", lower):
            return True
    except Exception:
        pass
    # 备用：通过 dumpsys display 判断
    try:
        display_output = subprocess.check_output(
            ['adb', '-s', device, 'shell', 'dumpsys', 'display'],
            text=True, errors='ignore', timeout=10
        )
        dlower = display_output.lower()
        display_off_keywords = [
            "state=off",
            "mstate=off",
            "mdisplaystate=off",
            "display_state=off",
            "display-state=off",
        ]
        if any(k in dlower for k in display_off_keywords):
            return True
        if re.search(r"state[:=]\\s*off", dlower):
            return True
    except Exception:
        pass
    return False


def sleep_wake_test(device, loop_count, sleep_time_minutes, wake_time_minutes):
    """休眠唤醒专项：按电源键灭屏，静置待机，再按电源键亮屏"""
    global exit_flag
    log_print(device, "开始执行【休眠唤醒专项】", Fore.CYAN)
    post_power_key_wait = CONFIG.get('timings', {}).get('post_power_key_wait', 2)  # 电源键灭/亮屏后的检测延迟
    preinstalled_opened = False

    if not ensure_device_ready_for_test(device, "休眠唤醒专项前置检查"):
        log_print(device, "设备未就绪，终止休眠唤醒专项", Fore.RED)
        return False
    
    # 设置2分钟息屏时间
    log_print(device, "设置息屏时间为2分钟...", Fore.CYAN)
    subprocess.run(['adb', '-s', device, 'shell', 'settings', 'put', 'system', 'screen_off_timeout', '120000'])
    
    # 返回桌面
    log_print(device, "返回桌面...", Fore.CYAN)
    subprocess.run(f"adb -s {device} shell input keyevent 3", shell=True)
    time.sleep(CONFIG['timings']['short_wait'])
    
    for i in range(loop_count):
        if exit_flag:
            log_print(device, "检测到退出信号，停止测试", Fore.YELLOW)
            break
        try:
            log_print(device, f"休眠唤醒 第 {i + 1}/{loop_count} 次", Fore.YELLOW)

            # 仅在第一次循环前随机打开带界面的预置应用
            if not preinstalled_opened:
                open_preinstalled_apps_random(device, count=10, interval_seconds=5)
                preinstalled_opened = True
            
            # 按电源键灭屏
            log_print(device, "按电源键灭屏...", Fore.CYAN)
            subprocess.run(['adb', '-s', device, 'shell', 'input', 'keyevent', '26'])
            time.sleep(post_power_key_wait)
            
            # 检测是否处于息屏状态
            if not check_screen_off(device):
                log_print(device, "未检测到息屏，再次按电源键...", Fore.YELLOW)
                subprocess.run(['adb', '-s', device, 'shell', 'input', 'keyevent', '26'])
                time.sleep(post_power_key_wait)
                
                if not check_screen_off(device):
                    log_print(device, "无法进入息屏状态，跳过本次循环", Fore.RED)
                    continue
            
            log_print(device, "已进入息屏状态", Fore.GREEN)
            
            # 静置待机预设时间（分钟）
            sleep_seconds = sleep_time_minutes * 60
            log_print(device, f"静置待机 {sleep_time_minutes} 分钟 ({sleep_seconds} 秒)...", Fore.CYAN)
            time.sleep(sleep_seconds)
            
            # 按电源键亮屏
            log_print(device, "按电源键亮屏...", Fore.CYAN)
            subprocess.run(['adb', '-s', device, 'shell', 'input', 'keyevent', '26'])
            time.sleep(2)
            
            # 通过两次 keyevent 82 进入桌面
            log_print(device, "解锁进入桌面...", Fore.CYAN)
            subprocess.run(['adb', '-s', device, 'shell', 'input', 'keyevent', '82'])
            time.sleep(1)
            subprocess.run(['adb', '-s', device, 'shell', 'input', 'keyevent', '82'])
            time.sleep(2)
            
            # 亮屏等待预设时间（分钟）
            wake_seconds = wake_time_minutes * 60
            log_print(device, f"亮屏等待 {wake_time_minutes} 分钟 ({wake_seconds} 秒)...", Fore.CYAN)
            time.sleep(wake_seconds)
            
            log_print(device, f"休眠唤醒第 {i + 1} 次完成", Fore.GREEN)
        except Exception as e:
            log_print(device, f"休眠唤醒第 {i + 1} 次出错: {e}", Fore.RED)
            continue
    
    return True


def run_all_tests_sequential(device, loop_count):
    """连贯执行全部专项：依次执行恢复出厂设置、UI联机重启、ADB reboot重启"""
    global exit_flag
    log_print(device, "开始执行【连贯全部专项测试】", Fore.MAGENTA)
    log_print(device, f"执行顺序: 恢复出厂设置 -> UI联机重启 -> ADB reboot重启", Fore.MAGENTA)
    log_print(device, f"每个专项循环次数: {loop_count}", Fore.MAGENTA)
    
    # 1. 恢复出厂设置专项
    if not exit_flag:
        if not factory_reset_test(device, loop_count):
            return
    
    # 2. UI联机重启专项
    if not exit_flag:
        if not ui_reboot_test(device, loop_count):
            return
    
    # 3. ADB reboot重启专项
    if not exit_flag:
        if not adb_reboot_test(device, loop_count):
            return
    
    log_print(device, "【连贯全部专项测试】执行完成！", Fore.MAGENTA)

def reboot_and_power_wake_up(device,loop_number,wakeup_time,sleep_time):
    """开关机专项：使用adb shell setprop sys.powerctl reboot关机，等待开机后再次重启"""
    """休眠唤醒专项：按电源键灭屏，静置待机，再按电源键亮屏"""
    global exit_flag
    if wakeup_time <= 0 or sleep_time <= 0:
        log_print(device,"设置【休眠唤醒】休眠时间或者唤醒等待时间小于或等于0分钟",Fore.RED)
        return False
    log_print(device, "现在执行开关机+休眠唤醒混合循环专项", Fore.YELLOW)
    log_print(device, "1.开始执行【开关机专项】", Fore.BLUE)

    if not ensure_device_ready_for_test(device, "开关机专项前置检查"):
        log_print(device, "设备未就绪，终止开关机专项", Fore.RED)
        return False

    # 推送器件检测脚本
    if not push_device_check_script(device):
        log_print(device, "器件检测脚本推送失败，将跳过器件检测", Fore.YELLOW)
        device_check_enabled = False
    else:
        device_check_enabled = True
        clear_device_check_baseline(device)

    post_power_key_wait = CONFIG.get('timings', {}).get('post_power_key_wait', 2)  # 电源键灭/亮屏后的检测延迟
    preinstalled_opened = False

    # 统计
    check_stats = {'total': 0, 'passed': 0, 'failed': 0, 'failed_iterations': []}

    for i in range(loop_number):
        if exit_flag:
            log_print(device, "检测到退出信号，停止测试", Fore.YELLOW)
            break
        try:
            log_print(device, f"开关机 第 {i + 1}/{loop_count} 次", Fore.YELLOW)

            # 常规前置检查（严格模式）
            if not ensure_device_ready_for_test(device, f"开关机第 {i + 1} 次前置检查"):
                log_print(device, "常规前置检查失败，启动【失败专项前置检查】...", Fore.YELLOW)

                # 使用容错恢复机制
                if not recover_device_after_failure(device):
                    log_print(device, "设备无法恢复（可能死机），终止所有测试", Fore.RED)
                    return False

                log_print(device, "设备已恢复，跳过本次循环，继续下一轮测试", Fore.GREEN)
                continue

            # 亮屏并返回桌面
            check_and_turn_on_screen(device)
            time.sleep(CONFIG['timings']['short_wait'])
            subprocess.run(f"adb -s {device} shell input keyevent 3", shell=True)
            time.sleep(CONFIG['timings']['short_wait'])

            # 使用 adb shell setprop sys.powerctl reboot 关机
            log_print(device, "执行关机命令...", Fore.BLUE)
            subprocess.run(f"adb -s {device} shell setprop sys.powerctl reboot", shell=True)

            # 等待设备断开连接
            if not wait_for_device_disconnect(device, timeout=60):
                log_print(device, "设备未能在60秒内断开，跳过本次循环", Fore.RED)
                continue

            log_print(device, "设备已关机，等待手动开机...", Fore.YELLOW)

            # 等待设备重新连接并完全就绪
            wait_device_ready(device, wait_disconnect=False)
            if not wait_for_system_ready(device, timeout=CONFIG.get('timings', {}).get('device_ready_timeout', 300),
                                         allow_timeout=False):
                log_print(device, "系统服务未就绪，终止开关机专项", Fore.RED)
                return False
            if not ensure_home_ready(device, timeout=CONFIG.get('timings', {}).get('device_ready_timeout', 300)):
                log_print(device, "未进入系统主界面，终止开关机专项", Fore.RED)
                return False

            # 开机后等待预定时间
            #total_time = (wakeup_time + sleep_time) * 60 + 30
            #log_print(device, f"开机完成，等待 {total_time} 秒后继续...", Fore.CYAN)
            #time.sleep(total_time)

            # 执行器件检测
            if device_check_enabled:
                check_stats['total'] += 1
                success, result = run_device_check(device, i + 1)
                if success:
                    check_stats['passed'] += 1
                    log_print(device, f"开关机第 {i + 1} 次完成 - 器件检测通过", Fore.GREEN)
                else:
                    check_stats['failed'] += 1
                    check_stats['failed_iterations'].append(i + 1)
                    log_print(device, f"开关机第 {i + 1} 次完成 - 器件检测失败", Fore.RED)
            else:
                log_print(device, f"开关机第 {i + 1} 次完成", Fore.GREEN)
        except Exception as e:
            log_print(device, f"开关机第 {i + 1} 次出错: {e}", Fore.RED)
            continue
        ################################################################################################################
        log_print(device,"2.开始进行休眠唤醒操作",Fore.BLUE)
        try:
            log_print(device, f"休眠唤醒 第 {i + 1}/{loop_count} 次", Fore.YELLOW)

            # 仅在第一次循环前随机打开带界面的预置应用
            if not preinstalled_opened:
                open_preinstalled_apps_random(device, count=10, interval_seconds=5)
                preinstalled_opened = True

            # 按电源键灭屏
            log_print(device, "按电源键灭屏...", Fore.CYAN)
            subprocess.run(['adb', '-s', device, 'shell', 'input', 'keyevent', '26'])
            time.sleep(post_power_key_wait)

            # 检测是否处于息屏状态
            if not check_screen_off(device):
                log_print(device, "未检测到息屏，再次按电源键...", Fore.YELLOW)
                subprocess.run(['adb', '-s', device, 'shell', 'input', 'keyevent', '26'])
                time.sleep(post_power_key_wait)

                if not check_screen_off(device):
                    log_print(device, "无法进入息屏状态，跳过本次循环", Fore.RED)
                    continue

            log_print(device, "已进入息屏状态", Fore.GREEN)

            # 静置待机预设时间（分钟）
            sleep_seconds = sleep_time * 60
            log_print(device, f"静置待机 {sleep_time} 分钟 ({sleep_seconds} 秒)...", Fore.CYAN)
            time.sleep(sleep_seconds)

            # 按电源键亮屏
            log_print(device, "按电源键亮屏...", Fore.CYAN)
            subprocess.run(['adb', '-s', device, 'shell', 'input', 'keyevent', '26'])
            time.sleep(2)

            # 通过两次 keyevent 82 进入桌面
            log_print(device, "解锁进入桌面...", Fore.CYAN)
            subprocess.run(['adb', '-s', device, 'shell', 'input', 'keyevent', '82'])
            time.sleep(1)
            subprocess.run(['adb', '-s', device, 'shell', 'input', 'keyevent', '82'])
            time.sleep(2)

            # 亮屏等待预设时间（分钟）
            wake_seconds = wakeup_time * 60
            log_print(device, f"亮屏等待 {wakeup_time} 分钟 ({wake_seconds} 秒)...", Fore.CYAN)
            time.sleep(wake_seconds)

            log_print(device, f"休眠唤醒第 {i + 1} 次完成", Fore.GREEN)
        except Exception as e:
            log_print(device, f"休眠唤醒第 {i + 1} 次出错: {e}", Fore.RED)
            continue
    log_print(device,"开关机+休眠唤醒混合循环专项全部执行完成",Fore.GREEN)
    # 输出器件检测统计
    if device_check_enabled and check_stats['total'] > 0:
        log_print(device, f"【开关机专项】器件检测统计:", Fore.MAGENTA)
        log_print(device,
                  f"  总次数: {check_stats['total']}, 通过: {check_stats['passed']}, 失败: {check_stats['failed']}",
                  Fore.GREEN if check_stats['failed'] == 0 else Fore.RED)
        if check_stats['failed_iterations']:
            log_print(device, f"  失败的迭代: {check_stats['failed_iterations']}", Fore.RED)
    return True


# def split_devices_by_sn(devices):
#     """
#     根据SN号将设备分成两组
#     返回: (group1, group2) - 两个设备列表
#     """
#     # 根据SN号的哈希值进行分组，确保分布均匀
#     device_groups = {'group1': [], 'group2': []}
#
#     for device in devices:
#         # 使用SN号的哈希值决定分组
#         hash_value = hash(device)
#         if hash_value % 2 == 0:
#             device_groups['group1'].append(device)
#         else:
#             device_groups['group2'].append(device)
#
#     return device_groups['group1'], device_groups['group2']
def split_devices_by_sn(devices):
    """
    根据SN号将设备均匀分成两组
    返回: (group1, group2) - 两个设备列表
    """
    device_count = len(devices)

    if device_count < 2:
        print(f"{Fore.YELLOW}警告：设备数量({device_count})不足以分成两组，将全部执行相同的测试{Style.RESET_ALL}")
        return devices, []  # 返回原列表和空列表

    # 计算每组应该有多少设备
    group1_size = device_count // 2
    group2_size = device_count - group1_size

    print(f"{Fore.CYAN}设备分组信息：{Style.RESET_ALL}")
    print(f"  总设备数: {device_count}")
    print(f"  Group1 (开关机测试) 设备数: {group1_size}")
    print(f"  Group2 (休眠唤醒测试) 设备数: {group2_size}")

    # 方法1：根据SN号排序后均匀分配（推荐，保证每次运行同一设备分配到同一组）
    sorted_devices = sorted(devices)  # 按SN号排序

    group1 = sorted_devices[:group1_size]
    group2 = sorted_devices[group1_size:]

    return group1, group2


def handle_split_test(devices, loop_count):
    """
    处理分组测试：一半设备执行开关机测试，一半执行休眠唤醒测试
    """
    print(f"\n{Fore.CYAN}[{get_timestamp()}] 开始分组测试...{Style.RESET_ALL}")
    print(f"{Fore.YELLOW}根据SN号将设备分为两组：{Style.RESET_ALL}")

    # 获取两组设备
    group1, group2 = split_devices_by_sn(devices)

    # 确保两组都有设备
    if not group1 or not group2:
        print(f"{Fore.RED}错误：设备数量不足以分成两组！{Style.RESET_ALL}")
        print(f"  Group1设备数: {len(group1)}")
        print(f"  Group2设备数: {len(group2)}")
        return

    print(f"\n{Fore.GREEN}Group1 (开关机测试):{Style.RESET_ALL}")
    for device in group1:
        print(f"  - {device}")

    print(f"\n{Fore.GREEN}Group2 (休眠唤醒测试):{Style.RESET_ALL}")
    for device in group2:
        print(f"  - {device}")

    print(f"\n{Fore.CYAN}[{get_timestamp()}] 开始并行执行分组测试...{Style.RESET_ALL}")

    # 使用ThreadPoolExecutor并发处理所有设备
    with concurrent.futures.ThreadPoolExecutor() as executor:
        futures = []

        # 提交group1的任务（开关机测试 - 模式5）
        for device in group1:
            print(f"{Fore.BLUE}[{device}] 分配开关机测试{Style.RESET_ALL}")
            futures.append(executor.submit(power_on_off_test, device, loop_count))

        # 提交group2的任务（休眠唤醒测试 - 模式6）
        for device in group2:
            print(f"{Fore.BLUE}[{device}] 分配休眠唤醒测试{Style.RESET_ALL}")
            futures.append(executor.submit(sleep_wake_test, device, loop_count))

        # 等待所有任务完成
        concurrent.futures.wait(futures)

    print(f"\n{Fore.GREEN}[{get_timestamp()}] 分组测试完成！{Style.RESET_ALL}")
    print(f"  - 开关机测试设备数: {len(group1)}")
    print(f"  - 休眠唤醒测试设备数: {len(group2)}")

def handle_device(device, loop_count, switch_value,wakeup_time,sleep_time):
    """根据选择执行对应的测试专项"""
    if switch_value == 1:
        factory_reset_test(device, loop_count)
    elif switch_value == 2:
        ui_reboot_test(device, loop_count)
    elif switch_value == 3:
        adb_reboot_test(device, loop_count)
    elif switch_value == 4:
        run_all_tests_sequential(device, loop_count)
    elif switch_value == 5:
        power_on_off_test(device, loop_count)
    elif switch_value == 6:
        sleep_wake_test(device, loop_count,wakeup_time,sleep_time)
    elif switch_value == 7:
        reboot_and_power_wake_up(device, loop_count,wakeup_time,sleep_time)

# ==================== 主程序入口 ====================

def parse_arguments():
    """解析命令行参数，便于批处理或集成到脚本"""
    parser = argparse.ArgumentParser(
        description="工厂重置/重启自动化测试脚本（支持多设备并行）"
    )
    parser.add_argument(
        "-m", "--mode",
        help="指定测试模式编号 (1-7)，或使用 all 表示顺序执行全部模式（等同于选项4）"
    )
    parser.add_argument(
        "-l", "--loop", type=int,
        help="指定每个测试的循环次数，未提供时使用配置文件默认值"
    )
    parser.add_argument(
        "-d", "--device", action="append",
        help="指定设备序列号，默认对所有已连接设备执行；可多次传入以选择多台设备"
    )
    parser.add_argument(
        "--no-pause", action="store_true",
        help="脚本结束时不再等待按键，便于自动化调用"
    )
    return parser.parse_args()


def pause_before_exit(skip_pause):
    """根据参数决定是否等待用户按键"""
    if not skip_pause:
        input("按任意键退出...")


if __name__ == "__main__":
    args = parse_arguments()
    print(f"\n{Fore.CYAN}[{get_timestamp()}] 脚本启动{Style.RESET_ALL}")
    print(f"{Fore.YELLOW}提示: 按 Ctrl+C 可安全退出脚本{Style.RESET_ALL}")
    
    # 获取连接的设备列表
    devices_output = subprocess.run('adb devices', shell=True, capture_output=True, text=True).stdout.strip().split('\n')[1:]
    devices = [device.split('\t')[0] for device in devices_output if device.strip()]

    if not devices:
        print(f"{Fore.RED}[{get_timestamp()}] 未检测到任何设备，请检查ADB连接！{Style.RESET_ALL}")
        pause_before_exit(args.no_pause)
        sys.exit(1)

    # 根据参数筛选设备
    if args.device:
        selected = []
        missing = []
        for d in args.device:
            if d in devices:
                selected.append(d)
            else:
                missing.append(d)
        if missing:
            print(f"{Fore.RED}以下序列号未在当前连接列表中找到: {', '.join(missing)}{Style.RESET_ALL}")
            pause_before_exit(args.no_pause)
            sys.exit(1)
        devices = selected
        print(f"{Fore.CYAN}已根据参数筛选设备: {', '.join(devices)}{Style.RESET_ALL}")

    # 显示已连接设备
    print(f"\n{Fore.CYAN}[{get_timestamp()}] 当前连接设备列表（支持多设备并发运行）：{Style.RESET_ALL}")
    for idx, device in enumerate(devices, 1):
        print(f"  {idx}. {device}")

    # 解析或交互获取测试选项
    switch_value = None
    if args.mode:
        mode_arg = args.mode.strip()
        if mode_arg.lower() == "all":
            switch_value = 4
        else:
            try:
                switch_value = int(mode_arg)
            except ValueError:
                print(f"{Fore.RED}无效的模式参数: {mode_arg}，请使用1-7或all。{Style.RESET_ALL}")
                pause_before_exit(args.no_pause)
                sys.exit(1)
        if str(switch_value) not in CONFIG['test_modes']:
            print(f"{Fore.RED}模式 {mode_arg} 不在配置范围内（有效值1-7或all）。{Style.RESET_ALL}")
            pause_before_exit(args.no_pause)
            sys.exit(1)
        print(f"{Fore.CYAN}已通过参数选择模式 {mode_arg}，将跳过交互式选择。{Style.RESET_ALL}")

    if switch_value is None:
        print(f"\n{Fore.CYAN}{'='*50}{Style.RESET_ALL}")
        print(f"{Fore.YELLOW}选择执行测试项：{Style.RESET_ALL}")
        for key, mode in CONFIG['test_modes'].items():
            print(f"  {key}. {mode['name']}")
            print(f"     {Fore.WHITE}{mode['description']}{Style.RESET_ALL}")
        print(f"{Fore.CYAN}{'='*50}{Style.RESET_ALL}")
        switch_value = int(input(f"\n{Fore.CYAN}请输入测试项编号 (1-8)：{Style.RESET_ALL}"))

    # 解析或交互获取循环次数
    default_count = CONFIG['general']['default_loop_count']
    ##带mix的参数为选项7开关机+休眠唤醒融合参数
    # 默认亮屏时间(单位:分钟)
    default_mix_wakeup_time = CONFIG['general']['default_mix_wakeup_time']
    # 默认休眠时间(单位:分钟)
    default_mix_sleep_time = CONFIG['general']['default_mix_sleep_time']
    #不带mix参数为选项6单独休眠唤醒参数
    # (纯休眠唤醒) 默认唤醒时间(单位:分钟)
    default_wakeup_time = CONFIG['general']['default_wakeup_time']
    # (纯休眠唤醒) 默认休眠时间(单位:分钟)
    default_sleep_time = CONFIG['general']['default_sleep_time']
    #(开关机+休眠唤醒)定义参数
    mix_wakeup_time = default_mix_wakeup_time
    mix_sleep_time = default_mix_sleep_time
    #(休眠唤醒)定义参数
    wakeup_time = default_wakeup_time
    sleep_time = default_sleep_time
    if args.loop is not None:
        loop_count = args.loop
    elif args.mode:
        loop_count = default_count
        print(f"{Fore.CYAN}未指定循环次数，使用默认值 {default_count}。{Style.RESET_ALL}")
    else:
        print(f"\n{Fore.WHITE}默认循环次数: {default_count} 次{Style.RESET_ALL}")
        loop_input = input(f"{Fore.CYAN}请输入循环次数 (直接回车使用默认值)：{Style.RESET_ALL}")
        loop_count = int(loop_input) if loop_input.strip() else default_count
        if switch_value == 7:
            wakeup_input = input(f"{Fore.CYAN}请输入唤醒时间 (直接回车使用默认值:默认值为{default_mix_wakeup_time}分钟)：{Style.RESET_ALL}")
            mix_wakeup_time = int(wakeup_input) if wakeup_input.strip() else default_mix_wakeup_time
            sleep_input = input(f"{Fore.CYAN}请输入休眠时间 (直接回车使用默认值:默认值为{default_mix_sleep_time}分钟)：{Style.RESET_ALL}")
            mix_sleep_time = int(sleep_input) if sleep_input.strip() else default_mix_sleep_time
        elif switch_value == 6:
            wakeup_input = input(f"{Fore.CYAN}请输入唤醒时间 (直接回车使用默认值:默认值为{default_wakeup_time}分钟)：{Style.RESET_ALL}")
            wakeup_time = int(wakeup_input) if wakeup_input.strip() else default_wakeup_time
            sleep_input = input(f"{Fore.CYAN}请输入休眠时间 (直接回车使用默认值:默认值为{default_sleep_time}分钟)：{Style.RESET_ALL}")
            sleep_time = int(sleep_input) if sleep_input.strip() else default_sleep_time


    mode_info = CONFIG['test_modes'].get(str(switch_value), {})
    mode_name = mode_info.get('name', f"模式 {switch_value}")
    print(f"\n{Fore.GREEN}[{get_timestamp()}] 即将开始执行测试...{Style.RESET_ALL}")
    if switch_value < 6:
        print(f"  测试项: {mode_name}")
        print(f"  循环次数: {loop_count}")
        print(f"  设备数量: {len(devices)}")
    elif switch_value == 6:
        print(f"  测试项: {mode_name}")
        print(f"  休眠唤醒循环次数: {loop_count}")
        print(f"  休眠唤醒-休眠时间: {sleep_time}")
        print(f"  休眠唤醒-唤醒时间: {wakeup_time}")
        print(f"  设备数量: {len(devices)}")
    elif switch_value == 7:
        print(f"  测试项: {mode_name}")
        print(f"  开关机和休眠唤醒融合总循环次数: {loop_count}")
        print(f"  休眠唤醒-休眠时间: {mix_sleep_time}")
        print(f"  休眠唤醒-唤醒时间: {mix_wakeup_time}")
        print(f"  设备数量: {len(devices)}")

    # 使用ThreadPoolExecutor并发处理每个设备
    try:
        # 特殊处理模式8（分组测试）
        if switch_value == 8:
            # 模式7需要所有设备一起处理，不能逐个设备调用handle_device
            handle_split_test(devices, loop_count)
        else:
            with concurrent.futures.ThreadPoolExecutor() as executor:
                futures = [executor.submit(handle_device, device, loop_count, switch_value,wakeup_time,sleep_time) for device in devices]
                concurrent.futures.wait(futures)
    except KeyboardInterrupt:
        print(f"\n{Fore.YELLOW}[{get_timestamp()}] 用户中断，正在退出...{Style.RESET_ALL}")

    print(f"\n{Fore.GREEN}[{get_timestamp()}] 所有测试执行完成！{Style.RESET_ALL}")
    pause_before_exit(args.no_pause)
