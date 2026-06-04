#!/usr/bin/env python3
"""
Google Play 直接下载工具
========================
通过包名直接从 Google Play 下载最新 APK（含 split APK），
无需设备侧 Google Play 更新 → 提取流程。

用途：给定一个包名列表 + 目标设备型号，直接产出可批量的 APK 目录。

依赖：playstoreapi（匿名/Google 账号认证）

用法：
  # 匿名模式（通过 Aurora token dispenser，无需 Google 账号）
  python playstore_downloader.py --from-file pkgs.txt
  python playstore_downloader.py com.android.chrome com.google.android.webview

  # Google 账号模式（首次需要邮箱 + 应用专用密码）
  python playstore_downloader.py --from-file pkgs.txt --email you@gmail.com

认证说明：
  - 匿名模式：通过 AuroraOSS 公共 token dispenser 认证，无需 Google 账号。
    限制：请求频率和并发受限，适合少量下载。
  - 账号模式：使用自己的 Google 账号 + 应用专用密码。
    首次登录后缓存的 token 保存在 ~/.config/playstoreapi/ 或 ./.playstoreapi，
    后续无需重复输入密码。
"""

import argparse
import json
import os
import re
import subprocess
import sys
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from datetime import datetime
from pathlib import Path

from playstoreapi.googleplay import GooglePlayAPI

# ---------------------------------------------------------------------------
# 工具函数
# ---------------------------------------------------------------------------

def safe_filename(name: str) -> str:
    return name.replace(".", "_").replace(":", "_").replace("/", "_")

def eprint(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)

def _run(cmd: list[str], timeout: int = 60) -> str:
    r = subprocess.run(
        cmd,
        capture_output=True,
        timeout=timeout,
        encoding="utf-8",
        errors="replace",
    )
    out = (r.stdout or "").strip()
    err = (r.stderr or "").strip()
    if r.returncode != 0:
        raise RuntimeError(f"command failed rc={r.returncode}: {' '.join(cmd)} | {err[:200]}")
    return out

def _adb(serial: str, args: list[str], timeout: int = 60) -> str:
    return _run(["adb", "-s", serial] + args, timeout=timeout)

def _adb_shell(serial: str, shell_cmd: str, timeout: int = 60) -> str:
    return _adb(serial, ["shell", shell_cmd], timeout=timeout)

def _getprop(serial: str, key: str) -> str:
    try:
        return _adb_shell(serial, f"getprop {key}", timeout=30).strip()
    except Exception:
        return ""

def _parse_wm_size(wm_out: str) -> tuple[str, str]:
    # 兼容输出：Physical size: 1080x2436 / Override size: ...
    m = re.search(r"Physical size:\s*(\d+)\s*x\s*(\d+)", wm_out)
    if m:
        return m.group(1), m.group(2)
    m = re.search(r"(\d+)\s*x\s*(\d+)", wm_out)
    if m:
        return m.group(1), m.group(2)
    return "", ""

def _parse_wm_density(wm_out: str) -> str:
    # 兼容输出：Physical density: 480 / Override density: ...
    m = re.search(r"Physical density:\s*(\d+)", wm_out)
    if m:
        return m.group(1)
    m = re.search(r"\b(\d+)\b", wm_out)
    return m.group(1) if m else ""

def collect_device_profile(serial: str, profile_name: str, base_dir: Path) -> Path:
    """
    从连接设备采集“设备画像”并写入 device_profiles/<profile_name>.json
    说明：该画像主要用于记录设备信息，便于下载/分发时追溯；不会影响匿名下载逻辑。
    """
    base_dir.mkdir(parents=True, exist_ok=True)

    brand = _getprop(serial, "ro.product.brand")
    model = _getprop(serial, "ro.product.model")
    device = _getprop(serial, "ro.product.device")
    manufacturer = _getprop(serial, "ro.product.manufacturer")
    product = _getprop(serial, "ro.product.name") or _getprop(serial, "ro.product.product.name")
    hardware = _getprop(serial, "ro.hardware")
    build_id = _getprop(serial, "ro.build.id")
    fingerprint = _getprop(serial, "ro.build.fingerprint")
    android_version = _getprop(serial, "ro.build.version.release")
    sdk = _getprop(serial, "ro.build.version.sdk")
    locale = _getprop(serial, "persist.sys.locale") or _getprop(serial, "ro.product.locale")
    timezone = _getprop(serial, "persist.sys.timezone")

    wm_size = _adb_shell(serial, "wm size", timeout=30)
    wm_density = _adb_shell(serial, "wm density", timeout=30)
    screen_width, screen_height = _parse_wm_size(wm_size)
    screen_density = _parse_wm_density(wm_density)

    abilist = _getprop(serial, "ro.product.cpu.abilist")
    platforms = [a.strip() for a in abilist.split(",") if a.strip()]

    # Play Store 版本信息（尽力采集，失败则留空）
    vending_version_code = ""
    vending_version_name = ""
    try:
        dumpsys_pkg = _adb(serial, ["shell", "dumpsys", "package", "com.android.vending"], timeout=60)
        m_code = re.search(r"\bversionCode=(\d+)", dumpsys_pkg)
        m_name = re.search(r"\bversionName=([^\s]+)", dumpsys_pkg)
        vending_version_code = m_code.group(1) if m_code else ""
        vending_version_name = m_name.group(1) if m_name else ""
    except Exception:
        pass

    saved_at = datetime.now().strftime("%Y%m%d_%H%M%S")
    profile = {
        "schema_version": 1,
        "profile_name": profile_name,
        "saved_at": saved_at,
        "profile": {
            "device_id": serial,
            "info": {
                "serial": serial,
                "brand": brand,
                "model": model,
                "device": device,
                "manufacturer": manufacturer,
                "product": product,
                "hardware": hardware,
                "build_id": build_id,
                "fingerprint": fingerprint,
                "android_version": android_version,
                "sdk": sdk,
                "screen_width": screen_width,
                "screen_height": screen_height,
                "screen_density": screen_density,
                "platforms": platforms,
                "play_locale": locale,
                "timezone": timezone,
                "vending_version_code": vending_version_code,
                "vending_version_name": vending_version_name,
            },
            "locale": locale,
            "timezone": timezone,
            "overrides": {},
            "case_overrides": {},
        },
    }

    out_path = base_dir / f"{profile_name}.json"
    out_path.write_text(json.dumps(profile, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    return out_path

def load_device_profile(profile_name: str, base_dir: Path) -> dict:
    path = base_dir / f"{profile_name}.json"
    if not path.exists():
        raise FileNotFoundError(f"device profile not found: {path}")
    return json.loads(path.read_text(encoding="utf-8", errors="replace"))

def _default_output_dir_from_profile(profile: dict) -> str:
    info = (profile.get("profile") or {}).get("info") or {}
    brand = (info.get("brand") or "").strip()
    model = (info.get("model") or "").strip()
    android_version = (info.get("android_version") or "").strip()

    # 尽量贴近仓库里已有目录命名习惯：downloaded_apks_<Brand Model>_Android<ver>
    parts = []
    if brand:
        parts.append(brand)
    if model and model.lower() not in brand.lower():
        parts.append(model)
    device_name = " ".join(parts).strip() or (profile.get("profile_name") or "device")
    device_name = re.sub(r"\s+", " ", device_name).strip()

    suffix = f"_Android{android_version}" if android_version else ""
    return f"downloaded_apks_{device_name}{suffix}"


# ---------------------------------------------------------------------------
# 下载器
# ---------------------------------------------------------------------------

class PlayStoreDownloader:
    """封装 Google Play API 的 APK 下载器"""

    def __init__(self, locale: str = "en_US", timezone: str = "America/New_York"):
        self.api = GooglePlayAPI(locale, timezone)
        self.api.ssl_verify = True

    def login_anonymous(self) -> bool:
        """匿名登录（通过 Aurora token dispenser）"""
        eprint("[认证] 正在通过 Aurora token dispenser 匿名登录...")
        try:
            self.api.login(anonymous=True)
            eprint(f"[认证] 匿名登录成功 (GSF ID: {self.api.gsfId})")
            return True
        except Exception as exc:
            eprint(f"[认证] 匿名登录失败: {exc}")
            return False

    def login_email(self, email: str) -> bool:
        """Google 账号登录（首次需要密码，后续复用缓存 token）"""
        from getpass import getpass

        # 先尝试缓存的 token
        cached = self._load_cached_config()
        if cached:
            eprint("[认证] 发现缓存 token，尝试复用...")
            try:
                self.api.login(gsfId=int(cached["gsfId"]), authSubToken=cached["authSubToken"])
                eprint("[认证] 缓存 token 有效")
                return True
            except Exception:
                eprint("[认证] 缓存 token 已过期，需要重新登录")

        password = getpass(f"请输入 Google 账号 [{email}] 的应用专用密码: ")
        eprint("[认证] 正在登录 Google 账号...")
        try:
            self.api.login(email=email, password=password)
            self._save_config()
            eprint("[认证] 登录成功，token 已缓存")
            return True
        except Exception as exc:
            eprint(f"[认证] 登录失败: {exc}")
            return False

    def _config_path(self) -> Path:
        return Path.home() / ".config" / "playstoreapi" / "credentials.json"

    def _load_cached_config(self) -> dict | None:
        path = self._config_path()
        if path.exists():
            try:
                return json.loads(path.read_text())
            except Exception:
                pass
        return None

    def _save_config(self) -> None:
        path = self._config_path()
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(json.dumps({
            "gsfId": str(self.api.gsfId),
            "authSubToken": self.api.authSubToken,
        }))

    def get_details(self, package: str) -> dict:
        """获取应用详情"""
        return self.api.details(package)

    def download(self, package: str, version_code: int | None = None) -> dict:
        """下载 APK，返回包含 URL 和各 split 信息的字典"""
        return self.api.download(package, versionCode=version_code)

    def download_to_dir(self, package: str, output_dir: Path, version_code: int | None = None) -> Path:
        """下载 APK 并按目录结构保存

        返回应用子目录路径。
        目录结构：
          <output_dir>/
            com_example_app/
              base.apk
              split_*.apk
              metadata.json
        """
        import requests

        app_dir = output_dir / safe_filename(package)
        app_dir.mkdir(parents=True, exist_ok=True)

        # 获取下载链接信息（含重试）
        eprint(f"  [下载] {package} ...")
        delivery = None
        last_err = None
        for attempt in range(3):
            try:
                delivery = self.download(package, version_code)
                break
            except Exception as exc:
                last_err = exc
                if attempt < 2:
                    wait = (attempt + 1) * 3
                    eprint(f"         获取下载链接失败，重试 {attempt+1}/3 ({wait}s后)...")
                    time.sleep(wait)
        if delivery is None:
            raise last_err

        # 下载 base APK
        base_url = delivery["file"]["url"]
        base_cookies = delivery["file"]["cookies"]
        self._fetch_and_save(base_url, base_cookies, app_dir / "base.apk")

        split_count = 0
        apk_files = ["base.apk"]

        # 下载 split APK
        for split in delivery.get("splits", []):
            split_url = split["file"]["url"]
            split_cookies = split["file"]["cookies"]
            split_name = split.get("name", "unknown.apk")
            if not split_name.endswith(".apk"):
                split_name += ".apk"
            self._fetch_and_save(split_url, split_cookies, app_dir / split_name)
            apk_files.append(split_name)
            split_count += 1

        # 获取版本信息
        app_details = delivery.get("docId", {})
        version_code_actual = version_code
        version_name = ""
        try:
            details = self.get_details(package)
            inner = details.get("details", {}).get("appDetails", {})
            version_code_actual = inner.get("versionCode", version_code)
            version_name = inner.get("versionString", "")
        except Exception:
            pass

        # 写入 metadata.json（与现有提取工具格式兼容）
        metadata = {
            "package": package,
            "version_code": str(version_code_actual),
            "version_name": version_name,
            "source": "google_play_direct",
            "apk_files": apk_files,
        }
        (app_dir / "metadata.json").write_text(json.dumps(metadata, ensure_ascii=False, indent=2) + "\n")

        split_info = f" +{split_count} splits" if split_count > 0 else ""
        eprint(f"         {len(apk_files)} APK{'' if len(apk_files) == 1 else 's'}{split_info} -> {app_dir.name}")

        return app_dir

    def _fetch_and_save(self, url: str, cookies: dict, dest: Path, max_retries: int = 3) -> None:
        """下载文件并保存，支持断点续传式重试"""
        import requests
        last_err = None
        for attempt in range(max_retries):
            try:
                resp = requests.get(url, cookies=cookies, timeout=300, stream=True)
                resp.raise_for_status()
                with open(dest, "wb") as f:
                    for chunk in resp.iter_content(chunk_size=8192):
                        f.write(chunk)
                file_size_mb = dest.stat().st_size / (1024 * 1024)
                eprint(f"         {dest.name} ({file_size_mb:.1f}MB)")
                return
            except (requests.exceptions.ConnectionError,
                    requests.exceptions.ChunkedEncodingError,
                    requests.exceptions.Timeout) as exc:
                last_err = exc
                if attempt < max_retries - 1:
                    wait = (attempt + 1) * 3
                    eprint(f"         重试 {attempt+1}/{max_retries} ({wait}s后)... {exc!r:.80}")
                    time.sleep(wait)
        raise last_err


# ---------------------------------------------------------------------------
# 命令行入口
# ---------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(
        description="Google Play 直接下载工具 — 通过包名从 Google Play 下载最新 APK",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
示例:
  python playstore_downloader.py --from-file pkgs.txt
  python playstore_downloader.py com.android.chrome com.google.android.webview
  python playstore_downloader.py --from-file pkgs.txt --email you@gmail.com
  python playstore_downloader.py --from-file pkgs.txt --output ./my_apks --dry-run
  python playstore_downloader.py --from-file pkgs.txt --jobs 4
  python playstore_downloader.py --collect-device-profile my_phone --device <serial>
  python playstore_downloader.py --list-device-profiles
        """,
    )
    parser.add_argument(
        "packages", nargs="*",
        help="要下载的包名列表（可多个）"
    )
    parser.add_argument(
        "--from-file", "-f",
        help="从文件读取包名列表（每行一个）"
    )
    parser.add_argument(
        "--output", "-o", default=None,
        help="输出目录（默认按设备型号自动命名，匿名模式下使用 download_<时间戳>）"
    )
    parser.add_argument(
        "--email", "-e",
        help="Google 账号邮箱（不提供则使用匿名模式）"
    )
    parser.add_argument(
        "--dry-run", "-n", action="store_true",
        help="仅显示将要下载的应用信息，不实际下载"
    )
    parser.add_argument(
        "--skip-existing", action="store_true",
        help="跳过输出目录中已存在的应用"
    )
    parser.add_argument(
        "--jobs", "-j", type=int, default=1,
        help="并行下载线程数（默认 1；匿名模式建议 1~2，账号模式可适当提高）",
    )
    parser.add_argument(
        "--collect-device-profile",
        help="采集当前设备画像并保存到 ./device_profiles/<name>.json（需配合 --device）",
    )
    parser.add_argument(
        "--list-device-profiles", action="store_true",
        help="列出 ./device_profiles 下已有的设备画像",
    )
    parser.add_argument(
        "--device",
        help="ADB 设备序列号（用于采集设备画像）",
    )
    parser.add_argument(
        "--device-profile",
        help="使用 ./device_profiles/<name>.json 中的设备画像（用于输出目录命名与信息记录）",
    )
    parser.add_argument(
        "--no-device-profile", action="store_true",
        help="禁用设备画像（不读取 ./device_profiles，输出目录使用时间戳命名）",
    )

    args = parser.parse_args()

    script_dir = Path(__file__).resolve().parent
    profiles_dir = script_dir / "device_profiles"

    if args.list_device_profiles:
        if not profiles_dir.exists():
            print("(empty) device_profiles directory not found")
            sys.exit(0)
        items = sorted(profiles_dir.glob("*.json"))
        if not items:
            print("(empty) no profiles")
            sys.exit(0)
        for p in items:
            print(p.stem)
        sys.exit(0)

    if args.collect_device_profile:
        if not args.device:
            eprint("[错误] 缺少 --device <serial>，请先用 adb devices 获取序列号")
            sys.exit(2)
        try:
            out = collect_device_profile(args.device, args.collect_device_profile, profiles_dir)
            print(str(out))
            sys.exit(0)
        except Exception as exc:
            eprint(f"[错误] 采集设备画像失败: {exc}")
            sys.exit(1)

    # 收集包名
    packages = list(args.packages)
    if args.from_file:
        pkg_file = Path(args.from_file)
        if not pkg_file.exists():
            eprint(f"[错误] 包名文件不存在: {args.from_file}")
            sys.exit(1)
        with open(pkg_file) as f:
            for line in f:
                line = line.strip()
                if line and not line.startswith("#"):
                    packages.append(line)

    if not packages:
        parser.print_help()
        sys.exit(1)

    # 去重
    packages = list(dict.fromkeys(packages))

    eprint("=" * 60)
    eprint("  Google Play 直接下载工具")
    eprint("=" * 60)
    eprint(f"  包名数量: {len(packages)}")
    eprint(f"  认证方式: {'Google 账号' if args.email else '匿名 (Aurora token dispenser)'}")
    eprint(f"  并行任务: {max(1, int(args.jobs))}")
    eprint()

    # 认证
    downloader = PlayStoreDownloader()
    if args.email:
        if not downloader.login_email(args.email):
            sys.exit(1)
    else:
        if not downloader.login_anonymous():
            sys.exit(1)

    # 输出目录
    if args.output:
        output_dir = Path(args.output)
    else:
        device_profile_obj = None
        if not args.no_device_profile and args.device_profile:
            try:
                device_profile_obj = load_device_profile(args.device_profile, profiles_dir)
            except Exception as exc:
                eprint(f"[警告] 读取 device profile 失败，将回退到时间戳目录: {exc}")
                device_profile_obj = None

        if device_profile_obj:
            output_dir = Path(_default_output_dir_from_profile(device_profile_obj))
        else:
            ts = datetime.now().strftime("%Y%m%d_%H%M%S")
            output_dir = Path(f"downloaded_apks_{ts}")
    output_dir.mkdir(parents=True, exist_ok=True)

    # 写入设备信息
    device_info = {
        "source": "google_play_direct",
        "auth_method": "google_account" if args.email else "anonymous",
        "downloaded_at": datetime.now().strftime("%Y%m%d_%H%M%S"),
    }
    if not args.no_device_profile and args.device_profile:
        device_info["device_profile"] = args.device_profile
        try:
            device_info["device_profile_data"] = load_device_profile(args.device_profile, profiles_dir)
        except Exception as exc:
            device_info["device_profile_error"] = str(exc)
    (output_dir / "device_info.json").write_text(
        json.dumps(device_info, ensure_ascii=False, indent=2) + "\n"
    )

    eprint(f"[输出] {output_dir}")
    eprint()

    ok = 0
    skip = 0
    fail = 0

    total = len(packages)
    jobs = max(1, int(args.jobs))
    if not args.email and jobs > 2:
        eprint("[提示] 当前为匿名模式，并行过高容易触发频率限制；建议 --jobs 1~2")

    # dry-run 查询串行即可（避免高频触发限制）
    if args.dry_run:
        for i, pkg in enumerate(packages, 1):
            try:
                details = downloader.get_details(pkg)
                inner = details.get("details", {}).get("appDetails", {})
                vc = inner.get("versionCode", "?")
                vn = inner.get("versionString", "?")
                eprint(f"[{i}/{total}] {pkg}  versionCode={vc}  versionName={vn}")
                ok += 1
            except Exception as exc:
                eprint(f"[{i}/{total}] {pkg}  查询失败: {exc}")
                fail += 1
        eprint()
        eprint(f"  完成: {ok} 成功, {skip} 跳过, {fail} 失败")
        eprint(f"  输出: {output_dir}")
        eprint("=" * 60)
        sys.exit(0 if fail == 0 else 1)

    # 过滤掉 skip-existing
    work_items: list[tuple[int, str]] = []
    for i, pkg in enumerate(packages, 1):
        app_dir = output_dir / safe_filename(pkg)
        if args.skip_existing and app_dir.exists() and (app_dir / "metadata.json").exists():
            eprint(f"[{i}/{total}] 跳过 {pkg}（已存在）")
            skip += 1
        else:
            work_items.append((i, pkg))

    def _download_one(item: tuple[int, str]) -> tuple[int, str, bool, str]:
        i, pkg = item
        try:
            downloader.download_to_dir(pkg, output_dir)
            return i, pkg, True, ""
        except Exception as exc:
            return i, pkg, False, str(exc)

    if jobs == 1:
        for i, pkg in work_items:
            eprint(f"[{i}/{total}] {pkg}")
            _, _, success, msg = _download_one((i, pkg))
            if success:
                ok += 1
            else:
                eprint(f"         失败: {msg}")
                fail += 1
            if i < total:
                time.sleep(1.5)
    else:
        eprint(f"[并行] 启动 {jobs} 个下载任务（失败会在汇总中显示）")
        with ThreadPoolExecutor(max_workers=jobs) as ex:
            fut_map = {ex.submit(_download_one, it): it for it in work_items}
            for fut in as_completed(fut_map):
                i, pkg = fut_map[fut]
                try:
                    ii, pp, success, msg = fut.result()
                except Exception as exc:
                    ii, pp, success, msg = i, pkg, False, str(exc)
                if success:
                    eprint(f"[{ii}/{total}] OK   {pp}")
                    ok += 1
                else:
                    eprint(f"[{ii}/{total}] FAIL {pp} | {msg}")
                    fail += 1

    eprint()
    eprint(f"  完成: {ok} 成功, {skip} 跳过, {fail} 失败")
    eprint(f"  输出: {output_dir}")
    eprint("=" * 60)

    sys.exit(0 if fail == 0 else 1)


if __name__ == "__main__":
    main()
