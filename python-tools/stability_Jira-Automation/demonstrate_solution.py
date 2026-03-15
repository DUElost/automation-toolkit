#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
演示如何使用会话认证解决JIRA连接问题
"""

print("""
=== JIRA连接问题解决方案 ===

问题分析:
- JIRA服务器返回HTML错误页面而不是JSON
- 可能是认证失败、SSO要求或服务器配置问题

解决方案:
1. 使用浏览器cookies进行认证
2. 创建了 `jira_batch_create_session.py` 脚本

使用方法:

1. 在浏览器中登录 https://jira.tinno.com
2. 获取登录后的cookies:
   - 打开开发者工具 (F12)
   - 切换到 Application/Storage 标签页
   - 找到 Cookies -> https://jira.tinno.com
   - 复制JSESSIONID和其他认证cookies

3. 运行脚本:
   python jira_batch_create_session.py JIRA_Upload_List_20250911_225735.xlsx

4. 输入cookies或使用 --cookies 参数

优势:
- 绕过了直接API认证的问题
- 使用浏览器已建立的会话状态
- 适用于复杂的认证环境

文件说明:
- jira_batch_create_session.py: 主要的批量创建脚本
- jira_cookie_auth_tool.py: Cookie认证工具
- jira_session_auth.py: 会话认证测试工具

下一步:
1. 在浏览器中登录JIRA
2. 复制cookies
3. 运行脚本进行批量创建
""")

# 显示可用的Excel文件
import os
import glob

excel_files = glob.glob("*.xlsx") + glob.glob("*.xls")
if excel_files:
    print("\n可用的Excel文件:")
    for i, file in enumerate(excel_files, 1):
        print(f"{i}. {file}")
else:
    print("\n未找到Excel文件")