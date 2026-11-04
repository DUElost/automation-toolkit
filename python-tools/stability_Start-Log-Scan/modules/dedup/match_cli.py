# -*- coding: utf-8 -*-
"""-match_issues：把待匹配行对已有问题代表做归并（stp.issue_match_request → stp.issue_match_result）。

用法：python start_log_scan.py -match_issues <input.json> -o <output.json> [-threshold 90]
退出码：0 成功；2 输入不合法；1 内部错误。只读：不联网、不写 report_history、不解压。
只依赖标准库。
"""
import argparse
import json
import os
import sys
import traceback

from modules.dedup import aee_rule
from modules.dedup.membership import build_meta, write_sidecar

REQUEST_SCHEMA = "stp.issue_match_request"
RESULT_SCHEMA = "stp.issue_match_result"
SCHEMA_VERSION = "1.0"
SUPPORTED_MAJOR = "1"


class InputError(ValueError):
    pass


def _require_str(obj, key, where):
    value = obj.get(key)
    if not isinstance(value, str):
        raise InputError("{}.{} 必须是字符串".format(where, key))
    return value


def validate_request(req):
    if not isinstance(req, dict):
        raise InputError("请求必须是 JSON 对象")
    if req.get("schema") != REQUEST_SCHEMA:
        raise InputError("schema 必须为 {}".format(REQUEST_SCHEMA))
    version = str(req.get("schema_version", ""))
    if version.split(".")[0] != SUPPORTED_MAJOR:
        raise InputError("不支持的 schema_version：{}".format(version))
    existing = req.get("existing", [])
    rows = req.get("rows", [])
    if not isinstance(existing, list) or not isinstance(rows, list):
        raise InputError("existing 与 rows 必须是数组")
    seen = set()
    for i, e in enumerate(existing):
        where = "existing[{}]".format(i)
        if not isinstance(e, dict):
            raise InputError(where + " 必须是对象")
        for key in ("issue_id", "exp_class", "package", "caused_by"):
            _require_str(e, key, where)
    for i, r in enumerate(rows):
        where = "rows[{}]".format(i)
        if not isinstance(r, dict):
            raise InputError(where + " 必须是对象")
        for key in ("ref", "exp_class", "package", "caused_by"):
            _require_str(r, key, where)
        if "path" in r and not isinstance(r["path"], str):
            raise InputError(where + ".path 必须是字符串")
        if r["ref"] in seen:
            raise InputError("rows 中 ref 重复：{}".format(r["ref"]))
        seen.add(r["ref"])
    return existing, rows


def run_match(req, threshold=aee_rule.DEFAULT_THRESHOLD):
    existing, rows = validate_request(req)
    results, errors = aee_rule.match_issues(existing, rows, threshold)
    return {
        "schema": RESULT_SCHEMA,
        "schema_version": SCHEMA_VERSION,
        "meta": build_meta(threshold),
        "results": results,
        "stats": {"rows": len(rows), "existing": len(existing),
                  "matched_existing": sum(1 for r in results if r["matched_issue_id"] is not None),
                  "new_groups": len({r["new_group"] for r in results if r["new_group"]}),
                  "compare_errors": errors},
    }


def main(argv=None):
    parser = argparse.ArgumentParser(description="对已有问题代表做归并匹配")
    parser.add_argument("-match_issues", dest="input", required=True)
    parser.add_argument("-o", dest="output", required=True)
    parser.add_argument("-threshold", dest="threshold", type=float, default=aee_rule.DEFAULT_THRESHOLD)
    try:
        args = parser.parse_args(argv)
    except SystemExit:
        return 2
    try:
        with open(args.input, encoding="utf-8") as f:
            req = json.load(f)
        threshold = int(args.threshold) if float(args.threshold).is_integer() else args.threshold
        result = run_match(req, threshold)
    except (InputError, ValueError, OSError) as exc:
        sys.stderr.write("输入不合法：{}\n".format(exc))
        return 2
    except Exception:
        sys.stderr.write(traceback.format_exc())
        return 1
    try:
        out_dir = os.path.dirname(os.path.abspath(args.output))
        if out_dir and not os.path.isdir(out_dir):
            os.makedirs(out_dir)
        write_sidecar(args.output, result)
    except Exception:
        sys.stderr.write(traceback.format_exc())
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
