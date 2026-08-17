package com.google.android.material.appbar;

import a.f.l.r;
import a.f.l.z;
import android.content.Context;
import android.graphics.Rect;
import android.util.AttributeSet;
import android.view.View;
import android.view.ViewGroup;
import androidx.coordinatorlayout.widget.CoordinatorLayout;
import java.util.List;
/* loaded from: classes.dex */
abstract class b extends c<View> {

    /* renamed from: d  reason: collision with root package name */
    final Rect f2281d;
    final Rect e;
    private int f;
    private int g;

    public b() {
        this.f2281d = new Rect();
        this.e = new Rect();
        this.f = 0;
    }

    public b(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.f2281d = new Rect();
        this.e = new Rect();
        this.f = 0;
    }

    private static int M(int i) {
        if (i == 0) {
            return 8388659;
        }
        return i;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // com.google.android.material.appbar.c
    public void E(CoordinatorLayout coordinatorLayout, View view, int i) {
        int i2;
        View G = G(coordinatorLayout.q(view));
        if (G != null) {
            CoordinatorLayout.f fVar = (CoordinatorLayout.f) view.getLayoutParams();
            Rect rect = this.f2281d;
            rect.set(coordinatorLayout.getPaddingLeft() + ((ViewGroup.MarginLayoutParams) fVar).leftMargin, G.getBottom() + ((ViewGroup.MarginLayoutParams) fVar).topMargin, (coordinatorLayout.getWidth() - coordinatorLayout.getPaddingRight()) - ((ViewGroup.MarginLayoutParams) fVar).rightMargin, ((coordinatorLayout.getHeight() + G.getBottom()) - coordinatorLayout.getPaddingBottom()) - ((ViewGroup.MarginLayoutParams) fVar).bottomMargin);
            z lastWindowInsets = coordinatorLayout.getLastWindowInsets();
            if (lastWindowInsets != null && r.n(coordinatorLayout) && !r.n(view)) {
                rect.left += lastWindowInsets.b();
                rect.right -= lastWindowInsets.c();
            }
            Rect rect2 = this.e;
            a.f.l.c.a(M(fVar.f821c), view.getMeasuredWidth(), view.getMeasuredHeight(), rect, rect2, i);
            int H = H(G);
            view.layout(rect2.left, rect2.top - H, rect2.right, rect2.bottom - H);
            i2 = rect2.top - G.getBottom();
        } else {
            super.E(coordinatorLayout, view, i);
            i2 = 0;
        }
        this.f = i2;
    }

    abstract View G(List<View> list);

    /* JADX INFO: Access modifiers changed from: package-private */
    public final int H(View view) {
        if (this.g == 0) {
            return 0;
        }
        float I = I(view);
        int i = this.g;
        return a.f.g.a.a((int) (I * i), 0, i);
    }

    abstract float I(View view);

    public final int J() {
        return this.g;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int K(View view) {
        return view.getMeasuredHeight();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final int L() {
        return this.f;
    }

    public final void N(int i) {
        this.g = i;
    }

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public boolean m(CoordinatorLayout coordinatorLayout, View view, int i, int i2, int i3, int i4) {
        View G;
        int i5 = view.getLayoutParams().height;
        if ((i5 == -1 || i5 == -2) && (G = G(coordinatorLayout.q(view))) != null) {
            if (r.n(G) && !r.n(view)) {
                r.W(view, true);
                if (r.n(view)) {
                    view.requestLayout();
                    return true;
                }
            }
            int size = View.MeasureSpec.getSize(i3);
            if (size == 0) {
                size = coordinatorLayout.getHeight();
            }
            coordinatorLayout.I(view, i, i2, View.MeasureSpec.makeMeasureSpec((size - G.getMeasuredHeight()) + K(G), i5 == -1 ? 1073741824 : Integer.MIN_VALUE), i4);
            return true;
        }
        return false;
    }
}
