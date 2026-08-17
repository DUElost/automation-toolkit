package d.q;

import d.s.d;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public abstract class c implements Runnable {

    /* renamed from: b  reason: collision with root package name */
    private final AtomicInteger f2684b = new AtomicInteger(0);

    /* renamed from: c  reason: collision with root package name */
    private final d<Long, a> f2685c = new d<>();

    /* renamed from: d  reason: collision with root package name */
    protected final Thread f2686d;
    private boolean e;

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static final class a {

        /* renamed from: a  reason: collision with root package name */
        private final d.q.a f2687a;

        /* renamed from: b  reason: collision with root package name */
        private final int f2688b;

        /* renamed from: c  reason: collision with root package name */
        private boolean f2689c;

        public a(d.q.a aVar, int i) {
            this.f2687a = aVar;
            this.f2688b = i;
        }

        public boolean equals(Object obj) {
            if (this == obj) {
                return true;
            }
            if (obj != null && (obj instanceof a)) {
                a aVar = (a) obj;
                return this.f2688b == aVar.f2688b && this.f2687a.equals(aVar.f2687a);
            }
            return false;
        }

        public int hashCode() {
            return ((this.f2688b + 31) * 31) + this.f2687a.hashCode();
        }

        public String toString() {
            return "TimerInfo [id=" + this.f2688b + ", sink=" + this.f2687a + "]";
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public c(String str) {
        this.f2686d = e(str);
    }

    public void a(long j, d.q.a aVar, int i) {
        long d2 = d() + j;
        this.f2685c.e(Long.valueOf(d2), new a(aVar, i));
        this.e = true;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void b(int i) {
        this.f2684b.addAndGet(i);
    }

    public void c(d.q.a aVar, int i) {
        this.f2685c.b(new a(aVar, i)).f2689c = true;
    }

    long d() {
        return d.s.b.a();
    }

    Thread e(String str) {
        Thread thread = new Thread(this, str);
        thread.setDaemon(true);
        return thread;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public long f() {
        Long value;
        d<Long, a> dVar;
        this.e = false;
        if (this.f2685c.f()) {
            return 0L;
        }
        long d2 = d();
        for (Map.Entry<a, Long> entry : this.f2685c.a()) {
            a key = entry.getKey();
            if (key.f2689c) {
                dVar = this.f2685c;
                value = entry.getValue();
            } else {
                value = entry.getValue();
                if (value.longValue() > d2) {
                    return value.longValue() - d2;
                }
                key.f2687a.h(key.f2688b);
                dVar = this.f2685c;
            }
            dVar.g(value, key);
        }
        if (this.e) {
            return f();
        }
        return 0L;
    }

    public int g() {
        return this.f2684b.get();
    }
}
