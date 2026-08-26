package com.mediatek.schpwronoff.powercycle;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Handler;
import android.os.Looper;

import com.mediatek.schpwronoff.utils.LogUtil;

/**
 * 真关机模式下的定时唤醒 + 看门狗续跑（对齐 MTBF MtbfAutoResumeReceiver 思路）。
 */
public class PowerCycleAutoResumeReceiver extends BroadcastReceiver {

    public static final String ACTION_ALARM_WAKE = "com.tinno.autotesttool.action.POWER_CYCLE_ALARM_WAKE";
    public static final String ACTION_KEEPALIVE = "com.tinno.autotesttool.action.POWER_CYCLE_KEEPALIVE";

    private static final String TAG = "PowerCycleAutoResume";
    private static final long RESUME_UI_DELAY_MS = 800L;

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
        final Context app = context.getApplicationContext();
        Intent service = new Intent(app, PowerCycleService.class);
        service.setAction(PowerCycleService.ACTION_START);
        app.startForegroundService(service);

        new Handler(Looper.getMainLooper()).postDelayed(
                () -> PowerCycleActivity.bringToFront(app), RESUME_UI_DELAY_MS);
    }
}
