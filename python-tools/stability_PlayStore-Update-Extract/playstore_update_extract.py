#!/usr/bin/env python3
"""
Google Play 更新检测与 APK 提取工具
======================================
用途：在稳定性挂测前，通过读取 Play Store 内部数据库获知待更新应用列表，
      在手动更新后自动提取变更的 APK（含 split APK），用于分发到其他样机。

原理：
  1. 读取 Google Play 内部 SQLite 数据库（需要 root）
     - install_queue.db → install_requests 表：待更新队列
     - localappstate.db → appstate 表：应用状态与目标版本
  2. 对设备做版本快照（pm list packages --show-versioncode）
  3. 手动更新前后 diff，确定实际变更的包
  4. 提取变更应用的完整 APK 目录到本地

用法：
  python playstore_update_extract.py check              # 检查待更新应用
  python playstore_update_extract.py snapshot           # 创建当前版本快照
  python playstore_update_extract.py diff <前> <后>      # 对比两次快照
  python playstore_update_extract.py extract <diff文件>  # 提取变更的 APK
  python playstore_update_extract.py full-flow          # 交互式完整流程
"""

import subprocess
import json
import os
import sys
import time
import base64
import sqlite3
import argparse
import re
import tempfile
import shutil
from pathlib import Path
from datetime import datetime
from typing import Optional


# ---------------------------------------------------------------------------
# 工具函数
# ---------------------------------------------------------------------------

PLAYSTORE_DATA = "/data/data/com.android.vending"
DB_INSTALL_QUEUE = f"{PLAYSTORE_DATA}/databases/install_queue.db"
DB_APPSTATE = f"{PLAYSTORE_DATA}/databases/localappstate.db"
DB_AUTO_UPDATE = f"{PLAYSTORE_DATA}/databases/auto_update.db"


def safe_filename(name: str) -> str:
    """将包名转为安全的文件名片段"""
    return name.replace(".", "_").replace(":", "_").replace("/", "_")


def eprint(*args, **kwargs):
    """输出到 stderr（进度信息）"""
    print(*args, file=sys.stderr, **kwargs)


# ---------------------------------------------------------------------------
# ADB 封装
# ---------------------------------------------------------------------------

class AdbHelper:
    """ADB 通信封装，处理 Windows 下的二进制传输问题"""

    def __init__(self, device_id: Optional[str] = None):
        self.device_id = device_id
        self._base = ["adb"]
        if device_id:
            self._base += ["-s", device_id]

    # Windows 下 subprocess 默认编码为 GBK，但 ADB 输出为 UTF-8
    # 且 dumpsys 等命令可能含非 GBK 字节，必须显式指定编码
    _TEXT_KW = {"encoding": "utf-8", "errors": "replace"}

    def run(self, args: list, check=True, text=True):
        """直接调用 adb 命令"""
        kw = {"capture_output": True, "check": check}
        if text:
            kw.update(self._TEXT_KW)
        return subprocess.run(self._base + args, **kw)

    def shell(self, cmd: str, root=False) -> str:
        """执行 adb shell 命令，返回 stdout（已去 \\r）

        root=True 仅当 ADB 不以 root 身份运行时才会尝试提权。
        大多数测试设备 ADB 直接以 root 运行，此时直接执行原命令。
        """
        if root and not self._is_root:
            cmd = f"su -c '{cmd}'"
        result = subprocess.run(
            self._base + ["shell", cmd],
            capture_output=True, **self._TEXT_KW
        )
        return (result.stdout or "").replace("\r", "").strip()

    @property
    def _is_root(self) -> bool:
        if not hasattr(self, "_cached_root"):
            result = subprocess.run(
                self._base + ["shell", "whoami"],
                capture_output=True, **self._TEXT_KW
            )
            self._cached_root = ((result.stdout or "").strip() == "root")
        return self._cached_root

    def check_root(self) -> bool:
        return self.shell("whoami") == "root"

    def pull_db(self, remote_path: str, local_path: str) -> int:
        """通过 base64 编码拉取二进制数据库文件，返回文件大小

        Windows 下 adb pull / adb exec-out 对二进制文件的管道可能截断，
        因此先用设备端 base64 编码，再在本地解码写入。
        """
        tmp = "/data/local/tmp/_pse_tmp_" + os.path.basename(remote_path)
        self.shell(f"cp '{remote_path}' '{tmp}'", root=True)

        result = subprocess.run(
            self._base + ["shell", f"base64 '{tmp}'"],
            capture_output=True, **self._TEXT_KW
        )
        b64_data = (result.stdout or "").replace("\r", "")
        self.shell(f"rm '{tmp}'", root=True)

        decoded = base64.b64decode(b64_data)
        with open(local_path, "wb") as f:
            f.write(decoded)
        return len(decoded)

    def get_device_info(self) -> dict:
        """获取设备基本信息"""
        brand = self.shell("getprop ro.product.brand")
        model = self.shell("getprop ro.product.model")
        android = self.shell("getprop ro.build.version.release")
        sdk = self.shell("getprop ro.build.version.sdk")
        return {
            "brand": brand,
            "model": model,
            "android_version": android,
            "sdk": int(sdk) if sdk.isdigit() else sdk,
        }


# ---------------------------------------------------------------------------
# 1) 检查待更新应用
# ---------------------------------------------------------------------------

class UpdateChecker:
    """通过读取 Play Store 数据库 + UI 抓取获取待更新应用列表"""

    # 显示名 → 包名映射（常见 Google 应用）
    NAME_MAP = {
        "google chrome": "com.android.chrome",
        "chrome": "com.android.chrome",
        "gmail": "com.google.android.gm",
        "google maps": "com.google.android.apps.maps",
        "maps": "com.google.android.apps.maps",
        "youtube": "com.google.android.youtube",
        "google photos": "com.google.android.apps.photos",
        "photos": "com.google.android.apps.photos",
        "google drive": "com.google.android.apps.docs",
        "drive": "com.google.android.apps.docs",
        "google meet": "com.google.android.apps.tachyon",
        "meet": "com.google.android.apps.tachyon",
        "files by google": "com.google.android.apps.nbu.files",
        "google tv": "com.google.android.videos",
        "youtube music": "com.google.android.apps.youtube.music",
        "digital wellbeing": "com.google.android.apps.wellbeing",
        "personal safety": "com.google.android.apps.safetyhub",
        "android switch": "com.google.android.apps.restore",
        "android system intelligence": "com.google.android.as",
        "private compute services": "com.google.android.as.oss",
        "google play services": "com.google.android.gms",
        "google play store": "com.android.vending",
        "gboard": "com.google.android.inputmethod.latin",
        "google text-to-speech": "com.google.android.tts",
        "google tts": "com.google.android.tts",
        "android auto": "com.google.android.projection.gearhead",
        "google": "com.google.android.googlequicksearchbox",
        "google app": "com.google.android.googlequicksearchbox",
        "google search": "com.google.android.googlequicksearchbox",
        "gboard": "com.google.android.inputmethod.latin",
        "gboard - the google keyboard": "com.google.android.inputmethod.latin",
        "live transcribe & notification": "com.google.audio.hearing.visualization.accessibility.scribe",
        "speech recognition & synthesis": "com.google.android.tts",
        "speech services by google": "com.google.android.tts",
        "talkback": "com.google.android.marvin.talkback",
        "google accessibility": "com.google.audio.hearing.visualization.accessibility.scribe",
        # 以下非 Google 应用，仅作占位说明
        "_system_overlay": "",
        "_theme": "",
    }

    def __init__(self, adb: AdbHelper):
        self.adb = adb

    def from_install_queue(self) -> list[dict]:
        """从 install_queue.db 读取批量更新队列"""
        with tempfile.TemporaryDirectory() as tmpdir:
            local_db = os.path.join(tmpdir, "install_queue.db")
            try:
                self.adb.pull_db(DB_INSTALL_QUEUE, local_db)
            except Exception as e:
                eprint(f"[错误] 无法拉取 install_queue.db: {e}")
                return []

            if os.path.getsize(local_db) < 1024:
                eprint("[信息] install_queue.db 为空或过小，Play Store 可能尚未检查更新")
                return []

            conn = sqlite3.connect(local_db)
            cur = conn.cursor()
            cur.execute(
                "SELECT pk, reason, state FROM install_requests "
                "WHERE reason LIKE '%update%' ORDER BY state, pk"
            )
            rows = cur.fetchall()
            conn.close()

        # 一次性获取所有包的版本号（避免逐个 dumpsys）
        ver_map = self._build_version_map()

        # state 含义（经验值）
        state_map = {0: "未知", 4: "下载中", 6: "等待中", 11: "排队中"}
        results = []
        for pkg, reason, state in rows:
            results.append({
                "package": pkg,
                "reason": reason,
                "state": state,
                "state_desc": state_map.get(state, f"未知({state})"),
                "installed_version_code": ver_map.get(pkg, "未安装"),
            })
        return results

    def _build_version_map(self) -> dict[str, str]:
        """通过一次 pm 命令建立包名→版本号的映射"""
        out = self.adb.shell("pm list packages --show-versioncode")
        ver_map = {}
        for line in out.split("\n"):
            line = line.strip()
            if not line.startswith("package:"):
                continue
            # 格式: package:com.example.app versionCode:123
            parts = line[len("package:"):].split(" versionCode:")
            if len(parts) == 2:
                ver_map[parts[0]] = parts[1]
        return ver_map

    def _get_installed_version(self, pkg: str) -> str:
        """兜底：单独查询某个包的版本号（仅当 pm 列表中没有时使用）"""
        out = self.adb.shell(f"dumpsys package {pkg} 2>/dev/null")
        m = re.search(r"versionCode=(\d+)", out)
        return m.group(1) if m else "未安装"

    def _scrape_playstore_ui(self, scroll_rounds: int = 4) -> list[dict]:
        """通过 uiautomator 抓取 Play Store「我的应用」页面中的待更新列表

        当 install_requests 为空时作为补充数据源。
        每次抓取后向下滚动一屏，共 scroll_rounds 轮。
        """
        import xml.etree.ElementTree as ET

        # 启动 My Apps 页面
        eprint("[UI抓取] 打开 Play Store 我的应用...")
        self.adb.shell("am start -a com.google.android.finsky.VIEW_MY_DOWNLOADS")
        time.sleep(3)

        found = {}  # display_name → first_seen_text

        for rnd in range(scroll_rounds):
            # dump UI
            dump_path = "/data/local/tmp/_pse_playstore_ui.xml"
            self.adb.shell(f"uiautomator dump {dump_path}")
            time.sleep(0.5)

            # 读取并解析
            xml_raw = self.adb.shell(f"cat {dump_path}")
            if not xml_raw:
                break

            try:
                root = ET.fromstring(xml_raw)
            except ET.ParseError:
                break

            # 找到所有 "Update" 按钮（排除 "Update all"）
            update_nodes = [
                n for n in root.iter("node")
                if n.get("text") == "Update"
            ]

            for node in update_nodes:
                # 向上查找包含应用名的容器
                name = self._find_app_name_near(node, root)
                if name and name not in found:
                    found[name] = {
                        "display_name": name,
                        "package": self._resolve_package(name),
                        "source": "ui_scrape",
                    }

            if rnd < scroll_rounds - 1:
                # 向下滚动一屏
                self.adb.shell(
                    "input swipe 540 1800 540 600 300"
                )
                time.sleep(1.5)

        # 清理
        self.adb.shell(f"rm {dump_path}")

        results = list(found.values())
        eprint(f"[UI抓取] 完成，发现 {len(results)} 个待更新应用")
        return results

    def _find_app_name_near(self, node, root) -> Optional[str]:
        """在 UI 树中查找 Update 按钮附近的应用显示名"""
        # 向上遍历找到包含多个文本节点的容器
        for _ in range(6):
            parent = None
            for p in root.iter("node"):
                for child in p:
                    if child is node:
                        parent = p
                        break
                if parent is not None:
                    break
            if parent is None:
                break
            texts = [
                n.get("text", "").strip()
                for n in parent.iter("node")
                if n.get("text", "").strip()
                and n.get("text") not in ("Update", "Update all")
            ]
            # 过滤掉纯数字/大小文本（如 "17 MB"）
            names = [t for t in texts if not re.match(r'^[\d.]+ (MB|KB|GB)$', t)]
            if names:
                return names[0]
            node = parent
        return None

    def _resolve_package(self, display_name: str) -> str:
        """通过显示名查找包名"""
        key = display_name.lower().strip()
        if key in self.NAME_MAP:
            return self.NAME_MAP[key]

        # 模糊匹配：用 pm list packages 查找，排除明显非目标包
        _SKIP_PATTERNS = [
            r'overlay', r'theme', r'wallpaper', r'livewallpaper',
            r'smartrecognition', r'factory', r'\.cts\.',
        ]
        keywords = key.split()
        out = self.adb.shell("pm list packages")
        for kw in keywords:
            kw_clean = re.escape(kw.lower())
            for m in re.finditer(rf'package:(\S*{kw_clean}\S*)', out, re.I):
                pkg = m.group(1)
                if any(re.search(pat, pkg, re.I) for pat in _SKIP_PATTERNS):
                    continue
                return pkg
        return ""

    def from_appstate(self) -> list[dict]:
        """从 localappstate.db 的 appstate 表读取所有 Play Store 管理的应用

        当 install_requests 中的 bulk_update 条目被 Play Store 清空后，
        appstate 仍保留完整的受管理应用列表，可作为可靠的回退数据源。
        """
        with tempfile.TemporaryDirectory() as tmpdir:
            local_db = os.path.join(tmpdir, "localappstate.db")
            try:
                self.adb.pull_db(DB_APPSTATE, local_db)
            except Exception as e:
                eprint(f"[错误] 无法拉取 localappstate.db: {e}")
                return []

            if os.path.getsize(local_db) < 1024:
                return []

            conn = sqlite3.connect(local_db)
            cur = conn.cursor()
            cur.execute(
                "SELECT package_name FROM appstate ORDER BY package_name"
            )
            rows = cur.fetchall()
            conn.close()

        ver_map = self._build_version_map()
        results = []
        for (pkg,) in rows:
            results.append({
                "package": pkg,
                "reason": "appstate",
                "state": 0,
                "state_desc": "Play管理",
                "installed_version_code": ver_map.get(pkg, "未安装"),
            })
        return results

    def check(self, show_all=False) -> list[dict]:
        """打印待更新应用列表，返回待更新项列表

        数据来源优先级:
          1. install_requests（瞬态队列，Play Store 首次检查后存在）
          2. appstate（稳定列表，install_queue 被清空后回退使用）
          3. UI 抓取（最后的补充手段）
        """
        print("=" * 70)
        print("  Google Play 待更新应用检测")
        print("=" * 70)

        if not self.adb.check_root():
            print("[错误] 需要 root 权限才能读取 Play Store 数据库")
            print("       请以 root 身份运行: adb root")
            return []

        # 来源 1: install_queue.db
        items = self.from_install_queue()
        source = "install_queue.db"

        # 来源 2: 如果 install_queue 太少，回退到 appstate
        if len(items) < 5:
            eprint(f"[信息] install_queue.db 仅 {len(items)} 条，回退到 appstate...")
            appstate_items = self.from_appstate()
            iq_pkgs = {it["package"] for it in items}
            for a in appstate_items:
                if a["package"] not in iq_pkgs:
                    items.append(a)
            if appstate_items:
                source = f"appstate ({len(appstate_items)}个Play管理应用)"

        if not items:
            print("未检测到待更新应用。可能原因：")
            print("  1. Google Play 尚未联网检查更新")
            print("  2. 所有应用已是最新版本")
            print("  3. Play Store 数据库尚未初始化")
            print()
            print("建议：打开 Google Play → 进入「我的应用」页面触发更新检查，")
            print("      然后重新运行本工具。")
            return []

        items.sort(key=lambda x: x["package"])

        print(f"\n找到 {len(items)} 个待更新应用（数据源: {source}）:\n")
        print(f"  {'包名':<55} {'状态':<12} {'当前版本'}")
        print(f"  {'-'*55} {'-'*12} {'-'*12}")
        for item in items:
            print(f"  {item['package']:<55} {item['state_desc']:<12} {item['installed_version_code']}")

        if show_all:
            self._show_auto_update_config()

        print(f"\n提示：当前所有列出的应用 = {len(items)} 个")
        print("      要开始更新流程，请运行: python playstore_update_extract.py full-flow")
        return items

    def _show_auto_update_config(self):
        """查看 auto_update 配置（辅助信息）"""
        with tempfile.TemporaryDirectory() as tmpdir:
            local_db = os.path.join(tmpdir, "auto_update.db")
            try:
                self.adb.pull_db(DB_AUTO_UPDATE, local_db)
            except Exception:
                return
            conn = sqlite3.connect(local_db)
            cur = conn.cursor()
            cur.execute("SELECT pk FROM auto_update")
            rows = cur.fetchall()
            conn.close()
            print(f"\n  [auto_update.db] 已开启自动更新的应用: {len(rows)} 个")
            for (pkg,) in rows:
                print(f"    - {pkg}")


# ---------------------------------------------------------------------------
# 2) 版本快照
# ---------------------------------------------------------------------------

class PackageSnapshot:
    """设备已安装包的版本快照，用于更新前后 diff"""

    def __init__(self, adb: AdbHelper, snapshot_dir: Path):
        self.adb = adb
        self.snapshot_dir = Path(snapshot_dir)
        self.snapshot_dir.mkdir(parents=True, exist_ok=True)

    def take(self, label: str = "auto") -> Path:
        """获取当前设备所有包的快照，返回快照文件路径"""
        eprint("[快照] 正在获取设备包列表...")

        out = self.adb.shell("pm list packages --show-versioncode -f")
        packages = {}

        for line in out.split("\n"):
            line = line.strip()
            if not line.startswith("package:"):
                continue
            # 格式: package:/path/with/=/base.apk=com.example versionCode:123
            # 注意：Android 10+ 路径含 == (base64 padding)，不能用第一个 = 分割
            m = re.search(r'=([\w.]+)\s+versionCode:(\d+)', line)
            if not m:
                continue
            pkg_name = m.group(1)
            ver_code = m.group(2)
            # APK 路径 = package: 之后、=包名 之前的内容
            apk_path = line[len("package:"):line.rfind("=" + pkg_name)]

            packages[pkg_name] = {
                "apk_path": apk_path,
                "version_code": ver_code,
            }

        # 获取版本名称（对关键包）
        device_info = self.adb.get_device_info()
        snapshot = {
            "timestamp": datetime.now().isoformat(),
            "label": label,
            "device": device_info,
            "package_count": len(packages),
            "packages": packages,
        }

        ts = datetime.now().strftime("%Y%m%d_%H%M%S")
        filename = f"snapshot_{label}_{ts}.json"
        filepath = self.snapshot_dir / filename
        with open(filepath, "w", encoding="utf-8") as f:
            json.dump(snapshot, f, indent=2, ensure_ascii=False)

        eprint(f"[快照] 完成，共 {len(packages)} 个包 → {filepath}")
        return filepath


# ---------------------------------------------------------------------------
# 3) 快照比对
# ---------------------------------------------------------------------------

def load_snapshot(path: str) -> dict:
    with open(path, "r", encoding="utf-8") as f:
        return json.load(f)


def diff_snapshots(before_path: str, after_path: str) -> dict:
    """对比两个快照，返回差异"""
    before = load_snapshot(before_path)
    after = load_snapshot(after_path)

    before_pkgs = before["packages"]
    after_pkgs = after["packages"]

    # 找出变化的包
    added = {}       # 新增的包（after 有, before 无）
    removed = {}     # 被卸载的包（before 有, after 无）
    changed = {}     # 版本变化的包

    all_pkgs = set(before_pkgs.keys()) | set(after_pkgs.keys())
    for pkg in all_pkgs:
        in_before = pkg in before_pkgs
        in_after = pkg in after_pkgs

        if not in_before and in_after:
            added[pkg] = after_pkgs[pkg]
        elif in_before and not in_after:
            removed[pkg] = before_pkgs[pkg]
        elif in_before and in_after:
            old_ver = before_pkgs[pkg]["version_code"]
            new_ver = after_pkgs[pkg]["version_code"]
            if old_ver != new_ver:
                changed[pkg] = {
                    "old_version_code": old_ver,
                    "new_version_code": new_ver,
                    "apk_path": after_pkgs[pkg]["apk_path"],
                }

    result = {
        "before_snapshot": str(before_path),
        "after_snapshot": str(after_path),
        "before_label": before.get("label", ""),
        "after_label": after.get("label", ""),
        "diff_time": datetime.now().isoformat(),
        "summary": {
            "added": len(added),
            "removed": len(removed),
            "changed": len(changed),
            "unchanged": len(before_pkgs) - len(removed) - len(changed),
        },
        "added": added,
        "removed": removed,
        "changed": changed,
    }
    return result


def print_diff(diff: dict):
    """格式化打印 diff 结果"""
    s = diff["summary"]
    print("=" * 70)
    print("  快照对比结果")
    print("=" * 70)
    print(f"  快照前: {diff['before_label']} ({diff['before_snapshot']})")
    print(f"  快照后: {diff['after_label']} ({diff['after_snapshot']})")
    print()
    print(f"  新增:  {s['added']}  卸载: {s['removed']}  "
          f"更新: {s['changed']}  未变: {s['unchanged']}")
    print()

    if s["changed"] == 0:
        print("  没有应用被更新。")
        return

    print(f"  以下 {s['changed']} 个应用被更新:\n")
    print(f"  {'包名':<55} {'旧版本':<12} {'新版本'}")
    print(f"  {'-'*55} {'-'*12} {'-'*12}")
    for pkg, info in sorted(diff["changed"].items()):
        print(f"  {pkg:<55} {info['old_version_code']:<12} {info['new_version_code']}")


# ---------------------------------------------------------------------------
# 4) APK 提取
# ---------------------------------------------------------------------------

class ApkExtractor:
    """从设备提取应用的 APK（含 split APK）"""

    def __init__(self, adb: AdbHelper, output_dir: Path):
        self.adb = adb
        self.output_dir = Path(output_dir)
        self.output_dir.mkdir(parents=True, exist_ok=True)

    SHARED_LIB_DEPS = {
        "com.android.chrome": ["com.google.android.trichromelibrary"],
        "com.google.android.webview": ["com.google.android.trichromelibrary"],
    }

    def _ensure_shared_libs(self, packages: list[str]) -> list[str]:
        """确保共享库依赖也被提取（如 Chrome/WebView → Trichrome Library）

        Trichrome Library 等共享库不作为常规包注册，pm path 查不到。
        先尝试 pm path，失败时回退到 /data/app/ 文件系统搜索。
        """
        needed = set()
        for pkg in packages:
            for lib in self.SHARED_LIB_DEPS.get(pkg, []):
                if lib not in packages and lib not in needed:
                    needed.add(lib)
        if not needed:
            return packages
        for lib in sorted(needed):
            out = self.adb.shell(f"pm path '{lib}' 2>/dev/null")
            if out and "package:" in out:
                eprint(f"[依赖] {lib} (共享库，自动添加)")
                packages.append(lib)
                continue
            # pm path 失败，用文件系统搜索共享库目录
            lib_basename = lib.split(".")[-1]
            find_out = self.adb.shell(
                f"find /data/app -maxdepth 3 -name '*{lib_basename}*' -type d 2>/dev/null"
            )
            if find_out:
                for line in find_out.strip().split("\n"):
                    line = line.strip()
                    if not line:
                        continue
                    # 确认该目录包含 .apk 文件
                    apk_check = self.adb.shell(
                        f"ls '{line}'/*.apk 2>/dev/null"
                    )
                    if apk_check and ".apk" in apk_check:
                        eprint(f"[依赖] {lib} (共享库，文件系统发现: {line})")
                        packages.append(lib)
                        break
                else:
                    eprint(f"[依赖] {lib} 未在设备上找到 APK，跳过")
            else:
                eprint(f"[依赖] {lib} 未在设备上找到 APK，跳过")
        return packages

    def extract_changed(self, diff: dict, dry_run=False) -> list[Path]:
        """根据 diff 结果提取所有变更应用的 APK"""
        changed = diff.get("changed", {})
        if not changed:
            eprint("[提取] 没有变更的应用需要提取")
            return []

        pkg_list = list(changed.keys())
        pkg_list = self._ensure_shared_libs(pkg_list)

        # 为共享库包（不在 diff 中）获取 APK 路径和版本
        extra_info = {}
        for pkg in pkg_list:
            if pkg not in changed:
                apk_path = self._resolve_apk_path(pkg)
                ver_code = self._get_version_code(pkg)
                extra_info[pkg] = (apk_path, ver_code)

        eprint(f"[提取] 共 {len(pkg_list)} 个应用需要提取 APK...")
        extracted = []

        for idx, pkg in enumerate(sorted(pkg_list), 1):
            if pkg in changed:
                info = changed[pkg]
                apk_path = info.get("apk_path", "")
                ver_code = info.get("new_version_code", "")
            else:
                apk_path, ver_code = extra_info[pkg]

            eprint(f"  [{idx}/{len(pkg_list)}] {pkg}")

            if dry_run:
                eprint(f"         (dry-run) 跳过: {apk_path}")
                continue

            if not apk_path:
                eprint(f"    [错误] 无法定位 APK 路径")
                continue

            pkg_dir = self._extract_package(pkg, apk_path, version_code=ver_code)
            if pkg_dir:
                extracted.append(pkg_dir)

        return extracted

    def _extract_package(self, pkg: str, apk_path: str,
                         version_code: str = "") -> Optional[Path]:
        """提取单个包的所有 APK 文件

        Android 10+ 的包路径示例：
          /data/app/~~hash~~/com.google.android.youtube-XXXX==/base.apk
        Android 9- 的包路径示例：
          /data/app/com.google.android.youtube-1/base.apk

        需要提取整个父目录（包含 base.apk + 所有 split APK）
        version_code: 当前安装的版本号，用于安装后校验升级是否生效
        """
        # 获取包含 base.apk 的目录
        apk_dir = os.path.dirname(apk_path)  # 如 /data/app/~~hash~~/pkg-XXXX==

        if not apk_dir or apk_dir == "/":
            eprint(f"    [错误] 无法解析 APK 路径: {apk_path}")
            return None

        # 列出该目录下所有 .apk 文件
        files_out = self.adb.shell(f"ls -1 '{apk_dir}'/*.apk 2>/dev/null", root=True)
        if not files_out:
            # 尝试不带 root
            files_out = self.adb.shell(f"ls -1 '{apk_dir}'/*.apk 2>/dev/null")
        if not files_out:
            eprint(f"    [错误] 目录为空: {apk_dir}")
            return None

        apk_files = [f.strip() for f in files_out.split("\n") if f.strip().endswith(".apk")]
        if not apk_files:
            eprint(f"    [错误] 未找到 .apk 文件: {apk_dir}")
            return None

        # 创建本地子目录
        safe_name = safe_filename(pkg)
        local_dir = self.output_dir / safe_name
        local_dir.mkdir(parents=True, exist_ok=True)

        # 拉取每个 APK
        for remote_apk in apk_files:
            apk_filename = os.path.basename(remote_apk)
            local_path = local_dir / apk_filename

            # 先复制到 /sdcard 再拉取（规避 Windows adb pull 路径问题）
            tmp = f"/data/local/tmp/_pse_apk_{apk_filename}"
            self.adb.shell(f"cp '{remote_apk}' '{tmp}'", root=True)

            result = subprocess.run(
                self.adb._base + ["pull", tmp, str(local_path)],
                capture_output=True, **self.adb._TEXT_KW
            )
            self.adb.shell(f"rm '{tmp}'", root=True)

            if result.returncode != 0:
                eprint(f"    [警告] 拉取失败: {remote_apk}")
                continue
            eprint(f"    ✓ {apk_filename} ({os.path.getsize(local_path)} bytes)")

        # 获取版本名称
        version_name = self._get_version_name(pkg)

        # 记录元信息
        meta = {
            "package": pkg,
            "version_code": version_code,
            "version_name": version_name,
            "remote_dir": apk_dir,
            "apk_files": [os.path.basename(f) for f in apk_files],
        }
        with open(local_dir / "metadata.json", "w", encoding="utf-8") as f:
            json.dump(meta, f, indent=2, ensure_ascii=False)

        eprint(f"    → {local_dir}")
        return local_dir

    def _get_version_name(self, pkg: str) -> str:
        """获取包的 versionName（human-readable）"""
        out = self.adb.shell(f"dumpsys package {pkg} 2>/dev/null | grep versionName")
        m = re.search(r"versionName=(\S+)", out)
        return m.group(1) if m else ""

    def _get_version_code(self, pkg: str) -> str:
        """获取包的 versionCode"""
        out = self.adb.shell(
            f"dumpsys package {pkg} 2>/dev/null | grep versionCode"
        )
        m = re.search(r"versionCode=(\d+)", out)
        return m.group(1) if m else ""

    def _resolve_apk_path(self, pkg: str) -> str:
        """获取包的 APK 路径（base.apk 或单 APK 文件）

        先尝试 pm path（适用常规包），失败时回退到 /data/app/ 文件系统搜索
        （适用于 Trichrome Library 等共享库）。
        """
        out = self.adb.shell(f"pm path '{pkg}' 2>/dev/null")
        if out:
            for line in out.split("\n"):
                line = line.strip()
                if line.startswith("package:"):
                    apk_path = line[len("package:"):]
                    if apk_path.endswith(".apk"):
                        return apk_path
        # pm path 失败 → 文件系统搜索
        lib_basename = pkg.split(".")[-1]
        find_out = self.adb.shell(
            f"find /data/app -maxdepth 3 -name '*{lib_basename}*' -type d 2>/dev/null"
        )
        if find_out:
            for line in find_out.strip().split("\n"):
                line = line.strip()
                if not line:
                    continue
                apk_check = self.adb.shell(
                    f"ls '{line}'/*.apk 2>/dev/null"
                )
                if apk_check and ".apk" in apk_check:
                    # 返回第一个 .apk 文件路径（通常为 base.apk）
                    for apk_line in apk_check.strip().split("\n"):
                        apk_line = apk_line.strip()
                        if apk_line.endswith(".apk"):
                            return apk_line
        return ""

    def pull_packages(self, packages: list[str], dry_run=False) -> list[Path]:
        """直接按包名提取 APK（不依赖 diff/snapshot）

        先通过 pm path 找到每个包的 base.apk 路径，再拉取整个目录。
        提取前获取版本号，写入 metadata.json 供安装后校验。
        适用于：已在 Play Store 更新完应用，只需将当前版本的 APK 取出分发。
        """
        if not packages:
            eprint("[提取] 包名列表为空")
            return []

        packages = self._ensure_shared_libs(packages)

        # 一次性获取所有包版本号 + APK 路径映射
        eprint(f"[提取] 正在定位 {len(packages)} 个包的 APK 路径与版本...")
        ver_map = UpdateChecker(self.adb)._build_version_map()

        pkg_path_map = {}
        for pkg in packages:
            apk_path = self._resolve_apk_path(pkg)
            if not apk_path:
                eprint(f"  [跳过] {pkg}: 未找到 APK")
                continue
            pkg_path_map[pkg] = (apk_path, ver_map.get(pkg, ""))

        if not pkg_path_map:
            eprint("[提取] 未找到任何可提取的包")
            return []

        eprint(f"[提取] 共 {len(pkg_path_map)} 个包待提取...")
        extracted = []
        for idx, (pkg, (apk_path, ver_code)) in enumerate(
            sorted(pkg_path_map.items()), 1
        ):
            eprint(f"  [{idx}/{len(pkg_path_map)}] {pkg}  (版本: {ver_code})")
            if dry_run:
                eprint(f"         (dry-run) 跳过: {apk_path}")
                continue
            pkg_dir = self._extract_package(pkg, apk_path, version_code=ver_code)
            if pkg_dir:
                extracted.append(pkg_dir)
        return extracted

def _make_device_output_dir(adb: AdbHelper, explicit: str = "") -> tuple[Path, dict]:
    """根据设备信息生成输出目录名: extracted_apks_{brand}_{model}_Android{version}/"""
    info = adb.get_device_info()
    if explicit and explicit.strip():
        out_dir = Path(explicit)
    else:
        model = re.sub(r'[^A-Za-z0-9._-]', '-', info.get("model", "unknown")).strip("-")
        android = f"Android{info.get('android_version', '0')}"
        dirname = f"extracted_apks_{model}_{android}"
        out_dir = Path(f"./{dirname}")
    out_dir.mkdir(parents=True, exist_ok=True)
    # 写入设备信息
    ts = datetime.now().strftime("%Y%m%d_%H%M%S")
    info["extracted_at"] = ts
    info_path = out_dir / "device_info.json"
    if not info_path.exists():
        with open(info_path, "w", encoding="utf-8") as f:
            json.dump(info, f, indent=2, ensure_ascii=False)
    return out_dir, info


def cmd_check(args):
    adb = AdbHelper(args.device)
    checker = UpdateChecker(adb)
    pending = checker.check(show_all=args.verbose)

    # 如果指定了 --save，将包名列表写入文件供后续 pull 使用
    if args.save and pending:
        pkg_list = [item["package"] for item in pending]
        save_path = Path(args.save)
        save_path.parent.mkdir(parents=True, exist_ok=True)
        with open(save_path, "w", encoding="utf-8") as f:
            f.write("\n".join(pkg_list) + "\n")
        print(f"\n包名列表已保存到: {save_path}")
        print(f"更新完成后运行: python playstore_update_extract.py pull --from-file {save_path}")


def cmd_snapshot(args):
    adb = AdbHelper(args.device)
    out_dir = Path(args.output) if args.output else Path("./snapshots")
    snap = PackageSnapshot(adb, out_dir)
    path = snap.take(label=args.label)
    print(f"\n快照已保存: {path}")
    print(f"下一步：在设备上通过 Google Play 更新全部应用")
    print(f"        然后再次运行 snapshot 创建更新后的快照")
    print(f"        最后运行 diff 对比两个快照")


def cmd_diff(args):
    result = diff_snapshots(args.before, args.after)
    print_diff(result)

    # 保存 diff 结果
    ts = datetime.now().strftime("%Y%m%d_%H%M%S")
    out_path = args.output or f"diff_{ts}.json"
    with open(out_path, "w", encoding="utf-8") as f:
        json.dump(result, f, indent=2, ensure_ascii=False)
    print(f"\nDiff 已保存: {out_path}")
    print(f"下一步：python playstore_update_extract.py extract {out_path}")


def cmd_extract(args):
    diff_path = args.diff_file
    if not os.path.exists(diff_path):
        eprint(f"[错误] 找不到 diff 文件: {diff_path}")
        sys.exit(1)

    diff = load_snapshot(diff_path)
    adb = AdbHelper(args.device)
    out_dir, dev_info = _make_device_output_dir(adb, args.output)
    extractor = ApkExtractor(adb, out_dir)
    results = extractor.extract_changed(diff, dry_run=args.dry_run)

    print(f"\n提取完成，共 {len(results)} 个应用 → {out_dir.absolute()}")
    print(f"  设备: {dev_info['brand']} {dev_info['model']} (Android {dev_info['android_version']})")
    if results:
        print("\n提取的应用:")
        for r in results:
            print(f"  {r.name}")


def cmd_pull(args):
    """直接按包名提取 APK，不依赖快照/diff"""
    packages = []
    if args.from_file:
        p = Path(args.from_file)
        if not p.exists():
            eprint(f"[错误] 文件不存在: {args.from_file}")
            sys.exit(1)
        packages = [line.strip() for line in p.read_text(encoding="utf-8").splitlines()
                    if line.strip() and not line.strip().startswith("#")]
        eprint(f"[信息] 从文件读取 {len(packages)} 个包名: {args.from_file}")
    if args.packages:
        packages.extend(args.packages)

    # 去重
    packages = list(dict.fromkeys(packages))
    if not packages:
        eprint("[错误] 未指定包名。用法: pull <包名1> [包名2 ...] 或 pull --from-file packages.txt")
        sys.exit(1)

    adb = AdbHelper(args.device)
    out_dir, dev_info = _make_device_output_dir(adb, args.output)
    extractor = ApkExtractor(adb, out_dir)
    results = extractor.pull_packages(packages, dry_run=args.dry_run)

    print(f"\n提取完成，共 {len(results)}/{len(packages)} 个应用 → {out_dir.absolute()}")
    print(f"  设备: {dev_info['brand']} {dev_info['model']} (Android {dev_info['android_version']})")
    if results:
        print("\n提取的应用:")
        for r in results:
            print(f"  {r.name}")


def cmd_full_flow(args):
    """交互式完整流程"""
    print("=" * 70)
    print("  Google Play 更新检测 & APK 提取 — 完整流程")
    print("=" * 70)
    print()

    adb = AdbHelper(args.device)

    # ---- Step 1: 检查 root ----
    print("[Step 1/5] 检查设备连接与 root 权限...")
    if not adb.check_root():
        print("[错误] 需要 root 权限。请先执行: adb root")
        sys.exit(1)
    info = adb.get_device_info()
    print(f"         设备: {info['brand']} {info['model']} (Android {info['android_version']})")
    print()

    # ---- Step 2: 查看待更新列表 ----
    print("[Step 2/5] 读取 Google Play 待更新队列...")
    checker = UpdateChecker(adb)
    pending = checker.from_install_queue()
    if pending:
        state_map = {0: "未知", 4: "下载中", 6: "等待中", 11: "排队中"}
        print(f"         发现 {len(pending)} 个待更新应用:")
        for item in pending:
            print(f"           {item['package']:<50} [{item['state_desc']}]")
    else:
        print("         未检测到待更新应用。如果 Play Store 尚未检查更新，")
        print("         请手动打开 Google Play → 我的应用 → 检查更新。")
    print()

    # ---- Step 3: 更新前快照 ----
    print("[Step 3/5] 创建更新前版本快照...")
    snap_dir = Path(args.snapshot_dir) if args.snapshot_dir else Path("./snapshots")
    snap = PackageSnapshot(adb, snap_dir)
    before_path = snap.take(label="before_update")
    print()

    # ---- Step 4: 等待手动更新 ----
    print("[Step 4/5] 请在设备上手动操作:")
    print("          " + "=" * 50)
    print("          1. 打开 Google Play 商店")
    print("          2. 点击右上角头像 →「管理应用和设备」")
    print("          3. 点击「全部更新」")
    print("          4. 等待所有应用更新完成")
    print("          5. 确认 Play Store 显示「所有应用已是最新版本」")
    print("          " + "=" * 50)
    print()
    input("          完成后按 Enter 继续...")
    print()

    # ---- Step 5: 更新后快照 + diff + 提取 ----
    print("[Step 5/5] 创建更新后版本快照...")
    after_path = snap.take(label="after_update")

    print()
    print("[Diff] 对比快照...")
    diff = diff_snapshots(str(before_path), str(after_path))
    print_diff(diff)

    # 保存 diff
    ts = datetime.now().strftime("%Y%m%d_%H%M%S")
    diff_path = snap_dir / f"diff_{ts}.json"
    with open(diff_path, "w", encoding="utf-8") as f:
        json.dump(diff, f, indent=2, ensure_ascii=False)

    if diff["summary"]["changed"] == 0:
        print("\n没有检测到应用变更，流程结束。")
        return

    print(f"\n[提取] 正在提取 {diff['summary']['changed']} 个更新应用的 APK...")
    out_dir, dev_info = _make_device_output_dir(adb, args.output)
    extractor = ApkExtractor(adb, out_dir)
    results = extractor.extract_changed(diff, dry_run=args.dry_run)
    print(f"  设备: {dev_info['brand']} {dev_info['model']} (Android {dev_info['android_version']})")

    print()
    print("=" * 70)
    print("  流程完成！")
    print("=" * 70)
    print(f"  快照前: {before_path}")
    print(f"  快照后: {after_path}")
    print(f"  Diff:   {diff_path}")
    print(f"  APK:    {out_dir.absolute()} ({len(results)} 个应用)")
    print()
    print("  分发方式：")
    print(f"    adb install-multiple {out_dir.absolute()}/<应用名>/*.apk")
    print(f"    或逐个: adb install {out_dir.absolute()}/<应用名>/base.apk")


# ---------------------------------------------------------------------------
# 入口
# ---------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(
        description="Google Play 更新检测与 APK 提取工具",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
示例:
  %(prog)s check                    检查待更新应用
  %(prog)s check --save pkgs.txt    检查并保存包名列表
  %(prog)s pull pkg1 pkg2          直接按包名提取 APK
  %(prog)s pull --from-file pkgs.txt  从文件读取包名提取 APK
  %(prog)s snapshot                 创建版本快照
  %(prog)s diff before.json after.json  对比两次快照
  %(prog)s extract diff.json        根据 diff 提取更新的 APK
  %(prog)s full-flow                交互式完整流程（推荐）
        """,
    )
    parser.add_argument("--device", "-s", help="指定设备序列号（多设备时使用）")

    sub = parser.add_subparsers(dest="command", help="子命令")

    # check
    p_check = sub.add_parser("check", help="检查 Play Store 待更新应用列表")
    p_check.add_argument("--verbose", "-v", action="store_true", help="显示 auto_update 配置等额外信息")
    p_check.add_argument("--save", "-S", help="将待更新包名列表保存到文件（供 pull --from-file 使用）")
    p_check.set_defaults(func=cmd_check)

    # pull — 直接按包名提取 APK
    p_pull = sub.add_parser("pull", help="直接按包名提取 APK（不依赖快照/diff）")
    p_pull.add_argument("packages", nargs="*", help="要提取的包名（可多个）")
    p_pull.add_argument("--from-file", "-f", help="从文件读取包名（每行一个，# 开头为注释）")
    p_pull.add_argument("--output", "-o", default="", help="APK 输出目录（默认按设备型号自动命名）")
    p_pull.add_argument("--dry-run", action="store_true", help="只显示要提取的，不实际执行")
    p_pull.set_defaults(func=cmd_pull)

    # snapshot
    p_snap = sub.add_parser("snapshot", help="创建当前所有包版本快照")
    p_snap.add_argument("--label", "-l", default="auto", help="快照标签")
    p_snap.add_argument("--output", "-o", default="./snapshots", help="快照输出目录")
    p_snap.set_defaults(func=cmd_snapshot)

    # diff
    p_diff = sub.add_parser("diff", help="对比两个快照")
    p_diff.add_argument("before", help="更新前的快照 JSON")
    p_diff.add_argument("after", help="更新后的快照 JSON")
    p_diff.add_argument("--output", "-o", help="保存 diff 结果到文件")
    p_diff.set_defaults(func=cmd_diff)

    # extract
    p_ext = sub.add_parser("extract", help="根据 diff 提取变更应用的 APK")
    p_ext.add_argument("diff_file", help="diff 生成的 JSON 文件")
    p_ext.add_argument("--output", "-o", default="", help="APK 输出目录（默认按设备型号自动命名）")
    p_ext.add_argument("--dry-run", action="store_true", help="只显示要提取的，不实际执行")
    p_ext.set_defaults(func=cmd_extract)

    # full-flow
    p_full = sub.add_parser("full-flow", help="交互式完整流程（推荐）")
    p_full.add_argument("--snapshot-dir", default="./snapshots", help="快照存放目录")
    p_full.add_argument("--output", "-o", default="", help="APK 输出目录（默认按设备型号自动命名）")
    p_full.add_argument("--dry-run", action="store_true", help="跳过实际 APK 提取")
    p_full.set_defaults(func=cmd_full_flow)

    args = parser.parse_args()

    if args.command is None:
        parser.print_help()
        sys.exit(1)

    args.func(args)


if __name__ == "__main__":
    main()
