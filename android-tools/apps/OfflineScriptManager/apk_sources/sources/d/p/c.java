package d.p;

import java.util.concurrent.atomic.AtomicInteger;
/* loaded from: classes.dex */
public class c<T> implements d<T> {

    /* renamed from: a  reason: collision with root package name */
    private final f<T> f2666a;

    /* renamed from: b  reason: collision with root package name */
    private int f2667b;

    /* renamed from: c  reason: collision with root package name */
    private int f2668c;

    /* renamed from: d  reason: collision with root package name */
    private int f2669d;
    private final AtomicInteger e;

    public c(int i) {
        f<T> fVar = new f<>(i);
        this.f2666a = fVar;
        int b2 = fVar.b();
        this.f2669d = b2;
        this.f2668c = b2;
        this.f2667b = b2;
        this.e = new AtomicInteger(b2);
    }

    @Override // d.p.d
    public T a() {
        c();
        return this.f2666a.c();
    }

    @Override // d.p.d
    public void b(T t, boolean z) {
        this.f2666a.f(t);
        if (z) {
            return;
        }
        this.f2669d = this.f2666a.b();
    }

    @Override // d.p.d
    public boolean c() {
        int d2 = this.f2666a.d();
        if (d2 != this.f2668c) {
            return true;
        }
        if (!this.e.compareAndSet(d2, -1)) {
            this.f2668c = this.e.get();
        }
        int i = this.f2668c;
        return (d2 == i || i == -1) ? false : true;
    }

    @Override // d.p.d
    public T d() {
        if (c()) {
            return this.f2666a.e();
        }
        return null;
    }

    @Override // d.p.d
    public T e() {
        if (this.f2669d == this.f2666a.b()) {
            return null;
        }
        this.f2666a.g();
        return this.f2666a.a();
    }

    @Override // d.p.d
    public boolean flush() {
        int i = this.f2667b;
        int i2 = this.f2669d;
        if (i == i2) {
            return true;
        }
        if (this.e.compareAndSet(i, i2)) {
            this.f2667b = this.f2669d;
            return true;
        }
        this.e.set(this.f2669d);
        this.f2667b = this.f2669d;
        return false;
    }
}
