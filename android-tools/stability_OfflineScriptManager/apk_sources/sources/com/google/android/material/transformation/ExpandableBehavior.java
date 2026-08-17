package com.google.android.material.transformation;

import a.f.l.r;
import android.content.Context;
import android.util.AttributeSet;
import android.view.View;
import android.view.ViewTreeObserver;
import androidx.coordinatorlayout.widget.CoordinatorLayout;
import java.util.List;
/* loaded from: classes.dex */
public abstract class ExpandableBehavior extends CoordinatorLayout.c<View> {

    /* renamed from: a  reason: collision with root package name */
    private int f2437a;

    /* loaded from: classes.dex */
    class a implements ViewTreeObserver.OnPreDrawListener {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ View f2438b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ int f2439c;

        /* renamed from: d  reason: collision with root package name */
        final /* synthetic */ b.d.a.a.n.a f2440d;

        a(View view, int i, b.d.a.a.n.a aVar) {
            this.f2438b = view;
            this.f2439c = i;
            this.f2440d = aVar;
        }

        @Override // android.view.ViewTreeObserver.OnPreDrawListener
        public boolean onPreDraw() {
            this.f2438b.getViewTreeObserver().removeOnPreDrawListener(this);
            if (ExpandableBehavior.this.f2437a == this.f2439c) {
                ExpandableBehavior expandableBehavior = ExpandableBehavior.this;
                b.d.a.a.n.a aVar = this.f2440d;
                expandableBehavior.G((View) aVar, this.f2438b, aVar.a(), false);
            }
            return false;
        }
    }

    public ExpandableBehavior() {
        this.f2437a = 0;
    }

    public ExpandableBehavior(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.f2437a = 0;
    }

    private boolean E(boolean z) {
        if (!z) {
            return this.f2437a == 1;
        }
        int i = this.f2437a;
        return i == 0 || i == 2;
    }

    protected b.d.a.a.n.a F(CoordinatorLayout coordinatorLayout, View view) {
        List<View> q = coordinatorLayout.q(view);
        int size = q.size();
        for (int i = 0; i < size; i++) {
            View view2 = q.get(i);
            if (e(coordinatorLayout, view, view2)) {
                return (b.d.a.a.n.a) view2;
            }
        }
        return null;
    }

    protected abstract boolean G(View view, View view2, boolean z, boolean z2);

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public boolean h(CoordinatorLayout coordinatorLayout, View view, View view2) {
        b.d.a.a.n.a aVar = (b.d.a.a.n.a) view2;
        if (E(aVar.a())) {
            this.f2437a = aVar.a() ? 1 : 2;
            return G((View) aVar, view, aVar.a(), true);
        }
        return false;
    }

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public boolean l(CoordinatorLayout coordinatorLayout, View view, int i) {
        b.d.a.a.n.a F;
        if (r.E(view) || (F = F(coordinatorLayout, view)) == null || !E(F.a())) {
            return false;
        }
        int i2 = F.a() ? 1 : 2;
        this.f2437a = i2;
        view.getViewTreeObserver().addOnPreDrawListener(new a(view, i2, F));
        return false;
    }
}
