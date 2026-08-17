package androidx.recyclerview.widget;

import androidx.recyclerview.widget.RecyclerView;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class n {

    /* renamed from: a  reason: collision with root package name */
    final a.d.a<RecyclerView.c0, a> f1272a = new a.d.a<>();

    /* renamed from: b  reason: collision with root package name */
    final a.d.d<RecyclerView.c0> f1273b = new a.d.d<>();

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class a {

        /* renamed from: d  reason: collision with root package name */
        static a.f.k.d<a> f1274d = new a.f.k.e(20);

        /* renamed from: a  reason: collision with root package name */
        int f1275a;

        /* renamed from: b  reason: collision with root package name */
        RecyclerView.l.c f1276b;

        /* renamed from: c  reason: collision with root package name */
        RecyclerView.l.c f1277c;

        private a() {
        }

        static void a() {
            do {
            } while (f1274d.b() != null);
        }

        static a b() {
            a b2 = f1274d.b();
            return b2 == null ? new a() : b2;
        }

        static void c(a aVar) {
            aVar.f1275a = 0;
            aVar.f1276b = null;
            aVar.f1277c = null;
            f1274d.a(aVar);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public interface b {
        void a(RecyclerView.c0 c0Var);

        void b(RecyclerView.c0 c0Var, RecyclerView.l.c cVar, RecyclerView.l.c cVar2);

        void c(RecyclerView.c0 c0Var, RecyclerView.l.c cVar, RecyclerView.l.c cVar2);

        void d(RecyclerView.c0 c0Var, RecyclerView.l.c cVar, RecyclerView.l.c cVar2);
    }

    private RecyclerView.l.c l(RecyclerView.c0 c0Var, int i) {
        a m;
        RecyclerView.l.c cVar;
        int f = this.f1272a.f(c0Var);
        if (f >= 0 && (m = this.f1272a.m(f)) != null) {
            int i2 = m.f1275a;
            if ((i2 & i) != 0) {
                int i3 = (~i) & i2;
                m.f1275a = i3;
                if (i == 4) {
                    cVar = m.f1276b;
                } else if (i != 8) {
                    throw new IllegalArgumentException("Must provide flag PRE or POST");
                } else {
                    cVar = m.f1277c;
                }
                if ((i3 & 12) == 0) {
                    this.f1272a.k(f);
                    a.c(m);
                }
                return cVar;
            }
        }
        return null;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void a(RecyclerView.c0 c0Var, RecyclerView.l.c cVar) {
        a aVar = this.f1272a.get(c0Var);
        if (aVar == null) {
            aVar = a.b();
            this.f1272a.put(c0Var, aVar);
        }
        aVar.f1275a |= 2;
        aVar.f1276b = cVar;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void b(RecyclerView.c0 c0Var) {
        a aVar = this.f1272a.get(c0Var);
        if (aVar == null) {
            aVar = a.b();
            this.f1272a.put(c0Var, aVar);
        }
        aVar.f1275a |= 1;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void c(long j, RecyclerView.c0 c0Var) {
        this.f1273b.j(j, c0Var);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void d(RecyclerView.c0 c0Var, RecyclerView.l.c cVar) {
        a aVar = this.f1272a.get(c0Var);
        if (aVar == null) {
            aVar = a.b();
            this.f1272a.put(c0Var, aVar);
        }
        aVar.f1277c = cVar;
        aVar.f1275a |= 8;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void e(RecyclerView.c0 c0Var, RecyclerView.l.c cVar) {
        a aVar = this.f1272a.get(c0Var);
        if (aVar == null) {
            aVar = a.b();
            this.f1272a.put(c0Var, aVar);
        }
        aVar.f1276b = cVar;
        aVar.f1275a |= 4;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void f() {
        this.f1272a.clear();
        this.f1273b.b();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public RecyclerView.c0 g(long j) {
        return this.f1273b.f(j);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean h(RecyclerView.c0 c0Var) {
        a aVar = this.f1272a.get(c0Var);
        return (aVar == null || (aVar.f1275a & 1) == 0) ? false : true;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean i(RecyclerView.c0 c0Var) {
        a aVar = this.f1272a.get(c0Var);
        return (aVar == null || (aVar.f1275a & 4) == 0) ? false : true;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void j() {
        a.a();
    }

    public void k(RecyclerView.c0 c0Var) {
        p(c0Var);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public RecyclerView.l.c m(RecyclerView.c0 c0Var) {
        return l(c0Var, 8);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public RecyclerView.l.c n(RecyclerView.c0 c0Var) {
        return l(c0Var, 4);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void o(b bVar) {
        RecyclerView.l.c cVar;
        RecyclerView.l.c cVar2;
        for (int size = this.f1272a.size() - 1; size >= 0; size--) {
            RecyclerView.c0 i = this.f1272a.i(size);
            a k = this.f1272a.k(size);
            int i2 = k.f1275a;
            if ((i2 & 3) != 3) {
                if ((i2 & 1) != 0) {
                    cVar = k.f1276b;
                    cVar2 = cVar != null ? k.f1277c : null;
                } else {
                    if ((i2 & 14) != 14) {
                        if ((i2 & 12) == 12) {
                            bVar.d(i, k.f1276b, k.f1277c);
                        } else if ((i2 & 4) != 0) {
                            cVar = k.f1276b;
                        } else if ((i2 & 8) == 0) {
                        }
                        a.c(k);
                    }
                    bVar.b(i, k.f1276b, k.f1277c);
                    a.c(k);
                }
                bVar.c(i, cVar, cVar2);
                a.c(k);
            }
            bVar.a(i);
            a.c(k);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void p(RecyclerView.c0 c0Var) {
        a aVar = this.f1272a.get(c0Var);
        if (aVar == null) {
            return;
        }
        aVar.f1275a &= -2;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void q(RecyclerView.c0 c0Var) {
        int l = this.f1273b.l() - 1;
        while (true) {
            if (l < 0) {
                break;
            } else if (c0Var == this.f1273b.m(l)) {
                this.f1273b.k(l);
                break;
            } else {
                l--;
            }
        }
        a remove = this.f1272a.remove(c0Var);
        if (remove != null) {
            a.c(remove);
        }
    }
}
