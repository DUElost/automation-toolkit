#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Motorola Excel文件JIRA问题上传清单生成器

功能：
1. 读取Result_None_None_MonkeyAEE_SH_20251010.xls文件
2. 读取包名与模块&经办人对应表_moto.xls文件
3. 读取问题等级定级表.xls文件
4. 生成规范的Motorola JIRA问题上传清单

"""

import os
import sys
import argparse
import pandas as pd
import logging
import re
from typing import Dict, List, Any, Optional
from datetime import datetime


def _resolve_base_dir() -> str:
    """Resolve base directory; works when packaged with PyInstaller."""
    if getattr(sys, 'frozen', False):
        exe_dir = os.path.dirname(os.path.abspath(sys.executable))
        if os.path.exists(os.path.join(exe_dir, 'config')):
            return exe_dir
        meipass = getattr(sys, '_MEIPASS', None)
        if meipass:
            return meipass
        return exe_dir
    return os.path.dirname(os.path.abspath(__file__))


def _resolve_config_dir(base_dir: str) -> str:
    """Prefer base_dir/config, else try __file__ sibling or CWD/config."""
    candidates = [
        os.path.join(base_dir, 'config'),
        os.path.join(os.path.dirname(os.path.abspath(__file__)), 'config'),
        os.path.join(os.getcwd(), 'config'),
    ]
    for path in candidates:
        if os.path.exists(path):
            return path
    return candidates[0]


base_dir = _resolve_base_dir()
config_dir = _resolve_config_dir(base_dir)
log_dir = os.path.join(base_dir, 'log')
os.makedirs(log_dir, exist_ok=True)
os.makedirs(config_dir, exist_ok=True)

# 配置日志
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler(os.path.join(log_dir, 'excel_to_jira_upload_list_moto.log'), encoding='utf-8'),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger(__name__)

class ExcelToJiraUploadListMoto:
    """Motorola Excel文件JIRA问题上传清单生成器"""

    def __init__(self, main_file_path: str = None, test_case: str = "Monkey"):
        """初始化生成器"""
        # 文件路径
        if main_file_path:
            if os.path.isabs(main_file_path) or re.match(r"^[a-zA-Z]:", main_file_path):
                self.main_excel_path = main_file_path
            else:
                self.main_excel_path = os.path.abspath(main_file_path)
        else:
            logger.error(f"读取main_file_path文件失败")

        self.package_mapping_path = os.path.join(config_dir, "包名与模块&经办人对应表_moto.xls")
        self.severity_mapping_path = os.path.join(config_dir, "问题等级定级表.xls")

        # 数据存储
        self.main_data = None
        self.package_mapping = {}
        self.default_package_info = None
        self.severity_rules = []
        self.test_case = (test_case or "Monkey").strip() or "Monkey"

        # 统计信息
        self.stats = {
            'total_records': 0,
            'processed_records': 0,
            'failed_records': 0,
            'upload_list': []
        }

    def _read_excel_file(self, file_path: str) -> pd.DataFrame:
        """智能读取Excel文件，自动检测.xls和.xlsx格式"""
        try:
            # 首先尝试使用默认引擎读取
            if file_path.lower().endswith('.xlsx'):
                # 对于.xlsx文件，使用openpyxl引擎
                return pd.read_excel(file_path, engine='openpyxl')
            elif file_path.lower().endswith('.xls'):
                # 对于.xls文件，使用xlrd引擎
                return pd.read_excel(file_path, engine='xlrd')
            else:
                # 尝试自动检测
                try:
                    return pd.read_excel(file_path, engine='openpyxl')
                except:
                    return pd.read_excel(file_path, engine='xlrd')
        except Exception as e:
            logger.error(f"读取Excel文件失败 {file_path}: {e}")
            raise

    def load_excel_files(self):
        """加载所有Excel文件"""
        try:
            logger.info("开始加载Excel文件...")

            # 加载主数据文件
            logger.info(f"加载主数据文件: {self.main_excel_path}")
            self.main_data = self._read_excel_file(self.main_excel_path)
            logger.info(f"主数据文件加载完成，共 {len(self.main_data)} 条记录")

            # 加载包名与模块映射表
            logger.info(f"加载包名与模块映射表: {self.package_mapping_path}")
            package_df = self._read_excel_file(self.package_mapping_path)
            self._build_package_mapping(package_df)
            logger.info(f"包名与模块映射表加载完成，共 {len(self.package_mapping)} 条映射")

            # 加载问题等级定级表
            logger.info(f"加载问题等级定级表: {self.severity_mapping_path}")
            severity_df = self._read_excel_file(self.severity_mapping_path)
            self._build_severity_rules(severity_df)
            logger.info(f"问题等级定级表加载完成，共 {len(self.severity_rules)} 条规则")

            return True

        except Exception as e:
            logger.error(f"加载Excel文件失败: {e}")
            return False

    def _build_package_mapping(self, df: pd.DataFrame):
        """构建包名与模块映射关系"""
        try:
            # Excel结构：包名 | 模块 | 经办人 | 邮箱
            for _, row in df.iterrows():
                package = str(row[df.columns[0]]).strip() if pd.notna(row[df.columns[0]]) else ""
                module = str(row[df.columns[1]]).strip() if pd.notna(row[df.columns[1]]) else ""
                assignee = str(row[df.columns[3]]).strip() if pd.notna(row[df.columns[3]]) else ""

                if package and module and assignee:
                    package_key = package.lower()
                    entry = {
                        'module': module,
                        'assignee': assignee
                    }
                    self.package_mapping[package_key] = entry
                    if package_key == "other":
                        self.default_package_info = entry

        except Exception as e:
            logger.error(f"构建包名映射失败: {e}")

    def _build_severity_rules(self, df: pd.DataFrame):
        """构建问题等级定级规则"""
        try:
            # Excel结构：问题等级 | 报错类型 | 次数要求
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

        except Exception as e:
            logger.error(f"构建等级规则失败: {e}")

    def generate_upload_list(self):
        """生成JIRA问题上传清单"""
        try:
            logger.info("开始生成JIRA问题上传清单...")

            if self.main_data is None:
                logger.error("主数据未加载")
                return False

            self.stats['total_records'] = len(self.main_data)

            for index, row in self.main_data.iterrows():
                try:
                    # 提取关键信息
                    issue_data = self._extract_issue_data(row)

                    # 生成JIRA问题记录
                    jira_issue = self._generate_jira_issue(issue_data)

                    if jira_issue:
                        self.stats['upload_list'].append(jira_issue)
                        self.stats['processed_records'] += 1
                    else:
                        self.stats['failed_records'] += 1

                except Exception as e:
                    logger.warning(f"处理第 {index + 1} 行数据失败: {e}")
                    self.stats['failed_records'] += 1
                    continue

            logger.info(f"JIRA问题上传清单生成完成，成功处理 {self.stats['processed_records']}/{self.stats['total_records']} 条记录")
            return True

        except Exception as e:
            logger.error(f"生成上传清单失败: {e}")
            return False

    def _extract_issue_data(self, row: pd.Series) -> Dict[str, Any]:
        """从Excel行数据中提取问题信息"""
        # 根据实际Excel列结构提取数据：Id, Path, Version, ExpTime, ExpClass, ExpType, CurProcess, Package, Detail, CausedBy, extraTag, Count, Activity, DeviceId
        return {
            'id': str(row['Id']) if pd.notna(row['Id']) else "",
            'path': str(row['Path']) if pd.notna(row['Path']) else "",
            'version': str(row['Version']) if pd.notna(row['Version']) else "",
            'exp_time': str(row['ExpTime']) if pd.notna(row['ExpTime']) else "",
            'exp_class': str(row['ExpClass']) if pd.notna(row['ExpClass']) else "",
            'exp_type': str(row['ExpType ']) if pd.notna(row['ExpType ']) else "",  # 注意列名有空格
            'cur_process': str(row['CurProcess']) if pd.notna(row['CurProcess']) else "",
            'package': str(row['Package']) if pd.notna(row['Package']) else "",
            'detail': str(row['Detail']) if pd.notna(row['Detail']) else "",
            'caused_by': str(row['CausedBy']) if pd.notna(row['CausedBy']) else "",
            'extra_tag': str(row['extraTag']) if pd.notna(row['extraTag']) else "",
            'count': int(row['Count']) if pd.notna(row['Count']) and str(row['Count']).replace('.', '').isdigit() else 0,
            'activity': str(row['Activity']) if pd.notna(row['Activity']) else "",
            'device_id': str(row['DeviceId']) if pd.notna(row['DeviceId']) else ""
        }

    def _extract_version_from_string(self, version_str: str) -> str:
        """从版本字符串中提取第二个空格与第三个空格之间的字符串"""
        try:
            if not version_str:
                return "Unknown"

            # 分割字符串
            parts = version_str.split(' ')

            # 如果至少有3个部分，取第三个部分（索引为2）
            if len(parts) >= 3:
                return parts[2]
            else:
                # 如果没有足够的部分，返回最后一个部分
                return parts[-1] if parts else "Unknown"

        except Exception as e:
            logger.error(f"提取版本号失败: {e}")
            return "Unknown"

    def _extract_package_version_from_detail(self, detail: str) -> str:
        """从Detail字段中提取异常包名版本信息"""
        try:
            if not detail:
                return "Unknown"

            # 使用正则表达式匹配异常包名后的版本信息
            # 模式：异常包名：['package version (version_info)']
            pattern = r"异常包名：\['([^']+)'\]"
            match = re.search(pattern, detail)

            if match:
                return match.group(1)

            return "Unknown"

        except Exception as e:
            logger.error(f"提取包版本信息失败: {e}")
            return "Unknown"

    def _determine_bug_severity(self, issue_data: Dict[str, Any]) -> str:
        """根据问题等级定级表确定Bug严重程度"""
        try:
            exp_class = issue_data.get('exp_class', '')
            count = issue_data.get('count', 0)

            # 遍历等级规则进行匹配
            for rule in self.severity_rules:
                error_type = rule['error_type']
                count_req = rule['count_requirement']
                severity = rule['severity']

                # 匹配报错类型
                if error_type in exp_class:
                    # 检查次数要求
                    if self._check_count_requirement(count, count_req):
                        return severity

            # 默认等级
            if count >= 50:
                return 'A'
            elif count >= 10:
                return 'B'
            else:
                return 'B'

        except Exception as e:
            logger.error(f"确定问题等级失败: {e}")
            return 'B'

    def _check_count_requirement(self, actual_count: int, requirement: str) -> bool:
        """检查次数是否满足要求"""
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
        """将问题等级映射到优先级数字"""
        severity_priority_map = {
            'S': '1',  # 紧急
            'A': '2',  # 严重
            'B': '3',  # 重要
        }
        return severity_priority_map.get(severity, '3')

    def _map_severity_to_severity_text(self, severity: str) -> str:
        """将问题等级映射到严重程度文本"""
        severity_text_map = {
            'S': 'Blocker',
            'A': 'Critical',
            'B': 'Major',
        }
        return severity_text_map.get(severity, 'Major')

    def _generate_jira_issue(self, issue_data: Dict[str, Any]) -> Optional[Dict[str, Any]]:
        """生成JIRA问题记录"""
        try:
            # 获取包名映射信息
            package_key = issue_data['package'].lower() if issue_data.get('package') else ""
            package_info = self.package_mapping.get(package_key)
            if not package_info and self.default_package_info:
                package_info = self.default_package_info
            if not package_info:
                package_info = {'module': 'Unknown', 'assignee': 'Unassigned'}

            # 如果映射结果缺失或为Unknown/Unknow，尝试使用默认other行
            if self.default_package_info:
                module_val = package_info.get('module', '').strip()
                assignee_val = package_info.get('assignee', '').strip()
                if module_val.lower() in ('', 'unknown', 'unknow') or assignee_val.lower() in ('', 'unknown', 'unknow', 'unassigned'):
                    package_info = self.default_package_info

            # 确定问题等级
            bug_severity = self._determine_bug_severity(issue_data)

            # 提取版本号
            version_clean = self._extract_version_from_string(issue_data['version'])

            # 提取包版本信息
            package_version = self._extract_package_version_from_detail(issue_data['detail'])

            # 生成概要
            summary = f"[STABILITY][{self.test_case}][Lamu26 DVT1]{issue_data['exp_class']}: {issue_data['package']} ({issue_data['count']} Times)"

            # 生成描述
            description = f"""{issue_data['exp_class']} in {issue_data['package']} on {package_version} first found on build: {version_clean} occurred at {issue_data['exp_time']} during {self.test_case} test
BARCODE：{issue_data['device_id']}
Recurrence probability: {issue_data['count']} times/ 20 units
TYPE：{issue_data['exp_class']}
PACKAGE VERSION：{package_version}
BUILD：{version_clean}
TIME STAMP：{issue_data['exp_time']}

{issue_data['detail']}"""

            # 生成PS内容
            ps_content = f"""*Path :* {issue_data['path']}
*Duplicate Number :* {issue_data['count']}
*Device Count :* {issue_data['count']}
*Version :* {issue_data['version']}"""

            # 构建JIRA问题记录
            jira_issue = {
                'Project': 'EKLAMUC',
                'Issue Type': '故障',
                'Summary': summary,
                'Description': description,
                'Priority': self._map_severity_to_priority(bug_severity),
                'Assignee': package_info['assignee'],
                'Label': f"lamuc_{self.test_case.lower().replace(' ', '_')}",
                'Components': package_info['module'],
                'Versions': version_clean,
                'Severity': self._map_severity_to_severity_text(bug_severity),
                'Team Found': 'ODM',
                'Product Affected': 'Lamu26 (lamuc)',
                'PS': ps_content,

                # 原始数据
                'path': issue_data['path'],
                'version': issue_data['version'],
                'exp_class': issue_data['exp_class'],
                'exp_type': issue_data['exp_type'],
                'cur_process': issue_data['cur_process'],
                'package': issue_data['package'],
                'count': issue_data['count'],
                'device_id': issue_data['device_id'],
                'bug_severity': bug_severity
            }

            return jira_issue

        except Exception as e:
            logger.error(f"生成JIRA问题记录失败: {e}")
            return None

    def save_upload_list_to_excel(self, output_path: str = None):
        """保存上传清单到Excel文件"""
        try:
            if not output_path:
                timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
                output_path = os.path.join(f"JIRA_Upload_List_Moto_{timestamp}.xlsx")
            else:
                # 如果指定路径的目录不存在，尝试创建
                output_dir = os.path.dirname(os.path.abspath(output_path))
                if output_dir and not os.path.exists(output_dir):
                    os.makedirs(output_dir, exist_ok=True)

            if not self.stats['upload_list']:
                logger.warning("没有生成的上传清单数据")
                return False

            # 转换为DataFrame
            df = pd.DataFrame(self.stats['upload_list'])

            # 选择需要的列并按照模板顺序排列
            columns_order = [
                'Project', 'Issue Type', 'Summary', 'Description', 'Priority',
                'Assignee', 'Label', 'Components', 'Versions', 'Severity',
                'Team Found', 'Product Affected', 'PS'
            ]

            df_output = df[columns_order]

            # 保存到Excel
            df_output.to_excel(output_path, index=False, engine='openpyxl')
            logger.info(f"Motorola JIRA上传清单已保存到: {output_path}")

            return True

        except Exception as e:
            logger.error(f"保存上传清单失败: {e}")
            return False

    def print_statistics(self):
        """打印统计信息"""
        print("\n" + "="*60)
        print("Motorola JIRA问题上传清单生成统计")
        print("="*60)
        print(f"总记录数: {self.stats['total_records']}")
        print(f"成功处理: {self.stats['processed_records']}")
        print(f"处理失败: {self.stats['failed_records']}")
        print(f"成功率: {(self.stats['processed_records']/self.stats['total_records']*100):.1f}%" if self.stats['total_records'] > 0 else "成功率: 0%")

        if self.stats['upload_list']:
            print("\n按问题等级分布:")
            severity_count = {}
            for issue in self.stats['upload_list']:
                severity = issue['bug_severity']
                severity_count[severity] = severity_count.get(severity, 0) + 1

            for severity, count in sorted(severity_count.items()):
                print(f"  {severity}: {count}")

            print("\n按模块分布:")
            module_count = {}
            for issue in self.stats['upload_list']:
                module = issue['Components']
                module_count[module] = module_count.get(module, 0) + 1

            for module, count in sorted(module_count.items(), key=lambda x: x[1], reverse=True)[:10]:
                print(f"  {module}: {count}")

        print("="*60)

def main():
    """主函数"""
    try:
        parser = argparse.ArgumentParser(description="生成Motorola JIRA问题上传清单")
        parser.add_argument("-add-main-excel", "--add-main-excel", dest="main_excel_path", help="指定主结果Excel路径")
        parser.add_argument("--set-test-case", dest="test_case", default="Monkey", help="指定测试项名称（默认: Monkey）")

        # 无参数时直接打印帮助信息
        if len(sys.argv) == 1:
            parser.print_help()
            return

        args = parser.parse_args()

        logger.info("开始Motorola Excel文件JIRA问题上传清单生成...")

        # 创建生成器
        generator = ExcelToJiraUploadListMoto(main_file_path=args.main_excel_path, test_case=args.test_case)

        # 加载Excel文件
        if not generator.load_excel_files():
            logger.error("加载Excel文件失败")
            return

        # 生成上传清单
        if not generator.generate_upload_list():
            logger.error("生成上传清单失败")
            return

        # 保存到Excel文件
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        excel_output = f"JIRA_Upload_List_Moto_{args.test_case}_{timestamp}.xlsx"
        generator.save_upload_list_to_excel(excel_output)

        # 打印统计信息
        generator.print_statistics()

        logger.info("Motorola Excel文件JIRA问题上传清单生成完成")

    except Exception as e:
        logger.error(f"程序执行失败: {e}")
        raise

if __name__ == "__main__":
    main()
