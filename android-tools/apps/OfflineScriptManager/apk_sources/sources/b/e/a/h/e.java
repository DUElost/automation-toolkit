package b.e.a.h;

import b.c.a.i.b0;
import b.c.a.i.d;
import b.c.a.i.f0;
import b.c.a.i.t;
import b.c.a.i.u;
import b.e.a.i.d.d.f;
import java.util.List;
import java.util.Map;
/* loaded from: classes.dex */
public class e extends a {
    f0 e;
    b.c.a.d[] f;
    private List<f> g;
    private u h;
    private long[] i;
    private List<d.a> j;
    private long[] k;
    private List<t.a> l;
    private h m;
    private String n;
    private b0 o;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    /* JADX WARN: Removed duplicated region for block: B:73:0x0299  */
    /* JADX WARN: Removed duplicated region for block: B:83:0x02ec  */
    /* JADX WARN: Removed duplicated region for block: B:84:0x02f1  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public e(java.lang.String r31, b.c.a.i.f0 r32, b.c.a.d... r33) {
        /*
            Method dump skipped, instructions count: 1061
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: b.e.a.h.e.<init>(java.lang.String, b.c.a.i.f0, b.c.a.d[]):void");
    }

    private Map<b.e.a.i.d.d.b, long[]> a(List<b.e.a.i.d.d.e> list, List<b.e.a.i.d.d.e> list2, List<b.e.a.i.d.d.f> list3, Map<b.e.a.i.d.d.b, long[]> map, long j) {
        for (b.e.a.i.d.d.f fVar : list3) {
            int i = 0;
            for (f.a aVar : fVar.s()) {
                if (aVar.a() > 0) {
                    b.e.a.i.d.d.b bVar = null;
                    if (aVar.a() > 65535) {
                        for (b.e.a.i.d.d.e eVar : list2) {
                            if (eVar.u().equals(fVar.u())) {
                                bVar = eVar.s().get((aVar.a() - 1) & 65535);
                            }
                        }
                    } else {
                        for (b.e.a.i.d.d.e eVar2 : list) {
                            if (eVar2.u().equals(fVar.u())) {
                                bVar = eVar2.s().get(aVar.a() - 1);
                            }
                        }
                    }
                    b.e.a.i.d.d.b bVar2 = bVar;
                    long[] jArr = map.get(bVar2);
                    if (jArr == null) {
                        jArr = new long[0];
                    }
                    long[] jArr2 = jArr;
                    long[] jArr3 = new long[b.e.a.j.b.a(aVar.b()) + jArr2.length];
                    System.arraycopy(jArr2, 0, jArr3, 0, jArr2.length);
                    int i2 = 0;
                    while (true) {
                        long j2 = i2;
                        if (j2 >= aVar.b()) {
                            break;
                        }
                        jArr3[jArr2.length + i2] = j + i + j2;
                        i2++;
                    }
                    map.put(bVar2, jArr3);
                }
                i = (int) (i + aVar.b());
            }
        }
        return map;
    }

    @Override // b.e.a.h.g
    public List<t.a> A() {
        return this.l;
    }

    @Override // java.io.Closeable, java.lang.AutoCloseable
    public void close() {
        b.c.a.i.e parent = this.e.getParent();
        if (parent instanceof b.e.a.d) {
            ((b.e.a.d) parent).close();
        }
        b.c.a.d[] dVarArr = this.f;
        if (dVarArr != null) {
            for (b.c.a.d dVar : dVarArr) {
                dVar.close();
            }
        }
    }

    @Override // b.e.a.h.g
    public List<d.a> d() {
        return this.j;
    }

    @Override // b.e.a.h.g
    public long[] f() {
        long[] jArr = this.k;
        if (jArr == null || jArr.length == this.g.size()) {
            return null;
        }
        return this.k;
    }

    @Override // b.e.a.h.g
    public List<f> g() {
        return this.g;
    }

    @Override // b.e.a.h.g
    public b0 i() {
        return this.o;
    }

    @Override // b.e.a.h.g
    public String r() {
        return this.n;
    }

    @Override // b.e.a.h.g
    public synchronized long[] w() {
        return this.i;
    }

    @Override // b.e.a.h.g
    public u x() {
        return this.h;
    }

    @Override // b.e.a.h.g
    public h z() {
        return this.m;
    }
}
