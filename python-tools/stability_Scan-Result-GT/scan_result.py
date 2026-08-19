# -*- coding: utf-8 -*-
"""问题包汇总与去重（第二阶段主入口，输出对齐 MTK 工具）。

用法：
    python scan_result.py -d <第一阶段保存根目录> [--threshold 0.9]

产物生成在 -d 目录下：
    Result_None_None_MonkeyAEE_SPRD_{时间戳}.xls        （去重后）
    Result_None_None_MonkeyAEE_SPRD_{时间戳}_org.xls    （去重前）
"""

import argparse
import json
import os
from datetime import datetime

from modules.collect import collect_problems
from modules.dedup import dedup
from modules.export import export_xls
from modules.logger import TEST_LOGGER

CONFIG_PATH = os.path.join(os.path.dirname(os.path.abspath(__file__)), "config.json")


def load_config():
    with open(CONFIG_PATH, encoding="utf-8") as f:
        return json.load(f)


def main():
    parser = argparse.ArgumentParser(description="问题包汇总与去重（第二阶段）")
    parser.add_argument("-d", "--dir", required=True,
                        help="第一阶段保存根目录（含 {version}/{device}/；产物也生成在此）")
    parser.add_argument("--threshold", type=float, default=None, help="去重相似度阈值（覆盖 config）")
    args = parser.parse_args()

    data_dir = os.path.abspath(args.dir)
    TEST_LOGGER.info("第二阶段汇总开始")
    TEST_LOGGER.info("输入目录: %s" % data_dir)

    config = load_config()
    if args.threshold is not None:
        config["dedup"]["similarity_threshold"] = args.threshold
        TEST_LOGGER.info("去重阈值: %s" % args.threshold)

    records = collect_problems(data_dir, config)
    if not records:
        TEST_LOGGER.warn("未找到问题包（需 {version}/{device}/ 结构）")
        return 1

    TEST_LOGGER.info("开始去重（%d 条）" % len(records))
    before, after = dedup(records, config)
    TEST_LOGGER.info("去重完成: %d -> %d" % (len(before), len(after)))

    ts = datetime.now().strftime("%Y%m%d_%H%M%S")
    exp = config["export"]
    after_name = exp["output_after"].replace("{ts}", ts)
    before_name = exp["output_before"].replace("{ts}", ts)
    after_path = os.path.join(data_dir, after_name)
    before_path = os.path.join(data_dir, before_name)

    TEST_LOGGER.info("导出 Excel（去重后）: %s" % after_path)
    export_xls(after, after_path, config)
    TEST_LOGGER.info("导出 Excel（去重前）: %s" % before_path)
    export_xls(before, before_path, config)

    TEST_LOGGER.info("汇总: %d 条（去重前）-> %d 条（去重后）" % (len(before), len(after)))
    TEST_LOGGER.info("输出: %s" % after_path)
    TEST_LOGGER.info("      %s" % before_path)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
