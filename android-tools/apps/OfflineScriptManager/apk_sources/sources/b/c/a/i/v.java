package b.c.a.i;

import c.b.a.a.a;
import java.nio.ByteBuffer;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class v extends b.e.a.c {
    private static final /* synthetic */ a.InterfaceC0057a p = null;
    private static final /* synthetic */ a.InterfaceC0057a q = null;
    private static final /* synthetic */ a.InterfaceC0057a r = null;
    private static final /* synthetic */ a.InterfaceC0057a s = null;
    private static final /* synthetic */ a.InterfaceC0057a t = null;
    private static final /* synthetic */ a.InterfaceC0057a u = null;
    private long m;
    private long[] n;
    int o;

    static {
        k();
    }

    public v() {
        super("stsz");
        this.n = new long[0];
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("SampleSizeBox.java", v.class);
        p = bVar.f("method-execution", bVar.e("1", "getSampleSize", "com.coremedia.iso.boxes.SampleSizeBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "long"), 50);
        bVar.f("method-execution", bVar.e("1", "setSampleSize", "com.coremedia.iso.boxes.SampleSizeBox", "long", "sampleSize", BuildConfig.FLAVOR, "void"), 54);
        q = bVar.f("method-execution", bVar.e("1", "getSampleSizeAtIndex", "com.coremedia.iso.boxes.SampleSizeBox", "int", "index", BuildConfig.FLAVOR, "long"), 59);
        r = bVar.f("method-execution", bVar.e("1", "getSampleCount", "com.coremedia.iso.boxes.SampleSizeBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "long"), 67);
        s = bVar.f("method-execution", bVar.e("1", "getSampleSizes", "com.coremedia.iso.boxes.SampleSizeBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "[J"), 76);
        t = bVar.f("method-execution", bVar.e("1", "setSampleSizes", "com.coremedia.iso.boxes.SampleSizeBox", "[J", "sampleSizes", BuildConfig.FLAVOR, "void"), 80);
        u = bVar.f("method-execution", bVar.e("1", "toString", "com.coremedia.iso.boxes.SampleSizeBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 119);
    }

    @Override // b.e.a.a
    public void c(ByteBuffer byteBuffer) {
        o(byteBuffer);
        this.m = b.c.a.e.k(byteBuffer);
        int a2 = b.e.a.j.b.a(b.c.a.e.k(byteBuffer));
        this.o = a2;
        if (this.m == 0) {
            this.n = new long[a2];
            for (int i = 0; i < this.o; i++) {
                this.n[i] = b.c.a.e.k(byteBuffer);
            }
        }
    }

    @Override // b.e.a.a
    protected void d(ByteBuffer byteBuffer) {
        r(byteBuffer);
        b.c.a.f.g(byteBuffer, this.m);
        if (this.m != 0) {
            b.c.a.f.g(byteBuffer, this.o);
            return;
        }
        b.c.a.f.g(byteBuffer, this.n.length);
        for (long j : this.n) {
            b.c.a.f.g(byteBuffer, j);
        }
    }

    @Override // b.e.a.a
    protected long e() {
        return (this.m == 0 ? this.n.length * 4 : 0) + 12;
    }

    public long s() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(r, this, this));
        return this.m > 0 ? this.o : this.n.length;
    }

    public String toString() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(u, this, this));
        return "SampleSizeBox[sampleSize=" + u() + ";sampleCount=" + s() + "]";
    }

    public long u() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(p, this, this));
        return this.m;
    }

    public long v(int i) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(q, this, this, c.b.a.b.a.a.d(i)));
        long j = this.m;
        return j > 0 ? j : this.n[i];
    }

    public long[] w() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(s, this, this));
        return this.n;
    }

    public void x(long[] jArr) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(t, this, this, jArr));
        this.n = jArr;
    }
}
