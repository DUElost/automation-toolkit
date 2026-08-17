package androidx.appcompat.widget;

import android.content.res.ColorStateList;
import android.graphics.PorterDuff;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.RippleDrawable;
import android.os.Build;
import android.util.AttributeSet;
import android.widget.ImageView;
/* loaded from: classes.dex */
public class l {

    /* renamed from: a  reason: collision with root package name */
    private final ImageView f722a;

    /* renamed from: b  reason: collision with root package name */
    private o0 f723b;

    /* renamed from: c  reason: collision with root package name */
    private o0 f724c;

    /* renamed from: d  reason: collision with root package name */
    private o0 f725d;

    public l(ImageView imageView) {
        this.f722a = imageView;
    }

    private boolean a(Drawable drawable) {
        if (this.f725d == null) {
            this.f725d = new o0();
        }
        o0 o0Var = this.f725d;
        o0Var.a();
        ColorStateList a2 = androidx.core.widget.e.a(this.f722a);
        if (a2 != null) {
            o0Var.f744d = true;
            o0Var.f741a = a2;
        }
        PorterDuff.Mode b2 = androidx.core.widget.e.b(this.f722a);
        if (b2 != null) {
            o0Var.f743c = true;
            o0Var.f742b = b2;
        }
        if (o0Var.f744d || o0Var.f743c) {
            h.C(drawable, o0Var, this.f722a.getDrawableState());
            return true;
        }
        return false;
    }

    private boolean j() {
        int i = Build.VERSION.SDK_INT;
        return i > 21 ? this.f723b != null : i == 21;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void b() {
        Drawable drawable = this.f722a.getDrawable();
        if (drawable != null) {
            z.b(drawable);
        }
        if (drawable != null) {
            if (j() && a(drawable)) {
                return;
            }
            o0 o0Var = this.f724c;
            if (o0Var != null) {
                h.C(drawable, o0Var, this.f722a.getDrawableState());
                return;
            }
            o0 o0Var2 = this.f723b;
            if (o0Var2 != null) {
                h.C(drawable, o0Var2, this.f722a.getDrawableState());
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public ColorStateList c() {
        o0 o0Var = this.f724c;
        if (o0Var != null) {
            return o0Var.f741a;
        }
        return null;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public PorterDuff.Mode d() {
        o0 o0Var = this.f724c;
        if (o0Var != null) {
            return o0Var.f742b;
        }
        return null;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean e() {
        return Build.VERSION.SDK_INT < 21 || !(this.f722a.getBackground() instanceof RippleDrawable);
    }

    public void f(AttributeSet attributeSet, int i) {
        int m;
        q0 t = q0.t(this.f722a.getContext(), attributeSet, a.a.j.AppCompatImageView, i, 0);
        try {
            Drawable drawable = this.f722a.getDrawable();
            if (drawable == null && (m = t.m(a.a.j.AppCompatImageView_srcCompat, -1)) != -1 && (drawable = a.a.k.a.a.d(this.f722a.getContext(), m)) != null) {
                this.f722a.setImageDrawable(drawable);
            }
            if (drawable != null) {
                z.b(drawable);
            }
            int i2 = a.a.j.AppCompatImageView_tint;
            if (t.q(i2)) {
                androidx.core.widget.e.c(this.f722a, t.c(i2));
            }
            int i3 = a.a.j.AppCompatImageView_tintMode;
            if (t.q(i3)) {
                androidx.core.widget.e.d(this.f722a, z.d(t.j(i3, -1), null));
            }
        } finally {
            t.u();
        }
    }

    public void g(int i) {
        if (i != 0) {
            Drawable d2 = a.a.k.a.a.d(this.f722a.getContext(), i);
            if (d2 != null) {
                z.b(d2);
            }
            this.f722a.setImageDrawable(d2);
        } else {
            this.f722a.setImageDrawable(null);
        }
        b();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void h(ColorStateList colorStateList) {
        if (this.f724c == null) {
            this.f724c = new o0();
        }
        o0 o0Var = this.f724c;
        o0Var.f741a = colorStateList;
        o0Var.f744d = true;
        b();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void i(PorterDuff.Mode mode) {
        if (this.f724c == null) {
            this.f724c = new o0();
        }
        o0 o0Var = this.f724c;
        o0Var.f742b = mode;
        o0Var.f743c = true;
        b();
    }
}
