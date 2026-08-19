package a.f.i;

import android.os.Handler;
import android.os.HandlerThread;
import android.os.Message;
import java.util.concurrent.Callable;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicReference;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;
/* loaded from: classes.dex */
public class c {

    /* renamed from: b  reason: collision with root package name */
    private HandlerThread f143b;

    /* renamed from: c  reason: collision with root package name */
    private Handler f144c;
    private final int f;
    private final int g;
    private final String h;

    /* renamed from: a  reason: collision with root package name */
    private final Object f142a = new Object();
    private Handler.Callback e = new a();

    /* renamed from: d  reason: collision with root package name */
    private int f145d = 0;

    /* loaded from: classes.dex */
    class a implements Handler.Callback {
        a() {
        }

        @Override // android.os.Handler.Callback
        public boolean handleMessage(Message message) {
            int i = message.what;
            if (i == 0) {
                c.this.a();
                return true;
            } else if (i != 1) {
                return true;
            } else {
                c.this.b((Runnable) message.obj);
                return true;
            }
        }
    }

    /* loaded from: classes.dex */
    class b implements Runnable {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ Callable f147b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ Handler f148c;

        /* renamed from: d  reason: collision with root package name */
        final /* synthetic */ d f149d;

        /* loaded from: classes.dex */
        class a implements Runnable {

            /* renamed from: b  reason: collision with root package name */
            final /* synthetic */ Object f150b;

            a(Object obj) {
                this.f150b = obj;
            }

            @Override // java.lang.Runnable
            public void run() {
                b.this.f149d.a(this.f150b);
            }
        }

        b(c cVar, Callable callable, Handler handler, d dVar) {
            this.f147b = callable;
            this.f148c = handler;
            this.f149d = dVar;
        }

        @Override // java.lang.Runnable
        public void run() {
            Object obj;
            try {
                obj = this.f147b.call();
            } catch (Exception unused) {
                obj = null;
            }
            this.f148c.post(new a(obj));
        }
    }

    /* renamed from: a.f.i.c$c  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    class RunnableC0007c implements Runnable {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ AtomicReference f152b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ Callable f153c;

        /* renamed from: d  reason: collision with root package name */
        final /* synthetic */ ReentrantLock f154d;
        final /* synthetic */ AtomicBoolean e;
        final /* synthetic */ Condition f;

        RunnableC0007c(c cVar, AtomicReference atomicReference, Callable callable, ReentrantLock reentrantLock, AtomicBoolean atomicBoolean, Condition condition) {
            this.f152b = atomicReference;
            this.f153c = callable;
            this.f154d = reentrantLock;
            this.e = atomicBoolean;
            this.f = condition;
        }

        @Override // java.lang.Runnable
        public void run() {
            try {
                this.f152b.set(this.f153c.call());
            } catch (Exception unused) {
            }
            this.f154d.lock();
            try {
                this.e.set(false);
                this.f.signal();
            } finally {
                this.f154d.unlock();
            }
        }
    }

    /* loaded from: classes.dex */
    public interface d<T> {
        void a(T t);
    }

    public c(String str, int i, int i2) {
        this.h = str;
        this.g = i;
        this.f = i2;
    }

    private void c(Runnable runnable) {
        synchronized (this.f142a) {
            if (this.f143b == null) {
                HandlerThread handlerThread = new HandlerThread(this.h, this.g);
                this.f143b = handlerThread;
                handlerThread.start();
                this.f144c = new Handler(this.f143b.getLooper(), this.e);
                this.f145d++;
            }
            this.f144c.removeMessages(0);
            Handler handler = this.f144c;
            handler.sendMessage(handler.obtainMessage(1, runnable));
        }
    }

    void a() {
        synchronized (this.f142a) {
            if (this.f144c.hasMessages(1)) {
                return;
            }
            this.f143b.quit();
            this.f143b = null;
            this.f144c = null;
        }
    }

    void b(Runnable runnable) {
        runnable.run();
        synchronized (this.f142a) {
            this.f144c.removeMessages(0);
            Handler handler = this.f144c;
            handler.sendMessageDelayed(handler.obtainMessage(0), this.f);
        }
    }

    public <T> void d(Callable<T> callable, d<T> dVar) {
        c(new b(this, callable, new Handler(), dVar));
    }

    public <T> T e(Callable<T> callable, int i) {
        ReentrantLock reentrantLock = new ReentrantLock();
        Condition newCondition = reentrantLock.newCondition();
        AtomicReference atomicReference = new AtomicReference();
        AtomicBoolean atomicBoolean = new AtomicBoolean(true);
        c(new RunnableC0007c(this, atomicReference, callable, reentrantLock, atomicBoolean, newCondition));
        reentrantLock.lock();
        try {
            if (atomicBoolean.get()) {
                long nanos = TimeUnit.MILLISECONDS.toNanos(i);
                do {
                    try {
                        nanos = newCondition.awaitNanos(nanos);
                    } catch (InterruptedException unused) {
                    }
                    if (!atomicBoolean.get()) {
                        return (T) atomicReference.get();
                    }
                } while (nanos > 0);
                throw new InterruptedException("timeout");
            }
            return (T) atomicReference.get();
        } finally {
            reentrantLock.unlock();
        }
    }
}
