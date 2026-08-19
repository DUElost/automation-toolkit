package b.c.a.i;

import c.b.a.a.a;
import java.nio.ByteBuffer;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class y extends b.e.a.c {
    private static final /* synthetic */ a.InterfaceC0057a p = null;
    private static final /* synthetic */ a.InterfaceC0057a q = null;
    String m;
    long n;
    String o;

    static {
        k();
    }

    public y() {
        super("schm");
        this.m = "    ";
        this.o = null;
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("SchemeTypeBox.java", y.class);
        p = bVar.f("method-execution", bVar.e("1", "getSchemeType", "com.coremedia.iso.boxes.SchemeTypeBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 44);
        bVar.f("method-execution", bVar.e("1", "getSchemeVersion", "com.coremedia.iso.boxes.SchemeTypeBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "long"), 48);
        bVar.f("method-execution", bVar.e("1", "getSchemeUri", "com.coremedia.iso.boxes.SchemeTypeBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 52);
        bVar.f("method-execution", bVar.e("1", "setSchemeType", "com.coremedia.iso.boxes.SchemeTypeBox", "java.lang.String", "schemeType", BuildConfig.FLAVOR, "void"), 56);
        bVar.f("method-execution", bVar.e("1", "setSchemeVersion", "com.coremedia.iso.boxes.SchemeTypeBox", "int", "schemeVersion", BuildConfig.FLAVOR, "void"), 61);
        bVar.f("method-execution", bVar.e("1", "setSchemeUri", "com.coremedia.iso.boxes.SchemeTypeBox", "java.lang.String", "schemeUri", BuildConfig.FLAVOR, "void"), 65);
        q = bVar.f("method-execution", bVar.e("1", "toString", "com.coremedia.iso.boxes.SchemeTypeBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 93);
    }

    @Override // b.e.a.a
    public void c(ByteBuffer byteBuffer) {
        o(byteBuffer);
        this.m = b.c.a.e.b(byteBuffer);
        this.n = b.c.a.e.k(byteBuffer);
        if ((l() & 1) == 1) {
            this.o = b.c.a.e.g(byteBuffer);
        }
    }

    @Override // b.e.a.a
    protected void d(ByteBuffer byteBuffer) {
        r(byteBuffer);
        byteBuffer.put(b.c.a.d.F(this.m));
        b.c.a.f.g(byteBuffer, this.n);
        if ((l() & 1) == 1) {
            byteBuffer.put(b.c.a.h.b(this.o));
        }
    }

    @Override // b.e.a.a
    protected long e() {
        return ((l() & 1) == 1 ? b.c.a.h.c(this.o) + 1 : 0) + 12;
    }

    public String s() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(p, this, this));
        return this.m;
    }

    public String toString() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(q, this, this));
        return "Schema Type Box[schemeUri=" + this.o + "; schemeType=" + this.m + "; schemeVersion=" + this.n + "; ]";
    }
}
