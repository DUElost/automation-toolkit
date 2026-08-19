package b.b.a.a.c;

import android.util.Log;
import java.util.ArrayList;
import java.util.Arrays;
/* loaded from: classes.dex */
public class i implements c {

    /* renamed from: c  reason: collision with root package name */
    private String f1390c;

    /* renamed from: d  reason: collision with root package name */
    private String f1391d;
    private String e;
    private String f;
    private String g;
    private String i;

    /* renamed from: a  reason: collision with root package name */
    private int f1388a = 0;

    /* renamed from: b  reason: collision with root package name */
    private int f1389b = 259200000;
    private String h = "android.support.test.runner.AndroidJUnitRunner";
    private ArrayList<a> j = new ArrayList<>();
    private boolean k = true;

    @Override // b.b.a.a.c.c
    public int a() {
        return this.f1388a;
    }

    @Override // b.b.a.a.c.c
    public String b() {
        return this.g;
    }

    @Override // b.b.a.a.c.c
    public b.b.a.a.b.b c(String str) {
        b.b.a.a.b.i iVar = new b.b.a.a.b.i(this.f1390c, str);
        iVar.g(this.f);
        iVar.i(this.g);
        iVar.j(this.f1391d);
        iVar.h(this.i);
        return iVar;
    }

    @Override // b.b.a.a.c.c
    public void d(boolean z) {
        this.k = z;
    }

    @Override // b.b.a.a.c.c
    public void e(b.b.a.a.b.b bVar) {
        String m = m();
        com.ape.offlinescriptmanager.utils.l.c cVar = new com.ape.offlinescriptmanager.utils.l.c(bVar);
        try {
            Log.v("STEVEN_LOG", m);
            com.ape.offlinescriptmanager.utils.b.i("run cmd %s", m);
            com.ape.offlinescriptmanager.utils.b.i("UiAuto2.mTestTimeOut: %s", Integer.valueOf(this.f1389b));
            com.ape.offlinescriptmanager.utils.l.d.a(m, cVar, this.f1389b);
        } catch (Exception e) {
            e.printStackTrace();
            cVar.g(Arrays.toString(e.getStackTrace()));
        }
    }

    @Override // b.b.a.a.c.c
    public boolean f() {
        return this.k;
    }

    @Override // b.b.a.a.c.c
    public boolean g() {
        com.ape.offlinescriptmanager.utils.g.E(this.j);
        com.ape.offlinescriptmanager.utils.g.O(k(), j(), l(), n(), this.j);
        return true;
    }

    public void h(a aVar) {
        this.j.add(aVar);
    }

    protected String i() {
        return String.format(" -e %1$s %2$s", "class", this.f + '#' + this.g);
    }

    public String j() {
        return this.f;
    }

    public String k() {
        return this.e;
    }

    public String l() {
        return this.g;
    }

    protected String m() {
        return String.format("am instrument -w %s %s/%s", i(), this.f1391d, this.h);
    }

    public String n() {
        return this.h;
    }

    public void o(String str) {
        this.f1390c = str;
    }

    public void p(String str) {
        this.f = str;
    }

    public void q(String str) {
        this.e = str;
    }

    public void r(String str) {
        this.i = str;
    }

    public void s(String str) {
        this.g = str;
    }

    public void t(String str) {
        this.f1391d = str;
    }

    public void u(String str) {
        this.h = str;
    }

    public void v(int i) {
        this.f1389b = i;
    }

    public void w(int i) {
        this.f1388a = i;
    }
}
