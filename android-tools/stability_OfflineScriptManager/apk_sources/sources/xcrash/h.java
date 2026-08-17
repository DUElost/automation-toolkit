package xcrash;

import android.text.TextUtils;
/* loaded from: classes.dex */
public class h {
    public static boolean a(String str, String str2, String str3) {
        if (TextUtils.isEmpty(str) || TextUtils.isEmpty(str2) || str3 == null) {
            return false;
        }
        c l = c.l();
        return l.e(str, "\n\n" + str2 + ":\n" + str3 + "\n\n");
    }
}
