package b.e.a.j;

import java.nio.ByteBuffer;
/* loaded from: classes.dex */
public class h {
    public static final h j = new h(1.0d, 0.0d, 0.0d, 1.0d, 0.0d, 0.0d, 1.0d, 0.0d, 0.0d);
    public static final h k = new h(0.0d, 1.0d, -1.0d, 0.0d, 0.0d, 0.0d, 1.0d, 0.0d, 0.0d);
    public static final h l = new h(-1.0d, 0.0d, 0.0d, -1.0d, 0.0d, 0.0d, 1.0d, 0.0d, 0.0d);
    public static final h m = new h(0.0d, -1.0d, 1.0d, 0.0d, 0.0d, 0.0d, 1.0d, 0.0d, 0.0d);

    /* renamed from: a  reason: collision with root package name */
    double f1604a;

    /* renamed from: b  reason: collision with root package name */
    double f1605b;

    /* renamed from: c  reason: collision with root package name */
    double f1606c;

    /* renamed from: d  reason: collision with root package name */
    double f1607d;
    double e;
    double f;
    double g;
    double h;
    double i;

    public h(double d2, double d3, double d4, double d5, double d6, double d7, double d8, double d9, double d10) {
        this.f1604a = d6;
        this.f1605b = d7;
        this.f1606c = d8;
        this.f1607d = d2;
        this.e = d3;
        this.f = d4;
        this.g = d5;
        this.h = d9;
        this.i = d10;
    }

    public static h a(ByteBuffer byteBuffer) {
        return b(b.c.a.e.d(byteBuffer), b.c.a.e.d(byteBuffer), b.c.a.e.c(byteBuffer), b.c.a.e.d(byteBuffer), b.c.a.e.d(byteBuffer), b.c.a.e.c(byteBuffer), b.c.a.e.d(byteBuffer), b.c.a.e.d(byteBuffer), b.c.a.e.c(byteBuffer));
    }

    public static h b(double d2, double d3, double d4, double d5, double d6, double d7, double d8, double d9, double d10) {
        return new h(d2, d3, d5, d6, d4, d7, d10, d8, d9);
    }

    public void c(ByteBuffer byteBuffer) {
        b.c.a.f.b(byteBuffer, this.f1607d);
        b.c.a.f.b(byteBuffer, this.e);
        b.c.a.f.a(byteBuffer, this.f1604a);
        b.c.a.f.b(byteBuffer, this.f);
        b.c.a.f.b(byteBuffer, this.g);
        b.c.a.f.a(byteBuffer, this.f1605b);
        b.c.a.f.b(byteBuffer, this.h);
        b.c.a.f.b(byteBuffer, this.i);
        b.c.a.f.a(byteBuffer, this.f1606c);
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null || h.class != obj.getClass()) {
            return false;
        }
        h hVar = (h) obj;
        return Double.compare(hVar.f1607d, this.f1607d) == 0 && Double.compare(hVar.e, this.e) == 0 && Double.compare(hVar.f, this.f) == 0 && Double.compare(hVar.g, this.g) == 0 && Double.compare(hVar.h, this.h) == 0 && Double.compare(hVar.i, this.i) == 0 && Double.compare(hVar.f1604a, this.f1604a) == 0 && Double.compare(hVar.f1605b, this.f1605b) == 0 && Double.compare(hVar.f1606c, this.f1606c) == 0;
    }

    public int hashCode() {
        long doubleToLongBits = Double.doubleToLongBits(this.f1604a);
        long doubleToLongBits2 = Double.doubleToLongBits(this.f1605b);
        long doubleToLongBits3 = Double.doubleToLongBits(this.f1606c);
        long doubleToLongBits4 = Double.doubleToLongBits(this.f1607d);
        long doubleToLongBits5 = Double.doubleToLongBits(this.e);
        long doubleToLongBits6 = Double.doubleToLongBits(this.f);
        long doubleToLongBits7 = Double.doubleToLongBits(this.g);
        long doubleToLongBits8 = Double.doubleToLongBits(this.h);
        long doubleToLongBits9 = Double.doubleToLongBits(this.i);
        return (((((((((((((((((int) (doubleToLongBits ^ (doubleToLongBits >>> 32))) * 31) + ((int) (doubleToLongBits2 ^ (doubleToLongBits2 >>> 32)))) * 31) + ((int) (doubleToLongBits3 ^ (doubleToLongBits3 >>> 32)))) * 31) + ((int) (doubleToLongBits4 ^ (doubleToLongBits4 >>> 32)))) * 31) + ((int) (doubleToLongBits5 ^ (doubleToLongBits5 >>> 32)))) * 31) + ((int) (doubleToLongBits6 ^ (doubleToLongBits6 >>> 32)))) * 31) + ((int) (doubleToLongBits7 ^ (doubleToLongBits7 >>> 32)))) * 31) + ((int) (doubleToLongBits8 ^ (doubleToLongBits8 >>> 32)))) * 31) + ((int) ((doubleToLongBits9 >>> 32) ^ doubleToLongBits9));
    }

    public String toString() {
        if (equals(j)) {
            return "Rotate 0°";
        }
        if (equals(k)) {
            return "Rotate 90°";
        }
        if (equals(l)) {
            return "Rotate 180°";
        }
        if (equals(m)) {
            return "Rotate 270°";
        }
        return "Matrix{u=" + this.f1604a + ", v=" + this.f1605b + ", w=" + this.f1606c + ", a=" + this.f1607d + ", b=" + this.e + ", c=" + this.f + ", d=" + this.g + ", tx=" + this.h + ", ty=" + this.i + '}';
    }
}
