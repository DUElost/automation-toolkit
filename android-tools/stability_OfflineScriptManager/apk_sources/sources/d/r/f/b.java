package d.r.f;

import d.c;
import d.e;
import d.j;
/* loaded from: classes.dex */
public class b extends j {
    private final d.r.b A;

    public b(c cVar, int i, int i2) {
        super(cVar, i, i2);
        this.e.j = 8;
        this.A = new d.r.b();
    }

    @Override // d.j
    protected void k1(d.p.b bVar, boolean z) {
        bVar.N0();
        this.A.b(bVar);
    }

    @Override // d.j
    protected void m1(d.p.b bVar) {
        this.A.d(bVar);
    }

    @Override // d.j
    public boolean o1(e eVar) {
        return this.A.c(eVar, this.l, null);
    }

    @Override // d.j
    protected void q1(d.p.b bVar) {
        this.A.a(bVar);
    }
}
