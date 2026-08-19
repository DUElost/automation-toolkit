package xcrash;

import android.util.Log;
/* loaded from: classes.dex */
class b implements f {
    @Override // xcrash.f
    public void a(String str, String str2, Throwable th) {
        Log.w(str, str2, th);
    }

    @Override // xcrash.f
    public void b(String str, String str2) {
        Log.e(str, str2);
    }

    @Override // xcrash.f
    public void c(String str, String str2, Throwable th) {
        Log.i(str, str2, th);
    }

    @Override // xcrash.f
    public void d(String str, String str2, Throwable th) {
        Log.e(str, str2, th);
    }
}
