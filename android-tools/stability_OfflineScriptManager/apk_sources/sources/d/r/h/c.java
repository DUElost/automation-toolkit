package d.r.h;

import d.e;
import d.j;
import d.s.f;
/* loaded from: classes.dex */
public class c extends d.r.h.a {
    private boolean D;
    private boolean E;
    private final f<d.p.b> F;
    private boolean G;
    private int H;
    private boolean I;

    /* loaded from: classes.dex */
    public static class a extends d.n.f {
        private static /* synthetic */ int[] B;
        private EnumC0118a A;

        /* JADX INFO: Access modifiers changed from: package-private */
        /* renamed from: d.r.h.c$a$a  reason: collision with other inner class name */
        /* loaded from: classes.dex */
        public enum EnumC0118a {
            BOTTOM,
            BODY;

            /* renamed from: values  reason: to resolve conflict with enum method */
            public static EnumC0118a[] valuesCustom() {
                EnumC0118a[] valuesCustom = values();
                int length = valuesCustom.length;
                EnumC0118a[] enumC0118aArr = new EnumC0118a[length];
                System.arraycopy(valuesCustom, 0, enumC0118aArr, 0, length);
                return enumC0118aArr;
            }
        }

        public a(d.n.d dVar, boolean z, j jVar, d.f fVar, d.n.j.a aVar) {
            super(dVar, z, jVar, fVar, aVar);
            this.A = EnumC0118a.BOTTOM;
        }

        static /* synthetic */ int[] X0() {
            int[] iArr = B;
            if (iArr != null) {
                return iArr;
            }
            int[] iArr2 = new int[EnumC0118a.valuesCustom().length];
            try {
                iArr2[EnumC0118a.BODY.ordinal()] = 2;
            } catch (NoSuchFieldError unused) {
            }
            try {
                iArr2[EnumC0118a.BOTTOM.ordinal()] = 1;
            } catch (NoSuchFieldError unused2) {
            }
            B = iArr2;
            return iArr2;
        }

        @Override // d.n.f
        public boolean P0(e eVar) {
            int i = X0()[this.A.ordinal()];
            if (i != 1) {
                if (i == 2) {
                    if (eVar.j()) {
                        return super.P0(eVar);
                    }
                    if (eVar.d() == 0) {
                        this.A = EnumC0118a.BOTTOM;
                        return super.P0(eVar);
                    }
                }
            } else if (eVar.j() && eVar.B() == 0) {
                this.A = EnumC0118a.BODY;
                return super.P0(eVar);
            }
            this.l.c(14);
            return false;
        }

        @Override // d.n.f
        public void S0() {
            super.S0();
            this.A = EnumC0118a.BOTTOM;
        }
    }

    public c(d.c cVar, int i, int i2) {
        super(cVar, i, i2);
        this.F = new f<>();
        this.D = false;
        this.E = true;
        this.e.j = 3;
        this.G = false;
        this.H = d.s.e.c();
        this.I = true;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // d.r.h.a, d.j
    public void m1(d.p.b bVar) {
        if (this.F.a() == bVar) {
            this.F.b(null);
        }
        super.m1(bVar);
    }

    /* JADX WARN: Removed duplicated region for block: B:24:0x0068 A[RETURN] */
    /* JADX WARN: Removed duplicated region for block: B:25:0x0069  */
    @Override // d.r.h.a, d.j
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public boolean o1(d.e r6) {
        /*
            r5 = this;
            boolean r0 = r5.D
            r1 = 0
            r2 = 1
            if (r0 == 0) goto L17
            boolean r0 = r5.I
            if (r0 == 0) goto L13
            d.s.c r6 = r5.l
            r0 = 156384763(0x9523dfb, float:2.5306974E-33)
            r6.c(r0)
            return r1
        L13:
            r5.D = r1
            r5.E = r2
        L17:
            boolean r0 = r5.E
            if (r0 == 0) goto L5e
            d.s.f<d.p.b> r0 = r5.F
            r3 = 0
            r0.b(r3)
            boolean r0 = r5.G
            if (r0 == 0) goto L45
            int r0 = r5.H
            int r0 = r0 + r2
            r5.H = r0
            d.e r0 = new d.e
            r3 = 4
            r0.<init>(r3)
            java.nio.ByteBuffer r3 = r0.a()
            int r4 = r5.H
            d.s.g.d(r3, r4)
            r0.y(r2)
            d.s.f<d.p.b> r3 = r5.F
            boolean r0 = super.s1(r0, r3)
            if (r0 != 0) goto L45
            return r1
        L45:
            d.e r0 = new d.e
            r0.<init>()
            r0.y(r2)
            d.s.f<d.p.b> r3 = r5.F
            boolean r0 = super.s1(r0, r3)
            if (r0 != 0) goto L56
            return r1
        L56:
            r5.E = r1
        L58:
            d.e r0 = super.t1()
            if (r0 != 0) goto L58
        L5e:
            boolean r0 = r6.j()
            boolean r6 = super.o1(r6)
            if (r6 != 0) goto L69
            return r1
        L69:
            if (r0 != 0) goto L6f
            r5.D = r2
            r5.E = r2
        L6f:
            return r2
        */
        throw new UnsupportedOperationException("Method not decompiled: d.r.h.c.o1(d.e):boolean");
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // d.r.h.a, d.j
    public boolean p1(int i, Object obj) {
        if (i == 52) {
            this.G = d.f.c(i, obj);
            return true;
        } else if (i != 53) {
            return super.p1(i, obj);
        } else {
            this.I = !d.f.c(i, obj);
            return true;
        }
    }
}
