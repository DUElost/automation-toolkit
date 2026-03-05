import subprocess
import time
import uiautomator2 as u2
import concurrent.futures
def wait_rids(device, rids, timeout=30):
    """
    等待多个控件的其中一个,只要rids中的其中一个控件存在，则通过
    比如判断有没有进入某个应用，可以通过判断title有没有出现，也可以判断“agree”有没有出现（初次进入）
    """
    # rids = ["com.transsion.phonemaster:id/tv_agree",
    #         "com.transsion.phonemaster:id/tv_title"
    #         ]
    d = u2.connect(device)
    rid=' | '.join([f'//*[@resource-id="{rid}"]' for rid in rids])
    # 等待任意一个元素出现
    try:
        if d.xpath(rid).wait(timeout):#等待该控件timeout秒，如果超时仍没有找到则提示没有找到控件
            # 再获取所有匹配元素
            elements = d.xpath(rid).all()
            if (len(elements) > 0):
                print(f"成功找到{rids}")
        else:
            print(f"等待超时，未找到元素{rids}")

    except Exception as e:
        print(f"出错: {e}")
    time.sleep(1)

def check_home(device, rids, timeout=30):
    """
    等待多个控件的其中一个,只要rids中的其中一个控件存在，则通过
    比如判断有没有进入某个应用，可以通过判断title有没有出现，也可以判断“agree”有没有出现（初次进入）
    """
    # rids = ["com.transsion.phonemaster:id/tv_agree",
    #         "com.transsion.phonemaster:id/tv_title"
    #         ]
    d = u2.connect(device)
    rid=' | '.join([f'//*[@resource-id="{rid}"]' for rid in rids])
    # 等待任意一个元素出现
    try:
        if d.xpath(rid).wait(timeout):#等待该控件timeout秒，如果超时仍没有找到则提示没有找到控件
            # 再获取所有匹配元素
            elements = d.xpath(rid).all()
            if (len(elements) > 0):
                return True
        else:
            print(f"等待超时，未找到元素{rids}")
            return False

    except Exception as e:
        print(f"出错: {e}")
        return False
    time.sleep(1)
def _click_element(element, resource_id, exp):
    if str(element.info.get('clickable', '')).lower() == 'false':
        print(f"{resource_id} 不可点击")
    elif str(element.info.get('checkable', '')).lower() == 'false':
        # 说明他可点击但不是一个开关,默认直接点击
        element.click()
    elif str(element.info.get('checked', '')).lower() == exp:
        # 说明他是一个开关，且是我们想要点击的
        element.click()
def _normalize_expect_param(expect):
    #因为expect必须是字符串类型，容易输错，所以加一个标准化处理
    if expect is None:
        return "true"

    # 处理布尔值
    if isinstance(expect, bool):
        return "true" if expect else "false"

    # 处理字符串
    if isinstance(expect, str):
        expect = expect.lower()
        if expect in ("true", "false"):
            return expect
        # 尝试转换类似 "True"/"False" 的字符串
        if expect.lower() == "true":
            return "true"
        if expect.lower() == "false":
            return "false"

    # 如果无法识别，默认返回 "true"
    return "true"
def touch_rid(device,resource_id,index=0,expect="true"):
    #假设expect="true"，则说明我们希望点击checked==“true”的开关
    exp=_normalize_expect_param(expect)
    #根据resourceid点击相应的控件
    #可能存在多个rid相同的控件，index用来标注我们希望操控的是第几个
    d = u2.connect(device)
    rid = f'//*[@resource-id="{resource_id}"]'
    try:
        elements = d.xpath(resource_id).all()
        if len(elements) <= 0:
            print(f"没有找到{resource_id}")
            return

        # 当index等于元素数量时，点击所有元素
        if index == len(elements):
            for element in elements:
                _click_element(element, resource_id, exp)
            return

        # 否则点击指定index的元素
        if 0 <= index < len(elements):
            element = elements[index]
            _click_element(element, resource_id, exp)
        else:
            print(f"索引{index}超出范围，有效范围是0到{len(elements)}")

    except Exception as e:
        print(f"出错: {e}")
def test1(device):
    #android:id/alertTitle
    wait_rids(device,["com.google.android.setupwizard:id/welcome_title"])
    subprocess.run(
        ['adb', '-s', device, 'shell', 'input', 'tap',
         '570','1450'])
    wait_rids(device, ["com.google.android.setupwizard:id/suc_layout_title"])
    subprocess.run(
        ['adb', '-s', device, 'shell', 'input', 'tap',
         '60', '1450'])
    wait_rids(device, ["com.google.android.setupwizard:id/sud_items_title"])
    subprocess.run(
        ['adb', '-s', device, 'shell', 'input', 'tap',
         '60', '1450'])
    wait_rids(device, ["android:id/button1"])

    subprocess.run(
        ['adb', '-s', device, 'shell', 'input', 'tap',
         '555', '1050'])
    wait_rids(device, ["com.google.android.setupwizard:id/sud_layout_icon"])
    subprocess.run(
        ['adb', '-s', device, 'shell', 'input', 'tap',
         '580', '1450'])
    wait_rids(device, ["com.android.settings:id/sud_layout_icon"])
    subprocess.run(
        ['adb', '-s', device, 'shell', 'input', 'tap',
         '60', '1050'])
    wait_rids(device, ["android:id/button1"])
    subprocess.run(
        ['adb', '-s', device, 'shell', 'input', 'tap',
         '580', '940'])
    time.sleep(1)
    subprocess.run(
        ['adb', '-s', device, 'shell', 'input', 'tap',
         '580','1450'])
    wait_rids(device, ["com.google.android.gms:id/sud_items_icon"])
    subprocess.run(
        ['adb', '-s', device, 'shell', 'input', 'tap',
         '580', '1450'])
    wait_rids(device, ["com.google.android.gms:id/sud_items_title"])
    subprocess.run(
        ['adb', '-s', device, 'shell', 'input', 'tap',
         '580', '1450'])
    # wait_rids(device, ["com.google.android.gms:id/sud_items_title"])
    # subprocess.run(
    #     ['adb', '-s', device, 'shell', 'input', 'tap',
    #      '580', '1450'])
    time.sleep(4)
    if(check_home(device,["com.google.android.apps.searchlite:id/lens_icon"])):
        print("成功过完OOBE")
        pass
    else:
        print("未成功过OOBE")
        input()
        exit(0)
    time.sleep(2)



if __name__ == "__main__":
# 读取所有设备的device
    devices_output = subprocess.run('adb devices', shell=True, capture_output=True, text=True).stdout.strip().split(
        '\n')[
                     1:]
    devices = [device.split('\t')[0] for device in devices_output]

    d = 1
    # 确认操作手机
    for device in devices:
        print(f"{d}.{device}")
    d += 1
    input("请确认机器数量")
    # 多线程处理
    with concurrent.futures.ThreadPoolExecutor() as executor:
        for device in devices:
            executor.submit(test1, device)

    input("执行完成，按任意键继续")