package androidx.core.app;

import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
/* loaded from: classes.dex */
public class a extends androidx.core.content.a {

    /* renamed from: c  reason: collision with root package name */
    private static c f830c;

    /* renamed from: androidx.core.app.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    static class RunnableC0030a implements Runnable {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ String[] f831b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ Activity f832c;

        /* renamed from: d  reason: collision with root package name */
        final /* synthetic */ int f833d;

        RunnableC0030a(String[] strArr, Activity activity, int i) {
            this.f831b = strArr;
            this.f832c = activity;
            this.f833d = i;
        }

        @Override // java.lang.Runnable
        public void run() {
            int[] iArr = new int[this.f831b.length];
            PackageManager packageManager = this.f832c.getPackageManager();
            String packageName = this.f832c.getPackageName();
            int length = this.f831b.length;
            for (int i = 0; i < length; i++) {
                iArr[i] = packageManager.checkPermission(this.f831b[i], packageName);
            }
            ((b) this.f832c).onRequestPermissionsResult(this.f833d, this.f831b, iArr);
        }
    }

    /* loaded from: classes.dex */
    public interface b {
        void onRequestPermissionsResult(int i, String[] strArr, int[] iArr);
    }

    /* loaded from: classes.dex */
    public interface c {
        boolean a(Activity activity, String[] strArr, int i);

        boolean b(Activity activity, int i, int i2, Intent intent);
    }

    /* loaded from: classes.dex */
    public interface d {
        void b(int i);
    }

    public static void h(Activity activity) {
        if (Build.VERSION.SDK_INT >= 16) {
            activity.finishAffinity();
        } else {
            activity.finish();
        }
    }

    public static c i() {
        return f830c;
    }

    public static void j(Activity activity, String[] strArr, int i) {
        c cVar = f830c;
        if (cVar == null || !cVar.a(activity, strArr, i)) {
            if (Build.VERSION.SDK_INT >= 23) {
                if (activity instanceof d) {
                    ((d) activity).b(i);
                }
                activity.requestPermissions(strArr, i);
            } else if (activity instanceof b) {
                new Handler(Looper.getMainLooper()).post(new RunnableC0030a(strArr, activity, i));
            }
        }
    }

    public static void k(Activity activity, Intent intent, int i, Bundle bundle) {
        if (Build.VERSION.SDK_INT >= 16) {
            activity.startActivityForResult(intent, i, bundle);
        } else {
            activity.startActivityForResult(intent, i);
        }
    }
}
