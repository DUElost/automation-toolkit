from __future__ import annotations

from pathlib import Path

from .models import SpecialtyConfig, TemplateProfile


COMMON_REQUIRED_FIELDS = ("round_no", "test_cycle", "test_result")


SPECIALTY_CONFIGS = {
    "mtbf": SpecialtyConfig(
        specialty_code="mtbf",
        display_name="MTBF",
        summary_sheet_name="MTBF",
        output_subdir="MTBF",
        template_relative_path=Path("stability/specialties/general_specialty.xlsx"),
        required_fields=COMMON_REQUIRED_FIELDS,
    ),
    "power_cycle": SpecialtyConfig(
        specialty_code="power_cycle",
        display_name="开关机",
        summary_sheet_name="开关机",
        output_subdir="压力测试/开关机",
        template_relative_path=Path("stability/specialties/general_specialty.xlsx"),
        required_fields=COMMON_REQUIRED_FIELDS,
    ),
    "sleep_wakeup": SpecialtyConfig(
        specialty_code="sleep_wakeup",
        display_name="休眠唤醒",
        summary_sheet_name="休眠唤醒",
        output_subdir="压力测试/休眠唤醒",
        template_relative_path=Path("stability/specialties/general_specialty.xlsx"),
        required_fields=COMMON_REQUIRED_FIELDS,
    ),
    "gpu": SpecialtyConfig(
        specialty_code="gpu",
        display_name="GPU",
        summary_sheet_name="GPU",
        output_subdir="压力测试/GPU",
        template_relative_path=Path("stability/specialties/general_specialty.xlsx"),
        required_fields=COMMON_REQUIRED_FIELDS,
    ),
    "standby": SpecialtyConfig(
        specialty_code="standby",
        display_name="待机",
        summary_sheet_name="待机",
        output_subdir="压力测试/待机",
        template_relative_path=Path("stability/specialties/general_specialty.xlsx"),
        required_fields=COMMON_REQUIRED_FIELDS,
    ),
    "ddr": SpecialtyConfig(
        specialty_code="ddr",
        display_name="DDR",
        summary_sheet_name="DDR",
        output_subdir="压力测试/DDR",
        template_relative_path=Path("stability/specialties/general_specialty.xlsx"),
        required_fields=COMMON_REQUIRED_FIELDS,
        use_round_directory=False,
    ),
    "online_ui_adb_monkey": SpecialtyConfig(
        specialty_code="online_ui_adb_monkey",
        display_name="联机UI+ADB重启与原生Monkey",
        summary_sheet_name="联机UI重启+ADB重启与原生Monkey",
        output_subdir="压力测试/联机UI+ADB重启+恢复出厂开关机",
        template_relative_path=Path("stability/specialties/online_ui_adb_monkey.xlsx"),
        required_fields=COMMON_REQUIRED_FIELDS,
    ),
    "stress": SpecialtyConfig(
        specialty_code="stress",
        display_name="Stress",
        summary_sheet_name="Stress",
        output_subdir="压力测试/内存泄露Stress",
        template_relative_path=Path("stability/specialties/stress_specialty.xlsx"),
        required_fields=COMMON_REQUIRED_FIELDS,
    ),
    "monkey2": SpecialtyConfig(
        specialty_code="monkey2",
        display_name="Monkey2.0",
        summary_sheet_name="Monkey2.0",
        output_subdir="monkey",
        template_relative_path=Path("stability/specialties/monkey_specialty.xlsx"),
        required_fields=COMMON_REQUIRED_FIELDS,
    ),
}

TEMPLATE_PROFILES = {
    "default": TemplateProfile(
        profile_name="default",
        resource_dir=Path("resource/KO5项目Beta阶段稳定性测试报告"),
        summary_filename="KO5项目Beta阶段稳定性测试报告汇总.xlsx",
    ),
    "ko5_sample": TemplateProfile(
        profile_name="ko5_sample",
        resource_dir=Path("resource/KO5项目Beta阶段稳定性测试报告"),
        summary_filename="KO5项目Beta阶段稳定性测试报告汇总.xlsx",
    ),
}


def get_specialty_configs() -> dict[str, SpecialtyConfig]:
    return SPECIALTY_CONFIGS


def get_template_profile(profile_name: str) -> TemplateProfile | None:
    return TEMPLATE_PROFILES.get(profile_name)
