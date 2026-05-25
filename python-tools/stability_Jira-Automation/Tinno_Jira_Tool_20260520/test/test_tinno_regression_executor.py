import sys
import unittest
from pathlib import Path


TOOL_DIR = Path(__file__).resolve().parent.parent
if str(TOOL_DIR) not in sys.path:
    sys.path.insert(0, str(TOOL_DIR))

import tinno_regression_executor as executor


class TinnoRegressionExecutorTest(unittest.TestCase):
    def test_strict_version_compare_only_applies_to_projects_from_config(self) -> None:
        decision = executor.decide_action(
            current_row={"project": "VFFCA"},
            history={
                "status": "Resolved",
                "resolution": "完成",
                "fix_version": "MLD-LX2-16-260521V5",
                "build_version": "MLD-LX2-16-260512V2",
                "affect_project": "VFFCA",
            },
            current_version="MLD-LX2-16-260511V1",
            strict_version_project_keys=[],
        )

        self.assertEqual("RESOLVED_FIXED_WAIT_NEW_VERSION", decision.action)

    def test_vffca_strict_version_chain_decision_boundaries(self) -> None:
        history = {
            "status": "Resolved",
            "resolution": "完成",
            "fix_version": "MLD-LX2-16-260521V5",
            "build_version": "MLD-LX2-16-260512V2",
            "affect_project": "VFFCA",
        }
        cases = [
            ("MLD-LX2-16-260511V1", "MANUAL_REVIEW"),
            ("MLD-LX2-16-260512V2", "RESOLVED_FIXED_WAIT_NEW_VERSION"),
            ("MLD-LX2-16-260518V3", "RESOLVED_FIXED_WAIT_NEW_VERSION"),
            ("MLD-LX2-16-260521V5", "MANUAL_REVIEW"),
            ("MLD-LX2-16-260523V6", "MANUAL_REVIEW"),
        ]

        for current_version, expected_action in cases:
            with self.subTest(current_version=current_version):
                decision = executor.decide_action(
                    current_row={"project": "VFFCA"},
                    history=history,
                    current_version=current_version,
                    strict_version_project_keys=["VFFCA"],
                )
                self.assertEqual(expected_action, decision.action)

    def test_vffca_resolved_fixed_waits_for_new_version_when_between_build_and_fix(self) -> None:
        decision = executor.decide_action(
            current_row={"project": "VFFCA"},
            history={
                "status": "Resolved",
                "resolution": "完成",
                "fix_version": "V552AA-16-260515V25",
                "build_version": "V552AA-16-260511V17",
                "affect_project": "VFFCA",
            },
            current_version="V552AA-16-260513V18",
            strict_version_project_keys=["VFFCA"],
        )

        self.assertEqual("RESOLVED_FIXED_WAIT_NEW_VERSION", decision.action)
        self.assertFalse(decision.manual_review)

    def test_vffca_resolved_fixed_requires_build_version(self) -> None:
        decision = executor.decide_action(
            current_row={"project": "VFFCA"},
            history={
                "status": "Resolved",
                "resolution": "完成",
                "fix_version": "V552AA-16-260515V25",
                "build_version": "",
                "affect_project": "VFFCA",
            },
            current_version="V552AA-16-260513V18",
            strict_version_project_keys=["VFFCA"],
        )

        self.assertEqual("MANUAL_REVIEW", decision.action)
        self.assertTrue(decision.manual_review)

    def test_vffca_resolved_fixed_requires_current_version_not_earlier_than_build(self) -> None:
        decision = executor.decide_action(
            current_row={"project": "VFFCA"},
            history={
                "status": "Resolved",
                "resolution": "完成",
                "fix_version": "V552AA-16-260515V25",
                "build_version": "V552AA-16-260511V17",
                "affect_project": "VFFCA",
            },
            current_version="V552AA-16-260504V4",
            strict_version_project_keys=["VFFCA"],
        )

        self.assertEqual("MANUAL_REVIEW", decision.action)
        self.assertTrue(decision.manual_review)

    def test_vffca_resolved_fixed_requires_fix_version_after_build_version(self) -> None:
        decision = executor.decide_action(
            current_row={"project": "VFFCA"},
            history={
                "status": "Resolved",
                "resolution": "完成",
                "fix_version": "V552AA-16-260511V17",
                "build_version": "V552AA-16-260511V17",
                "affect_project": "VFFCA",
            },
            current_version="V552AA-16-260513V18",
            strict_version_project_keys=["VFFCA"],
        )

        self.assertEqual("MANUAL_REVIEW", decision.action)

    def test_vffca_resolved_fixed_returns_manual_review_when_current_version_reaches_fix(self) -> None:
        decision = executor.decide_action(
            current_row={"project": "VFFCA"},
            history={
                "status": "Resolved",
                "resolution": "完成",
                "fix_version": "V552AA-16-260515V25",
                "build_version": "V552AA-16-260511V17",
                "affect_project": "VFFCA",
            },
            current_version="V552AA-16-260521V37",
            strict_version_project_keys=["VFFCA"],
        )

        self.assertEqual("MANUAL_REVIEW", decision.action)
        self.assertTrue(decision.manual_review)

    def test_in_progress_is_treated_as_open_like(self) -> None:
        decision = executor.decide_action(
            current_row={"project": "VFFCA"},
            history={"status": "In Progress", "resolution": "", "fix_version": ""},
            current_version="V552AA-16-260521V37",
        )

        self.assertEqual("OPEN_LIKE_UPDATE", decision.action)
        self.assertTrue(decision.update_jira)

    def test_non_strict_project_keeps_legacy_resolved_behavior(self) -> None:
        decision = executor.decide_action(
            current_row={"project": "VCAME"},
            history={
                "status": "已解决",
                "resolution": "完成",
                "fix_version": "P2",
                "build_version": "",
                "affect_project": "VCAME",
            },
            current_version="P1",
        )

        self.assertEqual("RESOLVED_FIXED_WAIT_NEW_VERSION", decision.action)

    def test_regression_pass_skip_when_build_version_missing_for_vffca(self) -> None:
        decision = executor.evaluate_regression_pass(
            pass_count=0,
            required_versions=2,
            current_version="V552AA-16-260521V37",
            fix_version="V552AA-16-260515V25",
            already_verified=[],
            build_version="",
            project_key="VFFCA",
            strict_version_project_keys=["VFFCA"],
        )

        self.assertEqual("REGRESSION_PASS_SKIP", decision.action)
        self.assertEqual("BUILD_VERSION_EMPTY", decision.reason)

    def test_regression_pass_skip_when_current_version_before_build_version_for_vffca(self) -> None:
        decision = executor.evaluate_regression_pass(
            pass_count=0,
            required_versions=2,
            current_version="V552AA-16-260504V4",
            fix_version="V552AA-16-260515V25",
            already_verified=[],
            build_version="V552AA-16-260511V17",
            project_key="VFFCA",
            strict_version_project_keys=["VFFCA"],
        )

        self.assertEqual("REGRESSION_PASS_SKIP", decision.action)
        self.assertEqual("CURRENT_VERSION_BEFORE_BUILD_VERSION", decision.reason)

    def test_regression_pass_close_when_vffca_version_chain_is_valid(self) -> None:
        decision = executor.evaluate_regression_pass(
            pass_count=1,
            required_versions=2,
            current_version="V552AA-16-260521V37",
            fix_version="V552AA-16-260515V25",
            already_verified=["V552AA-16-260519V22"],
            build_version="V552AA-16-260511V17",
            project_key="VFFCA",
            strict_version_project_keys=["VFFCA"],
        )

        self.assertEqual("REGRESSION_PASS_CLOSE", decision.action)
        self.assertTrue(decision.close_issue)

    def test_vffca_strict_version_chain_regression_pass_boundaries(self) -> None:
        cases = [
            ("MLD-LX2-16-260511V1", 0, [], "REGRESSION_PASS_SKIP", "CURRENT_VERSION_BEFORE_BUILD_VERSION"),
            ("MLD-LX2-16-260512V2", 0, [], "REGRESSION_PASS_SKIP", "CURRENT_VERSION_BEFORE_FIX_VERSION"),
            ("MLD-LX2-16-260518V3", 0, [], "REGRESSION_PASS_SKIP", "CURRENT_VERSION_BEFORE_FIX_VERSION"),
            ("MLD-LX2-16-260521V5", 0, [], "REGRESSION_PASS_PROGRESS", ""),
            ("MLD-LX2-16-260523V6", 1, ["MLD-LX2-16-260521V5"], "REGRESSION_PASS_CLOSE", ""),
        ]

        for current_version, pass_count, verified_versions, expected_action, expected_reason in cases:
            with self.subTest(current_version=current_version):
                decision = executor.evaluate_regression_pass(
                    pass_count=pass_count,
                    required_versions=2,
                    current_version=current_version,
                    fix_version="MLD-LX2-16-260521V5",
                    already_verified=verified_versions,
                    build_version="MLD-LX2-16-260512V2",
                    project_key="VFFCA",
                    strict_version_project_keys=["VFFCA"],
                )
                self.assertEqual(expected_action, decision.action)
                self.assertEqual(expected_reason, decision.reason)


if __name__ == "__main__":
    unittest.main()
