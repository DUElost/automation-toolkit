package com.mediatek.schpwronoff.sleeptest;

import android.annotation.SuppressLint;
import android.app.AlarmManager;
import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.ServiceInfo;
import android.os.Build;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.IBinder;
import android.os.Looper;
import android.os.PowerManager;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.app.NotificationCompat;

import com.mediatek.schpwronoff.R;
import com.mediatek.schpwronoff.utils.GlobalUtils;
import com.mediatek.schpwronoff.utils.LogUtil;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

/**
 * 休眠唤醒循环：前台服务 + PARTIAL_WAKE_LOCK + 独立线程定时器。
 * AlarmManager 仅作备胎，主干不依赖 ZTE 省电策略下的闹钟。
 */
public class SleepTestService extends Service {

    public static final String ACTION_START = "com.tinno.autotesttool.action.SLEEP_TEST_START";
    public static final String ACTION_STOP = "com.tinno.autotesttool.action.SLEEP_TEST_STOP";
    public static final String ACTION_ALARM_WAKE = "com.tinno.autotesttool.action.SLEEP_TEST_ALARM_WAKE";

    private static final String TAG = "SleepTestService";
    private static final int NOTIFICATION_ID = 12002;
    private static final String CHANNEL_ID = "sleep_test_channel";
    private static final int MSG_GO_SLEEP = 10000;
    private static final int SCREEN_OFF_TIMEOUT_SLEEP_MS = 1500;
    private static final int SCREEN_OFF_TIMEOUT_WAKE_MS = 30 * 60 * 1000;

    private final Handler mainHandler = new Handler(Looper.getMainLooper()) {
        @Override
        public void handleMessage(@NonNull android.os.Message msg) {
            if (msg.what == MSG_GO_SLEEP) {
                goSleep();
            }
        }
    };

    private HandlerThread timerThread;
    private Handler timerHandler;
    private Runnable wakeUpTask;

    private PowerManager powerManager;
    private AlarmManager alarmManager;
    private PowerManager.WakeLock cpuWakeLock;
    private PowerManager.WakeLock screenWakeLock;
    private PendingIntent alarmPendingIntent;
    private BroadcastReceiver screenReceiver;

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        powerManager = (PowerManager) getSystemService(Context.POWER_SERVICE);
        alarmManager = (AlarmManager) getSystemService(Context.ALARM_SERVICE);

        cpuWakeLock = powerManager.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK, "SleepTest:keep_cpu");
        cpuWakeLock.setReferenceCounted(false);
        screenWakeLock = powerManager.newWakeLock(
                PowerManager.SCREEN_BRIGHT_WAKE_LOCK | PowerManager.ACQUIRE_CAUSES_WAKEUP,
                "SleepTest:screen");
        screenWakeLock.setReferenceCounted(false);

        timerThread = new HandlerThread("sleep-test-timer");
        timerThread.start();
        timerHandler = new Handler(timerThread.getLooper());

        Intent alarmIntent = new Intent(this, SleepTestAlarmReceiver.class);
        alarmIntent.setAction(SleepTestAlarmReceiver.ACTION_ALARM_WAKE);
        alarmPendingIntent = PendingIntent.getBroadcast(
                this, 0, alarmIntent,
                PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE);

        registerScreenReceiver();
        startAsForeground();
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        if (intent != null && ACTION_STOP.equals(intent.getAction())) {
            stopTest("stopped by user");
            return START_NOT_STICKY;
        }

        if (!SleepTestPrefs.isRunning(this)) {
            SleepTestPrefs.setRunning(this, true);
        }

        int current = SleepTestPrefs.getCurrentCount(this);
        int total = SleepTestPrefs.getTestTimes(this);
        LogUtil.i(TAG, "onStartCommand count=" + current + "/" + total
                + " wake=" + SleepTestPrefs.getWakeSeconds(this)
                + "s sleep=" + SleepTestPrefs.getSleepSeconds(this) + "s");

        if (current >= total) {
            finishTest("PASS");
            return START_NOT_STICKY;
        }

        scheduleKeepAliveBackup();

        if (intent != null && ACTION_ALARM_WAKE.equals(intent.getAction())) {
            onWakeTrigger("alarm_or_activity");
            return START_STICKY;
        }

        if (SleepTestPrefs.PHASE_SLEEP.equals(SleepTestPrefs.getPhase(this))) {
            LogUtil.i(TAG, "keepalive during sleep, keep cpu lock + timer");
            holdCpuLock();
            return START_STICKY;
        }

        enterWakePhase();
        return START_STICKY;
    }

    private void enterWakePhase() {
        holdCpuLock();
        if (screenWakeLock != null && !screenWakeLock.isHeld()) {
            screenWakeLock.acquire(10 * 60_000L);
        }
        if (!powerManager.isInteractive()) {
            WakeUpActivity.start(this);
        }
        setScreenOffTimeout(SCREEN_OFF_TIMEOUT_WAKE_MS);
        SleepTestPrefs.setPhase(this, SleepTestPrefs.PHASE_WAKE);
        scheduleGoSleep();
    }

    private void onWakeTrigger(String source) {
        if (!SleepTestPrefs.PHASE_SLEEP.equals(SleepTestPrefs.getPhase(this))) {
            return;
        }
        SleepTestPrefs.setPhase(this, SleepTestPrefs.PHASE_WAKE);
        cancelWakeTimer();
        cancelBackupAlarm();
        appendResultLine("timer fire source=" + source
                + " cpuLock=" + (cpuWakeLock != null && cpuWakeLock.isHeld()));
        LogUtil.i(TAG, "wake trigger source=" + source);
        setScreenOffTimeout(SCREEN_OFF_TIMEOUT_WAKE_MS);
        if (screenWakeLock != null && !screenWakeLock.isHeld()) {
            screenWakeLock.acquire(10 * 60_000L);
        }
        WakeUpActivity.start(this);
        mainHandler.postDelayed(this::onWakeSuccess, 800);
    }

    private void onWakeSuccess() {
        int current = SleepTestPrefs.getCurrentCount(this);
        int total = SleepTestPrefs.getTestTimes(this);
        boolean interactive = powerManager.isInteractive();

        SleepTestPrefs.setPhase(this, SleepTestPrefs.PHASE_WAKE);
        SleepTestPrefs.incrementCount(this);
        int cycle = current + 1;
        if (interactive) {
            appendResultLine("cycle " + cycle + "/" + total + " wake OK screen=ON");
        } else {
            appendResultLine("cycle " + cycle + "/" + total + " wake FAIL screen=OFF");
        }

        if (cycle >= total) {
            finishTest(interactive ? "PASS" : "FAIL");
            return;
        }
        scheduleGoSleep();
    }

    private void scheduleGoSleep() {
        mainHandler.removeMessages(MSG_GO_SLEEP);
        long delayMs = SleepTestPrefs.getWakeSeconds(this) * 1000L;
        long offAt = System.currentTimeMillis() + delayMs;
        long wakeAt = offAt + SleepTestPrefs.getSleepSeconds(this) * 1000L;
        SleepTestPrefs.setNextScreenOffAt(this, offAt);
        SleepTestPrefs.setNextWakeAt(this, wakeAt);
        mainHandler.sendEmptyMessageDelayed(MSG_GO_SLEEP, delayMs);
    }

    private void goSleep() {
        int sleepSec = SleepTestPrefs.getSleepSeconds(this);
        SleepTestPrefs.setPhase(this, SleepTestPrefs.PHASE_SLEEP);
        releaseScreenLock();
        turnScreenOff();
        holdCpuLock();
        long wakeAt = System.currentTimeMillis() + sleepSec * 1000L;
        long nextOffAt = wakeAt + SleepTestPrefs.getWakeSeconds(this) * 1000L;
        SleepTestPrefs.setNextWakeAt(this, wakeAt);
        SleepTestPrefs.setNextScreenOffAt(this, nextOffAt);
        startWakeCountdown(sleepSec * 1000L);
        scheduleBackupAlarm(wakeAt);
        LogUtil.i(TAG, "go sleep " + sleepSec + "s cpuLock=" + cpuWakeLock.isHeld());
        timerHandler.postDelayed(() -> {
            boolean off = !powerManager.isInteractive();
            appendResultLine("go sleep " + sleepSec + "s screen=" + (off ? "OFF" : "ON")
                    + " cpuLock=" + cpuWakeLock.isHeld());
        }, 2000);
    }

    private void startWakeCountdown(long delayMs) {
        cancelWakeTimer();
        wakeUpTask = () -> mainHandler.post(() -> onWakeTrigger("handler_thread"));
        timerHandler.postDelayed(wakeUpTask, delayMs);
    }

    private void cancelWakeTimer() {
        if (timerHandler != null && wakeUpTask != null) {
            timerHandler.removeCallbacks(wakeUpTask);
        }
    }

    private void holdCpuLock() {
        if (cpuWakeLock == null) {
            return;
        }
        if (!cpuWakeLock.isHeld()) {
            cpuWakeLock.acquire(12 * 60_000L);
        }
    }

    private void turnScreenOff() {
        setScreenOffTimeout(SCREEN_OFF_TIMEOUT_SLEEP_MS);
    }

    private void setScreenOffTimeout(int timeoutMs) {
        try {
            android.provider.Settings.System.putInt(
                    getContentResolver(),
                    android.provider.Settings.System.SCREEN_OFF_TIMEOUT,
                    timeoutMs);
        } catch (Exception e) {
            LogUtil.e(TAG, "set SCREEN_OFF_TIMEOUT failed: " + e.getMessage());
        }
    }

    private void scheduleBackupAlarm(long triggerAt) {
        if (alarmManager == null || alarmPendingIntent == null) {
            return;
        }
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                alarmManager.setExactAndAllowWhileIdle(
                        AlarmManager.RTC_WAKEUP, triggerAt, alarmPendingIntent);
            } else {
                alarmManager.setExact(AlarmManager.RTC_WAKEUP, triggerAt, alarmPendingIntent);
            }
        } catch (Exception e) {
            LogUtil.e(TAG, "backup alarm failed: " + e.getMessage());
        }
    }

    private void cancelBackupAlarm() {
        if (alarmManager != null && alarmPendingIntent != null) {
            alarmManager.cancel(alarmPendingIntent);
        }
    }

    private void scheduleKeepAliveBackup() {
        if (!SleepTestPrefs.isAutoResume(this) || alarmManager == null) {
            return;
        }
        Intent keepAlive = new Intent(SleepTestKeepAliveReceiver.ACTION_KEEPALIVE);
        keepAlive.setPackage(getPackageName());
        PendingIntent pi = PendingIntent.getBroadcast(
                this, 1, keepAlive,
                PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE);
        long triggerAt = System.currentTimeMillis() + 5 * 60_000L;
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                alarmManager.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, triggerAt, pi);
            }
        } catch (Exception ignored) {
        }
    }

    private void registerScreenReceiver() {
        screenReceiver = new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                if (intent == null || intent.getAction() == null) {
                    return;
                }
                if (Intent.ACTION_SCREEN_OFF.equals(intent.getAction())) {
                    if (SleepTestPrefs.PHASE_SLEEP.equals(SleepTestPrefs.getPhase(context))) {
                        holdCpuLock();
                    }
                }
            }
        };
        IntentFilter filter = new IntentFilter();
        filter.addAction(Intent.ACTION_SCREEN_OFF);
        filter.addAction(Intent.ACTION_SCREEN_ON);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            registerReceiver(screenReceiver, filter, Context.RECEIVER_NOT_EXPORTED);
        } else {
            registerReceiver(screenReceiver, filter);
        }
    }

    private void releaseScreenLock() {
        if (screenWakeLock != null && screenWakeLock.isHeld()) {
            screenWakeLock.release();
        }
    }

    private void releaseWakeLock() {
        releaseScreenLock();
        if (cpuWakeLock != null && cpuWakeLock.isHeld()) {
            cpuWakeLock.release();
        }
    }

    private void stopTest(String reason) {
        cancelWakeTimer();
        mainHandler.removeCallbacksAndMessages(null);
        cancelBackupAlarm();
        releaseWakeLock();
        SleepTestPrefs.markFinished(this);
        appendResultLine(reason);
        stopForeground(true);
        stopSelf();
    }

    private void finishTest(String result) {
        cancelWakeTimer();
        mainHandler.removeCallbacksAndMessages(null);
        cancelBackupAlarm();
        releaseWakeLock();
        SleepTestPrefs.markFinished(this);
        appendResultLine("finished result=" + result);
        stopForeground(true);
        stopSelf();
    }

    private File getResultDir() {
        File appDir = getExternalFilesDir("SleepTest");
        if (appDir != null) {
            if (!appDir.exists()) {
                //noinspection ResultOfMethodCallIgnored
                appDir.mkdirs();
            }
            return appDir;
        }
        File legacyDir = new File(GlobalUtils.getRootFolderDir(), "SleepTest");
        if (!legacyDir.exists()) {
            //noinspection ResultOfMethodCallIgnored
            legacyDir.mkdirs();
        }
        return legacyDir;
    }

    private void appendResultLine(String line) {
        try {
            File log = new File(getResultDir(), "sleep_test_result.txt");
            String ts = new SimpleDateFormat(GlobalUtils.DATE_PATTERN, Locale.getDefault())
                    .format(new Date());
            FileWriter fw = new FileWriter(log, true);
            fw.write(ts + " " + line + "\n");
            fw.close();
        } catch (IOException e) {
            LogUtil.e(TAG, "write result failed: " + e.getMessage());
        }
    }

    @SuppressLint("InlinedApi")
    private void startAsForeground() {
        NotificationManager nm = (NotificationManager) getSystemService(NOTIFICATION_SERVICE);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationChannel channel = new NotificationChannel(
                    CHANNEL_ID, "Sleep Test", NotificationManager.IMPORTANCE_LOW);
            nm.createNotificationChannel(channel);
        }
        Notification notification = new NotificationCompat.Builder(this, CHANNEL_ID)
                .setContentTitle(getString(R.string.activity_sleep_test))
                .setContentText(getString(R.string.sleep_test_notification_running))
                .setSmallIcon(R.mipmap.ic_launcher)
                .setOngoing(true)
                .build();
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            startForeground(NOTIFICATION_ID, notification, ServiceInfo.FOREGROUND_SERVICE_TYPE_MEDIA_PLAYBACK);
        } else {
            startForeground(NOTIFICATION_ID, notification);
        }
    }

    @Override
    public void onDestroy() {
        try {
            if (screenReceiver != null) {
                unregisterReceiver(screenReceiver);
            }
        } catch (Exception ignored) {
        }
        cancelWakeTimer();
        mainHandler.removeCallbacksAndMessages(null);
        if (timerThread != null) {
            timerThread.quitSafely();
        }
        releaseWakeLock();
        super.onDestroy();
    }
}
