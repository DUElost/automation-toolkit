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
public class b extends c {
    private static final /* synthetic */ a.InterfaceC0057a A = null;
    private static final /* synthetic */ a.InterfaceC0057a r = null;
    private static final /* synthetic */ a.InterfaceC0057a s = null;
    private static final /* synthetic */ a.InterfaceC0057a t = null;
    private static final /* synthetic */ a.InterfaceC0057a u = null;
    private static final /* synthetic */ a.InterfaceC0057a v = null;
    private static final /* synthetic */ a.InterfaceC0057a w = null;
    private static final /* synthetic */ a.InterfaceC0057a x = null;
    private static final /* synthetic */ a.InterfaceC0057a y = null;
    private static final /* synthetic */ a.InterfaceC0057a z = null;
    private short m;
    private short[] n;
    private int o;
    private String p;
    private String q;

    static {
        k();
    }

    public b() {
        super("saiz");
        this.n = new short[0];
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("SampleAuxiliaryInformationSizesBox.java", b.class);
        r = bVar.f("method-execution", bVar.e("1", "getSize", "com.mp4parser.iso14496.part12.SampleAuxiliaryInformationSizesBox", "int", "index", BuildConfig.FLAVOR, "short"), 57);
        s = bVar.f("method-execution", bVar.e("1", "getAuxInfoType", "com.mp4parser.iso14496.part12.SampleAuxiliaryInformationSizesBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 106);
        z = bVar.f("method-execution", bVar.e("1", "setSampleCount", "com.mp4parser.iso14496.part12.SampleAuxiliaryInformationSizesBox", "int", "sampleCount", BuildConfig.FLAVOR, "void"), 146);
        A = bVar.f("method-execution", bVar.e("1", "toString", "com.mp4parser.iso14496.part12.SampleAuxiliaryInformationSizesBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 151);
        t = bVar.f("method-execution", bVar.e("1", "setAuxInfoType", "com.mp4parser.iso14496.part12.SampleAuxiliaryInformationSizesBox", "java.lang.String", "auxInfoType", BuildConfig.FLAVOR, "void"), 110);
        bVar.f("method-execution", bVar.e("1", "getAuxInfoTypeParameter", "com.mp4parser.iso14496.part12.SampleAuxiliaryInformationSizesBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 114);
        bVar.f("method-execution", bVar.e("1", "setAuxInfoTypeParameter", "com.mp4parser.iso14496.part12.SampleAuxiliaryInformationSizesBox", "java.lang.String", "auxInfoTypeParameter", BuildConfig.FLAVOR, "void"), 118);
        u = bVar.f("method-execution", bVar.e("1", "getDefaultSampleInfoSize", "com.mp4parser.iso14496.part12.SampleAuxiliaryInformationSizesBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "int"), 122);
        v = bVar.f("method-execution", bVar.e("1", "setDefaultSampleInfoSize", "com.mp4parser.iso14496.part12.SampleAuxiliaryInformationSizesBox", "int", "defaultSampleInfoSize", BuildConfig.FLAVOR, "void"), 126);
        w = bVar.f("method-execution", bVar.e("1", "getSampleInfoSizes", "com.mp4parser.iso14496.part12.SampleAuxiliaryInformationSizesBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "[S"), 131);
        x = bVar.f("method-execution", bVar.e("1", "setSampleInfoSizes", "com.mp4parser.iso14496.part12.SampleAuxiliaryInformationSizesBox", "[S", "sampleInfoSizes", BuildConfig.FLAVOR, "void"), 137);
        y = bVar.f("method-execution", bVar.e("1", "getSampleCount", "com.mp4parser.iso14496.part12.SampleAuxiliaryInformationSizesBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "int"), 142);
    }

    public void A(int i) {
        g.b().c(c.b.a.b.b.b.d(z, this, this, c.b.a.b.a.a.d(i)));
        this.o = i;
    }

    public void B(short[] sArr) {
        g.b().c(c.b.a.b.b.b.d(x, this, this, sArr));
        short[] sArr2 = new short[sArr.length];
        this.n = sArr2;
        System.arraycopy(sArr, 0, sArr2, 0, sArr.length);
    }

    @Override // b.e.a.a
    public void c(ByteBuffer byteBuffer) {
        o(byteBuffer);
        if ((l() & 1) == 1) {
            this.p = e.b(byteBuffer);
            this.q = e.b(byteBuffer);
        }
        this.m = (short) e.n(byteBuffer);
        int a2 = b.e.a.j.b.a(e.k(byteBuffer));
        this.o = a2;
        if (this.m == 0) {
            this.n = new short[a2];
            for (int i = 0; i < this.o; i++) {
                this.n[i] = (short) e.n(byteBuffer);
            }
        }
    }

    @Override // b.e.a.a
    protected void d(ByteBuffer byteBuffer) {
        r(byteBuffer);
        if ((l() & 1) == 1) {
            byteBuffer.put(d.F(this.p));
            byteBuffer.put(d.F(this.q));
        }
        f.j(byteBuffer, this.m);
        if (this.m != 0) {
            f.g(byteBuffer, this.o);
            return;
        }
        f.g(byteBuffer, this.n.length);
        for (short s2 : this.n) {
            f.j(byteBuffer, s2);
        }
    }

    @Override // b.e.a.a
    protected long e() {
        return ((l() & 1) == 1 ? 12 : 4) + 5 + (this.m == 0 ? this.n.length : 0);
    }

    public String s() {
        g.b().c(c.b.a.b.b.b.c(s, this, this));
        return this.p;
    }

    public String toString() {
        g.b().c(c.b.a.b.b.b.c(A, this, this));
        return "SampleAuxiliaryInformationSizesBox{defaultSampleInfoSize=" + ((int) this.m) + ", sampleCount=" + this.o + ", auxInfoType='" + this.p + "', auxInfoTypeParameter='" + this.q + "'}";
    }

    public int u() {
        g.b().c(c.b.a.b.b.b.c(u, this, this));
        return this.m;
    }

    public int v() {
        g.b().c(c.b.a.b.b.b.c(y, this, this));
        return this.o;
    }

    public short[] w() {
        g.b().c(c.b.a.b.b.b.c(w, this, this));
        short[] sArr = this.n;
        short[] sArr2 = new short[sArr.length];
        System.arraycopy(sArr, 0, sArr2, 0, sArr.length);
        return sArr2;
    }

    public short x(int i) {
        g.b().c(c.b.a.b.b.b.d(r, this, this, c.b.a.b.a.a.d(i)));
        return u() == 0 ? this.n[i] : this.m;
    }

    public void y(String str) {
        g.b().c(c.b.a.b.b.b.d(t, this, this, str));
        this.p = str;
    }

    public void z(int i) {
        g.b().c(c.b.a.b.b.b.d(v, this, this, c.b.a.b.a.a.d(i)));
        this.m = (short) i;
    }
}
