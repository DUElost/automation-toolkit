package xcrash;

import android.annotation.SuppressLint;
import android.content.Context;
import android.os.Build;
import android.text.TextUtils;
import java.io.File;
import java.util.Map;
/* JADX INFO: Access modifiers changed from: package-private */
@SuppressLint({"StaticFieldLeak"})
/* loaded from: classes.dex */
public class NativeHandler {
    private static final NativeHandler g = new NativeHandler();

    /* renamed from: b  reason: collision with root package name */
    private Context f2822b;

    /* renamed from: a  reason: collision with root package name */
    private long f2821a = 15000;

    /* renamed from: c  reason: collision with root package name */
    private d f2823c = null;

    /* renamed from: d  reason: collision with root package name */
    private d f2824d = null;
    private boolean e = false;
    private boolean f = false;

    private NativeHandler() {
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static NativeHandler a() {
        return g;
    }

    private static String b(boolean z, String str) {
        try {
            for (Map.Entry<Thread, StackTraceElement[]> entry : Thread.getAllStackTraces().entrySet()) {
                Thread key = entry.getKey();
                if ((z && key.getName().equals("main")) || (!z && key.getName().contains(str))) {
                    StringBuilder sb = new StringBuilder();
                    StackTraceElement[] value = entry.getValue();
                    for (StackTraceElement stackTraceElement : value) {
                        sb.append("    at ");
                        sb.append(stackTraceElement.toString());
                        sb.append("\n");
                    }
                    return sb.toString();
                }
            }
            return null;
        } catch (Exception e) {
            j.a().d("xcrash", "NativeHandler getStacktraceByThreadName failed", e);
            return null;
        }
    }

    private static void crashCallback(String str, String str2, boolean z, boolean z2, String str3) {
        if (!TextUtils.isEmpty(str)) {
            if (z) {
                String b2 = b(z2, str3);
                if (!TextUtils.isEmpty(b2)) {
                    h.a(str, "java stacktrace", b2);
                }
            }
            h.a(str, "memory info", i.k());
        }
        d dVar = a().f2823c;
        if (dVar != null) {
            try {
                dVar.a(str, str2);
            } catch (Exception e) {
                j.a().a("xcrash", "NativeHandler native crash callback.onCrash failed", e);
            }
        }
    }

    private static native int nativeInit(int i, String str, String str2, String str3, String str4, String str5, String str6, String str7, String str8, String str9, String str10, boolean z, boolean z2, int i2, int i3, int i4, boolean z3, boolean z4, boolean z5, boolean z6, int i5, String[] strArr, boolean z7, boolean z8, int i6, int i7, int i8, boolean z9);

    private static native void nativeNotifyJavaCrashed();

    private static native void nativeTestCrash(int i);

    private static void traceCallback(String str, String str2) {
        if (TextUtils.isEmpty(str)) {
            return;
        }
        h.a(str, "memory info", i.k());
        if (!i.b(a().f2822b, a().f2821a)) {
            c.l().q(new File(str));
        } else if (c.l().p()) {
            String str3 = str.substring(0, str.length() - 13) + ".anr.xcrash";
            File file = new File(str);
            if (!file.renameTo(new File(str3))) {
                c.l().q(file);
                return;
            }
            d dVar = a().f2824d;
            if (dVar != null) {
                try {
                    dVar.a(str3, str2);
                } catch (Exception e) {
                    j.a().a("xcrash", "NativeHandler ANR callback.onCrash failed", e);
                }
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int c(Context context, e eVar, String str, String str2, String str3, boolean z, boolean z2, int i, int i2, int i3, boolean z3, boolean z4, boolean z5, boolean z6, int i4, String[] strArr, d dVar, boolean z7, boolean z8, int i5, int i6, int i7, boolean z9, d dVar2) {
        Throwable th;
        f a2;
        String str4;
        if (eVar == null) {
            try {
                System.loadLibrary("xcrash");
            } catch (Throwable th2) {
                th = th2;
                a2 = j.a();
                str4 = "NativeHandler System.loadLibrary failed";
                a2.d("xcrash", str4, th);
                return -2;
            }
        } else {
            try {
                eVar.a("xcrash");
            } catch (Throwable th3) {
                th = th3;
                a2 = j.a();
                str4 = "NativeHandler ILibLoader.loadLibrary failed";
                a2.d("xcrash", str4, th);
                return -2;
            }
        }
        this.f2822b = context;
        this.f2823c = dVar;
        this.f2824d = dVar2;
        this.f = z7;
        this.f2821a = z8 ? 15000L : 30000L;
        try {
            if (nativeInit(Build.VERSION.SDK_INT, Build.VERSION.RELEASE, i.c(), Build.MANUFACTURER, Build.BRAND, Build.MODEL, Build.FINGERPRINT, str, str2, context.getApplicationInfo().nativeLibraryDir, str3, z, z2, i, i2, i3, z3, z4, z5, z6, i4, strArr, z7, z8, i5, i6, i7, z9) != 0) {
                j.a().b("xcrash", "NativeHandler init failed");
                return -3;
            }
            this.e = true;
            return 0;
        } catch (Throwable th4) {
            j.a().d("xcrash", "NativeHandler init failed", th4);
            return -3;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void d() {
        if (this.e && this.f) {
            nativeNotifyJavaCrashed();
        }
    }
}
