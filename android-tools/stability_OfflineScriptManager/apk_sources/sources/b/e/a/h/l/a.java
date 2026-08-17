package b.e.a.h.l;

import b.c.a.i.b0;
import b.c.a.i.d;
import b.c.a.i.k0.d;
import b.c.a.i.t;
import b.c.a.i.u;
import b.e.a.h.g;
import b.e.a.i.d.c.e;
import b.e.a.i.d.c.h;
import b.e.a.j.f;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.channels.Channels;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class a extends b.e.a.h.a {
    private static f i = f.a(a.class);
    g[] e;
    u f;
    List<b.e.a.h.f> g;
    long[] h;

    public a(g... gVarArr) {
        super(a(gVarArr));
        this.e = gVarArr;
        for (g gVar : gVarArr) {
            u uVar = this.f;
            if (uVar == null) {
                u uVar2 = new u();
                this.f = uVar2;
                uVar2.v((b.c.a.i.b) gVar.x().q(b.c.a.i.k0.c.class).get(0));
            } else {
                this.f = m(uVar, gVar.x());
            }
        }
        this.g = new ArrayList();
        for (g gVar2 : gVarArr) {
            this.g.addAll(gVar2.g());
        }
        int i2 = 0;
        for (g gVar3 : gVarArr) {
            i2 += gVar3.w().length;
        }
        this.h = new long[i2];
        int i3 = 0;
        for (g gVar4 : gVarArr) {
            long[] w = gVar4.w();
            System.arraycopy(w, 0, this.h, i3, w.length);
            i3 += w.length;
        }
    }

    public static String a(g... gVarArr) {
        String str = BuildConfig.FLAVOR;
        for (g gVar : gVarArr) {
            str = String.valueOf(str) + gVar.getName() + " + ";
        }
        return str.substring(0, str.length() - 3);
    }

    private b.c.a.i.k0.b b(b.c.a.i.k0.b bVar, b.c.a.i.k0.b bVar2) {
        b.c.a.i.k0.b bVar3 = new b.c.a.i.k0.b(bVar2.getType());
        if (bVar.G() != bVar2.G()) {
            i.c("BytesPerFrame differ");
            return null;
        }
        bVar3.R(bVar.G());
        if (bVar.H() == bVar2.H()) {
            bVar3.S(bVar.H());
            if (bVar.I() == bVar2.I()) {
                bVar3.T(bVar.I());
                if (bVar.J() == bVar2.J()) {
                    bVar3.U(bVar.J());
                    if (bVar.L() == bVar2.L()) {
                        bVar3.W(bVar.L());
                        if (bVar.K() == bVar2.K()) {
                            bVar3.V(bVar.K());
                            if (bVar.M() == bVar2.M()) {
                                bVar3.X(bVar.M());
                                if (bVar.N() == bVar2.N()) {
                                    bVar3.Y(bVar.N());
                                    if (bVar.O() == bVar2.O()) {
                                        bVar3.Z(bVar.O());
                                        if (bVar.P() == bVar2.P()) {
                                            bVar3.a0(bVar.P());
                                            if (Arrays.equals(bVar.Q(), bVar2.Q())) {
                                                bVar3.b0(bVar.Q());
                                                if (bVar.e().size() == bVar2.e().size()) {
                                                    Iterator<b.c.a.i.b> it = bVar2.e().iterator();
                                                    for (b.c.a.i.b bVar4 : bVar.e()) {
                                                        b.c.a.i.b next = it.next();
                                                        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
                                                        ByteArrayOutputStream byteArrayOutputStream2 = new ByteArrayOutputStream();
                                                        try {
                                                            bVar4.t(Channels.newChannel(byteArrayOutputStream));
                                                            next.t(Channels.newChannel(byteArrayOutputStream2));
                                                            if (!Arrays.equals(byteArrayOutputStream.toByteArray(), byteArrayOutputStream2.toByteArray())) {
                                                                if ("esds".equals(bVar4.getType()) && "esds".equals(next.getType())) {
                                                                    b.e.a.i.d.b bVar5 = (b.e.a.i.d.b) bVar4;
                                                                    bVar5.u(e(bVar5.v(), ((b.e.a.i.d.b) next).v()));
                                                                }
                                                            }
                                                            bVar3.v(bVar4);
                                                        } catch (IOException e) {
                                                            i.d(e.getMessage());
                                                            return null;
                                                        }
                                                    }
                                                }
                                                return bVar3;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        return null;
                    }
                    i.c("ChannelCount differ");
                }
                return null;
            }
            i.c("BytesPerSample differ");
        }
        return null;
    }

    private h e(b.e.a.i.d.c.b bVar, b.e.a.i.d.c.b bVar2) {
        if (!(bVar instanceof h) || !(bVar2 instanceof h)) {
            i.c("I can only merge ESDescriptors");
            return null;
        }
        h hVar = (h) bVar;
        h hVar2 = (h) bVar2;
        if (hVar.o() != hVar2.o()) {
            return null;
        }
        hVar.p();
        hVar2.p();
        if (hVar.h() == hVar2.h() && hVar.i() == hVar2.i() && hVar.r() == hVar2.r() && hVar.s() == hVar2.s() && hVar.k() == hVar2.k() && hVar.m() == hVar2.m()) {
            hVar.n();
            hVar2.n();
            if (hVar.q() != null) {
                hVar.q().equals(hVar2.q());
            } else {
                hVar2.q();
            }
            if (hVar.g() == null ? hVar2.g() != null : !hVar.g().equals(hVar2.g())) {
                e g = hVar.g();
                e g2 = hVar2.g();
                if (g.g() != null && g2.g() != null && !g.g().equals(g2.g())) {
                    return null;
                }
                if (g.h() != g2.h()) {
                    g.q((g.h() + g2.h()) / 2);
                }
                g.i();
                g2.i();
                if (g.j() == null ? g2.j() != null : !g.j().equals(g2.j())) {
                    return null;
                }
                if (g.k() != g2.k()) {
                    g.r(Math.max(g.k(), g2.k()));
                }
                if (!g.m().equals(g2.m()) || g.l() != g2.l() || g.n() != g2.n() || g.o() != g2.o()) {
                    return null;
                }
            }
            if (hVar.j() == null ? hVar2.j() == null : hVar.j().equals(hVar2.j())) {
                if (hVar.l() == null ? hVar2.l() == null : hVar.l().equals(hVar2.l())) {
                    return hVar;
                }
                return null;
            }
            return null;
        }
        return null;
    }

    private b.c.a.i.k0.c h(b.c.a.i.k0.c cVar, b.c.a.i.k0.c cVar2) {
        if (cVar.getType().equals(cVar2.getType())) {
            if ((cVar instanceof d) && (cVar2 instanceof d)) {
                return q((d) cVar, (d) cVar2);
            }
            if ((cVar instanceof b.c.a.i.k0.b) && (cVar2 instanceof b.c.a.i.k0.b)) {
                return b((b.c.a.i.k0.b) cVar, (b.c.a.i.k0.b) cVar2);
            }
            return null;
        }
        return null;
    }

    private u m(u uVar, u uVar2) {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        ByteArrayOutputStream byteArrayOutputStream2 = new ByteArrayOutputStream();
        try {
            uVar.t(Channels.newChannel(byteArrayOutputStream));
            uVar2.t(Channels.newChannel(byteArrayOutputStream2));
            if (!Arrays.equals(byteArrayOutputStream2.toByteArray(), byteArrayOutputStream.toByteArray())) {
                b.c.a.i.k0.c h = h((b.c.a.i.k0.c) uVar.q(b.c.a.i.k0.c.class).get(0), (b.c.a.i.k0.c) uVar2.q(b.c.a.i.k0.c.class).get(0));
                if (h == null) {
                    throw new IOException("Cannot merge " + uVar.q(b.c.a.i.k0.c.class).get(0) + " and " + uVar2.q(b.c.a.i.k0.c.class).get(0));
                }
                uVar.E(Collections.singletonList(h));
            }
            return uVar;
        } catch (IOException e) {
            i.c(e.getMessage());
            return null;
        }
    }

    private d q(d dVar, d dVar2) {
        d dVar3 = new d();
        if (dVar.K() != dVar2.K()) {
            i.c("Horizontal Resolution differs");
            return null;
        }
        dVar3.R(dVar.K());
        dVar3.N(dVar.G());
        if (dVar.H() != dVar2.H()) {
            i.c("Depth differs");
            return null;
        }
        dVar3.O(dVar.H());
        if (dVar.I() != dVar2.I()) {
            i.c("frame count differs");
            return null;
        }
        dVar3.P(dVar.I());
        if (dVar.J() != dVar2.J()) {
            i.c("height differs");
            return null;
        }
        dVar3.Q(dVar.J());
        if (dVar.M() != dVar2.M()) {
            i.c("width differs");
            return null;
        }
        dVar3.T(dVar.M());
        if (dVar.L() != dVar2.L()) {
            i.c("vert resolution differs");
            return null;
        }
        dVar3.S(dVar.L());
        if (dVar.K() != dVar2.K()) {
            i.c("horizontal resolution differs");
            return null;
        }
        dVar3.R(dVar.K());
        if (dVar.e().size() == dVar2.e().size()) {
            Iterator<b.c.a.i.b> it = dVar2.e().iterator();
            for (b.c.a.i.b bVar : dVar.e()) {
                b.c.a.i.b next = it.next();
                ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
                ByteArrayOutputStream byteArrayOutputStream2 = new ByteArrayOutputStream();
                try {
                    bVar.t(Channels.newChannel(byteArrayOutputStream));
                    next.t(Channels.newChannel(byteArrayOutputStream2));
                    if (!Arrays.equals(byteArrayOutputStream.toByteArray(), byteArrayOutputStream2.toByteArray())) {
                        if ((bVar instanceof b.e.a.i.d.a) && (next instanceof b.e.a.i.d.a)) {
                            b.e.a.i.d.a aVar = (b.e.a.i.d.a) bVar;
                            aVar.u(e(aVar.s(), ((b.e.a.i.d.a) next).s()));
                        }
                    }
                    dVar3.v(bVar);
                } catch (IOException e) {
                    i.d(e.getMessage());
                    return null;
                }
            }
        }
        return dVar3;
    }

    @Override // b.e.a.h.g
    public List<t.a> A() {
        if (this.e[0].A() == null || this.e[0].A().isEmpty()) {
            return null;
        }
        LinkedList linkedList = new LinkedList();
        for (g gVar : this.e) {
            linkedList.addAll(gVar.A());
        }
        return linkedList;
    }

    @Override // java.io.Closeable, java.lang.AutoCloseable
    public void close() {
        for (g gVar : this.e) {
            gVar.close();
        }
    }

    @Override // b.e.a.h.g
    public List<d.a> d() {
        if (this.e[0].d() == null || this.e[0].d().isEmpty()) {
            return null;
        }
        LinkedList<int[]> linkedList = new LinkedList();
        for (g gVar : this.e) {
            linkedList.add(b.c.a.i.d.s(gVar.d()));
        }
        LinkedList linkedList2 = new LinkedList();
        for (int[] iArr : linkedList) {
            for (int i2 : iArr) {
                if (linkedList2.isEmpty() || ((d.a) linkedList2.getLast()).b() != i2) {
                    linkedList2.add(new d.a(1, i2));
                } else {
                    d.a aVar = (d.a) linkedList2.getLast();
                    aVar.c(aVar.a() + 1);
                }
            }
        }
        return linkedList2;
    }

    @Override // b.e.a.h.g
    public long[] f() {
        g[] gVarArr;
        g[] gVarArr2;
        if (this.e[0].f() == null || this.e[0].f().length <= 0) {
            return null;
        }
        int i2 = 0;
        for (g gVar : this.e) {
            i2 += gVar.f() != null ? gVar.f().length : 0;
        }
        long[] jArr = new long[i2];
        long j = 0;
        int i3 = 0;
        for (g gVar2 : this.e) {
            if (gVar2.f() != null) {
                long[] f = gVar2.f();
                int length = f.length;
                int i4 = 0;
                while (i4 < length) {
                    jArr[i3] = f[i4] + j;
                    i4++;
                    i3++;
                }
            }
            j += gVar2.g().size();
        }
        return jArr;
    }

    @Override // b.e.a.h.g
    public List<b.e.a.h.f> g() {
        return this.g;
    }

    @Override // b.e.a.h.g
    public b0 i() {
        return this.e[0].i();
    }

    @Override // b.e.a.h.g
    public String r() {
        return this.e[0].r();
    }

    @Override // b.e.a.h.g
    public synchronized long[] w() {
        return this.h;
    }

    @Override // b.e.a.h.g
    public u x() {
        return this.f;
    }

    @Override // b.e.a.h.g
    public b.e.a.h.h z() {
        return this.e[0].z();
    }
}
