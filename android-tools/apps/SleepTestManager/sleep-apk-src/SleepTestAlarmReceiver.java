package com.mediatek.schpwronoff.sleeptest;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

import com.mediatek.schpwronoff.utils.LogUtil;

/**
 * 灭屏后定时唤醒：先拉起透明 WakeUpActivity 请求系统亮屏。
 */
public class SleepTestAlarmReceiver extends BroadcastReceiver {

    public static final String ACTION_ALARM_WAKE = "com.tinno.autotesttool.action.SLEEP_TEST_ALARM_WAKE";

    private static final String TAG = "SleepTestAlarm";

    @Override
    public void onReceive(Context context, Intent intent) {
        if (intent == null || !ACTION_ALARM_WAKE.equals(intent.getAction())) {
            return;
        }
        if (!SleepTestPrefs.isRunning(context)) {
            return;
        }
        LogUtil.i(TAG, "alarm wake");
        WakeUpActivity.start(context);
        Intent service = new Intent(context, SleepTestService.class);
        service.setAction(SleepTestService.ACTION_ALARM_WAKE);
        context.startForegroundService(service);
    }
}
