package b.b.a.a.c;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
/* loaded from: classes.dex */
public class h implements b, Serializable {

    /* renamed from: b  reason: collision with root package name */
    private String f1385b;

    /* renamed from: c  reason: collision with root package name */
    private int f1386c = 0;

    /* renamed from: d  reason: collision with root package name */
    private boolean f1387d = true;
    private int e = 0;
    private ArrayList<c> f = new ArrayList<>();

    @Override // b.b.a.a.c.b
    public int a() {
        return this.f1386c;
    }

    @Override // b.b.a.a.c.b
    public void b(int i) {
        this.f1386c = i;
    }

    public void c(c cVar) {
        if (cVar == null) {
            return;
        }
        this.f.add(cVar);
    }

    public int d() {
        return this.e;
    }

    public ArrayList<c> e() {
        return this.f;
    }

    public List<c> f() {
        return Collections.unmodifiableList(this.f);
    }

    public boolean g() {
        return this.f1387d;
    }

    @Override // b.b.a.a.c.b
    public String getName() {
        return this.f1385b;
    }

    public void h(String str) {
        this.f1385b = str;
    }

    public void i(int i) {
        this.e = i;
    }

    public void j(boolean z) {
        this.f1387d = z;
    }
}
