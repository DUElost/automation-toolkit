# Motorola edart JIRA 批量创建工具使用说明

## 概述

本工具集用于在Motorola edart JIRA系统中批量创建问题，支持EKLAMUC项目。基于获取的项目元数据生成Excel模板，并提供批量创建功能。

## 工具组件

### 1. 元数据分析工具
- **文件**: `test_jira_motorola_edart.py`
- **功能**: 连接到 JIRA 并获取项目元数据
- **用途**: 获取项目字段信息，生成模板所需数据

### 2. Excel模板生成工具
- **文件**: `generate_motorola_excel_template.py`
- **功能**: 基于项目元数据生成 Excel 模板
- **输出**: 包含多个工作表的 Excel 文件

### 3. 批量创建工具
- **文件**: `test_excel_to_jira_motorola_edart_batch_create.py`
- **功能**: 读取 Excel 文件并批量创建 JIRA 问题
- **支持**: 自定义字段、组件、版本等

### 4. 上传清单生成工具
- **文件**: `test_excel_to_jira_upload_list_moto.py`
- **功能**: 从原始 Monkey 结果 Excel 生成 Motorola 上传清单

## 使用步骤

### 第一步：获取项目元数据（如需要重新获取）

```bash
cd Moto_Jira_Tool_20251201
python test_jira_motorola_edart.py
```

这将生成以下文件：
- `motorola_project_info.json`: 项目基本信息
- `motorola_createmeta.json`: 字段元数据

### 第二步：生成Excel模板

```bash
python generate_motorola_excel_template.py
```

生成的Excel文件包含：
- **Issue Template**: 问题创建模板
- **Field Descriptions**: 字段说明
- **Components**: 可用组件列表
- **Versions**: 可用版本列表

### 第三步：填写Excel模板

#### 必填字段：
- **Project**: 项目Key，固定为 `EKLAMUC`
- **Issue Type**: 问题类型，通常选择 `故障`
- **Summary**: 问题的简短描述
- **Versions**: 影响版本，必填字段

#### 可选字段：
- **Description**: 问题的详细描述
- **Priority**: 优先级（1-5 或 紧急/高/重要/低/微小）
- **Assignee**: 经办人用户名
- **Components**: 影响组件，多个组件用逗号分隔
- **Severity**: 严重程度（自定义字段）
- **Team Found**: 发现团队（自定义字段）
- **Product Affected**: 受影响产品（自定义字段）

### 第四步：批量创建问题

```bash
# 测试运行（不实际创建问题）
python test_excel_to_jira_motorola_edart_batch_create.py --dry-run --add-excel-file "模板文件.xlsx" --set-jira-token "<TOKEN>"

# 正式创建问题
python test_excel_to_jira_motorola_edart_batch_create.py --add-excel-file "填写好的文件.xlsx" --set-jira-token "<TOKEN>"
```

## 项目信息

### 基本信息
- **项目名称**: Lamu26
- **项目Key**: EKLAMUC
- **JIRA服务器**: https://edart.motorola.com
- **JIRA版本**: 8.20.19

### 可用问题类型
- 故障（Bug）- ID: 10300
- 任务 - ID: 3
- 子任务 - ID: 10
- 故事 - ID: 22
- Epic - ID: 21
- Check List - ID: 10700
- Approval Request - ID: 11001
- Build Signing - ID: 11

### 主要组件（部分）
- Camera app
- Camera driver
- Camera tuning
- SW_APP_Launcher
- SW_APP_Settings
- SW_APP_SystemUI
- SW_BSP_BT
- SW_BSP_WIFI
- SW_Modem
- SW_Performance
- 等80+个组件

### 版本信息
- 当前版本：VVTB35.1 到 VVTB35.18
- 特殊版本：n/a（用于未指定版本的情况）

## 必填字段详情

### 故障类型必填字段：
1. **概要（summary）**: 问题的简短描述
2. **影响版本（versions）**: 问题影响的版本
3. **Severity**: 严重程度（customfield_10017）
4. **Team Found**: 发现团队（customfield_10198）
5. **Product Affected**: 受影响产品（customfield_11016）

## 认证方式

使用Personal Access Token进行认证：
- Token已配置在脚本中
- 具有创建问题的权限
- 支持所有读取操作

## 错误处理

### 常见错误及解决方案：

1. **连接失败**
   - 检查网络连接
   - 验证Token有效性
   - 确认服务器地址正确

2. **字段验证失败**
   - 确保必填字段都已填写
   - 检查组件和版本名称的正确性
   - 验证用户名是否存在

3. **权限不足**
   - 确认Token具有创建问题权限
   - 检查项目访问权限

## 输出文件

### 批量创建结果
创建完成后会生成结果文件：
- 文件名格式：`jira_motorola_edart_batch_create_result_YYYYMMDD_HHMMSS.txt`
- 包含：成功/失败统计、详细结果、问题链接

### Excel模板文件
- 文件名格式：`jira_motorola_edart_template_YYYYMMDD_HHMMSS.xlsx`
- 包含4个工作表，提供完整的字段指导

## 最佳实践

1. **测试先行**: 使用 `--dry-run` 参数验证数据
2. **批量控制**: 建议单次创建不超过50个问题
3. **数据验证**: 确保组件、版本名称准确
4. **结果检查**: 仔细查看创建结果中的错误信息
5. **备份保存**: 保留Excel文件和结果文件作为记录

## 技术支持

如遇到问题，请检查：
1. JIRA服务器连接状态
2. Token权限是否正确
3. Excel文件格式是否符合要求
4. 必填字段是否都已填写

---
*本工具基于Motorola edart JIRA EKLAMUC项目的实际元数据开发，确保与系统完全兼容。*