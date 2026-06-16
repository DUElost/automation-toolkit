#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
retro_add_tinno_ps_comments.py
-------------------------------

用于在 `create_tinno_jira_batch_from_excel.py` 忘记加 --add-comments 后，
根据已生成的 result JSON 和上传模板 xlsx，补加 PS 评论。

用法：
    python "retro_add_tinno_ps_comments.py" ^
        --add-excel-file ".\result\JIRA_Upload_List_Tinno_Monkey专项_20260615_211827.xlsx" ^
        --result-json ".\result\tinno_jira_batch_create_result_20260615_212929.json" ^
        --jira-cookie-jsessionid "<JSESSIONID>" ^
        --jira-cookie-xsrf-token "<XSRF_TOKEN>" ^
        --dry-run

    python "retro_add_tinno_ps_comments.py" ^
        --add-excel-file ".\result\JIRA_Upload_List_Tinno_Monkey专项_20260615_211827.xlsx" ^
        --result-json ".\result\tinno_jira_batch_create_result_20260615_212929.json" ^
        --jira-cookie-jsessionid "<JSESSIONID>" ^
        --jira-cookie-xsrf-token "<XSRF_TOKEN>"

不指定 --result-json 时，脚本会尝试按上传文件名自动匹配最近的 result JSON。
"""

from __future__ import annotations

import argparse
import json
import logging
import os
import re
import sys
from datetime import datetime
from pathlib import Path
from typing import Any, Dict, List, Tuple

import pandas as pd

CURRENT_DIR = Path(__file__).resolve().parent
if str(CURRENT_DIR) not in sys.path:
    sys.path.insert(0, str(CURRENT_DIR))

from tinno_batch_jira_common import add_issue_comment, connect_to_jira
from create_tinno_jira_batch_from_excel import (
    DEFAULT_CONFIG_FILE,
    DEFAULT_LOCAL_ENV_FILE,
    load_defaults,
    load_local_env,
    setup_logging,
)

logger = logging.getLogger(__name__)

RESULT_DIR = CURRENT_DIR / "result"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="补加 PS 评论到已创建的 Tinno Jira 问题单"
    )
    parser.add_argument("--add-excel-file", dest="excel_file", required=True, help="上传模板 Excel 路径")
    parser.add_argument(
        "--result-json", dest="result_json", default=None,
        help="create_tinno_jira_batch_from_excel.py 输出的 result JSON 路径；"
             "不传则自动按 Excel 文件名匹配最近的 result JSON",
    )
    parser.add_argument("--jira-username", dest="jira_username", default=os.getenv("JIRA_USERNAME"), help="Jira 用户名")
    parser.add_argument("--jira-password", dest="jira_password", default=os.getenv("JIRA_PASSWORD"), help="Jira 密码")
    parser.add_argument("--jira-server", dest="jira_server", default=None, help="Jira 服务地址")
    parser.add_argument("--jira-p12-path", dest="jira_p12_path", default=os.getenv("JIRA_P12_PATH"), help="P12 证书路径")
    parser.add_argument("--jira-p12-password", dest="jira_p12_password", default=os.getenv("JIRA_P12_PASSWORD"), help="P12 证书密码")
    parser.add_argument("--jira-cookie-jsessionid", dest="jira_cookie_jsessionid", default=os.getenv("JIRA_COOKIE_JSESSIONID"), help="JSESSIONID")
    parser.add_argument("--jira-cookie-xsrf-token", dest="jira_cookie_xsrf_token", default=os.getenv("JIRA_COOKIE_XSRF_TOKEN"), help="atlassian.xsrf.token")
    parser.add_argument("--jira-cookie-string", dest="jira_cookie_string", default=os.getenv("JIRA_COOKIE_STRING"), help="完整 Cookie 字符串")
    parser.add_argument("--config-file", dest="config_file", default=str(DEFAULT_CONFIG_FILE), help="默认配置路径")
    parser.add_argument("--dry-run", action="store_true", help="仅打印即将追加的评论，不做真实提交")
    return parser.parse_args()


def find_result_json_by_excel(excel_path: str) -> str | None:
    result_dir = RESULT_DIR
    if not result_dir.exists():
        return None

    excel_name = Path(excel_path).stem
    excel_timestamp_match = re.search(r"(\d{8})_(\d{6})$", excel_name)
    if not excel_timestamp_match:
        logger.warning("上传文件名未含时间戳，无法自动匹配 result JSON")
        return None
    excel_dt = datetime.strptime(excel_timestamp_match.group(0), "%Y%m%d_%H%M%S")

    candidates: List[Tuple[float, str]] = []
    for f in result_dir.iterdir():
        if not f.name.startswith("tinno_jira_batch_create_result_") or f.suffix != ".json":
            continue
        result_match = re.search(r"_(\d{8}_\d{6})\.json$", f.name)
        if not result_match:
            continue
        try:
            result_dt = datetime.strptime(result_match.group(1), "%Y%m%d_%H%M%S")
        except ValueError:
            continue
        if result_dt < excel_dt:
            continue
        delta = (result_dt - excel_dt).total_seconds()
        candidates.append((delta, f.name))

    if not candidates:
        logger.warning("未找到时间晚于上传模板的 result JSON")
        return None

    candidates.sort(key=lambda x: x[0])
    best = candidates[0]
    logger.info("自动匹配 result JSON: %s（晚于上传模板 %d 秒）", best[1], int(best[0]))
    return str(result_dir / best[1])


def read_excel_smart(file_path: str | Path) -> pd.DataFrame:
    path = Path(file_path)
    if not path.exists():
        raise FileNotFoundError(f"Excel 文件不存在: {path}")
    if path.suffix.lower() == ".xlsx":
        return pd.read_excel(path, engine="openpyxl")
    return pd.read_excel(path)


def load_result_json(result_path: str) -> List[Dict[str, Any]]:
    with open(result_path, "r", encoding="utf-8") as fp:
        data = json.load(fp)
    if not isinstance(data, list):
        raise ValueError(f"result JSON 格式错误，应为列表，实际为 {type(data).__name__}")
    return data


def build_excel_row_map(df: pd.DataFrame) -> Dict[int, str]:
    row_map: Dict[int, str] = {}
    if "PS" not in df.columns:
        logger.error("上传模板缺少 PS 列")
        return row_map

    for index in range(len(df)):
        excel_row = index + 2
        ps_value = str(df.iloc[index].get("PS") or "").strip()
        if ps_value and ps_value.lower() != "nan":
            row_map[excel_row] = ps_value
    return row_map


def build_result_row_map(results: List[Dict[str, Any]]) -> Dict[int, Dict[str, Any]]:
    row_map: Dict[int, Dict[str, Any]] = {}
    for item in results:
        row_num = item.get("row")
        if row_num is None:
            continue
        try:
            row_key = int(row_num)
        except (TypeError, ValueError):
            continue
        row_map[row_key] = item
    return row_map


def main() -> int:
    load_local_env()
    setup_logging()
    args = parse_args()

    if not args.result_json:
        matched = find_result_json_by_excel(args.excel_file)
        if not matched:
            logger.error("自动匹配 result JSON 失败，请手动传入 --result-json")
            return 1
        args.result_json = matched

    excel_path = Path(args.excel_file)
    result_path = Path(args.result_json)
    if not excel_path.exists():
        logger.error("上传模板 Excel 不存在: %s", excel_path)
        return 1
    if not result_path.exists():
        logger.error("result JSON 不存在: %s", result_path)
        return 1

    df = read_excel_smart(str(excel_path))
    results = load_result_json(str(result_path))

    logger.info("上传模板: %s (%d 行)", excel_path.name, len(df))
    logger.info("结果 JSON: %s (%d 条)", result_path.name, len(results))

    excel_ps_map = build_excel_row_map(df)
    result_issue_map = build_result_row_map(results)

    if not excel_ps_map:
        logger.warning("上传模板中无有效的 PS 内容，无需补加评论")
        return 0

    matched_pairs: List[Tuple[int, str, str]] = []
    for row_num, ps_text in sorted(excel_ps_map.items()):
        result_entry = result_issue_map.get(row_num)
        if result_entry is None:
            logger.warning("Excel 第 %d 行未在 result JSON 中找到对应记录，跳过", row_num)
            continue
        status = str(result_entry.get("status") or "")
        issue_key = str(result_entry.get("issue_key") or "").strip()
        if status != "SUCCESS" or not issue_key:
            logger.info(
                "Excel 第 %d 行 status=%s issue_key=%s，跳过",
                row_num, status, issue_key or "NONE",
            )
            continue
        matched_pairs.append((row_num, issue_key, ps_text))

    if not matched_pairs:
        logger.warning("未找到可补加评论的问题单")
        return 0

    logger.info("待补加评论: %d 条", len(matched_pairs))
    if args.dry_run:
        for row_num, issue_key, ps_text in matched_pairs:
            ps_preview = ps_text[:120].replace("\n", "\\n")
            logger.info("[DRY-RUN] 第 %d 行 -> %s: %s ...", row_num, issue_key, ps_preview)
        logger.info("dry-run 模式，未实际提交评论")
        return 0

    defaults = load_defaults(args.config_file)
    jira_server = args.jira_server or defaults["jira_server"]
    jira = connect_to_jira(
        server=jira_server,
        username=args.jira_username,
        password=args.jira_password,
        p12_file_path=args.jira_p12_path or "",
        p12_password=args.jira_p12_password or "",
        verify=bool(defaults.get("verify", False)),
        cookie_string=args.jira_cookie_string,
        cookie_jsessionid=args.jira_cookie_jsessionid,
        cookie_xsrf_token=args.jira_cookie_xsrf_token,
    )
    logger.info("当前认证来源: %s", getattr(jira, "auth_mode", "unknown"))

    try:
        success_count = 0
        fail_count = 0
        for row_num, issue_key, ps_text in matched_pairs:
            try:
                add_issue_comment(jira, issue_key, ps_text)
                logger.info("第 %d 行 -> %s: 评论已追加", row_num, issue_key)
                success_count += 1
            except Exception as exc:
                logger.error("第 %d 行 -> %s: 评论追加失败: %s", row_num, issue_key, exc)
                fail_count += 1
        logger.info(
            "处理完成: 成功=%d 失败=%d 总计=%d",
            success_count, fail_count, len(matched_pairs),
        )
        return 0 if fail_count == 0 else 1
    finally:
        jira.close()


if __name__ == "__main__":
    raise SystemExit(main())
