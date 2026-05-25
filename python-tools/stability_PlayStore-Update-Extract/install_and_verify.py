#!/usr/bin/env python3
"""
批量安装 APK 到设备并核对安装前后状态
"""
import json
import re
import subprocess
import sys
from pathlib import Path

SERIAL = "ASALE3741B000022"
APK_ROOT = Path(__file__).resolve().parent / "top50_output"


def adb(args, timeout=120):
    cmd = ["adb", "-s", SERIAL] + args
    r = subprocess.run(cmd, capture_output=True, timeout=timeout,
                       encoding="utf-8", errors="replace")
    stdout = (r.stdout or "").strip()
    stderr = (r.stderr or "").strip()
    return stdout, stderr, r.returncode


def get_pkg_state(pkg):
    out, _, rc = adb(["shell", "dumpsys", "package", pkg], timeout=60)
    if rc != 0 or not out:
        return None, None
    vc = re.search(r'versionCode=(\d+)', out)
    vn = re.search(r'versionName=([^\s]+)', out)
    vc_val = int(vc.group(1)) if vc else None
    vn_val = vn.group(1) if vn else None
    return vc_val, vn_val


def install_apks(app_dir):
    apks = sorted(app_dir.glob("*.apk"))
    if not apks:
        return False, "no APK files found"
    args = ["install-multiple", "-r", "-g", "-d"] + [str(a) for a in apks]
    out, err, rc = adb(args, timeout=300)
    success = "Success" in out or "Success" in err
    msg = (out + err)[:300]
    return success, msg


def main():
    dirs = [d for d in APK_ROOT.iterdir() if d.is_dir() and (d / "metadata.json").exists()]
    dirs.sort()

    print(f"设备: {SERIAL}")
    print(f"待安装: {len(dirs)} 个应用")
    print("=" * 70)

    results = []
    for i, app_dir in enumerate(dirs, 1):
        meta = json.loads((app_dir / "metadata.json").read_text())
        pkg = meta["package"]
        apk_count = len(list(app_dir.glob("*.apk")))

        # 安装前状态
        pre_vc, pre_vn = get_pkg_state(pkg)
        pre_str = f"vc={pre_vc} vn={pre_vn}" if pre_vc else "(未安装)"

        # 已是最新版本则跳过
        if pre_vc is not None and str(pre_vc) == str(meta.get("version_code", "")):
            line = f"[{i:2d}/{len(dirs)}] SKIP {pkg} ({apk_count} apk) | 已是 vc={pre_vc}"
            print(line)
            results.append({"pkg": pkg, "success": True, "pre_vc": pre_vc, "post_vc": pre_vc, "skipped": True})
            continue

        # 安装
        ok, msg = install_apks(app_dir)

        # 安装后状态
        post_vc, post_vn = get_pkg_state(pkg)
        post_str = f"vc={post_vc} vn={post_vn}" if post_vc else "(未安装)"

        status = "OK" if ok else "FAIL"
        delta = ""
        if pre_vc and post_vc and pre_vc != post_vc:
            delta = f" [vc: {pre_vc} -> {post_vc}]"
        elif not pre_vc and post_vc:
            delta = f" [新安装 vc={post_vc}]"
        elif pre_vc and not post_vc:
            delta = " [被卸载!]"
        elif not ok:
            delta = f" [{msg[:100]}]"

        line = f"[{i:2d}/{len(dirs)}] {status} {pkg} ({apk_count} apk) | 前:{pre_str} | 后:{post_str}{delta}"
        print(line)
        results.append({"pkg": pkg, "success": ok, "pre_vc": pre_vc, "post_vc": post_vc,
                         "error": msg if not ok else ""})

    # 汇总
    ok_count = sum(1 for r in results if r["success"])
    fail_count = len(results) - ok_count
    new_installs = sum(1 for r in results if r.get("pre_vc") is None and r.get("post_vc") is not None)
    upgrades = sum(1 for r in results if r.get("pre_vc") and r.get("post_vc") and r["pre_vc"] != r["post_vc"])
    skipped = sum(1 for r in results if r.get("skipped"))

    print()
    print("=" * 70)
    print(f"完成: {ok_count} 成功, {fail_count} 失败 | 新装:{new_installs} 升级:{upgrades} 跳过:{skipped}")

    out_file = APK_ROOT / "install_results.json"
    out_file.write_text(json.dumps(results, ensure_ascii=False, indent=2))
    print(f"结果已写入: {out_file}")

    return 0 if fail_count == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
