package com.ape.offlinescriptmanager.screenrecorder;

import android.annotation.TargetApi;
import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.ComponentName;
import android.content.Intent;
import android.content.ServiceConnection;
import android.content.SharedPreferences;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.hardware.display.VirtualDisplay;
import android.media.MediaRecorder;
import android.media.MediaScannerConnection;
import android.media.projection.MediaProjection;
import android.media.projection.MediaProjectionManager;
import android.net.Uri;
import android.os.Build;
import android.os.Environment;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.os.Message;
import android.preference.PreferenceManager;
import android.util.DisplayMetrics;
import android.util.Log;
import android.util.SparseIntArray;
import android.view.WindowManager;
import android.widget.Toast;
import androidx.core.app.g;
import com.ape.offlinescriptmanager.screenrecorder.FloatingControlService;
import com.ape.offlinescriptmanager.screenrecorder.a;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class RecorderService extends Service {
    private static final SparseIntArray s;
    private static int t;
    private static int u;
    private static int v;
    private static int w;
    private static int x;
    private static boolean y;
    private static String z;

    /* renamed from: b  reason: collision with root package name */
    private boolean f1998b;

    /* renamed from: c  reason: collision with root package name */
    private boolean f1999c;

    /* renamed from: d  reason: collision with root package name */
    private boolean f2000d;
    private FloatingControlService e;
    private long h;
    private SharedPreferences j;
    private WindowManager k;
    private MediaProjection l;
    private VirtualDisplay m;
    private d n;
    private MediaRecorder o;
    private NotificationManager p;
    private boolean f = false;
    private ServiceConnection g = new a();
    private long i = 0;
    private NotificationChannel q = null;
    Handler r = new c(Looper.getMainLooper());

    /* loaded from: classes.dex */
    class a implements ServiceConnection {
        a() {
        }

        @Override // android.content.ServiceConnection
        public void onServiceConnected(ComponentName componentName, IBinder iBinder) {
            RecorderService.this.e = ((FloatingControlService.e) iBinder).a();
            RecorderService.this.f = true;
        }

        @Override // android.content.ServiceConnection
        public void onServiceDisconnected(ComponentName componentName) {
            RecorderService.this.e = null;
            RecorderService.this.f = false;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b implements MediaScannerConnection.OnScanCompletedListener {
        b() {
        }

        @Override // android.media.MediaScannerConnection.OnScanCompletedListener
        public void onScanCompleted(String str, Uri uri) {
            Log.i("SCREENRECORDER", "SCAN COMPLETED: " + str);
            RecorderService.this.r.obtainMessage().sendToTarget();
            RecorderService.this.stopSelf();
        }
    }

    /* loaded from: classes.dex */
    class c extends Handler {
        c(Looper looper) {
            super(looper);
        }

        @Override // android.os.Handler
        public void handleMessage(Message message) {
            Toast.makeText(RecorderService.this, (int) R.string.screen_recording_stopped_toast, 0).show();
            RecorderService.this.p();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class d extends MediaProjection.Callback {
        private d() {
        }

        /* synthetic */ d(RecorderService recorderService, a aVar) {
            this();
        }

        @Override // android.media.projection.MediaProjection.Callback
        public void onStop() {
            Log.v("SCREENRECORDER", "Recording Stopped");
            RecorderService.this.r();
        }
    }

    static {
        SparseIntArray sparseIntArray = new SparseIntArray();
        s = sparseIntArray;
        sparseIntArray.append(0, 90);
        sparseIntArray.append(1, 0);
        sparseIntArray.append(2, 270);
        sparseIntArray.append(3, 180);
    }

    private Notification.Builder e(Notification.Action action) {
        Notification.Builder builder;
        Bitmap decodeResource = BitmapFactory.decodeResource(getResources(), R.mipmap.ic_launcher);
        Intent intent = new Intent(this, RecorderService.class);
        intent.setAction("com.ape.offlinescriptmanager.screenrecorder.services.action.stoprecording");
        PendingIntent service = PendingIntent.getService(this, 0, intent, 0);
        PendingIntent activity = PendingIntent.getActivity(this, 0, new Intent(this, ScreenRecorderActivity.class), 0);
        if (Build.VERSION.SDK_INT >= 26) {
            builder = new Notification.Builder(this, "offlinescriptmanager_id");
            builder.setContentTitle(getResources().getString(R.string.screen_recording_notification_title));
            builder.setTicker(getResources().getString(R.string.screen_recording_notification_title));
            builder.setSmallIcon(R.drawable.ic_notification);
            builder.setLargeIcon(Bitmap.createScaledBitmap(decodeResource, 128, 128, false));
            builder.setUsesChronometer(true);
            builder.setOngoing(true);
            builder.setContentIntent(activity);
            builder.setPriority(2);
            builder.addAction(R.drawable.ic_notification_stop, getResources().getString(R.string.screen_recording_notification_action_stop), service).build();
        } else {
            builder = null;
        }
        if (action != null) {
            builder.addAction(action);
        }
        return builder;
    }

    private VirtualDisplay f() {
        return this.l.createVirtualDisplay("ScreenRecorderActivity", t, u, w, 16, this.o.getSurface(), null, null);
    }

    /* JADX WARN: Code restructure failed: missing block: B:15:0x007d, code lost:
        if (r0 == null) goto L7;
     */
    /* JADX WARN: Code restructure failed: missing block: B:17:0x0080, code lost:
        r6.f1998b = false;
     */
    /* JADX WARN: Code restructure failed: missing block: B:18:0x0082, code lost:
        return;
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private void g() {
        /*
            r6 = this;
            java.lang.String r0 = "SCREENRECORDER"
            r1 = 0
            r2 = 0
            android.media.MediaRecorder r3 = r6.o     // Catch: java.lang.Throwable -> L31 java.lang.RuntimeException -> L33
            r3.stop()     // Catch: java.lang.Throwable -> L31 java.lang.RuntimeException -> L33
            r6.k()     // Catch: java.lang.Throwable -> L31 java.lang.RuntimeException -> L33
            java.lang.String r3 = "MediaProjection Stopped"
            android.util.Log.i(r0, r3)     // Catch: java.lang.Throwable -> L31 java.lang.RuntimeException -> L33
            android.media.MediaRecorder r0 = r6.o
            r0.reset()
            android.hardware.display.VirtualDisplay r0 = r6.m
            r0.release()
            android.media.MediaRecorder r0 = r6.o
            r0.release()
            android.media.projection.MediaProjection r0 = r6.l
            if (r0 == 0) goto L80
        L24:
            com.ape.offlinescriptmanager.screenrecorder.RecorderService$d r3 = r6.n
            r0.unregisterCallback(r3)
            android.media.projection.MediaProjection r0 = r6.l
            r0.stop()
            r6.l = r2
            goto L80
        L31:
            r0 = move-exception
            goto L83
        L33:
            r3 = move-exception
            java.lang.StringBuilder r4 = new java.lang.StringBuilder     // Catch: java.lang.Throwable -> L31
            r4.<init>()     // Catch: java.lang.Throwable -> L31
            java.lang.String r5 = "Fatal exception! Destroying media projection failed.\n"
            r4.append(r5)     // Catch: java.lang.Throwable -> L31
            java.lang.String r3 = r3.getMessage()     // Catch: java.lang.Throwable -> L31
            r4.append(r3)     // Catch: java.lang.Throwable -> L31
            java.lang.String r3 = r4.toString()     // Catch: java.lang.Throwable -> L31
            android.util.Log.e(r0, r3)     // Catch: java.lang.Throwable -> L31
            java.io.File r3 = new java.io.File     // Catch: java.lang.Throwable -> L31
            java.lang.String r4 = com.ape.offlinescriptmanager.screenrecorder.RecorderService.z     // Catch: java.lang.Throwable -> L31
            r3.<init>(r4)     // Catch: java.lang.Throwable -> L31
            boolean r3 = r3.delete()     // Catch: java.lang.Throwable -> L31
            if (r3 == 0) goto L5e
            java.lang.String r3 = "Corrupted file delete successful"
            android.util.Log.d(r0, r3)     // Catch: java.lang.Throwable -> L31
        L5e:
            r0 = 2131689596(0x7f0f007c, float:1.9008212E38)
            java.lang.String r0 = r6.getString(r0)     // Catch: java.lang.Throwable -> L31
            android.widget.Toast r0 = android.widget.Toast.makeText(r6, r0, r1)     // Catch: java.lang.Throwable -> L31
            r0.show()     // Catch: java.lang.Throwable -> L31
            android.media.MediaRecorder r0 = r6.o
            r0.reset()
            android.hardware.display.VirtualDisplay r0 = r6.m
            r0.release()
            android.media.MediaRecorder r0 = r6.o
            r0.release()
            android.media.projection.MediaProjection r0 = r6.l
            if (r0 == 0) goto L80
            goto L24
        L80:
            r6.f1998b = r1
            return
        L83:
            android.media.MediaRecorder r1 = r6.o
            r1.reset()
            android.hardware.display.VirtualDisplay r1 = r6.m
            r1.release()
            android.media.MediaRecorder r1 = r6.o
            r1.release()
            android.media.projection.MediaProjection r1 = r6.l
            if (r1 == 0) goto La2
            com.ape.offlinescriptmanager.screenrecorder.RecorderService$d r3 = r6.n
            r1.unregisterCallback(r3)
            android.media.projection.MediaProjection r1 = r6.l
            r1.stop()
            r6.l = r2
        La2:
            throw r0
        */
        throw new UnsupportedOperationException("Method not decompiled: com.ape.offlinescriptmanager.screenrecorder.RecorderService.g():void");
    }

    private String h() {
        String string = this.j.getString(getString(R.string.filename_key), "yyyyMMdd_hhmmss");
        String string2 = this.j.getString(getString(R.string.fileprefix_key), "recording");
        Date time = Calendar.getInstance().getTime();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(string);
        return string2 + "_" + simpleDateFormat.format(time);
    }

    private String i() {
        DisplayMetrics displayMetrics = new DisplayMetrics();
        WindowManager windowManager = (WindowManager) getSystemService("window");
        this.k = windowManager;
        windowManager.getDefaultDisplay().getMetrics(displayMetrics);
        w = displayMetrics.densityDpi;
        int i = displayMetrics.widthPixels;
        int i2 = displayMetrics.heightPixels;
        return i + "x" + i2;
    }

    private void k() {
        ArrayList arrayList = new ArrayList();
        arrayList.add(z);
        MediaScannerConnection.scanFile(this, (String[]) arrayList.toArray(new String[arrayList.size()]), null, new b());
    }

    private void l() {
        try {
            if (y) {
                this.o.setAudioSource(1);
            }
            this.o.setVideoSource(2);
            this.o.setOutputFormat(2);
            this.o.setOutputFile(z);
            this.o.setVideoSize(t, u);
            this.o.setVideoEncoder(2);
            if (y) {
                this.o.setAudioEncoder(3);
            }
            this.o.setVideoEncodingBitRate(x);
            this.o.setVideoFrameRate(v);
            this.o.setOrientationHint(s.get(this.k.getDefaultDisplay().getRotation() + 90));
            this.o.prepare();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @TargetApi(26)
    private void m() {
        this.o.pause();
        this.i += System.currentTimeMillis() - this.h;
        Intent intent = new Intent(this, RecorderService.class);
        intent.setAction("com.ape.offlinescriptmanager.screenrecorder.services.action.resumerecording");
        s(e(new Notification.Action(17301540, getString(R.string.screen_recording_notification_action_resume), PendingIntent.getService(this, 0, intent, 0))).setUsesChronometer(false).build(), 5001);
        Toast.makeText(this, (int) R.string.screen_recording_paused_toast, 0).show();
        if (this.f) {
            this.e.k(a.EnumC0076a.PAUSED);
        }
        if (this.f2000d) {
            Intent intent2 = new Intent();
            intent2.setAction("com.orpheusdroid.screenrecorder.DISABLETOUCH");
            intent2.addFlags(32);
            sendBroadcast(intent2);
        }
    }

    @TargetApi(26)
    private void n() {
        this.o.resume();
        this.h = System.currentTimeMillis();
        Intent intent = new Intent(this, RecorderService.class);
        intent.setAction("com.ape.offlinescriptmanager.screenrecorder.services.action.pauserecording");
        s(e(new Notification.Action(17301539, getString(R.string.screen_recording_notification_action_pause), PendingIntent.getService(this, 0, intent, 0))).setUsesChronometer(true).setWhen(System.currentTimeMillis() - this.i).build(), 5001);
        Toast.makeText(this, (int) R.string.screen_recording_resumed_toast, 0).show();
        if (this.f) {
            this.e.k(a.EnumC0076a.RECORDING);
        }
        boolean z2 = this.f2000d;
        if (z2 && z2) {
            Intent intent2 = new Intent();
            intent2.setAction("com.orpheusdroid.screenrecorder.SHOWTOUCH");
            intent2.addFlags(32);
            sendBroadcast(intent2);
        }
    }

    private void o(String str) {
        String[] split = str.split("x");
        t = Integer.parseInt(split[0]);
        u = Integer.parseInt(split[1]);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void p() {
        Bitmap decodeResource = BitmapFactory.decodeResource(getResources(), R.mipmap.ic_launcher);
        Intent intent = new Intent();
        Intent intent2 = new Intent(this, EditVideoActivity.class);
        intent2.putExtra("edit_video", z);
        PendingIntent activity = PendingIntent.getActivity(this, 0, intent2, 134217728);
        PendingIntent activity2 = PendingIntent.getActivity(this, 0, Intent.createChooser(intent, getString(R.string.share_intent_title)), 134217728);
        g.b bVar = new g.b(this);
        bVar.i(getString(R.string.share_intent_notification_title));
        bVar.h(getString(R.string.share_intent_notification_content));
        bVar.l(R.drawable.ic_notification);
        bVar.k(Bitmap.createScaledBitmap(decodeResource, 128, 128, false));
        bVar.f(true);
        bVar.g(activity2);
        bVar.a(17301586, getString(R.string.share_intent_notification_action_text), activity2);
        bVar.a(17301566, getString(R.string.edit_intent_notification_action_text), activity);
        s(bVar.b(), 5002);
    }

    private void q(Notification notification, int i) {
        startForeground(i, notification);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void r() {
        if (this.m == null) {
            return;
        }
        g();
    }

    private void s(Notification notification, int i) {
        ((NotificationManager) getSystemService("notification")).notify(i, notification);
    }

    public void j() {
        SharedPreferences defaultSharedPreferences = PreferenceManager.getDefaultSharedPreferences(this);
        this.j = defaultSharedPreferences;
        o(defaultSharedPreferences.getString(getString(R.string.res_key), i()));
        v = Integer.parseInt(this.j.getString(getString(R.string.fps_key), "30"));
        x = Integer.parseInt(this.j.getString(getString(R.string.bitrate_key), "7130317"));
        y = this.j.getBoolean(getString(R.string.audiorec_key), false);
        String string = this.j.getString(getString(R.string.savelocation_key), com.ape.offlinescriptmanager.screenrecorder.a.f2012a);
        File file = new File(string);
        if (Environment.getExternalStorageState().equals("mounted") && !file.isDirectory()) {
            file.mkdirs();
        }
        this.f1999c = this.j.getBoolean(getString(R.string.preference_floating_control_key), false);
        this.f2000d = this.j.getBoolean(getString(R.string.preference_show_touch_key), false);
        String h = h();
        z = string + File.separator + h + ".mp4";
    }

    @Override // android.app.Service
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override // android.app.Service
    public void onCreate() {
        super.onCreate();
        this.p = (NotificationManager) getSystemService("notification");
        if (Build.VERSION.SDK_INT >= 26) {
            NotificationChannel notificationChannel = new NotificationChannel("offlinescriptmanager_id", "offlinescriptmanager_name", 3);
            this.q = notificationChannel;
            notificationChannel.enableLights(true);
            this.q.setLightColor(-16711936);
            this.q.setShowBadge(false);
            this.p.createNotificationChannel(this.q);
        }
    }

    @Override // android.app.Service
    public void onDestroy() {
        super.onDestroy();
    }

    /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
    @Override // android.app.Service
    public int onStartCommand(Intent intent, int i, int i2) {
        char c2;
        Notification.Builder e;
        String action = intent.getAction();
        action.hashCode();
        switch (action.hashCode()) {
            case -181038371:
                if (action.equals("com.ape.offlinescriptmanager.screenrecorder.services.action.pauserecording")) {
                    c2 = 0;
                    break;
                }
                c2 = 65535;
                break;
            case 546252237:
                if (action.equals("com.ape.offlinescriptmanager.screenrecorder.services.action.stoprecording")) {
                    c2 = 1;
                    break;
                }
                c2 = 65535;
                break;
            case 914912898:
                if (action.equals("com.ape.offlinescriptmanager.screenrecorder.services.action.resumerecording")) {
                    c2 = 2;
                    break;
                }
                c2 = 65535;
                break;
            case 1880124913:
                if (action.equals("com.ape.offlinescriptmanager.screenrecorder.services.action.startrecording")) {
                    c2 = 3;
                    break;
                }
                c2 = 65535;
                break;
            default:
                c2 = 65535;
                break;
        }
        switch (c2) {
            case 0:
                m();
                break;
            case 1:
                if (this.f) {
                    unbindService(this.g);
                }
                r();
                if (this.f2000d) {
                    Intent intent2 = new Intent();
                    intent2.setAction("com.orpheusdroid.screenrecorder.DISABLETOUCH");
                    intent2.addFlags(32);
                    sendBroadcast(intent2);
                }
                stopForeground(true);
                break;
            case 2:
                n();
                break;
            case 3:
                if (!this.f1998b) {
                    j();
                    int intExtra = intent.getIntExtra("recorder_intent_result", -1);
                    this.o = new MediaRecorder();
                    l();
                    this.n = new d(this, null);
                    MediaProjection mediaProjection = ((MediaProjectionManager) getSystemService("media_projection")).getMediaProjection(intExtra, (Intent) intent.getParcelableExtra("recorder_intent_data"));
                    this.l = mediaProjection;
                    mediaProjection.registerCallback(this.n, null);
                    this.m = f();
                    try {
                        this.o.start();
                        if (this.f1999c) {
                            Intent intent3 = new Intent(this, FloatingControlService.class);
                            startService(intent3);
                            bindService(intent3, this.g, 1);
                        }
                        if (this.f) {
                            this.e.k(a.EnumC0076a.RECORDING);
                        }
                        this.f1998b = true;
                        if (this.f2000d) {
                            Intent intent4 = new Intent();
                            intent4.setAction("com.orpheusdroid.screenrecorder.SHOWTOUCH");
                            intent4.addFlags(32);
                            sendBroadcast(intent4);
                        }
                        Toast.makeText(this, (int) R.string.screen_recording_started_toast, 0).show();
                    } catch (IllegalStateException unused) {
                        Log.d("SCREENRECORDER", "Mediarecorder reached Illegal state exception. Did you start the recording twice?");
                        Toast.makeText(this, (int) R.string.recording_failed_toast, 0).show();
                        this.f1998b = false;
                    }
                    if (Build.VERSION.SDK_INT >= 26) {
                        this.h = System.currentTimeMillis();
                        Intent intent5 = new Intent(this, RecorderService.class);
                        intent5.setAction("com.ape.offlinescriptmanager.screenrecorder.services.action.pauserecording");
                        e = e(new Notification.Action(17301539, getString(R.string.screen_recording_notification_action_pause), PendingIntent.getService(this, 0, intent5, 0)));
                    } else {
                        e = e(null);
                    }
                    q(e.build(), 5001);
                    break;
                } else {
                    Toast.makeText(this, (int) R.string.screenrecording_already_active_toast, 0).show();
                    break;
                }
        }
        return 1;
    }
}
