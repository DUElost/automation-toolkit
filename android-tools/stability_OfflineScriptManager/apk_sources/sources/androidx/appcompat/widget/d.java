package androidx.appcompat.widget;

import android.content.res.ColorStateList;
import android.graphics.PorterDuff;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.util.AttributeSet;
import android.view.View;
/* loaded from: classes.dex */
class d {

    /* renamed from: a  reason: collision with root package name */
    private final View f669a;

    /* renamed from: d  reason: collision with root package name */
    private o0 f672d;
    private o0 e;
    private o0 f;

    /* renamed from: c  reason: collision with root package name */
    private int f671c = -1;

    /* renamed from: b  reason: collision with root package name */
    private final h f670b = h.n();

    /* JADX INFO: Access modifiers changed from: package-private */
    public d(View view) {
        this.f669a = view;
    }

    private boolean a(Drawable drawable) {
        if (this.f == null) {
            this.f = new o0();
        }
        o0 o0Var = this.f;
        o0Var.a();
        ColorStateList h = a.f.l.r.h(this.f669a);
        if (h != null) {
            o0Var.f744d = true;
            o0Var.f741a = h;
        }
        PorterDuff.Mode i = a.f.l.r.i(this.f669a);
        if (i != null) {
            o0Var.f743c = true;
            o0Var.f742b = i;
        }
        if (o0Var.f744d || o0Var.f743c) {
            h.C(drawable, o0Var, this.f669a.getDrawableState());
            return true;
        }
        return false;
    }

    private boolean k() {
        int i = Build.VERSION.SDK_INT;
        return i > 21 ? this.f672d != null : i == 21;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void b() {
        Drawable background = this.f669a.getBackground();
        if (background != null) {
            if (k() && a(background)) {
                return;
            }
            o0 o0Var = this.e;
            if (o0Var != null) {
                h.C(background, o0Var, this.f669a.getDrawableState());
                return;
            }
            o0 o0Var2 = this.f672d;
            if (o0Var2 != null) {
                h.C(background, o0Var2, this.f669a.getDrawableState());
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public ColorStateList c() {
        o0 o0Var = this.e;
        if (o0Var != null) {
            return o0Var.f741a;
        }
        return null;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public PorterDuff.Mode d() {
        o0 o0Var = this.e;
        if (o0Var != null) {
            return o0Var.f742b;
        }
        return null;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void e(AttributeSet attributeSet, int i) {
        q0 t = q0.t(this.f669a.getContext(), attributeSet, a.a.j.ViewBackgroundHelper, i, 0);
        try {
            int i2 = a.a.j.ViewBackgroundHelper_android_background;
            if (t.q(i2)) {
                this.f671c = t.m(i2, -1);
                ColorStateList s = this.f670b.s(this.f669a.getContext(), this.f671c);
                if (s != null) {
                    h(s);
                }
            }
            int i3 = a.a.j.ViewBackgroundHelper_backgroundTint;
            if (t.q(i3)) {
                a.f.l.r.R(this.f669a, t.c(i3));
            }
            int i4 = a.a.j.ViewBackgroundHelper_backgroundTintMode;
            if (t.q(i4)) {
                a.f.l.r.S(this.f669a, z.d(t.j(i4, -1), null));
            }
        } finally {
            t.u();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void f(Drawable drawable) {
        this.f671c = -1;
        h(null);
        b();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void g(int i) {
        this.f671c = i;
        h hVar = this.f670b;
        h(hVar != null ? hVar.s(this.f669a.getContext(), i) : null);
        b();
    }

    void h(ColorStateList colorStateList) {
        if (colorStateList != null) {
            if (this.f672d == null) {
                this.f672d = new o0();
            }
            o0 o0Var = this.f672d;
            o0Var.f741a = colorStateList;
            o0Var.f744d = true;
        } else {
            this.f672d = null;
        }
        b();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void i(ColorStateList colorStateList) {
        if (this.e == null) {
            this.e = new o0();
        }
        o0 o0Var = this.e;
        o0Var.f741a = colorStateList;
        o0Var.f744d = true;
        b();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void j(PorterDuff.Mode mode) {
        if (this.e == null) {
            this.e = new o0();
        }
        o0 o0Var = this.e;
        o0Var.f742b = mode;
        o0Var.f743c = true;
        b();
    }
}
