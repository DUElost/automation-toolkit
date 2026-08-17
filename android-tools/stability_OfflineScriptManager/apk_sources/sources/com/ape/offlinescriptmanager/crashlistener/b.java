package com.ape.offlinescriptmanager.crashlistener;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Bitmap;
import android.hardware.display.VirtualDisplay;
import android.media.Image;
import android.media.ImageReader;
import android.media.projection.MediaProjection;
import android.media.projection.MediaProjectionManager;
import android.os.AsyncTask;
import android.os.Handler;
import android.preference.PreferenceManager;
import android.util.DisplayMetrics;
import android.view.WindowManager;
import com.ape.offlinescriptmanager.utils.g;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class b {
    private static Intent k;

    /* renamed from: a  reason: collision with root package name */
    private Context f1947a;

    /* renamed from: b  reason: collision with root package name */
    private MediaProjection f1948b;

    /* renamed from: c  reason: collision with root package name */
    private VirtualDisplay f1949c;

    /* renamed from: d  reason: collision with root package name */
    private int f1950d;
    private int e;
    private int f;
    private ImageReader g;
    private String h;
    private String i;
    private String j;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a implements Runnable {
        a() {
        }

        @Override // java.lang.Runnable
        public void run() {
            b.this.n();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: com.ape.offlinescriptmanager.crashlistener.b$b  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public class RunnableC0072b implements Runnable {
        RunnableC0072b() {
        }

        @Override // java.lang.Runnable
        public void run() {
            b.this.l();
        }
    }

    /* loaded from: classes.dex */
    public static final class c {
        @Deprecated
        public static <Params, Progress, Result> AsyncTask<Params, Progress, Result> a(AsyncTask<Params, Progress, Result> asyncTask, Params... paramsArr) {
            if (asyncTask != null) {
                asyncTask.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, paramsArr);
                return asyncTask;
            }
            throw new IllegalArgumentException("task can not be null");
        }
    }

    /* loaded from: classes.dex */
    public class d extends AsyncTask<Image, Void, Bitmap> {
        public d() {
        }

        /* JADX INFO: Access modifiers changed from: protected */
        /* JADX WARN: Removed duplicated region for block: B:24:0x00a4 A[RETURN] */
        @Override // android.os.AsyncTask
        /* renamed from: a */
        /*
            Code decompiled incorrectly, please refer to instructions dump.
            To view partially-correct add '--show-bad-code' argument
        */
        public android.graphics.Bitmap doInBackground(android.media.Image... r9) {
            /*
                r8 = this;
                boolean r0 = com.ape.offlinescriptmanager.crashlistener.CrashListenerService.h
                r1 = 0
                if (r0 == 0) goto L6
                return r1
            L6:
                if (r9 == 0) goto La5
                int r0 = r9.length
                r2 = 1
                if (r0 < r2) goto La5
                r0 = 0
                r2 = r9[r0]
                if (r2 != 0) goto L13
                goto La5
            L13:
                r9 = r9[r0]
                int r2 = r9.getWidth()
                int r3 = r9.getHeight()
                android.media.Image$Plane[] r4 = r9.getPlanes()
                r5 = r4[r0]
                java.nio.ByteBuffer r5 = r5.getBuffer()
                r6 = r4[r0]
                int r6 = r6.getPixelStride()
                r4 = r4[r0]
                int r4 = r4.getRowStride()
                int r7 = r6 * r2
                int r4 = r4 - r7
                int r4 = r4 / r6
                int r4 = r4 + r2
                android.graphics.Bitmap$Config r6 = android.graphics.Bitmap.Config.ARGB_8888
                android.graphics.Bitmap r4 = android.graphics.Bitmap.createBitmap(r4, r3, r6)
                r4.copyPixelsFromBuffer(r5)
                android.graphics.Bitmap r0 = android.graphics.Bitmap.createBitmap(r4, r0, r0, r2, r3)
                r9.close()
                if (r0 == 0) goto La1
                java.io.File r9 = new java.io.File     // Catch: java.io.IOException -> L98 java.io.FileNotFoundException -> L9d
                com.ape.offlinescriptmanager.crashlistener.b r2 = com.ape.offlinescriptmanager.crashlistener.b.this     // Catch: java.io.IOException -> L98 java.io.FileNotFoundException -> L9d
                java.lang.String r2 = com.ape.offlinescriptmanager.crashlistener.b.b(r2)     // Catch: java.io.IOException -> L98 java.io.FileNotFoundException -> L9d
                com.ape.offlinescriptmanager.crashlistener.b r3 = com.ape.offlinescriptmanager.crashlistener.b.this     // Catch: java.io.IOException -> L98 java.io.FileNotFoundException -> L9d
                java.lang.String r3 = com.ape.offlinescriptmanager.crashlistener.b.c(r3)     // Catch: java.io.IOException -> L98 java.io.FileNotFoundException -> L9d
                com.ape.offlinescriptmanager.crashlistener.b r4 = com.ape.offlinescriptmanager.crashlistener.b.this     // Catch: java.io.IOException -> L98 java.io.FileNotFoundException -> L9d
                java.lang.String r4 = com.ape.offlinescriptmanager.crashlistener.b.d(r4)     // Catch: java.io.IOException -> L98 java.io.FileNotFoundException -> L9d
                java.lang.String r2 = com.ape.offlinescriptmanager.utils.g.v(r2, r3, r4)     // Catch: java.io.IOException -> L98 java.io.FileNotFoundException -> L9d
                r9.<init>(r2)     // Catch: java.io.IOException -> L98 java.io.FileNotFoundException -> L9d
                boolean r2 = r9.exists()     // Catch: java.io.IOException -> L98 java.io.FileNotFoundException -> L9d
                if (r2 != 0) goto L6e
                r9.createNewFile()     // Catch: java.io.IOException -> L98 java.io.FileNotFoundException -> L9d
            L6e:
                java.io.FileOutputStream r2 = new java.io.FileOutputStream     // Catch: java.io.IOException -> L98 java.io.FileNotFoundException -> L9d
                r2.<init>(r9)     // Catch: java.io.IOException -> L98 java.io.FileNotFoundException -> L9d
                android.graphics.Bitmap$CompressFormat r3 = android.graphics.Bitmap.CompressFormat.PNG     // Catch: java.io.IOException -> L98 java.io.FileNotFoundException -> L9d
                r4 = 100
                r0.compress(r3, r4, r2)     // Catch: java.io.IOException -> L98 java.io.FileNotFoundException -> L9d
                r2.flush()     // Catch: java.io.IOException -> L98 java.io.FileNotFoundException -> L9d
                r2.close()     // Catch: java.io.IOException -> L98 java.io.FileNotFoundException -> L9d
                android.content.Intent r2 = new android.content.Intent     // Catch: java.io.IOException -> L98 java.io.FileNotFoundException -> L9d
                java.lang.String r3 = "android.intent.action.MEDIA_SCANNER_SCAN_FILE"
                r2.<init>(r3)     // Catch: java.io.IOException -> L98 java.io.FileNotFoundException -> L9d
                android.net.Uri r3 = android.net.Uri.fromFile(r9)     // Catch: java.io.IOException -> L98 java.io.FileNotFoundException -> L9d
                r2.setData(r3)     // Catch: java.io.IOException -> L98 java.io.FileNotFoundException -> L9d
                com.ape.offlinescriptmanager.crashlistener.b r3 = com.ape.offlinescriptmanager.crashlistener.b.this     // Catch: java.io.IOException -> L98 java.io.FileNotFoundException -> L9d
                android.content.Context r3 = com.ape.offlinescriptmanager.crashlistener.b.e(r3)     // Catch: java.io.IOException -> L98 java.io.FileNotFoundException -> L9d
                r3.sendBroadcast(r2)     // Catch: java.io.IOException -> L98 java.io.FileNotFoundException -> L9d
                goto La2
            L98:
                r9 = move-exception
                r9.printStackTrace()
                goto La1
            L9d:
                r9 = move-exception
                r9.printStackTrace()
            La1:
                r9 = r1
            La2:
                if (r9 == 0) goto La5
                return r0
            La5:
                return r1
            */
            throw new UnsupportedOperationException("Method not decompiled: com.ape.offlinescriptmanager.crashlistener.b.d.doInBackground(android.media.Image[]):android.graphics.Bitmap");
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // android.os.AsyncTask
        /* renamed from: b */
        public void onPostExecute(Bitmap bitmap) {
            super.onPostExecute(bitmap);
        }
    }

    public b(Context context) {
        this.f1947a = context;
        i();
    }

    private void f() {
        if (this.g == null) {
            this.g = ImageReader.newInstance(this.f1950d, this.e, 1, 1);
        }
    }

    private MediaProjectionManager h() {
        return (MediaProjectionManager) this.f1947a.getSystemService("media_projection");
    }

    public static void j(Intent intent) {
        k = intent;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void l() {
        Image acquireLatestImage = this.g.acquireLatestImage();
        if (acquireLatestImage == null) {
            m();
        } else {
            c.a(new d(), acquireLatestImage);
        }
    }

    private void o() {
        VirtualDisplay virtualDisplay = this.f1949c;
        if (virtualDisplay == null) {
            return;
        }
        virtualDisplay.release();
        this.f1949c = null;
    }

    private void p() {
        MediaProjection mediaProjection = this.f1948b;
        if (mediaProjection != null) {
            mediaProjection.stop();
            this.f1948b = null;
        }
    }

    private void q() {
        f();
        this.f1949c = this.f1948b.createVirtualDisplay("screen-mirror", this.f1950d, this.e, this.f, 16, this.g.getSurface(), null, null);
    }

    public void g() {
        o();
        p();
    }

    public void i() {
        DisplayMetrics displayMetrics = new DisplayMetrics();
        ((WindowManager) this.f1947a.getSystemService("window")).getDefaultDisplay().getMetrics(displayMetrics);
        this.f = displayMetrics.densityDpi;
        this.f1950d = displayMetrics.widthPixels;
        this.e = displayMetrics.heightPixels;
        SharedPreferences defaultSharedPreferences = PreferenceManager.getDefaultSharedPreferences(this.f1947a);
        this.h = defaultSharedPreferences.getString(this.f1947a.getString(R.string.crash_save_location_key), g.t());
        this.i = defaultSharedPreferences.getString(this.f1947a.getString(R.string.crash_file_name_key), this.f1947a.getString(R.string.crash_listener_filename_default));
        this.j = defaultSharedPreferences.getString(this.f1947a.getString(R.string.crash_file_name_prefix_key), this.f1947a.getString(R.string.crash_listener_prefix_default));
    }

    public void k() {
        if (k != null) {
            this.f1948b = h().getMediaProjection(-1, k);
            return;
        }
        Intent intent = new Intent("android.intent.action.MAIN");
        intent.addCategory("android.intent.category.LAUNCHER");
        this.f1947a.startActivity(intent);
    }

    public void m() {
        Handler handler = new Handler(this.f1947a.getMainLooper());
        handler.postDelayed(new a(), 5L);
        handler.postDelayed(new RunnableC0072b(), 30L);
    }

    public void n() {
        if (this.f1948b == null) {
            k();
        }
        q();
    }
}
