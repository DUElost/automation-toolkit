#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""为不同场景创建测试数据并驱动主流程。"""

from __future__ import annotations

import argparse
import shutil
from pathlib import Path

DATA_FILE = Path('data/Monkey问题数据清单.xls')
TEST_FILE = Path('data/Monkey问题数据清单_case_test.xls')

CASE_SETUP = {
    'Case1': '已关闭问题，预期被跳过',
    'Case2': "Won't Fix 问题，只追加备注",
    'Case3-Reopen': 'Resolved 且新版本>=修复版本，预期Reopen+更新',
    'Case3-Wait': 'Resolved 且新版本<修复版本，预期只备注待验证',
    'Case4': '未解决问题，预期更新标题/等级+备注',
    'Case5': '无匹配条目，预期新建',
    'Case6': '回归 PASS 场景，通过删除部分条目触发',
}


def prepare_test_excel() -> None:
    if not DATA_FILE.exists():
        raise FileNotFoundError(f'原始文件不存在: {DATA_FILE}')
    shutil.copy(DATA_FILE, TEST_FILE)
    print(f'[INFO] 已复制 {DATA_FILE} -> {TEST_FILE}')
    print('[INFO] 请按以下顺序在 VCAME Jira 中准备对应状态的历史单，并更新 Excel 中的数据以匹配:')
    for name, desc in CASE_SETUP.items():
        print(f'  - {name}: {desc}')
    print('\n[INFO] 准备完 Excel 后，可执行以下命令验证所有场景:')
    print('  python src/main.py --excel data/Monkey问题数据清单_case_test.xls --action execute --db-path tests/jira_local.db')


def main() -> None:
    parser = argparse.ArgumentParser(description='构建覆盖全部Case的测试数据模板')
    parser.add_argument('--prepare', action='store_true', help='复制原始Excel并提示各Case的准备要求')
    parser.add_argument('--run', action='store_true', help='直接运行主流程（需确保Excel已准备好）')
    args = parser.parse_args()
    if args.prepare:
        prepare_test_excel()
    if args.run:
        import subprocess
        cmd = ['python', 'src/main.py', '--excel', str(TEST_FILE), '--action', 'execute', '--db-path', 'tests/jira_local.db']
        print('[INFO] 执行:', ' '.join(cmd))
        subprocess.run(cmd, check=True)
    if not args.prepare and not args.run:
        parser.print_help()


if __name__ == '__main__':
    main()
