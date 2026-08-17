package b.b.a.a.d;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class g implements c, Serializable {

    /* renamed from: c  reason: collision with root package name */
    private String f1405c;

    /* renamed from: d  reason: collision with root package name */
    private int f1406d;
    private String e;

    /* renamed from: b  reason: collision with root package name */
    private boolean f1404b = true;
    private List<b> f = new ArrayList();

    @Override // b.b.a.a.d.c
    public int a() {
        return this.f1406d;
    }

    @Override // b.b.a.a.d.c
    public String b() {
        return BuildConfig.FLAVOR;
    }

    @Override // b.b.a.a.d.c
    public void c(String str) {
        this.f1405c = str;
    }

    @Override // b.b.a.a.d.c
    public String d() {
        return this.f1405c;
    }

    @Override // b.b.a.a.d.c
    public List<b> e() {
        return this.f;
    }

    @Override // b.b.a.a.d.c
    public void f(b bVar) {
        if (bVar != null) {
            this.f.add(bVar);
        }
    }

    @Override // b.b.a.a.d.c
    public void g(String str) {
        this.e = str;
    }

    @Override // b.b.a.a.d.c
    public String getType() {
        return "TestCase";
    }

    @Override // b.b.a.a.d.c
    public String h() {
        return BuildConfig.FLAVOR;
    }

    @Override // b.b.a.a.d.c
    public String i() {
        return this.e;
    }

    @Override // b.b.a.a.d.c
    public boolean j() {
        return this.f1404b;
    }

    @Override // b.b.a.a.d.c
    public String k() {
        return BuildConfig.FLAVOR;
    }

    public void l(boolean z) {
        this.f1404b = z;
    }

    public void m(int i) {
        this.f1406d = i;
    }

    public void n(List<b> list) {
        this.f = list;
    }
}
