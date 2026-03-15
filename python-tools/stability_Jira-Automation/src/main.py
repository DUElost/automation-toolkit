#!/usr/bin/env python3
"""
JIRA Monkey测试自动化系统主程序

支持分阶段执行：
- sync: Phase 1 - 仅同步 JIRA 数据到本地（无需 Excel）
- preprocess: Phase 1+2 - 同步 + 预处理（输出预处理报告）
- execute: Phase 3+4 - 决策执行 + 回归验证（需要预处理报告）
- full: 完整流程 Phase 1-4

工作流阶段：
1. 初始化阶段：解析配置 → 数据库定位 → JIRA 连接 → 数据同步
2. 数据预处理：Excel 解析 → 数据标准化 → 经办人分配 → 写入待处理队列
3. 决策执行：候选匹配 → 决策判定 → JIRA 执行 → 本地同步
4. 回归验证：候选筛选 → 匹配检查 → PASS 记录
5. 收尾：数据持久化 → 连接关闭 → 结果汇总
"""

import sys
import logging
import argparse
import json
from pathlib import Path
from typing import List, Dict, Any, Optional
from urllib.parse import urlparse
from datetime import datetime

import urllib3

# 添加项目路径
sys.path.append(str(Path(__file__).parent))

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

from modules.config_loader import ConfigLoader
from modules.excel_parser import ExcelParser
from modules.data_normalizer import DataNormalizer
from modules.lark_integration import LarkIntegration
from modules.database_manager import DatabaseManager
from modules.jira_synchronizer import JIRASynchronizer
from modules.decision_engine import DecisionEngine
from modules.jira_executor import JIRAExecutor

# 项目根目录
PROJECT_ROOT = Path(__file__).parent.parent

# 配置文件路径
COMMENT_TEMPLATES_FILE = PROJECT_ROOT / "config" / "comment_templates.json"


def setup_logging(log_level: str = 'INFO', log_file: str = None):
    """设置日志配置"""
    level = getattr(logging, log_level.upper(), logging.INFO)
    
    formatter = logging.Formatter(
        '%(asctime)s - %(name)s - %(levelname)s - %(message)s'
    )
    
    root_logger = logging.getLogger()
    root_logger.setLevel(level)
    
    # 清除已有处理器
    root_logger.handlers.clear()
    
    # 控制台处理器
    console_handler = logging.StreamHandler()
    console_handler.setFormatter(formatter)
    root_logger.addHandler(console_handler)
    
    # 文件处理器
    if log_file:
        log_path = Path(log_file)
        log_path.parent.mkdir(parents=True, exist_ok=True)
        file_handler = logging.FileHandler(log_file, encoding='utf-8')
        file_handler.setFormatter(formatter)
        root_logger.addHandler(file_handler)
    
    return root_logger


def load_title_keywords() -> List[str]:
    """从配置文件加载标题关键字"""
    default_keywords = ["[自动化]", "[V551A]", "[MonkeyAEE]"]
    
    if not COMMENT_TEMPLATES_FILE.exists():
        return default_keywords
    
    try:
        with open(COMMENT_TEMPLATES_FILE, "r", encoding="utf-8") as f:
            config = json.load(f)
        
        regression_filter = config.get("regression_pass_filter", {})
        keywords = regression_filter.get("title_keywords", default_keywords)
        return keywords if keywords else default_keywords
        
    except (json.JSONDecodeError, IOError) as e:
        logging.warning(f"加载标题关键字配置失败: {e}，使用默认值")
        return default_keywords


def parse_jira_host(jira_url: str) -> str:
    """从 JIRA URL 解析主机名标识"""
    parsed = urlparse(jira_url)
    netloc = parsed.netloc or parsed.path
    parts = netloc.split('.')
    
    if len(parts) >= 2:
        if parts[0].lower() == 'jira':
            return parts[1]
        return parts[0]
    return netloc.replace('.', '_')


def resolve_db_path(jira_config: Dict[str, Any], args) -> str:
    """根据 JIRA 配置解析数据库路径"""
    if args.db_path != 'jira_automation.db':
        return args.db_path
    
    jira_url = jira_config.get("url", "")
    project_key = jira_config.get("project_key", "LOCAL")
    
    if not jira_url:
        return args.db_path
    
    jira_host = parse_jira_host(jira_url)
    db_dir = PROJECT_ROOT / "db"
    db_dir.mkdir(parents=True, exist_ok=True)
    
    return str(db_dir / f"{jira_host}_{project_key}.db")


def build_jql(project_key: str, keywords: List[str]) -> str:
    """构建 JQL 查询语句"""
    conditions = []
    for keyword in keywords:
        escaped = keyword.replace('[', '\\\\[').replace(']', '\\\\]')
        conditions.append(f'summary ~ "{escaped}"')
    
    return f'project = {project_key} AND type = Bug AND {" AND ".join(conditions)}'


def sync_jira_to_local(
    jira_sync: JIRASynchronizer,
    db: DatabaseManager,
    project_key: str,
    keywords: List[str],
    max_results: int = 100,
) -> int:
    """从 JIRA 同步符合条件的问题到本地数据库"""
    logger = logging.getLogger(__name__)
    
    jql = build_jql(project_key, keywords)
    logger.info(f"JQL 查询: {jql}")
    
    try:
        search_result = jira_sync.search_issues(jql, max_results=max_results)
        issues = search_result.get("issues", [])
        logger.info(f"从 JIRA 获取到 {len(issues)} 个问题")
    except Exception as e:
        logger.error(f"搜索 JIRA 问题失败: {e}")
        return 0
    
    synced_count = 0
    for issue in issues:
        try:
            jira_key = issue.get("key")
            fields = issue.get("fields", {})
            
            status = fields.get("status", {}).get("name", "Open")
            summary = fields.get("summary", "")
            description = fields.get("description", "")
            resolution = fields.get("resolution", {})
            resolution_name = resolution.get("name", "") if resolution else ""
            assignee = fields.get("assignee", {})
            assignee_name = assignee.get("name", "") if assignee else ""
            priority = fields.get("priority", {})
            priority_name = priority.get("name", "Medium") if priority else "Medium"
            
            fix_versions = fields.get("fixVersions", [])
            fix_version = fix_versions[0].get("name") if fix_versions else None
            
            # 提取自定义字段
            # customfield_10121 -> test_environment (优先)，回退到 environment 字段
            # customfield_10500 -> raw_caused_by (key_information)
            test_environment = fields.get("customfield_10121") or fields.get("environment") or ""
            raw_caused_by = fields.get("customfield_10500") or ""
            
            existing = db.get_issue_by_key(jira_key)
            
            if existing:
                # 保留本地的回归验证相关字段，不被同步覆盖
                update_data = {
                    "status": status,
                    "summary": summary,
                    "description": description,
                    "resolution": resolution_name,
                    "assignee": assignee_name,
                    "priority": priority_name,
                    "test_environment": test_environment,
                    "raw_caused_by": raw_caused_by,
                }
                if fix_version:
                    update_data["fix_version"] = fix_version
                
                # 注意：不更新 regression_pass_count 和 verified_versions
                # 这些字段由回归验证逻辑维护，同步时应保留本地值
                
                db.update_main_table_record(jira_key, update_data)
                logger.debug(f"更新问题: {jira_key} ({status}, {resolution_name})")
            else:
                issue_data = {
                    "jira_key": jira_key,
                    "status": status,
                    "summary": summary,
                    "normalized_summary": summary,
                    "description": description,
                    "resolution": resolution_name,
                    "test_environment": test_environment,
                    "raw_caused_by": raw_caused_by,
                    "assignee": assignee_name,
                    "bug_severity": "C",
                    "priority": priority_name,
                    "package_name": "",
                    "fix_version": fix_version,
                    "regression_pass_count": 0,
                }
                db.insert_issue(issue_data)
                logger.debug(f"插入问题: {jira_key} ({status}, {resolution_name})")
            
            synced_count += 1
            
        except Exception as e:
            logger.warning(f"同步问题 {issue.get('key')} 失败: {e}")
    
    return synced_count


def build_jira_config(config_loader: ConfigLoader, args) -> Dict[str, Any]:
    """根据配置文件与命令行参数生成最终 JIRA 配置"""
    base_config = dict(config_loader.get_jira_config() or {})
    overrides = {
        'url': getattr(args, 'jira_url', None),
        'username': getattr(args, 'jira_username', None),
        'password': getattr(args, 'jira_password', None),
        'api_token': getattr(args, 'jira_api_token', None),
        'p12_path': getattr(args, 'jira_p12_path', None),
        'p12_password': getattr(args, 'jira_p12_password', None),
        'project_key': getattr(args, 'jira_project_key', None),
        'issue_type': getattr(args, 'jira_issue_type', None),
        'mode': getattr(args, 'jira_mode', None),
    }
    for key, value in overrides.items():
        if value not in (None, ''):
            base_config[key] = value
    return base_config


# ============================================================
# Phase 1: JIRA 数据同步
# ============================================================
def run_phase1_sync(db: DatabaseManager, jira_config: Dict[str, Any], args) -> Dict[str, Any]:
    """
    Phase 1: 仅同步 JIRA 数据到本地数据库
    
    Returns:
        同步结果统计
    """
    logger = logging.getLogger(__name__)
    logger.info("=" * 60)
    logger.info("Phase 1: JIRA 数据同步")
    logger.info("=" * 60)
    
    result = {"phase": 1, "success": False, "synced_count": 0, "error": None}
    
    keywords = args.title_keywords or load_title_keywords()
    logger.info(f"标题关键字: {keywords}")
    
    jira_sync = JIRASynchronizer(jira_config)
    if not jira_sync.is_authenticated():
        result["error"] = "JIRA 认证失败"
        logger.error(result["error"])
        return result
    
    try:
        project_key = jira_config.get("project_key", "LOCAL")
        synced = sync_jira_to_local(jira_sync, db, project_key, keywords, args.max_sync)
        result["synced_count"] = synced
        result["success"] = True
        logger.info(f"JIRA 同步完成: {synced} 个问题")
    except Exception as e:
        result["error"] = str(e)
        logger.error(f"同步失败: {e}")
    finally:
        jira_sync.close()
    
    return result


# ============================================================
# Phase 2: 数据预处理
# ============================================================
def run_phase2_preprocess(
    db: DatabaseManager, 
    lark_integration: LarkIntegration,
    excel_path: str,
    output_path: Optional[str] = None
) -> Dict[str, Any]:
    """
    Phase 2: 数据预处理（Excel 解析 → 标准化 → 写入待处理队列）
    
    Args:
        db: 数据库管理器
        lark_integration: 飞书集成
        excel_path: 原始 Excel 文件路径
        output_path: 预处理报告输出路径（可选）
        
    Returns:
        预处理结果统计
    """
    logger = logging.getLogger(__name__)
    logger.info("=" * 60)
    logger.info("Phase 2: 数据预处理")
    logger.info("=" * 60)
    
    result = {
        "phase": 2, 
        "success": False, 
        "raw_count": 0,
        "normalized_count": 0,
        "pending_count": 0,
        "output_file": None,
        "error": None
    }
    
    try:
        # 解析 Excel
        excel_parser = ExcelParser()
        logger.info(f"解析 Excel: {excel_path}")
        raw_data = excel_parser.parse_excel(excel_path)
        result["raw_count"] = len(raw_data)
        logger.info(f"Excel 解析完成: {len(raw_data)} 条数据")
        
        # 数据标准化
        data_normalizer = DataNormalizer()
        normalized_data = data_normalizer.batch_normalize(raw_data)
        result["normalized_count"] = len(normalized_data)
        logger.info(f"数据标准化完成: {len(normalized_data)} 条数据")
        
        # 应用过滤规则
        filtered_data = apply_filters(lark_integration, normalized_data)
        
        # 准备待处理问题
        pending_issues = prepare_pending_issues(lark_integration, filtered_data)
        result["pending_count"] = len(pending_issues)
        
        # 写入数据库
        for issue in pending_issues:
            db.insert_pending_issue(issue)
        logger.info(f"待处理问题已写入数据库: {len(pending_issues)} 条")
        
        # 输出预处理报告
        if output_path:
            output_file = save_preprocessed_report(pending_issues, output_path)
            result["output_file"] = output_file
            logger.info(f"预处理报告已保存: {output_file}")
        
        result["success"] = True
        
    except Exception as e:
        result["error"] = str(e)
        logger.error(f"预处理失败: {e}")
    
    return result


def save_preprocessed_report(pending_issues: List[Dict[str, Any]], output_path: str) -> str:
    """保存预处理报告为 Excel 文件"""
    import pandas as pd
    
    # 选择关键字段输出
    columns = [
        'package_name', 'module', 'exp_class', 'exp_type', 'version',
        'count', 'device_count', 'bug_severity', 'assignee',
        'normalized_summary', 'jira_summary', 'test_environment'
    ]
    
    rows = []
    for issue in pending_issues:
        row = {col: issue.get(col, '') for col in columns}
        rows.append(row)
    
    df = pd.DataFrame(rows)
    
    # 生成输出文件名
    if output_path.endswith('/') or output_path.endswith('\\'):
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        output_file = Path(output_path) / f"preprocessed_{timestamp}.xlsx"
    else:
        output_file = Path(output_path)
    
    output_file.parent.mkdir(parents=True, exist_ok=True)
    df.to_excel(str(output_file), index=False)
    
    return str(output_file)


# ============================================================
# Phase 3 & 4: 决策执行 + 回归验证
# ============================================================
def run_phase34_execute(
    db: DatabaseManager,
    jira_config: Dict[str, Any],
    args
) -> Dict[str, Any]:
    """
    Phase 3 & 4: 决策执行 + 回归验证
    
    Returns:
        执行结果统计
    """
    logger = logging.getLogger(__name__)
    logger.info("=" * 60)
    logger.info("Phase 3 & 4: 决策执行 + 回归验证")
    logger.info("=" * 60)
    
    result = {
        "phase": "3+4",
        "success": False,
        "processed_count": 0,
        "created": 0,
        "updated": 0,
        "regression_closed": 0,
        "error_count": 0,
        "error": None
    }
    
    if not jira_config:
        result["error"] = "JIRA 配置未找到"
        logger.warning(result["error"])
        return result
    
    jira_sync = JIRASynchronizer(jira_config)
    if not jira_sync.is_authenticated():
        result["error"] = "JIRA 认证失败"
        logger.error(result["error"])
        return result
    
    try:
        # 初始化决策引擎
        decision_config = {
            'similarity_threshold': 0.85,
            'decision_rules': {},
            'cache_enabled': True,
            'cache_ttl': 3600
        }
        decision_engine = DecisionEngine(db, decision_config)
        
        # 初始化 JIRA 执行器
        executor_config = {
            'max_workers': args.max_workers,
            'retry_count': 3,
            'retry_delay': 5,
            'batch_size': args.batch_size,
            'dry_run': args.dry_run
        }
        executor = JIRAExecutor(jira_sync, decision_engine, db, executor_config)
        
        # 处理待处理问题
        logger.info("开始处理待处理问题")
        exec_result = executor.process_pending_issues(limit=args.batch_size)
        
        if exec_result['success']:
            result["processed_count"] = exec_result['processed_count']
            result["error_count"] = exec_result['error_count']
            
            stats = executor.get_execution_stats()
            result["created"] = stats['created']
            result["updated"] = stats['updated']
            result["regression_closed"] = stats['regression_closed']
            result["success"] = True
            
            logger.info(f"处理完成: {result['processed_count']} 个问题")
            logger.info(f"创建={result['created']}, 更新={result['updated']}, 回归关闭={result['regression_closed']}")
        else:
            result["error"] = exec_result.get('error', '未知错误')
            logger.error(f"处理失败: {result['error']}")
            
    except Exception as e:
        result["error"] = str(e)
        logger.error(f"执行失败: {e}")
    finally:
        jira_sync.close()
    
    return result


def apply_filters(lark_integration: LarkIntegration, data: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
    """应用过滤规则"""
    logger = logging.getLogger(__name__)
    
    try:
        package_list = [item['package'] for item in data]
        filtered_packages = lark_integration.filter_by_blacklist(package_list)
        filtered_packages = lark_integration.filter_by_whitelist(filtered_packages)
        
        filtered_data = [
            item for item in data 
            if item['package'] in filtered_packages
        ]
        
        logger.info(f"过滤完成: {len(data)} -> {len(filtered_data)}")
        return filtered_data
        
    except Exception as e:
        logger.error(f"过滤失败: {e}")
        return data


def _infer_affect_project(version: Optional[str]) -> str:
    if not version:
        return "UNKNOWN"
    return str(version).split('-')[0]


def prepare_pending_issues(lark_integration: LarkIntegration, 
                          filtered_data: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
    """准备待处理问题"""
    pending_issues = []
    
    for item in filtered_data:
        module = lark_integration.get_module_by_package(item['package'])
        assignee = lark_integration.get_assignee_by_module(module)
        affect_project = item.get('affect_project') or _infer_affect_project(item.get('version'))
        
        pending_issue = {
            'action': 'CREATE',
            'package_name': item['package'],
            'module': module,
            'key_information': item.get('key_information'),
            'exp_class': item['exp_class'],
            'exp_type': item['exp_type'],
            'cur_process': item['cur_process'],
            'version': item['version'],
            'detail': item['detail'],
            'caused_by': item['caused_by'],
            'count': item['count'],
            'device_count': item['device_count'],
            'normalized_summary': item['normalized_summary'],
            'test_environment': item['test_environment'],
            'bug_severity': item['bug_severity'],
            'priority': item.get('priority'),
            'assignee': assignee,
            'jira_summary': item['jira_summary'],
            'jira_description': item['jira_description'],
            'ps': item.get('ps'),
            'affect_project': affect_project,
            'source_file': item.get('source_file', 'excel'),
            'row_number': item.get('row_number', 0),
            'raw_data': item
        }
        
        pending_issues.append(pending_issue)
    
    return pending_issues


def print_summary(results: List[Dict[str, Any]], db_path: str, jira_url: str, project_key: str):
    """打印执行结果汇总"""
    print()
    print("=" * 60)
    print("执行结果汇总")
    print("=" * 60)
    print(f"JIRA 系统: {jira_url}")
    print(f"项目库: {project_key}")
    print(f"本地数据库: {db_path}")
    print()
    
    for r in results:
        phase = r.get("phase", "?")
        success = "✓" if r.get("success") else "✗"
        print(f"Phase {phase}: {success}")
        
        if r.get("synced_count") is not None:
            print(f"  - 同步问题数: {r['synced_count']}")
        if r.get("pending_count") is not None:
            print(f"  - 待处理问题: {r['pending_count']}")
        if r.get("output_file"):
            print(f"  - 预处理报告: {r['output_file']}")
        if r.get("processed_count") is not None:
            print(f"  - 处理数: {r['processed_count']}")
            print(f"  - 创建数: {r.get('created', 0)}")
            print(f"  - 更新数: {r.get('updated', 0)}")
            print(f"  - 回归关闭: {r.get('regression_closed', 0)}")
        if r.get("error"):
            print(f"  - 错误: {r['error']}")
    
    print("=" * 60)


def main():
    """主函数"""
    parser = argparse.ArgumentParser(
        description='JIRA Monkey测试自动化系统',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
执行动作说明:
  sync        Phase 1 - 仅同步 JIRA 数据到本地（无需 Excel）
  preprocess  Phase 1+2 - 同步 + 预处理（输出预处理报告）
  execute     Phase 3+4 - 决策执行 + 回归验证（需要预处理报告或原始报告）
  full        完整流程 Phase 1-4（需要原始报告）

示例:
  # 仅同步 JIRA 数据
  python src/main.py --action sync
  
  # 同步 + 预处理，输出预处理报告
  python src/main.py --action preprocess --excel data/monkey.xlsx --output data/
  
  # 执行决策（跳过同步，使用已有数据库）
  python src/main.py --action execute --excel data/preprocessed.xlsx --skip-sync
  
  # 完整流程
  python src/main.py --action full --excel data/monkey.xlsx
"""
    )
    
    # 基础参数
    parser.add_argument('--config', '-c', default='.env', help='配置文件路径')
    parser.add_argument('--excel', '-e', help='Excel文件路径（sync 动作不需要）')
    parser.add_argument('--output', '-o', help='预处理报告输出路径（preprocess 动作使用）')
    parser.add_argument('--log-level', '-l', default='INFO', 
                       choices=['DEBUG', 'INFO', 'WARNING', 'ERROR'], help='日志级别')
    parser.add_argument('--log-file', help='日志文件路径')
    parser.add_argument('--db-path', default='jira_automation.db', 
                       help='SQLite数据库路径（默认根据 JIRA URL 和项目自动生成）')
    
    # 执行动作
    parser.add_argument('--action', '-a',
                       choices=['sync', 'preprocess', 'execute', 'full'],
                       default='full', help='执行动作')
    parser.add_argument('--dry-run', action='store_true', help='试运行模式')
    parser.add_argument('--batch-size', type=int, default=10, help='批量处理大小')
    parser.add_argument('--max-workers', type=int, default=3, help='最大工作线程数')
    
    # JIRA 相关参数
    parser.add_argument('--jira-url', help='覆盖JIRA服务器地址')
    parser.add_argument('--jira-user', '--user', dest='jira_username', help='覆盖JIRA用户名')
    parser.add_argument('--jira-password', '--password', dest='jira_password', help='覆盖JIRA密码')
    parser.add_argument('--jira-api-token', dest='jira_api_token', help='覆盖JIRA API Token')
    parser.add_argument('--jira-p12', '--p12file', dest='jira_p12_path', help='P12证书路径')
    parser.add_argument('--jira-p12-password', '--p12password', dest='jira_p12_password', help='P12证书密码')
    parser.add_argument('--jira-project-key', '--project', dest='jira_project_key', help='覆盖项目Key')
    parser.add_argument('--jira-issue-type', dest='jira_issue_type', help='覆盖问题类型')
    parser.add_argument('--jira-mode', choices=['rest', 'mock'], help='强制指定JIRA模式')
    
    # 同步参数
    parser.add_argument('--skip-sync', action='store_true', help='跳过 JIRA 同步步骤')
    parser.add_argument('--max-sync', type=int, default=100, help='最大同步数量')
    parser.add_argument('--title-keywords', nargs='+', help='标题筛选关键字（覆盖配置文件）')
    
    args = parser.parse_args()
    
    # 验证参数
    if args.action in ['preprocess', 'execute', 'full'] and not args.excel:
        parser.error(f"--action {args.action} 需要指定 --excel 参数")
    
    try:
        # 设置日志
        logger = setup_logging(args.log_level, args.log_file)
        logger.info("=== JIRA Monkey测试自动化系统启动 ===")
        logger.info(f"执行动作: {args.action}")
        
        # 加载配置
        config_loader = ConfigLoader(args.config)
        jira_config = build_jira_config(config_loader, args)
        
        # 解析数据库路径
        db_path = resolve_db_path(jira_config, args)
        logger.info(f"数据库路径: {db_path}")
        
        # 初始化数据库
        db_config = {'type': 'sqlite', 'path': db_path}
        results = []
        
        with DatabaseManager(db_config) as db:
            # 初始化飞书集成
            lark_config = config_loader.get_lark_config()
            lark_integration = LarkIntegration(lark_config)
            
            # ============================================================
            # 根据 action 执行不同阶段
            # ============================================================
            
            # Phase 1: JIRA 同步
            # sync, preprocess, execute, full 都默认执行 Phase 1（除非指定 --skip-sync）
            if args.action in ['sync', 'preprocess', 'execute', 'full'] and not args.skip_sync:
                result = run_phase1_sync(db, jira_config, args)
                results.append(result)
                if not result["success"] and args.action == 'sync':
                    sys.exit(1)
            
            # Phase 2: 数据预处理
            if args.action in ['preprocess', 'full']:
                output_path = args.output if args.action == 'preprocess' else None
                result = run_phase2_preprocess(db, lark_integration, args.excel, output_path)
                results.append(result)
                if not result["success"]:
                    sys.exit(1)
            
            # Phase 3+4: 决策执行 + 回归验证
            if args.action in ['execute', 'full']:
                # execute 模式需要先预处理 Excel（如果有）
                if args.action == 'execute' and args.excel:
                    result = run_phase2_preprocess(db, lark_integration, args.excel, None)
                    results.append(result)
                    if not result["success"]:
                        sys.exit(1)
                
                result = run_phase34_execute(db, jira_config, args)
                results.append(result)
        
        # 打印汇总
        jira_url = jira_config.get("url", "N/A")
        project_key = jira_config.get("project_key", "N/A")
        print_summary(results, db_path, jira_url, project_key)
        
        logger.info("=== 程序执行完成 ===")
        
    except Exception as e:
        logging.error(f"程序执行失败: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)


if __name__ == "__main__":
    main()
