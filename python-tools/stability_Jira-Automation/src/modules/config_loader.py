import json
import logging
import os
from pathlib import Path
from typing import Any, Dict, Optional

from dotenv import load_dotenv

logger = logging.getLogger(__name__)


def _env_bool(value: Optional[str], default: bool = False) -> bool:
    if value is None:
        return default
    return value.strip().lower() in {"1", "true", "yes", "on"}


class ConfigLoader:
    """配置加载器"""
    
    def __init__(self, env_file: str = ".env"):
        """
        初始化配置加载器
        
        Args:
            env_file: 环境变量文件路径
        """
        self.env_file = env_file
        self.config = {}
        self._load_config()
    
    def _load_config(self):
        """加载配置"""
        try:
            # 加载环境变量文件
            env_path = Path(self.env_file)
            if env_path.exists():
                load_dotenv(env_path)
                logger.info(f"已加载环境变量文件: {env_path}")
            else:
                logger.warning(f"环境变量文件不存在: {env_path}，使用默认配置")
            
            # 可选：加载 monkey_config.json，提供 Jira 默认配置
            monkey_cfg_path = Path("config/monkey_config.json")
            monkey_config: Dict[str, Any] = {}
            if monkey_cfg_path.exists():
                try:
                    with open(monkey_cfg_path, "r", encoding="utf-8") as fp:
                        monkey_config = json.load(fp)
                    self.config["monkey"] = monkey_config
                    logger.info("已加载 monkey_config.json")
                except Exception as exc:  # pragma: no cover
                    logger.warning("monkey_config.json 解析失败: %s", exc)

            # 数据库配置
            self.config['database'] = {
                'host': os.getenv('DB_HOST', 'localhost'),
                'port': int(os.getenv('DB_PORT', 5432)),
                'name': os.getenv('DB_NAME', 'jira_automation'),
                'user': os.getenv('DB_USER', 'jira_user'),
                'password': os.getenv('DB_PASSWORD', ''),
            }
            
            # JIRA配置
            tinno_env = (monkey_config.get("jira_environments", {}).get("tinno", {}) if monkey_config else {})
            default_p12 = Path("src/modules/890177.p12")
            self.config['jira'] = {
                'url': os.getenv('JIRA_URL', tinno_env.get('server', '')),
                'username': os.getenv('JIRA_USERNAME', tinno_env.get('user', '')),
                'password': os.getenv('JIRA_PASSWORD', tinno_env.get('password', '')),
                'api_token': os.getenv('JIRA_API_TOKEN', ''),
                'p12_path': os.getenv('JIRA_P12_PATH', str(default_p12) if default_p12.exists() else ''),
                'p12_password': os.getenv('JIRA_P12_PASSWORD', ''),
                'project_key': os.getenv('JIRA_PROJECT_KEY', tinno_env.get('project_key', 'VCAME')),
                'issue_type': os.getenv('JIRA_ISSUE_TYPE', 'Bug'),
                'mode': os.getenv('JIRA_MODE', 'rest'),
                'verify': _env_bool(os.getenv('JIRA_VERIFY_SSL'), False),
            }
            mapping_section = (monkey_config.get("jira_field_mapping", {}).get("tinno", {}) if monkey_config else {})
            self.config['jira']['custom_fields'] = mapping_section.get('custom_fields', {})
            self.config['jira']['components_map'] = mapping_section.get('components', {})
            
            # 飞书配置
            self.config['lark'] = {
                'app_id': os.getenv('LARK_APP_ID', ''),
                'app_secret': os.getenv('LARK_APP_SECRET', ''),
                'tenant_access_token': os.getenv('LARK_TENANT_ACCESS_TOKEN', ''),
            }
            
            # 日志配置
            self.config['logging'] = {
                'level': os.getenv('LOG_LEVEL', 'INFO'),
                'file': os.getenv('LOG_FILE', 'logs/automation.log'),
            }
            
            # 判重阈值配置
            thresholds_cfg = (
                monkey_config.get("decision_rules", {}).get("similarity_thresholds", {}) if monkey_config else {}
            )
            self.config['thresholds'] = {
                'env_threshold': float(os.getenv('ENV_THRESHOLD', thresholds_cfg.get('high_confidence', 0.99))),
                'cause_threshold': float(os.getenv('CAUSE_THRESHOLD', 0.90)),
            }
            
            logger.info("配置加载完成")
            
        except Exception as e:
            logger.error(f"配置加载失败: {e}")
            raise
    
    def get(self, key: str, default: Any = None) -> Any:
        """
        获取配置值
        
        Args:
            key: 配置键（支持点号分隔，如 'database.host'）
            default: 默认值
            
        Returns:
            配置值
        """
        try:
            keys = key.split('.')
            value = self.config
            
            for k in keys:
                if isinstance(value, dict) and k in value:
                    value = value[k]
                else:
                    return default
            
            return value
            
        except Exception as e:
            logger.error(f"获取配置失败: {key}, {e}")
            return default
    
    def get_database_config(self) -> Dict[str, Any]:
        """获取数据库配置"""
        return self.get('database', {})
    
    def get_jira_config(self) -> Dict[str, Any]:
        """获取JIRA配置"""
        return self.get('jira', {})
    
    def get_lark_config(self) -> Dict[str, Any]:
        """获取飞书配置"""
        return self.get('lark', {})
    
    def get_thresholds(self) -> Dict[str, float]:
        """获取判重阈值"""
        return self.get('thresholds', {})
    
    def validate_config(self) -> bool:
        """
        验证配置是否完整
        
        Returns:
            验证结果
        """
        required_configs = [
            ('database.host', '数据库主机'),
            ('database.name', '数据库名称'),
            ('database.user', '数据库用户'),
            ('jira.url', 'JIRA地址'),
            ('jira.username', 'JIRA用户名'),
        ]
        
        missing_configs = []
        for config_key, config_name in required_configs:
            if not self.get(config_key):
                missing_configs.append(config_name)
        
        if not (self.get('jira.password') or self.get('jira.api_token')):
            missing_configs.append('JIRA密码/Token')

        if missing_configs:
            logger.error(f"缺少必需配置: {', '.join(missing_configs)}")
            return False
        
        # 验证阈值范围
        thresholds = self.get_thresholds()
        for threshold_name, threshold_value in thresholds.items():
            if not (0 <= threshold_value <= 1):
                logger.error(f"阈值 {threshold_name} 超出范围 (0-1): {threshold_value}")
                return False
        
        logger.info("配置验证通过")
        return True
    
    def reload_config(self):
        """重新加载配置"""
        logger.info("重新加载配置")
        self.config.clear()
        self._load_config()
