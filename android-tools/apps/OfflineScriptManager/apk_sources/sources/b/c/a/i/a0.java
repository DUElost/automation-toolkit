package b.c.a.i;

import c.b.a.a.a;
import java.nio.ByteBuffer;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class a0 extends c {
    private static final /* synthetic */ a.InterfaceC0057a o = null;
    private static final /* synthetic */ a.InterfaceC0057a p = null;
    private long[] n;

    static {
        k();
    }

    public a0() {
        super("stco");
        this.n = new long[0];
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("StaticChunkOffsetBox.java", a0.class);
        o = bVar.f("method-execution", bVar.e("1", "getChunkOffsets", "com.coremedia.iso.boxes.StaticChunkOffsetBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "[J"), 39);
        p = bVar.f("method-execution", bVar.e("1", "setChunkOffsets", "com.coremedia.iso.boxes.StaticChunkOffsetBox", "[J", "chunkOffsets", BuildConfig.FLAVOR, "void"), 48);
    }

    @Override // b.e.a.a
    public void c(ByteBuffer byteBuffer) {
        o(byteBuffer);
        int a2 = b.e.a.j.b.a(b.c.a.e.k(byteBuffer));
        this.n = new long[a2];
        for (int i = 0; i < a2; i++) {
            this.n[i] = b.c.a.e.k(byteBuffer);
        }
    }

    @Override // b.e.a.a
    protected void d(ByteBuffer byteBuffer) {
        r(byteBuffer);
        b.c.a.f.g(byteBuffer, this.n.length);
        for (long j : this.n) {
            b.c.a.f.g(byteBuffer, j);
        }
    }

    @Override // b.e.a.a
    protected long e() {
        return (this.n.length * 4) + 8;
    }

    @Override // b.c.a.i.c
    public long[] s() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(o, this, this));
        return this.n;
    }

    @Override // b.c.a.i.c
    public void u(long[] jArr) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(p, this, this, jArr));
        this.n = jArr;
    }
}
