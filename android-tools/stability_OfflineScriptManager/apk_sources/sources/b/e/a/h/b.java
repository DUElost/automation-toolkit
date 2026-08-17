package b.e.a.h;

import b.c.a.i.f0;
import b.c.a.i.q;
import b.c.a.i.y;
import b.e.a.j.j;
import b.g.b.a.a;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
/* loaded from: classes.dex */
public class b extends e implements b.e.a.h.l.b {
    private List<b.g.b.a.a> p;

    /* loaded from: classes.dex */
    private class a {

        /* renamed from: a  reason: collision with root package name */
        private b.c.a.i.e f1524a;

        /* renamed from: b  reason: collision with root package name */
        private b.g.a.a.b f1525b;

        /* renamed from: c  reason: collision with root package name */
        private b.g.a.a.a f1526c;

        public a(b bVar, b.c.a.i.e eVar) {
            this.f1524a = eVar;
        }

        public b.g.a.a.a c() {
            return this.f1526c;
        }

        public b.g.a.a.b d() {
            return this.f1525b;
        }

        public a e() {
            b.g.a.a.b bVar;
            b.g.a.a.a aVar;
            List q = this.f1524a.q(b.g.a.a.b.class);
            List q2 = this.f1524a.q(b.g.a.a.a.class);
            this.f1525b = null;
            this.f1526c = null;
            for (int i = 0; i < q.size(); i++) {
                if ((this.f1525b != null || ((b.g.a.a.b) q.get(i)).s() != null) && !"cenc".equals(((b.g.a.a.b) q.get(i)).s()) && ((bVar = this.f1525b) == null || bVar.s() != null || !"cenc".equals(((b.g.a.a.b) q.get(i)).s()))) {
                    throw new RuntimeException("Are there two cenc labeled saiz?");
                }
                this.f1525b = (b.g.a.a.b) q.get(i);
                if ((this.f1526c != null || ((b.g.a.a.a) q2.get(i)).s() != null) && !"cenc".equals(((b.g.a.a.a) q2.get(i)).s()) && ((aVar = this.f1526c) == null || aVar.s() != null || !"cenc".equals(((b.g.a.a.a) q2.get(i)).s()))) {
                    throw new RuntimeException("Are there two cenc labeled saio?");
                }
                this.f1526c = (b.g.a.a.a) q2.get(i);
            }
            return this;
        }
    }

    public b(String str, f0 f0Var, b.c.a.d... dVarArr) {
        super(str, f0Var, dVarArr);
        long j;
        int i;
        b.c.a.i.e eVar;
        long j2;
        int i2;
        y yVar = (y) j.a(f0Var, "mdia[0]/minf[0]/stbl[0]/stsd[0]/enc.[0]/sinf[0]/schm[0]");
        this.p = new ArrayList();
        long A = f0Var.I().A();
        if (f0Var.getParent().q(b.c.a.i.i0.a.class).size() <= 0) {
            b.g.b.a.b bVar = (b.g.b.a.b) j.a(f0Var, "mdia[0]/minf[0]/stbl[0]/stsd[0]/enc.[0]/sinf[0]/schi[0]/tenc[0]");
            bVar.u();
            b.c.a.i.c cVar = (b.c.a.i.c) j.a(f0Var, "mdia[0]/minf[0]/stbl[0]/stco[0]");
            long[] s = f0Var.H().K().s((cVar == null ? (b.c.a.i.c) j.a(f0Var, "mdia[0]/minf[0]/stbl[0]/co64[0]") : cVar).s().length);
            a aVar = new a(this, (b.c.a.i.e) j.a(f0Var, "mdia[0]/minf[0]/stbl[0]"));
            aVar.e();
            b.g.a.a.a aVar2 = aVar.f1526c;
            b.g.a.a.b bVar2 = aVar.f1525b;
            b.c.a.i.e parent = ((q) f0Var.getParent()).getParent();
            if (aVar2.u().length == 1) {
                long j3 = aVar2.u()[0];
                if (bVar2.u() > 0) {
                    i = (bVar2.v() * bVar2.u()) + 0;
                } else {
                    i = 0;
                    for (int i3 = 0; i3 < bVar2.v(); i3++) {
                        i += bVar2.w()[i3];
                    }
                }
                ByteBuffer s2 = parent.s(j3, i);
                for (int i4 = 0; i4 < bVar2.v(); i4++) {
                    this.p.add(b(bVar.s(), s2, bVar2.x(i4)));
                }
                return;
            } else if (aVar2.u().length != s.length) {
                throw new RuntimeException("Number of saio offsets must be either 1 or number of chunks");
            } else {
                int i5 = 0;
                for (int i6 = 0; i6 < s.length; i6++) {
                    long j4 = aVar2.u()[i6];
                    if (bVar2.u() > 0) {
                        j = (bVar2.v() * s[i6]) + 0;
                    } else {
                        j = 0;
                        for (int i7 = 0; i7 < s[i6]; i7++) {
                            j += bVar2.x(i5 + i7);
                        }
                    }
                    ByteBuffer s3 = parent.s(j4, j);
                    for (int i8 = 0; i8 < s[i6]; i8++) {
                        this.p.add(b(bVar.s(), s3, bVar2.x(i5 + i8)));
                    }
                    i5 = (int) (i5 + s[i6]);
                }
                return;
            }
        }
        Iterator it = ((b.c.a.i.b) f0Var.getParent()).getParent().q(b.c.a.i.i0.b.class).iterator();
        while (it.hasNext()) {
            b.c.a.i.i0.b bVar3 = (b.c.a.i.i0.b) it.next();
            Iterator it2 = bVar3.q(b.c.a.i.i0.e.class).iterator();
            while (it2.hasNext()) {
                b.c.a.i.i0.e eVar2 = (b.c.a.i.i0.e) it2.next();
                if (eVar2.G().y() == A) {
                    b.g.b.a.b bVar4 = (b.g.b.a.b) j.a(f0Var, "mdia[0]/minf[0]/stbl[0]/stsd[0]/enc.[0]/sinf[0]/schi[0]/tenc[0]");
                    bVar4.u();
                    if (eVar2.G().z()) {
                        eVar = ((b.c.a.i.b) f0Var.getParent()).getParent();
                        j2 = eVar2.G().s();
                    } else {
                        eVar = bVar3;
                        j2 = 0;
                    }
                    a aVar3 = new a(this, eVar2);
                    aVar3.e();
                    b.g.a.a.a c2 = aVar3.c();
                    b.g.a.a.b d2 = aVar3.d();
                    long[] u = c2.u();
                    List q = eVar2.q(b.c.a.i.i0.g.class);
                    long j5 = A;
                    int i9 = 0;
                    int i10 = 0;
                    while (i9 < u.length) {
                        int size = ((b.c.a.i.i0.g) q.get(i9)).u().size();
                        long j6 = u[i9];
                        Iterator it3 = it;
                        long[] jArr = u;
                        List list = q;
                        int i11 = i10;
                        long j7 = 0;
                        while (true) {
                            i2 = i10 + size;
                            if (i11 >= i2) {
                                break;
                            }
                            j7 += d2.x(i11);
                            i11++;
                            bVar3 = bVar3;
                            it2 = it2;
                        }
                        ByteBuffer s4 = eVar.s(j2 + j6, j7);
                        int i12 = i10;
                        while (i12 < i2) {
                            this.p.add(b(bVar4.s(), s4, d2.x(i12)));
                            i12++;
                            i2 = i2;
                            bVar3 = bVar3;
                            it2 = it2;
                        }
                        i9++;
                        u = jArr;
                        i10 = i2;
                        q = list;
                        it = it3;
                    }
                    A = j5;
                }
            }
        }
    }

    private b.g.b.a.a b(int i, ByteBuffer byteBuffer, long j) {
        b.g.b.a.a aVar = new b.g.b.a.a();
        if (j > 0) {
            byte[] bArr = new byte[i];
            aVar.f1633a = bArr;
            byteBuffer.get(bArr);
            if (j > i) {
                aVar.f1634b = new a.j[b.c.a.e.i(byteBuffer)];
                int i2 = 0;
                while (true) {
                    a.j[] jVarArr = aVar.f1634b;
                    if (i2 >= jVarArr.length) {
                        break;
                    }
                    jVarArr[i2] = aVar.a(b.c.a.e.i(byteBuffer), b.c.a.e.k(byteBuffer));
                    i2++;
                }
            }
        }
        return aVar;
    }

    @Override // b.e.a.h.a, b.e.a.h.g
    public String getName() {
        return "enc(" + super.getName() + ")";
    }

    @Override // b.e.a.h.l.b
    public List<b.g.b.a.a> n() {
        return this.p;
    }

    @Override // b.e.a.h.l.b
    public boolean p() {
        return false;
    }

    public String toString() {
        return "CencMp4TrackImpl{handler='" + r() + "'}";
    }
}
