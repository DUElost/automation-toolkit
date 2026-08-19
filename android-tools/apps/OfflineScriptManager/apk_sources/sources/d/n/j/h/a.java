package d.n.j.h;

import d.n.f;
/* loaded from: classes.dex */
public class a extends c {
    private static /* synthetic */ int[] x;
    private d.n.j.a v;
    EnumC0114a w;

    /* JADX INFO: Access modifiers changed from: private */
    /* renamed from: d.n.j.h.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public enum EnumC0114a {
        UNPLUGGED,
        WAITING_FOR_RECONNECT_TIME,
        WAITING_FOR_PROXY_CONNECTION,
        SENDING_GREETING,
        WAITING_FOR_CHOICE,
        SENDING_REQUEST,
        WAITING_FOR_RESPONSE;

        /* renamed from: values  reason: to resolve conflict with enum method */
        public static EnumC0114a[] valuesCustom() {
            EnumC0114a[] valuesCustom = values();
            int length = valuesCustom.length;
            EnumC0114a[] enumC0114aArr = new EnumC0114a[length];
            System.arraycopy(valuesCustom, 0, enumC0114aArr, 0, length);
            return enumC0114aArr;
        }
    }

    public a(d.n.d dVar, f fVar, d.f fVar2, d.n.j.a aVar, d.n.j.a aVar2, boolean z) {
        super(dVar, fVar, fVar2, aVar, z);
        this.v = aVar2;
        aVar2.toString();
        this.w = EnumC0114a.UNPLUGGED;
        throw new UnsupportedOperationException("Socks connecter is not implemented");
    }

    static /* synthetic */ int[] M0() {
        int[] iArr = x;
        if (iArr != null) {
            return iArr;
        }
        int[] iArr2 = new int[EnumC0114a.valuesCustom().length];
        try {
            iArr2[EnumC0114a.SENDING_GREETING.ordinal()] = 4;
        } catch (NoSuchFieldError unused) {
        }
        try {
            iArr2[EnumC0114a.SENDING_REQUEST.ordinal()] = 6;
        } catch (NoSuchFieldError unused2) {
        }
        try {
            iArr2[EnumC0114a.UNPLUGGED.ordinal()] = 1;
        } catch (NoSuchFieldError unused3) {
        }
        try {
            iArr2[EnumC0114a.WAITING_FOR_CHOICE.ordinal()] = 5;
        } catch (NoSuchFieldError unused4) {
        }
        try {
            iArr2[EnumC0114a.WAITING_FOR_PROXY_CONNECTION.ordinal()] = 3;
        } catch (NoSuchFieldError unused5) {
        }
        try {
            iArr2[EnumC0114a.WAITING_FOR_RECONNECT_TIME.ordinal()] = 2;
        } catch (NoSuchFieldError unused6) {
        }
        try {
            iArr2[EnumC0114a.WAITING_FOR_RESPONSE.ordinal()] = 7;
        } catch (NoSuchFieldError unused7) {
        }
        x = iArr2;
        return iArr2;
    }

    void N0() {
    }

    void O0() {
    }

    @Override // d.n.j.h.c, d.m
    protected void R() {
        if (this.q) {
            O0();
        } else {
            N0();
        }
    }

    @Override // d.n.j.h.c, d.g, d.m
    protected void W(int i) {
        switch (M0()[this.w.ordinal()]) {
            case 2:
                this.m.d(1);
                break;
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
                close();
                break;
        }
        super.W(i);
    }

    @Override // d.n.j.h.c, d.q.a
    public void e() {
        super.e();
    }

    @Override // d.n.j.h.c, d.q.a
    public void h(int i) {
        super.h(i);
    }

    @Override // d.n.j.h.c, d.q.a
    public void s() {
        super.s();
    }
}
