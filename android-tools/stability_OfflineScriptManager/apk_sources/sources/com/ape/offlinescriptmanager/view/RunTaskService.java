package com.ape.offlinescriptmanager.view;

import android.app.Activity;
import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Build;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.os.Message;
import android.util.Log;
import b.b.a.a.b.h;
import com.ape.offlinescriptmanager.batterytool.BatteryActivity;
import com.ape.offlinescriptmanager.batterytool.g.b;
import com.ape.offlinescriptmanager.utils.g;
import com.ape.offlinescriptmanager.utils.l.f;
import com.ape.offlinescriptmanager.utils.m.c;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.Map;
import me.zhanghai.android.materialprogressbar.BuildConfig;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class RunTaskService extends Service implements f.a {
    private static final String l = RunTaskService.class.getSimpleName();

    /* renamed from: b  reason: collision with root package name */
    f f2139b;

    /* renamed from: c  reason: collision with root package name */
    public Handler f2140c;
    private NotificationManager e;
    private String i;

    /* renamed from: d  reason: collision with root package name */
    c f2141d = null;
    private NotificationChannel f = null;
    private Notification.Builder g = null;
    private Notification.Builder h = null;
    private int j = 0;
    private int k = 0;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a extends Handler {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ NotificationManager f2142a;

        /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
        a(Looper looper, NotificationManager notificationManager) {
            super(looper);
            this.f2142a = notificationManager;
        }

        @Override // android.os.Handler
        public void handleMessage(Message message) {
            String valueOf = String.valueOf(message.obj);
            if (valueOf.startsWith("Pass")) {
                RunTaskService.this.h.setContentTitle(valueOf);
            } else if (valueOf.startsWith("Finished")) {
                this.f2142a.cancel(10010);
                RunTaskService.this.g.setContentText(valueOf);
                this.f2142a.notify(10011, RunTaskService.this.g.build());
                return;
            } else if (!valueOf.startsWith("Current")) {
                return;
            } else {
                String[] split = valueOf.split(":");
                Notification.Builder builder = RunTaskService.this.h;
                builder.setContentText(split[0] + ":" + split[1]);
                RunTaskService.this.h.setSubText(split[1]);
            }
            this.f2142a.notify(10010, RunTaskService.this.h.build());
        }
    }

    private void h(String str) {
        com.ape.offlinescriptmanager.utils.a aVar = new com.ape.offlinescriptmanager.utils.a(this);
        if (!aVar.e(2L)) {
            aVar.j(this);
            return;
        }
        aVar.h("com.ape.offlinescriptmanager.pref", "export_data_no_empty", false);
        new b(getApplicationContext(), str, false, true).execute(new Void[0]);
    }

    private String m(Context context, String str) {
        try {
            Class<?> loadClass = context.getClassLoader().loadClass("android.os.SystemProperties");
            return (String) loadClass.getMethod("get", String.class).invoke(loadClass, new String(str));
        } catch (IllegalArgumentException | Exception unused) {
            return BuildConfig.FLAVOR;
        }
    }

    private void o() {
        com.ape.offlinescriptmanager.utils.a.c(this).f("uiautomator");
        NotificationManager notificationManager = (NotificationManager) getSystemService("notification");
        PendingIntent activity = PendingIntent.getActivity(this, 0, new Intent(this, BatteryActivity.class), 0);
        Intent intent = new Intent(this, RunTaskService.class);
        intent.setAction("com.ape.offlinescriptmanager.view.RunTaskService.action.stop");
        PendingIntent service = PendingIntent.getService(this, 0, intent, 0);
        int i = Build.VERSION.SDK_INT;
        if (i >= 26) {
            this.h = new Notification.Builder(this, "offlinescriptmanager_id");
        }
        this.h.setContentTitle("OSM Tool Running").setContentText("task is running").setSmallIcon(R.mipmap.ic_launcher).setWhen(System.currentTimeMillis()).addAction(R.mipmap.ic_launcher, getString(R.string.run_task_service_notification_action_stop), service).setContentIntent(activity).build();
        notificationManager.notify(10010, this.h.build());
        startForeground(10010, this.h.build());
        if (i >= 26) {
            this.g = new Notification.Builder(this, "offlinescriptmanager_id");
        }
        this.g.setContentTitle("OSM Tool Result").setSmallIcon(R.mipmap.ic_launcher).setWhen(System.currentTimeMillis()).setAutoCancel(true).setContentIntent(activity).build();
        this.f2140c = new a(getMainLooper(), notificationManager);
        notificationManager.cancelAll();
        com.ape.offlinescriptmanager.utils.b.b();
        f fVar = new f(this);
        this.f2139b = fVar;
        fVar.start();
    }

    private void p() {
        com.ape.offlinescriptmanager.utils.a.c(this).f("uiautomator");
        f fVar = this.f2139b;
        if (fVar != null) {
            fVar.o();
        }
        stopForeground(true);
        stopSelf();
    }

    public static void q(Activity activity) {
        Intent intent = new Intent(activity, RunTaskService.class);
        intent.setAction("com.ape.offlinescriptmanager.view.RunTaskService.action.start");
        if (Build.VERSION.SDK_INT >= 26) {
            activity.startForegroundService(intent);
        } else {
            activity.startService(intent);
        }
    }

    @Override // com.ape.offlinescriptmanager.utils.l.f.a
    public void a(b.b.a.a.c.c cVar) {
        Message obtainMessage = this.f2140c.obtainMessage();
        obtainMessage.obj = String.format("Current:%s", cVar.b());
        this.f2140c.sendMessage(obtainMessage);
    }

    @Override // com.ape.offlinescriptmanager.utils.l.f.a
    public h b(h hVar) {
        hVar.a("startbattery", String.valueOf(com.ape.offlinescriptmanager.utils.a.c(this).b()));
        return hVar;
    }

    @Override // com.ape.offlinescriptmanager.utils.l.f.a
    public void c(b.b.a.a.c.f fVar) {
        String q = g.q();
        this.i = q;
        this.f2139b.c(q, fVar);
    }

    @Override // com.ape.offlinescriptmanager.utils.l.f.a
    public h d(h hVar) {
        if (hVar == null) {
            return null;
        }
        if (hVar.j() == b.b.a.a.b.g.RUNNING) {
            hVar.o(b.b.a.a.b.g.PASS);
        }
        hVar.l(g.m());
        if (hVar.j().equals(b.b.a.a.b.g.FAILURE) || hVar.j().equals(b.b.a.a.b.g.ERROR) || hVar.j().equals(b.b.a.a.b.g.INCOMPLETE)) {
            this.j++;
        } else if (hVar.j().a().equals(b.b.a.a.b.g.PASS.a())) {
            this.k++;
        }
        Message obtainMessage = this.f2140c.obtainMessage();
        obtainMessage.obj = String.format("Pass:%s;Fail:%s", Integer.valueOf(this.k), Integer.valueOf(this.j));
        this.f2140c.sendMessage(obtainMessage);
        String g = hVar.g();
        int intValue = Integer.valueOf(hVar.h().get("startbattery")).intValue();
        int b2 = com.ape.offlinescriptmanager.utils.a.c(this).b();
        com.ape.offlinescriptmanager.utils.a.c(this).g(g, hVar.j().a(), hVar.i(), hVar.e(), intValue, b2, Integer.valueOf(hVar.h().get("regression")).intValue());
        hVar.a("stopbattery", String.valueOf(b2));
        return hVar;
    }

    @Override // com.ape.offlinescriptmanager.utils.l.f.a
    public void e(b.b.a.a.c.f fVar) {
        if (n(k(this.i))) {
            Map<String, Object> n = this.f2141d.n();
            l(n, this.i, getBaseContext());
            r(n);
        }
        Message obtainMessage = this.f2140c.obtainMessage();
        obtainMessage.obj = String.format("Finished;Pass:%s;Fail:%s", Integer.valueOf(this.k), Integer.valueOf(this.j));
        this.f2140c.sendMessage(obtainMessage);
        h(this.i);
        stopForeground(true);
        stopSelf();
        com.ape.offlinescriptmanager.utils.b.a();
    }

    public String i() {
        return Build.MODEL;
    }

    public String j(Context context) {
        String m = m(context, "ro.internal.build.version");
        return m.equals(BuildConfig.FLAVOR) ? m(context, "ro.tinternal.build.version") : m;
    }

    public File k(String str) {
        return new File(com.ape.offlinescriptmanager.utils.f.a().h(str), "TESTS-RealResult-TestPoints.xml");
    }

    public Map<String, Object> l(Map<String, Object> map, String str, Context context) {
        SharedPreferences sharedPreferences = context.getSharedPreferences("test_task_data", 0);
        if (map != null) {
            map.put("reslut_dir_name", str);
            map.put("task_creator", sharedPreferences.getString("task_creator", "tester"));
            map.put("device_project", i());
            map.put("device_version", j(context));
        }
        return map;
    }

    public boolean n(File file) {
        if (!file.exists()) {
            Log.e(l, "load result xml file fail have no xml file");
            com.ape.offlinescriptmanager.utils.b.c("load result xml file fail have no xml file");
            return false;
        }
        com.ape.offlinescriptmanager.utils.b.h("load result xml file start");
        String str = l;
        Log.v(str, "load result xml file start");
        this.f2141d = new c();
        try {
            this.f2141d.c(new BufferedInputStream(new FileInputStream(file)));
            com.ape.offlinescriptmanager.utils.b.h("load result xml file end");
            Log.v(str, "load result xml file end");
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            com.ape.offlinescriptmanager.utils.b.c("load result xml file fail");
            Log.e(l, "load result xml file fail");
            return false;
        }
    }

    @Override // android.app.Service
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override // android.app.Service
    public void onCreate() {
        super.onCreate();
        this.e = (NotificationManager) getSystemService("notification");
        if (Build.VERSION.SDK_INT >= 26) {
            NotificationChannel notificationChannel = new NotificationChannel("offlinescriptmanager_id", "offlinescriptmanager_name", 3);
            this.f = notificationChannel;
            notificationChannel.enableLights(true);
            this.f.setLightColor(-16711936);
            this.f.setShowBadge(false);
            this.e.createNotificationChannel(this.f);
        }
    }

    @Override // android.app.Service
    public void onDestroy() {
        Log.v(l, "onDestroy");
        super.onDestroy();
    }

    @Override // android.app.Service
    public int onStartCommand(Intent intent, int i, int i2) {
        String action = intent.getAction();
        action.hashCode();
        if (action.equals("com.ape.offlinescriptmanager.view.RunTaskService.action.start")) {
            o();
            return 2;
        } else if (action.equals("com.ape.offlinescriptmanager.view.RunTaskService.action.stop")) {
            p();
            return 2;
        } else {
            return 2;
        }
    }

    public boolean r(Map<String, Object> map) {
        if (map == null || !new com.ape.offlinescriptmanager.utils.l.h(map).e()) {
            com.ape.offlinescriptmanager.utils.b.c("upload result xml file fail, test_result_map is null");
            Log.e(l, "upload result xml file fail, test_result_map is null");
            return false;
        }
        com.ape.offlinescriptmanager.utils.b.h("send result xml file to master is success");
        Log.v(l, "send result xml file to master is success");
        return true;
    }
}
