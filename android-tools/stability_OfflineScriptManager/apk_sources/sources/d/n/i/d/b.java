package d.n.i.d;

import d.e;
import d.f;
import d.l;
import d.n.i.a;
import d.n.i.d.a;
import d.s.g;
import java.nio.ByteBuffer;
import java.nio.charset.Charset;
/* loaded from: classes.dex */
public class b extends d.n.i.a {
    private static /* synthetic */ int[] v;
    private a i;
    private final byte[] j;
    private final byte[] k;
    private final byte[] l;
    private final byte[] m;
    private final byte[] n;
    private byte[] o;
    private byte[] p;
    private final byte[] q;
    private long r;
    private long s;
    private final d.n.i.d.a t;
    private final d.s.c u;

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public enum a {
        SEND_HELLO,
        EXPECT_WELCOME,
        SEND_INITIATE,
        EXPECT_READY,
        ERROR_RECEIVED,
        CONNECTED;

        /* renamed from: values  reason: to resolve conflict with enum method */
        public static a[] valuesCustom() {
            a[] valuesCustom = values();
            int length = valuesCustom.length;
            a[] aVarArr = new a[length];
            System.arraycopy(valuesCustom, 0, aVarArr, 0, length);
            return aVarArr;
        }
    }

    public b(f fVar) {
        super(null, null, fVar);
        this.o = new byte[a.EnumC0110a.e.a()];
        this.p = new byte[96];
        this.q = new byte[a.EnumC0110a.h.a()];
        this.i = a.SEND_HELLO;
        this.r = 1L;
        this.s = 1L;
        this.j = fVar.G;
        this.k = fVar.H;
        this.n = fVar.I;
        d.n.i.d.a aVar = new d.n.i.d.a();
        this.t = aVar;
        byte[][] f = aVar.f();
        this.l = f[0];
        this.m = f[1];
        this.u = fVar.P;
    }

    static /* synthetic */ int[] A() {
        int[] iArr = v;
        if (iArr != null) {
            return iArr;
        }
        int[] iArr2 = new int[a.valuesCustom().length];
        try {
            iArr2[a.CONNECTED.ordinal()] = 6;
        } catch (NoSuchFieldError unused) {
        }
        try {
            iArr2[a.ERROR_RECEIVED.ordinal()] = 5;
        } catch (NoSuchFieldError unused2) {
        }
        try {
            iArr2[a.EXPECT_READY.ordinal()] = 4;
        } catch (NoSuchFieldError unused3) {
        }
        try {
            iArr2[a.EXPECT_WELCOME.ordinal()] = 2;
        } catch (NoSuchFieldError unused4) {
        }
        try {
            iArr2[a.SEND_HELLO.ordinal()] = 1;
        } catch (NoSuchFieldError unused5) {
        }
        try {
            iArr2[a.SEND_INITIATE.ordinal()] = 3;
        } catch (NoSuchFieldError unused6) {
        }
        v = iArr2;
        return iArr2;
    }

    private int B(e eVar) {
        a aVar = this.i;
        if ((aVar == a.EXPECT_WELCOME || aVar == a.EXPECT_READY) && eVar.B() >= 7 && eVar.e(6) <= eVar.B() - 7) {
            this.i = a.ERROR_RECEIVED;
            return 0;
        }
        return 156384820;
    }

    private int C(e eVar) {
        if (eVar.B() < 30) {
            return 156384820;
        }
        a.EnumC0110a enumC0110a = a.EnumC0110a.f2622d;
        int a2 = (enumC0110a.a() + eVar.B()) - 14;
        ByteBuffer allocate = ByteBuffer.allocate(a.EnumC0110a.f2620b.a());
        a.EnumC0110a enumC0110a2 = a.EnumC0110a.f2621c;
        ByteBuffer allocate2 = ByteBuffer.allocate(enumC0110a2.a() + 256);
        ByteBuffer allocate3 = ByteBuffer.allocate(enumC0110a.a() + 16 + 256);
        allocate3.position(enumC0110a.a());
        eVar.C(allocate3, 14, a2 - enumC0110a.a());
        allocate.put("CurveZMQREADY---".getBytes(l.f2560c));
        eVar.C(allocate, 6, 8);
        this.s = g.c(eVar, 6);
        if (this.t.i(allocate2, allocate3, a2, allocate, this.q) != 0) {
            return 156384820;
        }
        allocate2.limit(a2);
        int n = n(allocate2, enumC0110a2.a(), false);
        if (n == 0) {
            this.i = a.CONNECTED;
        }
        return n;
    }

    private int D(e eVar) {
        if (eVar.B() != 168) {
            s("CURVE I: server HELLO is not correct size");
            return 156384820;
        }
        ByteBuffer allocate = ByteBuffer.allocate(a.EnumC0110a.f2620b.a());
        a.EnumC0110a enumC0110a = a.EnumC0110a.f2621c;
        ByteBuffer allocate2 = ByteBuffer.allocate(enumC0110a.a() + 128);
        a.EnumC0110a enumC0110a2 = a.EnumC0110a.f2622d;
        ByteBuffer allocate3 = ByteBuffer.allocate(enumC0110a2.a() + 144);
        allocate3.position(enumC0110a2.a());
        eVar.C(allocate3, 24, 144);
        allocate.put("WELCOME-".getBytes(l.f2560c));
        eVar.C(allocate, 8, 16);
        if (this.t.g(allocate2, allocate3, allocate3.capacity(), allocate, this.n, this.m) != 0) {
            return 156384820;
        }
        allocate2.position(enumC0110a.a());
        allocate2.get(this.o);
        allocate2.get(this.p);
        this.t.c(this.q, this.o, this.m);
        this.i = a.SEND_INITIATE;
        return 0;
    }

    private int E(e eVar) {
        ByteBuffer allocate = ByteBuffer.allocate(a.EnumC0110a.f2620b.a());
        ByteBuffer allocate2 = ByteBuffer.allocate(a.EnumC0110a.f2621c.a() + 64);
        a.EnumC0110a enumC0110a = a.EnumC0110a.f2622d;
        ByteBuffer allocate3 = ByteBuffer.allocate(enumC0110a.a() + 80);
        allocate.put("CurveZMQHELLO---".getBytes(l.f2560c));
        g.f(allocate, this.r);
        if (this.t.d(allocate3, allocate2, allocate2.capacity(), allocate, this.n, this.m) != 0) {
            return -1;
        }
        f(eVar, "HELLO");
        eVar.q(1);
        eVar.q(0);
        eVar.u(new byte[72]);
        eVar.u(this.l);
        eVar.t(allocate, 16, 8);
        eVar.t(allocate3, enumC0110a.a(), 80);
        this.r++;
        return 0;
    }

    private int F(e eVar) {
        a.EnumC0110a enumC0110a = a.EnumC0110a.f2620b;
        ByteBuffer allocate = ByteBuffer.allocate(enumC0110a.a());
        a.EnumC0110a enumC0110a2 = a.EnumC0110a.f2621c;
        ByteBuffer allocate2 = ByteBuffer.allocate(enumC0110a2.a() + 64);
        a.EnumC0110a enumC0110a3 = a.EnumC0110a.f2622d;
        ByteBuffer allocate3 = ByteBuffer.allocate(enumC0110a3.a() + 80);
        allocate2.position(enumC0110a2.a());
        allocate2.put(this.l);
        allocate2.put(this.n);
        Charset charset = l.f2560c;
        allocate.put("VOUCH---".getBytes(charset));
        allocate.put(this.t.k(16));
        if (this.t.d(allocate3, allocate2, allocate2.capacity(), allocate, this.o, this.k) == -1) {
            return -1;
        }
        ByteBuffer allocate4 = ByteBuffer.allocate(enumC0110a.a());
        ByteBuffer allocate5 = ByteBuffer.allocate(enumC0110a2.a() + 128 + 256);
        ByteBuffer allocate6 = ByteBuffer.allocate(enumC0110a3.a() + 144 + 256);
        allocate5.position(enumC0110a2.a());
        allocate5.put(this.j);
        allocate.limit(24).position(8);
        allocate5.put(allocate);
        allocate3.limit(enumC0110a3.a() + 80).position(enumC0110a3.a());
        allocate5.put(allocate3);
        b(allocate5, "Socket-Type", x(this.f2609a.j));
        f fVar = this.f2609a;
        int i = fVar.j;
        if (i == 3 || i == 5 || i == 6) {
            c(allocate5, "Identity", fVar.e);
        }
        int position = allocate5.position();
        allocate4.put("CurveZMQINITIATE".getBytes(charset));
        g.f(allocate4, this.r);
        if (this.t.d(allocate6, allocate5, position, allocate4, this.o, this.m) == -1) {
            return -1;
        }
        f(eVar, "INITIATE");
        eVar.u(this.p);
        eVar.t(allocate4, 16, 8);
        eVar.t(allocate6, enumC0110a3.a(), position - enumC0110a3.a());
        this.r++;
        return 0;
    }

    @Override // d.n.i.a
    public e i(e eVar) {
        String str;
        if (eVar.B() < 33) {
            str = "CURVE I: invalid CURVE server, sent malformed command";
        } else if (h(eVar, "MESSAGE", true)) {
            ByteBuffer allocate = ByteBuffer.allocate(a.EnumC0110a.f2620b.a());
            allocate.put("CurveZMQMESSAGES".getBytes(l.f2560c));
            eVar.C(allocate, 8, 8);
            long c2 = g.c(eVar, 8);
            if (c2 > this.s) {
                this.s = c2;
                a.EnumC0110a enumC0110a = a.EnumC0110a.f2622d;
                int a2 = (enumC0110a.a() + eVar.B()) - 16;
                ByteBuffer allocate2 = ByteBuffer.allocate(a2);
                ByteBuffer allocate3 = ByteBuffer.allocate(a2);
                allocate3.position(enumC0110a.a());
                eVar.C(allocate3, 16, eVar.B() - 16);
                if (this.t.i(allocate2, allocate3, a2, allocate, this.q) == 0) {
                    a.EnumC0110a enumC0110a2 = a.EnumC0110a.f2621c;
                    e eVar2 = new e((a2 - 1) - enumC0110a2.a());
                    if ((allocate2.get(enumC0110a2.a()) & 1) != 0) {
                        eVar2.y(1);
                    }
                    allocate2.position(enumC0110a2.a() + 1);
                    eVar2.s(allocate2);
                    return eVar2;
                }
                str = "CURVE I: connection key used for MESSAGE is wrong";
            }
            this.u.c(156384820);
            return null;
        } else {
            str = "CURVE I: invalid CURVE server, did not send MESSAGE";
        }
        s(str);
        this.u.c(156384820);
        return null;
    }

    @Override // d.n.i.a
    public e k(e eVar) {
        byte b2 = eVar.j() ? (byte) 1 : (byte) 0;
        ByteBuffer allocate = ByteBuffer.allocate(a.EnumC0110a.f2620b.a());
        allocate.put("CurveZMQMESSAGEC".getBytes(l.f2560c));
        g.f(allocate, this.r);
        a.EnumC0110a enumC0110a = a.EnumC0110a.f2621c;
        int a2 = enumC0110a.a() + 1 + eVar.B();
        ByteBuffer allocate2 = ByteBuffer.allocate(a2);
        allocate2.put(enumC0110a.a(), b2);
        allocate2.position(enumC0110a.a() + 1);
        eVar.C(allocate2, 0, eVar.B());
        ByteBuffer allocate3 = ByteBuffer.allocate(a2);
        this.t.a(allocate3, allocate2, a2, allocate, this.q);
        a.EnumC0110a enumC0110a2 = a.EnumC0110a.f2622d;
        e eVar2 = new e((a2 + 16) - enumC0110a2.a());
        f(eVar2, "MESSAGE");
        eVar2.t(allocate, 16, 8);
        eVar2.t(allocate3, enumC0110a2.a(), a2 - enumC0110a2.a());
        this.r++;
        return eVar2;
    }

    @Override // d.n.i.a
    public int m(e eVar) {
        int E;
        a aVar;
        int i = A()[this.i.ordinal()];
        if (i == 1) {
            E = E(eVar);
            if (E != 0) {
                return E;
            }
            aVar = a.EXPECT_WELCOME;
        } else if (i != 3) {
            return 35;
        } else {
            E = F(eVar);
            if (E != 0) {
                return E;
            }
            aVar = a.EXPECT_READY;
        }
        this.i = aVar;
        return E;
    }

    @Override // d.n.i.a
    public int q(e eVar) {
        int B = eVar.B();
        if (B < 8 || !h(eVar, "WELCOME", true)) {
            if (B < 6 || !h(eVar, "READY", true)) {
                if (B < 6 || !h(eVar, "ERROR", true)) {
                    return 156384820;
                }
                return B(eVar);
            }
            return C(eVar);
        }
        return D(eVar);
    }

    @Override // d.n.i.a
    public a.b y() {
        a aVar = this.i;
        return aVar == a.CONNECTED ? a.b.READY : aVar == a.ERROR_RECEIVED ? a.b.ERROR : a.b.HANDSHAKING;
    }

    @Override // d.n.i.a
    public int z() {
        return 0;
    }
}
