package b.g.a.b;

import b.c.a.e;
import b.c.a.f;
import java.nio.ByteBuffer;
/* loaded from: classes.dex */
public class c extends b.e.a.i.d.d.b {

    /* renamed from: a  reason: collision with root package name */
    int f1629a;

    /* renamed from: b  reason: collision with root package name */
    int f1630b;

    /* renamed from: c  reason: collision with root package name */
    boolean f1631c;

    /* renamed from: d  reason: collision with root package name */
    int f1632d;
    long e;
    long f;
    int g;
    int h;
    int i;
    int j;
    int k;

    @Override // b.e.a.i.d.d.b
    public ByteBuffer a() {
        ByteBuffer allocate = ByteBuffer.allocate(20);
        f.j(allocate, this.f1629a);
        f.j(allocate, (this.f1630b << 6) + (this.f1631c ? 32 : 0) + this.f1632d);
        f.g(allocate, this.e);
        f.h(allocate, this.f);
        f.j(allocate, this.g);
        f.e(allocate, this.h);
        f.e(allocate, this.i);
        f.j(allocate, this.j);
        f.e(allocate, this.k);
        return (ByteBuffer) allocate.rewind();
    }

    @Override // b.e.a.i.d.d.b
    public String b() {
        return "tscl";
    }

    @Override // b.e.a.i.d.d.b
    public void c(ByteBuffer byteBuffer) {
        this.f1629a = e.n(byteBuffer);
        int n = e.n(byteBuffer);
        this.f1630b = (n & 192) >> 6;
        this.f1631c = (n & 32) > 0;
        this.f1632d = n & 31;
        this.e = e.k(byteBuffer);
        this.f = e.l(byteBuffer);
        this.g = e.n(byteBuffer);
        this.h = e.i(byteBuffer);
        this.i = e.i(byteBuffer);
        this.j = e.n(byteBuffer);
        this.k = e.i(byteBuffer);
    }

    @Override // b.e.a.i.d.d.b
    public int d() {
        return 20;
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null || c.class != obj.getClass()) {
            return false;
        }
        c cVar = (c) obj;
        return this.f1629a == cVar.f1629a && this.i == cVar.i && this.k == cVar.k && this.j == cVar.j && this.h == cVar.h && this.f == cVar.f && this.g == cVar.g && this.e == cVar.e && this.f1632d == cVar.f1632d && this.f1630b == cVar.f1630b && this.f1631c == cVar.f1631c;
    }

    public int hashCode() {
        long j = this.e;
        long j2 = this.f;
        return (((((((((((((((((((this.f1629a * 31) + this.f1630b) * 31) + (this.f1631c ? 1 : 0)) * 31) + this.f1632d) * 31) + ((int) (j ^ (j >>> 32)))) * 31) + ((int) (j2 ^ (j2 >>> 32)))) * 31) + this.g) * 31) + this.h) * 31) + this.i) * 31) + this.j) * 31) + this.k;
    }

    public String toString() {
        return "TemporalLayerSampleGroup{temporalLayerId=" + this.f1629a + ", tlprofile_space=" + this.f1630b + ", tltier_flag=" + this.f1631c + ", tlprofile_idc=" + this.f1632d + ", tlprofile_compatibility_flags=" + this.e + ", tlconstraint_indicator_flags=" + this.f + ", tllevel_idc=" + this.g + ", tlMaxBitRate=" + this.h + ", tlAvgBitRate=" + this.i + ", tlConstantFrameRate=" + this.j + ", tlAvgFrameRate=" + this.k + '}';
    }
}
