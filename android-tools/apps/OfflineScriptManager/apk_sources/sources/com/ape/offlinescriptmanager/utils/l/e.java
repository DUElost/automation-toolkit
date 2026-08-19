package com.ape.offlinescriptmanager.utils.l;
/* loaded from: classes.dex */
public class e extends Thread {

    /* renamed from: b  reason: collision with root package name */
    private int f2090b = 259200000;

    /* renamed from: c  reason: collision with root package name */
    private boolean f2091c = true;

    /* renamed from: d  reason: collision with root package name */
    private final a f2092d;

    /* loaded from: classes.dex */
    public interface a {
        void a();
    }

    public e(a aVar) {
        this.f2092d = aVar;
    }

    public void a(boolean z) {
        this.f2091c = z;
    }

    public void b(boolean z) {
    }

    public void c(int i) {
        this.f2090b = i;
    }

    public void d() {
        start();
    }

    @Override // java.lang.Thread, java.lang.Runnable
    public void run() {
        long currentTimeMillis = System.currentTimeMillis();
        b(false);
        while (this.f2091c) {
            com.ape.offlinescriptmanager.utils.g.L(1000L);
            if (System.currentTimeMillis() - currentTimeMillis >= this.f2090b) {
                b(true);
                this.f2092d.a();
                return;
            }
        }
    }
}
