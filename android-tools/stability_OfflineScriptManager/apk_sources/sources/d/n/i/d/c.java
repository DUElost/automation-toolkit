package d.n.i.d;

import d.e;
import d.l;
import d.n.f;
import d.n.i.a;
import d.n.i.d.a;
import d.s.g;
import java.nio.ByteBuffer;
import java.nio.charset.Charset;
/* loaded from: classes.dex */
public class c extends d.n.i.a {
    private static /* synthetic */ int[] t;
    private long i;
    private long j;
    private final byte[] k;
    private final byte[] l;
    private final byte[] m;
    private byte[] n;
    private byte[] o;
    private final byte[] p;
    private a q;
    private final d.n.i.d.a r;
    private final d.s.c s;

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public enum a {
        EXPECT_HELLO,
        SEND_WELCOME,
        EXPECT_INITIATE,
        EXPECT_ZAP_REPLY,
        SEND_READY,
        SEND_ERROR,
        ERROR_SENT,
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

    public c(f fVar, d.n.j.a aVar, d.f fVar2) {
        super(fVar, aVar, fVar2);
        this.n = new byte[a.EnumC0110a.e.a()];
        this.p = new byte[a.EnumC0110a.h.a()];
        this.q = a.EXPECT_HELLO;
        this.i = 1L;
        this.j = 1L;
        this.k = fVar2.H;
        d.n.i.d.a aVar2 = new d.n.i.d.a();
        this.r = aVar2;
        byte[][] f = aVar2.f();
        this.l = f[0];
        this.m = f[1];
        this.s = fVar2.P;
    }

    static /* synthetic */ int[] A() {
        int[] iArr = t;
        if (iArr != null) {
            return iArr;
        }
        int[] iArr2 = new int[a.valuesCustom().length];
        try {
            iArr2[a.CONNECTED.ordinal()] = 8;
        } catch (NoSuchFieldError unused) {
        }
        try {
            iArr2[a.ERROR_SENT.ordinal()] = 7;
        } catch (NoSuchFieldError unused2) {
        }
        try {
            iArr2[a.EXPECT_HELLO.ordinal()] = 1;
        } catch (NoSuchFieldError unused3) {
        }
        try {
            iArr2[a.EXPECT_INITIATE.ordinal()] = 3;
        } catch (NoSuchFieldError unused4) {
        }
        try {
            iArr2[a.EXPECT_ZAP_REPLY.ordinal()] = 4;
        } catch (NoSuchFieldError unused5) {
        }
        try {
            iArr2[a.SEND_ERROR.ordinal()] = 6;
        } catch (NoSuchFieldError unused6) {
        }
        try {
            iArr2[a.SEND_READY.ordinal()] = 5;
        } catch (NoSuchFieldError unused7) {
        }
        try {
            iArr2[a.SEND_WELCOME.ordinal()] = 2;
        } catch (NoSuchFieldError unused8) {
        }
        t = iArr2;
        return iArr2;
    }

    private int B(e eVar) {
        String str;
        if (eVar.B() != 200) {
            str = "CURVE I: client HELLO is not correct size";
        } else if (h(eVar, "HELLO", true)) {
            byte e = eVar.e(6);
            byte e2 = eVar.e(7);
            if (e == 1 && e2 == 0) {
                eVar.f(80, this.n, 0, a.EnumC0110a.e.a());
                ByteBuffer allocate = ByteBuffer.allocate(a.EnumC0110a.f2620b.a());
                ByteBuffer allocate2 = ByteBuffer.allocate(a.EnumC0110a.f2621c.a() + 64);
                a.EnumC0110a enumC0110a = a.EnumC0110a.f2622d;
                ByteBuffer allocate3 = ByteBuffer.allocate(enumC0110a.a() + 80);
                allocate.put("CurveZMQHELLO---".getBytes(l.f2560c));
                eVar.C(allocate, 112, 8);
                this.j = g.c(eVar, 112);
                allocate3.position(enumC0110a.a());
                eVar.C(allocate3, 120, 80);
                if (this.r.g(allocate2, allocate3, allocate3.capacity(), allocate, this.n, this.k) == 0) {
                    this.q = a.SEND_WELCOME;
                    return 0;
                }
                str = "CURVE I: cannot open client HELLO -- wrong server key?";
            } else {
                str = "CURVE I: client HELLO has unknown version number";
            }
        } else {
            str = "CURVE I: client HELLO has invalid command name";
        }
        s(str);
        return 156384820;
    }

    private int C(e eVar) {
        String str;
        a aVar;
        if (eVar.B() < 257) {
            str = "CURVE I: client INITIATE is not correct size";
        } else if (h(eVar, "INITIATE", true)) {
            a.EnumC0110a enumC0110a = a.EnumC0110a.f2620b;
            ByteBuffer allocate = ByteBuffer.allocate(enumC0110a.a());
            a.EnumC0110a enumC0110a2 = a.EnumC0110a.f2621c;
            ByteBuffer allocate2 = ByteBuffer.allocate(enumC0110a2.a() + 64);
            a.EnumC0110a enumC0110a3 = a.EnumC0110a.f2622d;
            ByteBuffer allocate3 = ByteBuffer.allocate(enumC0110a3.a() + 80);
            allocate3.position(enumC0110a3.a());
            eVar.C(allocate3, 25, 80);
            Charset charset = l.f2560c;
            allocate.put("COOKIE--".getBytes(charset));
            eVar.C(allocate, 9, 16);
            if (this.r.n(allocate2, allocate3, allocate3.capacity(), allocate, this.o) != 0) {
                str = "CURVE I: cannot open client INITIATE cookie";
            } else if (g(allocate2, this.n, enumC0110a2.a(), 32) && g(allocate2, this.m, enumC0110a2.a() + 32, 32)) {
                int B = (eVar.B() - 113) + enumC0110a3.a();
                ByteBuffer allocate4 = ByteBuffer.allocate(enumC0110a.a());
                ByteBuffer allocate5 = ByteBuffer.allocate(enumC0110a2.a() + 128 + 256);
                ByteBuffer allocate6 = ByteBuffer.allocate(enumC0110a3.a() + 144 + 256);
                allocate6.position(enumC0110a3.a());
                eVar.C(allocate6, 113, B - enumC0110a3.a());
                allocate4.put("CurveZMQINITIATE".getBytes(charset));
                eVar.C(allocate4, 105, 8);
                this.j = g.c(eVar, 105);
                if (this.r.g(allocate5, allocate6, B, allocate4, this.n, this.m) != 0) {
                    str = "CURVE I: cannot open client INITIATE";
                } else {
                    byte[] bArr = new byte[384];
                    allocate5.position(enumC0110a2.a());
                    allocate5.get(bArr);
                    ByteBuffer allocate7 = ByteBuffer.allocate(enumC0110a.a());
                    ByteBuffer allocate8 = ByteBuffer.allocate(enumC0110a2.a() + 64);
                    ByteBuffer allocate9 = ByteBuffer.allocate(enumC0110a3.a() + 80);
                    allocate9.position(enumC0110a3.a());
                    allocate5.limit(enumC0110a2.a() + 48 + 80).position(enumC0110a2.a() + 48);
                    allocate9.put(allocate5);
                    allocate7.put("VOUCH---".getBytes(charset));
                    allocate5.limit(enumC0110a2.a() + 32 + 16).position(enumC0110a2.a() + 32);
                    allocate7.put(allocate5);
                    if (this.r.g(allocate8, allocate9, allocate9.capacity(), allocate7, bArr, this.m) != 0) {
                        str = "CURVE I: cannot open client INITIATE vouch";
                    } else if (g(allocate8, this.n, enumC0110a2.a(), 32)) {
                        this.r.c(this.p, this.n, this.m);
                        if (this.f.V0() == 0) {
                            G(bArr);
                            int t2 = t();
                            if (t2 == 0) {
                                if (!"200".equals(this.h)) {
                                    aVar = a.SEND_ERROR;
                                }
                            } else if (t2 != 35) {
                                return -1;
                            } else {
                                aVar = a.EXPECT_ZAP_REPLY;
                            }
                            this.q = aVar;
                            allocate5.position(0);
                            allocate5.limit(B);
                            return n(allocate5, enumC0110a2.a() + 128, false);
                        }
                        aVar = a.SEND_READY;
                        this.q = aVar;
                        allocate5.position(0);
                        allocate5.limit(B);
                        return n(allocate5, enumC0110a2.a() + 128, false);
                    } else {
                        str = "CURVE I: invalid handshake from client (public key)";
                    }
                }
            } else {
                str = "CURVE I: client INITIATE cookie is not valid";
            }
        } else {
            str = "CURVE I: client INITIATE has invalid command name";
        }
        s(str);
        return 156384820;
    }

    private int D(e eVar) {
        f(eVar, "ERROR");
        f(eVar, this.h);
        return 0;
    }

    private int E(e eVar) {
        ByteBuffer allocate = ByteBuffer.allocate(a.EnumC0110a.f2620b.a());
        a.EnumC0110a enumC0110a = a.EnumC0110a.f2621c;
        ByteBuffer allocate2 = ByteBuffer.allocate(enumC0110a.a() + 256);
        a.EnumC0110a enumC0110a2 = a.EnumC0110a.f2622d;
        ByteBuffer allocate3 = ByteBuffer.allocate(enumC0110a2.a() + 16 + 256);
        allocate2.position(enumC0110a.a());
        b(allocate2, "Socket-Type", x(this.f2609a.j));
        d.f fVar = this.f2609a;
        int i = fVar.j;
        if (i == 3 || i == 5 || i == 6) {
            c(allocate2, "Identity", fVar.e);
        }
        int position = allocate2.position();
        allocate.put("CurveZMQREADY---".getBytes(l.f2560c));
        g.f(allocate, this.i);
        this.r.a(allocate3, allocate2, position, allocate, this.p);
        f(eVar, "READY");
        eVar.t(allocate, 16, 8);
        eVar.t(allocate3, enumC0110a2.a(), position - enumC0110a2.a());
        this.i++;
        return 0;
    }

    private int F(e eVar) {
        a.EnumC0110a enumC0110a = a.EnumC0110a.f2620b;
        ByteBuffer allocate = ByteBuffer.allocate(enumC0110a.a());
        a.EnumC0110a enumC0110a2 = a.EnumC0110a.f2621c;
        ByteBuffer allocate2 = ByteBuffer.allocate(enumC0110a2.a() + 64);
        a.EnumC0110a enumC0110a3 = a.EnumC0110a.f2622d;
        ByteBuffer allocate3 = ByteBuffer.allocate(enumC0110a3.a() + 80);
        Charset charset = l.f2560c;
        allocate.put("COOKIE--".getBytes(charset));
        allocate.put(this.r.k(16));
        allocate2.position(enumC0110a2.a());
        allocate2.put(this.n);
        allocate2.put(this.m);
        this.o = this.r.k(a.EnumC0110a.g.a());
        this.r.l(allocate3, allocate2, allocate2.capacity(), allocate, this.o);
        ByteBuffer allocate4 = ByteBuffer.allocate(enumC0110a.a());
        ByteBuffer allocate5 = ByteBuffer.allocate(enumC0110a2.a() + 128);
        ByteBuffer allocate6 = ByteBuffer.allocate(enumC0110a3.a() + 144);
        allocate4.put("WELCOME-".getBytes(charset));
        allocate4.put(this.r.k(enumC0110a.a() - 8));
        allocate5.position(enumC0110a2.a());
        allocate5.put(this.l);
        allocate.limit(24).position(8);
        allocate5.put(allocate);
        allocate3.limit(enumC0110a3.a() + 80).position(enumC0110a3.a());
        allocate5.put(allocate3);
        if (this.r.d(allocate6, allocate5, allocate5.capacity(), allocate4, this.n, this.k) == -1) {
            return -1;
        }
        f(eVar, "WELCOME");
        eVar.t(allocate4, 8, 16);
        eVar.t(allocate6, enumC0110a3.a(), 144);
        return 0;
    }

    private void G(byte[] bArr) {
        u(d.n.i.b.CURVE, true);
        a.EnumC0110a enumC0110a = a.EnumC0110a.e;
        e eVar = new e(enumC0110a.a());
        eVar.v(bArr, 0, enumC0110a.a());
        this.f.U0(eVar);
    }

    @Override // d.n.i.a
    public e i(e eVar) {
        String str;
        if (eVar.B() < 33) {
            str = "CURVE I: invalid CURVE client, sent malformed command";
        } else if (h(eVar, "MESSAGE", true)) {
            ByteBuffer allocate = ByteBuffer.allocate(a.EnumC0110a.f2620b.a());
            allocate.put("CurveZMQMESSAGEC".getBytes(l.f2560c));
            eVar.C(allocate, 8, 8);
            long c2 = g.c(eVar, 8);
            if (c2 > this.j) {
                this.j = c2;
                a.EnumC0110a enumC0110a = a.EnumC0110a.f2622d;
                int a2 = (enumC0110a.a() + eVar.B()) - 16;
                ByteBuffer allocate2 = ByteBuffer.allocate(a2);
                ByteBuffer allocate3 = ByteBuffer.allocate(a2);
                allocate3.position(enumC0110a.a());
                eVar.C(allocate3, 16, eVar.B() - 16);
                if (this.r.i(allocate2, allocate3, a2, allocate, this.p) == 0) {
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
            this.s.c(156384820);
            return null;
        } else {
            str = "CURVE I: invalid CURVE client, did not send MESSAGE";
        }
        s(str);
        this.s.c(156384820);
        return null;
    }

    @Override // d.n.i.a
    public e k(e eVar) {
        byte b2 = eVar.j() ? (byte) 1 : (byte) 0;
        ByteBuffer allocate = ByteBuffer.allocate(a.EnumC0110a.f2620b.a());
        allocate.put("CurveZMQMESSAGES".getBytes(l.f2560c));
        g.f(allocate, this.i);
        a.EnumC0110a enumC0110a = a.EnumC0110a.f2621c;
        int a2 = enumC0110a.a() + 1 + eVar.B();
        ByteBuffer allocate2 = ByteBuffer.allocate(a2);
        allocate2.put(enumC0110a.a(), b2);
        allocate2.position(enumC0110a.a() + 1);
        eVar.C(allocate2, 0, eVar.B());
        ByteBuffer allocate3 = ByteBuffer.allocate(a2);
        this.r.a(allocate3, allocate2, a2, allocate, this.p);
        a.EnumC0110a enumC0110a2 = a.EnumC0110a.f2622d;
        e eVar2 = new e((a2 + 16) - enumC0110a2.a());
        f(eVar2, "MESSAGE");
        eVar2.t(allocate, 16, 8);
        eVar2.t(allocate3, enumC0110a2.a(), a2 - enumC0110a2.a());
        this.i++;
        return eVar2;
    }

    @Override // d.n.i.a
    public int m(e eVar) {
        int F;
        a aVar;
        int i = A()[this.q.ordinal()];
        if (i == 2) {
            F = F(eVar);
            if (F != 0) {
                return F;
            }
            aVar = a.EXPECT_INITIATE;
        } else if (i == 5) {
            F = E(eVar);
            if (F != 0) {
                return F;
            }
            aVar = a.CONNECTED;
        } else if (i != 6) {
            return 35;
        } else {
            F = D(eVar);
            if (F != 0) {
                return F;
            }
            aVar = a.ERROR_SENT;
        }
        this.q = aVar;
        return F;
    }

    @Override // d.n.i.a
    public int q(e eVar) {
        int i = A()[this.q.ordinal()];
        if (i != 1) {
            if (i != 3) {
                s("CURVE I: invalid handshake command");
                return 156384820;
            }
            return C(eVar);
        }
        return B(eVar);
    }

    @Override // d.n.i.a
    public a.b y() {
        a aVar = this.q;
        return aVar == a.CONNECTED ? a.b.READY : aVar == a.ERROR_SENT ? a.b.ERROR : a.b.HANDSHAKING;
    }

    @Override // d.n.i.a
    public int z() {
        if (this.q != a.EXPECT_ZAP_REPLY) {
            return 156384763;
        }
        int t2 = t();
        if (t2 == 0) {
            this.q = "200".equals(this.h) ? a.SEND_READY : a.SEND_ERROR;
        }
        return t2;
    }
}
