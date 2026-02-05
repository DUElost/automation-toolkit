#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Top300 Result Filler - 主程序入口
自动化处理Top300应用启动时间测试数据并回填到目标Excel文件
"""
import sys
import logging
from pathlib import Path

from top300_processor import process_all_sources, print_summary

# 配置日志
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.StreamHandler(sys.stdout),
        logging.FileHandler('top300_filler.log', encoding='utf-8')
    ]
)
logger = logging.getLogger(__name__)


def get_user_input() -> dict:
    """
    交互式获取用户输入

    Returns:
        用户输入字典
    """
    print("\n" + "=" * 60)
    print("Top300 Result Filler - Excel数据处理工具")
    print("=" * 60)

    # 1. 获取空载标准
    no_load_standard = input("\n请输入空载标准（直接回车默认为 /）: ").strip()
    if not no_load_standard:
        no_load_standard = "/"

    # 2. 获取负载标准
    load_standard = input("\n请输入负载标准（直接回车默认为 /）: ").strip()
    if not load_standard:
        load_standard = "/"

    # 3. 获取空载文件路径
    while True:
        no_load_file = input("\n请输入空载测试报告文件路径（如: test_report_空载.xlsx）: ").strip().strip('"').strip("'")
        if no_load_file:
            no_load_path = Path(no_load_file)
            if no_load_path.exists():
                break
            print(f"文件不存在: {no_load_file}")
        else:
            print("请输入有效的文件路径")

    # 4. 获取负载文件路径
    while True:
        load_file = input("\n请输入负载测试报告文件路径（如: test_report_负载.xlsx）: ").strip().strip('"').strip("'")
        if load_file:
            load_path = Path(load_file)
            if load_path.exists():
                break
            print(f"文件不存在: {load_file}")
        else:
            print("请输入有效的文件路径")

    # 5. 获取目标文件路径
    while True:
        target_file = input("\n请输入目标Excel文件路径（如: 目标文件.xlsx）: ").strip().strip('"').strip("'")
        if target_file:
            target_path = Path(target_file)
            if target_path.exists():
                break
            print(f"文件不存在: {target_file}")
        else:
            print("请输入有效的文件路径")

    return {
        "no_load_file": no_load_path,
        "load_file": load_path,
        "target_file": target_path,
        "no_load_standard": no_load_standard,
        "load_standard": load_standard,
    }


def main():
    """
    主函数
    """
    try:
        # 获取用户输入
        user_input = get_user_input()

        # 确认信息
        print("\n" + "=" * 60)
        print("请确认处理信息:")
        print(f"  空载标准: {user_input['no_load_standard']}")
        print(f"  负载标准: {user_input['load_standard']}")
        print(f"  空载文件: {user_input['no_load_file'].name}")
        print(f"  负载文件: {user_input['load_file'].name}")
        print(f"  目标文件: {user_input['target_file'].name}")
        print("  输出文件: 将在原目录创建带时间戳的新文件")
        print("=" * 60)

        confirm = input("\n确认开始处理？(Y/n): ").strip().lower()
        if confirm == 'n':
            print("已取消操作")
            return 0

        # 处理数据
        print("\n开始处理数据...")
        summary = process_all_sources(
            no_load_file=user_input["no_load_file"],
            load_file=user_input["load_file"],
            target_file=user_input["target_file"],
            no_load_standard=user_input["no_load_standard"],
            load_standard=user_input["load_standard"],
        )

        # 打印结果
        print_summary(summary)

        return 0 if summary["success"] else 1

    except KeyboardInterrupt:
        print("\n\n操作已取消")
        return 1
    except Exception as e:
        logger.error(f"程序运行出错: {e}")
        print(f"\n错误: {e}")
        return 1


if __name__ == '__main__':
    sys.exit(main())
