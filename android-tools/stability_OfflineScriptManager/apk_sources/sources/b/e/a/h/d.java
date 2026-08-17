package b.e.a.h;

import java.util.LinkedList;
import java.util.List;
/* loaded from: classes.dex */
public class d {

    /* renamed from: a  reason: collision with root package name */
    b.e.a.j.h f1531a = b.e.a.j.h.j;

    /* renamed from: b  reason: collision with root package name */
    List<g> f1532b = new LinkedList();

    public static long b(long j, long j2) {
        return j2 == 0 ? j : b(j2, j % j2);
    }

    public void a(g gVar) {
        if (f(gVar.z().h()) != null) {
            gVar.z().r(d());
        }
        this.f1532b.add(gVar);
    }

    public b.e.a.j.h c() {
        return this.f1531a;
    }

    public long d() {
        long j = 0;
        for (g gVar : this.f1532b) {
            if (j < gVar.z().h()) {
                j = gVar.z().h();
            }
        }
        return j + 1;
    }

    public long e() {
        long g = g().iterator().next().z().g();
        for (g gVar : g()) {
            g = b(gVar.z().g(), g);
        }
        return g;
    }

    public g f(long j) {
        for (g gVar : this.f1532b) {
            if (gVar.z().h() == j) {
                return gVar;
            }
        }
        return null;
    }

    public List<g> g() {
        return this.f1532b;
    }

    public void h(b.e.a.j.h hVar) {
        this.f1531a = hVar;
    }

    public void i(List<g> list) {
        this.f1532b = list;
    }

    public String toString() {
        String str = "Movie{ ";
        for (g gVar : this.f1532b) {
            str = String.valueOf(str) + "track_" + gVar.z().h() + " (" + gVar.r() + ") ";
        }
        return String.valueOf(str) + '}';
    }
}
