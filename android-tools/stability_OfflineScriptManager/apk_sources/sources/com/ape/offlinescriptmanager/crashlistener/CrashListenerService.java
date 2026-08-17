package com.ape.offlinescriptmanager.crashlistener;

import android.app.ActivityManager;
import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Build;
import android.os.Handler;
import android.os.IBinder;
import android.os.Message;
import android.preference.PreferenceManager;
import com.ape.offlinescriptmanager.utils.j;
import java.util.List;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class CrashListenerService extends Service {
    public static boolean h = false;

    /* renamed from: b  reason: collision with root package name */
    ActivityManager f1932b;

    /* renamed from: d  reason: collision with root package name */
    private long f1934d;
    private com.ape.offlinescriptmanager.crashlistener.b e;
    private NotificationManager f;

    /* renamed from: c  reason: collision with root package name */
    int f1933c = 0;
    private NotificationChannel g = null;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a extends Handler {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ Notification.Action f1935a;

        a(Notification.Action action) {
            this.f1935a = action;
        }

        @Override // android.os.Handler
        public void handleMessage(Message message) {
            CrashListenerService crashListenerService = CrashListenerService.this;
            Notification.Builder e = crashListenerService.e(this.f1935a);
            crashListenerService.l(e.setContentText("crash:" + message.obj.toString()).build(), 7001);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b implements Runnable {
        b() {
        }

        @Override // java.lang.Runnable
        public void run() {
            while (!CrashListenerService.h) {
                ActivityManager activityManager = CrashListenerService.this.f1932b;
                if (activityManager != null) {
                    List<ActivityManager.ProcessErrorStateInfo> processesInErrorState = activityManager.getProcessesInErrorState();
                    if (processesInErrorState != null) {
                        int size = processesInErrorState.size();
                        if (size != 0 && size != CrashListenerService.this.f1933c) {
                            j.b("crash", "takeScreenShot");
                            CrashListenerService.this.m();
                        }
                        CrashListenerService.this.f1933c = size;
                    } else {
                        CrashListenerService.this.f1933c = 0;
                    }
                }
                try {
                    j.b("offlinescriptmanager", "crash listener is running");
                    Thread.sleep(CrashListenerService.this.f1934d);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
            CrashListenerService.this.stopSelf();
        }
    }

    private void d() {
        try {
            this.f1934d = Long.valueOf(PreferenceManager.getDefaultSharedPreferences(this).getString(getString(R.string.crash_listener_interval_time_key), "200")).longValue();
        } catch (Exception unused) {
            this.f1934d = Long.valueOf("200").longValue();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public Notification.Builder e(Notification.Action action) {
        Notification.Builder builder;
        Bitmap decodeResource = BitmapFactory.decodeResource(getResources(), R.mipmap.ic_launcher);
        Intent intent = new Intent(this, CrashListenerService.class);
        intent.setAction("com.ape.offlinescriptmanager.screenshot.services.action.stoplistening");
        PendingIntent service = PendingIntent.getService(this, 0, intent, 0);
        PendingIntent activity = PendingIntent.getActivity(this, 0, new Intent(this, CrashListenerActivity.class), 0);
        if (Build.VERSION.SDK_INT >= 26) {
            builder = new Notification.Builder(this, "offlinescriptmanager_id");
            builder.setContentTitle(getResources().getString(R.string.crash_listener_notification_title)).setTicker(getResources().getString(R.string.crash_listener_notification_title)).setSmallIcon(R.drawable.ic_notification).setLargeIcon(Bitmap.createScaledBitmap(decodeResource, 128, 128, false)).setUsesChronometer(true).setOngoing(true).setContentIntent(activity).setPriority(2).addAction(R.drawable.ic_notification_stop, getResources().getString(R.string.screen_recording_notification_action_stop), service).build();
        } else {
            builder = null;
        }
        if (action != null) {
            builder.addAction(action);
        }
        return builder;
    }

    private void f() {
        l(e(null).build(), 7001);
        new a(null);
        d();
        j();
    }

    private void g() {
        com.ape.offlinescriptmanager.crashlistener.b bVar = this.e;
        if (bVar != null) {
            bVar.g();
        }
        stopForeground(true);
        h = true;
        stopSelf();
    }

    private void h() {
    }

    private void i() {
    }

    public static void k(Context context) {
        Intent intent = new Intent(context, CrashListenerService.class);
        intent.setAction("com.ape.offlinescriptmanager.screenshot.services.action.startlistening");
        context.startService(intent);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void l(Notification notification, int i) {
        startForeground(i, notification);
    }

    public void j() {
        h = false;
        if (this.f1932b == null) {
            this.f1932b = (ActivityManager) getSystemService("activity");
        }
        new Thread(new b()).start();
    }

    public void m() {
        if (h) {
            return;
        }
        com.ape.offlinescriptmanager.crashlistener.b bVar = new com.ape.offlinescriptmanager.crashlistener.b(getApplicationContext());
        this.e = bVar;
        bVar.m();
    }

    @Override // android.app.Service
    public IBinder onBind(Intent intent) {
        throw new UnsupportedOperationException("Not yet implemented");
    }

    @Override // android.app.Service
    public void onCreate() {
        super.onCreate();
        this.f = (NotificationManager) getSystemService("notification");
        if (Build.VERSION.SDK_INT >= 26) {
            NotificationChannel notificationChannel = new NotificationChannel("offlinescriptmanager_id", "offlinescriptmanager_name", 3);
            this.g = notificationChannel;
            notificationChannel.enableLights(true);
            this.g.setLightColor(-16711936);
            this.g.setShowBadge(false);
            this.f.createNotificationChannel(this.g);
        }
    }

    @Override // android.app.Service
    public void onDestroy() {
        g();
        super.onDestroy();
    }

    @Override // android.app.Service
    public int onStartCommand(Intent intent, int i, int i2) {
        String action = intent.getAction();
        action.hashCode();
        char c2 = 65535;
        switch (action.hashCode()) {
            case -1042934573:
                if (action.equals("com.ape.offlinescriptmanager.screenshot.services.action.stoplistening")) {
                    c2 = 0;
                    break;
                }
                break;
            case -257494805:
                if (action.equals("com.ape.offlinescriptmanager.screenshot.services.action.pauselistening")) {
                    c2 = 1;
                    break;
                }
                break;
            case 488457864:
                if (action.equals("com.ape.offlinescriptmanager.screenshot.services.action.resumelistening")) {
                    c2 = 2;
                    break;
                }
                break;
            case 1803668479:
                if (action.equals("com.ape.offlinescriptmanager.screenshot.services.action.startlistening")) {
                    c2 = 3;
                    break;
                }
                break;
        }
        switch (c2) {
            case 0:
                g();
                break;
            case 1:
                h();
                break;
            case 2:
                i();
                break;
            case 3:
                f();
                break;
        }
        return 1;
    }
}
