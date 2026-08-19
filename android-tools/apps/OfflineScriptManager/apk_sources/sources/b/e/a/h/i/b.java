package b.e.a.h.i;

import b.c.a.i.a0;
import b.c.a.i.c0;
import b.c.a.i.d;
import b.c.a.i.d0;
import b.c.a.i.e;
import b.c.a.i.e0;
import b.c.a.i.f0;
import b.c.a.i.g0;
import b.c.a.i.h;
import b.c.a.i.h0;
import b.c.a.i.i;
import b.c.a.i.j;
import b.c.a.i.k;
import b.c.a.i.l;
import b.c.a.i.m;
import b.c.a.i.n;
import b.c.a.i.o;
import b.c.a.i.p;
import b.c.a.i.q;
import b.c.a.i.r;
import b.c.a.i.s;
import b.c.a.i.t;
import b.c.a.i.v;
import b.c.a.i.w;
import b.c.a.i.x;
import b.c.a.i.z;
import b.e.a.h.d;
import b.e.a.h.g;
import b.e.a.i.d.d.f;
import b.e.a.j.f;
import b.e.a.j.j;
import java.nio.ByteBuffer;
import java.nio.channels.WritableByteChannel;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
/* loaded from: classes.dex */
public class b {
    private static f f = f.a(b.class);

    /* renamed from: a  reason: collision with root package name */
    Map<g, a0> f1537a = new HashMap();

    /* renamed from: b  reason: collision with root package name */
    Set<b.g.a.a.a> f1538b = new HashSet();

    /* renamed from: c  reason: collision with root package name */
    HashMap<g, List<b.e.a.h.f>> f1539c = new HashMap<>();

    /* renamed from: d  reason: collision with root package name */
    HashMap<g, long[]> f1540d = new HashMap<>();
    private c e;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a implements Comparator<g> {
        a(b bVar) {
        }

        @Override // java.util.Comparator
        /* renamed from: a */
        public int compare(g gVar, g gVar2) {
            return b.e.a.j.b.a(gVar.z().h() - gVar2.z().h());
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* renamed from: b.e.a.h.i.b$b  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public class C0050b implements b.c.a.i.b {

        /* renamed from: b  reason: collision with root package name */
        List<List<b.e.a.h.f>> f1541b;

        /* renamed from: c  reason: collision with root package name */
        e f1542c;

        /* renamed from: d  reason: collision with root package name */
        long f1543d;

        /* renamed from: b.e.a.h.i.b$b$a */
        /* loaded from: classes.dex */
        class a implements Comparator<g> {
            a(C0050b c0050b) {
            }

            @Override // java.util.Comparator
            /* renamed from: a */
            public int compare(g gVar, g gVar2) {
                return b.e.a.j.b.a(gVar.z().h() - gVar2.z().h());
            }
        }

        private C0050b(b bVar, d dVar, Map<g, int[]> map, long j) {
            int i;
            this.f1541b = new ArrayList();
            this.f1543d = j;
            dVar.g();
            ArrayList<g> arrayList = new ArrayList(map.keySet());
            Collections.sort(arrayList, new a(this));
            HashMap hashMap = new HashMap();
            HashMap hashMap2 = new HashMap();
            HashMap hashMap3 = new HashMap();
            for (g gVar : arrayList) {
                hashMap.put(gVar, 0);
                hashMap2.put(gVar, 0);
                hashMap3.put(gVar, Double.valueOf(0.0d));
            }
            while (true) {
                g gVar2 = null;
                for (g gVar3 : arrayList) {
                    if (gVar2 == null || ((Double) hashMap3.get(gVar3)).doubleValue() < ((Double) hashMap3.get(gVar2)).doubleValue()) {
                        if (((Integer) hashMap.get(gVar3)).intValue() < map.get(gVar3).length) {
                            gVar2 = gVar3;
                        }
                    }
                }
                if (gVar2 == null) {
                    return;
                }
                int intValue = ((Integer) hashMap.get(gVar2)).intValue();
                int i2 = map.get(gVar2)[intValue];
                int intValue2 = ((Integer) hashMap2.get(gVar2)).intValue();
                double doubleValue = ((Double) hashMap3.get(gVar2)).doubleValue();
                int i3 = intValue2;
                while (true) {
                    i = intValue2 + i2;
                    if (i3 >= i) {
                        break;
                    }
                    doubleValue += gVar2.w()[i3] / gVar2.z().g();
                    i3++;
                    i2 = i2;
                    intValue = intValue;
                }
                this.f1541b.add(gVar2.g().subList(intValue2, i));
                hashMap.put(gVar2, Integer.valueOf(intValue + 1));
                hashMap2.put(gVar2, Integer.valueOf(i));
                hashMap3.put(gVar2, Double.valueOf(doubleValue));
            }
        }

        /* synthetic */ C0050b(b bVar, d dVar, Map map, long j, C0050b c0050b) {
            this(bVar, dVar, map, j);
        }

        private boolean d(long j) {
            return j + 8 < 4294967296L;
        }

        @Override // b.c.a.i.b
        public long a() {
            return this.f1543d + 16;
        }

        @Override // b.c.a.i.b
        public void b(b.e.a.e eVar, ByteBuffer byteBuffer, long j, b.c.a.b bVar) {
        }

        public long c() {
            b.c.a.i.b next;
            long j = 16;
            e eVar = this;
            while (eVar instanceof b.c.a.i.b) {
                C0050b c0050b = eVar;
                Iterator<b.c.a.i.b> it = c0050b.getParent().e().iterator();
                while (it.hasNext() && eVar != (next = it.next())) {
                    j += next.a();
                }
                eVar = c0050b.getParent();
            }
            return j;
        }

        @Override // b.c.a.i.b
        public e getParent() {
            return this.f1542c;
        }

        @Override // b.c.a.i.b
        public String getType() {
            return "mdat";
        }

        @Override // b.c.a.i.b
        public void m(e eVar) {
            this.f1542c = eVar;
        }

        @Override // b.c.a.i.b
        public void t(WritableByteChannel writableByteChannel) {
            ByteBuffer allocate = ByteBuffer.allocate(16);
            long a2 = a();
            if (d(a2)) {
                b.c.a.f.g(allocate, a2);
            } else {
                b.c.a.f.g(allocate, 1L);
            }
            allocate.put(b.c.a.d.F("mdat"));
            if (d(a2)) {
                allocate.put(new byte[8]);
            } else {
                b.c.a.f.i(allocate, a2);
            }
            allocate.rewind();
            writableByteChannel.write(allocate);
            b.f.b("About to write " + this.f1543d);
            long j = 0;
            long j2 = 0;
            for (List<b.e.a.h.f> list : this.f1541b) {
                for (b.e.a.h.f fVar : list) {
                    fVar.b(writableByteChannel);
                    j += fVar.a();
                    if (j > 1048576) {
                        j -= 1048576;
                        j2++;
                        b.f.b("Written " + j2 + "MB");
                    }
                }
            }
        }
    }

    private static long v(long[] jArr) {
        long j = 0;
        for (long j2 : jArr) {
            j += j2;
        }
        return j;
    }

    public e b(d dVar) {
        b.c.a.i.b next;
        if (this.e == null) {
            this.e = new b.e.a.h.i.a(2.0d);
        }
        f.b("Creating movie " + dVar);
        Iterator<g> it = dVar.g().iterator();
        while (true) {
            if (!it.hasNext()) {
                break;
            }
            g next2 = it.next();
            List<b.e.a.h.f> g = next2.g();
            u(next2, g);
            int size = g.size();
            long[] jArr = new long[size];
            for (int i = 0; i < size; i++) {
                jArr[i] = g.get(i).a();
            }
            this.f1540d.put(next2, jArr);
        }
        b.e.a.d dVar2 = new b.e.a.d();
        dVar2.v(f(dVar));
        HashMap hashMap = new HashMap();
        for (g gVar : dVar.g()) {
            hashMap.put(gVar, s(gVar));
        }
        q g2 = g(dVar, hashMap);
        dVar2.v(g2);
        long j = 0;
        for (v vVar : j.b(g2, "trak/mdia/minf/stbl/stsz")) {
            j += v(vVar.w());
        }
        f.b("About to create mdat");
        C0050b c0050b = new C0050b(this, dVar, hashMap, j, null);
        dVar2.v(c0050b);
        f.b("mdat crated");
        long c2 = c0050b.c();
        for (a0 a0Var : this.f1537a.values()) {
            long[] s = a0Var.s();
            for (int i2 = 0; i2 < s.length; i2++) {
                s[i2] = s[i2] + c2;
            }
        }
        for (b.g.a.a.a aVar : this.f1538b) {
            long a2 = aVar.a() + 44;
            e eVar = aVar;
            while (true) {
                e parent = eVar.getParent();
                Iterator<b.c.a.i.b> it2 = parent.e().iterator();
                while (it2.hasNext() && (next = it2.next()) != eVar) {
                    a2 += next.a();
                }
                if (!(parent instanceof b.c.a.i.b)) {
                    break;
                }
                eVar = parent;
            }
            long[] u = aVar.u();
            for (int i3 = 0; i3 < u.length; i3++) {
                u[i3] = u[i3] + a2;
            }
            aVar.v(u);
        }
        return dVar2;
    }

    protected void c(b.e.a.h.l.b bVar, w wVar, int[] iArr) {
        b.g.a.a.b bVar2 = new b.g.a.a.b();
        bVar2.y("cenc");
        bVar2.p(1);
        List<b.g.b.a.a> n = bVar.n();
        if (bVar.p()) {
            int size = n.size();
            short[] sArr = new short[size];
            for (int i = 0; i < size; i++) {
                sArr[i] = (short) n.get(i).b();
            }
            bVar2.B(sArr);
        } else {
            bVar2.z(8);
            bVar2.A(bVar.g().size());
        }
        b.g.a.a.a aVar = new b.g.a.a.a();
        b.e.a.i.c.a aVar2 = new b.e.a.i.c.a();
        aVar2.z(bVar.p());
        aVar2.y(n);
        long u = aVar2.u();
        long[] jArr = new long[iArr.length];
        int i2 = 0;
        for (int i3 = 0; i3 < iArr.length; i3++) {
            jArr[i3] = u;
            int i4 = 0;
            while (i4 < iArr[i3]) {
                u += n.get(i2).b();
                i4++;
                i2++;
                aVar2 = aVar2;
            }
        }
        aVar.v(jArr);
        wVar.v(bVar2);
        wVar.v(aVar);
        wVar.v(aVar2);
        this.f1538b.add(aVar);
    }

    protected void d(g gVar, w wVar) {
        List<d.a> d2 = gVar.d();
        if (d2 == null || d2.isEmpty()) {
            return;
        }
        b.c.a.i.d dVar = new b.c.a.i.d();
        dVar.v(d2);
        wVar.v(dVar);
    }

    protected b.c.a.i.b e(g gVar, b.e.a.h.d dVar) {
        if (gVar.c() == null || gVar.c().size() <= 0) {
            return null;
        }
        b.c.a.i.j jVar = new b.c.a.i.j();
        jVar.q(0);
        ArrayList arrayList = new ArrayList();
        for (b.e.a.h.c cVar : gVar.c()) {
            arrayList.add(new j.a(jVar, Math.round(cVar.c() * dVar.e()), (cVar.b() * gVar.z().g()) / cVar.d(), cVar.a()));
        }
        jVar.u(arrayList);
        i iVar = new i();
        iVar.v(jVar);
        return iVar;
    }

    protected k f(b.e.a.h.d dVar) {
        LinkedList linkedList = new LinkedList();
        linkedList.add("mp42");
        linkedList.add("iso6");
        linkedList.add("avc1");
        linkedList.add("isom");
        return new k("iso6", 1L, linkedList);
    }

    protected q g(b.e.a.h.d dVar, Map<g, int[]> map) {
        long k;
        q qVar = new q();
        r rVar = new r();
        rVar.B(new Date());
        rVar.E(new Date());
        rVar.D(dVar.c());
        long t = t(dVar);
        long j = 0;
        for (g gVar : dVar.g()) {
            if (gVar.c() == null || gVar.c().isEmpty()) {
                k = (gVar.k() * t) / gVar.z().g();
            } else {
                double d2 = 0.0d;
                for (b.e.a.h.c cVar : gVar.c()) {
                    d2 += (long) cVar.c();
                }
                k = (long) (d2 * t);
            }
            if (k > j) {
                j = k;
            }
        }
        rVar.C(j);
        rVar.G(t);
        long j2 = 0;
        for (g gVar2 : dVar.g()) {
            if (j2 < gVar2.z().h()) {
                j2 = gVar2.z().h();
            }
        }
        rVar.F(j2 + 1);
        qVar.v(rVar);
        for (g gVar3 : dVar.g()) {
            qVar.v(q(gVar3, dVar, map));
        }
        b.c.a.i.b r = r(dVar);
        if (r != null) {
            qVar.v(r);
        }
        return qVar;
    }

    protected void h(g gVar, w wVar) {
        if (gVar.A() == null || gVar.A().isEmpty()) {
            return;
        }
        t tVar = new t();
        tVar.u(gVar.A());
        wVar.v(tVar);
    }

    protected b.c.a.i.b i(g gVar, b.e.a.h.d dVar, Map<g, int[]> map) {
        w wVar = new w();
        l(gVar, wVar);
        o(gVar, wVar);
        d(gVar, wVar);
        m(gVar, wVar);
        h(gVar, wVar);
        k(gVar, map, wVar);
        n(gVar, wVar);
        j(gVar, dVar, map, wVar);
        HashMap hashMap = new HashMap();
        for (Map.Entry<b.e.a.i.d.d.b, long[]> entry : gVar.o().entrySet()) {
            String b2 = entry.getKey().b();
            List list = (List) hashMap.get(b2);
            if (list == null) {
                list = new ArrayList();
                hashMap.put(b2, list);
            }
            list.add(entry.getKey());
        }
        for (Map.Entry entry2 : hashMap.entrySet()) {
            b.e.a.i.d.d.e eVar = new b.e.a.i.d.d.e();
            String str = (String) entry2.getKey();
            eVar.x(str);
            eVar.w((List) entry2.getValue());
            b.e.a.i.d.d.f fVar = new b.e.a.i.d.d.f();
            fVar.v(str);
            f.a aVar = null;
            for (int i = 0; i < gVar.g().size(); i++) {
                int i2 = 0;
                for (int i3 = 0; i3 < ((List) entry2.getValue()).size(); i3++) {
                    if (Arrays.binarySearch(gVar.o().get((b.e.a.i.d.d.b) ((List) entry2.getValue()).get(i3)), i) >= 0) {
                        i2 = i3 + 1;
                    }
                }
                if (aVar == null || aVar.a() != i2) {
                    f.a aVar2 = new f.a(1L, i2);
                    fVar.s().add(aVar2);
                    aVar = aVar2;
                } else {
                    aVar.c(aVar.b() + 1);
                }
            }
            wVar.v(eVar);
            wVar.v(fVar);
        }
        if (gVar instanceof b.e.a.h.l.b) {
            c((b.e.a.h.l.b) gVar, wVar, map.get(gVar));
        }
        p(gVar, wVar);
        f.b("done with stbl for track_" + gVar.z().h());
        return wVar;
    }

    protected void j(g gVar, b.e.a.h.d dVar, Map<g, int[]> map, w wVar) {
        char c2;
        int i;
        if (this.f1537a.get(gVar) == null) {
            f.b("Calculating chunk offsets for track_" + gVar.z().h());
            ArrayList<g> arrayList = new ArrayList(map.keySet());
            Collections.sort(arrayList, new a(this));
            HashMap hashMap = new HashMap();
            HashMap hashMap2 = new HashMap();
            HashMap hashMap3 = new HashMap();
            Iterator it = arrayList.iterator();
            while (true) {
                c2 = 0;
                if (!it.hasNext()) {
                    break;
                }
                ArrayList arrayList2 = arrayList;
                g gVar2 = (g) it.next();
                hashMap.put(gVar2, 0);
                hashMap2.put(gVar2, 0);
                hashMap3.put(gVar2, Double.valueOf(0.0d));
                this.f1537a.put(gVar2, new a0());
                arrayList = arrayList2;
            }
            long j = 0;
            while (true) {
                g gVar3 = null;
                for (g gVar4 : arrayList) {
                    ArrayList arrayList3 = arrayList;
                    if ((gVar3 == null || ((Double) hashMap3.get(gVar4)).doubleValue() < ((Double) hashMap3.get(gVar3)).doubleValue()) && ((Integer) hashMap.get(gVar4)).intValue() < map.get(gVar4).length) {
                        gVar3 = gVar4;
                    }
                    arrayList = arrayList3;
                    c2 = 0;
                }
                if (gVar3 == null) {
                    break;
                }
                a0 a0Var = this.f1537a.get(gVar3);
                long[] s = a0Var.s();
                long[] jArr = new long[1];
                jArr[c2] = j;
                a0Var.u(b.e.a.j.i.a(s, jArr));
                int intValue = ((Integer) hashMap.get(gVar3)).intValue();
                int i2 = map.get(gVar3)[intValue];
                int intValue2 = ((Integer) hashMap2.get(gVar3)).intValue();
                double doubleValue = ((Double) hashMap3.get(gVar3)).doubleValue();
                long[] w = gVar3.w();
                int i3 = intValue2;
                while (true) {
                    i = intValue2 + i2;
                    if (i3 >= i) {
                        break;
                    }
                    long j2 = j + this.f1540d.get(gVar3)[i3];
                    doubleValue += w[i3] / gVar3.z().g();
                    i3++;
                    intValue = intValue;
                    j = j2;
                    arrayList = arrayList;
                }
                hashMap.put(gVar3, Integer.valueOf(intValue + 1));
                hashMap2.put(gVar3, Integer.valueOf(i));
                hashMap3.put(gVar3, Double.valueOf(doubleValue));
                c2 = 0;
            }
        }
        wVar.v(this.f1537a.get(gVar));
    }

    protected void k(g gVar, Map<g, int[]> map, w wVar) {
        int[] iArr = map.get(gVar);
        x xVar = new x();
        xVar.v(new LinkedList());
        long j = -2147483648L;
        for (int i = 0; i < iArr.length; i++) {
            if (j != iArr[i]) {
                xVar.u().add(new x.a(i + 1, iArr[i], 1L));
                j = iArr[i];
            }
        }
        wVar.v(xVar);
    }

    protected void l(g gVar, w wVar) {
        wVar.v(gVar.x());
    }

    protected void m(g gVar, w wVar) {
        long[] f2 = gVar.f();
        if (f2 == null || f2.length <= 0) {
            return;
        }
        d0 d0Var = new d0();
        d0Var.u(f2);
        wVar.v(d0Var);
    }

    protected void n(g gVar, w wVar) {
        v vVar = new v();
        vVar.x(this.f1540d.get(gVar));
        wVar.v(vVar);
    }

    protected void o(g gVar, w wVar) {
        long[] w;
        ArrayList arrayList = new ArrayList();
        e0.a aVar = null;
        for (long j : gVar.w()) {
            if (aVar == null || aVar.b() != j) {
                aVar = new e0.a(1L, j);
                arrayList.add(aVar);
            } else {
                aVar.c(aVar.a() + 1);
            }
        }
        e0 e0Var = new e0();
        e0Var.v(arrayList);
        wVar.v(e0Var);
    }

    protected void p(g gVar, w wVar) {
        if (gVar.i() != null) {
            wVar.v(gVar.i());
        }
    }

    protected f0 q(g gVar, b.e.a.h.d dVar, Map<g, int[]> map) {
        long k;
        b.c.a.i.b sVar;
        f0 f0Var = new f0();
        g0 g0Var = new g0();
        g0Var.G(true);
        g0Var.I(true);
        g0Var.K(gVar.z().f());
        g0Var.D(gVar.z().b());
        g0Var.E(gVar.z().a());
        if (gVar.c() == null || gVar.c().isEmpty()) {
            k = (gVar.k() * t(dVar)) / gVar.z().g();
        } else {
            long j = 0;
            for (b.e.a.h.c cVar : gVar.c()) {
                j += (long) cVar.c();
            }
            k = j * gVar.z().g();
        }
        g0Var.F(k);
        g0Var.H(gVar.z().c());
        g0Var.O(gVar.z().j());
        g0Var.J(gVar.z().e());
        g0Var.L(new Date());
        g0Var.M(gVar.z().h());
        g0Var.N(gVar.z().i());
        f0Var.v(g0Var);
        f0Var.v(e(gVar, dVar));
        n nVar = new n();
        f0Var.v(nVar);
        o oVar = new o();
        oVar.y(gVar.z().a());
        oVar.z(gVar.k());
        oVar.B(gVar.z().g());
        oVar.A(gVar.z().d());
        nVar.v(oVar);
        l lVar = new l();
        nVar.v(lVar);
        lVar.v(gVar.r());
        p pVar = new p();
        if (gVar.r().equals("vide")) {
            sVar = new h0();
        } else if (gVar.r().equals("soun")) {
            sVar = new z();
        } else if (gVar.r().equals("text")) {
            sVar = new s();
        } else if (gVar.r().equals("subt")) {
            sVar = new c0();
        } else if (!gVar.r().equals("hint")) {
            if (gVar.r().equals("sbtl")) {
                sVar = new s();
            }
            b.c.a.i.g gVar2 = new b.c.a.i.g();
            h hVar = new h();
            gVar2.v(hVar);
            b.c.a.i.f fVar = new b.c.a.i.f();
            fVar.p(1);
            hVar.v(fVar);
            pVar.v(gVar2);
            pVar.v(i(gVar, dVar, map));
            nVar.v(pVar);
            b.e.a.j.f fVar2 = f;
            fVar2.b("done with trak for track_" + gVar.z().h());
            return f0Var;
        } else {
            sVar = new m();
        }
        pVar.v(sVar);
        b.c.a.i.g gVar22 = new b.c.a.i.g();
        h hVar2 = new h();
        gVar22.v(hVar2);
        b.c.a.i.f fVar3 = new b.c.a.i.f();
        fVar3.p(1);
        hVar2.v(fVar3);
        pVar.v(gVar22);
        pVar.v(i(gVar, dVar, map));
        nVar.v(pVar);
        b.e.a.j.f fVar22 = f;
        fVar22.b("done with trak for track_" + gVar.z().h());
        return f0Var;
    }

    protected b.c.a.i.b r(b.e.a.h.d dVar) {
        return null;
    }

    int[] s(g gVar) {
        long[] a2 = this.e.a(gVar);
        int[] iArr = new int[a2.length];
        int i = 0;
        while (i < a2.length) {
            int i2 = i + 1;
            iArr[i] = b.e.a.j.b.a((a2.length == i2 ? gVar.g().size() : a2[i2] - 1) - (a2[i] - 1));
            i = i2;
        }
        return iArr;
    }

    public long t(b.e.a.h.d dVar) {
        long g = dVar.g().iterator().next().z().g();
        for (g gVar : dVar.g()) {
            g = b.e.a.j.g.b(g, gVar.z().g());
        }
        return g;
    }

    protected List<b.e.a.h.f> u(g gVar, List<b.e.a.h.f> list) {
        return this.f1539c.put(gVar, list);
    }
}
