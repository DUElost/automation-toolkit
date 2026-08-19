# -*- coding: utf-8 -*-
"""去重：同根因归并（参照反编译 compare_Similarity_all_data 语义 + MTK 思路）。

分组规则：
1. 前置条件：ExpClass + Package 相同（不同类/不同包不比较）
2. 指纹优先：NE 类 CausedBy 提取 pc 地址指纹（pc 0000...），同 pc 才合并——
   不同 pc 的 backtrace 首帧因公共前后缀占比高，SequenceMatcher 会误并（实测 0.947>=0.9）
3. 无指纹（JE 异常行/SWT Blocked in/SR 等）：SequenceMatcher ratio（>= 阈值入组）
4. 组保留 ExpTime 最早的代表条目，sum = 组内条数；DeviceCount = 组内不同设备数。
"""

import re
from difflib import SequenceMatcher

from modules.classify import expclass_family

_PC_RE = re.compile(r"pc\s+[0-9a-fA-F]{6,}")


def _clean_for_compare(text):
    """MTK get_str_similar 清洗（format_str）：去除数字/0x 地址/@ 符号。

    用于 SequenceMatcher 比较前——141439（for 365s）与 141606（for 31s）
    仅阻塞秒数不同，清洗后一致才可归为同类。
    """
    text = re.sub(r"0x[a-zA-Z0-9]+", "", text)
    text = re.sub(r"@[a-zA-Z0-9]+", "", text)
    return re.sub(r"\d", "", text)


def _fingerprint(rec):
    """去重指纹：NE 类取 backtrace 首帧 pc 地址（同崩溃点硬匹配）；其余无指纹走相似度。"""
    caused = rec.get("CausedBy", "") or ""
    if expclass_family(rec.get("ExpClass")) == "NE":
        m = _PC_RE.search(caused)
        return ("pc", m.group(0).lower()) if m else ("raw", caused)
    return ("raw", caused)


def dedup(records, config=None):
    """records: 12 列 dict 列表 -> (before, after)。"""
    threshold = 0.9
    if config:
        threshold = config.get("dedup", {}).get("similarity_threshold", threshold)

    before = [dict(r, sum=1, DeviceCount=1) for r in records]

    groups = []  # [(代表 rec, [成员 rec])]
    for rec in records:
        key = (rec.get("ExpClass"), rec.get("Package"))
        caused = rec.get("CausedBy", "")
        fp_kind, fp_val = _fingerprint(rec)
        matched = None
        for g in groups:
            rep = g[0]
            if (rep.get("ExpClass"), rep.get("Package")) != key:
                continue
            if not caused or not rep.get("CausedBy"):
                # 均无关键行：同秒视为同一事件（uniview 包 + dropbox 包同秒双写）
                if (caused == rep.get("CausedBy")
                        and rec.get("ExpTime") and rec.get("ExpTime") == rep.get("ExpTime")):
                    matched = g
                continue
            rfp_kind, rfp_val = _fingerprint(rep)
            if fp_kind == "pc" and rfp_kind == "pc":
                # NE：pc 地址相同才合并（不同崩溃点不并）
                if fp_val == rfp_val:
                    matched = g
                continue
            # 非 NE：MTK 清洗（去数字/0x/@）后比较，阻塞秒数等动态值不干扰
            c1 = _clean_for_compare(rep.get("CausedBy", ""))
            c2 = _clean_for_compare(caused)
            if c1 and c2:
                ratio = SequenceMatcher(None, c1, c2).ratio()
                if ratio >= threshold:
                    matched = g
                    break
            elif SequenceMatcher(None, rep.get("CausedBy", ""), caused).ratio() >= threshold:
                matched = g
                break
        if matched is None:
            groups.append((rec, [rec]))
        else:
            matched[1].append(rec)

    after = []
    for rep, members in groups:
        best = rep
        for m in members:
            if m["ExpTime"] and (not best["ExpTime"] or m["ExpTime"] < best["ExpTime"]):
                best = m
        out = dict(best)
        out["sum"] = len(members)
        # 出现该问题的样机次数（组内不同设备数）
        out["DeviceCount"] = len({m.get("snNum", "") for m in members if m.get("snNum")})
        # Rom_Ram：组内唯一配置集合（跨设备配置不同时拼接，如 64GB+4GB/128GB+4GB）
        rr_set = []
        for m in members:
            rr = m.get("Rom_Ram")
            if rr and rr not in rr_set:
                rr_set.append(rr)
        if rr_set:
            out["Rom_Ram"] = "/".join(rr_set)
        after.append(out)
    after.sort(key=lambda r: (r["ExpClass"], r["Package"], r["ExpTime"]))
    return before, after
