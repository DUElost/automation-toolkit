#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Excel数据转移工具 - 主程序入口
自动化从源目录读取测试数据并填写到目标Excel文件
"""
import sys
import logging
import argparse
from pathlib import Path

# 尝试加载 .env 文件（如果存在）
try:
    from dotenv import load_dotenv
    load_dotenv()
except ImportError:
    pass  # python-dotenv 未安装，跳过环境变量加载

from excel_data_transfer.config import (
    SOURCE_DIR,
    SOURCE_DIR_SLIDING,
    SOURCE_DIR_COMPETITOR,
    SOURCE_DIR_SLIDING_COMPETITOR,
    TARGET_FILE,
    DEVICE_TYPE_TEST,
    DEVICE_TYPE_COMPETITOR,
    DEVICE_TYPE_LABELS,
    DATA_TYPE_ANIMATION,
    DATA_TYPE_SLIDING,
    DATA_TYPE_LABELS
)
from excel_data_transfer.transfer import (
    process_folder_transfer,
    process_sliding_transfer,
    print_summary,
    print_sliding_summary,
    get_available_levels_from_file,
    batch_process,
    print_batch_summary
)

# 配置日志
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.StreamHandler(sys.stdout),
        logging.FileHandler('data_transfer.log', encoding='utf-8')
    ]
)
logger = logging.getLogger(__name__)


def select_data_type():
    """
    交互式选择数据类型（动效丢帧/滑动丢帧）

    Returns:
        数据类型常量
    """
    print("\n请选择数据类型:")
    print(f"  1. {DATA_TYPE_LABELS[DATA_TYPE_ANIMATION]}")
    print(f"  2. {DATA_TYPE_LABELS[DATA_TYPE_SLIDING]}")

    while True:
        choice = input("\n请输入选项 (1/2): ").strip()
        if choice == '1':
            return DATA_TYPE_ANIMATION
        elif choice == '2':
            return DATA_TYPE_SLIDING
        else:
            print("无效选项，请重新输入")


def select_device_type():
    """
    交互式选择设备类型

    Returns:
        设备类型常量
    """
    print("\n请选择设备类型:")
    print(f"  1. {DEVICE_TYPE_LABELS[DEVICE_TYPE_TEST]}")
    print(f"  2. {DEVICE_TYPE_LABELS[DEVICE_TYPE_COMPETITOR]}")

    while True:
        choice = input("\n请输入选项 (1/2): ").strip()
        if choice == '1':
            return DEVICE_TYPE_TEST
        elif choice == '2':
            return DEVICE_TYPE_COMPETITOR
        else:
            print("无效选项，请重新输入")


def select_test_level(target_file: Path):
    """
    交互式选择用例等级

    Args:
        target_file: 目标Excel文件路径

    Returns:
        选中的用例等级，None表示不筛选
    """
    levels = get_available_levels_from_file(target_file)

    if not levels:
        print("\n未找到可用的用例等级，跳过筛选")
        return None

    print("\n请选择用例等级 (筛选条件):")
    print(f"  0. 不筛选 (全部)")
    for i, level in enumerate(levels, 1):
        print(f"  {i}. {level}")

    while True:
        choice = input("\n请输入选项: ").strip()
        if choice == '0':
            return None
        try:
            idx = int(choice) - 1
            if 0 <= idx < len(levels):
                return levels[idx]
        except ValueError:
            pass
        print("无效选项，请重新输入")


def select_source_dir():
    """
    交互式输入源目录路径

    Returns:
        源目录路径
    """
    print(f"\n请输入源目录路径 (如: {SOURCE_DIR}):")

    while True:
        path_str = input("路径: ").strip().strip('"').strip("'")
        if not path_str:
            # 使用默认路径
            print(f"使用默认路径: {SOURCE_DIR}")
            return SOURCE_DIR

        source_dir = Path(path_str)
        if source_dir.exists() and source_dir.is_dir():
            return source_dir
        else:
            print(f"路径不存在或不是文件夹: {path_str}")
            print("请重新输入，或直接回车使用默认路径")


def select_batch_data_types():
    """
    交互式选择数据类型（支持多选）

    Returns:
        数据类型常量列表
    """
    print("\n请选择数据类型 (可多选，用逗号分隔):")
    print(f"  1. {DATA_TYPE_LABELS[DATA_TYPE_ANIMATION]}")
    print(f"  2. {DATA_TYPE_LABELS[DATA_TYPE_SLIDING]}")
    print(f"  3. 全选")
    print(f"  0. 跳过（不进行数据回填）")

    while True:
        choice = input("\n请输入选项: ").strip()
        if choice == '0':
            return []  # 返回空列表表示不处理
        elif choice == '1':
            return [DATA_TYPE_ANIMATION]
        elif choice == '2':
            return [DATA_TYPE_SLIDING]
        elif choice == '3':
            return [DATA_TYPE_ANIMATION, DATA_TYPE_SLIDING]
        else:
            print("无效选项，请重新输入")


def select_batch_device_types():
    """
    交互式选择设备类型（支持多选）

    Returns:
        设备类型常量列表
    """
    print("\n请选择设备类型 (可多选，用逗号分隔):")
    print(f"  1. {DEVICE_TYPE_LABELS[DEVICE_TYPE_TEST]}")
    print(f"  2. {DEVICE_TYPE_LABELS[DEVICE_TYPE_COMPETITOR]}")
    print(f"  3. 全选")
    print(f"  0. 跳过（不进行数据回填）")

    while True:
        choice = input("\n请输入选项: ").strip()
        if choice == '0':
            return []  # 返回空列表表示不处理
        elif choice == '1':
            return [DEVICE_TYPE_TEST]
        elif choice == '2':
            return [DEVICE_TYPE_COMPETITOR]
        elif choice == '3':
            return [DEVICE_TYPE_TEST, DEVICE_TYPE_COMPETITOR]
        else:
            print("无效选项，请重新输入")


def select_source_dirs(device_types: list = None, data_types: list = None):
    """
    交互式输入动效丢帧和滑动丢帧的源目录路径
    根据设备类型和数据类型选择询问对应的源目录

    Args:
        device_types: 选择的设备类型列表
        data_types: 选择的数据类型列表

    Returns:
        (animation_source, sliding_source, animation_source_comp, sliding_source_comp) 元组
    """
    # 默认值
    animation_source = SOURCE_DIR
    sliding_source = SOURCE_DIR_SLIDING
    animation_source_comp = SOURCE_DIR_COMPETITOR
    sliding_source_comp = SOURCE_DIR_SLIDING_COMPETITOR

    # 判断是否需要动效丢帧源目录
    need_animation = not data_types or DATA_TYPE_ANIMATION in data_types

    # 判断是否需要滑动丢帧源目录
    need_sliding = not data_types or DATA_TYPE_SLIDING in data_types

    # 判断是否需要测试机源目录
    need_test = not device_types or DEVICE_TYPE_TEST in device_types

    # 判断是否需要竞品机源目录
    need_competitor = device_types and DEVICE_TYPE_COMPETITOR in device_types

    # 测试机源目录
    if need_test:
        print(f"\n请输入测试机源目录路径:")

        # 测试机动效丢帧源目录
        if need_animation:
            print(f"\n测试机动效丢帧源目录 (默认: {SOURCE_DIR}):")
            animation_choice = input("路径 (直接回车使用默认): ").strip().strip('"').strip("'")
            if animation_choice:
                animation_source = Path(animation_choice)
            print(f"  测试机动效丢帧: {animation_source}")

        # 测试机滑动丢帧源目录
        if need_sliding:
            print(f"\n测试机滑动丢帧源目录 (默认: {SOURCE_DIR_SLIDING}):")
            sliding_choice = input("路径 (直接回车使用默认): ").strip().strip('"').strip("'")
            if sliding_choice:
                sliding_source = Path(sliding_choice)
            print(f"  测试机滑动丢帧: {sliding_source}")

    # 竞品机源目录
    if need_competitor:
        print(f"\n请输入竞品机源目录路径:")

        # 竞品机动效丢帧源目录
        if need_animation:
            print(f"\n竞品机动效丢帧源目录 (默认: {SOURCE_DIR_COMPETITOR}):")
            animation_comp_choice = input("路径 (直接回车使用默认): ").strip().strip('"').strip("'")
            if animation_comp_choice:
                animation_source_comp = Path(animation_comp_choice)
            print(f"  竞品机动效丢帧: {animation_source_comp}")

        # 竞品机滑动丢帧源目录
        if need_sliding:
            print(f"\n竞品机滑动丢帧源目录 (默认: {SOURCE_DIR_SLIDING_COMPETITOR}):")
            sliding_comp_choice = input("路径 (直接回车使用默认): ").strip().strip('"').strip("'")
            if sliding_comp_choice:
                sliding_source_comp = Path(sliding_comp_choice)
            print(f"  竞品机滑动丢帧: {sliding_source_comp}")

    return animation_source, sliding_source, animation_source_comp, sliding_source_comp


def select_batch_test_level() -> str:
    """
    交互式选择用例等级（批量模式）

    Returns:
        选中的用例等级，None表示不筛选
    """
    print("\n请选择用例等级筛选:")
    print("  1. L1")
    print("  2. L2")
    print("  3. L3")
    print("  0. 不筛选 (全部)")

    while True:
        choice = input("\n请输入选项: ").strip()
        if choice == '0':
            return None
        elif choice == '1':
            return 'L1'
        elif choice == '2':
            return 'L2'
        elif choice == '3':
            return 'L3'
        else:
            # 尝试直接输入等级
            if choice.upper() in ['L1', 'L2', 'L3']:
                return choice.upper()
            print("无效选项，请重新输入")


def parse_args():
    """
    解析命令行参数

    Returns:
        解析后的参数
    """
    parser = argparse.ArgumentParser(
        description='Excel数据转移工具 - 从源目录读取测试数据并填写到目标Excel文件'
    )
    parser.add_argument(
        '-d', '--device',
        choices=['test', 'competitor', 't', 'c', 'both', 'all'],
        help='设备类型: test(测试机), competitor(竞品机), both(两者), all(两者)'
    )
    parser.add_argument(
        '--data-type',
        choices=['animation', 'sliding', 'a', 's', 'both', 'all'],
        help='数据类型: animation(动效丢帧), sliding(滑动丢帧), both(两者), all(两者)'
    )
    parser.add_argument(
        '-l', '--level',
        type=str,
        help='用例等级筛选 (如 L1, L3)'
    )
    parser.add_argument(
        '-s', '--source',
        type=str,
        help=f'测试机动效丢帧源目录路径 (默认: {SOURCE_DIR})'
    )
    parser.add_argument(
        '--sliding-source',
        type=str,
        help=f'测试机滑动丢帧源目录路径 (默认: {SOURCE_DIR_SLIDING})'
    )
    parser.add_argument(
        '--source-comp',
        type=str,
        help=f'竞品机动效丢帧源目录路径 (默认: {SOURCE_DIR_COMPETITOR})'
    )
    parser.add_argument(
        '--sliding-source-comp',
        type=str,
        help=f'竞品机滑动丢帧源目录路径 (默认: {SOURCE_DIR_SLIDING_COMPETITOR})'
    )
    parser.add_argument(
        '-i', '--interactive',
        action='store_true',
        help='交互式模式：提示输入源目录和其他选项'
    )
    parser.add_argument(
        '-t', '--target',
        type=str,
        help=f'目标Excel文件路径 (默认: 从模板生成新文件)'
    )
    parser.add_argument(
        '--no-backup',
        action='store_true',
        help='不创建备份文件'
    )
    parser.add_argument(
        '--no-template',
        action='store_true',
        help='不使用模板，直接使用指定的目标文件'
    )
    parser.add_argument(
        '-b', '--batch',
        action='store_true',
        help='批量模式：自动处理所有设备和数据类型（默认使用配置文件中的路径）'
    )
    parser.add_argument(
        '-v', '--verbose',
        action='store_true',
        help='详细输出模式'
    )

    return parser.parse_args()


def main():
    """
    主函数
    """
    args = parse_args()

    # 设置日志级别
    if args.verbose:
        logging.getLogger().setLevel(logging.DEBUG)

    # 批量模式
    if args.batch:
        return run_batch_mode(args)

    # 普通模式
    return run_single_mode(args)


def run_batch_mode(args) -> int:
    """
    批量模式执行

    Args:
        args: 命令行参数

    Returns:
        退出码
    """
    # 解析设备类型（批量模式默认全选）
    if args.device:
        device_input = args.device.lower()
        if device_input in ['both', 'all']:
            device_types = [DEVICE_TYPE_TEST, DEVICE_TYPE_COMPETITOR]
        elif device_input in ['test', 't']:
            device_types = [DEVICE_TYPE_TEST]
        elif device_input in ['competitor', 'c']:
            device_types = [DEVICE_TYPE_COMPETITOR]
        else:
            device_types = []
    elif args.interactive:
        # 交互式选择
        device_types = select_batch_device_types()
    else:
        # 批量模式默认：全选
        device_types = [DEVICE_TYPE_TEST, DEVICE_TYPE_COMPETITOR]

    # 解析数据类型（批量模式默认全选）
    if args.data_type:
        data_input = args.data_type.lower()
        if data_input in ['both', 'all']:
            data_types = [DATA_TYPE_ANIMATION, DATA_TYPE_SLIDING]
        elif data_input in ['animation', 'a']:
            data_types = [DATA_TYPE_ANIMATION]
        elif data_input in ['sliding', 's']:
            data_types = [DATA_TYPE_SLIDING]
        else:
            data_types = []
    elif args.interactive:
        # 交互式选择
        data_types = select_batch_data_types()
    else:
        # 批量模式默认：全选
        data_types = [DATA_TYPE_ANIMATION, DATA_TYPE_SLIDING]

    # 解析源目录（批量模式使用默认值）
    if args.interactive:
        animation_source, sliding_source, animation_source_comp, sliding_source_comp = select_source_dirs(device_types, data_types)
    else:
        animation_source = Path(args.source) if args.source else SOURCE_DIR
        sliding_source = Path(args.sliding_source) if args.sliding_source else SOURCE_DIR_SLIDING
        animation_source_comp = Path(args.source_comp) if args.source_comp else SOURCE_DIR_COMPETITOR
        sliding_source_comp = Path(args.sliding_source_comp) if args.sliding_source_comp else SOURCE_DIR_SLIDING_COMPETITOR

    # 解析目标文件
    target_file = Path(args.target) if args.target else None

    # 解析用例等级（交互式模式下选择）
    if args.level:
        level_filter = args.level
    elif args.interactive:
        level_filter = select_batch_test_level()
    else:
        level_filter = None

    # 确认开始执行
    print("\n" + "=" * 60)
    print("Excel数据转移工具 - 批量模式")
    print("=" * 60)
    print(f"设备类型: {', '.join([DEVICE_TYPE_LABELS.get(d, d) for d in device_types]) if device_types else '无'}")
    print(f"数据类型: {', '.join([DATA_TYPE_LABELS.get(d, d) for d in data_types]) if data_types else '无'}")
    if DEVICE_TYPE_TEST in device_types or not device_types:
        print(f"测试机动效源目录: {animation_source}")
        print(f"测试机滑动源目录: {sliding_source}")
    if DEVICE_TYPE_COMPETITOR in device_types:
        print(f"竞品机动效源目录: {animation_source_comp}")
        print(f"竞品机滑动源目录: {sliding_source_comp}")
    print(f"目标文件: {target_file or '从模板生成'}")
    print(f"用例等级筛选: {level_filter or '不筛选'}")
    print(f"使用模板: {'否' if args.no_template else '是'}")
    print("=" * 60)

    # 执行批量处理
    summary = batch_process(
        device_types=device_types,
        data_types=data_types,
        animation_source=animation_source,
        sliding_source=sliding_source,
        animation_source_comp=animation_source_comp,
        sliding_source_comp=sliding_source_comp,
        target_file=target_file,
        level_filter=level_filter,
        use_template=not args.no_template
    )
    print_batch_summary(summary)

    return 0 if summary['success'] else 1


def run_single_mode(args) -> int:
    """
    单模式执行

    Args:
        args: 命令行参数

    Returns:
        退出码
    """
    # 选择数据类型
    data_type = select_data_type()

    # 确定设备类型
    if args.device:
        device_input = args.device.lower()
        if device_input in ['test', 't']:
            device_type = DEVICE_TYPE_TEST
        else:
            device_type = DEVICE_TYPE_COMPETITOR
    else:
        device_type = select_device_type()

    # 确定源目录路径（直接使用命令行参数，已有默认值）
    source_dir = Path(args.source)

    # 解析目标文件路径
    target_file = Path(args.target)

    # 确定用例等级筛选
    if args.level:
        level_filter = args.level
    else:
        level_filter = select_test_level(target_file)

    # 确认开始执行
    print("\n" + "=" * 50)
    print("Excel数据转移工具")
    print("=" * 50)
    print(f"数据类型: {DATA_TYPE_LABELS[data_type]}")
    print(f"源目录: {source_dir}")
    print(f"目标文件: {target_file}")
    print(f"设备类型: {DEVICE_TYPE_LABELS[device_type]}")
    print(f"用例等级筛选: {level_filter or '不筛选'}")
    print(f"创建备份: {'否' if args.no_backup else '是'}")
    print("=" * 50)

    # 根据数据类型执行不同的处理
    if data_type == DATA_TYPE_SLIDING:
        summary = process_sliding_transfer(
            source_dir=source_dir,
            target_file=target_file,
            device_type=device_type,
            level_filter=level_filter,
            create_backup_flag=not args.no_backup
        )
        print_sliding_summary(summary)
    else:
        summary = process_folder_transfer(
            source_dir=source_dir,
            target_file=target_file,
            device_type=device_type,
            level_filter=level_filter,
            create_backup_flag=not args.no_backup
        )
        print_summary(summary)

    # 返回退出码
    return 0 if summary['success'] else 1


if __name__ == '__main__':
    sys.exit(main())
