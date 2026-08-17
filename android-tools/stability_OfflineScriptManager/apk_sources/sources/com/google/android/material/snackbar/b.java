package com.google.android.material.snackbar;

import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import java.lang.ref.WeakReference;
/* loaded from: classes.dex */
class b {
    private static b e;

    /* renamed from: a  reason: collision with root package name */
    private final Object f2397a = new Object();

    /* renamed from: b  reason: collision with root package name */
    private final Handler f2398b = new Handler(Looper.getMainLooper(), new a());

    /* renamed from: c  reason: collision with root package name */
    private c f2399c;

    /* renamed from: d  reason: collision with root package name */
    private c f2400d;

    /* loaded from: classes.dex */
    class a implements Handler.Callback {
        a() {
        }

        @Override // android.os.Handler.Callback
        public boolean handleMessage(Message message) {
            if (message.what != 0) {
                return false;
            }
            b.this.d((c) message.obj);
            return true;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: com.google.android.material.snackbar.b$b  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public interface InterfaceC0099b {
        void a();

        void b(int i);
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class c {

        /* renamed from: a  reason: collision with root package name */
        final WeakReference<InterfaceC0099b> f2402a;

        /* renamed from: b  reason: collision with root package name */
        int f2403b;

        /* renamed from: c  reason: collision with root package name */
        boolean f2404c;

        c(int i, InterfaceC0099b interfaceC0099b) {
            this.f2402a = new WeakReference<>(interfaceC0099b);
            this.f2403b = i;
        }

        boolean a(InterfaceC0099b interfaceC0099b) {
            return interfaceC0099b != null && this.f2402a.get() == interfaceC0099b;
        }
    }

    private b() {
    }

    private boolean a(c cVar, int i) {
        InterfaceC0099b interfaceC0099b = cVar.f2402a.get();
        if (interfaceC0099b != null) {
            this.f2398b.removeCallbacksAndMessages(cVar);
            interfaceC0099b.b(i);
            return true;
        }
        return false;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static b c() {
        if (e == null) {
            e = new b();
        }
        return e;
    }

    private boolean f(InterfaceC0099b interfaceC0099b) {
        c cVar = this.f2399c;
        return cVar != null && cVar.a(interfaceC0099b);
    }

    private boolean g(InterfaceC0099b interfaceC0099b) {
        c cVar = this.f2400d;
        return cVar != null && cVar.a(interfaceC0099b);
    }

    private void l(c cVar) {
        int i = cVar.f2403b;
        if (i == -2) {
            return;
        }
        if (i <= 0) {
            i = i == -1 ? 1500 : 2750;
        }
        this.f2398b.removeCallbacksAndMessages(cVar);
        Handler handler = this.f2398b;
        handler.sendMessageDelayed(Message.obtain(handler, 0, cVar), i);
    }

    private void n() {
        c cVar = this.f2400d;
        if (cVar != null) {
            this.f2399c = cVar;
            this.f2400d = null;
            InterfaceC0099b interfaceC0099b = cVar.f2402a.get();
            if (interfaceC0099b != null) {
                interfaceC0099b.a();
            } else {
                this.f2399c = null;
            }
        }
    }

    public void b(InterfaceC0099b interfaceC0099b, int i) {
        c cVar;
        synchronized (this.f2397a) {
            if (f(interfaceC0099b)) {
                cVar = this.f2399c;
            } else if (g(interfaceC0099b)) {
                cVar = this.f2400d;
            }
            a(cVar, i);
        }
    }

    void d(c cVar) {
        synchronized (this.f2397a) {
            if (this.f2399c == cVar || this.f2400d == cVar) {
                a(cVar, 2);
            }
        }
    }

    public boolean e(InterfaceC0099b interfaceC0099b) {
        boolean z;
        synchronized (this.f2397a) {
            z = f(interfaceC0099b) || g(interfaceC0099b);
        }
        return z;
    }

    public void h(InterfaceC0099b interfaceC0099b) {
        synchronized (this.f2397a) {
            if (f(interfaceC0099b)) {
                this.f2399c = null;
                if (this.f2400d != null) {
                    n();
                }
            }
        }
    }

    public void i(InterfaceC0099b interfaceC0099b) {
        synchronized (this.f2397a) {
            if (f(interfaceC0099b)) {
                l(this.f2399c);
            }
        }
    }

    public void j(InterfaceC0099b interfaceC0099b) {
        synchronized (this.f2397a) {
            if (f(interfaceC0099b)) {
                c cVar = this.f2399c;
                if (!cVar.f2404c) {
                    cVar.f2404c = true;
                    this.f2398b.removeCallbacksAndMessages(cVar);
                }
            }
        }
    }

    public void k(InterfaceC0099b interfaceC0099b) {
        synchronized (this.f2397a) {
            if (f(interfaceC0099b)) {
                c cVar = this.f2399c;
                if (cVar.f2404c) {
                    cVar.f2404c = false;
                    l(cVar);
                }
            }
        }
    }

    public void m(int i, InterfaceC0099b interfaceC0099b) {
        synchronized (this.f2397a) {
            if (f(interfaceC0099b)) {
                c cVar = this.f2399c;
                cVar.f2403b = i;
                this.f2398b.removeCallbacksAndMessages(cVar);
                l(this.f2399c);
                return;
            }
            if (g(interfaceC0099b)) {
                this.f2400d.f2403b = i;
            } else {
                this.f2400d = new c(i, interfaceC0099b);
            }
            c cVar2 = this.f2399c;
            if (cVar2 == null || !a(cVar2, 4)) {
                this.f2399c = null;
                n();
            }
        }
    }
}
