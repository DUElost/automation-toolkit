package b.c.a;

import java.io.EOFException;
import java.nio.ByteBuffer;
import java.util.logging.Logger;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public abstract class a implements b {

    /* renamed from: b  reason: collision with root package name */
    private static Logger f1430b = Logger.getLogger(a.class.getName());

    /* renamed from: a  reason: collision with root package name */
    ThreadLocal<ByteBuffer> f1431a = new C0046a(this);

    /* renamed from: b.c.a.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    class C0046a extends ThreadLocal<ByteBuffer> {
        C0046a(a aVar) {
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // java.lang.ThreadLocal
        /* renamed from: a */
        public ByteBuffer initialValue() {
            return ByteBuffer.allocate(32);
        }
    }

    @Override // b.c.a.b
    public b.c.a.i.b a(b.e.a.e eVar, b.c.a.i.e eVar2) {
        int y;
        long j;
        long j2;
        long l = eVar.l();
        this.f1431a.get().rewind().limit(8);
        do {
            y = eVar.y(this.f1431a.get());
            if (y == 8) {
                this.f1431a.get().rewind();
                long k = e.k(this.f1431a.get());
                long j3 = 8;
                byte[] bArr = null;
                if (k < 8 && k > 1) {
                    Logger logger = f1430b;
                    logger.severe("Plausibility check failed: size < 8 (size = " + k + "). Stop parsing!");
                    return null;
                }
                String b2 = e.b(this.f1431a.get());
                if (k == 1) {
                    this.f1431a.get().limit(16);
                    eVar.y(this.f1431a.get());
                    this.f1431a.get().position(8);
                    j = e.m(this.f1431a.get()) - 16;
                } else {
                    if (k == 0) {
                        k = eVar.size();
                        j3 = eVar.l();
                    }
                    j = k - j3;
                }
                if ("uuid".equals(b2)) {
                    this.f1431a.get().limit(this.f1431a.get().limit() + 16);
                    eVar.y(this.f1431a.get());
                    byte[] bArr2 = new byte[16];
                    for (int position = this.f1431a.get().position() - 16; position < this.f1431a.get().position(); position++) {
                        bArr2[position - (this.f1431a.get().position() - 16)] = this.f1431a.get().get(position);
                    }
                    j2 = j - 16;
                    bArr = bArr2;
                } else {
                    j2 = j;
                }
                b.c.a.i.b b3 = b(b2, bArr, eVar2 instanceof b.c.a.i.b ? ((b.c.a.i.b) eVar2).getType() : BuildConfig.FLAVOR);
                b3.m(eVar2);
                this.f1431a.get().rewind();
                b3.b(eVar, this.f1431a.get(), j2, this);
                return b3;
            }
        } while (y >= 0);
        eVar.u(l);
        throw new EOFException();
    }

    public abstract b.c.a.i.b b(String str, byte[] bArr, String str2);
}
