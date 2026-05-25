from __future__ import annotations

from contextlib import contextmanager
import json
import sqlite3
from pathlib import Path
from typing import Any, Dict, Iterable, Mapping, Optional


SNAPSHOT_COLUMNS = [
    "run_id",
    "jira_key",
    "summary",
    "status",
    "resolution",
    "fix_version",
    "build_version",
    "affect_project",
    "environment",
    "exp_class",
    "caused_by",
    "raw_payload",
]

ISSUE_STATE_COLUMNS = [
    "jira_key",
    "fingerprint",
    "status",
    "resolution",
    "fix_version",
    "build_version",
    "count",
    "open_seen_count",
    "regression_pass_count",
    "verified_versions",
    "last_seen_version",
    "updated_at",
]

EXECUTION_RESULT_COLUMNS = [
    "run_id",
    "row_number",
    "matched_jira_key",
    "fix_version",
    "action",
    "success",
    "manual_review",
    "reason",
    "result_message",
    "created_at",
]

SYNC_RUN_COLUMNS = [
    "run_id",
    "started_at",
    "finished_at",
    "jql",
    "current_version",
]


class RegressionStore:
    def __init__(self, db_path: str | Path):
        self.db_path = Path(db_path)
        self.db_path.parent.mkdir(parents=True, exist_ok=True)
        self._init_db()

    def _connect(self) -> sqlite3.Connection:
        conn = sqlite3.connect(self.db_path)
        conn.row_factory = sqlite3.Row
        return conn

    @contextmanager
    def _session(self):
        conn = self._connect()
        try:
            yield conn
            conn.commit()
        except Exception:
            conn.rollback()
            raise
        finally:
            conn.close()

    def _init_db(self) -> None:
        with self._session() as conn:
            cursor = conn.cursor()
            cursor.execute(
                """
                CREATE TABLE IF NOT EXISTS jira_issue_snapshot (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    run_id TEXT NOT NULL,
                    jira_key TEXT NOT NULL,
                    summary TEXT,
                    status TEXT,
                    resolution TEXT,
                    fix_version TEXT,
                    build_version TEXT,
                    affect_project TEXT,
                    environment TEXT,
                    exp_class TEXT,
                    caused_by TEXT,
                    raw_payload TEXT
                )
                """
            )
            cursor.execute(
                """
                CREATE TABLE IF NOT EXISTS issue_state (
                    jira_key TEXT PRIMARY KEY,
                    fingerprint TEXT,
                    status TEXT,
                    resolution TEXT,
                    fix_version TEXT,
                    build_version TEXT,
                    count INTEGER DEFAULT 0,
                    open_seen_count INTEGER DEFAULT 0,
                    regression_pass_count INTEGER DEFAULT 0,
                    verified_versions TEXT DEFAULT '[]',
                    last_seen_version TEXT,
                    updated_at TEXT DEFAULT CURRENT_TIMESTAMP
                )
                """
            )
            cursor.execute(
                """
                CREATE TABLE IF NOT EXISTS execution_results (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    run_id TEXT NOT NULL,
                    row_number INTEGER,
                    matched_jira_key TEXT,
                    fix_version TEXT,
                    action TEXT,
                    success INTEGER,
                    manual_review INTEGER,
                    reason TEXT,
                    result_message TEXT,
                    created_at TEXT DEFAULT CURRENT_TIMESTAMP
                )
                """
            )
            cursor.execute(
                """
                CREATE TABLE IF NOT EXISTS sync_runs (
                    run_id TEXT PRIMARY KEY,
                    started_at TEXT,
                    finished_at TEXT,
                    jql TEXT,
                    current_version TEXT
                )
                """
            )
            self._ensure_column(cursor, "jira_issue_snapshot", "build_version", "TEXT")
            self._ensure_column(cursor, "issue_state", "build_version", "TEXT")

    def _ensure_column(self, cursor: sqlite3.Cursor, table_name: str, column_name: str, column_sql: str) -> None:
        cursor.execute(f"PRAGMA table_info({table_name})")
        existing_columns = {str(row[1]).strip() for row in cursor.fetchall()}
        if column_name in existing_columns:
            return
        cursor.execute(f"ALTER TABLE {table_name} ADD COLUMN {column_name} {column_sql}")

    def save_snapshot(self, run_id: str, rows: Iterable[Mapping[str, Any]]) -> None:
        with self._session() as conn:
            cursor = conn.cursor()
            for row in rows:
                jira_key = str(row.get("jira_key", "")).strip()
                if not jira_key:
                    raise ValueError("jira_key 不能为空")
                cursor.execute(
                    """
                    INSERT INTO jira_issue_snapshot (
                        run_id, jira_key, summary, status, resolution, fix_version, build_version,
                        affect_project, environment, exp_class, caused_by, raw_payload
                    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                    """,
                    [
                        run_id,
                        jira_key,
                        row.get("summary"),
                        row.get("status"),
                        row.get("resolution"),
                        row.get("fix_version"),
                        row.get("build_version"),
                        row.get("affect_project"),
                        row.get("environment"),
                        row.get("exp_class"),
                        row.get("caused_by"),
                        row.get("raw_payload"),
                    ],
                )

    def fetch_snapshot_by_run(self, run_id: str) -> list[Dict[str, Any]]:
        with self._session() as conn:
            cursor = conn.cursor()
            cursor.execute(
                """
                SELECT run_id, jira_key, summary, status, resolution, fix_version, build_version,
                       affect_project, environment, exp_class, caused_by, raw_payload
                FROM jira_issue_snapshot
                WHERE run_id = ?
                ORDER BY id
                """,
                (run_id,),
            )
            return [dict(row) for row in cursor.fetchall()]

    def upsert_issue_state(self, record: Mapping[str, Any]) -> None:
        jira_key = str(record.get("jira_key", "")).strip()
        if not jira_key:
            raise ValueError("jira_key 不能为空")

        with self._session() as conn:
            cursor = conn.cursor()
            cursor.execute(
                """
                SELECT jira_key, fingerprint, status, resolution, fix_version, build_version, count,
                       open_seen_count, regression_pass_count, verified_versions,
                       last_seen_version, updated_at
                FROM issue_state
                WHERE jira_key = ?
                """,
                (jira_key,),
            )
            existing = cursor.fetchone()
            merged = self._merge_issue_state(existing, record)
            cursor.execute(
                """
                INSERT INTO issue_state (
                    jira_key, fingerprint, status, resolution, fix_version, build_version, count,
                    open_seen_count, regression_pass_count, verified_versions,
                    last_seen_version, updated_at
                ) VALUES (
                    ?, ?, ?, ?, ?, ?,
                    COALESCE(?, 0),
                    COALESCE(?, 0),
                    COALESCE(?, 0),
                    COALESCE(?, '[]'),
                    ?,
                    COALESCE(?, CURRENT_TIMESTAMP)
                )
                ON CONFLICT(jira_key) DO UPDATE SET
                    fingerprint = excluded.fingerprint,
                    status = excluded.status,
                    resolution = excluded.resolution,
                    fix_version = excluded.fix_version,
                    build_version = excluded.build_version,
                    count = excluded.count,
                    open_seen_count = excluded.open_seen_count,
                    regression_pass_count = excluded.regression_pass_count,
                    verified_versions = excluded.verified_versions,
                    last_seen_version = excluded.last_seen_version,
                    updated_at = excluded.updated_at
                """,
                [
                    merged["jira_key"],
                    merged["fingerprint"],
                    merged["status"],
                    merged["resolution"],
                    merged["fix_version"],
                    merged["build_version"],
                    merged["count"],
                    merged["open_seen_count"],
                    merged["regression_pass_count"],
                    merged["verified_versions"],
                    merged["last_seen_version"],
                    merged["updated_at"],
                ],
            )

    def fetch_issue_state(self, jira_key: str) -> Optional[Dict[str, Any]]:
        with self._session() as conn:
            cursor = conn.cursor()
            cursor.execute(
                """
                SELECT jira_key, fingerprint, status, resolution, fix_version, build_version, count,
                       open_seen_count, regression_pass_count, verified_versions,
                       last_seen_version, updated_at
                FROM issue_state
                WHERE jira_key = ?
                """,
                (jira_key,),
            )
            row = cursor.fetchone()
            return dict(row) if row else None

    def save_execution_result(self, result: Mapping[str, Any]) -> None:
        has_created_at = result.get("created_at") is not None
        columns = EXECUTION_RESULT_COLUMNS if has_created_at else EXECUTION_RESULT_COLUMNS[:-1]
        placeholders = ", ".join("?" for _ in columns)
        sql = f"""
            INSERT INTO execution_results (
                {", ".join(columns)}
            ) VALUES (
                {placeholders}
            )
        """
        values = [result.get(column) for column in columns]

        with self._session() as conn:
            cursor = conn.cursor()
            cursor.execute(sql, values)

    def fetch_execution_results_by_run(self, run_id: str) -> list[Dict[str, Any]]:
        with self._session() as conn:
            cursor = conn.cursor()
            cursor.execute(
                """
                SELECT run_id, row_number, matched_jira_key, fix_version, action,
                       success, manual_review, reason, result_message, created_at
                FROM execution_results
                WHERE run_id = ?
                ORDER BY id
                """,
                (run_id,),
            )
            return [dict(row) for row in cursor.fetchall()]

    def fetch_regression_pass_candidates(
        self,
        run_id: str,
        resolved_statuses: Iterable[str],
        resolved_fixed_resolutions: Iterable[str],
        excluded_jira_keys: Iterable[str] | None = None,
    ) -> list[Dict[str, Any]]:
        status_list = [str(item).strip() for item in resolved_statuses if str(item).strip()]
        resolution_list = [str(item).strip() for item in resolved_fixed_resolutions if str(item).strip()]
        excluded_list = [str(item).strip() for item in (excluded_jira_keys or []) if str(item).strip()]
        if not status_list or not resolution_list:
            return []

        sql = """
            SELECT run_id, jira_key, summary, status, resolution, fix_version, build_version,
                   affect_project, environment, exp_class, caused_by, raw_payload
            FROM jira_issue_snapshot
            WHERE run_id = ?
              AND status IN ({status_placeholders})
              AND resolution IN ({resolution_placeholders})
        """
        params: list[Any] = [run_id, *status_list, *resolution_list]
        if excluded_list:
            sql += f" AND jira_key NOT IN ({', '.join('?' for _ in excluded_list)})"
            params.extend(excluded_list)
        sql += " ORDER BY id"

        with self._session() as conn:
            cursor = conn.cursor()
            cursor.execute(
                sql.format(
                    status_placeholders=", ".join("?" for _ in status_list),
                    resolution_placeholders=", ".join("?" for _ in resolution_list),
                ),
                params,
            )
            return [dict(row) for row in cursor.fetchall()]

    def save_sync_run(self, run: Mapping[str, Any]) -> None:
        run_id = str(run.get("run_id", "")).strip()
        if not run_id:
            raise ValueError("run_id 不能为空")
        with self._session() as conn:
            cursor = conn.cursor()
            cursor.execute(
                """
                SELECT run_id, started_at, finished_at, jql, current_version
                FROM sync_runs
                WHERE run_id = ?
                """,
                (run_id,),
            )
            existing = cursor.fetchone()
            merged = self._merge_sync_run(existing, run)
            cursor.execute(
                """
                INSERT INTO sync_runs (
                    run_id, started_at, finished_at, jql, current_version
                ) VALUES (?, ?, ?, ?, ?)
                ON CONFLICT(run_id) DO UPDATE SET
                    started_at = excluded.started_at,
                    finished_at = excluded.finished_at,
                    jql = excluded.jql,
                    current_version = excluded.current_version
                """,
                [merged.get(column) for column in SYNC_RUN_COLUMNS],
            )

    def fetch_sync_run(self, run_id: str) -> Optional[Dict[str, Any]]:
        with self._session() as conn:
            cursor = conn.cursor()
            cursor.execute(
                """
                SELECT run_id, started_at, finished_at, jql, current_version
                FROM sync_runs
                WHERE run_id = ?
                """,
                (run_id,),
            )
            row = cursor.fetchone()
            return dict(row) if row else None

    def record_regression_pass(
        self,
        jira_key: str,
        current_version: str,
        new_pass_count: int,
        *,
        status: Any = None,
        resolution: Any = None,
        fix_version: Any = None,
        build_version: Any = None,
        updated_at: Any = None,
    ) -> None:
        existing = self.fetch_issue_state(jira_key) or {}
        verified_versions = self._decode_verified_versions(existing.get("verified_versions"))
        current_version_text = str(current_version or "").strip()
        if current_version_text and current_version_text not in verified_versions:
            verified_versions.append(current_version_text)
        self.upsert_issue_state(
            {
                "jira_key": jira_key,
                "status": status if status is not None else existing.get("status"),
                "resolution": resolution if resolution is not None else existing.get("resolution"),
                "fix_version": fix_version if fix_version is not None else existing.get("fix_version"),
                "build_version": build_version if build_version is not None else existing.get("build_version"),
                "regression_pass_count": int(new_pass_count or 0),
                "verified_versions": verified_versions,
                "last_seen_version": current_version_text or existing.get("last_seen_version"),
                "updated_at": updated_at,
            }
        )

    def _merge_issue_state(
        self,
        existing: Optional[sqlite3.Row],
        record: Mapping[str, Any],
    ) -> Dict[str, Any]:
        base = dict(existing) if existing else {
            "jira_key": None,
            "fingerprint": None,
            "status": None,
            "resolution": None,
            "fix_version": None,
            "build_version": None,
            "count": 0,
            "open_seen_count": 0,
            "regression_pass_count": 0,
            "verified_versions": "[]",
            "last_seen_version": None,
            "updated_at": None,
        }
        merged = dict(base)
        for key in base:
            if key in record:
                value = record[key]
                if key == "verified_versions":
                    merged[key] = self._normalize_verified_versions(value)
                else:
                    merged[key] = value
        if existing is None:
            if merged["verified_versions"] is None:
                merged["verified_versions"] = "[]"
            if merged["updated_at"] is None:
                merged["updated_at"] = None
        else:
            if "verified_versions" not in record:
                merged["verified_versions"] = base["verified_versions"]
            if "updated_at" not in record:
                merged["updated_at"] = base["updated_at"]
        return merged

    def _merge_sync_run(
        self,
        existing: Optional[sqlite3.Row],
        record: Mapping[str, Any],
    ) -> Dict[str, Any]:
        base = dict(existing) if existing else {
            "run_id": None,
            "started_at": None,
            "finished_at": None,
            "jql": None,
            "current_version": None,
        }
        merged = dict(base)
        for key in base:
            if key in record:
                merged[key] = record[key]
        return merged

    def _normalize_verified_versions(self, value: Any) -> Optional[str]:
        if value is None:
            return None
        if isinstance(value, (list, tuple)):
            return json.dumps(list(value), ensure_ascii=True)
        if isinstance(value, str):
            parsed = json.loads(value)
            if isinstance(parsed, (list, tuple)):
                return json.dumps(list(parsed), ensure_ascii=True)
            return json.dumps(parsed, ensure_ascii=True)
        raise ValueError("verified_versions 必须是 JSON 字符串或列表")

    def _decode_verified_versions(self, value: Any) -> list[str]:
        if value is None:
            return []
        if isinstance(value, str):
            text = value.strip()
            if not text:
                return []
            if text.startswith("["):
                parsed = json.loads(text)
                if isinstance(parsed, list):
                    return [str(item).strip() for item in parsed if str(item).strip()]
                normalized = str(parsed).strip()
                return [normalized] if normalized else []
            return [item.strip() for item in text.split(",") if item.strip()]
        if isinstance(value, (list, tuple)):
            return [str(item).strip() for item in value if str(item).strip()]
        normalized = str(value).strip()
        return [normalized] if normalized else []
