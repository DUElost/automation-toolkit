#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
检查Excel文件中PS列的内容
"""

import pandas as pd

def check_ps_column():
    """检查PS列内容"""
    excel_file = "jira_motorola_edart_template_20251013_001616.xlsx"

    try:
        df = pd.read_excel(excel_file, engine='openpyxl')
        print(f"Excel列名: {list(df.columns)}")

        if 'PS' in df.columns:
            print("\nPS列内容:")
            for i, ps in enumerate(df['PS']):
                if pd.notna(ps):
                    print(f"  第{i+1}行: {ps}")
                else:
                    print(f"  第{i+1}行: [空]")
        else:
            print("未找到PS列")

        return df
    except Exception as e:
        print(f"读取Excel失败: {e}")
        return None

if __name__ == "__main__":
    check_ps_column()