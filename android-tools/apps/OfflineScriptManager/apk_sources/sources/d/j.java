package d;

import d.c;
import d.l;
import d.p.b;
import d.q.b;
import java.io.IOException;
import java.nio.channels.SelectableChannel;
import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.locks.ReentrantLock;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public abstract class j extends g implements d.q.a, b.a {
    private final d.s.d<String, a> m;
    private final d.s.d<String, d.p.b> n;
    private int o;
    private boolean p;
    private boolean q;
    private final d r;
    private final Set<d.p.b> s;
    private d.q.b t;
    private b.a u;
    private long v;
    private j w;
    private int x;
    protected String y;
    private final ReentrantLock z;

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class a {

        /* renamed from: a  reason: collision with root package name */
        private final g f2554a;

        /* renamed from: b  reason: collision with root package name */
        private final d.p.b f2555b;

        public a(g gVar, d.p.b bVar) {
            this.f2554a = gVar;
            this.f2555b = bVar;
        }

        public String toString() {
            return "EndpointPipe [endpoint=" + this.f2554a + ", pipe=" + this.f2555b + "]";
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class b {

        /* renamed from: a  reason: collision with root package name */
        private final String f2556a;

        /* renamed from: b  reason: collision with root package name */
        private final String f2557b;

        private b(String str, String str2) {
            this.f2556a = str;
            this.f2557b = str2;
        }

        public static b a(String str) {
            int indexOf = str.indexOf("://");
            if (indexOf < 0) {
                throw new IllegalArgumentException("Invalid URI: " + str);
            }
            String substring = str.substring(0, indexOf);
            String substring2 = str.substring(indexOf + 3);
            if (substring.isEmpty() || substring2.isEmpty()) {
                throw new IllegalArgumentException("Invalid URI: " + str);
            }
            return new b(substring, substring2);
        }

        public String b() {
            return this.f2557b;
        }

        public String c() {
            return this.f2556a;
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public j(c cVar, int i, int i2) {
        super(cVar, i);
        this.z = new ReentrantLock(false);
        this.o = -1159861073;
        this.p = false;
        this.q = false;
        this.v = 0L;
        this.w = null;
        this.x = 0;
        f fVar = this.e;
        fVar.J = i2;
        fVar.q = cVar.l(42) != 0;
        this.e.k = cVar.l(70) != 0 ? -1 : 0;
        this.m = new d.s.d<>();
        this.n = new d.s.d<>();
        this.s = new HashSet();
        this.r = new d(cVar, "socket-" + i2, i);
    }

    private void H0(String str, g gVar, d.p.b bVar) {
        B0(gVar);
        this.m.e(str, new a(gVar, bVar));
    }

    private void I0(d.p.b bVar) {
        J0(bVar, false);
    }

    private void J0(d.p.b bVar, boolean z) {
        bVar.K0(this);
        this.s.add(bVar);
        k1(bVar, z);
        if (A0()) {
            D0(1);
            bVar.P0(false);
        }
    }

    private void L0() {
        if (this.q) {
            this.t.m(this.u);
            E(this);
            q0();
            super.C0();
        }
    }

    private d.n.j.b M0(String str) {
        d.n.j.b b2 = d.n.j.b.b(str);
        if (b2 == null || !b2.f2639b) {
            this.l.c(43);
            return b2;
        } else if (b2.a(this.e.j)) {
            return b2;
        } else {
            this.l.c(156384764);
            return null;
        }
    }

    private void Q0(String str, Object obj, int i) {
        try {
            this.z.lock();
            if ((this.x & i) != 0) {
                d1(new l.a(i, str, obj));
            }
        } finally {
            this.z.unlock();
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:16:0x002e  */
    /* JADX WARN: Removed duplicated region for block: B:7:0x0014  */
    /* JADX WARN: Unsupported multi-entry loop pattern (BACK_EDGE: B:5:0x000c -> B:6:0x0012). Please submit an issue!!! */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private boolean e1(int r5, boolean r6) {
        /*
            r4 = this;
            r0 = 0
            if (r5 == 0) goto Lc
            d.d r6 = r4.r
            long r2 = (long) r5
            d.a r5 = r6.b(r2)
            goto L12
        Lc:
            d.d r5 = r4.r
            d.a r5 = r5.b(r0)
        L12:
            if (r5 != 0) goto L2e
            d.s.c r5 = r4.l
            int r5 = r5.a()
            r6 = 4
            r0 = 0
            if (r5 != r6) goto L1f
            return r0
        L1f:
            boolean r5 = r4.p
            if (r5 == 0) goto L2c
            d.s.c r5 = r4.l
            r6 = 156384765(0x9523dfd, float:2.5306977E-33)
            r5.c(r6)
            return r0
        L2c:
            r5 = 1
            return r5
        L2e:
            r5.a()
            goto Lc
        */
        throw new UnsupportedOperationException("Method not decompiled: d.j.e1(int, boolean):boolean");
    }

    private void j1() {
        if (this.w != null) {
            if ((this.x & 1024) != 0) {
                d1(new l.a(1024, BuildConfig.FLAVOR, 0));
            }
            this.w.close();
            this.w = null;
            this.x = 0;
        }
    }

    @Override // d.g
    protected final void C0() {
        this.q = true;
    }

    public final boolean K0(String str) {
        d.n.j.h.d cVar;
        f fVar;
        String I0;
        if (this.p) {
            this.l.c(156384765);
            return false;
        } else if (e1(0, false)) {
            b a2 = b.a(str);
            String c2 = a2.c();
            String b2 = a2.b();
            d.n.j.b M0 = M0(c2);
            if (M0 == null || !M0.f2639b) {
                return false;
            }
            if (d.n.j.b.f2638d.equals(M0)) {
                boolean Z = Z(str, new c.a(this, this.e));
                if (Z) {
                    D(str, this);
                    this.e.f = str;
                } else {
                    this.l.c(48);
                }
                return Z;
            } else if (d.n.j.b.g.equals(M0) || d.n.j.b.h.equals(M0) || d.n.j.b.j.equals(M0)) {
                return O0(str);
            } else {
                d.n.d C = C(this.e.f2549c);
                if (C == null) {
                    this.l.c(156384766);
                    return false;
                }
                if (d.n.j.b.f.equals(M0)) {
                    cVar = new d.n.j.h.d(C, this, this.e);
                    if (!cVar.J0(b2)) {
                        cVar.y0();
                        T0(b2, this.l.a());
                        return false;
                    }
                    fVar = this.e;
                    I0 = cVar.I0();
                } else if (!d.n.j.b.e.equals(M0)) {
                    if (d.n.j.b.i.equals(M0)) {
                        new d.n.j.i.b(C, this, this.e);
                        throw null;
                    }
                    throw new IllegalArgumentException(str);
                } else {
                    cVar = new d.n.j.e.c(C, this, this.e);
                    if (!cVar.J0(b2)) {
                        cVar.y0();
                        T0(b2, this.l.a());
                        return false;
                    }
                    fVar = this.e;
                    I0 = cVar.I0();
                }
                fVar.f = I0;
                H0(str, cVar, null);
                return true;
            }
        } else {
            return false;
        }
    }

    @Override // d.m
    protected final void L(d.p.b bVar) {
        I0(bVar);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final boolean N0() {
        return this.o == -1159861073;
    }

    public final boolean O0(String str) {
        int i;
        d.s.c cVar;
        int i2;
        int i3;
        int i4;
        int i5;
        if (this.p) {
            cVar = this.l;
            i2 = 156384765;
        } else if (!e1(0, false)) {
            return false;
        } else {
            b a2 = b.a(str);
            String c2 = a2.c();
            String b2 = a2.b();
            d.n.j.b M0 = M0(c2);
            if (M0 == null || !M0.f2639b) {
                return false;
            }
            if (d.n.j.b.f2638d.equals(M0)) {
                c.a F = F(str);
                j jVar = F.f2529a;
                int i6 = this.e.f2547a;
                if (jVar != null) {
                    i6 = (i6 == 0 || (i5 = F.f2530b.f2548b) == 0) ? 0 : i6 + i5;
                }
                int i7 = this.e.f2548b;
                if (jVar != null) {
                    i7 = (i7 == 0 || (i4 = F.f2530b.f2547a) == 0) ? 0 : i7 + i4;
                }
                m[] mVarArr = new m[2];
                mVarArr[0] = this;
                if (jVar == null) {
                    jVar = this;
                }
                mVarArr[1] = jVar;
                f fVar = this.e;
                boolean z = fVar.K && ((i3 = fVar.j) == 5 || i3 == 7 || i3 == 8 || i3 == 1 || i3 == 2);
                int[] iArr = new int[2];
                if (z) {
                    i6 = -1;
                }
                iArr[0] = i6;
                iArr[1] = z ? -1 : i7;
                d.p.b[] G0 = d.p.b.G0(mVarArr, iArr, new boolean[]{z, z});
                I0(G0[0]);
                if (F.f2529a == null) {
                    e eVar = new e(this.e.f2550d);
                    f fVar2 = this.e;
                    eVar.v(fVar2.e, 0, fVar2.f2550d);
                    eVar.y(64);
                    G0[0].Q0(eVar);
                    G0[0].B0();
                    H(str, new c.a(this, this.e), G0);
                } else {
                    if (F.f2530b.t) {
                        e eVar2 = new e(this.e.f2550d);
                        f fVar3 = this.e;
                        eVar2.v(fVar3.e, 0, fVar3.f2550d);
                        eVar2.y(64);
                        G0[0].Q0(eVar2);
                        G0[0].B0();
                    }
                    if (this.e.t) {
                        e eVar3 = new e(F.f2530b.f2550d);
                        f fVar4 = F.f2530b;
                        eVar3.v(fVar4.e, 0, fVar4.f2550d);
                        eVar3.y(64);
                        G0[1].Q0(eVar3);
                        G0[1].B0();
                    }
                    f0(F.f2529a, G0[1], false);
                }
                this.e.f = str;
                this.n.e(str, G0[0]);
                return true;
            }
            int i8 = this.e.j;
            if ((i8 == 5 || i8 == 2 || i8 == 3) && this.m.d(str)) {
                return true;
            }
            d.n.d C = C(this.e.f2549c);
            if (C != null) {
                d.n.j.a aVar = new d.n.j.a(c2, b2);
                if (d.n.j.b.f.equals(M0) || d.n.j.b.e.equals(M0) || d.n.j.b.i.equals(M0)) {
                    aVar.e(this.e.q);
                }
                d.n.j.b bVar = d.n.j.b.g;
                if (!bVar.equals(M0)) {
                    d.n.j.b.h.equals(M0);
                }
                d.n.f e = d.r.d.e(C, true, this, this.e, aVar);
                boolean z2 = bVar.equals(M0) || d.n.j.b.h.equals(M0) || d.n.j.b.j.equals(M0);
                d.p.b bVar2 = null;
                f fVar5 = this.e;
                if (fVar5.r || z2) {
                    m[] mVarArr2 = {this, e};
                    boolean z3 = fVar5.K && ((i = fVar5.j) == 5 || i == 7 || i == 8 || i == 1 || i == 2);
                    int[] iArr2 = new int[2];
                    iArr2[0] = z3 ? -1 : fVar5.f2547a;
                    iArr2[1] = z3 ? -1 : fVar5.f2548b;
                    d.p.b[] G02 = d.p.b.G0(mVarArr2, iArr2, new boolean[]{z3, z3});
                    J0(G02[0], z2);
                    d.p.b bVar3 = G02[0];
                    e.J0(G02[1]);
                    bVar2 = bVar3;
                }
                this.e.f = aVar.toString();
                H0(str, e, bVar2);
                return true;
            }
            cVar = this.l;
            i2 = 156384766;
        }
        cVar.c(i2);
        return false;
    }

    public final int P0() {
        return this.l.a();
    }

    public final void R0(String str, int i) {
        Q0(str, Integer.valueOf(i), 64);
    }

    public final void S0(String str, SelectableChannel selectableChannel) {
        Q0(str, selectableChannel, 32);
    }

    public final void T0(String str, int i) {
        Q0(str, Integer.valueOf(i), 16);
    }

    public final void U0(String str, int i) {
        Q0(str, Integer.valueOf(i), 256);
    }

    @Override // d.m
    protected final void V() {
        try {
            this.z.lock();
            j1();
            this.p = true;
        } finally {
            this.z.unlock();
        }
    }

    public final void V0(String str, SelectableChannel selectableChannel) {
        Q0(str, selectableChannel, 128);
    }

    @Override // d.g, d.m
    protected final void W(int i) {
        w0(this);
        for (d.p.b bVar : this.s) {
            bVar.P0(false);
        }
        D0(this.s.size());
        super.W(i);
    }

    public final void W0(String str, int i) {
        Q0(str, Integer.valueOf(i), 2);
    }

    public final void X0(String str, int i) {
        try {
            this.z.lock();
            if ((this.x & 4) != 0) {
                d1(new l.a(4, str, Integer.valueOf(i)));
            }
        } finally {
            this.z.unlock();
        }
    }

    public final void Y0(String str, SelectableChannel selectableChannel) {
        Q0(str, selectableChannel, 1);
    }

    public final void Z0(String str, SelectableChannel selectableChannel) {
        Q0(str, selectableChannel, 512);
    }

    @Override // d.p.b.a
    public final void a(d.p.b bVar) {
        m1(bVar);
        this.n.h(bVar);
        this.s.remove(bVar);
        if (A0()) {
            G0();
        }
    }

    public final void a1(String str, int i) {
        Q0(str, Integer.valueOf(i), 32768);
    }

    @Override // d.q.a
    public final void b() {
        throw new UnsupportedOperationException();
    }

    public final void b1(String str, SelectableChannel selectableChannel) {
        Q0(str, selectableChannel, 8);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final d c1() {
        return this.r;
    }

    public final void close() {
        this.o = -559038737;
        p0(this);
    }

    protected final void d1(l.a aVar) {
        j jVar = this.w;
        if (jVar == null) {
            return;
        }
        aVar.a(jVar);
    }

    @Override // d.q.a
    public final void e() {
        e1(0, false);
        L0();
    }

    public final boolean f1(e eVar, int i) {
        int i2;
        if (this.p) {
            this.l.c(156384765);
            return false;
        } else if (eVar == null || !eVar.b()) {
            this.l.c(14);
            return false;
        } else if (e1(0, true)) {
            eVar.w(1);
            if ((i & 2) > 0) {
                eVar.y(1);
            }
            eVar.x();
            if (o1(eVar)) {
                return true;
            }
            if (this.l.a() == 35 && (i & 1) <= 0 && (i2 = this.e.p) != 0) {
                long a2 = i2 < 0 ? 0L : d.s.b.a() + i2;
                while (e1(i2, false)) {
                    if (o1(eVar)) {
                        return true;
                    }
                    if (this.l.a() != 35) {
                        return false;
                    }
                    if (i2 > 0 && (i2 = (int) (a2 - d.s.b.a())) <= 0) {
                        this.l.c(35);
                    }
                }
                return false;
            }
            return false;
        } else {
            return false;
        }
    }

    public final boolean g1(int i, Object obj) {
        if (this.p) {
            this.l.c(156384765);
            return false;
        }
        boolean p1 = p1(i, obj);
        if (p1 || this.l.a() != 22) {
            return p1;
        }
        boolean g = this.e.g(i, obj);
        if (g) {
            this.l.c(0);
        }
        return g;
    }

    @Override // d.q.a
    public final void h(int i) {
        throw new UnsupportedOperationException();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final void h1(d.q.b bVar) {
        this.t = bVar;
        b.a h = this.t.h(this.r.a(), this);
        this.u = h;
        this.t.r(h);
        F0();
        L0();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final void i1() {
        r0();
    }

    protected abstract void k1(d.p.b bVar, boolean z);

    protected void l1(d.p.b bVar) {
        throw new UnsupportedOperationException("Must override");
    }

    @Override // d.p.b.a
    public final void m(d.p.b bVar) {
        q1(bVar);
    }

    protected abstract void m1(d.p.b bVar);

    protected void n1(d.p.b bVar) {
        throw new UnsupportedOperationException("Must Override");
    }

    protected boolean o1(e eVar) {
        throw new UnsupportedOperationException("Must Override");
    }

    protected boolean p1(int i, Object obj) {
        this.l.c(22);
        return false;
    }

    @Override // d.q.a
    public final void q() {
        throw new UnsupportedOperationException();
    }

    protected void q1(d.p.b bVar) {
        throw new UnsupportedOperationException("Must Override");
    }

    @Override // d.q.a
    public final void s() {
        throw new UnsupportedOperationException();
    }

    @Override // d.p.b.a
    public final void t(d.p.b bVar) {
        n1(bVar);
    }

    public String toString() {
        return String.valueOf(getClass().getSimpleName()) + "[" + this.e.J + "]";
    }

    @Override // d.p.b.a
    public final void v(d.p.b bVar) {
        if (this.e.r) {
            l1(bVar);
        } else {
            bVar.P0(false);
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // d.g
    public void y0() {
        try {
            this.z.lock();
            try {
                this.r.close();
            } catch (IOException unused) {
            }
            j1();
        } finally {
            this.z.unlock();
        }
    }
}
