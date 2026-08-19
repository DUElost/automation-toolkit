package b.b.a.a.b;

import java.util.Arrays;
import java.util.List;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class j implements b {

    /* renamed from: a  reason: collision with root package name */
    private String f1366a;

    /* renamed from: b  reason: collision with root package name */
    private String f1367b;

    /* renamed from: c  reason: collision with root package name */
    private String f1368c;

    /* renamed from: d  reason: collision with root package name */
    private String f1369d;
    private String e;
    private h f;
    private c g = null;
    private boolean h = false;
    private boolean i = false;

    public j(String str, String str2) {
        this.f1368c = str;
        this.f1366a = str2;
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

    public static String f() {
        return "uiautomator";
    }

    @Override // b.b.a.a.b.b
    public void a(h hVar) {
        this.f = hVar;
        f fVar = new f();
        this.g = fVar;
        fVar.i(this.f1368c);
        this.g.j(this.f1369d);
        this.g.e(this.e);
        this.g.h(this.f1366a);
        this.g.c(this.f1367b);
        this.g.g(g.NOTEXECUTED);
        this.g.l(f());
        this.f.b(this.g);
    }

    @Override // b.b.a.a.b.b
    public void b() {
        if (this.h) {
            return;
        }
        this.h = true;
        long m = com.ape.offlinescriptmanager.utils.g.m();
        this.g.m(m);
        this.g.n(m);
        com.ape.offlinescriptmanager.utils.b.i("start time %s", com.ape.offlinescriptmanager.utils.g.y(m));
    }

    @Override // b.b.a.a.b.b
    public void c() {
        if (this.i) {
            return;
        }
        this.i = true;
        long m = com.ape.offlinescriptmanager.utils.g.m();
        this.g.n(m);
        if (this.g.o() == g.NOTEXECUTED) {
            this.g.g(g.PASS);
            com.ape.offlinescriptmanager.utils.b.i("%s#%s pass", this.f1369d, this.e);
        }
        com.ape.offlinescriptmanager.utils.b.i("end time %s", com.ape.offlinescriptmanager.utils.g.y(m));
    }

    @Override // b.b.a.a.b.b
    public void d(String str) {
        c cVar = this.g;
        g gVar = g.FAILURE;
        cVar.g(gVar);
        this.f.o(gVar);
        e(this.g, com.ape.offlinescriptmanager.utils.g.c(str));
        com.ape.offlinescriptmanager.utils.b.i("%s#%s  fail", this.f1369d, this.e);
    }

    public void g(String str) {
        this.f1369d = str;
    }

    public void h(String str) {
        this.f1367b = str;
    }

    public void i(String str) {
        this.e = str;
    }
}
