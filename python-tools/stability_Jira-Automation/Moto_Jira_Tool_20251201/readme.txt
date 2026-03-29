1、Motorola edart JIRA 批量问题创建工具
usage: 
create_moto_jira_batch_from_excel.exe 
						--add-excel-file EXCEL_FILE
						--set-jira-token JIRA_TOKEN
						--add-comments

optional arguments:
  --add-excel-file EXCEL_FILE
                        Excel文件路径（必填，执行创建时需要）
  --set-jira-token JIRA_TOKEN
                        JIRA Personal Access Token（必填）
  --add-comments        
			创建完成后添加PS列内容作为评论
例如：
create_moto_jira_batch_from_excel.exe --add-excel-file JIRA_Upload_List_Moto_Reboot_20251121_180241.xlsx --set-jira-token <your_jira_token> --add-comments


2、生成Motorola JIRA问题上传清单
usage: 
generate_moto_jira_upload_list.exe 
						-add-main-excel MAIN_EXCEL_PATH
						--set-test-case TEST_CASE

optional arguments:
  --add-main-excel MAIN_EXCEL_PATH
                        指定主结果Excel路径
  --set-test-case TEST_CASE
                        指定测试项名称（默认: Monkey）
例如：
generate_moto_jira_upload_list.exe -add-main-excel F:/Jira_test_1105_rin/config/Result_None_None_MonkeyAEE_SH_20251117.xls --set-test-case Reboot


更新日志：
Moto_Jira_Tool_20251201版本
1、create_moto_jira_batch_from_excel_V1.1.exe
- 为批量创建脚本新增 Severity 规范化，自动将 Block/1 等映射为合法选项，默认回退 Major。
- 拉取项目版本列表并校验 Excel 版本，未知版本告警并回退 n/a，避免因不存在的版本导致 400。
- JIRA 异常日志增强，打印响应文本/JSON，即使 e.text 为空也能看见具体错误。
2、问题等级定级表.xls
- 新增System API Dump异常类型

