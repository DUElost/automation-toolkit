package a.f.h;

import android.os.Build;
import android.os.Trace;
/* loaded from: classes.dex */
public final class a {
    public static void a(String str) {
        if (Build.VERSION.SDK_INT >= 18) {
            Trace.beginSection(str);
        }
    }

    public static void b() {
        if (Build.VERSION.SDK_INT >= 18) {
            Trace.endSection();
        }
    }
}
