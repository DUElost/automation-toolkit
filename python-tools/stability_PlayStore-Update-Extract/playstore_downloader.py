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
import sys
import time
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

    args = parser.parse_args()

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
        ts = datetime.now().strftime("%Y%m%d_%H%M%S")
        output_dir = Path(f"downloaded_apks_{ts}")
    output_dir.mkdir(parents=True, exist_ok=True)

    # 写入设备信息
    device_info = {
        "source": "google_play_direct",
        "auth_method": "google_account" if args.email else "anonymous",
        "downloaded_at": datetime.now().strftime("%Y%m%d_%H%M%S"),
    }
    (output_dir / "device_info.json").write_text(
        json.dumps(device_info, ensure_ascii=False, indent=2) + "\n"
    )

    eprint(f"[输出] {output_dir}")
    eprint()

    # 逐个下载
    ok = 0
    skip = 0
    fail = 0

    for i, pkg in enumerate(packages, 1):
        app_dir = output_dir / safe_filename(pkg)
        if args.skip_existing and app_dir.exists() and (app_dir / "metadata.json").exists():
            eprint(f"[{i}/{len(packages)}] 跳过 {pkg}（已存在）")
            skip += 1
            continue

        if args.dry_run:
            try:
                details = downloader.get_details(pkg)
                inner = details.get("details", {}).get("appDetails", {})
                vc = inner.get("versionCode", "?")
                vn = inner.get("versionString", "?")
                eprint(f"[{i}/{len(packages)}] {pkg}  versionCode={vc}  versionName={vn}")
                ok += 1
            except Exception as exc:
                eprint(f"[{i}/{len(packages)}] {pkg}  查询失败: {exc}")
                fail += 1
            continue

        eprint(f"[{i}/{len(packages)}] {pkg}")
        try:
            downloader.download_to_dir(pkg, output_dir)
            ok += 1
        except Exception as exc:
            eprint(f"         失败: {exc}")
            fail += 1

        # 请求间短暂延迟，避免触发频率限制（匿名模式尤其需要）
        if i < len(packages):
            time.sleep(1.5)

    eprint()
    eprint(f"  完成: {ok} 成功, {skip} 跳过, {fail} 失败")
    eprint(f"  输出: {output_dir}")
    eprint("=" * 60)

    sys.exit(0 if fail == 0 else 1)


if __name__ == "__main__":
    main()
