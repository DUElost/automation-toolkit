# automation-toolkit PR 27 independent review evidence

Reviewed HEAD `24f86c895740ebf735533b1914047118fd6544de`, baseline `9fd2734edc5a77c770105965eaf61b9c20d18ba7`.

All Jira keys and source rows in this bundle are simulated. Binary Excel files are the files
emitted by the vendor CLI or saved during review, including positive and negative cases.
The generation wrapper replaces only the log-server access paragraph in PS with a fixed
test string. The batch wrapper swaps the Jira client with an offline substitute. The real
vendor entry points, matching, field construction, opened workbooks and result writers run
from the detached checkouts. No local Jira credentials or P12 files are required.

- `explicit` and `auto` hold the distinct declared scopes and reviewed workbooks, the
  actual attribution JSON and the result JSON/Excel. The explicit manifest is in `caller`.
- `negative` has the edited XLSX, output JSON and simulated create call log. Signature 75
  originally selected occurrence 501. Deleting its Occurrence IDs causes occurrence 502
  to be linked. The two copied rows with occurrence 801 make no create call.
- `excel-visibility-filter` has an Excel AutoFilter with the excluded row marked hidden.
  That row is processed by the current tools.
- `relative-caller` and the Tinno `observed-script-result` directories show the output path
  behavior actually observed. Files copied from the tool directory retain original names.
- `*-checks.json` includes independently computed expected and actual values.
- `*-commands.json` records the actual synthetic-case invocations and return codes.
- `harness/` contains the probes. Run from a disposable directory with detached checkouts
  named `head` and `base` at the commits above. Copy the probe files into that directory,
  install each vendor's requirements plus pytest, pytest-subtests and xlwt into a venv,
  then run `python review_cli.py transsion` and `python review_cli.py tinno`.
  Run `python relative_output.py <vendor>` after its corresponding main probe.
  The independent assertions report current mismatches with exit 1.

Local validation also used an existing production-format MonkeyAEE XLS with 22 signatures
and 145 counted events. The real source and generated files from it are excluded from
this public bundle. A manifest with simulated occurrence IDs was used for that local run.
