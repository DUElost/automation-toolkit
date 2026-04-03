from __future__ import annotations

import re
import shutil
from pathlib import Path

from .models import ProjectInfo, SpecialtyConfig, SpecialtyExecution, TemplateProfile
from .title_helpers import build_exact_report_title


def _sanitize_filename(name: str) -> str:
    return re.sub(r'[<>:"/\\|?*]', "_", name).strip()


def build_project_output_dir(project: ProjectInfo) -> Path:
    project.output_root.mkdir(parents=True, exist_ok=True)
    output_dir = project.output_root / f"{project.project_name}项目{project.project_stage}阶段稳定性测试报告"
    output_dir.mkdir(parents=True, exist_ok=True)
    return output_dir


def clone_profile_directory(profile: TemplateProfile, tool_root: Path, output_dir: Path) -> None:
    source_dir = tool_root / profile.resource_dir
    if not source_dir.exists():
        raise FileNotFoundError(f"样板目录不存在: {source_dir}")
    shutil.copytree(source_dir, output_dir, dirs_exist_ok=True)


def materialize_summary(summary_template_path: Path, output_dir: Path, project: ProjectInfo, sample_summary_name: str | None = None) -> Path:
    summary_path = output_dir / f"{project.project_name}项目{project.project_stage}阶段稳定性测试报告汇总.xlsx"
    if sample_summary_name:
        copied_summary = output_dir / sample_summary_name
        if copied_summary.exists() and copied_summary != summary_path:
            copied_summary.rename(summary_path)
        elif copied_summary.exists():
            summary_path = copied_summary
        else:
            shutil.copy2(summary_template_path, summary_path)
    else:
        shutil.copy2(summary_template_path, summary_path)
    return summary_path


def materialize_specialty_report(
    template_path: Path,
    output_dir: Path,
    project: ProjectInfo,
    specialty: SpecialtyExecution,
    config: SpecialtyConfig,
) -> Path:
    if config.use_round_directory:
        round_dir = output_dir / Path(config.output_subdir) / f"第{specialty.round_no}轮"
    else:
        round_dir = output_dir / Path(config.output_subdir)
    round_dir.mkdir(parents=True, exist_ok=True)

    report_title = build_exact_report_title(project, specialty, config)
    if report_title.endswith(".xlsx"):
        report_name = _sanitize_filename(report_title)
    else:
        report_name = f"{_sanitize_filename(report_title)}----{specialty.test_result}.xlsx"
    report_path = round_dir / report_name

    existing_round_files = sorted(path for path in round_dir.glob("*.xlsx") if path.is_file())
    if existing_round_files:
        source_path = existing_round_files[0]
        if source_path != report_path:
            shutil.copy2(source_path, report_path)
        else:
            report_path = source_path
    else:
        template_candidates = sorted((output_dir / Path(config.output_subdir)).glob("**/*.xlsx"))
        source_path = template_candidates[-1] if template_candidates else template_path
        shutil.copy2(source_path, report_path)

    return report_path
