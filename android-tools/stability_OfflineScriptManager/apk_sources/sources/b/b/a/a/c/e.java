package b.b.a.a.c;

import java.io.IOException;
import java.util.concurrent.TimeoutException;
/* loaded from: classes.dex */
public class e implements c {

    /* renamed from: a  reason: collision with root package name */
    private int f1376a = 0;

    /* renamed from: b  reason: collision with root package name */
    private int f1377b = 259200000;

    /* renamed from: c  reason: collision with root package name */
    private String f1378c;

    /* renamed from: d  reason: collision with root package name */
    private String f1379d;
    private String e;
    private String f;
    private String g;

    @Override // b.b.a.a.c.c
    public int a() {
        return this.f1376a;
    }

    @Override // b.b.a.a.c.c
    public String b() {
        return this.f;
    }

    @Override // b.b.a.a.c.c
    public b.b.a.a.b.b c(String str) {
        b.b.a.a.b.e eVar = new b.b.a.a.b.e(this.f1378c, str);
        eVar.g(this.e);
        eVar.i(this.f);
        eVar.j(this.f1379d);
        eVar.h(this.g);
        return eVar;
    }

    @Override // b.b.a.a.c.c
    public void d(boolean z) {
    }

    @Override // b.b.a.a.c.c
    public void e(b.b.a.a.b.b bVar) {
        String i = i();
        com.ape.offlinescriptmanager.utils.l.c cVar = new com.ape.offlinescriptmanager.utils.l.c(bVar);
        try {
            com.ape.offlinescriptmanager.utils.b.i("rum cmd %s", i);
            com.ape.offlinescriptmanager.utils.l.d.a(i, cVar, this.f1377b);
        } catch (IOException | TimeoutException e) {
            e.printStackTrace();
            cVar.g(e.getStackTrace().toString());
        }
    }

    @Override // b.b.a.a.c.c
    public boolean f() {
        return false;
    }

    @Override // b.b.a.a.c.c
    public boolean g() {
        return true;
    }

    protected String h() {
        return String.format(" -e %1$s %2$s", "class", this.e + '#' + this.f);
    }

    protected String i() {
        return String.format("am instrument %s -w %s/android.test.InstrumentationTestRunner", h(), this.f1379d);
    }

    public void j(String str) {
        this.f1378c = str;
    }

    public void k(String str) {
        this.e = str;
    }

    public void l(String str) {
    }

    public void m(String str) {
        this.g = str;
    }

    public void n(String str) {
        this.f = str;
    }

    public void o(String str) {
        this.f1379d = str;
    }

    public void p(String str) {
    }

    public void q(int i) {
        this.f1377b = i;
    }

    public void r(int i) {
        this.f1376a = i;
    }
}
