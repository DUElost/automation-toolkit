package b.c.a.i;

import c.b.a.a.a;
import java.nio.ByteBuffer;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class c0 extends a {
    private static final /* synthetic */ a.InterfaceC0057a m = null;

    static {
        k();
    }

    public c0() {
        super("sthd");
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("SubtitleMediaHeaderBox.java", c0.class);
        m = bVar.f("method-execution", bVar.e("1", "toString", "com.coremedia.iso.boxes.SubtitleMediaHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 30);
    }

    @Override // b.e.a.a
    public void c(ByteBuffer byteBuffer) {
        o(byteBuffer);
    }

    @Override // b.e.a.a
    protected void d(ByteBuffer byteBuffer) {
        r(byteBuffer);
    }

    @Override // b.e.a.a
    protected long e() {
        return 4L;
    }

    public String toString() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(m, this, this));
        return "SubtitleMediaHeaderBox";
    }
}
