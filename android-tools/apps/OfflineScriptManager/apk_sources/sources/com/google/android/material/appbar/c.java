package com.google.android.material.appbar;

import android.content.Context;
import android.util.AttributeSet;
import android.view.View;
import androidx.coordinatorlayout.widget.CoordinatorLayout;
/* loaded from: classes.dex */
class c<V extends View> extends CoordinatorLayout.c<V> {

    /* renamed from: a  reason: collision with root package name */
    private d f2282a;

    /* renamed from: b  reason: collision with root package name */
    private int f2283b;

    /* renamed from: c  reason: collision with root package name */
    private int f2284c;

    public c() {
        this.f2283b = 0;
        this.f2284c = 0;
    }

    public c(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.f2283b = 0;
        this.f2284c = 0;
    }

    public int D() {
        d dVar = this.f2282a;
        if (dVar != null) {
            return dVar.a();
        }
        return 0;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void E(CoordinatorLayout coordinatorLayout, V v, int i) {
        coordinatorLayout.H(v, i);
    }

    public boolean F(int i) {
        d dVar = this.f2282a;
        if (dVar != null) {
            return dVar.d(i);
        }
        this.f2283b = i;
        return false;
    }

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public boolean l(CoordinatorLayout coordinatorLayout, V v, int i) {
        E(coordinatorLayout, v, i);
        if (this.f2282a == null) {
            this.f2282a = new d(v);
        }
        this.f2282a.b();
        int i2 = this.f2283b;
        if (i2 != 0) {
            this.f2282a.d(i2);
            this.f2283b = 0;
        }
        int i3 = this.f2284c;
        if (i3 != 0) {
            this.f2282a.c(i3);
            this.f2284c = 0;
            return true;
        }
        return true;
    }
}
