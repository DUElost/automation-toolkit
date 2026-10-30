# -*- coding: utf-8 -*-
from modules.analyse.tne.types.tne_base import TneBase
from modules.common.Logger import TEST_LOGGER

CLONE_STABILITY_RULES = {
    "0x0016000a": ("0x0016000a_连接失败", "0x0016000a"),
    "0x0016000b": ("0x0016000b_传输失败", "0x0016000b"),
}
CLONE_STABILITY_PACKAGE = "com.transsion.mobilecloner"
CLONE_STABILITY_TYPE = "CloneStability"


class TneCloneStability(TneBase):

    def __init__(self, path, tne_type=""):
        super(TneCloneStability, self).__init__(path)
        self._tne_tag = str(tne_type or "").strip().lower()
        exp_class, exp_type = CLONE_STABILITY_RULES.get(self._tne_tag, (self._tne_tag, self._tne_tag))
        self._exp_class = exp_class
        self._exp_type = exp_type
        self._cur_process = CLONE_STABILITY_PACKAGE
        self._package = CLONE_STABILITY_PACKAGE
        self._preserve_parse_fields = True

    def analyse(self):
        exp_class, exp_type = CLONE_STABILITY_RULES.get(self._tne_tag, (self._tne_tag, self._tne_tag))
        self._exp_class = exp_class
        self._exp_type = exp_type
        self._cur_process = CLONE_STABILITY_PACKAGE
        self._package = CLONE_STABILITY_PACKAGE
        from modules.analyse.tne.AnalyseTne import parse_tne_dir_timestamp
        time_tag_str = self.tne_dir_name.split("_", 1)[-1] if "_" in self.tne_dir_name else ""
        file_dt = parse_tne_dir_timestamp(time_tag_str)
        if file_dt:
            self._exp_time = file_dt.strftime("%Y-%m-%d %H:%M:%S")
        else:
            TEST_LOGGER.info("无法从目录名解析崩溃时间：{}".format(self.tne_dir_name), tag=self.tne_dir_name)
        sn = self._device_id or ""
        self._detail = "ExpClass: {}\nSN: {}".format(self._tne_tag, sn)
        return True
