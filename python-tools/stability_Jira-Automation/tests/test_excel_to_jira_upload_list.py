#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Excel文件JIRA问题上传清单生成器

功能：
1. 读取Result_VFFBA_V551A_dai.lv_MonkeyAEE_DCC_20250808.xls文件
2. 读取包名与模块&经办人对应表.xls文件
3. 读取问题等级定级表.xls文件
4. 生成规范的JIRA问题上传清单

作者：AI Assistant
创建时间：2025-01-08
"""

import os
import sys
import logging
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Any, Optional

import pandas as pd

# 将仓库 modules/src 目录加入 Python 路径，确保在不同执行入口下都能导入
_MODULE_PATH = Path(__file__).resolve()
_MODULES_ROOT = _MODULE_PATH.parent  # .../src/modules
if str(_MODULES_ROOT) not in sys.path:
    sys.path.insert(0, str(_MODULES_ROOT))
_REPO_ROOT = _MODULE_PATH.parents[2]
_CONFIG_DIR_DEFAULT = _REPO_ROOT / "config"

from config_loader import ConfigLoader
from database_manager import DatabaseManager

# 配置日志
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('excel_to_jira_upload_list.log', encoding='utf-8'),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger(__name__)

class ExcelToJiraUploadListGenerator:
    """Excel文件JIRA问题上传清单生成器"""
    
    def __init__(self, main_file_path: Optional[str] = None, config_dir: Optional[str] = None):
        """初始化生成器"""
        self.config = ConfigLoader()
        self.db_manager = DatabaseManager(self.config)
        self.repo_root = _REPO_ROOT
        self.config_dir = Path(config_dir) if config_dir else _CONFIG_DIR_DEFAULT
        if not self.config_dir.exists():
            logger.warning(f"配置目录不存在: {self.config_dir}")
        
        # 文件路径
        if main_file_path:
            self.main_excel_path = Path(main_file_path)
        else:
            # 自动检测主数据文件（优先xlsx，然后xls）
            self.main_excel_path = self._find_main_data_file()
        
        self.package_mapping_path = self.config_dir / "包名与模块&经办人对应表.xls"
        self.severity_mapping_path = self.config_dir / "问题等级定级表.xls"
        
        # 数据存储
        self.main_data = None
        self.package_mapping = {}
        self.severity_rules = []
        
        # 统计信息
        self.stats = {
            'total_records': 0,
            'processed_records': 0,
            'failed_records': 0,
            'upload_list': []
        }
    
    def _find_main_data_file(self) -> Path:
        """自动检测主数据文件"""
        base_dir = self.config_dir
        if not base_dir.exists():
            logger.warning(f"配置目录 {base_dir} 不存在，无法自动检测主数据文件")
            return base_dir / "Result_None_None_MonkeyAEE_SH_20250805.xls"
        
        # 查找模式：Result_*_MonkeyAEE_*.xlsx 或 Result_*_MonkeyAEE_*.xls
        patterns = [
            base_dir.glob("Result_*_MonkeyAEE_*.xlsx"),
            base_dir.glob("Result_*_MonkeyAEE_*.xls"),
        ]
        
        candidates: List[Path] = []
        
        for pattern_iter in patterns:
            candidates.extend(pattern_iter)
        
        if candidates:
            latest_file = max(candidates, key=lambda path: path.stat().st_mtime)
            logger.info(f"自动检测到主数据文件: {latest_file}")
            return latest_file
        
        # 如果没有找到，使用默认文件
        default_files = [
            base_dir / "Result_None_None_MonkeyAEE_SH_20250805.xlsx",
            base_dir / "Result_None_None_MonkeyAEE_SH_20250805.xls",
        ]
        
        for default_file in default_files:
            if default_file.exists():
                logger.info(f"使用默认主数据文件: {default_file}")
                return default_file
        
        # 如果都没有找到，返回第一个默认文件（会在后续加载时报错）
        logger.warning("未找到主数据文件，使用默认路径")
        return default_files[0]
    
    def _read_excel_file(self, file_path: Path) -> pd.DataFrame:
        """智能读取Excel文件，自动检测.xls和.xlsx格式"""
        file_path = Path(file_path)
        try:
            if not file_path.exists():
                raise FileNotFoundError(f"Excel 文件不存在: {file_path}")
            # 首先尝试使用默认引擎读取
            suffix = file_path.suffix.lower()
            if suffix == '.xlsx':
                # 对于.xlsx文件，使用openpyxl引擎
                return pd.read_excel(file_path, engine='openpyxl')
            elif suffix == '.xls':
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
            # Excel结构：包名 | 模块 | 经办人
            for _, row in df.iterrows():
                package = str(row['包名']).strip() if pd.notna(row['包名']) else ""
                module = str(row['模块']).strip() if pd.notna(row['模块']) else ""
                assignee = str(row['经办人']).strip() if pd.notna(row['经办人']) else ""
                
                if package and module and assignee:
                    self.package_mapping[package] = {
                        'module': module,
                        'assignee': assignee
                    }
                    
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
        # 根据实际Excel列结构提取数据：Id, Path, Version, ExpTime, ExpClass, ExpType, CurProcess, Package, Detail, CausedBy, extraTag, Count, DeviceCount
        affect_raw = row.get('AffectProject', '')
        affect_project = ""
        if pd.notna(affect_raw):
            affect_str = str(affect_raw).strip()
            if affect_str and affect_str.lower() != 'nan':
                affect_project = affect_str

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
            'device_count': int(row['DeviceCount']) if pd.notna(row['DeviceCount']) and str(row['DeviceCount']).replace('.', '').isdigit() else 0,
            'affect_project': affect_project,
        }
    
    def _generate_jira_issue(self, issue_data: Dict[str, Any]) -> Optional[Dict[str, Any]]:
        """生成JIRA问题记录"""
        try:
            # 获取包名映射信息
            package_info = self.package_mapping.get(issue_data['package'], {
                'module': 'Unknown',
                'assignee': 'autotest'
            })
            
            # 确定问题等级
            bug_severity = self._determine_bug_severity(issue_data)
            
            # 生成概要
            summary = self._generate_summary(issue_data)
            
            # 生成描述
            description = self._generate_description(issue_data)
            
            # 确定优先级
            priority = self._map_severity_to_priority(bug_severity)
            
            # 构建JIRA问题记录
            jira_issue = {
                'project': 'VFFBA',
                'issue_type': '故障',  # 默认问题类型
                'summary': summary,
                'assignee': package_info['assignee'],
                'module': package_info['module'],
                'priority': priority,
                'description': description,
                'key_information': issue_data['caused_by'],
                'bug_severity': bug_severity,
                'previous_version_status': '100%',  # 默认值
                'affect_project': issue_data.get('affect_project', ''),
                
                # 原始数据
                'path': issue_data['path'],
                'version': issue_data['version'],
                'environment': issue_data['version'],
                'exp_class': issue_data['exp_class'],
                'exp_type': issue_data['exp_type'],
                'cur_process': issue_data['cur_process'],
                'package': issue_data['package'],
                'count': issue_data['count'],
                'device_count': issue_data['device_count']
            }
            
            return jira_issue
            
        except Exception as e:
            logger.error(f"生成JIRA问题记录失败: {e}")
            return None
    
    def _generate_summary(self, issue_data: Dict[str, Any]) -> str:
        """生成JIRA概要"""
        try:
            # 格式：[Total Number 报错次数][版本][MonkeyAEE][报错]报错 包名
            # 示例：[Total Number 51][V551A][MonkeyAEE][JE]JE报错 com.android.systemui
            
            count = issue_data['count']
            version = issue_data['version']
            exp_class = issue_data['exp_class']
            package = issue_data['package']
            
            # 清理版本信息
            version_clean = self._clean_version(version)
            
            summary = f"[自动化][V551A][Total Number {count}][{version_clean}][MonkeyAEE][{exp_class}]{package}发生{exp_class}"
            
            # 限制长度
            if len(summary) > 255:
                summary = summary[:252] + "..."
                
            return summary
            
        except Exception as e:
            logger.error(f"生成概要失败: {e}")
            return f"Exception in {issue_data.get('package', 'Unknown')}"
    
    def _clean_version(self, version: str) -> str:
        """清理版本信息，提取关键部分"""
        if not version:
            return 'Unknown'
        
        # 如果是ELA-LX3或ELA-LX2版本,统一替换为V551A
        if 'ELA-LX3' in version or 'ELA-LX2' in version:
            version_parts = version.split('-')
            if len(version_parts) >= 3:
                version_suffix = '-'.join(version_parts[2:])  # 取第二个-后面的所有部分
            else:
                version_suffix = version_parts[-1] if len(version_parts) > 1 else ''
            return f'V551A-{version_suffix}'
        else:
            return version[:20]
    
    def _generate_description(self, issue_data: Dict[str, Any]) -> str:
        """生成JIRA描述"""
        try:
            description = f"""{issue_data['detail']}"""
            return description
            
        except Exception as e:
            logger.error(f"生成描述失败: {e}")
            return f"Exception in {issue_data.get('package', 'Unknown')}"
    
    def _determine_bug_severity(self, issue_data: Dict[str, Any]) -> str:
        """根据问题等级定级表确定Bug严重程度"""
        try:
            exp_class = issue_data.get('exp_class', '')
            exp_type = issue_data.get('exp_type', '')
            count = issue_data.get('count', 0)
            
            # 遍历等级规则进行匹配
            for rule in self.severity_rules:
                error_type = rule['error_type']
                count_req = rule['count_requirement']
                severity = rule['severity']
                
                # 匹配报错类型
                if error_type in exp_class or error_type in exp_type:
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
            logger.error(f"确定问题等级失败: {e}")
            return 'SWT'
    
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
        """将问题等级映射到优先级"""
        severity_priority_map = {
            'S': 'Highest',
            'A': 'High',
            'B': 'Medium',
            'SWT': 'Low'
        }
        return severity_priority_map.get(severity, 'Medium')
    
    def _map_severity_to_priority_transsion(self, severity: str) -> str:
        """将问题等级映射到Transsion JIRA优先级数字"""
        severity_priority_map = {
            'S': '1',  # 紧急
            'A': '2',  # 严重
            'B': '3',  # 重要
            'SWT': '3'  # 重要
        }
        return severity_priority_map.get(severity, '3')
    
    def save_upload_list_to_excel(self, output_path: str = None):
        """保存上传清单到Excel文件"""
        try:
            if not output_path:
                timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
                output_path = f"JIRA_Upload_List_{timestamp}.xlsx"
            
            if not self.stats['upload_list']:
                logger.warning("没有生成的上传清单数据")
                return False
            
            # 重新组织数据结构以匹配用户要求的表头
            excel_data = []
            for issue in self.stats['upload_list']:
                # 构建Environment列内容
                environment = f"*Package:* {issue['package']}\n*ExpClass:* {issue['exp_class']}\n*ExpType:* {issue['exp_type']}\n*CurProcess:* {issue['cur_process']}"
                
                # 构建PS列内容
                cleaned_version = self._clean_version(issue['version'])
                ps_content = f"""*Reporter:* dailv.tinno
*Version:* {cleaned_version}
*Path:* {issue['path']}
*Duplicate Number:* {issue['count']}
*Device Count:* {issue['device_count']}"""
                
                excel_row = {
                    'Project': issue['project'],
                    'Issue Type': issue['issue_type'],
                    'Summary': issue['summary'],
                    'Assignee': issue['assignee'],
                    'Module': issue['module'],
                    'Priority': issue['priority'],
                    'Description': issue['description'],  # 跟随Detail内容
                    'key_information': issue['key_information'],
                    'Environment': environment,  # 新增Environment列
                    'PS': ps_content,  # 新增PS列
                    'Bug Severity': issue['bug_severity'],
                    'Previous Version Status': issue['previous_version_status']
                }
                excel_data.append(excel_row)
            
            # 转换为DataFrame
            df = pd.DataFrame(excel_data)
            
            # 保存到Excel
            df.to_excel(output_path, index=False, engine='openpyxl')
            logger.info(f"JIRA上传清单已保存到: {output_path}")
            
            return True
            
        except Exception as e:
            logger.error(f"保存上传清单失败: {e}")
            return False
    
    def save_upload_list_to_excel_transsion(self, output_path: str = None):
        """保存上传清单到Excel文件 - Transsion JIRA格式"""
        try:
            if not output_path:
                timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
                output_path = f"JIRA_Upload_List_{timestamp}_Transsion_out.xlsx"
            
            if not self.stats['upload_list']:
                logger.warning("没有生成的上传清单数据")
                return False
            
            # 重新组织数据结构以匹配Transsion JIRA要求的表头
            excel_data = []
            for issue in self.stats['upload_list']:
                # 构建备注列内容（原PS列）
                cleaned_version = self._clean_version(issue['version'])
                remark_content = f"""*Reporter:* dailv.tinno
*Version:* {cleaned_version}
*Path:* {issue['path']}
*Duplicate Number:* {issue['count']}
*Device Count:* {issue['device_count']}"""
                
                excel_row = {
                    'project': issue['project'],  # 固定项目
                    'issuetype': '故障',  # 固定问题类型
                    'summary': issue['summary'],
                    'assignee': issue['assignee'],
                    'components': issue['module'],  # 原Module
                    'versions': issue['version'],  # 固定版本名
                    'priority': self._map_severity_to_priority_transsion(issue['bug_severity']),  # 数字优先级
                    'description': issue['description'],  # 原Description
                    'customfield_12805': issue['key_information'],  # 原key_information
                    'environment': f"*Package:* {issue['package']}\n*ExpClass:* {issue['exp_class']}\n*ExpType:* {issue['exp_type']}\n*CurProcess:* {issue['cur_process']}",  # 原Environment
                    'customfield_10201': 'must',  # 默认值must
                     'customfield_10203': 'Stability',  # 默认值Stability
                     'customfield_10401': 'Auto Test',  # 默认值Auto Test
                     'customfield_10202': 'New issues',  # 默认值New issues
                     'customfield_12500': 'MonkeyTest',  # 默认值MonkeyTest
                     'customfield_12804': 'MonkeyAEE',  # 默认值
                    '备注': remark_content  # 原PS列
                }
                excel_data.append(excel_row)
            
            # 转换为DataFrame
            df = pd.DataFrame(excel_data)
            
            # 保存到Excel
            df.to_excel(output_path, index=False, engine='openpyxl')
            logger.info(f"Transsion JIRA上传清单已保存到: {output_path}")
            
            return True
            
        except Exception as e:
            logger.error(f"保存Transsion上传清单失败: {e}")
            return False
    
    def save_upload_list_to_database(self):
        """保存上传清单到数据库"""
        try:
            if not self.stats['upload_list']:
                logger.warning("没有生成的上传清单数据")
                return False
            
            # 数据库已在初始化时完成连接
            
            success_count = 0
            for issue in self.stats['upload_list']:
                try:
                    # 构建主表记录
                    main_record = {
                        'jira_key': f"VFFBA-PENDING-{datetime.now().strftime('%Y%m%d%H%M%S')}-{success_count}",
                        'summary': issue['summary'],
                        'normalized_summary': issue['summary'],
                        'status': 'Pending Upload',
                        'assignee': issue['assignee'],
                        'priority': issue['priority'],
                        'description': issue['description'],
                        'exp_class': issue['exp_class'],
                        'exp_type': issue['exp_type'],
                        'cur_process': issue['cur_process'],
                        'package_name': issue['package'],
                        'version': issue['version'],
                        'count': issue['count'],
                        'device_count': issue['device_count'],
                        'raw_caused_by': issue['key_information'],
                        'bug_severity': issue['bug_severity'],
                        'test_environment': f"Package: {issue['package']} | ExpClass: {issue['exp_class']} | CurProcess: {issue['cur_process']}",
                        'source_file': 'excel_upload_list'
                    }
                    
                    # 插入数据库
                    self.db_manager.insert_main_table_record(main_record)
                    success_count += 1
                    
                except Exception as e:
                    logger.warning(f"保存问题到数据库失败: {e}")
                    continue
            
            logger.info(f"成功保存 {success_count}/{len(self.stats['upload_list'])} 条记录到数据库")
            return True
            
        except Exception as e:
            logger.error(f"保存到数据库失败: {e}")
            return False
    
    def print_statistics(self):
        """打印统计信息"""
        print("\n" + "="*60)
        print("JIRA问题上传清单生成统计")
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
                module = issue['module']
                module_count[module] = module_count.get(module, 0) + 1
            
            for module, count in sorted(module_count.items(), key=lambda x: x[1], reverse=True)[:10]:
                print(f"  {module}: {count}")
        
        print("="*60)

def main():
    """主函数"""
    try:
        logger.info("开始Excel文件JIRA问题上传清单生成...")
        
        # 创建生成器
        generator = ExcelToJiraUploadListGenerator()
        
        # 加载Excel文件
        if not generator.load_excel_files():
            logger.error("加载Excel文件失败")
            return
        
        # 生成上传清单
        if not generator.generate_upload_list():
            logger.error("生成上传清单失败")
            return
        
        # 保存到Excel文件 - 原版本（适用于jira.tinno.com）
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        excel_output = f"JIRA_Upload_List_{timestamp}.xlsx"
        generator.save_upload_list_to_excel(excel_output)
        
        # 保存到Excel文件 - Transsion版本（适用于jira-ex.transsion.com）
        excel_output_transsion = f"JIRA_Upload_List_{timestamp}_Transsion_out.xlsx"
        generator.save_upload_list_to_excel_transsion(excel_output_transsion)
        
        # 保存到数据库
        generator.save_upload_list_to_database()
        
        # 打印统计信息
        generator.print_statistics()
        
        logger.info("Excel文件JIRA问题上传清单生成完成")
        
    except Exception as e:
        logger.error(f"程序执行失败: {e}")
        raise

if __name__ == "__main__":
    main()
