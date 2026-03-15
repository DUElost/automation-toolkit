#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
JIRA标题更新工具

功能：
1. 根据JIRA单号修改对应的标题
2. 支持批量更新多个JIRA问题的标题
3. 提供详细的更新结果报告

使用示例：
1. 单个更新：python jira_title_updater.py --issue VFFBA-2621 --title "新的标题"
2. 批量更新：python jira_title_updater.py --batch issues.txt
3. 交互模式：python jira_title_updater.py --interactive

作者：AI Assistant
创建时间：2025-01-13
"""

import sys
import os
import argparse
import urllib3
import re
import pandas as pd
from datetime import datetime
from jira import JIRA, JIRAError
from typing import Dict, List, Tuple, Optional
try:
    import pandas as pd
    PANDAS_AVAILABLE = True
except ImportError:
    PANDAS_AVAILABLE = False

# 禁用SSL警告
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

# JIRA服务器配置
JIRA_SERVER = 'https://jira.tinno.com'
JIRA_USER = 'dai.lv'
JIRA_PASSWORD = 'l.74926520'

class JiraTitleUpdater:
    """JIRA标题更新器"""
    
    def __init__(self, server: str = JIRA_SERVER, username: str = JIRA_USER, password: str = JIRA_PASSWORD):
        """
        初始化JIRA标题更新器
        
        Args:
            server: JIRA服务器地址
            username: JIRA用户名
            password: JIRA密码
        """
        self.server = server
        self.username = username
        self.password = password
        self.jira_client = None
        self.severity_rules = []
        self._load_severity_rules()
    
    def _load_severity_rules(self):
        """加载问题等级定级规则"""
        try:
            if not PANDAS_AVAILABLE:
                print("[警告] 需要pandas库才能加载问题等级定级表")
                return
            
            severity_mapping_path = "F:/Jira_test_0813_rin/config/问题等级定级表.xls"
            if not os.path.exists(severity_mapping_path):
                print(f"[警告] 问题等级定级表文件不存在: {severity_mapping_path}")
                return
            
            # 读取Excel文件
            df = pd.read_excel(severity_mapping_path, engine='xlrd')
            
            # 构建等级规则
            self.severity_rules = []
            for _, row in df.iterrows():
                severity = str(row['问题等级']).strip() if pd.notna(row['问题等级']) else ""
                error_type = str(row['报错类型']).strip() if pd.notna(row['报错类型']) else ""
                count_req = str(row['次数要求']).strip() if pd.notna(row['次数要求']) else ""
                
                if severity and error_type:
                    self.severity_rules.append({
                        'severity': severity,
                        'error_type': error_type,
                        'count_requirement': count_req
                    })
            
            print(f"[成功] 加载问题等级定级规则 {len(self.severity_rules)} 条")
            
        except Exception as e:
            print(f"[警告] 加载问题等级定级规则失败: {e}")
    
    def _parse_title_info(self, title: str) -> Dict[str, any]:
        """解析标题中的报错次数和报错类型
        
        Args:
            title: JIRA标题，如：[自动化][V551A][Total Number 5][V551A-15-250808V39][MonkeyAEE][Java (JE)]com.android.settings发生Java (JE)
            
        Returns:
            包含count和error_type的字典
        """
        try:
            # 提取报错次数：[Total Number 数字]
            count_match = re.search(r'\[Total Number (\d+)\]', title)
            count = int(count_match.group(1)) if count_match else 0
            
            # 提取报错类型：[报错类型]
            error_type_patterns = [
                r'\[Java \(JE\)\]',
                r'\[Native \(NE\)\]', 
                r'\[ANR\]',
                r'\[Kernel API Dump\]',
                r'\[Fatal JE\]'
            ]
            
            error_type = ""
            for pattern in error_type_patterns:
                if re.search(pattern, title):
                    # 提取括号内的内容
                    match = re.search(pattern, title)
                    if match:
                        error_type = match.group(0).strip('[]')
                        break
            
            # 如果没有匹配到具体类型，尝试提取包名后的报错类型
            if not error_type:
                # 匹配 "发生XXX" 模式
                occur_match = re.search(r'发生(.+?)$', title)
                if occur_match:
                    error_type = occur_match.group(1).strip()
            
            return {
                'count': count,
                'error_type': error_type
            }
            
        except Exception as e:
            print(f"[警告] 解析标题信息失败: {e}")
            return {'count': 0, 'error_type': ''}
    
    def _determine_bug_severity(self, count: int, error_type: str) -> str:
        """根据问题等级定级表确定Bug严重程度
        
        Args:
            count: 报错次数
            error_type: 报错类型
            
        Returns:
            问题等级 (S/A/B/SWT)
        """
        try:
            # 遍历等级规则进行匹配
            for rule in self.severity_rules:
                rule_error_type = rule['error_type']
                count_req = rule['count_requirement']
                severity = rule['severity']
                
                # 匹配报错类型
                if rule_error_type in error_type or error_type in rule_error_type:
                    # 检查次数要求
                    if self._check_count_requirement(count, count_req):
                        return severity
            
            # 默认等级
            if count >= 50:
                return 'A'
            elif count >= 10:
                return 'B'
            else:
                return 'SWT'
                
        except Exception as e:
            print(f"[警告] 确定问题等级失败: {e}")
            return 'SWT'
    
    def _check_count_requirement(self, actual_count: int, requirement: str) -> bool:
        """检查次数是否满足要求
        
        Args:
            actual_count: 实际次数
            requirement: 次数要求字符串，如 ">=10", ">5", "<3" 等
            
        Returns:
            是否满足要求
        """
        try:
            if '>=' in requirement:
                threshold = int(requirement.replace('>=', '').strip())
                return actual_count >= threshold
            elif '>' in requirement:
                threshold = int(requirement.replace('>', '').strip())
                return actual_count > threshold
            elif '<=' in requirement:
                threshold = int(requirement.replace('<=', '').strip())
                return actual_count <= threshold
            elif '<' in requirement:
                threshold = int(requirement.replace('<', '').strip())
                return actual_count < threshold
            elif '=' in requirement:
                threshold = int(requirement.replace('=', '').strip())
                return actual_count == threshold
            else:
                # 如果只是数字，默认为大于等于
                threshold = int(requirement.strip())
                return actual_count >= threshold
        except:
            return False
    
    def _map_severity_to_priority(self, severity: str) -> str:
        """将问题等级映射到优先级
        
        Args:
            severity: 问题等级 (S/A/B/SWT)
            
        Returns:
            JIRA优先级
        """
        severity_priority_map = {
            'S': 'Highest',
            'A': 'High',
            'B': 'Medium',
            'SWT': 'Low'
        }
        return severity_priority_map.get(severity, 'Medium')

    def connect(self) -> bool:
        """
        连接到JIRA服务器
        
        Returns:
            连接是否成功
        """
        try:
            print(f"正在连接到 JIRA 服务器: {self.server}")
            print(f"用户名: {self.username}")
            
            self.jira_client = JIRA(self.server, basic_auth=(self.username, self.password))
            
            # 验证连接
            current_user = self.jira_client.current_user()
            print(f"[成功] JIRA 连接成功!")
            print(f"当前登录用户: {current_user}")
            return True
            
        except JIRAError as e:
            print(f"[失败] JIRA 连接失败 (JIRA错误): {e.text} (状态码: {e.status_code})")
            if e.status_code == 401:
                print("  认证失败，请检查用户名和密码是否正确")
            elif e.status_code == 403:
                print("  权限不足，请检查账户权限")
            elif e.status_code == 404:
                print("  服务器地址不正确或服务不可用")
            else:
                print("  请检查网络连接和服务器状态")
            return False
            
        except Exception as e:
            print(f"[失败] JIRA 连接失败: {e}")
            return False
    
    def get_issue_info(self, issue_key: str) -> Optional[Dict]:
        """
        获取JIRA问题信息
        
        Args:
            issue_key: JIRA问题键
            
        Returns:
            问题信息字典，如果获取失败返回None
        """
        try:
            issue = self.jira_client.issue(issue_key)
            return {
                'key': issue.key,
                'summary': issue.fields.summary,
                'status': issue.fields.status.name,
                'assignee': issue.fields.assignee.displayName if issue.fields.assignee else 'Unassigned',
                'project': issue.fields.project.key,
                'issue_type': issue.fields.issuetype.name
            }
        except JIRAError as e:
            print(f"[错误] 获取问题 {issue_key} 信息失败: {e.text}")
            return None
        except Exception as e:
            print(f"[错误] 获取问题 {issue_key} 信息失败: {e}")
            return None
    
    def update_issue_title(self, issue_key: str, new_title: str) -> Tuple[bool, str]:
        """
        更新JIRA问题标题
        
        Args:
            issue_key: JIRA问题键
            new_title: 新标题
            
        Returns:
            (是否成功, 结果消息)
        """
        try:
            # 首先获取问题信息
            issue_info = self.get_issue_info(issue_key)
            if not issue_info:
                return False, f"无法获取问题 {issue_key} 的信息"
            
            old_title = issue_info['summary']
            
            # 检查标题是否相同
            if old_title == new_title:
                return True, f"问题 {issue_key} 的标题已经是目标标题，无需更新"
            
            # 解析新标题中的报错信息
            title_info = self._parse_title_info(new_title)
            count = title_info['count']
            error_type = title_info['error_type']
            
            # 根据新标题重新判断问题等级
            new_severity = self._determine_bug_severity(count, error_type)
            new_priority = self._map_severity_to_priority(new_severity)
            
            # 准备更新字段
            update_fields = {'summary': new_title}
            
            # 如果有自定义字段用于存储Bug Severity，添加到更新字段中
            # 注意：这里需要根据实际JIRA配置调整字段名
            try:
                # 尝试更新优先级
                priority_field = {'name': new_priority}
                update_fields['priority'] = priority_field
                
                # 更新Bug Severity自定义字段 (customfield_10120)
                update_fields['customfield_10120'] = {'value': new_severity}
                
            except Exception as e:
                print(f"[警告] 准备优先级更新字段时出错: {e}")
            
            # 更新问题
            issue = self.jira_client.issue(issue_key)
            issue.update(fields=update_fields)
            
            print(f"[成功] 问题 {issue_key} 更新成功")
            print(f"  原标题: {old_title}")
            print(f"  新标题: {new_title}")
            print(f"  报错次数: {count}")
            print(f"  报错类型: {error_type}")
            print(f"  问题等级: {new_severity}")
            print(f"  优先级: {new_priority}")
            print(f"  问题链接: {self.server}/browse/{issue_key}")
            
            return True, f"标题和问题等级更新成功 (等级: {new_severity}, 优先级: {new_priority})"
            
        except JIRAError as e:
            error_msg = f"JIRA错误: {e.text} (状态码: {e.status_code})"
            print(f"[失败] 更新问题 {issue_key} 标题失败: {error_msg}")
            return False, error_msg
            
        except Exception as e:
            error_msg = f"更新标题时发生异常: {e}"
            print(f"[失败] 更新问题 {issue_key} 标题失败: {error_msg}")
            return False, error_msg
    
    def batch_update_titles(self, updates: List[Tuple[str, str]]) -> Dict:
        """
        批量更新JIRA问题标题
        
        Args:
            updates: 更新列表，每个元素为(issue_key, new_title)
            
        Returns:
            更新结果统计
        """
        print(f"\n开始批量更新 {len(updates)} 个JIRA问题标题...")
        
        results = {
            'total': len(updates),
            'success': 0,
            'failed': 0,
            'details': []
        }
        
        for i, (issue_key, new_title) in enumerate(updates):
            print(f"\n--- 更新第 {i + 1}/{len(updates)} 个问题 ---")
            print(f"问题: {issue_key}")
            print(f"新标题: {new_title}")
            
            success, message = self.update_issue_title(issue_key, new_title)
            
            result_detail = {
                'issue_key': issue_key,
                'new_title': new_title,
                'success': success,
                'message': message
            }
            
            results['details'].append(result_detail)
            
            if success:
                results['success'] += 1
            else:
                results['failed'] += 1
        
        # 打印统计信息
        print(f"\n=== 批量更新完成 ===")
        print(f"总计: {results['total']} 个问题")
        print(f"成功: {results['success']} 个")
        print(f"失败: {results['failed']} 个")
        print(f"成功率: {(results['success']/results['total']*100):.1f}%")
        
        return results
    
    def interactive_mode(self):
        """
        交互模式
        """
        print("\n=== JIRA标题更新工具 - 交互模式 ===")
        print("输入 'quit' 或 'exit' 退出程序")
        print("输入 'help' 查看帮助信息")
        
        while True:
            try:
                print("\n" + "-" * 50)
                issue_key = input("请输入JIRA问题键 (如 VFFBA-2621): ").strip()
                
                if issue_key.lower() in ['quit', 'exit']:
                    print("退出程序")
                    break
                
                if issue_key.lower() == 'help':
                    self.show_help()
                    continue
                
                if not issue_key:
                    print("[错误] 请输入有效的JIRA问题键")
                    continue
                
                # 获取当前问题信息
                issue_info = self.get_issue_info(issue_key)
                if not issue_info:
                    continue
                
                print(f"\n当前问题信息:")
                print(f"  问题键: {issue_info['key']}")
                print(f"  当前标题: {issue_info['summary']}")
                print(f"  状态: {issue_info['status']}")
                print(f"  经办人: {issue_info['assignee']}")
                print(f"  项目: {issue_info['project']}")
                
                new_title = input("\n请输入新标题: ").strip()
                
                if not new_title:
                    print("[错误] 请输入有效的新标题")
                    continue
                
                # 确认更新
                confirm = input(f"\n确认要将标题更新为: '{new_title}' ? (y/N): ").strip().lower()
                if confirm not in ['y', 'yes']:
                    print("取消更新")
                    continue
                
                # 执行更新
                success, message = self.update_issue_title(issue_key, new_title)
                
                if not success:
                    print(f"更新失败: {message}")
                
            except KeyboardInterrupt:
                print("\n\n程序被用户中断")
                break
            except Exception as e:
                print(f"[错误] 发生异常: {e}")
    
    def show_help(self):
        """
        显示帮助信息
        """
        help_text = """
=== JIRA标题更新工具帮助 ===

支持的命令:
1. 输入JIRA问题键 (如: VFFBA-2621)
2. help - 显示此帮助信息
3. quit/exit - 退出程序

使用流程:
1. 输入JIRA问题键
2. 查看当前问题信息
3. 输入新标题
4. 确认更新

示例标题格式:
[自动化][V551A][Total Number 47][V551A-15-250808V39][MonkeyAEE][Java (JE)]com.android.launcher3发生Java (JE)
[自动化][V551A][Total Number 5][V551A-15-250808V39][MonkeyAEE][Java (JE)]com.android.settings发生Java (JE)
        """
        print(help_text)

def read_batch_file(file_path: str) -> List[Tuple[str, str]]:
    """
    读取批量更新文件
    
    文件格式:
    ISSUE_KEY|NEW_TITLE
    VFFBA-2621|[自动化][V551A][Total Number 47][V551A-15-250808V39][MonkeyAEE]com.android.launcher3发生Java (JE)
    VFFBA-2622|[自动化][V551A][Total Number 5][V551A-15-250808V39][MonkeyAEE]com.android.settings发生Java (JE)
    
    Args:
        file_path: 文件路径
        
    Returns:
        更新列表
    """
    updates = []
    
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            for line_num, line in enumerate(f, 1):
                line = line.strip()
                if not line or line.startswith('#'):
                    continue
                
                if '|' not in line:
                    print(f"[警告] 第{line_num}行格式错误，跳过: {line}")
                    continue
                
                parts = line.split('|', 1)
                if len(parts) != 2:
                    print(f"[警告] 第{line_num}行格式错误，跳过: {line}")
                    continue
                
                issue_key = parts[0].strip()
                new_title = parts[1].strip()
                
                if not issue_key or not new_title:
                    print(f"[警告] 第{line_num}行数据不完整，跳过: {line}")
                    continue
                
                updates.append((issue_key, new_title))
        
        print(f"从文件 {file_path} 读取到 {len(updates)} 个更新任务")
        return updates
        
    except FileNotFoundError:
        print(f"[错误] 文件不存在: {file_path}")
        return []
    except Exception as e:
        print(f"[错误] 读取文件失败: {e}")
        return []


def read_excel_file(file_path: str, issue_column: str = 'ISSUE_KEY', title_column: str = 'NEW_TITLE', sheet_name: str = None) -> List[Tuple[str, str]]:
    """
    读取Excel文件进行批量更新
    
    Excel文件格式:
    | ISSUE_KEY | NEW_TITLE |
    | VFFBA-2621 | [自动化][V551A][Total Number 47][V551A-15-250808V39][MonkeyAEE]com.android.launcher3发生Java (JE) |
    | VFFBA-2622 | [自动化][V551A][Total Number 5][V551A-15-250808V39][MonkeyAEE]com.android.settings发生Java (JE) |
    
    Args:
        file_path: Excel文件路径
        issue_column: JIRA问题键列名，默认为'ISSUE_KEY'
        title_column: 新标题列名，默认为'NEW_TITLE'
        sheet_name: 工作表名称，默认为None（使用第一个工作表）
        
    Returns:
        更新列表
    """
    if not PANDAS_AVAILABLE:
        print("[错误] 需要安装pandas库才能读取Excel文件")
        print("请运行: pip install pandas openpyxl")
        return []
    
    updates = []
    
    try:
        # 读取Excel文件
        if sheet_name:
            df = pd.read_excel(file_path, sheet_name=sheet_name)
        else:
            df = pd.read_excel(file_path)
        
        print(f"Excel文件信息:")
        print(f"  文件路径: {file_path}")
        print(f"  工作表: {sheet_name if sheet_name else '默认工作表'}")
        print(f"  总行数: {len(df)}")
        print(f"  列名: {list(df.columns)}")
        
        # 检查必需的列是否存在
        if issue_column not in df.columns:
            print(f"[错误] 未找到JIRA问题键列: {issue_column}")
            print(f"可用列: {list(df.columns)}")
            return []
        
        if title_column not in df.columns:
            print(f"[错误] 未找到新标题列: {title_column}")
            print(f"可用列: {list(df.columns)}")
            return []
        
        # 处理数据
        valid_count = 0
        for index, row in df.iterrows():
            issue_key = str(row[issue_column]).strip() if pd.notna(row[issue_column]) else ''
            new_title = str(row[title_column]).strip() if pd.notna(row[title_column]) else ''
            
            # 跳过空行或无效数据
            if not issue_key or not new_title or issue_key == 'nan' or new_title == 'nan':
                print(f"[警告] 第{index + 2}行数据不完整，跳过: ISSUE_KEY='{issue_key}', NEW_TITLE='{new_title}'")
                continue
            
            updates.append((issue_key, new_title))
            valid_count += 1
        
        print(f"从Excel文件 {file_path} 读取到 {valid_count} 个有效更新任务")
        return updates
        
    except FileNotFoundError:
        print(f"[错误] Excel文件不存在: {file_path}")
        return []
    except Exception as e:
        print(f"[错误] 读取Excel文件失败: {e}")
        print(f"请确保文件格式正确，并且已安装pandas和openpyxl库")
        return []

def save_results_to_file(results: Dict, output_file: str = None):
    """
    保存更新结果到文件
    
    Args:
        results: 更新结果
        output_file: 输出文件路径
    """
    if not output_file:
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        output_file = f"jira_title_update_result_{timestamp}.txt"
    
    try:
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(f"JIRA标题更新结果报告\n")
            f.write(f"生成时间: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
            f.write(f"{'='*60}\n\n")
            
            f.write(f"统计信息:\n")
            f.write(f"总计: {results['total']} 个问题\n")
            f.write(f"成功: {results['success']} 个\n")
            f.write(f"失败: {results['failed']} 个\n")
            f.write(f"成功率: {(results['success']/results['total']*100):.1f}%\n\n")
            
            f.write(f"详细结果:\n")
            f.write(f"{'-'*60}\n")
            
            for i, detail in enumerate(results['details'], 1):
                status = "✅ 成功" if detail['success'] else "❌ 失败"
                f.write(f"第{i}个: {status}\n")
                f.write(f"  问题键: {detail['issue_key']}\n")
                f.write(f"  新标题: {detail['new_title']}\n")
                f.write(f"  结果: {detail['message']}\n")
                f.write(f"\n")
        
        print(f"\n结果已保存到文件: {output_file}")
        
    except Exception as e:
        print(f"[错误] 保存结果文件失败: {e}")

def main():
    """
    主函数
    """
    parser = argparse.ArgumentParser(
        description='JIRA标题更新工具',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
使用示例:
  单个更新: python jira_title_updater.py --issue VFFBA-2621 --title "新的标题"
  批量更新（文本文件）: python jira_title_updater.py --batch issues.txt
  批量更新（Excel文件）: python jira_title_updater.py --excel issues.xlsx
  Excel自定义列名: python jira_title_updater.py --excel issues.xlsx --issue-column "问题键" --title-column "标题"
  Excel指定工作表: python jira_title_updater.py --excel issues.xlsx --sheet-name "Sheet2"
  交互模式: python jira_title_updater.py --interactive

批量文件格式 (每行一个，用|分隔):
  VFFBA-2621|[自动化][V551A][Total Number 47][V551A-15-250808V39][MonkeyAEE]com.android.launcher3发生Java (JE)
  VFFBA-2622|[自动化][V551A][Total Number 5][V551A-15-250808V39][MonkeyAEE]com.android.settings发生Java (JE)

Excel文件格式:
  | ISSUE_KEY | NEW_TITLE |
  | VFFBA-2621 | [自动化][V551A][Total Number 47]... |
  | VFFBA-2622 | [自动化][V551A][Total Number 5]... |
        """
    )
    
    parser.add_argument('--issue', help='JIRA问题键')
    parser.add_argument('--title', help='新标题')
    parser.add_argument('--batch', help='批量更新文件路径（文本文件）')
    parser.add_argument('--excel', help='Excel文件路径')
    parser.add_argument('--issue-column', default='ISSUE_KEY', help='Excel中JIRA问题键列名（默认：ISSUE_KEY）')
    parser.add_argument('--title-column', default='NEW_TITLE', help='Excel中新标题列名（默认：NEW_TITLE）')
    parser.add_argument('--sheet-name', help='Excel工作表名称（默认使用第一个工作表）')
    parser.add_argument('--interactive', action='store_true', help='交互模式')
    parser.add_argument('--server', default=JIRA_SERVER, help='JIRA服务器地址')
    parser.add_argument('--user', default=JIRA_USER, help='JIRA用户名')
    parser.add_argument('--password', default=JIRA_PASSWORD, help='JIRA密码')
    parser.add_argument('--output', help='结果输出文件路径')
    
    args = parser.parse_args()
    
    # 检查参数
    if not any([args.issue, args.batch, args.excel, args.interactive]):
        parser.print_help()
        return
    
    if args.issue and not args.title:
        print("[错误] 使用 --issue 时必须同时指定 --title")
        return
    
    if args.batch and args.excel:
        print("[错误] --batch 和 --excel 不能同时使用")
        return
    
    # 创建更新器并连接
    updater = JiraTitleUpdater(args.server, args.user, args.password)
    
    if not updater.connect():
        print("[错误] 无法连接到JIRA服务器")
        return
    
    try:
        if args.interactive:
            # 交互模式
            updater.interactive_mode()
            
        elif args.issue:
            # 单个更新
            print(f"\n=== 单个标题更新 ===")
            success, message = updater.update_issue_title(args.issue, args.title)
            
            if success:
                print(f"\n[成功] 标题更新完成")
            else:
                print(f"\n[失败] 标题更新失败: {message}")
                
        elif args.batch:
            # 批量更新（文本文件）
            updates = read_batch_file(args.batch)
            
            if not updates:
                print("[错误] 没有有效的更新任务")
                return
            
            results = updater.batch_update_titles(updates)
            
            # 保存结果
            save_results_to_file(results, args.output)
            
        elif args.excel:
            # 批量更新（Excel文件）
            updates = read_excel_file(
                args.excel, 
                args.issue_column, 
                args.title_column, 
                args.sheet_name
            )
            
            if not updates:
                print("[错误] 没有有效的更新任务")
                return
            
            results = updater.batch_update_titles(updates)
            
            # 保存结果
            save_results_to_file(results, args.output)
            
    except KeyboardInterrupt:
        print("\n\n程序被用户中断")
    except Exception as e:
        print(f"[错误] 程序执行失败: {e}")

if __name__ == '__main__':
    main()