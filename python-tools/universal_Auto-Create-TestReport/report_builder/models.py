from __future__ import annotations

from dataclasses import dataclass, field
from pathlib import Path


@dataclass
class ProjectInfo:
    project_name: str
    project_stage: str
    software_version: str
    reporter: str
    report_date: str
    output_root: Path
    template_profile: str
    brand: str = ""
    platform: str = ""
    bom: str = ""
    rom_ram: str = ""


@dataclass
class SpecialtyExecution:
    specialty_code: str
    specialty_name: str
    enabled: bool
    round_no: int
    test_cycle: str
    test_result: str
    device_count: str
    bug_summary: str
    subreport_title: str
    extensions: dict[str, str] = field(default_factory=dict)


@dataclass
class ReportInput:
    project: ProjectInfo
    specialties: list[SpecialtyExecution]
    bug_rows: list[dict[str, str]] = field(default_factory=list)


@dataclass
class SpecialtyConfig:
    specialty_code: str
    display_name: str
    summary_sheet_name: str
    output_subdir: str
    template_relative_path: Path
    required_fields: tuple[str, ...]
    use_round_directory: bool = True


@dataclass
class TemplateProfile:
    profile_name: str
    resource_dir: Path
    summary_filename: str


@dataclass
class TemplatePaths:
    summary: Path


@dataclass
class SpecialtyFailure:
    specialty_code: str
    reason: str


@dataclass
class GeneratedSpecialty:
    specialty_code: str
    report_path: Path


@dataclass
class GenerationResult:
    output_dir: Path
    summary_path: Path
    generated_reports: list[Path]
    failed_specialties: list[SpecialtyFailure]
