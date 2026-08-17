package a.m;

import android.os.Build;
import android.view.ViewGroup;
/* loaded from: classes.dex */
class x {
    /* JADX INFO: Access modifiers changed from: package-private */
    public static w a(ViewGroup viewGroup) {
        return Build.VERSION.SDK_INT >= 18 ? new v(viewGroup) : u.g(viewGroup);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static void b(ViewGroup viewGroup, boolean z) {
        if (Build.VERSION.SDK_INT >= 18) {
            z.b(viewGroup, z);
        } else {
            y.b(viewGroup, z);
        }
    }
}
