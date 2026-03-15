"""Local similarity → create/update → regression pipeline for experimentation.

该脚本依赖 `tests/local_jira_simulator.py`，通过本地 Excel 数据驱动，模拟
JQL 相似度判定、问题新建/更新以及回归状态处理的完整流程，不会访问正式
Jira 环境，适用于调试算法和阈值。

Excel 要求包含两个工作表：
1. ``existing_issues``：表示当前系统里已存在的问题列表。
   必填列：``Key``、``Summary``、``Environment``、``CausedBy``、``Module``、
   ``AffectProject``，可选列：``Status``、``Labels``。
2. ``new_issues``：待处理的全量问题。
   必填列：``Summary``、``Environment``、``CausedBy``、``Module``、
   ``AffectProject``。

示例：

```
python -m tests.local_similarity_pipeline tests/sample_issues.xlsx \
    --project VCAME --output tests/pipeline_result.xlsx
```
"""

from __future__ import annotations

import argparse
from pathlib import Path
from typing import Dict, List, Tuple

import pandas as pd

from .local_jira_simulator import (
    CAUSE_SIMILARITY_THRESHOLD,
    ENV_SIMILARITY_THRESHOLD,
    LocalJiraSimulator,
    decide_action,
)


REQUIRED_EXISTING_COLUMNS = {
    "Key",
    "Summary",
    "Environment",
    "CausedBy",
    "Module",
    "AffectProject",
}
REQUIRED_NEW_COLUMNS = {
    "Summary",
    "Environment",
    "CausedBy",
    "Module",
    "AffectProject",
}


def _validate_columns(df: pd.DataFrame, required: set, sheet_name: str) -> None:
    missing = required - set(df.columns)
    if missing:
        raise ValueError(f"工作表 '{sheet_name}' 缺少必填列: {sorted(missing)}")


def _load_excel(excel_path: Path) -> Tuple[pd.DataFrame, pd.DataFrame]:
    data = pd.read_excel(excel_path, sheet_name=["existing_issues", "new_issues"])
    existing_df = data.get("existing_issues", pd.DataFrame())
    new_df = data.get("new_issues", pd.DataFrame())

    if new_df.empty:
        raise ValueError("new_issues 工作表不能为空")

    _validate_columns(new_df, REQUIRED_NEW_COLUMNS, "new_issues")
    if not existing_df.empty:
        _validate_columns(existing_df, REQUIRED_EXISTING_COLUMNS, "existing_issues")

    return existing_df, new_df


def _seed_existing(simulator: LocalJiraSimulator, existing_df: pd.DataFrame) -> None:
    if existing_df.empty:
        return
    for _, row in existing_df.iterrows():
        simulator.seed_issue(
            key=str(row["Key"]),
            summary=str(row["Summary"]),
            environment=str(row["Environment"]),
            caused_by=str(row["CausedBy"]),
            module=str(row["Module"]),
            affect_project=str(row["AffectProject"]),
            status=str(row.get("Status", "Open")),
            labels=[label.strip() for label in str(row.get("Labels", "")).split(";") if label.strip()],
        )


def run_pipeline(
    excel_path: Path,
    project_key: str,
    regression_cycles: int,
) -> Dict[str, pd.DataFrame]:
    existing_df, new_df = _load_excel(excel_path)
    simulator = LocalJiraSimulator(project_key)
    _seed_existing(simulator, existing_df)

    actions: List[Dict[str, object]] = []
    for row_idx, row in new_df.iterrows():
        summary = str(row["Summary"])
        environment = str(row["Environment"])
        caused_by = str(row["CausedBy"])
        module = str(row["Module"])
        affect_project = str(row["AffectProject"])

        issue, action, env_score, cause_score = decide_action(
            simulator,
            summary=summary,
            environment=environment,
            caused_by=caused_by,
            module=module,
            affect_project=affect_project,
        )

        actions.append(
            {
                "Row": row_idx + 1,
                "Summary": summary,
                "Action": action,
                "IssueKey": issue.key,
                "EnvironmentSimilarity": round(env_score, 3),
                "CausedBySimilarity": round(cause_score, 3),
                "StatusAfter": issue.status,
                "Module": issue.module,
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

    return {
        "actions": pd.DataFrame(actions),
        "regression": regression_df,
        "final_state": pd.DataFrame(
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
        ),
    }


def write_output(result_frames: Dict[str, pd.DataFrame], output_path: Path) -> None:
    with pd.ExcelWriter(output_path, engine="openpyxl") as writer:
        for sheet_name, df in result_frames.items():
            if df.empty:
                continue
            df.to_excel(writer, sheet_name=sheet_name[:31], index=False)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="本地相似度 + 提单/更新 + 回归处理实验工具")
    parser.add_argument("excel_path", type=Path, help="包含 existing_issues 与 new_issues 工作表的Excel路径")
    parser.add_argument("--project", default="SIM", help="模拟的项目Key，默认SIM")
    parser.add_argument("--output", type=Path, help="输出结果Excel路径，可选")
    parser.add_argument("--regression-cycles", type=int, default=2, help="回归通过所需重开次数，默认2")
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    frames = run_pipeline(args.excel_path, args.project, args.regression_cycles)

    actions_df = frames["actions"]
    print("\n=== 动作决策统计 ===")
    if actions_df.empty:
        print("无待处理数据")
    else:
        print(actions_df.groupby("Action").size())
        print("\n相似度阈值:")
        print(f"  environment >= {ENV_SIMILARITY_THRESHOLD:.2f}")
        print(f"  caused_by >= {CAUSE_SIMILARITY_THRESHOLD:.2f}")

    if args.output:
        write_output(frames, args.output)
        print(f"\n结果已输出至: {args.output}")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())


