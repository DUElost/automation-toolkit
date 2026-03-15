#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
离线 Monkey → Jira 自动化流水线

该模块复刻 Jenkins 日志中的处理流程：从 Monkey 结果 Excel 读取数据，结合
config/ 目录下的包名映射与等级规则，驱动本地 Jira 模拟器执行
「Excel 解析 → 包名映射 → 等级判定 → 相似度判重 → 新建/更新 → 回归」全链路，
最终仅生成 `Main_Jira_database.xlsx`，不触达线上 Jira。

用法示例：

```
python -m tests.offline_monkey_pipeline \
    --main-excel config/Result_None_None_MonkeyAEE_SH_20251025_V551A.xls \
    --project VCAME \
    --regression-cycles 2
```
"""

from __future__ import annotations

import argparse
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Dict, List, Optional

import pandas as pd

from .local_jira_simulator import (
    CAUSE_SIMILARITY_THRESHOLD,
    ENV_SIMILARITY_THRESHOLD,
    LocalJiraSimulator,
    decide_action,
)

# ---------------------------------------------------------------------------
# 项目路径设置
# ---------------------------------------------------------------------------
REPO_ROOT = Path(__file__).resolve().parents[1]
SRC_ROOT = REPO_ROOT / "src"
if str(SRC_ROOT) not in sys.path:
    sys.path.insert(0, str(SRC_ROOT))

from modules.config_loader import ConfigLoader  # noqa: E402
from modules.test_excel_to_jira_upload_list import ExcelToJiraUploadListGenerator  # noqa: E402


@dataclass
class PipelineResult:
    """执行流水线后的结果集合，方便测试与调用方使用。"""

    actions: pd.DataFrame
    regression: pd.DataFrame
    issues: pd.DataFrame
    upload_list: pd.DataFrame


class OfflineMonkeyPipeline:
    """基于本地 Jira 模拟器的 Monkey → Jira 自动化流水线。"""

    def __init__(
        self,
        project_key: str = "VCAME",
        config_dir: Optional[Path] = None,
        output_path: Optional[Path] = None,
    ) -> None:
        self.project_key = project_key
        self.repo_root = REPO_ROOT
        self.config_dir = Path(config_dir) if config_dir else (self.repo_root / "config")
        self.output_path = Path(output_path) if output_path else (self.repo_root / "tests" / "Main_Jira_database.xlsx")
        self.config_loader = ConfigLoader()
        thresholds = self.config_loader.get_thresholds()
        self.env_threshold = thresholds.get("env_threshold", ENV_SIMILARITY_THRESHOLD)
        self.cause_threshold = thresholds.get("cause_threshold", CAUSE_SIMILARITY_THRESHOLD)

    # ------------------------------------------------------------------
    # 数据加载与种子初始化
    # ------------------------------------------------------------------
    def _load_existing_issues(self, path: Path) -> pd.DataFrame:
        if not path.exists():
            return pd.DataFrame()
        try:
            return pd.read_excel(path, sheet_name="issues")
        except ValueError:
            # 文件存在但缺少 issues 工作表
            return pd.DataFrame()

    def _seed_existing(self, simulator: LocalJiraSimulator, existing_df: pd.DataFrame) -> None:
        if existing_df.empty:
            return
        for _, row in existing_df.iterrows():
            simulator.seed_issue(
                key=str(row.get("IssueKey")),
                summary=str(row.get("Summary", "")),
                environment=str(row.get("Environment", "")),
                caused_by=str(row.get("CausedBy", "")),
                module=str(row.get("Module", "")),
                affect_project=str(row.get("AffectProject", "")),
                status=str(row.get("Status", "Open")),
                labels=[label.strip() for label in str(row.get("Labels", "")).split(";") if label.strip()],
                bug_severity=str(row.get("BugSeverity", "SWT") or "SWT"),
                assignee=self._optional_str(row.get("Assignee")),
                priority=self._optional_str(row.get("Priority")),
            )

    @staticmethod
    def _optional_str(value: object) -> Optional[str]:
        if value is None:
            return None
        if isinstance(value, float) and pd.isna(value):
            return None
        text = str(value).strip()
        return text or None

    # ------------------------------------------------------------------
    # 主流程
    # ------------------------------------------------------------------
    def run(
        self,
        main_excel_path: Optional[Path] = None,
        regression_cycles: int = 2,
        existing_database_path: Optional[Path] = None,
        output_path: Optional[Path] = None,
    ) -> PipelineResult:
        generator = ExcelToJiraUploadListGenerator(
            main_file_path=str(main_excel_path) if main_excel_path else None,
            config_dir=str(self.config_dir),
        )
        if not generator.load_excel_files():
            raise RuntimeError("加载 Excel 文件失败，无法继续执行流水线。")
        if not generator.generate_upload_list():
            raise RuntimeError("上传清单生成失败，请检查原始 Excel 数据。")

        upload_list = generator.stats.get("upload_list", [])
        upload_df = pd.DataFrame(upload_list)

        simulator = LocalJiraSimulator(self.project_key)
        existing_path = Path(existing_database_path) if existing_database_path else self.output_path
        existing_df = self._load_existing_issues(existing_path)
        self._seed_existing(simulator, existing_df)

        actions: List[Dict[str, object]] = []
        for idx, issue_payload in enumerate(upload_list, start=1):
            summary = str(issue_payload.get("summary", ""))
            environment = str(issue_payload.get("version", ""))
            caused_by = str(issue_payload.get("key_information", ""))
            module = str(issue_payload.get("module", ""))
            affect_project = str(issue_payload.get("affect_project", "")) or "X6726B"
            bug_severity = str(issue_payload.get("bug_severity", "SWT"))
            assignee = self._optional_str(issue_payload.get("assignee"))
            priority = self._optional_str(issue_payload.get("priority"))

            issue, action, env_score, cause_score = decide_action(
                simulator,
                summary=summary,
                environment=environment,
                caused_by=caused_by,
                module=module,
                affect_project=affect_project,
                bug_severity=bug_severity,
                assignee=assignee,
                priority=priority,
                env_threshold=self.env_threshold,
                cause_threshold=self.cause_threshold,
            )

            actions.append(
                {
                    "Row": idx,
                    "Summary": summary,
                    "Module": module,
                    "BugSeverity": bug_severity,
                    "Assignee": assignee or "",
                    "Priority": priority or "",
                    "Action": action,
                    "IssueKey": issue.key,
                    "EnvironmentSimilarity": round(env_score, 3),
                    "CausedBySimilarity": round(cause_score, 3),
                    "StatusAfter": issue.status,
                    "AffectProject": issue.affect_project,
                }
            )

        regression_closed = simulator.regression_pass(required_cycles=regression_cycles)
        regression_df = pd.DataFrame(
            [
                {
                    "IssueKey": issue.key,
                    "FinalStatus": issue.status,
                    "History": "\n".join(issue.history),
                }
                for issue in regression_closed
            ]
        )

        issues_df = pd.DataFrame(
            [
                {
                    "IssueKey": issue.key,
                    "Summary": issue.summary,
                    "Environment": issue.environment,
                    "CausedBy": issue.caused_by,
                    "Status": issue.status,
                    "Module": issue.module,
                    "AffectProject": issue.affect_project,
                    "Labels": ";".join(issue.labels),
                    "BugSeverity": issue.bug_severity,
                    "Assignee": issue.assignee or "",
                    "Priority": issue.priority or "",
                }
                for issue in simulator.all_issues()
            ]
        )

        result = PipelineResult(
            actions=pd.DataFrame(actions),
            regression=regression_df,
            issues=issues_df,
            upload_list=upload_df,
        )

        output_target = Path(output_path) if output_path else self.output_path
        self._write_output(result, output_target)
        return result

    # ------------------------------------------------------------------
    # 结果输出
    # ------------------------------------------------------------------
    def _write_output(self, result: PipelineResult, output_path: Path) -> None:
        output_path.parent.mkdir(parents=True, exist_ok=True)
        with pd.ExcelWriter(output_path, engine="openpyxl") as writer:
            if not result.actions.empty:
                result.actions.to_excel(writer, sheet_name="actions", index=False)
            if not result.regression.empty:
                result.regression.to_excel(writer, sheet_name="regression", index=False)
            if not result.issues.empty:
                result.issues.to_excel(writer, sheet_name="issues", index=False)
            if not result.upload_list.empty:
                result.upload_list.to_excel(writer, sheet_name="upload_list", index=False)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="离线 Monkey → Jira 自动化流水线")
    parser.add_argument("--main-excel", type=Path, help="Monkey 结果文件路径，默认自动在 config/ 中检索最新文件")
    parser.add_argument("--project", default="VCAME", help="模拟使用的项目 Key，默认 VCAME")
    parser.add_argument("--config-dir", type=Path, help="配置目录，默认 <repo>/config")
    parser.add_argument("--output", type=Path, help="结果 Excel 输出路径，默认 tests/Main_Jira_database.xlsx")
    parser.add_argument("--regression-cycles", type=int, default=2, help="通过回归所需的重开次数，默认 2")
    parser.add_argument(
        "--existing-db",
        type=Path,
        help="已有离线数据库 (Main_Jira_database.xlsx) 路径，可用于重复运行时继承历史",
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    pipeline = OfflineMonkeyPipeline(
        project_key=args.project,
        config_dir=args.config_dir,
        output_path=args.output or (REPO_ROOT / "tests" / "Main_Jira_database.xlsx"),
    )
    pipeline.run(
        main_excel_path=args.main_excel,
        regression_cycles=args.regression_cycles,
        existing_database_path=args.existing_db,
        output_path=args.output,
    )
    print(f"离线流水线执行完成，结果已写入: {args.output or pipeline.output_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

