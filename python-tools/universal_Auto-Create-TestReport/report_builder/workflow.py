from __future__ import annotations

import argparse
from pathlib import Path

from .config import get_specialty_configs, get_template_profile
from .input_reader import read_input_workbook
from .models import GenerationResult, SpecialtyFailure
from .template_factory import create_input_template, ensure_builtin_templates
from .template_manager import build_project_output_dir, clone_profile_directory, materialize_specialty_report, materialize_summary
from .workbook_writer import write_specialty_report, write_summary_workbook


TOOL_ROOT = Path(__file__).resolve().parent.parent


def run_generation(input_path: Path | str, output_root: Path | str | None = None) -> GenerationResult:
    report_input = read_input_workbook(input_path)
    if output_root is not None:
        report_input.project.output_root = Path(output_root)

    template_paths = ensure_builtin_templates(TOOL_ROOT / "templates")
    output_dir = build_project_output_dir(report_input.project)
    template_profile = get_template_profile(report_input.project.template_profile)
    if template_profile is not None:
        clone_profile_directory(template_profile, TOOL_ROOT, output_dir)

    summary_path = materialize_summary(
        template_paths.summary,
        output_dir,
        report_input.project,
        sample_summary_name=template_profile.summary_filename if template_profile else None,
    )

    specialty_configs = get_specialty_configs()
    successful_specialties: list[tuple] = []
    generated_reports: list[Path] = []
    failures: list[SpecialtyFailure] = []

    for specialty in report_input.specialties:
        if not specialty.enabled:
            continue

        config = specialty_configs.get(specialty.specialty_code)
        if config is None:
            failures.append(SpecialtyFailure(specialty_code=specialty.specialty_code, reason="未找到专项配置"))
            continue

        missing_fields = [
            field_name
            for field_name in config.required_fields
            if not getattr(specialty, field_name, "")
        ]
        if missing_fields:
            failures.append(
                SpecialtyFailure(
                    specialty_code=specialty.specialty_code,
                    reason=f"缺少必要字段: {', '.join(missing_fields)}",
                )
            )
            continue

        report_path = materialize_specialty_report(
            template_path=TOOL_ROOT / "templates" / config.template_relative_path,
            output_dir=output_dir,
            project=report_input.project,
            specialty=specialty,
            config=config,
        )
        write_specialty_report(report_path, report_input.project, specialty, config)
        generated_reports.append(report_path)
        successful_specialties.append((specialty, config, report_path))

    write_summary_workbook(
        summary_path=summary_path,
        project=report_input.project,
        specialties=successful_specialties,
        bug_rows=report_input.bug_rows,
    )

    return GenerationResult(
        output_dir=output_dir,
        summary_path=summary_path,
        generated_reports=generated_reports,
        failed_specialties=failures,
    )


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description="稳定性测试报告自动生成工具")
    subparsers = parser.add_subparsers(dest="command", required=True)

    run_parser = subparsers.add_parser("run", help="根据输入工作簿生成报告")
    run_parser.add_argument("--input", required=True, help="输入工作簿路径")
    run_parser.add_argument("--output-root", help="覆盖输出根目录")

    init_parser = subparsers.add_parser("init-input", help="生成输入工作簿模板")
    init_parser.add_argument(
        "--output",
        default=str(TOOL_ROOT / "examples" / "report_input_template.xlsx"),
        help="输入模板输出路径",
    )
    return parser


def main(argv: list[str] | None = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)

    if args.command == "init-input":
        output_path = create_input_template(Path(args.output))
        print(f"输入模板已生成: {output_path}")
        return 0

    result = run_generation(input_path=Path(args.input), output_root=args.output_root)
    print(f"输出目录: {result.output_dir}")
    print(f"汇总报告: {result.summary_path}")
    print(f"成功生成专项报告数: {len(result.generated_reports)}")
    for report_path in result.generated_reports:
        print(f"  - {report_path}")
    if result.failed_specialties:
        print("失败专项:")
        for failure in result.failed_specialties:
            print(f"  - {failure.specialty_code}: {failure.reason}")
    return 0 if not result.failed_specialties else 1
