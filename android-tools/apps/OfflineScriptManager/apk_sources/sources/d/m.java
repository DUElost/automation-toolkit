package d;

import d.a;
import d.c;
/* loaded from: classes.dex */
public abstract class m {

    /* renamed from: d  reason: collision with root package name */
    private static /* synthetic */ int[] f2566d;

    /* renamed from: b  reason: collision with root package name */
    private final c f2567b;

    /* renamed from: c  reason: collision with root package name */
    private int f2568c;

    /* JADX INFO: Access modifiers changed from: protected */
    public m(c cVar, int i) {
        this.f2567b = cVar;
        this.f2568c = i;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public m(m mVar) {
        this(mVar.f2567b, mVar.f2568c);
    }

    static /* synthetic */ int[] B() {
        int[] iArr = f2566d;
        if (iArr != null) {
            return iArr;
        }
        int[] iArr2 = new int[a.EnumC0103a.valuesCustom().length];
        try {
            iArr2[a.EnumC0103a.ACTIVATE_READ.ordinal()] = 6;
        } catch (NoSuchFieldError unused) {
        }
        try {
            iArr2[a.EnumC0103a.ACTIVATE_WRITE.ordinal()] = 7;
        } catch (NoSuchFieldError unused2) {
        }
        try {
            iArr2[a.EnumC0103a.ATTACH.ordinal()] = 4;
        } catch (NoSuchFieldError unused3) {
        }
        try {
            iArr2[a.EnumC0103a.BIND.ordinal()] = 5;
        } catch (NoSuchFieldError unused4) {
        }
        try {
            iArr2[a.EnumC0103a.DONE.ordinal()] = 17;
        } catch (NoSuchFieldError unused5) {
        }
        try {
            iArr2[a.EnumC0103a.HICCUP.ordinal()] = 8;
        } catch (NoSuchFieldError unused6) {
        }
        try {
            iArr2[a.EnumC0103a.INPROC_CONNECTED.ordinal()] = 16;
        } catch (NoSuchFieldError unused7) {
        }
        try {
            iArr2[a.EnumC0103a.OWN.ordinal()] = 3;
        } catch (NoSuchFieldError unused8) {
        }
        try {
            iArr2[a.EnumC0103a.PIPE_TERM.ordinal()] = 9;
        } catch (NoSuchFieldError unused9) {
        }
        try {
            iArr2[a.EnumC0103a.PIPE_TERM_ACK.ordinal()] = 10;
        } catch (NoSuchFieldError unused10) {
        }
        try {
            iArr2[a.EnumC0103a.PLUG.ordinal()] = 2;
        } catch (NoSuchFieldError unused11) {
        }
        try {
            iArr2[a.EnumC0103a.REAP.ordinal()] = 14;
        } catch (NoSuchFieldError unused12) {
        }
        try {
            iArr2[a.EnumC0103a.REAPED.ordinal()] = 15;
        } catch (NoSuchFieldError unused13) {
        }
        try {
            iArr2[a.EnumC0103a.STOP.ordinal()] = 1;
        } catch (NoSuchFieldError unused14) {
        }
        try {
            iArr2[a.EnumC0103a.TERM.ordinal()] = 12;
        } catch (NoSuchFieldError unused15) {
        }
        try {
            iArr2[a.EnumC0103a.TERM_ACK.ordinal()] = 13;
        } catch (NoSuchFieldError unused16) {
        }
        try {
            iArr2[a.EnumC0103a.TERM_REQ.ordinal()] = 11;
        } catch (NoSuchFieldError unused17) {
        }
        f2566d = iArr2;
        return iArr2;
    }

    private void g0(a aVar) {
        this.f2567b.q(aVar.f2516a.G(), aVar);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final d.n.d C(long j) {
        return this.f2567b.b(j);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void D(String str, j jVar) {
        this.f2567b.e(str, jVar);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void E(j jVar) {
        this.f2567b.i(jVar);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final c.a F(String str) {
        return this.f2567b.k(str);
    }

    public final int G() {
        return this.f2568c;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void H(String str, c.a aVar, d.p.b[] bVarArr) {
        this.f2567b.o(str, aVar, bVarArr);
    }

    protected void I() {
        throw new UnsupportedOperationException();
    }

    protected void J(long j) {
        throw new UnsupportedOperationException();
    }

    protected void K(d.n.b bVar) {
        throw new UnsupportedOperationException();
    }

    protected void L(d.p.b bVar) {
        throw new UnsupportedOperationException();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final void M(a aVar) {
        switch (B()[aVar.f2517b.ordinal()]) {
            case 1:
                V();
                return;
            case 2:
                R();
                break;
            case 3:
                O((g) aVar.f2518c);
                break;
            case 4:
                K((d.n.b) aVar.f2518c);
                break;
            case 5:
                L((d.p.b) aVar.f2518c);
                break;
            case 6:
                I();
                return;
            case 7:
                J(((Long) aVar.f2518c).longValue());
                return;
            case 8:
                N((d.p.d) aVar.f2518c);
                return;
            case 9:
                P();
                return;
            case 10:
                Q();
                return;
            case 11:
                Y((g) aVar.f2518c);
                return;
            case 12:
                W(((Integer) aVar.f2518c).intValue());
                return;
            case 13:
                X();
                return;
            case 14:
                S((j) aVar.f2518c);
                return;
            case 15:
                T();
                return;
            case 16:
                break;
            default:
                throw new IllegalArgumentException();
        }
        U();
    }

    protected void N(d.p.d<e> dVar) {
        throw new UnsupportedOperationException();
    }

    protected void O(g gVar) {
        throw new UnsupportedOperationException();
    }

    protected void P() {
        throw new UnsupportedOperationException();
    }

    protected void Q() {
        throw new UnsupportedOperationException();
    }

    protected void R() {
        throw new UnsupportedOperationException();
    }

    protected void S(j jVar) {
        throw new UnsupportedOperationException();
    }

    protected void T() {
        throw new UnsupportedOperationException();
    }

    protected void U() {
        throw new UnsupportedOperationException();
    }

    protected void V() {
        throw new UnsupportedOperationException();
    }

    protected void W(int i) {
        throw new UnsupportedOperationException();
    }

    protected void X() {
        throw new UnsupportedOperationException();
    }

    protected void Y(g gVar) {
        throw new UnsupportedOperationException();
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final boolean Z(String str, c.a aVar) {
        return this.f2567b.p(str, aVar);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void a0(d.p.b bVar) {
        g0(new a(bVar, a.EnumC0103a.ACTIVATE_READ));
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void b0(d.p.b bVar, long j) {
        g0(new a(bVar, a.EnumC0103a.ACTIVATE_WRITE, Long.valueOf(j)));
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void c0(d.n.f fVar, d.n.b bVar) {
        d0(fVar, bVar, true);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void d0(d.n.f fVar, d.n.b bVar, boolean z) {
        if (z) {
            fVar.z0();
        }
        g0(new a(fVar, a.EnumC0103a.ATTACH, bVar));
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void e0(g gVar, d.p.b bVar) {
        f0(gVar, bVar, true);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void f0(g gVar, d.p.b bVar, boolean z) {
        if (z) {
            gVar.z0();
        }
        g0(new a(gVar, a.EnumC0103a.BIND, bVar));
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void h0() {
        this.f2567b.q(0, new a(null, a.EnumC0103a.DONE));
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void i0(d.p.b bVar, d.p.d<e> dVar) {
        g0(new a(bVar, a.EnumC0103a.HICCUP, dVar));
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void j0(j jVar) {
        g0(new a(jVar, a.EnumC0103a.INPROC_CONNECTED));
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void k0(g gVar, g gVar2) {
        gVar.z0();
        g0(new a(gVar, a.EnumC0103a.OWN, gVar2));
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void l0(d.p.b bVar) {
        g0(new a(bVar, a.EnumC0103a.PIPE_TERM));
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void m0(d.p.b bVar) {
        g0(new a(bVar, a.EnumC0103a.PIPE_TERM_ACK));
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void n0(g gVar) {
        o0(gVar, true);
    }

    protected final void o0(g gVar, boolean z) {
        if (z) {
            gVar.z0();
        }
        g0(new a(gVar, a.EnumC0103a.PLUG));
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void p0(j jVar) {
        g0(new a(this.f2567b.m(), a.EnumC0103a.REAP, jVar));
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void q0() {
        g0(new a(this.f2567b.m(), a.EnumC0103a.REAPED));
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void r0() {
        this.f2567b.q(this.f2568c, new a(this, a.EnumC0103a.STOP));
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void s0(g gVar, int i) {
        g0(new a(gVar, a.EnumC0103a.TERM, Integer.valueOf(i)));
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void t0(g gVar) {
        g0(new a(gVar, a.EnumC0103a.TERM_ACK));
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void u0(g gVar, g gVar2) {
        g0(new a(gVar, a.EnumC0103a.TERM_REQ, gVar2));
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void v0(int i) {
        this.f2568c = i;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void w0(j jVar) {
        this.f2567b.t(jVar);
    }
}
