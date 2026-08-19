package life.knowledge4.videotrimmer.h;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Executor;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicBoolean;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public final class a {

    /* renamed from: a  reason: collision with root package name */
    public static final Executor f2737a;

    /* renamed from: b  reason: collision with root package name */
    private static Executor f2738b;

    /* renamed from: c  reason: collision with root package name */
    private static final List<AbstractRunnableC0119a> f2739c;

    /* renamed from: d  reason: collision with root package name */
    private static final ThreadLocal<String> f2740d;

    /* renamed from: life.knowledge4.videotrimmer.h.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public static abstract class AbstractRunnableC0119a implements Runnable {

        /* renamed from: b  reason: collision with root package name */
        private String f2741b;

        /* renamed from: c  reason: collision with root package name */
        private long f2742c;

        /* renamed from: d  reason: collision with root package name */
        private long f2743d;
        private String e;
        private boolean f;
        private Future<?> g;
        private AtomicBoolean h = new AtomicBoolean();

        public AbstractRunnableC0119a(String str, long j, String str2) {
            if (!BuildConfig.FLAVOR.equals(str)) {
                this.f2741b = str;
            }
            if (j > 0) {
                this.f2742c = j;
                this.f2743d = System.currentTimeMillis() + j;
            }
            if (BuildConfig.FLAVOR.equals(str2)) {
                return;
            }
            this.e = str2;
        }

        private void i() {
            AbstractRunnableC0119a g;
            if (this.f2741b == null && this.e == null) {
                return;
            }
            a.f2740d.set(null);
            synchronized (a.class) {
                a.f2739c.remove(this);
                String str = this.e;
                if (str != null && (g = a.g(str)) != null) {
                    if (g.f2742c != 0) {
                        g.f2742c = Math.max(0L, this.f2743d - System.currentTimeMillis());
                    }
                    a.e(g);
                }
            }
        }

        public abstract void h();

        @Override // java.lang.Runnable
        public void run() {
            if (this.h.getAndSet(true)) {
                return;
            }
            try {
                a.f2740d.set(this.e);
                h();
            } finally {
                i();
            }
        }
    }

    static {
        ScheduledExecutorService newScheduledThreadPool = Executors.newScheduledThreadPool(Runtime.getRuntime().availableProcessors() * 2);
        f2737a = newScheduledThreadPool;
        f2738b = newScheduledThreadPool;
        f2739c = new ArrayList();
        f2740d = new ThreadLocal<>();
    }

    private a() {
    }

    private static Future<?> d(Runnable runnable, long j) {
        if (j > 0) {
            Executor executor = f2738b;
            if (executor instanceof ScheduledExecutorService) {
                return ((ScheduledExecutorService) executor).schedule(runnable, j, TimeUnit.MILLISECONDS);
            }
            throw new IllegalArgumentException("The executor set does not support scheduling");
        }
        Executor executor2 = f2738b;
        if (executor2 instanceof ExecutorService) {
            return ((ExecutorService) executor2).submit(runnable);
        }
        executor2.execute(runnable);
        return null;
    }

    public static synchronized void e(AbstractRunnableC0119a abstractRunnableC0119a) {
        synchronized (a.class) {
            Future<?> future = null;
            if (abstractRunnableC0119a.e == null || !f(abstractRunnableC0119a.e)) {
                abstractRunnableC0119a.f = true;
                future = d(abstractRunnableC0119a, abstractRunnableC0119a.f2742c);
            }
            if ((abstractRunnableC0119a.f2741b != null || abstractRunnableC0119a.e != null) && !abstractRunnableC0119a.h.get()) {
                abstractRunnableC0119a.g = future;
                f2739c.add(abstractRunnableC0119a);
            }
        }
    }

    private static boolean f(String str) {
        for (AbstractRunnableC0119a abstractRunnableC0119a : f2739c) {
            if (abstractRunnableC0119a.f && str.equals(abstractRunnableC0119a.e)) {
                return true;
            }
        }
        return false;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static AbstractRunnableC0119a g(String str) {
        int size = f2739c.size();
        for (int i = 0; i < size; i++) {
            List<AbstractRunnableC0119a> list = f2739c;
            if (str.equals(list.get(i).e)) {
                return list.remove(i);
            }
        }
        return null;
    }
}
