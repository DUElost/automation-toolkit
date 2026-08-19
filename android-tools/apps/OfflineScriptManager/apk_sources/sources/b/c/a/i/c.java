package b.c.a.i;

import c.b.a.a.a;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public abstract class c extends b.e.a.c {
    private static final /* synthetic */ a.InterfaceC0057a m = null;

    static {
        k();
    }

    public c(String str) {
        super(str);
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("ChunkOffsetBox.java", c.class);
        m = bVar.f("method-execution", bVar.e("1", "toString", "com.coremedia.iso.boxes.ChunkOffsetBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 18);
    }

    public abstract long[] s();

    public String toString() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(m, this, this));
        return String.valueOf(getClass().getSimpleName()) + "[entryCount=" + s().length + "]";
    }

    public abstract void u(long[] jArr);
}
