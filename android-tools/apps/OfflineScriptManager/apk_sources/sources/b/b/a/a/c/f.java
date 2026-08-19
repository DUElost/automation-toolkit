package b.b.a.a.c;

import java.io.Serializable;
import java.util.ArrayList;
/* loaded from: classes.dex */
public class f implements b, Serializable {

    /* renamed from: b  reason: collision with root package name */
    private String f1380b;

    /* renamed from: c  reason: collision with root package name */
    private int f1381c = 1;

    /* renamed from: d  reason: collision with root package name */
    private int f1382d = 259200000;
    private ArrayList<h> e = new ArrayList<>();
    private int f = 1;
    private int g = 0;
    private int h = 2;
    private boolean i = false;

    @Override // b.b.a.a.c.b
    public int a() {
        return this.f1381c;
    }

    @Override // b.b.a.a.c.b
    public void b(int i) {
        this.f1381c = i;
    }

    public void c(h hVar) {
        if (hVar == null) {
            return;
        }
        this.e.add(hVar);
    }

    public int d() {
        return this.g;
    }

    public boolean e() {
        return this.i;
    }

    public int f() {
        return this.f;
    }

    public int g() {
        return this.h;
    }

    @Override // b.b.a.a.c.b
    public String getName() {
        return this.f1380b;
    }

    public ArrayList<h> h() {
        return this.e;
    }

    public int i() {
        return this.f1382d;
    }

    public void j(int i) {
        this.g = i;
    }

    public void k(String str) {
        this.f1380b = str;
    }

    public void l(boolean z) {
        this.i = z;
    }

    public void m(int i) {
        this.f = i;
    }

    public void n(int i) {
        this.h = i;
    }

    public void o(int i) {
        this.f1382d = i;
    }
}
