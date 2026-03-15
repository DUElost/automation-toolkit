"""生成用于本地相似度实验的示例 Excel 数据集。

运行方式：

```
python -m tests.create_sample_data --output tests/sample_issues.xlsx
```

生成后的工作簿包含：
- ``existing_issues``：模拟已存在的历史问题，供相似度判定与回归逻辑使用。
- ``new_issues``：模拟一次新的批量提单数据。

可根据需要修改脚本中的样例数据，再重新生成。
"""

from __future__ import annotations

import argparse
from pathlib import Path

import pandas as pd


def build_existing_issues() -> pd.DataFrame:
    return pd.DataFrame(
        [
            {
                "Key": "SIM-1001",
                "Summary": "[Total Number 8][SIM_BUILD][MonkeyAEE][ANR] com.example.magicshow",
                "Environment": "Package: com.example.magicshow | ExpClass: ANR | CurProcess: com.example.magicshow",
                "CausedBy": "Input dispatching timed out (ANR)",
                "Module": "MagicShow",
                "AffectProject": "SIM_BUILD",
                "Status": "Closed",
                "Labels": "MonkeyAEE",
            },
            {
                "Key": "SIM-1002",
                "Summary": "[Total Number 12][SIM_BUILD][MonkeyAEE][JE] net.example.store",
                "Environment": "Package: net.example.store | ExpClass: JE | CurProcess: net.example.store",
                "CausedBy": "java.lang.NullPointerException at StoreActivity.onCreate",
                "Module": "Store",
                "AffectProject": "SIM_BUILD",
                "Status": "Resolved",
                "Labels": "MonkeyAEE",
            },
        ]
    )


def build_new_issues() -> pd.DataFrame:
    return pd.DataFrame(
        [
            {
                "Summary": "[Total Number 10][SIM_BUILD][MonkeyAEE][ANR] com.example.magicshow",
                "Environment": "Package: com.example.magicshow | ExpClass: ANR | CurProcess: com.example.magicshow",
                "CausedBy": "Input dispatching timed out (ANR)",
                "Module": "MagicShow",
                "AffectProject": "SIM_BUILD",
            },
            {
                "Summary": "[Total Number 3][SIM_BUILD][MonkeyAEE][JE] net.example.store",
                "Environment": "Package: net.example.store | ExpClass: JE | CurProcess: net.example.store",
                "CausedBy": "java.lang.IndexOutOfBoundsException",
                "Module": "Store",
                "AffectProject": "SIM_BUILD",
            },
            {
                "Summary": "[Total Number 5][SIM_BUILD][MonkeyAEE][ANR] com.example.weather",
                "Environment": "Package: com.example.weather | ExpClass: ANR | CurProcess: system_server",
                "CausedBy": "system_server hung due to broadcast queue",
                "Module": "Weather",
                "AffectProject": "SIM_BUILD",
            },
        ]
    )


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="生成本地Jira实验用示例Excel")
    parser.add_argument("--output", type=Path, default=Path("tests/sample_issues.xlsx"), help="输出Excel路径")
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    existing_df = build_existing_issues()
    new_df = build_new_issues()

    with pd.ExcelWriter(args.output, engine="openpyxl") as writer:
        existing_df.to_excel(writer, sheet_name="existing_issues", index=False)
        new_df.to_excel(writer, sheet_name="new_issues", index=False)

    print(f"示例数据已写入: {args.output}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())


