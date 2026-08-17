package d;

import d.a;
import d.k;
import java.io.IOException;
import java.nio.channels.Selector;
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Deque;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
/* loaded from: classes.dex */
public class c {
    private static AtomicInteger w = new AtomicInteger(0);

    /* renamed from: d  reason: collision with root package name */
    private final AtomicBoolean f2528d = new AtomicBoolean(true);
    private final List<Selector> g = new ArrayList();
    private final Lock s = new ReentrantLock();
    private final Map<String, b> t = new HashMap();
    private final d.s.c v = new d.s.c();

    /* renamed from: a  reason: collision with root package name */
    private int f2525a = -1414673666;
    private boolean e = false;
    private h h = null;
    private int j = 0;
    private d[] k = null;
    private int o = 1024;
    private int p = 1;
    private boolean u = false;
    private boolean q = true;
    private final Lock f = new ReentrantLock();
    private final Lock n = new ReentrantLock();
    private final Lock r = new ReentrantLock();
    private final d l = new d(this, "terminater", -1);

    /* renamed from: c  reason: collision with root package name */
    private final Deque<Integer> f2527c = new ArrayDeque();
    private final List<d.n.d> i = new ArrayList();

    /* renamed from: b  reason: collision with root package name */
    private final List<j> f2526b = new ArrayList();
    private final Map<String, a> m = new HashMap();

    /* loaded from: classes.dex */
    public static class a {

        /* renamed from: a  reason: collision with root package name */
        public final j f2529a;

        /* renamed from: b  reason: collision with root package name */
        public final f f2530b;

        public a(j jVar, f fVar) {
            this.f2529a = jVar;
            this.f2530b = fVar;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class b {

        /* renamed from: a  reason: collision with root package name */
        private final a f2531a;

        /* renamed from: b  reason: collision with root package name */
        private final d.p.b f2532b;

        /* renamed from: c  reason: collision with root package name */
        private final d.p.b f2533c;

        public b(a aVar, d.p.b bVar, d.p.b bVar2) {
            this.f2531a = aVar;
            this.f2532b = bVar;
            this.f2533c = bVar2;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* renamed from: d.c$c  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public enum EnumC0104c {
        CONNECT,
        BIND;

        /* renamed from: values  reason: to resolve conflict with enum method */
        public static EnumC0104c[] valuesCustom() {
            EnumC0104c[] valuesCustom = values();
            int length = valuesCustom.length;
            EnumC0104c[] enumC0104cArr = new EnumC0104c[length];
            System.arraycopy(valuesCustom, 0, enumC0104cArr, 0, length);
            return enumC0104cArr;
        }
    }

    private void d(j jVar, f fVar, b bVar, EnumC0104c enumC0104c) {
        jVar.z0();
        bVar.f2533c.v0(jVar.G());
        if (!fVar.t) {
            bVar.f2533c.I0();
        }
        int i = (bVar.f2531a.f2530b.f2547a == 0 || fVar.f2548b == 0) ? 0 : bVar.f2531a.f2530b.f2547a + fVar.f2548b;
        int i2 = (bVar.f2531a.f2530b.f2548b == 0 || fVar.f2547a == 0) ? 0 : bVar.f2531a.f2530b.f2548b + fVar.f2547a;
        boolean z = bVar.f2531a.f2530b.K && (bVar.f2531a.f2530b.j == 5 || bVar.f2531a.f2530b.j == 7 || bVar.f2531a.f2530b.j == 8 || bVar.f2531a.f2530b.j == 1 || bVar.f2531a.f2530b.j == 2);
        int[] iArr = new int[2];
        if (z) {
            i = -1;
        }
        iArr[0] = i;
        if (z) {
            i2 = -1;
        }
        iArr[1] = i2;
        bVar.f2532b.L0(iArr[1], iArr[0]);
        bVar.f2533c.L0(iArr[0], iArr[1]);
        if (enumC0104c == EnumC0104c.BIND) {
            jVar.M(new d.a(null, a.EnumC0103a.BIND, bVar.f2533c));
            jVar.j0(bVar.f2531a.f2529a);
        } else {
            bVar.f2532b.f0(jVar, bVar.f2533c, false);
        }
        if (bVar.f2531a.f2530b.t && bVar.f2531a.f2529a.N0()) {
            e eVar = new e(fVar.f2550d);
            eVar.v(fVar.e, 0, fVar.f2550d);
            eVar.y(64);
            bVar.f2533c.Q0(eVar);
            bVar.f2533c.B0();
        }
    }

    private void h() {
        for (d.n.d dVar : this.i) {
            dVar.B0();
        }
        for (d.n.d dVar2 : this.i) {
            dVar2.close();
        }
        this.i.clear();
        this.s.lock();
        try {
            for (Selector selector : this.g) {
                if (selector != null) {
                    selector.close();
                }
            }
            this.g.clear();
            this.s.unlock();
            h hVar = this.h;
            if (hVar != null) {
                hVar.close();
            }
            this.l.close();
            this.f2525a = -559038737;
        } catch (Throwable th) {
            this.s.unlock();
            throw th;
        }
    }

    private void n() {
        int i;
        this.f.lock();
        try {
            this.r.lock();
            int i2 = this.p;
            this.j = this.o + i2 + 2;
            this.r.unlock();
            d[] dVarArr = new d[this.j];
            this.k = dVarArr;
            dVarArr[0] = this.l;
            h hVar = new h(this, 1);
            this.h = hVar;
            this.k[1] = hVar.y0();
            this.h.z0();
            int i3 = 2;
            while (true) {
                i = i2 + 2;
                if (i3 == i) {
                    break;
                }
                d.n.d dVar = new d.n.d(this, i3);
                this.i.add(dVar);
                this.k[i3] = dVar.y0();
                dVar.A0();
                i3++;
            }
            for (int i4 = this.j - 1; i4 >= i; i4--) {
                this.f2527c.add(Integer.valueOf(i4));
                this.k[i4] = null;
            }
        } finally {
            this.f.unlock();
        }
    }

    public boolean a() {
        return this.f2525a == -1414673666;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public d.n.d b(long j) {
        d.n.d dVar = null;
        if (this.i.isEmpty()) {
            return null;
        }
        int i = -1;
        for (int i2 = 0; i2 != this.i.size(); i2++) {
            if (j == 0 || ((1 << i2) & j) > 0) {
                int x0 = this.i.get(i2).x0();
                if (dVar == null || x0 < i) {
                    dVar = this.i.get(i2);
                    i = x0;
                }
            }
        }
        return dVar;
    }

    public boolean c(Selector selector) {
        this.s.lock();
        try {
            boolean remove = this.g.remove(selector);
            if (remove) {
                try {
                    selector.close();
                } catch (IOException e) {
                    throw new k.b(e);
                }
            }
            return remove;
        } finally {
            this.s.unlock();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void e(String str, j jVar) {
        this.n.lock();
        try {
            b remove = this.t.remove(str);
            if (remove != null) {
                d(jVar, this.m.get(str).f2530b, remove, EnumC0104c.BIND);
            }
        } finally {
            this.n.unlock();
        }
    }

    public Selector f() {
        this.s.lock();
        try {
            try {
                Selector open = Selector.open();
                this.g.add(open);
                return open;
            } catch (IOException e) {
                throw new k.b(e);
            }
        } finally {
            this.s.unlock();
        }
    }

    public j g(int i) {
        this.f.lock();
        try {
            if (this.f2528d.compareAndSet(true, false)) {
                n();
            }
            if (this.e) {
                throw new k.a();
            }
            if (this.f2527c.isEmpty()) {
                throw new IllegalStateException("EMFILE");
            }
            int intValue = this.f2527c.pollLast().intValue();
            j b2 = d.r.d.b(i, this, intValue, w.incrementAndGet());
            if (b2 == null) {
                this.f2527c.addLast(Integer.valueOf(intValue));
                this.f.unlock();
                return null;
            }
            this.f2526b.add(b2);
            this.k[intValue] = b2.c1();
            return b2;
        } finally {
            this.f.unlock();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void i(j jVar) {
        this.f.lock();
        try {
            int G = jVar.G();
            this.f2527c.add(Integer.valueOf(G));
            this.k[G] = null;
            this.f2526b.remove(jVar);
            if (this.e && this.f2526b.isEmpty()) {
                this.h.A0();
            }
        } finally {
            this.f.unlock();
        }
    }

    public d.s.c j() {
        return this.v;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public a k(String str) {
        this.n.lock();
        try {
            a aVar = this.m.get(str);
            if (aVar == null) {
                aVar = new a(null, new f());
            } else {
                aVar.f2529a.z0();
            }
            return aVar;
        } finally {
            this.n.unlock();
        }
    }

    public int l(int i) {
        if (i == 2) {
            return this.o;
        }
        if (i == 1) {
            return this.p;
        }
        if (i == 70) {
            return this.q ? 1 : 0;
        }
        if (i == 42) {
            return this.u ? 1 : 0;
        }
        throw new IllegalArgumentException("option = " + i);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public m m() {
        return this.h;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void o(String str, a aVar, d.p.b[] bVarArr) {
        b bVar = new b(aVar, bVarArr[0], bVarArr[1]);
        this.n.lock();
        try {
            a aVar2 = this.m.get(str);
            if (aVar2 == null) {
                aVar.f2529a.z0();
                this.t.put(str, bVar);
            } else {
                d(aVar2.f2529a, aVar2.f2530b, bVar, EnumC0104c.CONNECT);
            }
        } finally {
            this.n.unlock();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean p(String str, a aVar) {
        this.n.lock();
        try {
            return this.m.put(str, aVar) == null;
        } finally {
            this.n.unlock();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void q(int i, d.a aVar) {
        this.k[i].e(aVar);
    }

    public boolean r(int i, int i2) {
        if (i == 2 && i2 >= 1) {
            this.r.lock();
            try {
                this.o = i2;
            } finally {
            }
        } else if (i != 1 || i2 < 0) {
            if (i == 70 && i2 >= 0) {
                this.r.lock();
                try {
                    this.q = i2 != 0;
                } finally {
                }
            } else if (i != 42 || i2 < 0) {
                return false;
            } else {
                this.r.lock();
                try {
                    this.u = i2 != 0;
                } finally {
                }
            }
        } else {
            this.r.lock();
            try {
                this.p = i2;
            } finally {
            }
        }
        return true;
    }

    public void s() {
        for (Map.Entry<String, b> entry : this.t.entrySet()) {
            j g = g(0);
            g.K0(entry.getKey());
            g.close();
        }
        this.f.lock();
        try {
            if (!this.f2528d.get()) {
                boolean z = this.e;
                this.e = true;
                if (!z) {
                    for (j jVar : this.f2526b) {
                        jVar.i1();
                    }
                    if (this.f2526b.isEmpty()) {
                        this.h.A0();
                    }
                }
                this.f.unlock();
                if (this.l.b(-1L) == null) {
                    throw new IllegalStateException();
                }
                this.f.lock();
            }
            try {
                h();
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        } finally {
            this.f.unlock();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void t(j jVar) {
        this.n.lock();
        try {
            Iterator<Map.Entry<String, a>> it = this.m.entrySet().iterator();
            while (it.hasNext()) {
                if (it.next().getValue().f2529a == jVar) {
                    it.remove();
                }
            }
        } finally {
            this.n.unlock();
        }
    }
}
