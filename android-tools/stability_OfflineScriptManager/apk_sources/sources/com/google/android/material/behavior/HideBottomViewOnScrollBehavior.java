package com.google.android.material.behavior;

import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.animation.TimeInterpolator;
import android.content.Context;
import android.util.AttributeSet;
import android.view.View;
import android.view.ViewPropertyAnimator;
import androidx.coordinatorlayout.widget.CoordinatorLayout;
/* loaded from: classes.dex */
public class HideBottomViewOnScrollBehavior<V extends View> extends CoordinatorLayout.c<V> {

    /* renamed from: a  reason: collision with root package name */
    private int f2290a;

    /* renamed from: b  reason: collision with root package name */
    private int f2291b;

    /* renamed from: c  reason: collision with root package name */
    private ViewPropertyAnimator f2292c;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a extends AnimatorListenerAdapter {
        a() {
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            HideBottomViewOnScrollBehavior.this.f2292c = null;
        }
    }

    public HideBottomViewOnScrollBehavior() {
        this.f2290a = 0;
        this.f2291b = 2;
    }

    public HideBottomViewOnScrollBehavior(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.f2290a = 0;
        this.f2291b = 2;
    }

    private void E(V v, int i, long j, TimeInterpolator timeInterpolator) {
        this.f2292c = v.animate().translationY(i).setInterpolator(timeInterpolator).setDuration(j).setListener(new a());
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void F(V v) {
        ViewPropertyAnimator viewPropertyAnimator = this.f2292c;
        if (viewPropertyAnimator != null) {
            viewPropertyAnimator.cancel();
            v.clearAnimation();
        }
        this.f2291b = 1;
        E(v, this.f2290a, 175L, b.d.a.a.k.a.f1468b);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void G(V v) {
        ViewPropertyAnimator viewPropertyAnimator = this.f2292c;
        if (viewPropertyAnimator != null) {
            viewPropertyAnimator.cancel();
            v.clearAnimation();
        }
        this.f2291b = 2;
        E(v, 0, 225L, b.d.a.a.k.a.f1469c);
    }

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public boolean l(CoordinatorLayout coordinatorLayout, V v, int i) {
        this.f2290a = v.getMeasuredHeight();
        return super.l(coordinatorLayout, v, i);
    }

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public void r(CoordinatorLayout coordinatorLayout, V v, View view, int i, int i2, int i3, int i4) {
        int i5 = this.f2291b;
        if (i5 != 1 && i2 > 0) {
            F(v);
        } else if (i5 == 2 || i2 >= 0) {
        } else {
            G(v);
        }
    }

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public boolean y(CoordinatorLayout coordinatorLayout, V v, View view, View view2, int i) {
        return i == 2;
    }
}
