#!/bin/bash

# PostgreSQL 设置脚本
# 用于手动安装和配置PostgreSQL数据库

set -e

echo "=== PostgreSQL 设置脚本 ==="

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 日志函数
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查是否为root用户
check_root() {
    if [[ $EUID -ne 0 ]]; then
        log_error "此脚本需要root权限运行"
        exit 1
    fi
}

# 安装PostgreSQL
install_postgresql() {
    log_info "开始安装PostgreSQL..."
    
    # 更新包列表
    apt-get update
    
    # 安装PostgreSQL和贡献包
    apt-get install -y postgresql postgresql-contrib postgresql-server-dev-all
    
    log_info "PostgreSQL安装完成"
}

# 启动PostgreSQL服务
start_postgresql() {
    log_info "启动PostgreSQL服务..."
    
    # 启用服务
    systemctl enable postgresql
    
    # 启动服务
    systemctl start postgresql
    
    # 检查服务状态
    if systemctl is-active --quiet postgresql; then
        log_info "PostgreSQL服务已启动"
    else
        log_error "PostgreSQL服务启动失败"
        exit 1
    fi
}

# 创建数据库和用户
create_database() {
    log_info "创建数据库和用户..."
    
    # 设置默认值
    DB_NAME=${DB_NAME:-"jira_automation"}
    DB_USER=${DB_USER:-"jira_user"}
    DB_PASSWORD=${DB_PASSWORD:-"jira_password"}
    
    # 创建用户
    sudo -u postgres psql -c "CREATE USER $DB_USER WITH PASSWORD '$DB_PASSWORD';"
    
    # 创建数据库
    sudo -u postgres psql -c "CREATE DATABASE $DB_NAME OWNER $DB_USER;"
    
    # 授予所有权限
    sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USER;"
    
    log_info "数据库和用户创建完成"
    log_info "数据库名: $DB_NAME"
    log_info "用户名: $DB_USER"
    log_info "密码: $DB_PASSWORD"
}

# 启用pg_trgm扩展
enable_extensions() {
    log_info "启用PostgreSQL扩展..."
    
    DB_NAME=${DB_NAME:-"jira_automation"}
    
    # 启用pg_trgm扩展
    sudo -u postgres psql -d "$DB_NAME" -c "CREATE EXTENSION IF NOT EXISTS pg_trgm;"
    
    # 验证扩展是否启用
    EXTENSION_EXISTS=$(sudo -u postgres psql -d "$DB_NAME" -t -c "SELECT 1 FROM pg_extension WHERE extname = 'pg_trgm';")
    
    if [[ $EXTENSION_EXISTS -eq 1 ]]; then
        log_info "pg_trgm扩展已启用"
    else
        log_error "pg_trgm扩展启用失败"
        exit 1
    fi
}

# 导入数据库架构
import_schema() {
    log_info "导入数据库架构..."
    
    DB_NAME=${DB_NAME:-"jira_user"}
    SCHEMA_FILE=${SCHEMA_FILE:-"src/config/schema.sql"}
    
    if [[ ! -f "$SCHEMA_FILE" ]]; then
        log_error "架构文件不存在: $SCHEMA_FILE"
        exit 1
    fi
    
    # 导入架构
    sudo -u postgres psql -d "$DB_NAME" -f "$SCHEMA_FILE"
    
    log_info "数据库架构导入完成"
}

# 验证安装
verify_installation() {
    log_info "验证PostgreSQL安装..."
    
    DB_NAME=${DB_NAME:-"jira_automation"}
    DB_USER=${DB_USER:-"jira_user"}
    
    # 测试连接
    if sudo -u postgres psql -d "$DB_NAME" -c "SELECT version();" > /dev/null 2>&1; then
        log_info "数据库连接正常"
    else
        log_error "数据库连接失败"
        exit 1
    fi
    
    # 检查表是否存在
    TABLE_COUNT=$(sudo -u postgres psql -d "$DB_NAME" -t -c "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'public';")
    log_info "数据库表数量: $TABLE_COUNT"
    
    # 检查索引是否存在
    INDEX_COUNT=$(sudo -u postgres psql -d "$DB_NAME" -t -c "SELECT COUNT(*) FROM pg_indexes WHERE schemaname = 'public';")
    log_info "数据库索引数量: $INDEX_COUNT"
    
    # 检查pg_trgm扩展
    TRGM_ENABLED=$(sudo -u postgres psql -d "$DB_NAME" -t -c "SELECT 1 FROM pg_extension WHERE extname = 'pg_trgm';")
    if [[ $TRGM_ENABLED -eq 1 ]]; then
        log_info "pg_trgm扩展已启用"
    else
        log_error "pg_trgm扩展未启用"
        exit 1
    fi
}

# 显示连接信息
show_connection_info() {
    log_info "=== 连接信息 ==="
    echo "Host: localhost"
    echo "Port: 5432"
    echo "Database: ${DB_NAME:-jira_automation}"
    echo "Username: ${DB_USER:-jira_user}"
    echo "Password: ${DB_PASSWORD:-jira_password}"
    echo ""
    echo "连接字符串:"
    echo "postgresql://${DB_USER:-jira_user}:${DB_PASSWORD:-jira_password}@localhost:5432/${DB_NAME:-jira_automation}"
}

# 主函数
main() {
    echo "选择操作:"
    echo "1. 完整安装 (安装PostgreSQL + 创建数据库 + 启用扩展)"
    echo "2. 仅创建数据库和用户"
    echo "3. 仅启用扩展"
    echo "4. 验证安装"
    echo "5. 显示连接信息"
    echo "0. 退出"
    
    read -p "请输入选项 (0-5): " choice
    
    case $choice in
        1)
            check_root
            install_postgresql
            start_postgresql
            create_database
            enable_extensions
            import_schema
            verify_installation
            show_connection_info
            ;;
        2)
            check_root
            create_database
            ;;
        3)
            check_root
            enable_extensions
            ;;
        4)
            verify_installation
            ;;
        5)
            show_connection_info
            ;;
        0)
            log_info "退出"
            exit 0
            ;;
        *)
            log_error "无效选项"
            exit 1
            ;;
    esac
}

# 如果直接运行脚本
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi