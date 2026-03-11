# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\aee\files\sys_kernel_log.py
import os
from modules.common.Logger import TEST_LOGGER

class SysKernelLog(object):

    def __init__(self, file_path):
        super(SysKernelLog, self).__init__()
        self._SysKernelLog__file_path = file_path
        self._SysKernelLog__aee_dir = os.path.dirname(file_path)
        self._SysKernelLog__aee_dir_name = os.path.basename(self._SysKernelLog__aee_dir)

    def is_invalid_issue(self):
        TEST_LOGGER.debug("开始在 SYS_KERNEL_LOG 中检查该问题是否需要忽略", tag=(self._SysKernelLog__aee_dir_name))
        ScnTimeoutCount = False
        halHifPowerOffWifi = False
        no_packet_for_sending_new_probe_response = False
        no_packet_for_sending_new_probe_response_more = False
        mtk_p2p_cfg80211_mgmt_tx = False
        mgmt_frame_tx_fail = False
        waiting_for_power_off = False
        halIsTxHang = False
        with open(self._SysKernelLog__file_path, "rb") as f:
            for line in f:
                if halHifPowerOffWifi:
                    if no_packet_for_sending_new_probe_response or mtk_p2p_cfg80211_mgmt_tx:
                        if no_packet_for_sending_new_probe_response_more:
                            break
                    line = line.decode(encoding="utf-8", errors="ignore").strip()
                    if "ScnTimeoutCount(3)" in line:
                        ScnTimeoutCount = True
                        break
                    if "halHifPowerOffWifi" in line:
                        halHifPowerOffWifi = True
                    if "No packet for sending new probe response" in line:
                        no_packet_for_sending_new_probe_response = True
                    if "p2pFuncProcessP2pProbeRsp:(P2P WARN) No packet for sending new probe response" in line:
                        no_packet_for_sending_new_probe_response_more = True
                        no_packet_for_sending_new_probe_response = True
                    if "mtk_p2p_cfg80211_mgmt_tx:(P2P ERROR) Allocate TX packet fails" in line:
                        mtk_p2p_cfg80211_mgmt_tx = True
                    if "Mgmt Frame TX Fail" in line:
                        mgmt_frame_tx_fail = True
                    if "Waiting for power off: Timeout" in line:
                        waiting_for_power_off = True
                    if "halIsTxHang" in line:
                        halIsTxHang = True

        return ScnTimeoutCount or halHifPowerOffWifi and no_packet_for_sending_new_probe_response or halHifPowerOffWifi and waiting_for_power_off or mtk_p2p_cfg80211_mgmt_tx and no_packet_for_sending_new_probe_response_more or mgmt_frame_tx_fail and waiting_for_power_off or halIsTxHang and waiting_for_power_off

# okay decompiling extracted_pyz_modules\modules\analyse\aee\files\sys_kernel_log.pyc
