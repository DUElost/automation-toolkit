package d.p;

import d.m;
/* loaded from: classes.dex */
public class b extends m {
    private d<d.e> e;
    private d<d.e> f;
    private boolean g;
    private boolean h;
    private int i;
    private int j;
    private long k;
    private long l;
    private long m;
    private b n;
    private a o;
    private EnumC0116b p;
    private boolean q;
    private d.s.a r;
    private d.s.a s;
    private final boolean t;
    private final m u;

    /* loaded from: classes.dex */
    public interface a {
        void a(b bVar);

        void m(b bVar);

        void t(b bVar);

        void v(b bVar);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: d.p.b$b  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public enum EnumC0116b {
        ACTIVE,
        DELIMITER_RECEIVED,
        WAITING_FOR_DELIMITER,
        TERM_ACK_SENT,
        TERM_REQ_SENT_1,
        TERM_REQ_SENT_2;

        /* renamed from: values  reason: to resolve conflict with enum method */
        public static EnumC0116b[] valuesCustom() {
            EnumC0116b[] valuesCustom = values();
            int length = valuesCustom.length;
            EnumC0116b[] enumC0116bArr = new EnumC0116b[length];
            System.arraycopy(valuesCustom, 0, enumC0116bArr, 0, length);
            return enumC0116bArr;
        }
    }

    private b(m mVar, d<d.e> dVar, d<d.e> dVar2, int i, int i2, boolean z) {
        super(mVar);
        this.e = dVar;
        this.f = dVar2;
        this.g = true;
        this.h = true;
        this.i = i2;
        this.j = A0(i);
        this.k = 0L;
        this.l = 0L;
        this.m = 0L;
        this.n = null;
        this.o = null;
        this.p = EnumC0116b.ACTIVE;
        this.q = true;
        this.t = z;
        this.u = mVar;
    }

    private static int A0(int i) {
        return (i + 1) / 2;
    }

    private static boolean F0(d.e eVar) {
        return eVar.n();
    }

    public static b[] G0(m[] mVarArr, int[] iArr, boolean[] zArr) {
        b[] bVarArr = new b[2];
        d eVar = zArr[0] ? new e() : new c(d.b.MESSAGE_PIPE_GRANULARITY.a());
        d eVar2 = zArr[1] ? new e() : new c(d.b.MESSAGE_PIPE_GRANULARITY.a());
        bVarArr[0] = new b(mVarArr[0], eVar, eVar2, iArr[1], iArr[0], zArr[0]);
        bVarArr[1] = new b(mVarArr[1], eVar2, eVar, iArr[0], iArr[1], zArr[1]);
        bVarArr[0].O0(bVarArr[1]);
        bVarArr[1].O0(bVarArr[0]);
        return bVarArr;
    }

    private void H0() {
        EnumC0116b enumC0116b;
        if (this.p == EnumC0116b.ACTIVE) {
            enumC0116b = EnumC0116b.DELIMITER_RECEIVED;
        } else {
            this.f = null;
            m0(this.n);
            enumC0116b = EnumC0116b.TERM_ACK_SENT;
        }
        this.p = enumC0116b;
    }

    private void O0(b bVar) {
        this.n = bVar;
    }

    public void B0() {
        d<d.e> dVar;
        if (this.p == EnumC0116b.TERM_ACK_SENT || (dVar = this.f) == null || dVar.flush()) {
            return;
        }
        a0(this.n);
    }

    public d.s.a C0() {
        return this.s;
    }

    public d.s.a D0() {
        return this.r;
    }

    public void E0() {
        if (this.p != EnumC0116b.ACTIVE) {
            return;
        }
        this.e = null;
        this.e = this.t ? new e<>() : new c<>(d.b.MESSAGE_PIPE_GRANULARITY.a());
        this.g = true;
        i0(this.n, this.e);
    }

    @Override // d.m
    protected void I() {
        if (this.g) {
            return;
        }
        EnumC0116b enumC0116b = this.p;
        if (enumC0116b == EnumC0116b.ACTIVE || enumC0116b == EnumC0116b.WAITING_FOR_DELIMITER) {
            this.g = true;
            this.o.t(this);
        }
    }

    public d.e I0() {
        if (!this.g) {
            return null;
        }
        EnumC0116b enumC0116b = this.p;
        if (enumC0116b != EnumC0116b.ACTIVE && enumC0116b != EnumC0116b.WAITING_FOR_DELIMITER) {
            return null;
        }
        while (true) {
            d.e d2 = this.e.d();
            if (d2 == null) {
                this.g = false;
                return null;
            } else if (!d2.m()) {
                if (d2.n()) {
                    H0();
                    return null;
                }
                if (!d2.j() && !d2.o()) {
                    this.k++;
                }
                int i = this.j;
                if (i > 0) {
                    long j = this.k;
                    if (j % i == 0) {
                        b0(this.n, j);
                    }
                }
                return d2;
            } else {
                this.s = d.s.a.a(d2);
            }
        }
    }

    @Override // d.m
    protected void J(long j) {
        this.m = j;
        if (this.h || this.p != EnumC0116b.ACTIVE) {
            return;
        }
        this.h = true;
        this.o.m(this);
    }

    public void J0() {
        if (this.f != null) {
            do {
            } while (this.f.e() != null);
        }
    }

    public void K0(a aVar) {
        this.o = aVar;
    }

    public void L0(int i, int i2) {
        this.j = A0(i);
        this.i = i2;
    }

    public void M0(d.s.a aVar) {
        this.r = aVar;
    }

    @Override // d.m
    protected void N(d<d.e> dVar) {
        this.f.flush();
        while (true) {
            d.e d2 = this.f.d();
            if (d2 == null) {
                break;
            } else if (!d2.j()) {
                this.l--;
            }
        }
        this.f = dVar;
        this.h = true;
        if (this.p == EnumC0116b.ACTIVE) {
            this.o.v(this);
        }
    }

    public void N0() {
        this.q = false;
    }

    @Override // d.m
    protected void P() {
        EnumC0116b enumC0116b;
        EnumC0116b enumC0116b2 = this.p;
        if (enumC0116b2 == EnumC0116b.ACTIVE) {
            if (this.q) {
                this.p = EnumC0116b.WAITING_FOR_DELIMITER;
                return;
            }
        } else if (enumC0116b2 != EnumC0116b.DELIMITER_RECEIVED) {
            if (enumC0116b2 == EnumC0116b.TERM_REQ_SENT_1) {
                enumC0116b = EnumC0116b.TERM_REQ_SENT_2;
                this.p = enumC0116b;
                this.f = null;
                m0(this.n);
            }
            return;
        }
        enumC0116b = EnumC0116b.TERM_ACK_SENT;
        this.p = enumC0116b;
        this.f = null;
        m0(this.n);
    }

    /* JADX WARN: Code restructure failed: missing block: B:19:0x0033, code lost:
        if (r0 == d.p.b.EnumC0116b.f2664c) goto L11;
     */
    /* JADX WARN: Removed duplicated region for block: B:23:0x003d  */
    /* JADX WARN: Removed duplicated region for block: B:26:? A[RETURN, SYNTHETIC] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void P0(boolean r5) {
        /*
            r4 = this;
            r4.q = r5
            d.p.b$b r0 = r4.p
            d.p.b$b r1 = d.p.b.EnumC0116b.TERM_REQ_SENT_1
            if (r0 == r1) goto L50
            d.p.b$b r2 = d.p.b.EnumC0116b.TERM_REQ_SENT_2
            if (r0 != r2) goto Ld
            goto L50
        Ld:
            d.p.b$b r2 = d.p.b.EnumC0116b.TERM_ACK_SENT
            if (r0 != r2) goto L12
            return
        L12:
            d.p.b$b r3 = d.p.b.EnumC0116b.ACTIVE
            if (r0 != r3) goto L1e
        L16:
            d.p.b r5 = r4.n
            r4.l0(r5)
            r4.p = r1
            goto L36
        L1e:
            d.p.b$b r3 = d.p.b.EnumC0116b.WAITING_FOR_DELIMITER
            if (r0 != r3) goto L2f
            if (r5 != 0) goto L2f
            r5 = 0
            r4.f = r5
            d.p.b r5 = r4.n
            r4.m0(r5)
            r4.p = r2
            goto L36
        L2f:
            if (r0 == r3) goto L36
            d.p.b$b r5 = d.p.b.EnumC0116b.DELIMITER_RECEIVED
            if (r0 != r5) goto L36
            goto L16
        L36:
            r5 = 0
            r4.h = r5
            d.p.d<d.e> r0 = r4.f
            if (r0 == 0) goto L50
            r4.J0()
            d.e r0 = new d.e
            r0.<init>()
            r0.k()
            d.p.d<d.e> r1 = r4.f
            r1.b(r0, r5)
            r4.B0()
        L50:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: d.p.b.P0(boolean):void");
    }

    @Override // d.m
    protected void Q() {
        this.o.a(this);
        if (this.p == EnumC0116b.TERM_REQ_SENT_1) {
            this.f = null;
            m0(this.n);
        }
        if (this.e == null) {
            return;
        }
        if (this.t) {
            this.e = null;
        }
        do {
        } while (this.e.d() != null);
        this.e = null;
    }

    public boolean Q0(d.e eVar) {
        if (z0()) {
            boolean j = eVar.j();
            boolean o = eVar.o();
            this.f.b(eVar, j);
            if (j || o) {
                return true;
            }
            this.l++;
            return true;
        }
        return false;
    }

    public String toString() {
        return String.valueOf(super.toString()) + "(" + this.u.getClass().getSimpleName() + "[" + this.u.G() + "]->" + this.n.u.getClass().getSimpleName() + "[" + this.n.u.G() + "])";
    }

    public boolean x0() {
        int i = this.i;
        return !(i > 0 && this.l - this.m >= ((long) i));
    }

    public boolean y0() {
        if (this.g) {
            EnumC0116b enumC0116b = this.p;
            if (enumC0116b == EnumC0116b.ACTIVE || enumC0116b == EnumC0116b.WAITING_FOR_DELIMITER) {
                if (!this.e.c()) {
                    this.g = false;
                    return false;
                } else if (F0(this.e.a())) {
                    this.e.d();
                    H0();
                    return false;
                } else {
                    return true;
                }
            }
            return false;
        }
        return false;
    }

    public boolean z0() {
        if (this.h && this.p == EnumC0116b.ACTIVE) {
            if (!x0()) {
                this.h = false;
                return false;
            }
            return true;
        }
        return false;
    }
}
