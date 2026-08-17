package d.n;

import d.c;
import d.j;
import d.m;
import d.n.g;
import d.p.b;
import java.util.HashSet;
import java.util.Set;
/* loaded from: classes.dex */
public class f extends d.g implements b.a, d.q.a {
    private static /* synthetic */ int[] y;
    private static /* synthetic */ int[] z;
    private final boolean m;
    private d.p.b n;
    private d.p.b o;
    private final Set<d.p.b> p;
    private boolean q;
    private boolean r;
    private b s;
    protected final j t;
    private final d u;
    private boolean v;
    private final d.n.j.a w;
    private final c x;

    public f(d dVar, boolean z2, j jVar, d.f fVar, d.n.j.a aVar) {
        super(dVar, fVar);
        this.x = new c(dVar, this);
        this.m = z2;
        this.n = null;
        this.o = null;
        this.q = false;
        this.r = false;
        this.s = null;
        this.t = jVar;
        this.u = dVar;
        this.v = false;
        this.w = aVar;
        this.p = new HashSet();
    }

    static /* synthetic */ int[] H0() {
        int[] iArr = y;
        if (iArr != null) {
            return iArr;
        }
        int[] iArr2 = new int[g.b.valuesCustom().length];
        try {
            iArr2[g.b.CONNECTION.ordinal()] = 2;
        } catch (NoSuchFieldError unused) {
        }
        try {
            iArr2[g.b.PROTOCOL.ordinal()] = 1;
        } catch (NoSuchFieldError unused2) {
        }
        try {
            iArr2[g.b.TIMEOUT.ordinal()] = 3;
        } catch (NoSuchFieldError unused3) {
        }
        y = iArr2;
        return iArr2;
    }

    static /* synthetic */ int[] I0() {
        int[] iArr = z;
        if (iArr != null) {
            return iArr;
        }
        int[] iArr2 = new int[d.n.j.b.values().length];
        try {
            iArr2[d.n.j.b.h.ordinal()] = 5;
        } catch (NoSuchFieldError unused) {
        }
        try {
            iArr2[d.n.j.b.f2638d.ordinal()] = 1;
        } catch (NoSuchFieldError unused2) {
        }
        try {
            iArr2[d.n.j.b.e.ordinal()] = 2;
        } catch (NoSuchFieldError unused3) {
        }
        try {
            iArr2[d.n.j.b.j.ordinal()] = 7;
        } catch (NoSuchFieldError unused4) {
        }
        try {
            iArr2[d.n.j.b.g.ordinal()] = 4;
        } catch (NoSuchFieldError unused5) {
        }
        try {
            iArr2[d.n.j.b.f.ordinal()] = 3;
        } catch (NoSuchFieldError unused6) {
        }
        try {
            iArr2[d.n.j.b.i.ordinal()] = 6;
        } catch (NoSuchFieldError unused7) {
        }
        z = iArr2;
        return iArr2;
    }

    private void K0() {
        this.n.J0();
        this.n.B0();
        while (this.q && O0() != null) {
        }
    }

    private void R0() {
        if (this.n != null && !this.e.r && !d.n.j.b.g.equals(this.w.d()) && !d.n.j.b.h.equals(this.w.d()) && !d.n.j.b.j.equals(this.w.d())) {
            this.n.E0();
            this.n.P0(false);
            this.p.add(this.n);
            this.n = null;
        }
        S0();
        if (this.e.l != -1) {
            T0(true);
        }
        d.p.b bVar = this.n;
        if (bVar != null) {
            int i = this.e.j;
            if (i == 2 || i == 10) {
                bVar.E0();
            }
        }
    }

    private void T0(boolean z2) {
        d.g bVar;
        d C = C(this.e.f2549c);
        d.n.j.b d2 = this.w.d();
        if (d2 == null) {
            this.l.c(43);
            return;
        }
        switch (I0()[d2.ordinal()]) {
            case 2:
                bVar = new d.n.j.e.b(C, this, this.e, this.w, z2);
                break;
            case 3:
                if (this.e.v != null) {
                    new d.n.j.h.a(C, this, this.e, this.w, new d.n.j.a(d.n.j.b.f.name(), this.e.v), z2);
                    throw null;
                }
                bVar = new d.n.j.h.c(C, this, this.e, this.w, z2);
                break;
            case 4:
            case 5:
                d.n.j.b bVar2 = d.n.j.b.h;
                d.f fVar = this.e;
                int i = fVar.j;
                if (i == 1 || i == 9) {
                    new d.n.j.g.b(C, fVar);
                    throw null;
                } else {
                    new d.n.j.g.a(C, fVar);
                    throw null;
                }
            case 6:
                new d.n.j.i.a(C, this, this.e, this.w, z2);
                throw null;
            case 7:
                d.f fVar2 = this.e;
                int i2 = fVar2.j;
                if (i2 == 1 || i2 == 9) {
                    new d.n.j.f.a(C, fVar2);
                    throw null;
                } else {
                    new d.n.j.f.a(C, fVar2);
                    throw null;
                }
            default:
                return;
        }
        B0(bVar);
    }

    public void J0(d.p.b bVar) {
        this.n = bVar;
        bVar.K0(this);
    }

    @Override // d.m
    protected void K(b bVar) {
        int i;
        if (this.n == null && !A0()) {
            m[] mVarArr = {this, this.t};
            d.f fVar = this.e;
            boolean z2 = fVar.K && ((i = fVar.j) == 5 || i == 7 || i == 8 || i == 1 || i == 2);
            int[] iArr = new int[2];
            iArr[0] = z2 ? -1 : fVar.f2548b;
            iArr[1] = z2 ? -1 : fVar.f2547a;
            d.p.b[] G0 = d.p.b.G0(mVarArr, iArr, new boolean[]{z2, z2});
            G0[0].K0(this);
            this.n = G0[0];
            e0(this.t, G0[1]);
        }
        this.s = bVar;
        bVar.c(this.u, this);
    }

    /* JADX WARN: Removed duplicated region for block: B:18:0x002d  */
    /* JADX WARN: Removed duplicated region for block: B:21:0x0034  */
    /* JADX WARN: Removed duplicated region for block: B:23:? A[RETURN, SYNTHETIC] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void L0(d.n.g.b r2) {
        /*
            r1 = this;
            r0 = 0
            r1.s = r0
            d.p.b r0 = r1.n
            if (r0 == 0) goto La
            r1.K0()
        La:
            int[] r0 = H0()
            int r2 = r2.ordinal()
            r2 = r0[r2]
            r0 = 1
            if (r2 == r0) goto L26
            r0 = 2
            if (r2 == r0) goto L1e
            r0 = 3
            if (r2 == r0) goto L1e
            goto L29
        L1e:
            boolean r2 = r1.m
            if (r2 == 0) goto L26
            r1.R0()
            goto L29
        L26:
            r1.F0()
        L29:
            d.p.b r2 = r1.n
            if (r2 == 0) goto L30
            r2.y0()
        L30:
            d.p.b r2 = r1.o
            if (r2 == 0) goto L37
            r2.y0()
        L37:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: d.n.f.L0(d.n.g$b):void");
    }

    public void M0() {
        d.p.b bVar = this.n;
        if (bVar != null) {
            bVar.B0();
        }
    }

    public j N0() {
        return this.t;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public d.e O0() {
        d.e I0;
        d.p.b bVar = this.n;
        if (bVar == null || (I0 = bVar.I0()) == null) {
            return null;
        }
        this.q = I0.j();
        return I0;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public boolean P0(d.e eVar) {
        d.p.b bVar = this.n;
        if (bVar == null || !bVar.Q0(eVar)) {
            this.l.c(35);
            return false;
        }
        return true;
    }

    public d.e Q0() {
        d.p.b bVar = this.o;
        if (bVar == null) {
            this.l.c(57);
            return null;
        }
        d.e I0 = bVar.I0();
        if (I0 == null) {
            this.l.c(35);
        }
        return I0;
    }

    @Override // d.m
    protected void R() {
        this.x.f();
        if (this.m) {
            T0(false);
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void S0() {
    }

    public boolean U0(d.e eVar) {
        d.p.b bVar = this.o;
        if (bVar == null) {
            this.l.c(57);
            return false;
        }
        bVar.Q0(eVar);
        if (eVar.j()) {
            return true;
        }
        this.o.B0();
        return true;
    }

    public int V0() {
        int i;
        c.a F = F("inproc://zeromq.zap.01");
        j jVar = F.f2529a;
        if (jVar == null || ((i = F.f2530b.j) != 4 && i != 6)) {
            this.l.c(61);
            return 61;
        }
        d.p.b[] G0 = d.p.b.G0(new m[]{this, jVar}, new int[2], new boolean[2]);
        d.p.b bVar = G0[0];
        this.o = bVar;
        bVar.N0();
        this.o.K0(this);
        f0(F.f2529a, G0[1], false);
        if (F.f2530b.t) {
            d.e eVar = new d.e();
            eVar.y(64);
            this.o.Q0(eVar);
            this.o.B0();
        }
        return 0;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // d.g, d.m
    public void W(int i) {
        if (this.n == null && this.o == null && this.p.isEmpty()) {
            super.W(0);
            return;
        }
        this.r = true;
        if (this.n != null) {
            if (i > 0) {
                this.x.c(i, 32);
                this.v = true;
            }
            this.n.P0(i != 0);
            if (this.s == null) {
                this.n.y0();
            }
        }
        d.p.b bVar = this.o;
        if (bVar != null) {
            bVar.P0(false);
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public boolean W0() {
        d.f fVar = this.e;
        if (fVar.B == d.n.i.b.NULL) {
            String str = fVar.D;
            return (str == null || str.isEmpty()) ? false : true;
        }
        return true;
    }

    @Override // d.p.b.a
    public void a(d.p.b bVar) {
        b bVar2;
        if (this.n == bVar) {
            this.n = null;
            if (this.v) {
                this.x.d(32);
                this.v = false;
            }
        } else if (this.o == bVar) {
            this.o = null;
        } else {
            this.p.remove(bVar);
        }
        if (!A0() && this.e.u && (bVar2 = this.s) != null) {
            bVar2.d();
            this.s = null;
        }
        if (this.r && this.n == null && this.o == null && this.p.isEmpty()) {
            this.r = false;
            super.W(0);
        }
    }

    @Override // d.q.a
    public void b() {
        throw new UnsupportedOperationException();
    }

    @Override // d.q.a
    public void e() {
        throw new UnsupportedOperationException();
    }

    @Override // d.q.a
    public void h(int i) {
        this.v = false;
        this.n.P0(false);
    }

    @Override // d.p.b.a
    public void m(d.p.b bVar) {
        b bVar2;
        if (this.n == bVar && (bVar2 = this.s) != null) {
            bVar2.a();
        }
    }

    @Override // d.q.a
    public void q() {
        throw new UnsupportedOperationException();
    }

    @Override // d.q.a
    public void s() {
        throw new UnsupportedOperationException();
    }

    @Override // d.p.b.a
    public void t(d.p.b bVar) {
        d.p.b bVar2 = this.n;
        if (bVar2 == bVar || this.o == bVar) {
            b bVar3 = this.s;
            if (bVar3 == null) {
                bVar2.y0();
            } else if (bVar2 == bVar) {
                bVar3.f();
            } else {
                bVar3.g();
            }
        }
    }

    public String toString() {
        return String.valueOf(getClass().getSimpleName()) + "-" + this.t;
    }

    @Override // d.p.b.a
    public void v(d.p.b bVar) {
        throw new UnsupportedOperationException("Must Override");
    }

    @Override // d.g
    public void y0() {
        if (this.v) {
            this.x.d(32);
            this.v = false;
        }
        b bVar = this.s;
        if (bVar != null) {
            bVar.d();
        }
        this.x.o();
    }

    @Override // d.g
    public final void z0() {
        super.z0();
    }
}
