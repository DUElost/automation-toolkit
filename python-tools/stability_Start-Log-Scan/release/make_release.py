# -*- coding: utf-8 -*-
"""生成发布产物：把工具目录导出到 <out>/<version>/，并写入 release.json。

用法（在仓库内运行）：
    python release/make_release.py --tag start-log-scan/v2.1.0 --out /path/to/dist

前置检查（任何一项失败即退出，不产出）：
- tag 已存在，且指向当前 HEAD；
- 工具目录没有未提交改动；
- tag 版本与 modules/common/Version.py 的 VERSION 一致（V2.1.0_YYYYMMDD ↔ v2.1.0）；
- 输出目录不存在（已发布版本不可原地修改）。

release.json 字段：tool、version、tag、git_commit、git_dirty、built_at、files_sha256、
files_mode（git 文件模式）、executables（模式为 100755 的文件）。导出文件按 git 模式设置权限。
运行时由 modules/dedup/membership.py 读取，写入 sidecar 的 meta.tool。
"""
import argparse
import datetime
import hashlib
import json
import os
import re
import shutil
import subprocess
import sys

TOOL_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
TAG_PREFIX = "start-log-scan/v"


def git(*args):
    return subprocess.check_output(["git", "-C", TOOL_DIR] + list(args)).decode("utf-8").strip()


def fail(msg):
    sys.stderr.write("发布中止：{}\n".format(msg))
    sys.exit(1)


def tool_version():
    sys.path.insert(0, TOOL_DIR)
    from modules.common.Version import VERSION
    match = re.match(r"[vV](\d+\.\d+\.\d+)_\d{8}$", VERSION)
    if not match:
        fail("Version.py 的 VERSION 格式应为 V<x.y.z>_<YYYYMMDD>：{}".format(VERSION))
    return match.group(1), VERSION


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--tag", required=True)
    parser.add_argument("--out", required=True)
    args = parser.parse_args()

    if not args.tag.startswith(TAG_PREFIX):
        fail("tag 必须以 {} 开头".format(TAG_PREFIX))
    tag_version = args.tag[len(TAG_PREFIX):]
    version, version_string = tool_version()
    if tag_version != version:
        fail("tag 版本 {} 与 Version.py {} 不一致".format(tag_version, version_string))
    head = git("rev-parse", "HEAD")
    try:
        tag_commit = git("rev-list", "-n", "1", args.tag)
    except subprocess.CalledProcessError:
        fail("tag {} 不存在".format(args.tag))
    if tag_commit != head:
        fail("tag {} 指向 {}，不是当前 HEAD {}".format(args.tag, tag_commit, head))
    if git("status", "--porcelain", "--", "."):
        fail("工具目录有未提交改动")

    dest = os.path.join(os.path.abspath(args.out), version)
    if os.path.exists(dest):
        fail("{} 已存在；已发布版本不可原地修改".format(dest))

    rel_prefix = git("rev-parse", "--show-prefix")
    # ls-files -s：<mode> <blob> <stage>\t<path>；记录 git 文件模式，导出时还原可执行位
    listed = subprocess.check_output(["git", "-C", TOOL_DIR, "ls-files", "-s", "-z", "--full-name", "--", "."])
    file_modes = {}
    for entry in listed.decode("utf-8").split("\0"):
        if not entry:
            continue
        meta, path = entry.split("\t", 1)
        if path.startswith(rel_prefix):
            file_modes[path[len(rel_prefix):]] = meta.split(" ")[0]
    files = [f for f in file_modes if f and not f.startswith("tests/")]
    final_dest = dest
    dest = final_dest + ".partial"
    if os.path.exists(dest):
        shutil.rmtree(dest)
    os.makedirs(dest)
    hashes = {}
    for rel in sorted(files):
        data = subprocess.check_output(["git", "-C", TOOL_DIR, "show", "{}:{}{}".format(head, rel_prefix, rel)])
        target = os.path.join(dest, rel)
        os.makedirs(os.path.dirname(target), exist_ok=True)
        with open(target, "wb") as f:
            f.write(data)
        os.chmod(target, 0o755 if file_modes[rel] == "100755" else 0o644)
        hashes[rel] = hashlib.sha256(data).hexdigest()

    release = {
        "tool": "start-log-scan",
        "version": version,
        "version_string": version_string,
        "tag": args.tag,
        "git_commit": head,
        "git_dirty": False,
        "built_at": datetime.datetime.now().astimezone().isoformat(timespec="seconds"),
        "files_sha256": hashes,
        # git 文件模式（100644 / 100755），部署方据此校验可执行位
        "files_mode": {rel: file_modes[rel] for rel in sorted(files)},
        "executables": sorted(rel for rel in files if file_modes[rel] == "100755"),
    }
    with open(os.path.join(dest, "release.json"), "w", encoding="utf-8") as f:
        json.dump(release, f, ensure_ascii=False, indent=1, sort_keys=True)
    os.rename(dest, final_dest)
    print(final_dest)


if __name__ == "__main__":
    main()
