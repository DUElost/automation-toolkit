package b.e.a.i;

import b.c.a.e;
import b.c.a.f;
import b.e.a.c;
import b.e.a.g;
import c.b.a.a.a;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.util.Arrays;
import java.util.UUID;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public abstract class b extends c {
    private static final /* synthetic */ a.InterfaceC0057a p = null;
    private static final /* synthetic */ a.InterfaceC0057a q = null;
    private static final /* synthetic */ a.InterfaceC0057a r = null;
    private static final /* synthetic */ a.InterfaceC0057a s = null;
    int m;
    int n;
    byte[] o;

    static {
        k();
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public b(String str) {
        super(str);
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("AbstractTrackEncryptionBox.java", b.class);
        bVar.f("method-execution", bVar.e("1", "getDefaultAlgorithmId", "com.googlecode.mp4parser.boxes.AbstractTrackEncryptionBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "int"), 24);
        bVar.f("method-execution", bVar.e("1", "setDefaultAlgorithmId", "com.googlecode.mp4parser.boxes.AbstractTrackEncryptionBox", "int", "defaultAlgorithmId", BuildConfig.FLAVOR, "void"), 28);
        p = bVar.f("method-execution", bVar.e("1", "getDefaultIvSize", "com.googlecode.mp4parser.boxes.AbstractTrackEncryptionBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "int"), 32);
        bVar.f("method-execution", bVar.e("1", "setDefaultIvSize", "com.googlecode.mp4parser.boxes.AbstractTrackEncryptionBox", "int", "defaultIvSize", BuildConfig.FLAVOR, "void"), 36);
        q = bVar.f("method-execution", bVar.e("1", "getDefault_KID", "com.googlecode.mp4parser.boxes.AbstractTrackEncryptionBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.util.UUID"), 40);
        bVar.f("method-execution", bVar.e("1", "setDefault_KID", "com.googlecode.mp4parser.boxes.AbstractTrackEncryptionBox", "java.util.UUID", "uuid", BuildConfig.FLAVOR, "void"), 46);
        r = bVar.f("method-execution", bVar.e("1", "equals", "com.googlecode.mp4parser.boxes.AbstractTrackEncryptionBox", "java.lang.Object", "o", BuildConfig.FLAVOR, "boolean"), 76);
        s = bVar.f("method-execution", bVar.e("1", "hashCode", "com.googlecode.mp4parser.boxes.AbstractTrackEncryptionBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "int"), 90);
    }

    @Override // b.e.a.a
    public void c(ByteBuffer byteBuffer) {
        o(byteBuffer);
        this.m = e.j(byteBuffer);
        this.n = e.n(byteBuffer);
        byte[] bArr = new byte[16];
        this.o = bArr;
        byteBuffer.get(bArr);
    }

    @Override // b.e.a.a
    protected void d(ByteBuffer byteBuffer) {
        r(byteBuffer);
        f.f(byteBuffer, this.m);
        f.j(byteBuffer, this.n);
        byteBuffer.put(this.o);
    }

    @Override // b.e.a.a
    protected long e() {
        return 24L;
    }

    public boolean equals(Object obj) {
        g.b().c(c.b.a.b.b.b.d(r, this, this, obj));
        if (this == obj) {
            return true;
        }
        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }
        b bVar = (b) obj;
        return this.m == bVar.m && this.n == bVar.n && Arrays.equals(this.o, bVar.o);
    }

    public int hashCode() {
        g.b().c(c.b.a.b.b.b.c(s, this, this));
        int i = ((this.m * 31) + this.n) * 31;
        byte[] bArr = this.o;
        return i + (bArr != null ? Arrays.hashCode(bArr) : 0);
    }

    public int s() {
        g.b().c(c.b.a.b.b.b.c(p, this, this));
        return this.n;
    }

    public UUID u() {
        g.b().c(c.b.a.b.b.b.c(q, this, this));
        ByteBuffer wrap = ByteBuffer.wrap(this.o);
        wrap.order(ByteOrder.BIG_ENDIAN);
        return new UUID(wrap.getLong(), wrap.getLong());
    }
}
