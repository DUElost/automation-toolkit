package d.r.h;

import d.e;
import d.f;
import d.j;
/* loaded from: classes.dex */
public class a extends j {
    private final d.r.a A;
    private final d.r.b B;
    private boolean C;

    public a(d.c cVar, int i, int i2) {
        super(cVar, i, i2);
        this.e.j = 5;
        this.A = new d.r.a();
        this.B = new d.r.b();
    }

    @Override // d.j
    protected void k1(d.p.b bVar, boolean z) {
        if (this.C) {
            bVar.Q0(new e());
            bVar.B0();
        }
        this.A.b(bVar);
        this.B.b(bVar);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // d.j
    public void m1(d.p.b bVar) {
        this.A.d(bVar);
        this.B.d(bVar);
    }

    @Override // d.j
    protected void n1(d.p.b bVar) {
        this.A.a(bVar);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // d.j
    public boolean o1(e eVar) {
        return s1(eVar, null);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // d.j
    public boolean p1(int i, Object obj) {
        if (i == 51) {
            this.C = f.c(i, obj);
            return true;
        }
        this.l.c(22);
        return false;
    }

    @Override // d.j
    protected void q1(d.p.b bVar) {
        this.B.a(bVar);
    }

    protected final e r1(d.s.f<d.p.b> fVar) {
        return this.A.c(this.l, fVar);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final boolean s1(e eVar, d.s.f<d.p.b> fVar) {
        return this.B.c(eVar, this.l, fVar);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public e t1() {
        return r1(null);
    }
}
