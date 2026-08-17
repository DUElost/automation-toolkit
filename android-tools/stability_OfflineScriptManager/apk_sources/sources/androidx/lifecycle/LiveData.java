package androidx.lifecycle;

import androidx.lifecycle.e;
/* loaded from: classes.dex */
public abstract class LiveData<T> {
    static final Object i = new Object();

    /* renamed from: a  reason: collision with root package name */
    final Object f1054a = new Object();

    /* renamed from: b  reason: collision with root package name */
    private a.b.a.b.b<m<? super T>, LiveData<T>.a> f1055b = new a.b.a.b.b<>();

    /* renamed from: c  reason: collision with root package name */
    int f1056c = 0;

    /* renamed from: d  reason: collision with root package name */
    private volatile Object f1057d;
    volatile Object e;
    private int f;
    private boolean g;
    private boolean h;

    /* loaded from: classes.dex */
    class LifecycleBoundObserver extends LiveData<T>.a implements d {
        final g e;

        LifecycleBoundObserver(g gVar, m<? super T> mVar) {
            super(mVar);
            this.e = gVar;
        }

        @Override // androidx.lifecycle.d
        public void d(g gVar, e.a aVar) {
            if (this.e.a().b() == e.b.DESTROYED) {
                LiveData.this.g(this.f1058a);
            } else {
                h(k());
            }
        }

        @Override // androidx.lifecycle.LiveData.a
        void i() {
            this.e.a().c(this);
        }

        @Override // androidx.lifecycle.LiveData.a
        boolean j(g gVar) {
            return this.e == gVar;
        }

        @Override // androidx.lifecycle.LiveData.a
        boolean k() {
            return this.e.a().b().a(e.b.STARTED);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public abstract class a {

        /* renamed from: a  reason: collision with root package name */
        final m<? super T> f1058a;

        /* renamed from: b  reason: collision with root package name */
        boolean f1059b;

        /* renamed from: c  reason: collision with root package name */
        int f1060c = -1;

        a(m<? super T> mVar) {
            this.f1058a = mVar;
        }

        void h(boolean z) {
            if (z == this.f1059b) {
                return;
            }
            this.f1059b = z;
            LiveData liveData = LiveData.this;
            int i = liveData.f1056c;
            boolean z2 = i == 0;
            liveData.f1056c = i + (z ? 1 : -1);
            if (z2 && z) {
                liveData.e();
            }
            LiveData liveData2 = LiveData.this;
            if (liveData2.f1056c == 0 && !this.f1059b) {
                liveData2.f();
            }
            if (this.f1059b) {
                LiveData.this.c(this);
            }
        }

        void i() {
        }

        boolean j(g gVar) {
            return false;
        }

        abstract boolean k();
    }

    public LiveData() {
        Object obj = i;
        this.f1057d = obj;
        this.e = obj;
        this.f = -1;
    }

    private static void a(String str) {
        if (a.b.a.a.a.b().a()) {
            return;
        }
        throw new IllegalStateException("Cannot invoke " + str + " on a background thread");
    }

    private void b(LiveData<T>.a aVar) {
        if (aVar.f1059b) {
            if (!aVar.k()) {
                aVar.h(false);
                return;
            }
            int i2 = aVar.f1060c;
            int i3 = this.f;
            if (i2 >= i3) {
                return;
            }
            aVar.f1060c = i3;
            aVar.f1058a.a((Object) this.f1057d);
        }
    }

    void c(LiveData<T>.a aVar) {
        if (this.g) {
            this.h = true;
            return;
        }
        this.g = true;
        do {
            this.h = false;
            if (aVar == null) {
                a.b.a.b.b<m<? super T>, LiveData<T>.a>.d d2 = this.f1055b.d();
                while (d2.hasNext()) {
                    b((a) d2.next().getValue());
                    if (this.h) {
                        break;
                    }
                }
            } else {
                b(aVar);
                aVar = null;
            }
        } while (this.h);
        this.g = false;
    }

    public void d(g gVar, m<? super T> mVar) {
        a("observe");
        if (gVar.a().b() == e.b.DESTROYED) {
            return;
        }
        LifecycleBoundObserver lifecycleBoundObserver = new LifecycleBoundObserver(gVar, mVar);
        LiveData<T>.a g = this.f1055b.g(mVar, lifecycleBoundObserver);
        if (g != null && !g.j(gVar)) {
            throw new IllegalArgumentException("Cannot add the same observer with different lifecycles");
        }
        if (g != null) {
            return;
        }
        gVar.a().a(lifecycleBoundObserver);
    }

    protected void e() {
    }

    protected void f() {
    }

    public void g(m<? super T> mVar) {
        a("removeObserver");
        LiveData<T>.a h = this.f1055b.h(mVar);
        if (h == null) {
            return;
        }
        h.i();
        h.h(false);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void h(T t) {
        a("setValue");
        this.f++;
        this.f1057d = t;
        c(null);
    }
}
