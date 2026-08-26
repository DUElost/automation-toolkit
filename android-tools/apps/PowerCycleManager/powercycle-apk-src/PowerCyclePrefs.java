package com.mediatek.schpwronoff.powercycle;

import android.content.Context;
import android.content.SharedPreferences;

/**
 * 开关机测试运行参数（与 PC 端 deploy 脚本写入的 powercycle_runner.xml 对齐）。
 */
public final class PowerCyclePrefs {

    public static final String PREFS_NAME = "powercycle_runner";

    public static final String KEY_TEST_TIMES = "test_times";
    public static final String KEY_CURRENT_COUNT = "current_count";
    public static final String KEY_MODE = "mode";
    public static final String KEY_POWER_OFF_MINUTES = "power_off_minutes";
    public static final String KEY_WAIT_SECONDS = "wait_seconds";
    public static final String KEY_AUTO_RESUME = "auto_resume";
    public static final String KEY_RUNNING = "running";
    public static final String KEY_TESTER = "tester_name";
    public static final String KEY_LAST_ACTION_TIME = "last_action_time";
    public static final String KEY_NEXT_ACTION_AT = "next_action_at";
    public static final String KEY_NEXT_POWER_ON_AT = "next_power_on_at";

    public static final String MODE_REBOOT = "reboot";
    public static final String MODE_POWER_OFF = "poweroff";

    public static final int DEFAULT_TEST_TIMES = 100;
    public static final int DEFAULT_POWER_OFF_MINUTES = 1;
    public static final int DEFAULT_WAIT_SECONDS = 3;

    private PowerCyclePrefs() {
    }

    private static SharedPreferences prefs(Context context) {
        return context.getApplicationContext()
                .getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
    }

    public static int getTestTimes(Context context) {
        return prefs(context).getInt(KEY_TEST_TIMES, DEFAULT_TEST_TIMES);
    }

    public static int getCurrentCount(Context context) {
        return prefs(context).getInt(KEY_CURRENT_COUNT, 0);
    }

    public static String getMode(Context context) {
        return prefs(context).getString(KEY_MODE, MODE_REBOOT);
    }

    public static int getPowerOffMinutes(Context context) {
        return prefs(context).getInt(KEY_POWER_OFF_MINUTES, DEFAULT_POWER_OFF_MINUTES);
    }

    public static int getWaitSeconds(Context context) {
        return prefs(context).getInt(KEY_WAIT_SECONDS, DEFAULT_WAIT_SECONDS);
    }

    public static boolean isAutoResume(Context context) {
        return prefs(context).getBoolean(KEY_AUTO_RESUME, true);
    }

    public static boolean isRunning(Context context) {
        return prefs(context).getBoolean(KEY_RUNNING, false);
    }

    public static String getTester(Context context) {
        return prefs(context).getString(KEY_TESTER, "tester");
    }

    public static long getNextActionAt(Context context) {
        return prefs(context).getLong(KEY_NEXT_ACTION_AT, 0L);
    }

    public static long getNextPowerOnAt(Context context) {
        return prefs(context).getLong(KEY_NEXT_POWER_ON_AT, 0L);
    }

    public static void setNextActionAt(Context context, long epochMs) {
        prefs(context).edit().putLong(KEY_NEXT_ACTION_AT, epochMs).apply();
    }

    public static void setNextPowerOnAt(Context context, long epochMs) {
        prefs(context).edit().putLong(KEY_NEXT_POWER_ON_AT, epochMs).apply();
    }

    public static void clearScheduleTimes(Context context) {
        prefs(context).edit()
                .putLong(KEY_NEXT_ACTION_AT, 0L)
                .putLong(KEY_NEXT_POWER_ON_AT, 0L)
                .apply();
    }

    public static void setRunning(Context context, boolean running) {
        prefs(context).edit().putBoolean(KEY_RUNNING, running).apply();
    }

    public static void incrementCount(Context context) {
        int next = getCurrentCount(context) + 1;
        prefs(context).edit()
                .putInt(KEY_CURRENT_COUNT, next)
                .putLong(KEY_LAST_ACTION_TIME, System.currentTimeMillis())
                .apply();
    }

    public static void resetCount(Context context) {
        prefs(context).edit()
                .putInt(KEY_CURRENT_COUNT, 0)
                .putLong(KEY_LAST_ACTION_TIME, 0L)
                .apply();
    }

    public static void markFinished(Context context) {
        prefs(context).edit()
                .putBoolean(KEY_RUNNING, false)
                .putLong(KEY_NEXT_ACTION_AT, 0L)
                .putLong(KEY_NEXT_POWER_ON_AT, 0L)
                .apply();
    }
}
