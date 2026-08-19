package b.g.a.a;

import b.c.a.d;
import b.c.a.e;
import b.c.a.f;
import b.e.a.c;
import b.e.a.g;
import c.b.a.a.a;
import java.nio.ByteBuffer;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class a extends c {
    private static final /* synthetic */ a.InterfaceC0057a p = null;
    private static final /* synthetic */ a.InterfaceC0057a q = null;
    private static final /* synthetic */ a.InterfaceC0057a r = null;
    private long[] m;
    private String n;
    private String o;

    static {
        k();
    }

    public a() {
        super("saio");
        this.m = new long[0];
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("SampleAuxiliaryInformationOffsetsBox.java", a.class);
        p = bVar.f("method-execution", bVar.e("1", "getAuxInfoType", "com.mp4parser.iso14496.part12.SampleAuxiliaryInformationOffsetsBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 107);
        bVar.f("method-execution", bVar.e("1", "setAuxInfoType", "com.mp4parser.iso14496.part12.SampleAuxiliaryInformationOffsetsBox", "java.lang.String", "auxInfoType", BuildConfig.FLAVOR, "void"), 111);
        bVar.f("method-execution", bVar.e("1", "getAuxInfoTypeParameter", "com.mp4parser.iso14496.part12.SampleAuxiliaryInformationOffsetsBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 115);
        bVar.f("method-execution", bVar.e("1", "setAuxInfoTypeParameter", "com.mp4parser.iso14496.part12.SampleAuxiliaryInformationOffsetsBox", "java.lang.String", "auxInfoTypeParameter", BuildConfig.FLAVOR, "void"), 119);
        q = bVar.f("method-execution", bVar.e("1", "getOffsets", "com.mp4parser.iso14496.part12.SampleAuxiliaryInformationOffsetsBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "[J"), 123);
        r = bVar.f("method-execution", bVar.e("1", "setOffsets", "com.mp4parser.iso14496.part12.SampleAuxiliaryInformationOffsetsBox", "[J", "offsets", BuildConfig.FLAVOR, "void"), 127);
    }

    @Override // b.e.a.a
    public void c(ByteBuffer byteBuffer) {
        o(byteBuffer);
        if ((l() & 1) == 1) {
            this.n = e.b(byteBuffer);
            this.o = e.b(byteBuffer);
        }
        int a2 = b.e.a.j.b.a(e.k(byteBuffer));
        this.m = new long[a2];
        for (int i = 0; i < a2; i++) {
            if (n() == 0) {
                this.m[i] = e.k(byteBuffer);
            } else {
                this.m[i] = e.m(byteBuffer);
            }
        }
    }

    @Override // b.e.a.a
    protected void d(ByteBuffer byteBuffer) {
        r(byteBuffer);
        if ((l() & 1) == 1) {
            byteBuffer.put(d.F(this.n));
            byteBuffer.put(d.F(this.o));
        }
        f.g(byteBuffer, this.m.length);
        for (long j : this.m) {
            Long valueOf = Long.valueOf(j);
            if (n() == 0) {
                f.g(byteBuffer, valueOf.longValue());
            } else {
                f.i(byteBuffer, valueOf.longValue());
            }
        }
    }

    @Override // b.e.a.a
    protected long e() {
        return (n() == 0 ? this.m.length * 4 : this.m.length * 8) + 8 + ((l() & 1) != 1 ? 0 : 8);
    }

    public String s() {
        g.b().c(c.b.a.b.b.b.c(p, this, this));
        return this.n;
    }

    public long[] u() {
        g.b().c(c.b.a.b.b.b.c(q, this, this));
        return this.m;
    }

    public void v(long[] jArr) {
        g.b().c(c.b.a.b.b.b.d(r, this, this, jArr));
        this.m = jArr;
    }
}
