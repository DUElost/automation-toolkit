package com.mediatek.schpwronoff.powercycle;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

import com.mediatek.schpwronoff.utils.LogUtil;

/**
 * 真关机模式下的定时唤醒 + 看门狗续跑（对齐 MTBF MtbfAutoResumeReceiver 思路）。
 */
public class PowerCycleAutoResumeReceiver extends BroadcastReceiver {

    public static final String ACTION_ALARM_WAKE = "com.tinno.autotesttool.action.POWER_CYCLE_ALARM_WAKE";
    public static final String ACTION_KEEPALIVE = "com.tinno.autotesttool.action.POWER_CYCLE_KEEPALIVE";

    private static final String TAG = "PowerCycleAutoResume";

    @Override
    public void onReceive(Context context, Intent intent) {
        if (intent == null || intent.getAction() == null) {
            return;
        }
        String action = intent.getAction();
        if (!PowerCyclePrefs.isRunning(context) || !PowerCyclePrefs.isAutoResume(context)) {
            return;
        }

        LogUtil.i(TAG, "onReceive " + action);
        Intent service = new Intent(context, PowerCycleService.class);
        service.setAction(PowerCycleService.ACTION_START);
        context.startForegroundService(service);
    }
}
