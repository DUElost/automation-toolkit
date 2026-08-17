package b.c.a.i;

import c.b.a.a.a;
import java.nio.ByteBuffer;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class f extends b.e.a.c {
    private static final /* synthetic */ a.InterfaceC0057a m = null;

    static {
        k();
    }

    public f() {
        super("url ");
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("DataEntryUrlBox.java", f.class);
        m = bVar.f("method-execution", bVar.e("1", "toString", "com.coremedia.iso.boxes.DataEntryUrlBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 51);
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
        return "DataEntryUrlBox[]";
    }
}
