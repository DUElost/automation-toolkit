package b.e.a.j;

import android.util.Log;
/* loaded from: classes.dex */
public class a extends f {

    /* renamed from: a  reason: collision with root package name */
    String f1597a;

    public a(String str) {
        this.f1597a = str;
    }

    @Override // b.e.a.j.f
    public void b(String str) {
        Log.d("isoparser", String.valueOf(this.f1597a) + ":" + str);
    }

    @Override // b.e.a.j.f
    public void c(String str) {
        Log.e("isoparser", String.valueOf(this.f1597a) + ":" + str);
    }

    @Override // b.e.a.j.f
    public void d(String str) {
        Log.w("isoparser", String.valueOf(this.f1597a) + ":" + str);
    }
}
