package d;

import d.k;
import java.io.Closeable;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.channels.ClosedChannelException;
import java.nio.channels.ClosedSelectorException;
import java.nio.channels.Pipe;
import java.nio.channels.SelectableChannel;
import java.nio.channels.Selector;
import java.util.concurrent.atomic.AtomicInteger;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public final class i implements Closeable {

    /* renamed from: b  reason: collision with root package name */
    private final Pipe.SinkChannel f2551b;

    /* renamed from: c  reason: collision with root package name */
    private final Pipe.SourceChannel f2552c;

    /* renamed from: d  reason: collision with root package name */
    private final Selector f2553d;
    private final ByteBuffer e = ByteBuffer.allocate(1);
    private final ByteBuffer f = ByteBuffer.allocate(1);
    private final AtomicInteger g = new AtomicInteger(0);
    private int h = 0;
    private final d.s.c i;
    private final int j;
    private final c k;

    /* JADX INFO: Access modifiers changed from: package-private */
    public i(c cVar, int i, d.s.c cVar2) {
        this.k = cVar;
        this.j = i;
        this.i = cVar2;
        try {
            Pipe open = Pipe.open();
            Pipe.SourceChannel source = open.source();
            this.f2552c = source;
            Pipe.SinkChannel sink = open.sink();
            this.f2551b = sink;
            d.s.e.f(sink, source);
            Selector f = cVar.f();
            this.f2553d = f;
            source.register(f, 1);
        } catch (IOException e) {
            throw new k.b(e);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public SelectableChannel a() {
        return this.f2552c;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void b() {
        int i = 0;
        while (i == 0) {
            try {
                this.f.clear();
                i = this.f2552c.read(this.f);
            } catch (ClosedChannelException e) {
                e.printStackTrace();
                this.i.c(4);
                return;
            } catch (IOException e2) {
                throw new k.b(e2);
            }
        }
        this.h++;
    }

    @Override // java.io.Closeable, java.lang.AutoCloseable
    public void close() {
        try {
            this.f2552c.close();
            e = null;
        } catch (IOException e) {
            e = e;
            e.printStackTrace();
        }
        try {
            this.f2551b.close();
        } catch (IOException e2) {
            e = e2;
            e.printStackTrace();
        }
        this.k.c(this.f2553d);
        if (e != null) {
            throw e;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void e() {
        do {
            try {
                this.e.clear();
            } catch (IOException e) {
                e.printStackTrace();
                throw new k.b(e);
            }
        } while (this.f2551b.write(this.e) == 0);
        this.g.incrementAndGet();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean h(long j) {
        if (this.h < this.g.get()) {
            return true;
        }
        int i = (j > 0L ? 1 : (j == 0L ? 0 : -1));
        try {
            if (i == 0) {
                this.i.c(35);
                return false;
            }
            if ((i < 0 ? this.f2553d.select(0L) : this.f2553d.select(j)) == 0) {
                this.i.c(35);
                return false;
            }
            this.f2553d.selectedKeys().clear();
            return true;
        } catch (IOException e) {
            e = e;
            e.printStackTrace();
            this.i.c(4);
            return false;
        } catch (ClosedSelectorException e2) {
            e = e2;
            e.printStackTrace();
            this.i.c(4);
            return false;
        }
    }

    public String toString() {
        return "Signaler[" + this.j + "]";
    }
}
