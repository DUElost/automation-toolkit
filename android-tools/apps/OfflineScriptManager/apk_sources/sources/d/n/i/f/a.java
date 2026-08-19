package d.n.i.f;

import d.e;
import d.f;
import d.n.i.a;
/* loaded from: classes.dex */
public class a extends d.n.i.a {
    private static /* synthetic */ int[] j;
    private EnumC0112a i;

    /* JADX INFO: Access modifiers changed from: private */
    /* renamed from: d.n.i.f.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public enum EnumC0112a {
        SENDING_HELLO,
        WAITING_FOR_WELCOME,
        SENDING_INITIATE,
        WAITING_FOR_READY,
        ERROR_COMMAND_RECEIVED,
        READY;

        /* renamed from: values  reason: to resolve conflict with enum method */
        public static EnumC0112a[] valuesCustom() {
            EnumC0112a[] valuesCustom = values();
            int length = valuesCustom.length;
            EnumC0112a[] enumC0112aArr = new EnumC0112a[length];
            System.arraycopy(valuesCustom, 0, enumC0112aArr, 0, length);
            return enumC0112aArr;
        }
    }

    public a(f fVar) {
        super(null, null, fVar);
        this.i = EnumC0112a.SENDING_HELLO;
    }

    static /* synthetic */ int[] A() {
        int[] iArr = j;
        if (iArr != null) {
            return iArr;
        }
        int[] iArr2 = new int[EnumC0112a.valuesCustom().length];
        try {
            iArr2[EnumC0112a.ERROR_COMMAND_RECEIVED.ordinal()] = 5;
        } catch (NoSuchFieldError unused) {
        }
        try {
            iArr2[EnumC0112a.READY.ordinal()] = 6;
        } catch (NoSuchFieldError unused2) {
        }
        try {
            iArr2[EnumC0112a.SENDING_HELLO.ordinal()] = 1;
        } catch (NoSuchFieldError unused3) {
        }
        try {
            iArr2[EnumC0112a.SENDING_INITIATE.ordinal()] = 3;
        } catch (NoSuchFieldError unused4) {
        }
        try {
            iArr2[EnumC0112a.WAITING_FOR_READY.ordinal()] = 4;
        } catch (NoSuchFieldError unused5) {
        }
        try {
            iArr2[EnumC0112a.WAITING_FOR_WELCOME.ordinal()] = 2;
        } catch (NoSuchFieldError unused6) {
        }
        j = iArr2;
        return iArr2;
    }

    private int B(e eVar) {
        EnumC0112a enumC0112a = this.i;
        if ((enumC0112a == EnumC0112a.WAITING_FOR_WELCOME || enumC0112a == EnumC0112a.WAITING_FOR_READY) && eVar.B() >= 7 && eVar.e(6) <= eVar.B() - 7) {
            this.i = EnumC0112a.ERROR_COMMAND_RECEIVED;
            return 0;
        }
        return 156384820;
    }

    private int C(e eVar) {
        if (this.i != EnumC0112a.WAITING_FOR_READY) {
            return 156384820;
        }
        int o = o(eVar, 6, false);
        if (o == 0) {
            this.i = EnumC0112a.READY;
        }
        return o;
    }

    private int D(e eVar) {
        if (this.i == EnumC0112a.WAITING_FOR_WELCOME && eVar.B() == 8) {
            this.i = EnumC0112a.SENDING_INITIATE;
            return 0;
        }
        return 156384820;
    }

    private int E(e eVar) {
        f fVar = this.f2609a;
        String str = fVar.E;
        String str2 = fVar.F;
        f(eVar, "HELLO");
        f(eVar, str);
        f(eVar, str2);
        return 0;
    }

    private int F(e eVar) {
        f(eVar, "INITIATE");
        d(eVar, "Socket-Type", x(this.f2609a.j));
        f fVar = this.f2609a;
        int i = fVar.j;
        if (i == 3 || i == 5 || i == 6) {
            e(eVar, "Identity", fVar.e);
            return 0;
        }
        return 0;
    }

    @Override // d.n.i.a
    public int m(e eVar) {
        int E;
        EnumC0112a enumC0112a;
        int i = A()[this.i.ordinal()];
        if (i == 1) {
            E = E(eVar);
            if (E != 0) {
                return E;
            }
            enumC0112a = EnumC0112a.WAITING_FOR_WELCOME;
        } else if (i != 3) {
            return 35;
        } else {
            E = F(eVar);
            if (E != 0) {
                return E;
            }
            enumC0112a = EnumC0112a.WAITING_FOR_READY;
        }
        this.i = enumC0112a;
        return E;
    }

    @Override // d.n.i.a
    public int q(e eVar) {
        int B = eVar.B();
        if (B < 8 || !h(eVar, "WELCOME", true)) {
            if (B < 6 || !h(eVar, "READY", true)) {
                if (B < 6 || !h(eVar, "ERROR", true)) {
                    System.out.println("PLAIN Client I: invalid handshake command");
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
        EnumC0112a enumC0112a = this.i;
        return enumC0112a == EnumC0112a.READY ? a.b.READY : enumC0112a == EnumC0112a.ERROR_COMMAND_RECEIVED ? a.b.ERROR : a.b.HANDSHAKING;
    }

    @Override // d.n.i.a
    public int z() {
        return 0;
    }
}
