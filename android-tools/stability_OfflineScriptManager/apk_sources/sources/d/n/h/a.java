package d.n.h;

import d.n.h.e;
/* loaded from: classes.dex */
public abstract class a extends d.n.h.b {
    protected final long h;
    protected d.e i;
    protected final e.a j;
    protected final e.a k;
    protected final e.a l;
    protected final e.a m;
    private final d.o.a n;

    /* renamed from: d.n.h.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    private final class C0106a implements e.a {
        private C0106a() {
        }

        /* synthetic */ C0106a(a aVar, C0106a c0106a) {
            this();
        }

        @Override // d.n.h.e.a
        public e.a.EnumC0107a a() {
            return a.this.i();
        }
    }

    /* loaded from: classes.dex */
    private final class b implements e.a {
        private b() {
        }

        /* synthetic */ b(a aVar, b bVar) {
            this();
        }

        @Override // d.n.h.e.a
        public e.a.EnumC0107a a() {
            return a.this.j();
        }
    }

    /* loaded from: classes.dex */
    private final class c implements e.a {
        private c() {
        }

        /* synthetic */ c(a aVar, c cVar) {
            this();
        }

        @Override // d.n.h.e.a
        public e.a.EnumC0107a a() {
            return a.this.k();
        }
    }

    /* loaded from: classes.dex */
    private final class d implements e.a {
        private d() {
        }

        /* synthetic */ d(a aVar, d dVar) {
            this();
        }

        @Override // d.n.h.e.a
        public e.a.EnumC0107a a() {
            return a.this.l();
        }
    }

    public a(d.s.c cVar, int i, long j, d.o.a aVar) {
        super(cVar, i);
        this.j = new d(this, null);
        this.k = new C0106a(this, null);
        this.l = new b(this, null);
        this.m = new c(this, null);
        this.h = j;
        this.n = aVar;
    }

    @Override // d.n.h.e
    public d.e b() {
        return this.i;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public d.e h(int i) {
        return this.n.a(i);
    }

    protected abstract e.a.EnumC0107a i();

    protected abstract e.a.EnumC0107a j();

    protected abstract e.a.EnumC0107a k();

    protected abstract e.a.EnumC0107a l();

    /* JADX INFO: Access modifiers changed from: protected */
    public final e.a.EnumC0107a m(long j) {
        long j2 = this.h;
        if (j2 >= 0 && j > j2) {
            e(156384722);
            return e.a.EnumC0107a.ERROR;
        } else if (j > 2147483647L) {
            e(156384722);
            return e.a.EnumC0107a.ERROR;
        } else {
            this.i = h((int) j);
            return e.a.EnumC0107a.MORE_DATA;
        }
    }
}
