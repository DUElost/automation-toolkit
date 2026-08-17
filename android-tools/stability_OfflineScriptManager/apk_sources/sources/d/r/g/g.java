package d.r.g;

import d.j;
import d.r.g.e;
/* loaded from: classes.dex */
public class g extends j {
    private final d.r.a A;
    private final d.r.g.a B;
    private final e C;
    private final e.a D;

    /* loaded from: classes.dex */
    private final class a implements e.a {
        private a() {
        }

        /* synthetic */ a(g gVar, a aVar) {
            this();
        }

        @Override // d.r.g.e.a
        public void a(byte[] bArr, int i, d.p.b bVar) {
            g.this.s1(bArr, i, bVar);
        }
    }

    public g(d.c cVar, int i, int i2) {
        super(cVar, i, i2);
        this.D = new a(this, null);
        d.f fVar = this.e;
        fVar.j = 10;
        fVar.k = 0;
        this.A = new d.r.a();
        this.B = new d.r.g.a();
        this.C = new e();
        new d.e();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean s1(byte[] bArr, int i, d.p.b bVar) {
        d.e eVar = new d.e(i + 1);
        eVar.p((byte) 1).v(bArr, 0, i);
        return bVar.Q0(eVar);
    }

    @Override // d.j
    protected void k1(d.p.b bVar, boolean z) {
        this.A.b(bVar);
        this.B.b(bVar);
        this.C.b(this.D, bVar);
        bVar.B0();
    }

    @Override // d.j
    protected void l1(d.p.b bVar) {
        this.C.b(this.D, bVar);
        bVar.B0();
    }

    @Override // d.j
    protected void m1(d.p.b bVar) {
        this.A.d(bVar);
        this.B.h(bVar);
    }

    @Override // d.j
    protected void n1(d.p.b bVar) {
        this.A.a(bVar);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // d.j
    public boolean o1(d.e eVar) {
        int B = eVar.B();
        if (B > 0 && eVar.e(0) == 1) {
            this.C.a(eVar, 1, B - 1);
        } else if (B > 0 && eVar.e(0) == 0 && !this.C.f(eVar, 1, B - 1)) {
            return true;
        }
        return this.B.f(eVar);
    }

    @Override // d.j
    protected void q1(d.p.b bVar) {
        this.B.a(bVar);
    }
}
