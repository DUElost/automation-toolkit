#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Tinno 项目历史 SQLite 缓存（DatabaseManager）
------------------------------------------------

供 Tinno 第二阶段建单与回归验证使用，管理本地 jira_issues_main 等表。
"""

import sqlite3
import logging
from typing import Dict, List, Any, Optional
from pathlib import Path
import json

logger = logging.getLogger(__name__)


class DatabaseManager:
    """SQLite 数据库管理器"""
    
    def __init__(self, config: Dict[str, Any]):
        """
        初始化数据库管理器
        
        Args:
            config: 数据库配置，支持以下字段：
                - type: 数据库类型，仅支持 'sqlite'（可选，默认 sqlite）
                - path: 数据库文件路径（可选，默认 jira_automation.db）
        """
        self.config = config
        db_type = config.get('type', 'sqlite')
        
        if db_type != 'sqlite':
            logger.warning(f"不支持的数据库类型 '{db_type}'，将使用 SQLite")
        
        self.db_type = 'sqlite'  # 仅支持 SQLite
        self.db_path = config.get('path', 'jira_automation.db')
        self.connection: Optional[sqlite3.Connection] = None
        self._initialize_database()
    
    def _initialize_database(self):
        """初始化 SQLite 数据库"""
        try:
            # 创建数据库目录
            db_dir = Path(self.db_path).parent
            if db_dir and str(db_dir) != '.':
                db_dir.mkdir(parents=True, exist_ok=True)
            
            # 连接数据库
            self.connection = sqlite3.connect(self.db_path, check_same_thread=False)
            self.connection.row_factory = sqlite3.Row
            
            # 创建表结构
            self._create_tables()
            
            # 确保新增列存在（向后兼容）
            self._ensure_columns()
            
            logger.info(f"数据库初始化完成: {self.db_path}")
            
        except Exception as e:
            logger.error(f"数据库初始化失败: {e}")
            raise
    
    def _create_tables(self):
        """创建表结构"""
        table_sql = """
        -- 主表：存储所有JIRA问题
        CREATE TABLE IF NOT EXISTS jira_issues_main (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            jira_key TEXT UNIQUE NOT NULL,
            status TEXT NOT NULL DEFAULT 'Open',
            summary TEXT NOT NULL,
            normalized_summary TEXT NOT NULL,
            test_environment TEXT NOT NULL,
            raw_caused_by TEXT NOT NULL,
            assignee TEXT,
            bug_severity TEXT NOT NULL DEFAULT 'Trivial',
            priority TEXT NOT NULL DEFAULT 'Medium',
            description TEXT,
            resolution TEXT,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            resolved_at TIMESTAMP,
            package_name TEXT NOT NULL,
            exp_class TEXT,
            exp_type TEXT,
            cur_process TEXT,
            version TEXT,
            count INTEGER DEFAULT 0,
            device_count INTEGER DEFAULT 0,
            source_file TEXT,
            raw_data TEXT,
            fix_version TEXT,
            build_version TEXT,
            regression_pass_count INTEGER DEFAULT 0,
            verified_versions TEXT
        );
        
        -- 临时表：存储待处理的新问题
        CREATE TABLE IF NOT EXISTS pending_issues (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            action TEXT NOT NULL,
            similarity_score REAL,
            match_type TEXT,
            matched_jira_key TEXT,
            package_name TEXT NOT NULL,
            module TEXT,
            affect_project TEXT,
            key_information TEXT,
            exp_class TEXT,
            exp_type TEXT,
            cur_process TEXT,
            version TEXT,
            detail TEXT NOT NULL,
            caused_by TEXT NOT NULL,
            count INTEGER DEFAULT 0,
            device_count INTEGER DEFAULT 0,
            normalized_summary TEXT NOT NULL,
            test_environment TEXT NOT NULL,
            bug_severity TEXT NOT NULL,
            priority TEXT DEFAULT 'Medium',
            assignee TEXT,
            jira_summary TEXT,
            jira_description TEXT,
            ps TEXT,
            processed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            source_file TEXT,
            row_number INTEGER,
            raw_data TEXT
        );
        
        -- 配置表：存储系统配置
        CREATE TABLE IF NOT EXISTS system_config (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            config_key TEXT UNIQUE NOT NULL,
            config_value TEXT NOT NULL,
            config_type TEXT NOT NULL DEFAULT 'string',
            description TEXT,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );

        -- 版本表：记录本次构建涉及到的版本
        CREATE TABLE IF NOT EXISTS jira_versions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT UNIQUE NOT NULL,
            project_key TEXT,
            affect_project TEXT,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );

        -- 回归表：记录每个问题的回归轮次
        CREATE TABLE IF NOT EXISTS issue_regressions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            jira_key TEXT NOT NULL,
            version TEXT NOT NULL,
            status TEXT NOT NULL,
            tester TEXT,
            cycle INTEGER DEFAULT 1,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );
        
        -- 日志表：存储操作日志
        CREATE TABLE IF NOT EXISTS operation_logs (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            operation_type TEXT NOT NULL,
            operation_details TEXT,
            status TEXT NOT NULL,
            error_message TEXT,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            created_by TEXT,
            execution_time_ms INTEGER,
            metadata TEXT
        );
        """
        
        try:
            cursor = self.connection.cursor()
            cursor.executescript(table_sql)
            self.connection.commit()
            logger.info("表创建完成")
            
            # 创建索引
            index_statements = [
                "CREATE INDEX IF NOT EXISTS idx_status ON jira_issues_main (status)",
                "CREATE INDEX IF NOT EXISTS idx_package_name ON jira_issues_main (package_name)",
                "CREATE INDEX IF NOT EXISTS idx_assignee ON jira_issues_main (assignee)",
                "CREATE INDEX IF NOT EXISTS idx_bug_severity ON jira_issues_main (bug_severity)",
                "CREATE INDEX IF NOT EXISTS idx_created_at ON jira_issues_main (created_at)",
                "CREATE INDEX IF NOT EXISTS idx_pending_action ON pending_issues (action)",
                "CREATE INDEX IF NOT EXISTS idx_pending_package ON pending_issues (package_name)",
                "CREATE INDEX IF NOT EXISTS idx_pending_similarity ON pending_issues (similarity_score)"
            ]
            
            for sql in index_statements:
                try:
                    cursor.execute(sql)
                    logger.info(f"索引创建成功: {sql.split()[-1]}")
                except Exception as e:
                    logger.warning(f"索引创建失败: {e}")
            
            self.connection.commit()
            logger.info("索引创建完成")
            
        except Exception as e:
            logger.error(f"表创建失败: {e}")
            raise
        
        self._insert_default_config()
    
    def _ensure_columns(self):
        """确保新增列存在（向后兼容旧数据库）"""
        columns_to_ensure = [
            ("pending_issues", "module", "TEXT"),
            ("pending_issues", "affect_project", "TEXT"),
            ("pending_issues", "key_information", "TEXT"),
            ("pending_issues", "priority", "TEXT"),
            ("pending_issues", "ps", "TEXT"),
            ("jira_issues_main", "fix_version", "TEXT"),
            ("jira_issues_main", "build_version", "TEXT"),
            ("jira_issues_main", "resolution", "TEXT"),
            ("jira_issues_main", "regression_pass_count", "INTEGER DEFAULT 0"),
            ("jira_issues_main", "verified_versions", "TEXT"),
            ("jira_versions", "affect_project", "TEXT"),
        ]
        
        for table, column, col_type in columns_to_ensure:
            self.ensure_column(table, column, col_type)
    
    def _insert_default_config(self):
        """插入默认配置"""
        default_configs = [
            ('env_threshold', '0.99', 'number', '测试环境相似度阈值'),
            ('cause_threshold', '0.90', 'number', '根原因相似度阈值'),
            ('summary_threshold', '0.85', 'number', '概要相似度阈值'),
            ('auto_assign_enabled', 'true', 'boolean', '是否自动分配经办人'),
            ('max_retry_count', '3', 'number', '最大重试次数'),
            ('batch_size', '100', 'number', '批量处理大小')
        ]
        
        for key, value, config_type, description in default_configs:
            try:
                self.execute(
                    "INSERT OR IGNORE INTO system_config (config_key, config_value, config_type, description) VALUES (?, ?, ?, ?)",
                    (key, value, config_type, description)
                )
            except Exception as e:
                logger.warning(f"插入默认配置失败: {key}, {e}")
    
    def execute(self, query: str, params: tuple = None) -> Any:
        """
        执行SQL查询
        
        Args:
            query: SQL查询语句
            params: 查询参数
            
        Returns:
            SELECT/PRAGMA 返回结果列表，其他返回 lastrowid
        """
        try:
            cursor = self.connection.cursor()
            if params:
                cursor.execute(query, params)
            else:
                cursor.execute(query)
            
            self.connection.commit()
            
            normalized = query.strip().upper()
            if normalized.startswith('SELECT') or normalized.startswith('PRAGMA'):
                return cursor.fetchall()
            else:
                return cursor.lastrowid
                
        except Exception as e:
            self.connection.rollback()
            logger.error(f"SQL执行失败: {query}, {e}")
            raise
    
    def execute_many(self, query: str, params_list: List[tuple]):
        """
        批量执行SQL
        
        Args:
            query: SQL查询语句
            params_list: 参数列表
        """
        try:
            cursor = self.connection.cursor()
            cursor.executemany(query, params_list)
            self.connection.commit()
            logger.info(f"批量执行完成，影响 {cursor.rowcount} 行")
            
        except Exception as e:
            self.connection.rollback()
            logger.error(f"批量执行失败: {e}")
            raise

    def begin_transaction(self):
        """开始事务"""
        self.connection.execute("BEGIN TRANSACTION")
    
    def commit_transaction(self):
        """提交事务"""
        self.connection.commit()
    
    def rollback_transaction(self):
        """回滚事务"""
        self.connection.rollback()
    
    class TransactionContext:
        """事务上下文管理器"""
        
        def __init__(self, db: "DatabaseManager"):
            self.db = db
        
        def __enter__(self):
            self.db.begin_transaction()
            return self
        
        def __exit__(self, exc_type, exc_val, exc_tb):
            if exc_type is not None:
                self.db.rollback_transaction()
                return False
            self.db.commit_transaction()
            return True
    
    def transaction(self) -> "DatabaseManager.TransactionContext":
        """
        获取事务上下文管理器
        
        用法:
            with db.transaction():
                db.execute(...)
                db.execute(...)
        """
        return self.TransactionContext(self)

    def ensure_column(self, table_name: str, column_name: str, column_type: str) -> bool:
        """
        幂等式新增列，避免重复 ALTER TABLE 产生的警告
        
        Args:
            table_name: 表名
            column_name: 列名
            column_type: 列类型
            
        Returns:
            是否执行了新增操作
        """
        try:
            cursor = self.connection.cursor()
            cursor.execute(f"PRAGMA table_info({table_name})")
            existing = {row[1] for row in cursor.fetchall()}
            
            if column_name in existing:
                return False
            
            cursor.execute(f"ALTER TABLE {table_name} ADD COLUMN {column_name} {column_type}")
            self.connection.commit()
            logger.info(f"添加列成功: {table_name}.{column_name}")
            return True
            
        except Exception as e:
            self.connection.rollback()
            logger.error(f"添加列失败 {table_name}.{column_name}: {e}")
            raise


    # ------------------------------------------------------------------
    # 问题操作
    # ------------------------------------------------------------------
    
    def insert_issue(self, issue_data: Dict[str, Any]) -> int:
        """
        插入JIRA问题
        
        Args:
            issue_data: 问题数据
            
        Returns:
            插入的ID
        """
        fields = [
            'jira_key', 'status', 'summary', 'normalized_summary', 'test_environment',
            'raw_caused_by', 'assignee', 'bug_severity', 'priority', 'description',
            'resolution', 'package_name', 'exp_class', 'exp_type', 'cur_process', 'version',
            'count', 'device_count', 'source_file', 'raw_data', 'fix_version', 'build_version',
            'regression_pass_count', 'verified_versions'
        ]
        
        values = []
        for field in fields:
            value = issue_data.get(field)
            if field == 'raw_data' and isinstance(value, dict):
                value = json.dumps(value)
            if field == 'verified_versions' and isinstance(value, list):
                value = json.dumps(value)
            values.append(value)
        
        placeholders = ', '.join(['?'] * len(fields))
        query = f"INSERT INTO jira_issues_main ({', '.join(fields)}) VALUES ({placeholders})"
        
        return self.execute(query, tuple(values))
    
    def get_issue_by_key(self, jira_key: str) -> Optional[Dict[str, Any]]:
        """
        根据JIRA键获取问题
        
        Args:
            jira_key: JIRA问题键
            
        Returns:
            问题数据，如果不存在返回None
        """
        result = self.execute("SELECT * FROM jira_issues_main WHERE jira_key = ?", (jira_key,))
        
        if result and len(result) > 0:
            return dict(result[0])
        return None
    
    def update_main_table_record(self, jira_key: str, update_data: Dict[str, Any]) -> bool:
        """
        更新主表记录
        
        Args:
            jira_key: JIRA问题键
            update_data: 更新数据
            
        Returns:
            更新是否成功
        """
        set_clauses = []
        params = []
        
        for key, value in update_data.items():
            if key == 'jira_key':
                continue
            if key == 'raw_data' and isinstance(value, dict):
                value = json.dumps(value)
            if key == 'verified_versions' and isinstance(value, (dict, list)):
                value = json.dumps(value)
            set_clauses.append(f"{key} = ?")
            params.append(value)
        
        if not set_clauses:
            return True
        
        query = f"UPDATE jira_issues_main SET {', '.join(set_clauses)}, updated_at = CURRENT_TIMESTAMP WHERE jira_key = ?"
        params.append(jira_key)
        
        self.execute(query, tuple(params))
        return True
    
    def fetch_issues_by_package(self, package_name: str) -> List[Dict[str, Any]]:
        """根据包名获取问题列表"""
        query = """
            SELECT jira_key, summary, normalized_summary, test_environment,
                   raw_caused_by, status, bug_severity, package_name, version
            FROM jira_issues_main WHERE package_name = ?
        """
        rows = self.execute(query, (package_name,))
        return [dict(row) for row in rows] if rows else []

    def batch_fetch_issues_by_packages(self, packages: List[str]) -> Dict[str, List[Dict[str, Any]]]:
        """批量根据包名获取问题列表"""
        if not packages:
            return {}
        
        placeholders = ', '.join(['?'] * len(packages))
        query = f"""
            SELECT jira_key, summary, normalized_summary, test_environment,
                   raw_caused_by, status, bug_severity, package_name, version
            FROM jira_issues_main WHERE package_name IN ({placeholders})
        """
        rows = self.execute(query, tuple(packages))
        
        result: Dict[str, List[Dict[str, Any]]] = {pkg: [] for pkg in packages}
        if rows:
            for row in rows:
                row_dict = dict(row)
                pkg = row_dict.get("package_name")
                if pkg in result:
                    result[pkg].append(row_dict)
        
        return result

    # ------------------------------------------------------------------
    # 待处理问题操作
    # ------------------------------------------------------------------
    
    def insert_pending_issue(self, pending_data: Dict[str, Any]) -> int:
        """插入待处理问题"""
        fields = [
            'action', 'similarity_score', 'match_type', 'matched_jira_key',
            'package_name', 'module', 'affect_project', 'key_information',
            'exp_class', 'exp_type', 'cur_process', 'version',
            'detail', 'caused_by', 'count', 'device_count', 'normalized_summary',
            'test_environment', 'bug_severity', 'priority', 'assignee', 'jira_summary',
            'jira_description', 'ps', 'source_file', 'row_number', 'raw_data'
        ]
        
        values = []
        for field in fields:
            value = pending_data.get(field)
            if field == 'raw_data' and isinstance(value, dict):
                value = json.dumps(value)
            elif field == 'raw_data' and value is not None:
                value = str(value)
            values.append(value)
        
        placeholders = ', '.join(['?'] * len(fields))
        query = f"INSERT INTO pending_issues ({', '.join(fields)}) VALUES ({placeholders})"
        
        return self.execute(query, tuple(values))

    def delete_pending_issue(self, issue_id: int) -> None:
        """删除已处理的待处理问题"""
        self.execute("DELETE FROM pending_issues WHERE id = ?", (issue_id,))

    def get_pending_issues(self, limit: int = None) -> List[Dict[str, Any]]:
        """获取待处理问题列表"""
        query = "SELECT * FROM pending_issues ORDER BY processed_at ASC"
        if limit:
            query += f" LIMIT {limit}"
        
        result = self.execute(query)
        if not result:
            return []
        
        issues = []
        for row in result:
            issue_dict = dict(row)
            if issue_dict.get('raw_data'):
                try:
                    issue_dict['raw_data'] = json.loads(issue_dict['raw_data'])
                except (json.JSONDecodeError, TypeError):
                    pass
            issues.append(issue_dict)
        
        logger.info(f"获取到 {len(issues)} 个待处理问题")
        return issues

    # ------------------------------------------------------------------
    # 版本和回归操作
    # ------------------------------------------------------------------
    
    def ensure_version_records(self, versions: List[str], project_key: str, affect_project: Optional[str] = None) -> None:
        """批量插入版本，若已存在则忽略"""
        unique_versions = sorted({v for v in versions if v})
        if not unique_versions:
            return
        params = [(version, project_key, affect_project) for version in unique_versions]
        self.execute_many(
            "INSERT OR IGNORE INTO jira_versions (name, project_key, affect_project) VALUES (?, ?, ?)",
            params
        )

    def record_regression_result(self, jira_key: str, version: str, status: str, tester: str = "MONKEYAEE", cycle: int = 1) -> None:
        """记录回归结果"""
        self.execute(
            "INSERT INTO issue_regressions (jira_key, version, status, tester, cycle) VALUES (?, ?, ?, ?, ?)",
            (jira_key, version, status, tester, cycle)
        )

    def fetch_regression_candidates(self, statuses: Optional[List[str]] = None) -> List[Dict[str, Any]]:
        """获取回归候选问题"""
        statuses = statuses or ["Resolved", "已解决", "Verified"]
        placeholders = ', '.join(['?'] * len(statuses))
        query = f"SELECT * FROM jira_issues_main WHERE status IN ({placeholders})"
        rows = self.execute(query, tuple(statuses))
        return [dict(row) for row in rows] if rows else []

    # ------------------------------------------------------------------
    # 配置和日志操作
    # ------------------------------------------------------------------
    
    def get_config(self, key: str, default: Any = None) -> Any:
        """获取配置值"""
        result = self.execute(
            "SELECT config_value, config_type FROM system_config WHERE config_key = ?",
            (key,)
        )
        
        if result:
            row = result[0]
            value = row['config_value']
            config_type = row['config_type']
            
            if config_type == 'number':
                return float(value)
            elif config_type == 'boolean':
                return value.lower() in ['true', '1', 'yes']
            elif config_type == 'json':
                return json.loads(value)
            return value
        
        return default
    
    def log_operation(self, operation_type: str, status: str, 
                     details: str = None, error_message: str = None,
                     execution_time_ms: int = None, metadata: Dict = None):
        """记录操作日志"""
        metadata_json = json.dumps(metadata) if metadata else None
        self.execute(
            """INSERT INTO operation_logs 
            (operation_type, operation_details, status, error_message, execution_time_ms, metadata)
            VALUES (?, ?, ?, ?, ?, ?)""",
            (operation_type, details, status, error_message, execution_time_ms, metadata_json)
        )

    # ------------------------------------------------------------------
    # 统计和关闭
    # ------------------------------------------------------------------
    
    def get_main_table_count(self) -> int:
        """获取主表记录数量"""
        result = self.execute("SELECT COUNT(*) FROM jira_issues_main")
        return result[0][0] if result else 0
    
    def get_pending_table_count(self) -> int:
        """获取待处理表记录数量"""
        result = self.execute("SELECT COUNT(*) FROM pending_issues")
        return result[0][0] if result else 0
    
    def close(self):
        """关闭数据库连接"""
        if self.connection:
            self.connection.close()
            self.connection = None
            logger.info("数据库连接已关闭")
    
    def __enter__(self):
        return self
    
    def __exit__(self, exc_type, exc_val, exc_tb):
        self.close()
