package b.c.a.i;

import c.b.a.a.a;
import java.nio.ByteBuffer;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class h0 extends a {
    private static final /* synthetic */ a.InterfaceC0057a o = null;
    private static final /* synthetic */ a.InterfaceC0057a p = null;
    private static final /* synthetic */ a.InterfaceC0057a q = null;
    private int m;
    private int[] n;

    static {
        k();
    }

    public h0() {
        super("vmhd");
        this.m = 0;
        this.n = new int[3];
        p(1);
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("VideoMediaHeaderBox.java", h0.class);
        o = bVar.f("method-execution", bVar.e("1", "getGraphicsmode", "com.coremedia.iso.boxes.VideoMediaHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "int"), 39);
        p = bVar.f("method-execution", bVar.e("1", "getOpcolor", "com.coremedia.iso.boxes.VideoMediaHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "[I"), 43);
        q = bVar.f("method-execution", bVar.e("1", "toString", "com.coremedia.iso.boxes.VideoMediaHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 71);
        bVar.f("method-execution", bVar.e("1", "setOpcolor", "com.coremedia.iso.boxes.VideoMediaHeaderBox", "[I", "opcolor", BuildConfig.FLAVOR, "void"), 75);
        bVar.f("method-execution", bVar.e("1", "setGraphicsmode", "com.coremedia.iso.boxes.VideoMediaHeaderBox", "int", "graphicsmode", BuildConfig.FLAVOR, "void"), 79);
    }

    @Override // b.e.a.a
    public void c(ByteBuffer byteBuffer) {
        o(byteBuffer);
        this.m = b.c.a.e.i(byteBuffer);
        this.n = new int[3];
        for (int i = 0; i < 3; i++) {
            this.n[i] = b.c.a.e.i(byteBuffer);
        }
    }

    @Override // b.e.a.a
    protected void d(ByteBuffer byteBuffer) {
        r(byteBuffer);
        b.c.a.f.e(byteBuffer, this.m);
        for (int i : this.n) {
            b.c.a.f.e(byteBuffer, i);
        }
    }

    @Override // b.e.a.a
    protected long e() {
        return 12L;
    }

    public int s() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(o, this, this));
        return this.m;
    }

    public String toString() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(q, this, this));
        return "VideoMediaHeaderBox[graphicsmode=" + s() + ";opcolor0=" + u()[0] + ";opcolor1=" + u()[1] + ";opcolor2=" + u()[2] + "]";
    }

    public int[] u() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(p, this, this));
        return this.n;
    }
}
