#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
获取新cookies的解决方案
"""

print("""
=== 获取新的JIRA Cookies ===

由于提供的cookies已经过期，我们需要获取新的有效cookies。

步骤说明:

1. **在浏览器中重新登录**
   - 打开浏览器，访问: https://jira.tinno.com
   - 使用您的凭据登录 (dai.lv / l.74926520)
   - 确认登录成功

2. **获取新的cookies**
   - 登录成功后，按F12打开开发者工具
   - 切换到 "Application" 或 "Storage" 标签页
   - 在左侧菜单中找到 "Cookies" -> "https://jira.tinno.com"
   - 复制以下cookies的值:
     * JSESSIONID
     * atlassian.xsrf.token  
     * seraph.remermeme.cookie
     * 其他认证相关的cookies

3. **更新cookies**
   - 获取到新的cookies后，可以运行批量创建脚本

快速验证方法:

在浏览器中访问以下URL，确认能返回JSON数据:
https://jira.tinno.com/rest/api/2/myself

如果返回JSON数据，说明cookies有效。

批量创建脚本使用方法:

1. 使用交互式脚本:
   python jira_batch_create_session.py JIRA_Upload_List_20250911_225735.xlsx

2. 使用命令行参数:
   python jira_batch_create_session.py JIRA_Upload_List_20250911_225735.xlsx --cookies "JSESSIONID=new_value; atlassian.xsrf.token=new_token; ..."

已准备的工具:

- jira_batch_create_session.py: 支持cookies认证的批量创建脚本
- jira_batch_create_browser_auth.py: 浏览器会话认证脚本
- test_and_batch_create.py: 测试和批量创建脚本

重要提示:

- cookies通常有时间限制，可能需要定期更新
- 确保在cookies有效期内完成批量创建操作
- 如果操作过程中cookies过期，需要重新获取

请按上述步骤获取新的cookies，然后就可以继续进行批量创建了。
""")

# 显示可用的Excel文件
import os
import glob

excel_files = glob.glob("*.xlsx") + glob.glob("*.xls")
if excel_files:
    print("\n可用的Excel文件:")
    for i, file in enumerate(excel_files, 1):
        print(f"{i}. {file}")
    
    print("\n建议使用最新的文件:")
    latest_file = max(excel_files, key=os.path.getctime)
    print(f"最新文件: {latest_file}")
else:
    print("\n未找到Excel文件")