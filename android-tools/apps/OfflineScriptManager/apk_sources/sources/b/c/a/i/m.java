package b.c.a.i;

import c.b.a.a.a;
import java.nio.ByteBuffer;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class m extends a {
    private static final /* synthetic */ a.InterfaceC0057a q = null;
    private int m;
    private int n;
    private long o;
    private long p;

    static {
        k();
    }

    public m() {
        super("hmhd");
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("HintMediaHeaderBox.java", m.class);
        bVar.f("method-execution", bVar.e("1", "getMaxPduSize", "com.coremedia.iso.boxes.HintMediaHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "int"), 42);
        bVar.f("method-execution", bVar.e("1", "getAvgPduSize", "com.coremedia.iso.boxes.HintMediaHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "int"), 46);
        bVar.f("method-execution", bVar.e("1", "getMaxBitrate", "com.coremedia.iso.boxes.HintMediaHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "long"), 50);
        bVar.f("method-execution", bVar.e("1", "getAvgBitrate", "com.coremedia.iso.boxes.HintMediaHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "long"), 54);
        q = bVar.f("method-execution", bVar.e("1", "toString", "com.coremedia.iso.boxes.HintMediaHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 84);
    }

    @Override // b.e.a.a
    public void c(ByteBuffer byteBuffer) {
        o(byteBuffer);
        this.m = b.c.a.e.i(byteBuffer);
        this.n = b.c.a.e.i(byteBuffer);
        this.o = b.c.a.e.k(byteBuffer);
        this.p = b.c.a.e.k(byteBuffer);
        b.c.a.e.k(byteBuffer);
    }

    @Override // b.e.a.a
    protected void d(ByteBuffer byteBuffer) {
        r(byteBuffer);
        b.c.a.f.e(byteBuffer, this.m);
        b.c.a.f.e(byteBuffer, this.n);
        b.c.a.f.g(byteBuffer, this.o);
        b.c.a.f.g(byteBuffer, this.p);
        b.c.a.f.g(byteBuffer, 0L);
    }

    @Override // b.e.a.a
    protected long e() {
        return 20L;
    }

    public String toString() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(q, this, this));
        return "HintMediaHeaderBox{maxPduSize=" + this.m + ", avgPduSize=" + this.n + ", maxBitrate=" + this.o + ", avgBitrate=" + this.p + '}';
    }
}
