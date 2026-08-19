package d.n.i.d;

import com.neilalexander.jnacl.crypto.curve25519xsalsa20poly1305;
import com.neilalexander.jnacl.crypto.xsalsa20poly1305;
import d.s.e;
import java.nio.ByteBuffer;
/* loaded from: classes.dex */
public class a {

    /* JADX WARN: Failed to restore enum class, 'enum' modifier and super class removed */
    /* JADX WARN: Unknown enum class pattern. Please report as an issue! */
    /* renamed from: d.n.i.d.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    static abstract class EnumC0110a {

        /* renamed from: b  reason: collision with root package name */
        public static final EnumC0110a f2620b;

        /* renamed from: c  reason: collision with root package name */
        public static final EnumC0110a f2621c;

        /* renamed from: d  reason: collision with root package name */
        public static final EnumC0110a f2622d;
        public static final EnumC0110a e;
        public static final EnumC0110a f;
        public static final EnumC0110a g;
        public static final EnumC0110a h;
        private static final /* synthetic */ EnumC0110a[] i;

        /* renamed from: d.n.i.d.a$a$a  reason: collision with other inner class name */
        /* loaded from: classes.dex */
        enum C0111a extends EnumC0110a {
            C0111a(String str, int i) {
                super(str, i, null);
            }

            @Override // d.n.i.d.a.EnumC0110a
            public int a() {
                return 24;
            }
        }

        /* renamed from: d.n.i.d.a$a$b */
        /* loaded from: classes.dex */
        enum b extends EnumC0110a {
            b(String str, int i) {
                super(str, i, null);
            }

            @Override // d.n.i.d.a.EnumC0110a
            public int a() {
                return 32;
            }
        }

        /* renamed from: d.n.i.d.a$a$c */
        /* loaded from: classes.dex */
        enum c extends EnumC0110a {
            c(String str, int i) {
                super(str, i, null);
            }

            @Override // d.n.i.d.a.EnumC0110a
            public int a() {
                return 16;
            }
        }

        /* renamed from: d.n.i.d.a$a$d */
        /* loaded from: classes.dex */
        enum d extends EnumC0110a {
            d(String str, int i) {
                super(str, i, null);
            }

            @Override // d.n.i.d.a.EnumC0110a
            public int a() {
                return 32;
            }
        }

        /* renamed from: d.n.i.d.a$a$e */
        /* loaded from: classes.dex */
        enum e extends EnumC0110a {
            e(String str, int i) {
                super(str, i, null);
            }

            @Override // d.n.i.d.a.EnumC0110a
            public int a() {
                return 32;
            }
        }

        /* renamed from: d.n.i.d.a$a$f */
        /* loaded from: classes.dex */
        enum f extends EnumC0110a {
            f(String str, int i) {
                super(str, i, null);
            }

            @Override // d.n.i.d.a.EnumC0110a
            public int a() {
                return 32;
            }
        }

        /* renamed from: d.n.i.d.a$a$g */
        /* loaded from: classes.dex */
        enum g extends EnumC0110a {
            g(String str, int i) {
                super(str, i, null);
            }

            @Override // d.n.i.d.a.EnumC0110a
            public int a() {
                return 32;
            }
        }

        static {
            C0111a c0111a = new C0111a("NONCE", 0);
            f2620b = c0111a;
            b bVar = new b("ZERO", 1);
            f2621c = bVar;
            c cVar = new c("BOXZERO", 2);
            f2622d = cVar;
            d dVar = new d("PUBLICKEY", 3);
            e = dVar;
            e eVar = new e("SECRETKEY", 4);
            f = eVar;
            f fVar = new f("KEY", 5);
            g = fVar;
            g gVar = new g("BEFORENM", 6);
            h = gVar;
            i = new EnumC0110a[]{c0111a, bVar, cVar, dVar, eVar, fVar, gVar};
        }

        private EnumC0110a(String str, int i2) {
        }

        /* synthetic */ EnumC0110a(String str, int i2, EnumC0110a enumC0110a) {
            this(str, i2);
        }

        public static EnumC0110a valueOf(String str) {
            return (EnumC0110a) Enum.valueOf(EnumC0110a.class, str);
        }

        public static EnumC0110a[] values() {
            EnumC0110a[] enumC0110aArr = i;
            int length = enumC0110aArr.length;
            EnumC0110a[] enumC0110aArr2 = new EnumC0110a[length];
            System.arraycopy(enumC0110aArr, 0, enumC0110aArr2, 0, length);
            return enumC0110aArr2;
        }

        public abstract int a();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int a(ByteBuffer byteBuffer, ByteBuffer byteBuffer2, int i, ByteBuffer byteBuffer3, byte[] bArr) {
        return b(byteBuffer.array(), byteBuffer2.array(), i, byteBuffer3.array(), bArr);
    }

    int b(byte[] bArr, byte[] bArr2, int i, byte[] bArr3, byte[] bArr4) {
        return curve25519xsalsa20poly1305.crypto_box_afternm(bArr, bArr2, i, bArr3, bArr4);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int c(byte[] bArr, byte[] bArr2, byte[] bArr3) {
        return curve25519xsalsa20poly1305.crypto_box_beforenm(bArr, bArr2, bArr3);
    }

    public int d(ByteBuffer byteBuffer, ByteBuffer byteBuffer2, int i, ByteBuffer byteBuffer3, byte[] bArr, byte[] bArr2) {
        return e(byteBuffer.array(), byteBuffer2.array(), i, byteBuffer3.array(), bArr, bArr2);
    }

    public int e(byte[] bArr, byte[] bArr2, int i, byte[] bArr3, byte[] bArr4, byte[] bArr5) {
        return curve25519xsalsa20poly1305.crypto_box(bArr, bArr2, i, bArr3, bArr4, bArr5);
    }

    public byte[][] f() {
        byte[] bArr = new byte[EnumC0110a.e.a()];
        byte[] bArr2 = new byte[EnumC0110a.f.a()];
        curve25519xsalsa20poly1305.crypto_box_keypair(bArr, bArr2);
        return new byte[][]{bArr, bArr2};
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int g(ByteBuffer byteBuffer, ByteBuffer byteBuffer2, int i, ByteBuffer byteBuffer3, byte[] bArr, byte[] bArr2) {
        return h(byteBuffer.array(), byteBuffer2.array(), i, byteBuffer3.array(), bArr, bArr2);
    }

    int h(byte[] bArr, byte[] bArr2, int i, byte[] bArr3, byte[] bArr4, byte[] bArr5) {
        return curve25519xsalsa20poly1305.crypto_box_open(bArr, bArr2, i, bArr3, bArr4, bArr5);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int i(ByteBuffer byteBuffer, ByteBuffer byteBuffer2, int i, ByteBuffer byteBuffer3, byte[] bArr) {
        return j(byteBuffer.array(), byteBuffer2.array(), i, byteBuffer3.array(), bArr);
    }

    int j(byte[] bArr, byte[] bArr2, int i, byte[] bArr3, byte[] bArr4) {
        return curve25519xsalsa20poly1305.crypto_box_open_afternm(bArr, bArr2, i, bArr3, bArr4);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public byte[] k(int i) {
        return e.b(i);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int l(ByteBuffer byteBuffer, ByteBuffer byteBuffer2, int i, ByteBuffer byteBuffer3, byte[] bArr) {
        return m(byteBuffer.array(), byteBuffer2.array(), i, byteBuffer3.array(), bArr);
    }

    int m(byte[] bArr, byte[] bArr2, int i, byte[] bArr3, byte[] bArr4) {
        return xsalsa20poly1305.crypto_secretbox(bArr, bArr2, i, bArr3, bArr4);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int n(ByteBuffer byteBuffer, ByteBuffer byteBuffer2, int i, ByteBuffer byteBuffer3, byte[] bArr) {
        return o(byteBuffer.array(), byteBuffer2.array(), i, byteBuffer3.array(), bArr);
    }

    int o(byte[] bArr, byte[] bArr2, int i, byte[] bArr3, byte[] bArr4) {
        return xsalsa20poly1305.crypto_secretbox_open(bArr, bArr2, i, bArr3, bArr4);
    }
}
