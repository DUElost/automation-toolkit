package androidx.fragment.app;

import android.view.View;
import android.view.ViewTreeObserver;
/* loaded from: classes.dex */
class n implements ViewTreeObserver.OnPreDrawListener, View.OnAttachStateChangeListener {

    /* renamed from: b  reason: collision with root package name */
    private final View f1043b;

    /* renamed from: c  reason: collision with root package name */
    private ViewTreeObserver f1044c;

    /* renamed from: d  reason: collision with root package name */
    private final Runnable f1045d;

    private n(View view, Runnable runnable) {
        this.f1043b = view;
        this.f1044c = view.getViewTreeObserver();
        this.f1045d = runnable;
    }

    public static n a(View view, Runnable runnable) {
        n nVar = new n(view, runnable);
        view.getViewTreeObserver().addOnPreDrawListener(nVar);
        view.addOnAttachStateChangeListener(nVar);
        return nVar;
    }

    public void b() {
        (this.f1044c.isAlive() ? this.f1044c : this.f1043b.getViewTreeObserver()).removeOnPreDrawListener(this);
        this.f1043b.removeOnAttachStateChangeListener(this);
    }

    @Override // android.view.ViewTreeObserver.OnPreDrawListener
    public boolean onPreDraw() {
        b();
        this.f1045d.run();
        return true;
    }

    @Override // android.view.View.OnAttachStateChangeListener
    public void onViewAttachedToWindow(View view) {
        this.f1044c = view.getViewTreeObserver();
    }

    @Override // android.view.View.OnAttachStateChangeListener
    public void onViewDetachedFromWindow(View view) {
        b();
    }
}
