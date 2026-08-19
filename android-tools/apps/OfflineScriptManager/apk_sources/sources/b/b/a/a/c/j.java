package b.b.a.a.c;

import java.io.IOException;
import java.util.ArrayList;
import java.util.concurrent.TimeoutException;
/* loaded from: classes.dex */
public class j implements c {

    /* renamed from: c  reason: collision with root package name */
    private String f1394c;

    /* renamed from: d  reason: collision with root package name */
    private String f1395d;
    private String e;
    private String g;

    /* renamed from: a  reason: collision with root package name */
    private int f1392a = 0;

    /* renamed from: b  reason: collision with root package name */
    private int f1393b = 259200000;
    private String f = "android.support.test.runner.AndroidJUnitRunner";
    private ArrayList<a> h = new ArrayList<>();

    @Override // b.b.a.a.c.c
    public int a() {
        return this.f1392a;
    }

    @Override // b.b.a.a.c.c
    public String b() {
        return this.e;
    }

    @Override // b.b.a.a.c.c
    public b.b.a.a.b.b c(String str) {
        b.b.a.a.b.j jVar = new b.b.a.a.b.j(this.f1394c, str);
        jVar.g(this.f1395d);
        jVar.i(this.e);
        jVar.h(this.g);
        return jVar;
    }

    @Override // b.b.a.a.c.c
    public void d(boolean z) {
    }

    @Override // b.b.a.a.c.c
    public void e(b.b.a.a.b.b bVar) {
        String m = m();
        com.ape.offlinescriptmanager.utils.l.g gVar = new com.ape.offlinescriptmanager.utils.l.g(bVar);
        try {
            com.ape.offlinescriptmanager.utils.b.i("rum cmd %s", m);
            com.ape.offlinescriptmanager.utils.l.d.a(m, gVar, this.f1393b);
        } catch (IOException | TimeoutException e) {
            e.printStackTrace();
            gVar.i(e.getStackTrace().toString());
        }
    }

    @Override // b.b.a.a.c.c
    public boolean f() {
        return false;
    }

    @Override // b.b.a.a.c.c
    public boolean g() {
        com.ape.offlinescriptmanager.utils.g.E(this.h);
        com.ape.offlinescriptmanager.utils.g.O(k(), j(), l(), n(), this.h);
        return true;
    }

    public void h(a aVar) {
        this.h.add(aVar);
    }

    protected String i() {
        return String.format(" -e %1$s %2$s", "class", this.f1395d + '#' + this.e);
    }

    public String j() {
        return this.f1395d;
    }

    public String k() {
        return this.f1394c;
    }

    public String l() {
        return this.e;
    }

    protected String m() {
        return String.format("%s runtest %s %s", "/system/bin/uiautomator", this.f1394c, i());
    }

    public String n() {
        return this.f;
    }

    public void o(String str) {
        this.f1395d = str;
    }

    public void p(String str) {
        this.g = str;
    }

    public void q(String str) {
        this.f1394c = str;
    }

    public void r(String str) {
        this.e = str;
    }

    public void s(String str) {
        this.f = str;
    }

    public void t(int i) {
        this.f1393b = i;
    }

    public void u(int i) {
        this.f1392a = i;
    }
}
