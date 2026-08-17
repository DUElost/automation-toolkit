package d;

import java.io.Closeable;
import java.nio.channels.SelectableChannel;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
/* loaded from: classes.dex */
public final class d implements Closeable {

    /* renamed from: b  reason: collision with root package name */
    private final d.p.c<a> f2537b;

    /* renamed from: c  reason: collision with root package name */
    private final i f2538c;

    /* renamed from: d  reason: collision with root package name */
    private final Lock f2539d;
    private boolean e;
    private final String f;
    private final d.s.c g;

    public d(c cVar, String str, int i) {
        d.s.c j = cVar.j();
        this.g = j;
        d.p.c<a> cVar2 = new d.p.c<>(b.COMMAND_PIPE_GRANULARITY.a());
        this.f2537b = cVar2;
        this.f2539d = new ReentrantLock();
        this.f2538c = new i(cVar, i, j);
        cVar2.d();
        this.e = false;
        this.f = str;
    }

    public SelectableChannel a() {
        return this.f2538c.a();
    }

    public a b(long j) {
        if (this.e) {
            a d2 = this.f2537b.d();
            if (d2 != null) {
                return d2;
            }
            this.e = false;
        }
        if (this.f2538c.h(j)) {
            this.f2538c.b();
            this.e = true;
            return this.f2537b.d();
        }
        return null;
    }

    @Override // java.io.Closeable, java.lang.AutoCloseable
    public void close() {
        this.f2539d.lock();
        this.f2539d.unlock();
        this.f2538c.close();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void e(a aVar) {
        this.f2539d.lock();
        try {
            this.f2537b.b(aVar, false);
            if (this.f2537b.flush()) {
                return;
            }
            this.f2538c.e();
        } finally {
            this.f2539d.unlock();
        }
    }

    public String toString() {
        return String.valueOf(super.toString()) + "[" + this.f + "]";
    }
}
