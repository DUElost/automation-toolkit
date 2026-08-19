package d.p;
/* loaded from: classes.dex */
class f<T> {

    /* renamed from: a  reason: collision with root package name */
    private a<T> f2672a;

    /* renamed from: b  reason: collision with root package name */
    private int f2673b;

    /* renamed from: c  reason: collision with root package name */
    private a<T> f2674c;

    /* renamed from: d  reason: collision with root package name */
    private int f2675d;
    private a<T> e;
    private int f;
    private volatile a<T> g;
    private final int h;
    private int i = 0;

    /* loaded from: classes.dex */
    private static class a<T> {

        /* renamed from: a  reason: collision with root package name */
        final T[] f2676a;

        /* renamed from: b  reason: collision with root package name */
        final int[] f2677b;

        /* renamed from: c  reason: collision with root package name */
        a<T> f2678c;

        /* renamed from: d  reason: collision with root package name */
        a<T> f2679d;

        public a(int i, int i2) {
            this.f2676a = (T[]) new Object[i];
            this.f2677b = new int[i];
            for (int i3 = 0; i3 != this.f2676a.length; i3++) {
                this.f2677b[i3] = i2;
                i2++;
            }
        }
    }

    public f(int i) {
        this.h = i;
        a<T> aVar = new a<>(i, 0);
        this.f2672a = aVar;
        this.i += i;
        this.f2673b = 0;
        this.f2675d = 0;
        this.f2674c = aVar;
        this.g = aVar;
        this.e = this.f2672a;
        this.f = 1;
    }

    public T a() {
        return this.f2674c.f2676a[this.f2675d];
    }

    public int b() {
        return this.f2674c.f2677b[this.f2675d];
    }

    public T c() {
        return this.f2672a.f2676a[this.f2673b];
    }

    public int d() {
        return this.f2672a.f2677b[this.f2673b];
    }

    public T e() {
        a<T> aVar = this.f2672a;
        T[] tArr = aVar.f2676a;
        int i = this.f2673b;
        T t = tArr[i];
        tArr[i] = null;
        int i2 = i + 1;
        this.f2673b = i2;
        if (i2 == this.h) {
            a<T> aVar2 = aVar.f2679d;
            this.f2672a = aVar2;
            aVar2.f2678c = null;
            this.f2673b = 0;
        }
        return t;
    }

    public void f(T t) {
        this.f2674c.f2676a[this.f2675d] = t;
        this.f2674c = this.e;
        int i = this.f;
        this.f2675d = i;
        int i2 = i + 1;
        this.f = i2;
        if (i2 != this.h) {
            return;
        }
        a<T> aVar = this.g;
        if (aVar != this.f2672a) {
            this.g = this.g.f2679d;
            a<T> aVar2 = this.e;
            aVar2.f2679d = aVar;
            aVar.f2678c = aVar2;
        } else {
            this.e.f2679d = new a<>(this.h, this.i);
            this.i += this.h;
            a<T> aVar3 = this.e;
            aVar3.f2679d.f2678c = aVar3;
        }
        this.e = this.e.f2679d;
        this.f = 0;
    }

    public void g() {
        int i = this.f2675d;
        if (i > 0) {
            this.f2675d = i - 1;
        } else {
            this.f2675d = this.h - 1;
            this.f2674c = this.f2674c.f2678c;
        }
        int i2 = this.f;
        if (i2 > 0) {
            this.f = i2 - 1;
            return;
        }
        this.f = this.h - 1;
        a<T> aVar = this.e.f2678c;
        this.e = aVar;
        aVar.f2679d = null;
    }
}
