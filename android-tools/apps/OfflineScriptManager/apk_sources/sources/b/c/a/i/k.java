package b.c.a.i;

import c.b.a.a.a;
import java.nio.ByteBuffer;
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class k extends b.e.a.a {
    private static final /* synthetic */ a.InterfaceC0057a l = null;
    private static final /* synthetic */ a.InterfaceC0057a m = null;
    private String i;
    private long j;
    private List<String> k;

    static {
        k();
    }

    public k() {
        super("ftyp");
        this.k = Collections.emptyList();
    }

    public k(String str, long j, List<String> list) {
        super("ftyp");
        this.k = Collections.emptyList();
        this.i = str;
        this.j = j;
        this.k = list;
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("FileTypeBox.java", k.class);
        l = bVar.f("method-execution", bVar.e("1", "getMajorBrand", "com.coremedia.iso.boxes.FileTypeBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 85);
        bVar.f("method-execution", bVar.e("1", "setMajorBrand", "com.coremedia.iso.boxes.FileTypeBox", "java.lang.String", "majorBrand", BuildConfig.FLAVOR, "void"), 94);
        bVar.f("method-execution", bVar.e("1", "setMinorVersion", "com.coremedia.iso.boxes.FileTypeBox", "long", "minorVersion", BuildConfig.FLAVOR, "void"), 103);
        m = bVar.f("method-execution", bVar.e("1", "getMinorVersion", "com.coremedia.iso.boxes.FileTypeBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "long"), 113);
        bVar.f("method-execution", bVar.e("1", "getCompatibleBrands", "com.coremedia.iso.boxes.FileTypeBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.util.List"), 122);
        bVar.f("method-execution", bVar.e("1", "setCompatibleBrands", "com.coremedia.iso.boxes.FileTypeBox", "java.util.List", "compatibleBrands", BuildConfig.FLAVOR, "void"), 126);
    }

    @Override // b.e.a.a
    public void c(ByteBuffer byteBuffer) {
        this.i = b.c.a.e.b(byteBuffer);
        this.j = b.c.a.e.k(byteBuffer);
        int remaining = byteBuffer.remaining() / 4;
        this.k = new LinkedList();
        for (int i = 0; i < remaining; i++) {
            this.k.add(b.c.a.e.b(byteBuffer));
        }
    }

    @Override // b.e.a.a
    protected void d(ByteBuffer byteBuffer) {
        byteBuffer.put(b.c.a.d.F(this.i));
        b.c.a.f.g(byteBuffer, this.j);
        for (String str : this.k) {
            byteBuffer.put(b.c.a.d.F(str));
        }
    }

    @Override // b.e.a.a
    protected long e() {
        return (this.k.size() * 4) + 8;
    }

    public String l() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(l, this, this));
        return this.i;
    }

    public long n() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(m, this, this));
        return this.j;
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("FileTypeBox[");
        sb.append("majorBrand=");
        sb.append(l());
        sb.append(";");
        sb.append("minorVersion=");
        sb.append(n());
        for (String str : this.k) {
            sb.append(";");
            sb.append("compatibleBrand=");
            sb.append(str);
        }
        sb.append("]");
        return sb.toString();
    }
}
