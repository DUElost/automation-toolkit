package b.e.a.i.d.c;

import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
@g(tags = {3})
/* loaded from: classes.dex */
public class h extends b {

    /* renamed from: d  reason: collision with root package name */
    int f1571d;
    int e;
    int f;
    int g;
    int h;
    String j;
    int k;
    int l;
    int m;
    e n;
    n o;
    int i = 0;
    List<b> p = new ArrayList();

    static {
        Logger.getLogger(h.class.getName());
    }

    public h() {
        this.f1560a = 3;
    }

    @Override // b.e.a.i.d.c.b
    int a() {
        int i = this.e > 0 ? 5 : 3;
        if (this.f > 0) {
            i += this.i + 1;
        }
        if (this.g > 0) {
            i += 2;
        }
        int b2 = i + this.n.b() + this.o.b();
        if (this.p.size() <= 0) {
            return b2;
        }
        throw new RuntimeException(" Doesn't handle other descriptors yet");
    }

    @Override // b.e.a.i.d.c.b
    public void e(ByteBuffer byteBuffer) {
        this.f1571d = b.c.a.e.i(byteBuffer);
        int n = b.c.a.e.n(byteBuffer);
        int i = n >>> 7;
        this.e = i;
        this.f = (n >>> 6) & 1;
        this.g = (n >>> 5) & 1;
        this.h = n & 31;
        if (i == 1) {
            this.l = b.c.a.e.i(byteBuffer);
        }
        if (this.f == 1) {
            int n2 = b.c.a.e.n(byteBuffer);
            this.i = n2;
            this.j = b.c.a.e.h(byteBuffer, n2);
        }
        if (this.g == 1) {
            this.m = b.c.a.e.i(byteBuffer);
        }
        while (byteBuffer.remaining() > 1) {
            b a2 = l.a(-1, byteBuffer);
            if (a2 instanceof e) {
                this.n = (e) a2;
            } else if (a2 instanceof n) {
                this.o = (n) a2;
            } else {
                this.p.add(a2);
            }
        }
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null || h.class != obj.getClass()) {
            return false;
        }
        h hVar = (h) obj;
        if (this.f == hVar.f && this.i == hVar.i && this.l == hVar.l && this.f1571d == hVar.f1571d && this.m == hVar.m && this.g == hVar.g && this.k == hVar.k && this.e == hVar.e && this.h == hVar.h) {
            String str = this.j;
            if (str == null ? hVar.j == null : str.equals(hVar.j)) {
                e eVar = this.n;
                if (eVar == null ? hVar.n == null : eVar.equals(hVar.n)) {
                    List<b> list = this.p;
                    if (list == null ? hVar.p == null : list.equals(hVar.p)) {
                        n nVar = this.o;
                        n nVar2 = hVar.o;
                        return nVar == null ? nVar2 == null : nVar.equals(nVar2);
                    }
                    return false;
                }
                return false;
            }
            return false;
        }
        return false;
    }

    public e g() {
        return this.n;
    }

    public int h() {
        return this.l;
    }

    public int hashCode() {
        int i = ((((((((((this.f1571d * 31) + this.e) * 31) + this.f) * 31) + this.g) * 31) + this.h) * 31) + this.i) * 31;
        String str = this.j;
        int hashCode = (((((((i + (str != null ? str.hashCode() : 0)) * 31) + this.k) * 31) + this.l) * 31) + this.m) * 31;
        e eVar = this.n;
        int hashCode2 = (hashCode + (eVar != null ? eVar.hashCode() : 0)) * 31;
        n nVar = this.o;
        int hashCode3 = (hashCode2 + (nVar != null ? nVar.hashCode() : 0)) * 31;
        List<b> list = this.p;
        return hashCode3 + (list != null ? list.hashCode() : 0);
    }

    public int i() {
        return this.f1571d;
    }

    public List<b> j() {
        return this.p;
    }

    public int k() {
        return this.k;
    }

    public n l() {
        return this.o;
    }

    public int m() {
        return this.e;
    }

    public int n() {
        return this.h;
    }

    public int o() {
        return this.f;
    }

    public int p() {
        return this.i;
    }

    public String q() {
        return this.j;
    }

    public int r() {
        return this.m;
    }

    public int s() {
        return this.g;
    }

    public ByteBuffer t() {
        ByteBuffer wrap = ByteBuffer.wrap(new byte[b()]);
        b.c.a.f.j(wrap, 3);
        f(wrap, a());
        b.c.a.f.e(wrap, this.f1571d);
        b.c.a.f.j(wrap, (this.e << 7) | (this.f << 6) | (this.g << 5) | (this.h & 31));
        if (this.e > 0) {
            b.c.a.f.e(wrap, this.l);
        }
        if (this.f > 0) {
            b.c.a.f.j(wrap, this.i);
            b.c.a.f.k(wrap, this.j);
        }
        if (this.g > 0) {
            b.c.a.f.e(wrap, this.m);
        }
        ByteBuffer p = this.n.p();
        ByteBuffer g = this.o.g();
        wrap.put(p.array());
        wrap.put(g.array());
        return wrap;
    }

    @Override // b.e.a.i.d.c.b
    public String toString() {
        return "ESDescriptor{esId=" + this.f1571d + ", streamDependenceFlag=" + this.e + ", URLFlag=" + this.f + ", oCRstreamFlag=" + this.g + ", streamPriority=" + this.h + ", URLLength=" + this.i + ", URLString='" + this.j + "', remoteODFlag=" + this.k + ", dependsOnEsId=" + this.l + ", oCREsId=" + this.m + ", decoderConfigDescriptor=" + this.n + ", slConfigDescriptor=" + this.o + '}';
    }
}
