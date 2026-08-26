package com.mediatek.schpwronoff.sleeptest;

import android.content.Context;
import android.content.SharedPreferences;

/**
 * 休眠唤醒测试运行参数（与 PC 端 deploy 脚本写入的 sleep_test_runner.xml 对齐）。
 */
public final class SleepTestPrefs {

    public static final String PREFS_NAME = "sleep_test_runner";

    public static final String KEY_TEST_TIMES = "test_times";
    public static final String KEY_CURRENT_COUNT = "current_count";
    public static final String KEY_WAKE_SECONDS = "wake_seconds";
    public static final String KEY_SLEEP_SECONDS = "sleep_seconds";
    public static final String KEY_AUTO_RESUME = "auto_resume";
    public static final String KEY_RUNNING = "running";
    public static final String KEY_PHASE = "phase";
    public static final String KEY_TESTER = "tester_name";
    public static final String KEY_LAST_ACTION_TIME = "last_action_time";
    public static final String KEY_NEXT_SCREEN_OFF_AT = "next_screen_off_at";
    public static final String KEY_NEXT_WAKE_AT = "next_wake_at";

    public static final String PHASE_IDLE = "idle";
    public static final String PHASE_WAKE = "wake";
    public static final String PHASE_SLEEP = "sleep";

    public static final int DEFAULT_TEST_TIMES = 100;
    public static final int DEFAULT_WAKE_SECONDS = 60;
    public static final int DEFAULT_SLEEP_SECONDS = 300;

    private SleepTestPrefs() {
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

    public static int getWakeSeconds(Context context) {
        return prefs(context).getInt(KEY_WAKE_SECONDS, DEFAULT_WAKE_SECONDS);
    }

    public static int getSleepSeconds(Context context) {
        return prefs(context).getInt(KEY_SLEEP_SECONDS, DEFAULT_SLEEP_SECONDS);
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

    public static String getPhase(Context context) {
        return prefs(context).getString(KEY_PHASE, PHASE_IDLE);
    }

    public static long getNextScreenOffAt(Context context) {
        return prefs(context).getLong(KEY_NEXT_SCREEN_OFF_AT, 0L);
    }

    public static long getNextWakeAt(Context context) {
        return prefs(context).getLong(KEY_NEXT_WAKE_AT, 0L);
    }

    public static void setNextScreenOffAt(Context context, long epochMs) {
        prefs(context).edit().putLong(KEY_NEXT_SCREEN_OFF_AT, epochMs).apply();
    }

    public static void setNextWakeAt(Context context, long epochMs) {
        prefs(context).edit().putLong(KEY_NEXT_WAKE_AT, epochMs).apply();
    }

    public static void clearScheduleTimes(Context context) {
        prefs(context).edit()
                .putLong(KEY_NEXT_SCREEN_OFF_AT, 0L)
                .putLong(KEY_NEXT_WAKE_AT, 0L)
                .apply();
    }

    public static void setPhase(Context context, String phase) {
        prefs(context).edit().putString(KEY_PHASE, phase).apply();
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
                .putString(KEY_PHASE, PHASE_IDLE)
                .putLong(KEY_NEXT_SCREEN_OFF_AT, 0L)
                .putLong(KEY_NEXT_WAKE_AT, 0L)
                .apply();
    }
}
