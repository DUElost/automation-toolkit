#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
JIRA Bug比对脚本 - 最终版本
比对两个Excel文件中的Bug数据，找出相同的Bug
"""

import pandas as pd
import re
from difflib import SequenceMatcher
import logging
from datetime import datetime
import os

# 配置日志
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.StreamHandler()
    ]
)
logger = logging.getLogger(__name__)

class JiraBugComparator:
    def __init__(self):
        # 调整阈值，使其更符合实际需求
        self.summary_threshold = 0.99  # Summary保持99%
        self.environment_threshold = 0.99  # Environment保持99%
        self.key_info_threshold = 0.90  # Key Information保持90%
    
    def extract_bug_pattern(self, text):
        """提取Bug的核心模式，用于更精确的匹配"""
        if pd.isna(text) or text is None:
            return ""
        
        text = str(text)
        
        # 提取关键信息模式
        patterns = {
            'automation': r'\[自动化\]',
            'version': r'\[V\d+[A-Z]*\]',
            'total_number': r'\[Total Number \d+\]',
            'build_info': r'\[[A-Z0-9\-]+\]',
            'monkey': r'\[MonkeyAEE\]',
            'error_type': r'(Fatal NE|ANR|崩溃|crash)',
            'component': r'(system_server|launcher|android)',
        }
        
        extracted = []
        for key, pattern in patterns.items():
            matches = re.findall(pattern, text, re.IGNORECASE)
            if matches:
                if key in ['version', 'total_number', 'build_info']:
                    # 对于版本、数量、构建信息，标准化处理
                    extracted.append(f'[{key}]')
                else:
                    extracted.extend(matches)
        
        return ' '.join(extracted)
    
    def clean_text_advanced(self, text):
        """高级文本清理策略"""
        if pd.isna(text) or text is None:
            return ""
        
        text = str(text)
        
        # 标准化常见的Bug类型
        text = re.sub(r'Fatal\s*NE', 'FatalNE', text, flags=re.IGNORECASE)
        text = re.sub(r'ANR', 'ANR', text, flags=re.IGNORECASE)
        
        # 移除具体的版本号和日期，但保留格式
        text = re.sub(r'V\d+[A-Z]*', 'V', text)
        text = re.sub(r'Total Number \d+', 'Total Number', text)
        text = re.sub(r'\d{6}V\d+', 'V', text)
        text = re.sub(r'\d{2}-\d{6}', '', text)
        
        # 移除其他数字
        text = re.sub(r'\d+', '', text)
        
        # 标准化空格
        text = re.sub(r'\s+', ' ', text).strip()
        
        return text
    
    def calculate_similarity(self, text1, text2):
        """计算两个文本的相似度"""
        if not text1 and not text2:
            return 1.0
        if not text1 or not text2:
            return 0.0
        
        return SequenceMatcher(None, text1.lower(), text2.lower()).ratio()
    
    def load_excel_data(self, file_path):
        """加载Excel数据"""
        try:
            logger.info(f"正在加载数据: {file_path}")
            df = pd.read_excel(file_path)
            logger.info(f"数据加载完成，共 {len(df)} 条记录")
            return df
        except Exception as e:
            logger.error(f"加载Excel文件失败: {e}")
            return None
    
    def find_matching_bugs(self, jira_df, upload_df):
        """查找匹配的Bug"""
        matches = []
        potential_matches = []  # 存储潜在匹配（相似度较高但未达到阈值）
        
        # 确定列名映射
        jira_summary_col = 'Summary'
        jira_env_col = 'Environment' 
        jira_key_col = 'key_information'
        
        upload_summary_col = 'Summary'
        upload_env_col = 'Environment'
        upload_key_col = 'key_information'
        
        logger.info("开始查找匹配的Bug...")
        
        for upload_idx, upload_row in upload_df.iterrows():
            logger.info(f"处理进度: {upload_idx + 1}/{len(upload_df)}")
            
            upload_summary = upload_row[upload_summary_col]
            upload_env = upload_row[upload_env_col]
            upload_key = upload_row[upload_key_col]
            
            # 清理上传数据的文本
            upload_summary_clean = self.clean_text_advanced(upload_summary)
            upload_env_clean = self.clean_text_advanced(upload_env)
            upload_key_clean = self.clean_text_advanced(upload_key)
            
            # 提取Bug模式
            upload_pattern = self.extract_bug_pattern(upload_summary)
            
            logger.info(f"\n上传数据 {upload_idx}:")
            logger.info(f"  原始Summary: {upload_summary}")
            logger.info(f"  清理后Summary: {upload_summary_clean}")
            logger.info(f"  Bug模式: {upload_pattern}")
            
            best_match = None
            best_summary_similarity = 0
            best_potential_match = None
            best_potential_similarity = 0
            
            for jira_idx, jira_row in jira_df.iterrows():
                jira_summary = jira_row[jira_summary_col]
                jira_env = jira_row[jira_env_col]
                jira_key = jira_row[jira_key_col]
                
                # 清理JIRA数据的文本
                jira_summary_clean = self.clean_text_advanced(jira_summary)
                jira_env_clean = self.clean_text_advanced(jira_env)
                jira_key_clean = self.clean_text_advanced(jira_key)
                
                # 提取Bug模式
                jira_pattern = self.extract_bug_pattern(jira_summary)
                
                # 计算Summary相似度
                summary_similarity = self.calculate_similarity(upload_summary_clean, jira_summary_clean)
                pattern_similarity = self.calculate_similarity(upload_pattern, jira_pattern)
                
                # 综合相似度（给模式匹配更高权重）
                combined_similarity = (summary_similarity * 0.7 + pattern_similarity * 0.3)
                
                if summary_similarity > 0.5 or pattern_similarity > 0.5:  # 显示有潜力的匹配
                    logger.info(f"\n  与JIRA数据 {jira_idx} 比对:")
                    logger.info(f"    JIRA Summary: {jira_summary}")
                    logger.info(f"    清理后: {jira_summary_clean}")
                    logger.info(f"    JIRA模式: {jira_pattern}")
                    logger.info(f"    Summary相似度: {summary_similarity:.4f}")
                    logger.info(f"    模式相似度: {pattern_similarity:.4f}")
                    logger.info(f"    综合相似度: {combined_similarity:.4f}")
                
                # 记录潜在匹配
                if combined_similarity > best_potential_similarity:
                    best_potential_similarity = combined_similarity
                    best_potential_match = {
                        'upload_index': upload_idx,
                        'jira_index': jira_idx,
                        'upload_summary': upload_summary,
                        'jira_summary': jira_summary,
                        'summary_similarity': summary_similarity,
                        'pattern_similarity': pattern_similarity,
                        'combined_similarity': combined_similarity,
                        'upload_data': upload_row.to_dict(),
                        'jira_data': jira_row.to_dict()
                    }
                
                if summary_similarity > self.summary_threshold:
                    # Summary匹配，继续比对Environment和Key Information
                    env_similarity = self.calculate_similarity(upload_env_clean, jira_env_clean)
                    key_similarity = self.calculate_similarity(upload_key_clean, jira_key_clean)
                    
                    logger.info(f"    Environment相似度: {env_similarity:.4f}")
                    logger.info(f"    Key Info相似度: {key_similarity:.4f}")
                    
                    if (env_similarity > self.environment_threshold and 
                        key_similarity > self.key_info_threshold):
                        
                        if summary_similarity > best_summary_similarity:
                            best_match = {
                                'upload_index': upload_idx,
                                'jira_index': jira_idx,
                                'upload_summary': upload_summary,
                                'jira_summary': jira_summary,
                                'summary_similarity': summary_similarity,
                                'environment_similarity': env_similarity,
                                'key_info_similarity': key_similarity,
                                'upload_data': upload_row.to_dict(),
                                'jira_data': jira_row.to_dict()
                            }
                            best_summary_similarity = summary_similarity
                            logger.info(f"    *** 找到匹配的Bug! ***")
            
            if best_match:
                matches.append(best_match)
                logger.info(f"\n找到匹配: 上传数据{upload_idx} <-> JIRA数据{best_match['jira_index']}")
            elif best_potential_match:
                potential_matches.append(best_potential_match)
                logger.info(f"\n找到潜在匹配: 上传数据{upload_idx} <-> JIRA数据{best_potential_match['jira_index']} (相似度: {best_potential_similarity:.4f})")
        
        return matches, potential_matches
    
    def save_results(self, matches, potential_matches, output_file):
        """保存比对结果到Excel文件"""
        # 使用ExcelWriter保存多个sheet
        with pd.ExcelWriter(output_file, engine='openpyxl') as writer:
            
            if matches:
                # 保存确定匹配的结果
                results = []
                for match in matches:
                    result = {
                        '上传数据索引': match['upload_index'],
                        'JIRA数据索引': match['jira_index'],
                        '上传Summary': match['upload_summary'],
                        'JIRA Summary': match['jira_summary'],
                        'Summary相似度': f"{match['summary_similarity']:.4f}",
                        'Environment相似度': f"{match['environment_similarity']:.4f}",
                        'Key Info相似度': f"{match['key_info_similarity']:.4f}",
                        '匹配状态': '确定匹配'
                    }
                    results.append(result)
                
                results_df = pd.DataFrame(results)
                results_df.to_excel(writer, sheet_name='确定匹配', index=False)
                logger.info(f"共找到 {len(matches)} 个确定匹配的Bug")
            
            if potential_matches:
                # 保存潜在匹配的结果
                potential_results = []
                for match in potential_matches:
                    result = {
                        '上传数据索引': match['upload_index'],
                        'JIRA数据索引': match['jira_index'],
                        '上传Summary': match['upload_summary'],
                        'JIRA Summary': match['jira_summary'],
                        'Summary相似度': f"{match['summary_similarity']:.4f}",
                        '模式相似度': f"{match['pattern_similarity']:.4f}",
                        '综合相似度': f"{match['combined_similarity']:.4f}",
                        '匹配状态': '潜在匹配'
                    }
                    potential_results.append(result)
                
                potential_df = pd.DataFrame(potential_results)
                potential_df.to_excel(writer, sheet_name='潜在匹配', index=False)
                logger.info(f"共找到 {len(potential_matches)} 个潜在匹配的Bug")
            
            if not matches and not potential_matches:
                # 没有找到任何匹配
                empty_df = pd.DataFrame({
                    '匹配结果': ['没有找到匹配的Bug'],
                    '说明': ['两个文件中没有发现相同或相似的Bug']
                })
                empty_df.to_excel(writer, sheet_name='结果', index=False)
                logger.info("没有找到匹配的Bug")
        
        logger.info(f"比对结果已保存到: {output_file}")

def main():
    # 文件路径
    jira_export_file = "f:/Jira_test_0813_rin/data/Tinno_JIRA_导出清单_20250815_151335.xlsx"
    upload_file = "f:/Jira_test_0813_rin/src/modules/JIRA_Upload_List_20250814_204605.xlsx"
    
    # 输出文件
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    output_file = f"f:/Jira_test_0813_rin/Bug比对结果_{timestamp}.xlsx"
    
    # 创建比对器
    comparator = JiraBugComparator()
    
    # 加载数据
    jira_df = comparator.load_excel_data(jira_export_file)
    upload_df = comparator.load_excel_data(upload_file)
    
    if jira_df is None or upload_df is None:
        logger.error("数据加载失败，程序退出")
        return
    
    # 查找匹配的Bug
    matches, potential_matches = comparator.find_matching_bugs(jira_df, upload_df)
    
    # 保存结果
    comparator.save_results(matches, potential_matches, output_file)
    
    logger.info("Bug比对完成！")
    logger.info(f"结果文件: {output_file}")

if __name__ == "__main__":
    main()