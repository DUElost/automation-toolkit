# -*- coding: utf-8 -*-
"""成员关系 sidecar（stp.scan_membership v1.0）。

契约：stability-test-platform B8，/mnt/project-files/b8/scan-tool-membership-contract-draft.md
与规划者冻结补充 scan-tool-membership-contract-planner-review.md。
只依赖标准库。
"""
import datetime
import hashlib
import json
import os
import re
import subprocess

from modules.dedup.aee_rule import CAUSED_BY_TRUNCATE, normalize_caused_by, rule_descriptor, sha256_text

SCHEMA = "stp.scan_membership"
SCHEMA_VERSION = "1.0"
TOOL_NAME = "start-log-scan"

BRANCH_SIMILARITY = "similarity"
BRANCH_SINGLETON = "singleton"
BRANCH_FILTERED = "filtered"

_DISCARD_VERSIONS = frozenset({
    "discard_dbg_version",
    "discard_ota_ke_dbg_version",
    "discard_db_file_map_exception",
})

_TOOL_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))


class AeeMembershipTrace(object):
    """_aee_to_data_list 一次调用内每个 org 行的去向。下标均为 0 起。"""

    def __init__(self, threshold):
        self.threshold = threshold
        self.rows = {}          # org_index -> dict
        self.group_rows = {}    # final_index -> [org_index, ...]
        self.compare_errors = 0

    def add_row(self, org_index, path_raw):
        self.rows[org_index] = {"path_raw": path_raw, "branch": None, "filter_reason": None,
                                "final_index": None, "is_representative": False, "similarity": None}

    def filtered(self, org_index, reason):
        row = self.rows[org_index]
        row["branch"] = BRANCH_FILTERED
        row["filter_reason"] = reason

    def new_group(self, org_index, final_index, branch):
        row = self.rows[org_index]
        row["branch"] = branch
        row["final_index"] = final_index
        row["is_representative"] = True
        self.group_rows[final_index] = [org_index]

    def join_group(self, org_index, final_index, ratio):
        row = self.rows[org_index]
        row["branch"] = BRANCH_SIMILARITY
        row["final_index"] = final_index
        row["similarity"] = round(float(ratio), 4)
        self.group_rows[final_index].append(org_index)


def compose_incremental_trace(org_list, full_trace, delta_org, delta_trace):
    """-inc：把差集上的去重结果映射回全量 org 行。

    delta_org 中的行对象来自 org_list（同一 list 对象），按 id 对应。
    不在差集中的行记为 filtered：discard 行为 preanalyse_discard，其余为 incremental_prev_path。
    """
    composed = AeeMembershipTrace(full_trace.threshold)
    org_pos = {id(row): i for i, row in enumerate(org_list)}
    delta_to_org = {}
    if delta_trace is not None:
        for d_index, row in enumerate(delta_org):
            delta_to_org[d_index] = org_pos[id(row)]
    for org_index in range(len(org_list)):
        path_raw = full_trace.rows.get(org_index, {}).get("path_raw", org_list[org_index][0])
        composed.add_row(org_index, path_raw)
    if delta_trace is not None:
        for d_index, d_row in delta_trace.rows.items():
            target = composed.rows[delta_to_org[d_index]]
            for key in ("branch", "filter_reason", "final_index", "is_representative", "similarity"):
                target[key] = d_row[key]
        for final_index, members in delta_trace.group_rows.items():
            composed.group_rows[final_index] = [delta_to_org[m] for m in members]
        composed.compare_errors = delta_trace.compare_errors
    for org_index, row in composed.rows.items():
        if row["branch"] is None:
            row["branch"] = BRANCH_FILTERED
            row["filter_reason"] = ("preanalyse_discard" if _is_discard(org_list[org_index])
                                    else "incremental_prev_path")
    return composed


def _is_discard(org_row):
    return len(org_row) > 1 and org_row[1] in _DISCARD_VERSIONS


def _device_id(value):
    if value is None:
        return None
    value = str(value).strip()
    if not value or value.lower() in ("none", "undefined", "unknown_device_id", "discard_device_id"):
        return None
    return value


def _file_sha256(path):
    if not path or not os.path.isfile(path):
        return None
    digest = hashlib.sha256()
    with open(path, "rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            digest.update(chunk)
    return digest.hexdigest()


def _git_commit():
    try:
        out = subprocess.run(["git", "-C", _TOOL_ROOT, "rev-parse", "HEAD"], stdout=subprocess.PIPE,
                             stderr=subprocess.DEVNULL, timeout=5)
        commit = out.stdout.decode().strip() if out.returncode == 0 else ""
        if not commit:
            return "unknown", None
        dirty = subprocess.run(["git", "-C", _TOOL_ROOT, "status", "--porcelain", "--", "."],
                               stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, timeout=5)
        return commit, bool(dirty.stdout.strip()) if dirty.returncode == 0 else None
    except Exception:
        return "unknown", None


def load_release_info():
    path = os.path.join(_TOOL_ROOT, "release.json")
    try:
        with open(path, encoding="utf-8") as f:
            return json.load(f)
    except Exception:
        return None


def tool_meta():
    from modules.common.Version import VERSION
    release = load_release_info()
    if release:
        version = release.get("version")
        commit = release.get("git_commit") or "unknown"
        dirty = release.get("git_dirty")
    else:
        match = re.match(r"[vV](\d+(?:\.\d+)*)", VERSION)
        version = match.group(1) if match else VERSION
        commit, dirty = _git_commit()
    return {"name": TOOL_NAME, "version": version, "version_string": VERSION,
            "git_commit": commit, "git_dirty": dirty, "release": release}


def parsers_meta():
    version = None
    try:
        from importlib import metadata  # Python 3.8+
        version = metadata.version("recognizeexception")
    except Exception:
        version = None
    if not version:
        try:
            from modules.common.GlobalAttrs import RECOGNIZE_LIB_VERSION
            match = re.search(r"recognizeexception\s+([0-9][0-9A-Za-z.\-]*)", RECOGNIZE_LIB_VERSION)
            version = match.group(1) if match else RECOGNIZE_LIB_VERSION
        except Exception:
            version = None
    return {"recognizeexception": version}


def build_meta(threshold, config=None, run=None, reports=None):
    meta = {"tool": tool_meta(), "parsers": parsers_meta(), "rule": rule_descriptor(threshold)}
    if config is not None:
        meta["config"] = config
    if run is not None:
        meta["run"] = run
    if reports is not None:
        meta["reports"] = reports
    return meta


def report_entry(path, rows):
    if not path:
        return None
    return {"file": os.path.basename(path), "sha256": _file_sha256(path), "rows": rows}


def build_sidecar(org_list, final_list, trace, meta, final_written=True):
    """按契约组装 sidecar dict。

    :param org_list: 写入 org.xls 的行（顺序即 xls 行序）
    :param final_list: 写入去重 xls 的行
    :param trace: AeeMembershipTrace，下标对应 org_list
    """
    rows = []
    stats = {"rows": len(org_list), BRANCH_FILTERED: 0, BRANCH_SINGLETON: 0, BRANCH_SIMILARITY: 0,
             "groups": 0, "compare_errors": trace.compare_errors if trace else 0}
    filter_reasons = {}
    for org_index, org_row in enumerate(org_list):
        t = trace.rows.get(org_index) if trace else None
        if t is None:
            # _save_discard_to_org 追加的预分析丢弃行，不经过去重
            t = {"path_raw": org_row[0], "branch": BRANCH_FILTERED, "filter_reason": "preanalyse_discard",
                 "final_index": None, "is_representative": False, "similarity": None}
        caused_by = str(org_row[8]) if len(org_row) > 8 else ""
        group = None if t["final_index"] is None else "g{}".format(t["final_index"] + 1)
        rows.append({
            "org_row": org_index + 1,
            "path": org_row[0],
            "path_raw": t["path_raw"],
            "device_id": _device_id(org_row[12] if len(org_row) > 12 else None),
            "branch": t["branch"],
            "filter_reason": t["filter_reason"],
            "group": group,
            "is_representative": bool(t["is_representative"]),
            "similarity_to_rep": t["similarity"],
            "signature": {
                "exp_class": org_row[3],
                "package": org_row[6],
                "caused_by_sha256": sha256_text(caused_by),
                "caused_by_norm_sha256": sha256_text(normalize_caused_by(caused_by)),
            },
        })
        stats[t["branch"]] += 1
        if t["filter_reason"]:
            filter_reasons[t["filter_reason"]] = filter_reasons.get(t["filter_reason"], 0) + 1

    groups = []
    group_rows = trace.group_rows if trace else {}
    for final_index in sorted(group_rows):
        members = sorted(group_rows[final_index])
        rep_index = members[0]
        rep_row = org_list[rep_index]
        rep_caused_by = str(rep_row[8])[:CAUSED_BY_TRUNCATE]
        final_row = final_list[final_index] if final_index < len(final_list) else None
        device_ids = sorted({d for d in (_device_id(org_list[m][12] if len(org_list[m]) > 12 else None)
                                         for m in members) if d})
        groups.append({
            "group": "g{}".format(final_index + 1),
            "final_row": final_index + 1 if (final_written and final_row is not None) else None,
            "representative_row": rep_index + 1,
            "member_rows": [m + 1 for m in members],
            "count": final_row[10] if final_row is not None else len(members),
            "device_ids": device_ids,
            "entered_by": trace.rows[rep_index]["branch"],
            "representative_signature": {
                "exp_class": rep_row[3],
                "package": rep_row[6],
                "caused_by": rep_caused_by,
                "caused_by_norm": normalize_caused_by(rep_caused_by),
            },
        })
    stats["groups"] = len(groups)
    stats["filter_reasons"] = dict(sorted(filter_reasons.items()))
    return {"schema": SCHEMA, "schema_version": SCHEMA_VERSION, "meta": meta,
            "rows": rows, "groups": groups, "stats": stats}


def members_path_for(org_or_final_xls_path):
    """Result_…_org.xls / Result_….xls → Result_…_members.json"""
    base = os.path.basename(org_or_final_xls_path)
    stem = base[:-len("_org.xls")] if base.endswith("_org.xls") else os.path.splitext(base)[0]
    return os.path.join(os.path.dirname(org_or_final_xls_path), stem + "_members.json")


def write_sidecar(path, sidecar):
    tmp = path + ".tmp"
    with open(tmp, "w", encoding="utf-8") as f:
        json.dump(sidecar, f, ensure_ascii=False, indent=1)
    os.replace(tmp, path)
    return path


def now_iso():
    return datetime.datetime.now().astimezone().isoformat(timespec="seconds")
