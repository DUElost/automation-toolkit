package com.mediatek.schpwronoff.powercycle;

import android.annotation.SuppressLint;
import android.app.AlarmManager;
import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ServiceInfo;
import android.os.Build;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.os.Message;
import android.os.PowerManager;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.app.NotificationCompat;

import com.mediatek.schpwronoff.R;
import com.mediatek.schpwronoff.screen.UnlockUtils;
import com.mediatek.schpwronoff.utils.GlobalUtils;
import com.mediatek.schpwronoff.utils.LogUtil;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

/**
 * 开关机 / 重启循环服务（基于 MTBFTool RebootService，适配 ATTS 常量与结果目录）。
 */
public class PowerCycleService extends Service {

    public static final String ACTION_START = "com.tinno.autotesttool.action.POWER_CYCLE_START";
    public static final String ACTION_STOP = "com.tinno.autotesttool.action.POWER_CYCLE_STOP";

    private static final String TAG = "PowerCycleService";
    private static final int NOTIFICATION_ID = 12001;
    private static final String CHANNEL_ID = "power_cycle_channel";
    private static final int MSG_EXECUTE = 1;

    private final Handler handler = new Handler(Looper.getMainLooper()) {
        @Override
        public void handleMessage(@NonNull Message msg) {
            if (msg.what == MSG_EXECUTE) {
                executeCycle();
            }
        }
    };

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        startAsForeground();
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        if (intent != null && ACTION_STOP.equals(intent.getAction())) {
            stopCycle();
            return START_NOT_STICKY;
        }

        PowerCyclePrefs.setRunning(this, true);
        int current = PowerCyclePrefs.getCurrentCount(this);
        int total = PowerCyclePrefs.getTestTimes(this);
        LogUtil.i(TAG, "onStartCommand count=" + current + "/" + total);

        if (current >= total) {
            finishTest("PASS");
            return START_NOT_STICKY;
        }

        UnlockUtils.unlockBySwipe();
        int waitSec = PowerCyclePrefs.getWaitSeconds(this);
        handler.removeMessages(MSG_EXECUTE);
        handler.sendEmptyMessageDelayed(MSG_EXECUTE, waitSec * 1000L);
        return START_STICKY;
    }

    private void executeCycle() {
        int current = PowerCyclePrefs.getCurrentCount(this);
        int total = PowerCyclePrefs.getTestTimes(this);
        PowerCyclePrefs.incrementCount(this);
        appendResultLine("cycle " + (current + 1) + "/" + total + " start");

        String mode = PowerCyclePrefs.getMode(this);
        if (PowerCyclePrefs.MODE_POWER_OFF.equals(mode)) {
            schedulePowerOnAlarm();
            shutdownDevice();
        } else {
            rebootDevice();
        }
    }

    private void rebootDevice() {
        LogUtil.i(TAG, "reboot");
        try {
            PowerManager pm = (PowerManager) getSystemService(Context.POWER_SERVICE);
            pm.reboot(null);
        } catch (Exception e) {
            LogUtil.e(TAG, "reboot failed: " + e.getMessage());
            appendResultLine("reboot failed: " + e.getMessage());
        }
    }

    private void shutdownDevice() {
        LogUtil.i(TAG, "shutdown");
        try {
            PowerManager pm = (PowerManager) getSystemService(Context.POWER_SERVICE);
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                pm.getClass()
                        .getMethod("shutdown", boolean.class, String.class, boolean.class)
                        .invoke(pm, false, null, false);
            } else {
                pm.reboot(null);
            }
        } catch (Exception e) {
            LogUtil.e(TAG, "shutdown failed, fallback reboot: " + e.getMessage());
            rebootDevice();
        }
    }

    private void schedulePowerOnAlarm() {
        int minutes = Math.max(1, PowerCyclePrefs.getPowerOffMinutes(this));
        long triggerAt = System.currentTimeMillis() + minutes * 60_000L;
        Intent alarmIntent = new Intent(PowerCycleAutoResumeReceiver.ACTION_ALARM_WAKE);
        alarmIntent.setPackage(getPackageName());
        PendingIntent pi = PendingIntent.getBroadcast(
                this, 0, alarmIntent,
                PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE);
        AlarmManager am = (AlarmManager) getSystemService(Context.ALARM_SERVICE);
        if (am != null) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                am.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, triggerAt, pi);
            } else {
                am.setExact(AlarmManager.RTC_WAKEUP, triggerAt, pi);
            }
            LogUtil.i(TAG, "power-on alarm in " + minutes + " min");
        }
    }

    private void stopCycle() {
        handler.removeCallbacksAndMessages(null);
        PowerCyclePrefs.markFinished(this);
        appendResultLine("stopped by user");
        stopForeground(true);
        stopSelf();
    }

    private void finishTest(String result) {
        handler.removeCallbacksAndMessages(null);
        PowerCyclePrefs.markFinished(this);
        appendResultLine("finished result=" + result);
        stopForeground(true);
        stopSelf();
    }

    private File getResultDir() {
        File appDir = getExternalFilesDir("PowerCycle");
        if (appDir != null) {
            if (!appDir.exists()) {
                //noinspection ResultOfMethodCallIgnored
                appDir.mkdirs();
            }
            return appDir;
        }
        File legacyDir = new File(GlobalUtils.getRootFolderDir(), "PowerCycle");
        if (!legacyDir.exists()) {
            //noinspection ResultOfMethodCallIgnored
            legacyDir.mkdirs();
        }
        return legacyDir;
    }

    private void appendResultLine(String line) {
        try {
            File log = new File(getResultDir(), "powercycle_result.txt");
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
                    CHANNEL_ID, "Power Cycle Test", NotificationManager.IMPORTANCE_LOW);
            nm.createNotificationChannel(channel);
        }
        Notification notification = new NotificationCompat.Builder(this, CHANNEL_ID)
                .setContentTitle(getString(R.string.app_name))
                .setContentText("Power cycle test running")
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
        handler.removeCallbacksAndMessages(null);
        super.onDestroy();
    }
}
