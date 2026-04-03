from __future__ import annotations

from .models import ProjectInfo, SpecialtyConfig, SpecialtyExecution


CHINESE_NUMERALS = {
    0: "零",
    1: "一",
    2: "二",
    3: "三",
    4: "四",
    5: "五",
    6: "六",
    7: "七",
    8: "八",
    9: "九",
    10: "十",
}


def chinese_round_text(round_no: int) -> str:
    if round_no <= 10:
        return f"第{CHINESE_NUMERALS[round_no]}轮"
    if round_no < 20:
        return f"第十{CHINESE_NUMERALS[round_no - 10]}轮"
    if round_no == 20:
        return "第二十轮"
    return f"第{round_no}轮"


def numeric_round_text(round_no: int) -> str:
    return f"第{round_no}轮"


def build_exact_report_title(project: ProjectInfo, specialty: SpecialtyExecution, config: SpecialtyConfig) -> str:
    round_text = chinese_round_text(specialty.round_no)
    prefix = f"{project.project_name}-"
    version = project.software_version[len(prefix):] if project.software_version.startswith(prefix) else project.software_version
    base = f"{project.project_name}项目{project.project_stage}阶段{version}版本"

    if specialty.specialty_code == "stress":
        return f"{base}稳定性专项内存泄露（Stress）{round_text}测试报告"
    if specialty.specialty_code == "online_ui_adb_monkey":
        return f"{base}联机UI+ADB重启+恢复出厂开关机专项{round_text}测试报告"
    if specialty.specialty_code == "monkey2":
        return f"{base}({round_text})monkey专项测试报告"
    return f"{base}{config.display_name}专项{round_text}测试报告"


def build_summary_title(project: ProjectInfo, specialty: SpecialtyExecution, config: SpecialtyConfig) -> str:
    if specialty.specialty_code == "stress":
        return f"{project.project_name}项目{project.project_stage}阶段稳定性Stress测试报告【{specialty.test_result.upper()}】"
    return build_exact_report_title(project, specialty, config)
