package b.c.a.i;

import c.b.a.a.a;
import java.nio.ByteBuffer;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class d0 extends b.e.a.c {
    private static final /* synthetic */ a.InterfaceC0057a n = null;
    private static final /* synthetic */ a.InterfaceC0057a o = null;
    private static final /* synthetic */ a.InterfaceC0057a p = null;
    private long[] m;

    static {
        k();
    }

    public d0() {
        super("stss");
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("SyncSampleBox.java", d0.class);
        n = bVar.f("method-execution", bVar.e("1", "getSampleNumber", "com.coremedia.iso.boxes.SyncSampleBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "[J"), 46);
        o = bVar.f("method-execution", bVar.e("1", "toString", "com.coremedia.iso.boxes.SyncSampleBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 77);
        p = bVar.f("method-execution", bVar.e("1", "setSampleNumber", "com.coremedia.iso.boxes.SyncSampleBox", "[J", "sampleNumber", BuildConfig.FLAVOR, "void"), 81);
    }

    @Override // b.e.a.a
    public void c(ByteBuffer byteBuffer) {
        o(byteBuffer);
        int a2 = b.e.a.j.b.a(b.c.a.e.k(byteBuffer));
        this.m = new long[a2];
        for (int i = 0; i < a2; i++) {
            this.m[i] = b.c.a.e.k(byteBuffer);
        }
    }

    @Override // b.e.a.a
    protected void d(ByteBuffer byteBuffer) {
        r(byteBuffer);
        b.c.a.f.g(byteBuffer, this.m.length);
        for (long j : this.m) {
            b.c.a.f.g(byteBuffer, j);
        }
    }

    @Override // b.e.a.a
    protected long e() {
        return (this.m.length * 4) + 8;
    }

    public long[] s() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(n, this, this));
        return this.m;
    }

    public String toString() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(o, this, this));
        return "SyncSampleBox[entryCount=" + this.m.length + "]";
    }

    public void u(long[] jArr) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(p, this, this, jArr));
        this.m = jArr;
    }
}
