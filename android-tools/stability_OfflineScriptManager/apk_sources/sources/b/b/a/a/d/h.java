package b.b.a.a.d;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class h implements c, Serializable {

    /* renamed from: b  reason: collision with root package name */
    private boolean f1407b = true;

    /* renamed from: c  reason: collision with root package name */
    private String f1408c = BuildConfig.FLAVOR;

    /* renamed from: d  reason: collision with root package name */
    private int f1409d = 1;
    private String e = BuildConfig.FLAVOR;
    private List<c> f = new ArrayList();

    @Override // b.b.a.a.d.c
    public int a() {
        return this.f1409d;
    }

    @Override // b.b.a.a.d.c
    public String b() {
        return null;
    }

    @Override // b.b.a.a.d.c
    public void c(String str) {
    }

    @Override // b.b.a.a.d.c
    public String d() {
        return this.f1408c;
    }

    @Override // b.b.a.a.d.c
    public List<b> e() {
        return null;
    }

    @Override // b.b.a.a.d.c
    public void f(b bVar) {
    }

    @Override // b.b.a.a.d.c
    public void g(String str) {
        this.e = str;
    }

    @Override // b.b.a.a.d.c
    public String getType() {
        return null;
    }

    @Override // b.b.a.a.d.c
    public String h() {
        return null;
    }

    @Override // b.b.a.a.d.c
    public String i() {
        return this.e;
    }

    @Override // b.b.a.a.d.c
    public boolean j() {
        return this.f1407b;
    }

    @Override // b.b.a.a.d.c
    public String k() {
        return null;
    }

    public void l(c cVar) {
        if (cVar == null) {
            return;
        }
        this.f.add(cVar);
    }

    public String m() {
        return this.f1408c;
    }

    public List<c> n() {
        return this.f;
    }

    public void o(boolean z) {
        this.f1407b = z;
    }

    public void p(String str) {
        this.f1408c = str;
    }

    public void q(int i) {
        this.f1409d = i;
    }
}
