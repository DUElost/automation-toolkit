#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
JIRA 问题状态流程变更脚本
------------------------

用于在 VCAME 项目中模拟真实的问题状态，支持：
1. 查看问题当前状态和可用转换
2. 批量创建测试问题
3. 将问题转换到指定状态
4. 为各决策场景准备测试数据
"""

from __future__ import annotations

import argparse
import logging
import os
import sys
from datetime import datetime, timedelta
from pathlib import Path
from typing import Any, Dict, List, Optional

PROJECT_ROOT = Path(__file__).parent.parent
sys.path.insert(0, str(PROJECT_ROOT))
sys.path.insert(0, str(PROJECT_ROOT / "src"))

from dotenv import load_dotenv
load_dotenv(PROJECT_ROOT / ".env")

from src.modules.jira_p12_client import JiraP12Client

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)


class JiraWorkflowManager:
    """JIRA 工作流管理器"""
    
    # 解决方案 ID 映射
    RESOLUTION_MAP = {
        "完成": "10000",
        "won't do": "10001",
        "重复提交": "10002",
        "无法再次复现": "10003",
        "重复问题": "10100",
        "非问题": "10101",
        "问题不修改": "10102",
        "平台限制": "10200",
        "verified": "10300",
        "monitor": "10301",
    }
    
    def __init__(self):
        self.client = JiraP12Client(
            jira_url=os.getenv('JIRA_URL'),
            p12_file_path=os.getenv('JIRA_P12_PATH'),
            p12_password=os.getenv('JIRA_P12_PASSWORD'),
            jira_username=os.getenv('JIRA_USERNAME'),
            jira_password=os.getenv('JIRA_PASSWORD')
        )
        self.project_key = os.getenv('JIRA_PROJECT_KEY', 'VCAME')
    
    def close(self):
        self.client.close()
    
    def get_issue_info(self, issue_key: str) -> Dict[str, Any]:
        """获取问题详情"""
        issue = self.client.get_issue(issue_key)
        fields = issue.get('fields', {})
        return {
            'key': issue.get('key'),
            'summary': fields.get('summary'),
            'status': fields.get('status', {}).get('name'),
            'resolution': fields.get('resolution', {}).get('name') if fields.get('resolution') else None,
            'reporter': fields.get('reporter', {}).get('name'),
            'assignee': fields.get('assignee', {}).get('name') if fields.get('assignee') else None,
            'created': fields.get('created'),
            'updated': fields.get('updated'),
            'fixVersions': [v.get('name') for v in fields.get('fixVersions', [])],
        }
    
    def get_available_transitions(self, issue_key: str) -> List[Dict[str, str]]:
        """获取问题可用的状态转换"""
        result = self.client.get_transitions(issue_key)
        transitions = []
        for t in result.get('transitions', []):
            transitions.append({
                'id': t.get('id'),
                'name': t.get('name'),
                'to_status': t.get('to', {}).get('name'),
            })
        return transitions
    
    def _get_resolution_id(self, resolution: str) -> str:
        """获取解决方案 ID"""
        return self.RESOLUTION_MAP.get(resolution.lower(), resolution)
    
    def _do_transition(self, issue_key: str, transition_id: str, 
                       fields: Dict[str, Any]) -> bool:
        """执行状态转换"""
        payload = {"transition": {"id": transition_id}}
        if fields:
            payload["fields"] = fields
        
        try:
            self.client._make_request(
                "POST",
                f"/rest/api/2/issue/{issue_key}/transitions",
                json=payload
            )
            return True
        except Exception as e:
            logger.error("转换失败: %s", e)
            return False
    
    def transition_to_open(self, issue_key: str, comment: Optional[str] = None) -> bool:
        """转换到开放状态"""
        transitions = self.get_available_transitions(issue_key)
        
        # 查找重新打开或停止进行转换
        for t in transitions:
            if t['to_status'] in ['开放', '重新打开']:
                if comment:
                    self.client.add_comment(issue_key, comment)
                return self._do_transition(issue_key, t['id'], {})
        
        logger.error("未找到到开放状态的转换")
        return False
    
    def transition_to_in_progress(self, issue_key: str, comment: Optional[str] = None) -> bool:
        """转换到处理中状态"""
        transitions = self.get_available_transitions(issue_key)
        
        for t in transitions:
            if t['to_status'] == '处理中':
                if comment:
                    self.client.add_comment(issue_key, comment)
                
                today = datetime.now()
                fields = {
                    "timetracking": {"originalEstimate": "1h"},
                    "customfield_10109": today.strftime("%Y-%m-%d"),
                    "customfield_10110": (today + timedelta(days=7)).strftime("%Y-%m-%d"),
                }
                return self._do_transition(issue_key, t['id'], fields)
        
        logger.error("未找到到处理中状态的转换")
        return False
    
    def transition_to_resolved(self, issue_key: str, resolution: str = "完成",
                               fix_version: str = "P1", comment: Optional[str] = None) -> bool:
        """
        转换到已解决状态
        
        必填字段（工作流验证器要求）：
        - resolution: 解决结果
        - fixVersions: 修复版本
        - customfield_10144: 根本原因
        - customfield_10701: 现象确认
        - customfield_10145: 长期措施
        - customfield_10146: 可能风险 (RiskProbability)
        - customfield_10147: 对应代码 (Corresponding code)
        - worklog: 需要先记录工时
        """
        transitions = self.get_available_transitions(issue_key)
        
        for t in transitions:
            if t['to_status'] == '已解决':
                # 先记录工时（必须）
                try:
                    self.client._make_request(
                        "POST",
                        f"/rest/api/2/issue/{issue_key}/worklog",
                        json={"timeSpent": "1h", "comment": "问题处理完成"}
                    )
                    logger.info("已记录工时 1h")
                except Exception as e:
                    logger.warning("记录工时失败: %s", e)
                
                if comment:
                    self.client.add_comment(issue_key, comment)
                
                # 完整的必填字段
                fields = {
                    "resolution": {"id": self._get_resolution_id(resolution)},
                    "fixVersions": [{"name": fix_version}],
                    "customfield_10144": "根本原因: 测试用途",      # 根本原因
                    "customfield_10701": "现象确认: 测试用途",      # 现象确认
                    "customfield_10145": "长期措施: 测试用途",      # 长期措施
                    "customfield_10146": "可能风险: 无",           # RiskProbability
                    "customfield_10147": "对应代码: N/A",          # Corresponding code
                }
                return self._do_transition(issue_key, t['id'], fields)
        
        logger.error("未找到到已解决状态的转换")
        return False
    
    def transition_to_closed(self, issue_key: str, resolution: str = "问题不修改",
                            fix_version: str = "P1", comment: Optional[str] = None) -> bool:
        """转换到已关闭状态"""
        transitions = self.get_available_transitions(issue_key)
        
        for t in transitions:
            if t['to_status'] == '已关闭':
                # 先记录工时
                try:
                    self.client._make_request(
                        "POST",
                        f"/rest/api/2/issue/{issue_key}/worklog",
                        json={"timeSpent": "1h", "comment": "自动记录工时"}
                    )
                except Exception:
                    pass
                
                if comment:
                    self.client.add_comment(issue_key, comment)
                
                fields = {
                    "resolution": {"id": self._get_resolution_id(resolution)},
                    "fixVersions": [{"name": fix_version}],
                    "customfield_10144": "测试用途",
                    "customfield_10701": "测试用途",
                }
                return self._do_transition(issue_key, t['id'], fields)
        
        logger.error("未找到到已关闭状态的转换")
        return False
    
    def transition_to_reopened(self, issue_key: str, comment: Optional[str] = None) -> bool:
        """转换到重新打开状态"""
        transitions = self.get_available_transitions(issue_key)
        
        for t in transitions:
            if t['to_status'] == '重新打开':
                if comment:
                    self.client.add_comment(issue_key, comment)
                return self._do_transition(issue_key, t['id'], {})
        
        logger.error("未找到到重新打开状态的转换")
        return False
    
    def create_test_issue(self, summary: str, description: str,
                         package_name: str = "com.test.workflow",
                         labels: List[str] = None,
                         component: str = "AUTOTEST",
                         assignee: str = None) -> Optional[str]:
        """创建测试问题"""
        fields = {
            "project": {"key": self.project_key},
            "issuetype": {"name": "Bug"},
            "summary": summary,
            "description": description,
            "labels": labels or ["MonkeyAEE", "WorkflowTest"],
            "components": [{"name": component}],
            "customfield_10120": {"value": "B"},  # bugSeverity
            "assignee": {"name": assignee or os.getenv('JIRA_USERNAME', 'dai.lv')},
        }
        
        try:
            result = self.client.create_issue(fields)
            key = result.get('key')
            logger.info("创建问题成功: %s", key)
            return key
        except Exception as e:
            logger.error("创建问题失败: %s", e)
            return None
    
    def setup_scenario_issues(self) -> Dict[str, str]:
        """
        创建各决策场景的测试问题并设置到对应状态
        
        返回: {场景名: 问题Key}
        """
        scenarios = {}
        
        print("=" * 60)
        print("创建各决策场景测试问题")
        print("=" * 60)
        
        # 场景1: Open 状态 - 用于 UPDATE 决策
        print("\n[1/5] 创建 Open 状态问题 (UPDATE 场景)...")
        key = self.create_test_issue(
            summary="[WorkflowTest][Open] com.android.settings 测试问题",
            description="此问题用于测试 UPDATE 决策场景\n包名: com.android.settings\n异常: java.lang.NullPointerException",
            package_name="com.android.settings"
        )
        if key:
            scenarios['OPEN_FOR_UPDATE'] = key
            print(f"  ✓ {key} - 状态: 开放")
        
        # 场景2: Resolved 状态 - 用于 REOPEN 决策
        print("\n[2/5] 创建 Resolved 状态问题 (REOPEN 场景)...")
        key = self.create_test_issue(
            summary="[WorkflowTest][Resolved] com.android.systemui 测试问题",
            description="此问题用于测试 REOPEN 决策场景\n包名: com.android.systemui\n异常: java.lang.RuntimeException",
            package_name="com.android.systemui"
        )
        if key:
            # Open -> In Progress -> Resolved
            self.transition_to_in_progress(key, "开始处理")
            self.transition_to_resolved(key, "完成", "P1", "已修复")
            scenarios['RESOLVED_FOR_REOPEN'] = key
            info = self.get_issue_info(key)
            print(f"  ✓ {key} - 状态: {info['status']}, 解决方案: {info['resolution']}")
        
        # 场景3: Won't Fix 状态 - 用于 COMMENT 决策
        print("\n[3/5] 创建 Won't Fix 状态问题 (COMMENT 场景)...")
        key = self.create_test_issue(
            summary="[WorkflowTest][Won't Fix] com.android.phone 测试问题",
            description="此问题用于测试 Won't Fix 备注决策场景\n包名: com.android.phone\n异常: java.lang.IllegalStateException",
            package_name="com.android.phone"
        )
        if key:
            # Open -> In Progress -> Closed (问题不修改)
            self.transition_to_in_progress(key, "开始处理")
            self.transition_to_closed(key, "问题不修改", "P1", "Won't Fix - 非问题")
            scenarios['WONTFIX_FOR_COMMENT'] = key
            info = self.get_issue_info(key)
            print(f"  ✓ {key} - 状态: {info['status']}, 解决方案: {info['resolution']}")
        
        # 场景4: Closed 状态 - 用于 IGNORE 决策
        print("\n[4/5] 创建 Closed 状态问题 (IGNORE 场景)...")
        key = self.create_test_issue(
            summary="[WorkflowTest][Closed] com.android.camera 测试问题",
            description="此问题用于测试 IGNORE 决策场景\n包名: com.android.camera\n异常: java.lang.OutOfMemoryError",
            package_name="com.android.camera"
        )
        if key:
            # Open -> In Progress -> Closed (完成)
            self.transition_to_in_progress(key, "开始处理")
            self.transition_to_closed(key, "完成", "P1", "已关闭")
            scenarios['CLOSED_FOR_IGNORE'] = key
            info = self.get_issue_info(key)
            print(f"  ✓ {key} - 状态: {info['status']}, 解决方案: {info['resolution']}")
        
        # 场景5: Reopened 状态 - 用于 UPDATE 决策（回归场景）
        print("\n[5/5] 创建 Reopened 状态问题 (回归 UPDATE 场景)...")
        key = self.create_test_issue(
            summary="[WorkflowTest][Reopened] com.android.launcher3 测试问题",
            description="此问题用于测试回归 UPDATE 决策场景\n包名: com.android.launcher3\n异常: java.lang.IndexOutOfBoundsException",
            package_name="com.android.launcher3"
        )
        if key:
            # Open -> In Progress -> Closed -> Reopened
            self.transition_to_in_progress(key, "开始处理")
            self.transition_to_closed(key, "完成", "P1", "已关闭")
            self.transition_to_reopened(key, "问题复现，重新打开")
            scenarios['REOPENED_FOR_UPDATE'] = key
            info = self.get_issue_info(key)
            print(f"  ✓ {key} - 状态: {info['status']}")
        
        return scenarios
    
    def show_issue_status(self, issue_key: str):
        """显示问题状态详情"""
        info = self.get_issue_info(issue_key)
        transitions = self.get_available_transitions(issue_key)
        
        print("=" * 60)
        print(f"问题: {info['key']}")
        print("=" * 60)
        print(f"摘要: {info['summary']}")
        print(f"状态: {info['status']}")
        print(f"解决方案: {info['resolution']}")
        print(f"报告人: {info['reporter']}")
        print(f"经办人: {info['assignee']}")
        print(f"修复版本: {info['fixVersions']}")
        print()
        print("可用转换:")
        for t in transitions:
            print(f"  - {t['name']} -> {t['to_status']} (id={t['id']})")
        print()


def cmd_show(args):
    """显示问题状态"""
    mgr = JiraWorkflowManager()
    try:
        for key in args.issues:
            mgr.show_issue_status(key)
    finally:
        mgr.close()


def cmd_transition(args):
    """转换问题状态"""
    mgr = JiraWorkflowManager()
    try:
        target = args.status.lower()
        success = False
        
        if target in ['open', '开放', '停止进行']:
            success = mgr.transition_to_open(args.issue, args.comment)
        elif target in ['in progress', '处理中', '开始进行']:
            success = mgr.transition_to_in_progress(args.issue, args.comment)
        elif target in ['resolved', '已解决', '解决问题']:
            success = mgr.transition_to_resolved(
                args.issue, 
                args.resolution or "完成",
                args.fix_version or "P1",
                args.comment
            )
        elif target in ['closed', '已关闭', '关闭问题']:
            success = mgr.transition_to_closed(
                args.issue,
                args.resolution or "问题不修改",
                args.fix_version or "P1",
                args.comment
            )
        elif target in ['reopened', '重新打开', '重新打开问题']:
            success = mgr.transition_to_reopened(args.issue, args.comment)
        else:
            print(f"不支持的状态: {args.status}")
            print("支持的状态: open, in progress, resolved, closed, reopened")
            sys.exit(1)
        
        if success:
            print(f"✓ 问题 {args.issue} 已转换到 {args.status}")
            mgr.show_issue_status(args.issue)
        else:
            print(f"✗ 转换失败")
            sys.exit(1)
    finally:
        mgr.close()


def cmd_setup(args):
    """创建测试场景问题"""
    mgr = JiraWorkflowManager()
    try:
        scenarios = mgr.setup_scenario_issues()
        
        print()
        print("=" * 60)
        print("测试场景问题创建完成")
        print("=" * 60)
        for name, key in scenarios.items():
            info = mgr.get_issue_info(key)
            print(f"{name}:")
            print(f"  Key: {key}")
            print(f"  状态: {info['status']}")
            print(f"  解决方案: {info['resolution']}")
            print(f"  URL: https://jira.tinno.com/browse/{key}")
        print()
    finally:
        mgr.close()


def cmd_list_transitions(args):
    """列出问题可用转换"""
    mgr = JiraWorkflowManager()
    try:
        transitions = mgr.get_available_transitions(args.issue)
        print(f"问题 {args.issue} 可用转换:")
        for t in transitions:
            print(f"  [{t['id']}] {t['name']} -> {t['to_status']}")
    finally:
        mgr.close()


def main():
    parser = argparse.ArgumentParser(description="JIRA 问题状态流程变更工具")
    subparsers = parser.add_subparsers(dest='command', help='可用命令')
    
    # show 命令
    p_show = subparsers.add_parser('show', help='显示问题状态')
    p_show.add_argument('issues', nargs='+', help='问题 Key 列表')
    p_show.set_defaults(func=cmd_show)
    
    # transition 命令
    p_trans = subparsers.add_parser('transition', help='转换问题状态')
    p_trans.add_argument('issue', help='问题 Key')
    p_trans.add_argument('status', help='目标状态 (open/in progress/resolved/closed/reopened)')
    p_trans.add_argument('--comment', '-c', help='转换备注')
    p_trans.add_argument('--resolution', '-r', help='解决方案 (完成/问题不修改/重复提交 等)')
    p_trans.add_argument('--fix-version', '-v', help='修复版本', default='P1')
    p_trans.set_defaults(func=cmd_transition)
    
    # setup 命令
    p_setup = subparsers.add_parser('setup', help='创建测试场景问题')
    p_setup.set_defaults(func=cmd_setup)
    
    # list-transitions 命令
    p_list = subparsers.add_parser('list-transitions', help='列出问题可用转换')
    p_list.add_argument('issue', help='问题 Key')
    p_list.set_defaults(func=cmd_list_transitions)
    
    args = parser.parse_args()
    
    if not args.command:
        parser.print_help()
        return 1
    
    return args.func(args)


if __name__ == "__main__":
    sys.exit(main() or 0)
