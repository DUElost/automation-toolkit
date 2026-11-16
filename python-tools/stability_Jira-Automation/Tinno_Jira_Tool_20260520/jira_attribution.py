#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""B8 G8 厂商 Jira 工具发生归因契约实现（b8-g8-attribution-v1）。

本模块在 Transsion 与 Tinno 两套工具中各保留一份内容一致的实现，只通过
TOOL_NAME 区分；三套工具互不 import 的仓库约定不变。共享契约见
../contracts/attribution-contract-v1.json。

契约目标：

- 平台 manifest.json 中的 signature_id / occurrence_id / occurrence_key
  贯穿清单生成、人工复核与建单结果；
- 一个清单项合并多个发生时保留完整 occurrence_ids 集合；
- 只有同时命中 manifest.attribution_candidates 的
  (signature_id, occurrence_id) 才允许生成 Jira key 关联；
- 缺失、无效、重复、越界标识写入 gaps，工作簿行号与 stdout 只用于诊断。
"""

from __future__ import annotations

import json
import os
from dataclasses import dataclass, field
from datetime import datetime
from pathlib import Path
from typing import Any, Dict, Iterable, List, Mapping, Optional, Sequence, Tuple

CONTRACT_VERSION = "b8-g8-attribution-v1"
ARTIFACT_SCHEMA = "stp.jira_attribution/v1"
MANIFEST_SCHEMA = "stp.jira_delivery_input/v1"
TOOL_NAME = "tinno"

SIGNATURE_COLUMN = "Signature ID"
OCCURRENCE_IDS_COLUMN = "Occurrence IDs"
OCCURRENCE_KEYS_COLUMN = "Occurrence Keys"
OCCURRENCE_COUNT_COLUMN = "Occurrence Count"
ATTRIBUTION_STATUS_COLUMN = "Attribution Status"
ATTRIBUTION_NOTE_COLUMN = "Attribution Note"
SOURCE_ROW_COLUMN = "Source Excel Row"

STATUS_OK = "OK"
STATUS_MERGED = "MERGED"
STATUS_MISSING_SIGNATURE_ID = "MISSING_SIGNATURE_ID"
STATUS_INVALID_SIGNATURE_ID = "INVALID_SIGNATURE_ID"
STATUS_UNKNOWN_SIGNATURE_ID = "UNKNOWN_SIGNATURE_ID"
STATUS_NO_OCCURRENCE = "NO_OCCURRENCE"
STATUS_INVALID_OCCURRENCE_ID = "INVALID_OCCURRENCE_ID"
STATUS_OUT_OF_SCOPE_OCCURRENCE_ID = "OUT_OF_SCOPE_OCCURRENCE_ID"
STATUS_DUPLICATE_OCCURRENCE_ID = "DUPLICATE_OCCURRENCE_ID"
STATUS_SIGNATURE_MISMATCH = "SIGNATURE_MISMATCH"

LINKABLE_STATUSES = frozenset({STATUS_OK, STATUS_MERGED})
RESULT_STATUSES_WITH_KEY = frozenset({"SUCCESS", "FAILED"})


class AttributionError(ValueError):
    """归因输入不可用；调用方应 fail-closed 并停止本次运行。"""


@dataclass(frozen=True)
class Occurrence:
    signature_id: int
    occurrence_id: int
    occurrence_key: str = ""
    dle_id: str = ""
    serial: str = ""

    def as_dict(self) -> Dict[str, Any]:
        return {
            "signature_id": self.signature_id,
            "occurrence_id": self.occurrence_id,
            "occurrence_key": self.occurrence_key,
            "dle_id": self.dle_id,
            "serial": self.serial,
        }


@dataclass
class Resolution:
    """一个清单项（或建单结果行）的归因判定结果。"""

    signature_id: Optional[int] = None
    status: str = STATUS_MISSING_SIGNATURE_ID
    occurrences: List[Occurrence] = field(default_factory=list)
    note: str = ""
    raw_signature: str = ""
    raw_occurrence_ids: str = ""
    source_row: Optional[int] = None
    workbook_row: Optional[int] = None
    duplicate_ids: List[int] = field(default_factory=list)

    @property
    def occurrence_ids(self) -> List[int]:
        return [item.occurrence_id for item in self.occurrences]

    @property
    def occurrence_keys(self) -> List[str]:
        return [item.occurrence_key for item in self.occurrences]

    @property
    def linkable(self) -> bool:
        return self.status in LINKABLE_STATUSES and bool(self.occurrences)

    @property
    def blocked(self) -> bool:
        """重复发生不得再建单，避免同一发生生成两个 key。"""

        return self.status == STATUS_DUPLICATE_OCCURRENCE_ID

    def result_fields(self) -> Dict[str, Any]:
        return {
            "signature_id": self.signature_id,
            "occurrence_id": self.occurrence_ids[0] if len(self.occurrences) == 1 else None,
            "occurrence_ids": self.occurrence_ids,
            "occurrence_keys": self.occurrence_keys,
            "attribution_status": self.status,
            "attribution_note": self.note,
        }

    def workbook_fields(self) -> Dict[str, Any]:
        return {
            SIGNATURE_COLUMN: "" if self.signature_id is None else str(self.signature_id),
            OCCURRENCE_IDS_COLUMN: json.dumps(self.occurrence_ids, ensure_ascii=False),
            OCCURRENCE_KEYS_COLUMN: json.dumps(self.occurrence_keys, ensure_ascii=False),
            OCCURRENCE_COUNT_COLUMN: len(self.occurrences),
            ATTRIBUTION_STATUS_COLUMN: self.status,
            ATTRIBUTION_NOTE_COLUMN: self.note,
            SOURCE_ROW_COLUMN: "" if self.workbook_row is None else int(self.workbook_row),
        }


def _cell_text(value: Any) -> str:
    if value is None:
        return ""
    if isinstance(value, float):
        if value != value:  # NaN：Excel 空单元格
            return ""
        if value.is_integer():
            return str(int(value))
    text = str(value).strip()
    if text.lower() in {"nan", "none", "<na>"}:
        return ""
    return text


def _parse_int(value: Any) -> Optional[int]:
    text = _cell_text(value)
    if not text:
        return None
    try:
        return int(float(text))
    except (TypeError, ValueError):
        return None


def _parse_id_list(value: Any) -> Tuple[List[int], List[str]]:
    """解析工作簿中的 Occurrence IDs；返回 (合法 ID, 非法原文)。"""

    if value is None:
        return [], []
    if isinstance(value, (list, tuple, set)):
        raw_items = list(value)
    else:
        text = _cell_text(value)
        if not text:
            return [], []
        raw_items = None
        if text.startswith("["):
            try:
                parsed = json.loads(text)
            except (TypeError, ValueError):
                parsed = None
            if isinstance(parsed, list):
                raw_items = parsed
        if raw_items is None:
            raw_items = [item for item in text.replace(";", ",").split(",") if item.strip()]

    valid: List[int] = []
    invalid: List[str] = []
    for item in raw_items:
        parsed = _parse_int(item)
        if parsed is None:
            text = _cell_text(item)
            if text:
                invalid.append(text)
            continue
        valid.append(parsed)
    return valid, invalid


def _row_value(row: Any, *names: str) -> Any:
    for name in names:
        if isinstance(row, Mapping):
            if name in row:
                return row.get(name)
            continue
        index = getattr(row, "index", None)
        if index is not None and name in index:
            return row[name]
    index = getattr(row, "index", None)
    if index is not None:
        lookup = {str(column).strip().lower(): column for column in index}
        for name in names:
            column = lookup.get(name.strip().lower())
            if column is not None:
                return row[column]
    return None


def read_attribution_inputs(row: Any) -> Tuple[Any, Any, Any]:
    """从清单行读取平台标识；兼容平台列名与手工复核后的列名。"""

    signature = _row_value(row, SIGNATURE_COLUMN, "signature_id", "SignatureId", "Id")
    occurrence_ids = _row_value(row, OCCURRENCE_IDS_COLUMN, "occurrence_ids", "OccurrenceIds")
    occurrence_keys = _row_value(row, OCCURRENCE_KEYS_COLUMN, "occurrence_keys", "OccurrenceKeys")
    return signature, occurrence_ids, occurrence_keys


class ManifestIndex:
    """平台 manifest.json 的只读索引。"""

    def __init__(self, manifest: Mapping[str, Any], path: Optional[Path] = None) -> None:
        schema = str(manifest.get("schema") or "")
        if schema != MANIFEST_SCHEMA:
            raise AttributionError(
                f"manifest schema 不受支持: {schema!r}，期望 {MANIFEST_SCHEMA!r}"
            )
        self.manifest = dict(manifest)
        self.path = Path(path) if path is not None else None
        self.candidates: Dict[Tuple[int, int], Occurrence] = {}
        self.by_signature: Dict[int, List[Occurrence]] = {}
        self.issue_by_signature: Dict[int, Dict[str, Any]] = {}
        self.registered_signatures: set[int] = set()
        for item in manifest.get("issue_ids") or []:
            signature_id = _parse_int(item)
            if signature_id is not None:
                self.registered_signatures.add(signature_id)
        for item in manifest.get("issues") or []:
            if not isinstance(item, Mapping):
                continue
            signature_id = _parse_int(item.get("signature_id"))
            if signature_id is None:
                continue
            self.issue_by_signature[signature_id] = dict(item)
            self.registered_signatures.add(signature_id)
        scoped_signatures = set(self.registered_signatures)
        for item in manifest.get("attribution_candidates") or []:
            if not isinstance(item, Mapping):
                continue
            signature_id = _parse_int(item.get("signature_id"))
            occurrence_id = _parse_int(item.get("occurrence_id"))
            if signature_id is None or occurrence_id is None:
                continue
            if scoped_signatures and signature_id not in scoped_signatures:
                continue
            occurrence = Occurrence(
                signature_id=signature_id,
                occurrence_id=occurrence_id,
                occurrence_key=str(item.get("occurrence_key") or ""),
                dle_id=str(item.get("dle_id") or ""),
                serial=str(item.get("serial") or ""),
            )
            self.candidates[(signature_id, occurrence_id)] = occurrence
            self.by_signature.setdefault(signature_id, []).append(occurrence)
        for occurrences in self.by_signature.values():
            occurrences.sort(key=lambda item: item.occurrence_id)

    def run_meta(self) -> Dict[str, Any]:
        return {
            "manifest": str(self.path) if self.path is not None else "",
            "manifest_schema": str(self.manifest.get("schema") or ""),
            "plan_run_id": _parse_int(self.manifest.get("plan_run_id")),
            "root_plan_run_id": _parse_int(self.manifest.get("root_plan_run_id")),
            "platform": str(self.manifest.get("platform") or ""),
            "delivery_version_id": _parse_int(self.manifest.get("delivery_version_id")),
            "delivery_version_no": _parse_int(self.manifest.get("delivery_version_no")),
            "compat_rerun_id": _parse_int(self.manifest.get("compat_rerun_id")),
            "issue_ids": [item for item in (self.manifest.get("issue_ids") or [])],
            "event_ids": [item for item in (self.manifest.get("event_ids") or [])],
        }

    def resolve(
        self,
        signature_raw: Any,
        occurrence_ids_raw: Any = None,
        *,
        source_row: Optional[int] = None,
        workbook_row: Optional[int] = None,
    ) -> Resolution:
        resolution = Resolution(
            raw_signature=_cell_text(signature_raw),
            raw_occurrence_ids=_cell_text(occurrence_ids_raw),
            source_row=source_row,
            workbook_row=workbook_row,
        )
        if not resolution.raw_signature:
            resolution.status = STATUS_MISSING_SIGNATURE_ID
            resolution.note = "清单行缺少平台 Signature ID"
            return resolution
        signature_id = _parse_int(signature_raw)
        if signature_id is None:
            resolution.status = STATUS_INVALID_SIGNATURE_ID
            resolution.note = f"Signature ID 不是整数: {resolution.raw_signature!r}"
            return resolution
        resolution.signature_id = signature_id
        if signature_id not in self.registered_signatures:
            resolution.status = STATUS_UNKNOWN_SIGNATURE_ID
            resolution.note = f"Signature ID {signature_id} 不在本次 manifest 登记范围"
            return resolution

        allowed = self.by_signature.get(signature_id, [])
        if not allowed:
            resolution.status = STATUS_NO_OCCURRENCE
            resolution.note = f"Signature ID {signature_id} 在 manifest 中没有发生"
            return resolution

        explicit_ids, invalid_tokens = _parse_id_list(occurrence_ids_raw)
        if invalid_tokens:
            resolution.status = STATUS_INVALID_OCCURRENCE_ID
            resolution.note = "Occurrence IDs 含非整数: " + ", ".join(sorted(set(invalid_tokens)))
            return resolution
        if not explicit_ids:
            resolution.occurrences = list(allowed)
            resolution.status = STATUS_OK
            resolution.note = "按 manifest 补全发生集合"
            return resolution

        deduped: List[int] = []
        duplicates: List[int] = []
        seen: set[int] = set()
        for occurrence_id in explicit_ids:
            if occurrence_id in seen:
                duplicates.append(occurrence_id)
                continue
            seen.add(occurrence_id)
            deduped.append(occurrence_id)

        out_of_scope = [item for item in deduped if (signature_id, item) not in self.candidates]
        if out_of_scope:
            resolution.status = STATUS_OUT_OF_SCOPE_OCCURRENCE_ID
            resolution.note = (
                f"Signature ID {signature_id} 的 occurrence_id 越界: "
                + ", ".join(str(item) for item in out_of_scope)
            )
            return resolution

        resolution.occurrences = [self.candidates[(signature_id, item)] for item in deduped]
        resolution.duplicate_ids = sorted(set(duplicates))
        resolution.status = STATUS_OK
        if resolution.duplicate_ids:
            resolution.note = "Occurrence IDs 重复已去重: " + ", ".join(
                str(item) for item in resolution.duplicate_ids
            )
        return resolution


def load_manifest(path: str | Path) -> ManifestIndex:
    manifest_path = Path(path)
    try:
        payload = json.loads(manifest_path.read_text(encoding="utf-8"))
    except (OSError, ValueError) as exc:
        raise AttributionError(f"manifest 不可读: {manifest_path}: {exc}") from exc
    if not isinstance(payload, Mapping):
        raise AttributionError(f"manifest 不是 JSON 对象: {manifest_path}")
    return ManifestIndex(payload, manifest_path)


def discover_manifest(
    explicit: Optional[str | Path],
    *search_dirs: Optional[Path],
) -> Optional[Path]:
    if explicit:
        return Path(explicit)
    seen: set[Path] = set()
    for directory in list(search_dirs) + [Path.cwd()]:
        if directory is None:
            continue
        candidate = Path(directory) / "manifest.json"
        try:
            resolved = candidate.resolve()
        except OSError:
            resolved = candidate
        if resolved in seen:
            continue
        seen.add(resolved)
        if candidate.is_file():
            return candidate
    return None


def resolve_workspace(
    explicit_output_dir: Optional[str | Path],
    manifest_path: Optional[Path],
    default_result_dir: Path,
) -> Tuple[Path, Path, bool]:
    """返回 (工作区, result 目录, 是否归因模式)。

    - 显式 --output-dir：工作区即该目录；
    - 否则 cwd 存在 manifest.json（平台隔离工作区）：工作区即 cwd；
    - 否则保持旧行为：result/ 即输出目录，归因关闭。
    """

    if explicit_output_dir:
        workspace = Path(explicit_output_dir)
        return workspace, workspace / "result", True
    if manifest_path is not None:
        workspace = Path(manifest_path).resolve().parent
        return workspace, workspace / "result", True
    return default_result_dir.parent, default_result_dir, False


def _gap(resolution: Resolution, *, stage: str, kind: Optional[str] = None) -> Optional[Dict[str, Any]]:
    if resolution.status in LINKABLE_STATUSES and not resolution.duplicate_ids:
        return None
    if kind is not None:
        gap_kind = kind
    elif resolution.status in LINKABLE_STATUSES:
        gap_kind = "duplicate_occurrence_id"
    else:
        gap_kind = resolution.status.lower()
    payload: Dict[str, Any] = {
        "kind": gap_kind,
        "stage": stage,
        "row": resolution.source_row,
        "workbook_row": resolution.workbook_row,
        "signature_id": resolution.signature_id,
        "occurrence_ids": resolution.occurrence_ids,
        "reason": resolution.note,
    }
    if resolution.duplicate_ids:
        payload["duplicate_occurrence_ids"] = resolution.duplicate_ids
    if resolution.raw_signature:
        payload["raw_signature_id"] = resolution.raw_signature
    if resolution.raw_occurrence_ids:
        payload["raw_occurrence_ids"] = resolution.raw_occurrence_ids
    return payload


def annotate_rows(
    rows: List[Dict[str, Any]],
    index: ManifestIndex,
    *,
    stage: str = "generate",
) -> Tuple[List[Dict[str, Any]], List[Dict[str, Any]], List[Dict[str, Any]]]:
    """为上传清单行写入归因列，并合并同一 signature 的多个清单项。

    rows 中的临时键：_raw_signature、_raw_occurrence_ids、_excel_row。
    返回 (rows, items, gaps)；generate 阶段 links 恒为空。
    """

    resolved: List[Tuple[Dict[str, Any], Resolution]] = []
    for row in rows:
        resolution = index.resolve(
            row.pop("_raw_signature", None),
            row.pop("_raw_occurrence_ids", None),
            source_row=row.pop("_source_row", None),
            workbook_row=row.pop("_excel_row", None),
        )
        resolved.append((row, resolution))

    # 同一 signature 的多行合并为一个清单项，保留完整发生集合。
    groups: Dict[int, List[Tuple[Dict[str, Any], Resolution]]] = {}
    order: List[int] = []
    for row, resolution in resolved:
        if resolution.status not in LINKABLE_STATUSES:
            continue
        signature_id = int(resolution.signature_id)
        if signature_id not in groups:
            groups[signature_id] = []
            order.append(signature_id)
        groups[signature_id].append((row, resolution))

    for signature_id in order:
        members = groups[signature_id]
        if len(members) <= 1:
            continue
        base_row, base_resolution = members[0]
        occurrence_map: Dict[int, Occurrence] = {
            item.occurrence_id: item for item in base_resolution.occurrences
        }
        merged_from: List[int] = []
        total_count = 0.0
        max_device_count = 0
        device_ids: List[str] = []
        for row, resolution in members:
            merged_from.append(int(resolution.workbook_row or 0))
            for occurrence in resolution.occurrences:
                occurrence_map[occurrence.occurrence_id] = occurrence
            try:
                total_count += float(row.get("Count") or 0)
            except (TypeError, ValueError):
                pass
            try:
                max_device_count = max(max_device_count, int(float(row.get("Device Count") or 0)))
            except (TypeError, ValueError):
                pass
            device_ids.extend(
                item.strip()
                for item in str(row.get("DeviceId") or "").replace(";", ",").split(",")
                if item.strip()
            )
        base_resolution.occurrences = [occurrence_map[key] for key in sorted(occurrence_map)]
        base_resolution.status = STATUS_MERGED
        base_resolution.note = "合并清单项 Excel 行: " + ", ".join(str(item) for item in merged_from)
        base_row["Count"] = int(total_count) if float(total_count).is_integer() else total_count
        if max_device_count:
            base_row["Device Count"] = max_device_count
        if device_ids:
            base_row["DeviceId"] = ",".join(dict.fromkeys(device_ids))
        for row, resolution in members[1:]:
            rows.remove(row)
            # 已并入首行；清空发生集合，避免后续重复检测把它当成第二个清单项。
            resolution.occurrences = []

    # 跨清单项重复发生：两边都不允许生成关联，避免把 key 写到错误发生。
    occurrence_rows: Dict[int, List[Resolution]] = {}
    for _, resolution in resolved:
        if resolution.status not in LINKABLE_STATUSES:
            continue
        for occurrence_id in resolution.occurrence_ids:
            occurrence_rows.setdefault(occurrence_id, []).append(resolution)
    for occurrence_id, hits in occurrence_rows.items():
        if len({id(item) for item in hits}) <= 1:
            continue
        for resolution in hits:
            resolution.status = STATUS_DUPLICATE_OCCURRENCE_ID
            resolution.duplicate_ids = sorted(set(resolution.duplicate_ids) | {occurrence_id})
            resolution.note = f"occurrence_id {occurrence_id} 同时出现在多个清单项"
            resolution.occurrences = []

    kept_row_ids = {id(item) for item in rows}
    items: List[Dict[str, Any]] = []
    gaps: List[Dict[str, Any]] = []
    for row, resolution in resolved:
        if id(row) not in kept_row_ids:
            continue
        row.update(resolution.workbook_fields())
        items.append(
            {
                "row": resolution.source_row,
                "workbook_row": resolution.workbook_row,
                "signature_id": resolution.signature_id,
                "occurrence_ids": resolution.occurrence_ids,
                "occurrence_keys": resolution.occurrence_keys,
                "occurrence_count": len(resolution.occurrences),
                "attribution_status": resolution.status,
                "attribution_note": resolution.note,
            }
        )
        gap = _gap(resolution, stage=stage)
        if gap is not None:
            gaps.append(gap)
    return rows, items, gaps


def build_payload(
    *,
    stage: str,
    index: ManifestIndex,
    items: Sequence[Mapping[str, Any]],
    links: Sequence[Mapping[str, Any]],
    gaps: Sequence[Mapping[str, Any]],
    run_id: str = "",
    workspace: Optional[Path] = None,
) -> Dict[str, Any]:
    return {
        "schema": ARTIFACT_SCHEMA,
        "contract_version": CONTRACT_VERSION,
        "tool": TOOL_NAME,
        "stage": stage,
        "run": {
            "run_id": run_id,
            "workspace": str(workspace) if workspace is not None else "",
            "generated_at": datetime.now().isoformat(timespec="seconds"),
            **index.run_meta(),
        },
        "items": [dict(item) for item in items],
        "links": [dict(item) for item in links],
        "gaps": [dict(item) for item in gaps],
    }


def write_payload(path: str | Path, payload: Mapping[str, Any]) -> Path:
    target = Path(path)
    target.parent.mkdir(parents=True, exist_ok=True)
    tmp = target.with_name(target.name + ".tmp")
    tmp.write_text(json.dumps(payload, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    os.replace(tmp, target)
    return target


class AttributionRecorder:
    """建单阶段归因记录器：逐行记录结果，最后一次性写 attribution.json。"""

    def __init__(
        self,
        index: Optional[ManifestIndex],
        *,
        workspace: Optional[Path] = None,
        run_id: str = "",
        stage: str = "create",
    ) -> None:
        self.index = index
        self.workspace = Path(workspace) if workspace is not None else None
        self.run_id = run_id
        self.stage = stage
        self.items: List[Dict[str, Any]] = []
        self.links: List[Dict[str, Any]] = []
        self.gaps: List[Dict[str, Any]] = []
        self._link_keys: set[Tuple[int, str]] = set()

    @property
    def enabled(self) -> bool:
        return self.index is not None

    def prepare(self, rows: Iterable[Any]) -> List[Resolution]:
        if self.index is None:
            return []
        resolutions: List[Resolution] = []
        row_iter = (item for _, item in rows.iterrows()) if hasattr(rows, "iterrows") else iter(rows)
        for position, row in enumerate(row_iter):
            signature, occurrence_ids, _ = read_attribution_inputs(row)
            resolutions.append(
                self.index.resolve(
                    signature,
                    occurrence_ids,
                    source_row=position + 1,
                    workbook_row=position + 2,
                )
            )
        occurrence_rows: Dict[int, List[Resolution]] = {}
        for resolution in resolutions:
            if resolution.status not in LINKABLE_STATUSES:
                continue
            for occurrence_id in resolution.occurrence_ids:
                occurrence_rows.setdefault(occurrence_id, []).append(resolution)
        for occurrence_id, hits in occurrence_rows.items():
            if len({id(item) for item in hits}) <= 1:
                continue
            for resolution in hits:
                resolution.status = STATUS_DUPLICATE_OCCURRENCE_ID
                resolution.duplicate_ids = sorted(set(resolution.duplicate_ids) | {occurrence_id})
                resolution.note = f"occurrence_id {occurrence_id} 同时出现在多个清单项"
                resolution.occurrences = []
        for resolution in resolutions:
            gap = _gap(resolution, stage=self.stage)
            if gap is not None:
                self.gaps.append(gap)
        return resolutions

    def record(
        self,
        resolution: Optional[Resolution],
        *,
        status: str,
        issue_key: Optional[str] = None,
        matched_jira_key: Optional[str] = None,
        action: str = "",
        error: Optional[str] = None,
        extra: Optional[Mapping[str, Any]] = None,
    ) -> Dict[str, Any]:
        if resolution is None:
            return {}
        key = str(issue_key or matched_jira_key or "").strip()
        item: Dict[str, Any] = {
            "row": resolution.source_row,
            "workbook_row": resolution.workbook_row,
            "signature_id": resolution.signature_id,
            "occurrence_ids": resolution.occurrence_ids,
            "occurrence_keys": resolution.occurrence_keys,
            "attribution_status": resolution.status,
            "attribution_note": resolution.note,
            "status": status,
            "action": action,
            "issue_key": key or None,
            "matched_jira_key": str(matched_jira_key or "").strip() or None,
            "error": error or None,
        }
        if extra:
            item.update(dict(extra))
        self.items.append(item)
        if resolution.linkable and key and status in RESULT_STATUSES_WITH_KEY:
            for occurrence in resolution.occurrences:
                link_key = (occurrence.occurrence_id, key)
                if link_key in self._link_keys:
                    continue
                self._link_keys.add(link_key)
                self.links.append(
                    {
                        "issue_key": key,
                        "signature_id": occurrence.signature_id,
                        "occurrence_id": occurrence.occurrence_id,
                        "occurrence_key": occurrence.occurrence_key,
                        "evidence_source": "vendor_attribution_json",
                        "row": resolution.source_row,
                        "workbook_row": resolution.workbook_row,
                    }
                )
        return item

    def payload(self) -> Optional[Dict[str, Any]]:
        if self.index is None:
            return None
        return build_payload(
            stage=self.stage,
            index=self.index,
            items=self.items,
            links=self.links,
            gaps=self.gaps,
            run_id=self.run_id,
            workspace=self.workspace,
        )

    def write(self, path: Optional[str | Path] = None) -> Optional[Path]:
        payload = self.payload()
        if payload is None:
            return None
        target = Path(path) if path is not None else (self.workspace or Path.cwd()) / "attribution.json"
        return write_payload(target, payload)
