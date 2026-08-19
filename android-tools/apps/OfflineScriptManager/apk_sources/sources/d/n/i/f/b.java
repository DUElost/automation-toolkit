package d.n.i.f;

import d.e;
import d.n.f;
import d.n.i.a;
/* loaded from: classes.dex */
public class b extends d.n.i.a {
    private static /* synthetic */ int[] j;
    private a i;

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public enum a {
        WAITING_FOR_HELLO,
        SENDING_WELCOME,
        WAITING_FOR_INITIATE,
        SENDING_READY,
        WAITING_FOR_ZAP_REPLY,
        SENDING_ERROR,
        ERROR_COMMAND_SENT,
        READY;

        /* renamed from: values  reason: to resolve conflict with enum method */
        public static a[] valuesCustom() {
            a[] valuesCustom = values();
            int length = valuesCustom.length;
            a[] aVarArr = new a[length];
            System.arraycopy(valuesCustom, 0, aVarArr, 0, length);
            return aVarArr;
        }
    }

    public b(f fVar, d.n.j.a aVar, d.f fVar2) {
        super(fVar, aVar, fVar2);
        this.i = a.WAITING_FOR_HELLO;
    }

    static /* synthetic */ int[] A() {
        int[] iArr = j;
        if (iArr != null) {
            return iArr;
        }
        int[] iArr2 = new int[a.valuesCustom().length];
        try {
            iArr2[a.ERROR_COMMAND_SENT.ordinal()] = 7;
        } catch (NoSuchFieldError unused) {
        }
        try {
            iArr2[a.READY.ordinal()] = 8;
        } catch (NoSuchFieldError unused2) {
        }
        try {
            iArr2[a.SENDING_ERROR.ordinal()] = 6;
        } catch (NoSuchFieldError unused3) {
        }
        try {
            iArr2[a.SENDING_READY.ordinal()] = 4;
        } catch (NoSuchFieldError unused4) {
        }
        try {
            iArr2[a.SENDING_WELCOME.ordinal()] = 2;
        } catch (NoSuchFieldError unused5) {
        }
        try {
            iArr2[a.WAITING_FOR_HELLO.ordinal()] = 1;
        } catch (NoSuchFieldError unused6) {
        }
        try {
            iArr2[a.WAITING_FOR_INITIATE.ordinal()] = 3;
        } catch (NoSuchFieldError unused7) {
        }
        try {
            iArr2[a.WAITING_FOR_ZAP_REPLY.ordinal()] = 5;
        } catch (NoSuchFieldError unused8) {
        }
        j = iArr2;
        return iArr2;
    }

    private int B(e eVar) {
        f(eVar, "ERROR");
        f(eVar, this.h);
        return 0;
    }

    private int C(e eVar) {
        String str;
        a aVar;
        int B = eVar.B();
        if (B < 6 || !h(eVar, "HELLO", true)) {
            str = "PLAIN I: invalid PLAIN client, did not send HELLO";
        } else {
            int i = B - 6;
            if (i < 1) {
                str = "PLAIN I: invalid PLAIN client, did not send username";
            } else {
                int e = eVar.e(6);
                int i2 = i - 1;
                if (i2 < e) {
                    str = "PLAIN I: invalid PLAIN client, sent malformed username";
                } else {
                    byte[] bArr = new byte[e];
                    eVar.f(7, bArr, 0, e);
                    int i3 = i2 - e;
                    int i4 = 7 + e;
                    int e2 = eVar.e(i4);
                    int i5 = i3 - 1;
                    if (i5 < e2) {
                        str = "PLAIN I: invalid PLAIN client, sent malformed password";
                    } else {
                        byte[] bArr2 = new byte[e2];
                        eVar.f(i4 + 1, bArr2, 0, e2);
                        if (i5 - e2 <= 0) {
                            if (this.f.V0() == 0) {
                                G(bArr, bArr2);
                                int t = t();
                                if (t == 0) {
                                    if (!"200".equals(this.h)) {
                                        aVar = a.SENDING_ERROR;
                                    }
                                } else if (t != 35) {
                                    return -1;
                                } else {
                                    aVar = a.WAITING_FOR_ZAP_REPLY;
                                }
                                this.i = aVar;
                                return 0;
                            }
                            aVar = a.SENDING_WELCOME;
                            this.i = aVar;
                            return 0;
                        }
                        str = "PLAIN I: invalid PLAIN client, sent extraneous data";
                    }
                }
            }
        }
        s(str);
        return 156384820;
    }

    private int D(e eVar) {
        if (eVar.B() < 9 || !h(eVar, "INITIATE", true)) {
            s("PLAIN I: invalid PLAIN client, did not send INITIATE");
            return 156384820;
        }
        int o = o(eVar, 9, false);
        if (o == 0) {
            this.i = a.SENDING_READY;
        }
        return o;
    }

    private int E(e eVar) {
        f(eVar, "READY");
        d(eVar, "Socket-Type", x(this.f2609a.j));
        d.f fVar = this.f2609a;
        int i = fVar.j;
        if (i == 3 || i == 5 || i == 6) {
            e(eVar, "Identity", fVar.e);
            return 0;
        }
        return 0;
    }

    private int F(e eVar) {
        f(eVar, "WELCOME");
        return 0;
    }

    private void G(byte[] bArr, byte[] bArr2) {
        u(d.n.i.b.PLAIN, true);
        e eVar = new e(bArr.length);
        eVar.y(1);
        eVar.u(bArr);
        this.f.U0(eVar);
        e eVar2 = new e(bArr2.length);
        eVar2.u(bArr2);
        this.f.U0(eVar2);
    }

    @Override // d.n.i.a
    public int m(e eVar) {
        int F;
        a aVar;
        int i = A()[this.i.ordinal()];
        if (i == 2) {
            F = F(eVar);
            if (F != 0) {
                return F;
            }
            aVar = a.WAITING_FOR_INITIATE;
        } else if (i == 4) {
            F = E(eVar);
            if (F != 0) {
                return F;
            }
            aVar = a.READY;
        } else if (i != 6) {
            return 35;
        } else {
            F = B(eVar);
            if (F != 0) {
                return F;
            }
            aVar = a.ERROR_COMMAND_SENT;
        }
        this.i = aVar;
        return F;
    }

    @Override // d.n.i.a
    public int q(e eVar) {
        int i = A()[this.i.ordinal()];
        if (i != 1) {
            if (i != 3) {
                s("PLAIN Server I: invalid handshake command");
                return 156384820;
            }
            return D(eVar);
        }
        return C(eVar);
    }

    @Override // d.n.i.a
    public a.b y() {
        a aVar = this.i;
        return aVar == a.READY ? a.b.READY : aVar == a.ERROR_COMMAND_SENT ? a.b.ERROR : a.b.HANDSHAKING;
    }

    @Override // d.n.i.a
    public int z() {
        if (this.i != a.WAITING_FOR_ZAP_REPLY) {
            return 156384763;
        }
        int t = t();
        if (t == 0) {
            this.i = "200".equals(this.h) ? a.SENDING_WELCOME : a.SENDING_ERROR;
        }
        return t;
    }
}
