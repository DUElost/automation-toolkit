package com.aurelhubert.ahbottomnavigation;

import a.f.l.r;
import a.f.l.v;
import a.f.l.y;
import android.animation.ObjectAnimator;
import android.animation.ValueAnimator;
import android.content.Context;
import android.content.res.TypedArray;
import android.os.Build;
import android.util.AttributeSet;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Interpolator;
import androidx.coordinatorlayout.widget.CoordinatorLayout;
import com.aurelhubert.ahbottomnavigation.AHBottomNavigation;
import com.google.android.material.snackbar.Snackbar;
import com.google.android.material.tabs.TabLayout;
/* loaded from: classes.dex */
public class AHBottomNavigationBehavior<V extends View> extends VerticalScrollingBehavior<V> {
    private static final Interpolator p = new a.i.a.a.c();
    private int e;
    private boolean f;
    private v g;
    private ObjectAnimator h;
    private TabLayout i;
    private Snackbar.SnackbarLayout j;
    private int k;
    private float l;
    private float m;
    private boolean n;
    private AHBottomNavigation.f o;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a implements y {
        a() {
        }

        @Override // a.f.l.y
        public void a(View view) {
            if (AHBottomNavigationBehavior.this.o != null) {
                AHBottomNavigationBehavior.this.o.a((int) ((view.getMeasuredHeight() - view.getTranslationY()) + AHBottomNavigationBehavior.this.m));
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b implements ValueAnimator.AnimatorUpdateListener {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ View f2231a;

        b(View view) {
            this.f2231a = view;
        }

        @Override // android.animation.ValueAnimator.AnimatorUpdateListener
        public void onAnimationUpdate(ValueAnimator valueAnimator) {
            if (AHBottomNavigationBehavior.this.j != null && (AHBottomNavigationBehavior.this.j.getLayoutParams() instanceof ViewGroup.MarginLayoutParams)) {
                AHBottomNavigationBehavior.this.l = this.f2231a.getMeasuredHeight() - this.f2231a.getTranslationY();
                ViewGroup.MarginLayoutParams marginLayoutParams = (ViewGroup.MarginLayoutParams) AHBottomNavigationBehavior.this.j.getLayoutParams();
                marginLayoutParams.setMargins(marginLayoutParams.leftMargin, marginLayoutParams.topMargin, marginLayoutParams.rightMargin, (int) AHBottomNavigationBehavior.this.l);
                AHBottomNavigationBehavior.this.j.requestLayout();
            }
            if (AHBottomNavigationBehavior.this.o != null) {
                AHBottomNavigationBehavior.this.o.a((int) ((this.f2231a.getMeasuredHeight() - this.f2231a.getTranslationY()) + AHBottomNavigationBehavior.this.m));
            }
        }
    }

    public AHBottomNavigationBehavior() {
        this.f = false;
        this.k = -1;
        this.l = 0.0f;
        this.m = 0.0f;
        this.n = true;
    }

    public AHBottomNavigationBehavior(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.f = false;
        this.k = -1;
        this.l = 0.0f;
        this.m = 0.0f;
        this.n = true;
        TypedArray obtainStyledAttributes = context.obtainStyledAttributes(attributeSet, h.AHBottomNavigationBehavior_Params);
        this.e = obtainStyledAttributes.getResourceId(h.AHBottomNavigationBehavior_Params_tabLayoutId, -1);
        obtainStyledAttributes.recycle();
    }

    public AHBottomNavigationBehavior(boolean z, int i) {
        this.f = false;
        this.k = -1;
        this.l = 0.0f;
        this.m = 0.0f;
        this.n = true;
        this.n = z;
    }

    private void L(V v, int i, boolean z, boolean z2) {
        if (this.n || z) {
            if (Build.VERSION.SDK_INT < 19) {
                N(v, i, z2);
                this.h.start();
                return;
            }
            M(v, z2);
            v vVar = this.g;
            vVar.k(i);
            vVar.j();
        }
    }

    private void M(V v, boolean z) {
        v vVar = this.g;
        if (vVar != null) {
            vVar.d(z ? 300L : 0L);
            this.g.b();
            return;
        }
        v a2 = r.a(v);
        this.g = a2;
        a2.d(z ? 300L : 0L);
        this.g.i(new a());
        this.g.e(p);
    }

    private void N(V v, int i, boolean z) {
        ObjectAnimator objectAnimator = this.h;
        if (objectAnimator != null) {
            objectAnimator.cancel();
        }
        ObjectAnimator ofFloat = ObjectAnimator.ofFloat(v, View.TRANSLATION_Y, i);
        this.h = ofFloat;
        ofFloat.setDuration(z ? 300L : 0L);
        this.h.setInterpolator(p);
        this.h.addUpdateListener(new b(v));
    }

    private TabLayout O(View view) {
        int i = this.e;
        if (i == 0) {
            return null;
        }
        return (TabLayout) view.findViewById(i);
    }

    private void P(V v, int i) {
        if (this.n) {
            if (i == -1 && this.f) {
                this.f = false;
                L(v, 0, false, true);
            } else if (i != 1 || this.f) {
            } else {
                this.f = true;
                L(v, v.getHeight(), false, true);
            }
        }
    }

    @Override // com.aurelhubert.ahbottomnavigation.VerticalScrollingBehavior
    public void D(CoordinatorLayout coordinatorLayout, V v, View view, int i, int i2, int[] iArr, int i3) {
    }

    @Override // com.aurelhubert.ahbottomnavigation.VerticalScrollingBehavior
    protected boolean E(CoordinatorLayout coordinatorLayout, V v, View view, float f, float f2, int i) {
        return false;
    }

    @Override // com.aurelhubert.ahbottomnavigation.VerticalScrollingBehavior
    public void F(CoordinatorLayout coordinatorLayout, V v, int i, int i2, int i3) {
    }

    public void Q(V v, int i, boolean z) {
        if (this.f) {
            return;
        }
        this.f = true;
        L(v, i, true, z);
    }

    public void R(boolean z, int i) {
        this.n = z;
    }

    public void S(AHBottomNavigation.f fVar) {
        this.o = fVar;
    }

    public void T(View view, View view2) {
        if (view2 == null || !(view2 instanceof Snackbar.SnackbarLayout)) {
            return;
        }
        this.j = (Snackbar.SnackbarLayout) view2;
        if (this.k == -1) {
            this.k = view2.getHeight();
        }
        int measuredHeight = (int) (view.getMeasuredHeight() - view.getTranslationY());
        if (Build.VERSION.SDK_INT < 21) {
            view.bringToFront();
        }
        if (view2.getLayoutParams() instanceof ViewGroup.MarginLayoutParams) {
            ViewGroup.MarginLayoutParams marginLayoutParams = (ViewGroup.MarginLayoutParams) view2.getLayoutParams();
            marginLayoutParams.setMargins(marginLayoutParams.leftMargin, marginLayoutParams.topMargin, marginLayoutParams.rightMargin, measuredHeight);
            view2.requestLayout();
        }
    }

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public boolean e(CoordinatorLayout coordinatorLayout, V v, View view) {
        if (view == null || !(view instanceof Snackbar.SnackbarLayout)) {
            return super.e(coordinatorLayout, v, view);
        }
        T(v, view);
        return true;
    }

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public boolean h(CoordinatorLayout coordinatorLayout, V v, View view) {
        return super.h(coordinatorLayout, v, view);
    }

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public void i(CoordinatorLayout coordinatorLayout, V v, View view) {
        super.i(coordinatorLayout, v, view);
    }

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public boolean l(CoordinatorLayout coordinatorLayout, V v, int i) {
        boolean l = super.l(coordinatorLayout, v, i);
        if (this.i == null && this.e != -1) {
            this.i = O(v);
        }
        return l;
    }

    @Override // com.aurelhubert.ahbottomnavigation.VerticalScrollingBehavior, androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public void r(CoordinatorLayout coordinatorLayout, V v, View view, int i, int i2, int i3, int i4) {
        int i5;
        super.r(coordinatorLayout, v, view, i, i2, i3, i4);
        if (i2 < 0) {
            i5 = -1;
        } else if (i2 <= 0) {
            return;
        } else {
            i5 = 1;
        }
        P(v, i5);
    }

    @Override // com.aurelhubert.ahbottomnavigation.VerticalScrollingBehavior, androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public boolean y(CoordinatorLayout coordinatorLayout, V v, View view, View view2, int i) {
        return i == 2 || super.y(coordinatorLayout, v, view, view2, i);
    }
}
