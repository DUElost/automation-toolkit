package b.c.a.i.i0;

import java.nio.ByteBuffer;
/* loaded from: classes.dex */
public class c {

    /* renamed from: a  reason: collision with root package name */
    private byte f1445a;

    /* renamed from: b  reason: collision with root package name */
    private byte f1446b;

    /* renamed from: c  reason: collision with root package name */
    private byte f1447c;

    /* renamed from: d  reason: collision with root package name */
    private byte f1448d;
    private byte e;
    private byte f;
    private boolean g;
    private int h;

    public c() {
    }

    public c(ByteBuffer byteBuffer) {
        long k = b.c.a.e.k(byteBuffer);
        this.f1445a = (byte) (((-268435456) & k) >> 28);
        this.f1446b = (byte) ((201326592 & k) >> 26);
        this.f1447c = (byte) ((50331648 & k) >> 24);
        this.f1448d = (byte) ((12582912 & k) >> 22);
        this.e = (byte) ((3145728 & k) >> 20);
        this.f = (byte) ((917504 & k) >> 17);
        this.g = ((65536 & k) >> 16) > 0;
        this.h = (int) (k & 65535);
    }

    public void a(ByteBuffer byteBuffer) {
        b.c.a.f.g(byteBuffer, (this.f1445a << 28) | 0 | (this.f1446b << 26) | (this.f1447c << 24) | (this.f1448d << 22) | (this.e << 20) | (this.f << 17) | ((this.g ? 1 : 0) << 16) | this.h);
    }

    public boolean b() {
        return this.g;
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null || c.class != obj.getClass()) {
            return false;
        }
        c cVar = (c) obj;
        return this.f1446b == cVar.f1446b && this.f1445a == cVar.f1445a && this.h == cVar.h && this.f1447c == cVar.f1447c && this.e == cVar.e && this.f1448d == cVar.f1448d && this.g == cVar.g && this.f == cVar.f;
    }

    public int hashCode() {
        return (((((((((((((this.f1445a * 31) + this.f1446b) * 31) + this.f1447c) * 31) + this.f1448d) * 31) + this.e) * 31) + this.f) * 31) + (this.g ? 1 : 0)) * 31) + this.h;
    }

    public String toString() {
        return "SampleFlags{reserved=" + ((int) this.f1445a) + ", isLeading=" + ((int) this.f1446b) + ", depOn=" + ((int) this.f1447c) + ", isDepOn=" + ((int) this.f1448d) + ", hasRedundancy=" + ((int) this.e) + ", padValue=" + ((int) this.f) + ", isDiffSample=" + this.g + ", degradPrio=" + this.h + '}';
    }
}
