package b.c.a.i;

import c.b.a.a.a;
import java.nio.ByteBuffer;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class z extends a {
    private static final /* synthetic */ a.InterfaceC0057a n = null;
    private static final /* synthetic */ a.InterfaceC0057a o = null;
    private float m;

    static {
        k();
    }

    public z() {
        super("smhd");
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("SoundMediaHeaderBox.java", z.class);
        n = bVar.f("method-execution", bVar.e("1", "getBalance", "com.coremedia.iso.boxes.SoundMediaHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "float"), 36);
        o = bVar.f("method-execution", bVar.e("1", "toString", "com.coremedia.iso.boxes.SoundMediaHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 58);
    }

    @Override // b.e.a.a
    public void c(ByteBuffer byteBuffer) {
        o(byteBuffer);
        this.m = b.c.a.e.e(byteBuffer);
        b.c.a.e.i(byteBuffer);
    }

    @Override // b.e.a.a
    protected void d(ByteBuffer byteBuffer) {
        r(byteBuffer);
        b.c.a.f.c(byteBuffer, this.m);
        b.c.a.f.e(byteBuffer, 0);
    }

    @Override // b.e.a.a
    protected long e() {
        return 8L;
    }

    public float s() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(n, this, this));
        return this.m;
    }

    public String toString() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(o, this, this));
        return "SoundMediaHeaderBox[balance=" + s() + "]";
    }
}
