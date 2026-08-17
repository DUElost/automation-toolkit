package d.q;

import d.k;
import java.io.IOException;
import java.io.PrintStream;
import java.nio.channels.CancelledKeyException;
import java.nio.channels.ClosedChannelException;
import java.nio.channels.ClosedSelectorException;
import java.nio.channels.SelectableChannel;
import java.nio.channels.SelectionKey;
import java.nio.channels.Selector;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.atomic.AtomicBoolean;
/* loaded from: classes.dex */
public final class b extends c implements Runnable {
    private final d.c f;
    private final Set<a> g;
    private boolean h;
    private final AtomicBoolean i;
    private final CountDownLatch j;
    private Selector k;

    /* loaded from: classes.dex */
    public static final class a {

        /* renamed from: a  reason: collision with root package name */
        private final SelectableChannel f2680a;

        /* renamed from: b  reason: collision with root package name */
        private final d.q.a f2681b;

        /* renamed from: c  reason: collision with root package name */
        private int f2682c;

        /* renamed from: d  reason: collision with root package name */
        private boolean f2683d;

        public a(SelectableChannel selectableChannel, d.q.a aVar) {
            this.f2680a = selectableChannel;
            this.f2681b = aVar;
        }

        public boolean equals(Object obj) {
            if (this == obj) {
                return true;
            }
            if (obj != null && (obj instanceof a)) {
                a aVar = (a) obj;
                return this.f2680a.equals(aVar.f2680a) && this.f2681b.equals(aVar.f2681b);
            }
            return false;
        }

        public int hashCode() {
            return ((this.f2680a.hashCode() + 31) * 31) + this.f2681b.hashCode();
        }

        public String toString() {
            return "Handle-" + this.f2680a;
        }
    }

    public b(d.c cVar, String str) {
        super(str);
        this.h = false;
        this.i = new AtomicBoolean();
        this.j = new CountDownLatch(1);
        this.f = cVar;
        this.g = new HashSet();
        this.k = cVar.f();
    }

    private int j(int i, long j, long j2) {
        int i2 = (j == 0 || System.currentTimeMillis() - j2 < j / 2) ? i + 1 : 0;
        if (i2 > 10) {
            k();
            return 0;
        }
        return i2;
    }

    private void k() {
        PrintStream printStream = System.out;
        printStream.println(this + " rebuilding selector");
        Selector f = this.f.f();
        Selector selector = this.k;
        this.k = f;
        this.h = true;
        this.f.c(selector);
    }

    private void l(a aVar, int i, boolean z) {
        int i2;
        if (z) {
            i2 = i | aVar.f2682c;
        } else {
            i2 = (~i) & aVar.f2682c;
        }
        aVar.f2682c = i2;
        this.h = true;
    }

    public a h(SelectableChannel selectableChannel, d.q.a aVar) {
        a aVar2 = new a(selectableChannel, aVar);
        this.g.add(aVar2);
        b(1);
        return aVar2;
    }

    public void i() {
        try {
            try {
                u();
                this.j.await();
            } catch (InterruptedException e) {
                e.printStackTrace();
                Thread.currentThread().interrupt();
            }
        } finally {
            this.f.c(this.k);
        }
    }

    public void m(a aVar) {
        aVar.f2683d = true;
        this.h = true;
        b(-1);
    }

    public void n(a aVar) {
        l(aVar, 1, false);
    }

    public void o(a aVar) {
        l(aVar, 4, false);
    }

    public void p(a aVar) {
        l(aVar, 16, true);
    }

    public void q(a aVar) {
        l(aVar, 8, true);
    }

    public void r(a aVar) {
        l(aVar, 1, true);
    }

    @Override // java.lang.Runnable
    public void run() {
        int i = 0;
        while (!this.i.get()) {
            long f = f();
            if (this.h) {
                this.h = false;
                Iterator<a> it = this.g.iterator();
                while (it.hasNext()) {
                    a next = it.next();
                    SelectionKey keyFor = next.f2680a.keyFor(this.k);
                    if (next.f2683d || !next.f2680a.isOpen()) {
                        if (keyFor != null) {
                            keyFor.cancel();
                        }
                        it.remove();
                    } else if (keyFor == null) {
                        if (next.f2680a.isOpen()) {
                            try {
                                next.f2680a.register(this.k, next.f2682c, next);
                            } catch (CancelledKeyException | ClosedChannelException | ClosedSelectorException e) {
                                e.printStackTrace();
                            }
                        }
                    } else if (keyFor.isValid()) {
                        keyFor.interestOps(next.f2682c);
                    }
                }
            }
            long currentTimeMillis = System.currentTimeMillis();
            try {
                if (this.k.select(f) == 0) {
                    i = j(i, f, currentTimeMillis);
                } else {
                    Iterator<SelectionKey> it2 = this.k.selectedKeys().iterator();
                    while (it2.hasNext()) {
                        SelectionKey next2 = it2.next();
                        a aVar = (a) next2.attachment();
                        it2.remove();
                        if (!aVar.f2683d) {
                            try {
                                if (next2.isValid() && next2.isAcceptable()) {
                                    aVar.f2681b.b();
                                }
                                if (next2.isValid() && next2.isConnectable()) {
                                    aVar.f2681b.q();
                                }
                                if (next2.isValid() && next2.isWritable()) {
                                    aVar.f2681b.s();
                                }
                                if (next2.isValid() && next2.isReadable()) {
                                    aVar.f2681b.e();
                                }
                            } catch (CancelledKeyException e2) {
                                e2.printStackTrace();
                            } catch (RuntimeException e3) {
                                e3.printStackTrace();
                            }
                        }
                    }
                }
            } catch (IOException e4) {
                throw new k.b(e4);
            } catch (ClosedSelectorException e5) {
                k();
                e5.printStackTrace();
                this.f.j().c(4);
            }
        }
        this.j.countDown();
    }

    public void s(a aVar) {
        l(aVar, 4, true);
    }

    public void t() {
        this.f2686d.start();
    }

    public void u() {
        this.i.set(true);
        this.h = false;
        this.k.wakeup();
    }
}
