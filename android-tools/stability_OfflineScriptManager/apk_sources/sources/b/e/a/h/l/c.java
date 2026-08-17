package b.e.a.h.l;

import b.c.a.i.b0;
import b.c.a.i.d;
import b.c.a.i.t;
import b.c.a.i.u;
import b.e.a.h.f;
import b.e.a.h.g;
import b.e.a.h.h;
import java.util.ArrayList;
import java.util.List;
import java.util.ListIterator;
/* loaded from: classes.dex */
public class c extends b.e.a.h.a {
    g e;
    private int f;
    private int g;

    public c(g gVar, long j, long j2) {
        super("crop(" + gVar.getName() + ")");
        this.e = gVar;
        this.f = (int) j;
        this.g = (int) j2;
    }

    static List<d.a> a(List<d.a> list, long j, long j2) {
        d.a next;
        d.a aVar;
        if (list == null || list.isEmpty()) {
            return null;
        }
        long j3 = 0;
        ListIterator<d.a> listIterator = list.listIterator();
        ArrayList arrayList = new ArrayList();
        while (true) {
            next = listIterator.next();
            if (next.a() + j3 > j) {
                break;
            }
            j3 += next.a();
        }
        if (next.a() + j3 >= j2) {
            aVar = new d.a((int) (j2 - j), next.b());
        } else {
            arrayList.add(new d.a((int) ((next.a() + j3) - j), next.b()));
            while (true) {
                j3 += next.a();
                if (!listIterator.hasNext()) {
                    break;
                }
                next = listIterator.next();
                if (next.a() + j3 >= j2) {
                    break;
                }
                arrayList.add(next);
            }
            aVar = new d.a((int) (j2 - j3), next.b());
        }
        arrayList.add(aVar);
        return arrayList;
    }

    @Override // b.e.a.h.g
    public List<t.a> A() {
        if (this.e.A() == null || this.e.A().isEmpty()) {
            return null;
        }
        return this.e.A().subList(this.f, this.g);
    }

    @Override // java.io.Closeable, java.lang.AutoCloseable
    public void close() {
        this.e.close();
    }

    @Override // b.e.a.h.g
    public List<d.a> d() {
        return a(this.e.d(), this.f, this.g);
    }

    @Override // b.e.a.h.g
    public synchronized long[] f() {
        if (this.e.f() != null) {
            long[] f = this.e.f();
            int length = f.length;
            int i = 0;
            while (i < f.length && f[i] < this.f) {
                i++;
            }
            while (length > 0 && this.g < f[length - 1]) {
                length--;
            }
            int i2 = length - i;
            long[] jArr = new long[i2];
            System.arraycopy(this.e.f(), i, jArr, 0, i2);
            for (int i3 = 0; i3 < i2; i3++) {
                jArr[i3] = jArr[i3] - this.f;
            }
            return jArr;
        }
        return null;
    }

    @Override // b.e.a.h.g
    public List<f> g() {
        return this.e.g().subList(this.f, this.g);
    }

    @Override // b.e.a.h.g
    public b0 i() {
        return this.e.i();
    }

    @Override // b.e.a.h.g
    public String r() {
        return this.e.r();
    }

    @Override // b.e.a.h.g
    public synchronized long[] w() {
        long[] jArr;
        int i = this.g - this.f;
        jArr = new long[i];
        System.arraycopy(this.e.w(), this.f, jArr, 0, i);
        return jArr;
    }

    @Override // b.e.a.h.g
    public u x() {
        return this.e.x();
    }

    @Override // b.e.a.h.g
    public h z() {
        return this.e.z();
    }
}
