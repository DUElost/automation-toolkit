import datetime
import os
from pathlib import Path

from modules.common.Excel import Excel, read_aee_rlt_excel
from modules.common.GlobalAttrs import SCAN_MODE_AEE
from modules.mode.BaseScan import ScanBase


class DedupOrgExcel(ScanBase):
    _SIDE_TO_CONFIG = {
        "shanghai": ("shanghai", "pkglist.txt"),
        "factory": ("factory", "pkglist_factory.txt"),
    }

    def __init__(self, org_excel_path, side="shanghai", config_dir=None):
        self._project_root = str(Path(__file__).resolve().parents[2])
        self._config_dir = self._resolve_config_dir(config_dir)
        super(DedupOrgExcel, self).__init__(
            SCAN_MODE_AEE,
            "SH",
            -1,
            None,
            self._project_root,
            True,
            True,
        )
        self._org_excel_path = os.path.abspath(org_excel_path)
        self._side = (side or "shanghai").strip().lower()

    def _scan(self):
        return

    def _get_scan_dir_failed(self, error_msg):
        return

    def _init_scan_attrs(self):
        return

    def _resolve_config_dir(self, config_dir):
        if config_dir:
            return os.path.abspath(config_dir)
        return os.path.join(self._project_root, "config")

    def _get_config_file_path(self, file_name):
        return os.path.join(self._config_dir, file_name)

    def _validate_input(self):
        if not os.path.isfile(self._org_excel_path):
            raise ValueError("org excel file does not exist")
        if os.path.splitext(self._org_excel_path)[1].lower() != ".xls":
            raise ValueError("org excel file must be .xls")
        file_name = os.path.basename(self._org_excel_path)
        if "_org" not in file_name:
            raise ValueError("org excel file name must contain _org")
        if self._side not in self._SIDE_TO_CONFIG:
            raise ValueError("unsupported side")

    def _prepare_context(self):
        self._is_network_connected = False
        self._scan_type, self._pkglist_file = self._SIDE_TO_CONFIG[self._side]
        self._pkglist = self._get_pkglist(
            self._scan_type, self._get_config_file_path(self._pkglist_file)
        )
        self._blacklist = self._get_blacklist(self._get_config_file_path(self._blacklist_file))
        self._report_history_list = self._get_report_history(
            self._get_config_file_path(self._report_history_file)
        )
        self._pkglist = self._pkglist or []
        self._blacklist = self._blacklist or []
        self._report_history_list = self._report_history_list or []

    def _build_output_path(self):
        timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
        file_name = os.path.splitext(os.path.basename(self._org_excel_path))[0]
        output_name = "{}_dedup_org_{}.xls".format(file_name, timestamp)
        return os.path.join(os.path.dirname(self._org_excel_path), output_name)

    def run(self):
        self._validate_input()
        self._prepare_context()
        aee_rlt_list = read_aee_rlt_excel(self._org_excel_path)
        _, aee_rlt_list_final, _ = self._aee_to_data_list(aee_rlt_list)
        output_path = self._build_output_path()
        excel = Excel(output_path)
        excel.insertResultAee(aee_rlt_list_final, deduplicated=True)
        return output_path
