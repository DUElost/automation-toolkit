# Product Overview

JIRA Monkey 测试自动化系统 - 用于将 Monkey 测试报告自动化处理并同步到 JIRA 系统的工具。

## 核心功能

- **Excel 解析**: 解析 Monkey 测试报告（Excel 格式）
- **数据标准化**: 统一字段格式、包名映射、模块识别、严重等级计算
- **智能决策**: 基于相似度算法判断是创建新问题、更新现有问题还是添加评论
- **JIRA 集成**: 自动创建/更新/评论/重开 JIRA Bug 单
- **回归验证**: 自动记录已解决问题的回归 PASS 状态

## 决策场景

| 场景 | 触发条件 | 操作 |
|------|----------|------|
| CREATE | 无匹配问题 | 创建新 JIRA 问题 |
| UPDATE | 匹配到 Open/Reopened 状态 | 更新计数，添加备注 |
| COMMENT | 匹配到已解决(Won't Fix)状态 | 仅添加备注 |
| REOPEN | 匹配到已解决(完成)，版本晚于修复版本 | 重新打开问题 |
| IGNORE | 匹配到已关闭状态 | 不做操作 |
| REGRESSION_PASS | 已解决问题未被匹配 | 记录回归 PASS |

## 支持的 JIRA 系统

- Tinno JIRA (jira.tinno.com)
- Motorola JIRA (edart)
- Transsion JIRA

## 数据库

仅支持 SQLite，按 `{jira_host}_{project_key}.db` 隔离存储。
