"""Local Jira simulator for offline similarity and regression experiments.

This module provides in-memory representations of Jira issues and helper
functions to mimic a subset of Jira behaviours without talking to the real
server. It is designed to support experimenting with the similarity →
create/update → regression pipeline while keeping all artefacts local.
"""

from __future__ import annotations

from dataclasses import dataclass, field
from datetime import datetime
from typing import Dict, List, Optional, Tuple

from difflib import SequenceMatcher


ENV_SIMILARITY_THRESHOLD = 0.99
CAUSE_SIMILARITY_THRESHOLD = 0.90


@dataclass
class IssueRecord:
    """Simplified representation of a Jira issue used for local simulation."""

    key: str
    summary: str
    environment: str
    caused_by: str
    module: str
    status: str
    affect_project: str
    labels: List[str] = field(default_factory=list)
    bug_severity: str = "SWT"
    assignee: Optional[str] = None
    priority: Optional[str] = None
    history: List[str] = field(default_factory=list)

    def log(self, message: str) -> None:
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        entry = f"[{timestamp}] {message}"
        self.history.append(entry)


class LocalJiraSimulator:
    """In-memory Jira interface supporting similarity checks and transitions."""

    def __init__(self, project_key: str) -> None:
        self.project_key = project_key
        self._issues: Dict[str, IssueRecord] = {}
        self._counter = 1000

    # ------------------------------------------------------------------
    # Similarity helpers
    # ------------------------------------------------------------------
    def _similarity(self, a: str, b: str) -> float:
        if not a or not b:
            return 0.0
        return SequenceMatcher(None, a, b).ratio()

    def query_similar(self, environment: str, caused_by: str) -> List[Tuple[IssueRecord, float, float]]:
        """Return existing issues with similarity scores."""

        matches: List[Tuple[IssueRecord, float, float]] = []
        for issue in self._issues.values():
            env_score = self._similarity(environment, issue.environment)
            cause_score = self._similarity(caused_by, issue.caused_by)
            matches.append((issue, env_score, cause_score))
        matches.sort(key=lambda item: (item[1], item[2]), reverse=True)
        return matches

    # ------------------------------------------------------------------
    # CRUD operations
    # ------------------------------------------------------------------
    def seed_issue(
        self,
        key: str,
        summary: str,
        environment: str,
        caused_by: str,
        module: str,
        affect_project: str,
        status: str = "Open",
        labels: Optional[List[str]] = None,
        bug_severity: str = "SWT",
        assignee: Optional[str] = None,
        priority: Optional[str] = None,
    ) -> IssueRecord:
        """Insert a pre-existing issue into the simulator state."""

        record = IssueRecord(
            key=key,
            summary=summary,
            environment=environment,
            caused_by=caused_by,
            module=module,
            status=status,
            affect_project=affect_project,
            labels=list(labels or []),
            bug_severity=bug_severity,
            assignee=assignee,
            priority=priority,
        )
        record.log("Seeded into simulator")
        self._issues[key] = record
        try:
            numeric_part = int(key.split("-")[-1])
            self._counter = max(self._counter, numeric_part)
        except ValueError:
            pass
        return record

    def create_issue(
        self,
        summary: str,
        environment: str,
        caused_by: str,
        module: str,
        affect_project: str,
        bug_severity: str = "SWT",
        assignee: Optional[str] = None,
        priority: Optional[str] = None,
    ) -> IssueRecord:
        self._counter += 1
        key = f"{self.project_key}-{self._counter}"
        record = IssueRecord(
            key=key,
            summary=summary,
            environment=environment,
            caused_by=caused_by,
            module=module,
            status="Open",
            affect_project=affect_project,
            labels=["LOCAL"],
            bug_severity=bug_severity,
            assignee=assignee,
            priority=priority,
        )
        record.log("Issue created")
        self._issues[key] = record
        return record

    def update_issue(
        self,
        key: str,
        summary: Optional[str] = None,
        caused_by: Optional[str] = None,
        module: Optional[str] = None,
        bug_severity: Optional[str] = None,
        assignee: Optional[str] = None,
        priority: Optional[str] = None,
    ) -> IssueRecord:
        record = self._ensure_issue(key)
        updates = []
        if summary and summary != record.summary:
            record.summary = summary
            updates.append("summary")
        if caused_by and caused_by != record.caused_by:
            record.caused_by = caused_by
            updates.append("caused_by")
        if module and module != record.module:
            record.module = module
            updates.append("module")
        if bug_severity and bug_severity != record.bug_severity:
            record.bug_severity = bug_severity
            updates.append("bug_severity")
        if assignee and assignee != record.assignee:
            record.assignee = assignee
            updates.append("assignee")
        if priority and priority != record.priority:
            record.priority = priority
            updates.append("priority")
        if updates:
            record.log(f"Fields updated: {', '.join(updates)}")
        return record

    def transition_issue(self, key: str, new_status: str, comment: Optional[str] = None) -> IssueRecord:
        record = self._ensure_issue(key)
        old_status = record.status
        record.status = new_status
        record.log(f"Status: {old_status} -> {new_status}")
        if comment:
            record.log(f"Comment: {comment}")
        return record

    def all_issues(self) -> List[IssueRecord]:
        return list(self._issues.values())

    # ------------------------------------------------------------------
    # Regression logic
    # ------------------------------------------------------------------
    def regression_pass(self, required_cycles: int = 2) -> List[IssueRecord]:
        """Close issues that have sufficient verification cycles.

        For the local simulation we treat the number of "reopen" entries in the
        history as a proxy for regression attempts. If an issue is currently in
        Resolved/Verified and has at least ``required_cycles`` reopen logs, we
        mark it as Closed.
        """

        closed: List[IssueRecord] = []
        for issue in self._issues.values():
            if issue.status not in {"Resolved", "Verified"}:
                continue
            reopen_events = sum(1 for h in issue.history if "Status: Closed -> Reopen" in h)
            if reopen_events >= required_cycles:
                self.transition_issue(issue.key, "Closed", comment="Auto-closed by regression_pass")
                closed.append(issue)
        return closed

    # ------------------------------------------------------------------
    # Internal helpers
    # ------------------------------------------------------------------
    def _ensure_issue(self, key: str) -> IssueRecord:
        if key not in self._issues:
            raise KeyError(f"Issue {key} does not exist in local simulator")
        return self._issues[key]


def decide_action(
    simulator: LocalJiraSimulator,
    summary: str,
    environment: str,
    caused_by: str,
    module: str,
    affect_project: str,
    bug_severity: Optional[str] = None,
    assignee: Optional[str] = None,
    priority: Optional[str] = None,
    env_threshold: float = ENV_SIMILARITY_THRESHOLD,
    cause_threshold: float = CAUSE_SIMILARITY_THRESHOLD,
) -> Tuple[IssueRecord, str, float, float]:
    """Decide whether to create a new issue or update an existing one.

    Returns ``(issue_record, action, env_similarity, cause_similarity)`` where
    ``action`` ∈ {``create``, ``update``, ``reopen``}.
    """

    candidates = simulator.query_similar(environment, caused_by)
    if candidates:
        top_issue, env_score, cause_score = candidates[0]
        if env_score >= env_threshold and cause_score >= cause_threshold:
            simulator.update_issue(
                top_issue.key,
                summary=summary,
                caused_by=caused_by,
                module=module,
                bug_severity=bug_severity,
                assignee=assignee,
                priority=priority,
            )
            if top_issue.status in {"Closed", "Resolved"}:
                simulator.transition_issue(top_issue.key, "Reopen", comment="Reopened due to new evidence")
                action = "reopen"
            else:
                action = "update"
            return top_issue, action, env_score, cause_score
    issue = simulator.create_issue(
        summary,
        environment,
        caused_by,
        module,
        affect_project,
        bug_severity=bug_severity or "SWT",
        assignee=assignee,
        priority=priority,
    )
    return issue, "create", 0.0, 0.0


