package com.aurelhubert.ahbottomnavigation;

import a.f.l.z;
import android.content.Context;
import android.os.Parcelable;
import android.util.AttributeSet;
import android.view.View;
import androidx.coordinatorlayout.widget.CoordinatorLayout;
/* loaded from: classes.dex */
public abstract class VerticalScrollingBehavior<V extends View> extends CoordinatorLayout.c<V> {

    /* renamed from: a  reason: collision with root package name */
    private int f2234a;

    /* renamed from: b  reason: collision with root package name */
    private int f2235b;

    /* renamed from: c  reason: collision with root package name */
    private int f2236c;

    /* renamed from: d  reason: collision with root package name */
    private int f2237d;

    public VerticalScrollingBehavior() {
        this.f2234a = 0;
        this.f2235b = 0;
        this.f2236c = 0;
        this.f2237d = 0;
    }

    public VerticalScrollingBehavior(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.f2234a = 0;
        this.f2235b = 0;
        this.f2236c = 0;
        this.f2237d = 0;
    }

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public void A(CoordinatorLayout coordinatorLayout, V v, View view) {
        super.A(coordinatorLayout, v, view);
    }

    public abstract void D(CoordinatorLayout coordinatorLayout, V v, View view, int i, int i2, int[] iArr, int i3);

    protected abstract boolean E(CoordinatorLayout coordinatorLayout, V v, View view, float f, float f2, int i);

    public abstract void F(CoordinatorLayout coordinatorLayout, V v, int i, int i2, int i3);

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public z f(CoordinatorLayout coordinatorLayout, V v, z zVar) {
        super.f(coordinatorLayout, v, zVar);
        return zVar;
    }

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public boolean n(CoordinatorLayout coordinatorLayout, V v, View view, float f, float f2, boolean z) {
        super.n(coordinatorLayout, v, view, f, f2, z);
        int i = f2 > 0.0f ? 1 : -1;
        this.f2237d = i;
        return E(coordinatorLayout, v, view, f, f2, i);
    }

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public boolean o(CoordinatorLayout coordinatorLayout, V v, View view, float f, float f2) {
        return super.o(coordinatorLayout, v, view, f, f2);
    }

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public void p(CoordinatorLayout coordinatorLayout, V v, View view, int i, int i2, int[] iArr) {
        int i3;
        super.p(coordinatorLayout, v, view, i, i2, iArr);
        if (i2 <= 0 || this.f2235b >= 0) {
            if (i2 < 0 && this.f2235b > 0) {
                this.f2235b = 0;
                i3 = -1;
            }
            this.f2235b += i2;
            D(coordinatorLayout, v, view, i, i2, iArr, this.f2237d);
        }
        this.f2235b = 0;
        i3 = 1;
        this.f2237d = i3;
        this.f2235b += i2;
        D(coordinatorLayout, v, view, i, i2, iArr, this.f2237d);
    }

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public void r(CoordinatorLayout coordinatorLayout, V v, View view, int i, int i2, int i3, int i4) {
        int i5;
        super.r(coordinatorLayout, v, view, i, i2, i3, i4);
        if (i4 <= 0 || this.f2234a >= 0) {
            if (i4 < 0 && this.f2234a > 0) {
                this.f2234a = 0;
                i5 = -1;
            }
            int i6 = this.f2234a + i4;
            this.f2234a = i6;
            F(coordinatorLayout, v, this.f2236c, i2, i6);
        }
        this.f2234a = 0;
        i5 = 1;
        this.f2236c = i5;
        int i62 = this.f2234a + i4;
        this.f2234a = i62;
        F(coordinatorLayout, v, this.f2236c, i2, i62);
    }

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public void t(CoordinatorLayout coordinatorLayout, V v, View view, View view2, int i) {
        super.t(coordinatorLayout, v, view, view2, i);
    }

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public Parcelable x(CoordinatorLayout coordinatorLayout, V v) {
        return super.x(coordinatorLayout, v);
    }

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public boolean y(CoordinatorLayout coordinatorLayout, V v, View view, View view2, int i) {
        return (i & 2) != 0;
    }
}
