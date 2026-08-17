package b.b.a.a.b;

import java.util.Arrays;
import java.util.List;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class e implements b {

    /* renamed from: a  reason: collision with root package name */
    private String f1351a;

    /* renamed from: b  reason: collision with root package name */
    private String f1352b;

    /* renamed from: c  reason: collision with root package name */
    private String f1353c;

    /* renamed from: d  reason: collision with root package name */
    private String f1354d;
    private String e;
    private String f;
    private h g;
    private c h = null;

    public e(String str, String str2) {
        this.f1353c = str;
        this.f1351a = str2;
    }

    private void e(c cVar, String str) {
        int indexOf;
        List asList = Arrays.asList(str.split("\n"));
        cVar.k(str);
        if (asList == null) {
            return;
        }
        String str2 = BuildConfig.FLAVOR;
        boolean z = false;
        String str3 = BuildConfig.FLAVOR;
        for (int i = 0; i < asList.size(); i++) {
            int indexOf2 = ((String) asList.get(i)).indexOf("INSTRUMENTATION_PIC=");
            if (indexOf2 != -1) {
                str3 = ((String) asList.get(i)).substring(indexOf2 + 20).trim();
                if (!str3.isEmpty()) {
                    cVar.d(str3);
                }
                z = true;
            }
            if (((String) asList.get(i)).indexOf("Caused by:") != -1 && z) {
                str2 = ("INSTRUMENTATION_PIC=" + str3 + "\n") + ((String) asList.get(i)).substring(indexOf);
            } else if (!str2.isEmpty()) {
                str2 = (str2 + "\n") + ((String) asList.get(i));
            }
        }
        if (str2.isEmpty()) {
            return;
        }
        cVar.k(str2);
    }

    @Override // b.b.a.a.b.b
    public void a(h hVar) {
        this.g = hVar;
        f fVar = new f();
        this.h = fVar;
        fVar.i(this.f1353c);
        this.h.j(this.f1354d);
        this.h.e(this.e);
        this.h.h(this.f1351a);
        this.h.c(this.f1352b);
        this.h.g(g.NOTEXECUTED);
        this.h.f(this.f);
        this.h.l(f());
        this.g.b(this.h);
    }

    @Override // b.b.a.a.b.b
    public void b() {
        long m = com.ape.offlinescriptmanager.utils.g.m();
        this.h.m(m);
        this.h.n(m);
        com.ape.offlinescriptmanager.utils.b.i("start time %s", com.ape.offlinescriptmanager.utils.g.y(m));
    }

    @Override // b.b.a.a.b.b
    public void c() {
        long m = com.ape.offlinescriptmanager.utils.g.m();
        this.h.n(m);
        if (this.h.o() == g.NOTEXECUTED) {
            this.h.g(g.PASS);
            com.ape.offlinescriptmanager.utils.b.i("%s#%s pass", this.f1354d, this.e);
        }
        com.ape.offlinescriptmanager.utils.b.i("end time %s", com.ape.offlinescriptmanager.utils.g.y(m));
    }

    @Override // b.b.a.a.b.b
    public void d(String str) {
        c cVar = this.h;
        g gVar = g.FAILURE;
        cVar.g(gVar);
        this.g.o(gVar);
        e(this.h, com.ape.offlinescriptmanager.utils.g.c(str));
        com.ape.offlinescriptmanager.utils.b.i("%s#%s  fail", this.f1354d, this.e);
    }

    public String f() {
        return "robotium";
    }

    public void g(String str) {
        this.f1354d = str;
    }

    public void h(String str) {
        this.f1352b = str;
    }

    public void i(String str) {
        this.e = str;
    }

    public void j(String str) {
        this.f = str;
    }
}
