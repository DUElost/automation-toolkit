# -*- coding: utf-8 -*-
"""MTK AEE 去重规则（唯一实现）。

扫描内去重（BaseScan._aee_to_data_list）与对已有问题匹配（-match_issues）
共用本模块。只依赖标准库，Python 3.7+ 可用，控制面可以不装 xlrd/xlwt 直接调用。

规则（rule id = mtk-aee-dedup，version 见 RULE_VERSION）：
- singleton：Path 含 "fatal" 且 CausedBy 含 "detailToBeDone"，直接成为新组代表，自身不比较；
  后续行仍可能并入它。
- similarity：ExpClass 完全相等、Package 完全相等、
  str_similar(代表 CausedBy, 行 CausedBy) >= threshold；按代表顺序取首个命中。
- 比较抛异常按"不命中"处理并计数。

改动任何语义都必须提升 RULE_VERSION。
"""
import difflib
import hashlib
import json
import re

RULE_ID = "mtk-aee-dedup"
RULE_VERSION = "1"
DEFAULT_THRESHOLD = 90
CAUSED_BY_TRUNCATE = 10000

_SPRD_MINIDUMP_KE = "*** sprd minidump ke ***"
_SPRD_KERNEL_CRASH = "exception_reboot_reason: kernel_crash"
_RE_HEX = re.compile(r'0x[a-zA-Z0-9]+')
_RE_AT = re.compile(r'@[a-zA-Z0-9]+')
_RE_DIGIT = re.compile(r'\d')


def normalize_caused_by(text):
    """比较前的归一化：去掉 0x…、@…、所有数字。"""
    text = _RE_HEX.sub('', text)
    text = _RE_AT.sub('', text)
    return _RE_DIGIT.sub('', text)


def str_similar(str_1, str_2, format_str=True, absolute_equal=False):
    """计算两个字符串的相似度（0–100）。AEE 与 TNE 共用。"""
    if absolute_equal:
        return 100 if str_1 == str_2 else 0

    if _SPRD_MINIDUMP_KE in str_1 and _SPRD_MINIDUMP_KE in str_2:
        if _SPRD_KERNEL_CRASH in str_1 and _SPRD_KERNEL_CRASH in str_2:
            return 100 if str_1 == str_2 else 0
        return 0

    if _SPRD_MINIDUMP_KE in str_1 or _SPRD_MINIDUMP_KE in str_2:
        return 0

    if format_str:
        str_1 = normalize_caused_by(str_1)
        str_2 = normalize_caused_by(str_2)

    return difflib.SequenceMatcher(None, str_1, str_2).quick_ratio() * 100


def is_singleton(path, caused_by):
    return "fatal" in str(path) and "detailToBeDone" in str(caused_by)


def find_first_match(reps, exp_class, package, caused_by, threshold=DEFAULT_THRESHOLD):
    """在代表序列中找首个命中。

    :param reps: 可迭代的 (exp_class, package, caused_by) 三元组，按比较顺序
    :return: (index 或 None, 比分 或 None, 本次比较异常次数)
    """
    errors = 0
    for index, (rep_class, rep_package, rep_caused_by) in enumerate(reps):
        if rep_class != exp_class:
            continue
        if rep_package != package:
            continue
        try:
            ratio = str_similar(rep_caused_by, caused_by)
            if ratio >= threshold:
                return index, ratio, errors
        except Exception:
            errors += 1
    return None, None, errors


def rule_params(threshold=DEFAULT_THRESHOLD):
    return {
        "key_fields": ["exp_class", "package"],
        "similarity": "difflib.quick_ratio",
        "normalize": ["strip:0x[0-9a-zA-Z]+", "strip:@[0-9a-zA-Z]+", "strip:digits"],
        "threshold": threshold,
        "caused_by_truncate": CAUSED_BY_TRUNCATE,
        "match": "first_hit_in_order",
        "singleton": "path~fatal && caused_by~detailToBeDone",
    }


def sha256_text(text):
    return hashlib.sha256(str(text).encode("utf-8")).hexdigest()


def rule_descriptor(threshold=DEFAULT_THRESHOLD):
    params = rule_params(threshold)
    canonical = json.dumps(params, sort_keys=True, separators=(",", ":"), ensure_ascii=False)
    return {
        "id": RULE_ID,
        "version": RULE_VERSION,
        "params": params,
        "params_sha256": sha256_text(canonical),
    }


def match_issues(existing, rows, threshold=DEFAULT_THRESHOLD):
    """把待匹配行对已有问题代表做归并。

    :param existing: [{"issue_id", "exp_class", "package", "caused_by"}]，按比较顺序
    :param rows: [{"ref", "exp_class", "package", "caused_by", "path"}]，按处理顺序
    :return: (results, compare_errors)
    """
    reps = [(e["exp_class"], e["package"], str(e["caused_by"])[:CAUSED_BY_TRUNCATE]) for e in existing]
    owners = [("issue", e["issue_id"]) for e in existing]
    results = []
    errors = 0
    new_count = 0
    for row in rows:
        caused_by = str(row["caused_by"])[:CAUSED_BY_TRUNCATE]
        key = (row["exp_class"], row["package"], caused_by)
        if is_singleton(row.get("path", ""), caused_by):
            branch, index, ratio = "singleton", None, None
        else:
            branch = "similarity"
            index, ratio, err = find_first_match(reps, row["exp_class"], row["package"], caused_by, threshold)
            errors += err
        if index is not None:
            kind, ident = owners[index]
            results.append({
                "ref": row["ref"], "branch": branch,
                "matched_issue_id": ident if kind == "issue" else None,
                "similarity": ratio,
                "new_group": ident if kind == "new" else None,
            })
            continue
        new_count += 1
        new_id = "n{}".format(new_count)
        reps.append(key)
        owners.append(("new", new_id))
        results.append({"ref": row["ref"], "branch": branch, "matched_issue_id": None,
                        "similarity": None, "new_group": new_id})
    return results, errors
