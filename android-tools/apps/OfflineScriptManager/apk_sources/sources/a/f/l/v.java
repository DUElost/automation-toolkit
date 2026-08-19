package a.f.l;

import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.animation.ValueAnimator;
import android.os.Build;
import android.view.View;
import android.view.animation.Interpolator;
import java.lang.ref.WeakReference;
/* loaded from: classes.dex */
public final class v {

    /* renamed from: a  reason: collision with root package name */
    private WeakReference<View> f204a;

    /* renamed from: b  reason: collision with root package name */
    Runnable f205b = null;

    /* renamed from: c  reason: collision with root package name */
    Runnable f206c = null;

    /* renamed from: d  reason: collision with root package name */
    int f207d = -1;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a extends AnimatorListenerAdapter {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ w f208a;

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ View f209b;

        a(v vVar, w wVar, View view) {
            this.f208a = wVar;
            this.f209b = view;
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationCancel(Animator animator) {
            this.f208a.c(this.f209b);
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            this.f208a.a(this.f209b);
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationStart(Animator animator) {
            this.f208a.b(this.f209b);
        }
    }

    /* loaded from: classes.dex */
    class b implements ValueAnimator.AnimatorUpdateListener {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ y f210a;

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ View f211b;

        b(v vVar, y yVar, View view) {
            this.f210a = yVar;
            this.f211b = view;
        }

        @Override // android.animation.ValueAnimator.AnimatorUpdateListener
        public void onAnimationUpdate(ValueAnimator valueAnimator) {
            this.f210a.a(this.f211b);
        }
    }

    /* loaded from: classes.dex */
    static class c implements w {

        /* renamed from: a  reason: collision with root package name */
        v f212a;

        /* renamed from: b  reason: collision with root package name */
        boolean f213b;

        c(v vVar) {
            this.f212a = vVar;
        }

        @Override // a.f.l.w
        public void a(View view) {
            int i = this.f212a.f207d;
            if (i > -1) {
                view.setLayerType(i, null);
                this.f212a.f207d = -1;
            }
            if (Build.VERSION.SDK_INT >= 16 || !this.f213b) {
                v vVar = this.f212a;
                Runnable runnable = vVar.f206c;
                if (runnable != null) {
                    vVar.f206c = null;
                    runnable.run();
                }
                Object tag = view.getTag(2113929216);
                w wVar = tag instanceof w ? (w) tag : null;
                if (wVar != null) {
                    wVar.a(view);
                }
                this.f213b = true;
            }
        }

        @Override // a.f.l.w
        public void b(View view) {
            this.f213b = false;
            if (this.f212a.f207d > -1) {
                view.setLayerType(2, null);
            }
            v vVar = this.f212a;
            Runnable runnable = vVar.f205b;
            if (runnable != null) {
                vVar.f205b = null;
                runnable.run();
            }
            Object tag = view.getTag(2113929216);
            w wVar = tag instanceof w ? (w) tag : null;
            if (wVar != null) {
                wVar.b(view);
            }
        }

        @Override // a.f.l.w
        public void c(View view) {
            Object tag = view.getTag(2113929216);
            w wVar = tag instanceof w ? (w) tag : null;
            if (wVar != null) {
                wVar.c(view);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public v(View view) {
        this.f204a = new WeakReference<>(view);
    }

    private void g(View view, w wVar) {
        if (wVar != null) {
            view.animate().setListener(new a(this, wVar, view));
        } else {
            view.animate().setListener(null);
        }
    }

    public v a(float f) {
        View view = this.f204a.get();
        if (view != null) {
            view.animate().alpha(f);
        }
        return this;
    }

    public void b() {
        View view = this.f204a.get();
        if (view != null) {
            view.animate().cancel();
        }
    }

    public long c() {
        View view = this.f204a.get();
        if (view != null) {
            return view.animate().getDuration();
        }
        return 0L;
    }

    public v d(long j) {
        View view = this.f204a.get();
        if (view != null) {
            view.animate().setDuration(j);
        }
        return this;
    }

    public v e(Interpolator interpolator) {
        View view = this.f204a.get();
        if (view != null) {
            view.animate().setInterpolator(interpolator);
        }
        return this;
    }

    public v f(w wVar) {
        View view = this.f204a.get();
        if (view != null) {
            if (Build.VERSION.SDK_INT < 16) {
                view.setTag(2113929216, wVar);
                wVar = new c(this);
            }
            g(view, wVar);
        }
        return this;
    }

    public v h(long j) {
        View view = this.f204a.get();
        if (view != null) {
            view.animate().setStartDelay(j);
        }
        return this;
    }

    public v i(y yVar) {
        View view = this.f204a.get();
        if (view != null && Build.VERSION.SDK_INT >= 19) {
            view.animate().setUpdateListener(yVar != null ? new b(this, yVar, view) : null);
        }
        return this;
    }

    public void j() {
        View view = this.f204a.get();
        if (view != null) {
            view.animate().start();
        }
    }

    public v k(float f) {
        View view = this.f204a.get();
        if (view != null) {
            view.animate().translationY(f);
        }
        return this;
    }
}
