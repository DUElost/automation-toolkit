#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
清空主表数据脚本
"""

import sqlite3
import sys
from pathlib import Path

def clear_main_table():
    """清空主表数据"""
    db_path = Path(__file__).parent.parent / 'db' / 'jira_automation.db'
    
    if not db_path.exists():
        print(f"数据库文件不存在: {db_path}")
        return False
    
    try:
        # 连接数据库
        with sqlite3.connect(db_path) as conn:
            cursor = conn.cursor()
            
            # 检查当前记录数
            cursor.execute('SELECT COUNT(*) FROM jira_issues_main')
            current_count = cursor.fetchone()[0]
            
            if current_count == 0:
                print("主表已经是空的，无需清空")
                return True
            
            print(f"当前主表记录数: {current_count}")
            
            # 确认操作
            confirm = input(f"确认要清空主表的所有 {current_count} 条记录吗？(输入 'YES' 确认): ")
            
            if confirm != 'YES':
                print("操作已取消")
                return False
            
            # 清空主表
            cursor.execute('DELETE FROM jira_issues_main')
            
            # 重置自增ID（如果有的话）
            cursor.execute("DELETE FROM sqlite_sequence WHERE name='jira_issues_main'")
            
            # 提交事务
            conn.commit()
            
            # 验证清空结果
            cursor.execute('SELECT COUNT(*) FROM jira_issues_main')
            final_count = cursor.fetchone()[0]
            
            if final_count == 0:
                print("✓ 主表数据清空成功")
                print(f"✓ 已删除 {current_count} 条记录")
                return True
            else:
                print(f"✗ 清空失败，仍有 {final_count} 条记录")
                return False
                
    except Exception as e:
        print(f"清空主表失败: {e}")
        return False

def clear_pending_table():
    """清空待处理表数据"""
    db_path = Path(__file__).parent.parent / 'jira_automation.db'
    
    try:
        with sqlite3.connect(db_path) as conn:
            cursor = conn.cursor()
            
            # 检查当前记录数
            cursor.execute('SELECT COUNT(*) FROM pending_issues')
            current_count = cursor.fetchone()[0]
            
            if current_count == 0:
                print("待处理表已经是空的，无需清空")
                return True
            
            print(f"当前待处理表记录数: {current_count}")
            
            # 确认操作
            confirm = input(f"确认要清空待处理表的所有 {current_count} 条记录吗？(输入 'YES' 确认): ")
            
            if confirm != 'YES':
                print("操作已取消")
                return False
            
            # 清空待处理表
            cursor.execute('DELETE FROM pending_issues')
            
            # 重置自增ID（如果有的话）
            cursor.execute("DELETE FROM sqlite_sequence WHERE name='pending_issues'")
            
            # 提交事务
            conn.commit()
            
            # 验证清空结果
            cursor.execute('SELECT COUNT(*) FROM pending_issues')
            final_count = cursor.fetchone()[0]
            
            if final_count == 0:
                print("✓ 待处理表数据清空成功")
                print(f"✓ 已删除 {current_count} 条记录")
                return True
            else:
                print(f"✗ 清空失败，仍有 {final_count} 条记录")
                return False
                
    except Exception as e:
        print(f"清空待处理表失败: {e}")
        return False

def show_table_status():
    """显示表状态"""
    db_path = Path(__file__).parent.parent / 'jira_automation.db'
    
    if not db_path.exists():
        print(f"数据库文件不存在: {db_path}")
        return
    
    try:
        with sqlite3.connect(db_path) as conn:
            cursor = conn.cursor()
            
            print("数据库表状态:")
            print("=" * 50)
            
            # 主表状态
            cursor.execute('SELECT COUNT(*) FROM jira_issues_main')
            main_count = cursor.fetchone()[0]
            print(f"主表 (jira_issues_main): {main_count} 条记录")
            
            # 待处理表状态
            cursor.execute('SELECT COUNT(*) FROM pending_issues')
            pending_count = cursor.fetchone()[0]
            print(f"待处理表 (pending_issues): {pending_count} 条记录")
            
            # 操作日志表状态
            try:
                cursor.execute('SELECT COUNT(*) FROM operation_logs')
                log_count = cursor.fetchone()[0]
                print(f"操作日志表 (operation_logs): {log_count} 条记录")
            except:
                print("操作日志表 (operation_logs): 表不存在")
            
            print("=" * 50)
            
    except Exception as e:
        print(f"查看表状态失败: {e}")

def main():
    """主函数"""
    if len(sys.argv) < 2:
        print("用法:")
        print("  python clear_main_table.py main     # 清空主表")
        print("  python clear_main_table.py pending  # 清空待处理表")
        print("  python clear_main_table.py status   # 查看表状态")
        print("  python clear_main_table.py all      # 清空所有表")
        return
    
    action = sys.argv[1].lower()
    
    if action == 'status':
        show_table_status()
    elif action == 'main':
        clear_main_table()
    elif action == 'pending':
        clear_pending_table()
    elif action == 'all':
        print("清空所有表数据...")
        print("\n1. 清空主表:")
        clear_main_table()
        print("\n2. 清空待处理表:")
        clear_pending_table()
        print("\n最终状态:")
        show_table_status()
    else:
        print(f"未知操作: {action}")
        print("支持的操作: main, pending, status, all")

if __name__ == '__main__':
    main()