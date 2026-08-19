package b.d.a.a.l;

import a.f.l.r;
import android.annotation.TargetApi;
import android.content.res.ColorStateList;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.PorterDuff;
import android.graphics.Rect;
import android.graphics.RectF;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.GradientDrawable;
import android.graphics.drawable.InsetDrawable;
import android.graphics.drawable.LayerDrawable;
import android.graphics.drawable.RippleDrawable;
import android.os.Build;
import b.d.a.a.j;
import com.google.android.material.internal.g;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class c {
    private static final boolean w;

    /* renamed from: a  reason: collision with root package name */
    private final a f1488a;

    /* renamed from: b  reason: collision with root package name */
    private int f1489b;

    /* renamed from: c  reason: collision with root package name */
    private int f1490c;

    /* renamed from: d  reason: collision with root package name */
    private int f1491d;
    private int e;
    private int f;
    private int g;
    private PorterDuff.Mode h;
    private ColorStateList i;
    private ColorStateList j;
    private ColorStateList k;
    private GradientDrawable o;
    private Drawable p;
    private GradientDrawable q;
    private Drawable r;
    private GradientDrawable s;
    private GradientDrawable t;
    private GradientDrawable u;
    private final Paint l = new Paint(1);
    private final Rect m = new Rect();
    private final RectF n = new RectF();
    private boolean v = false;

    static {
        w = Build.VERSION.SDK_INT >= 21;
    }

    public c(a aVar) {
        this.f1488a = aVar;
    }

    private Drawable a() {
        GradientDrawable gradientDrawable = new GradientDrawable();
        this.o = gradientDrawable;
        gradientDrawable.setCornerRadius(this.f + 1.0E-5f);
        this.o.setColor(-1);
        Drawable q = androidx.core.graphics.drawable.a.q(this.o);
        this.p = q;
        androidx.core.graphics.drawable.a.o(q, this.i);
        PorterDuff.Mode mode = this.h;
        if (mode != null) {
            androidx.core.graphics.drawable.a.p(this.p, mode);
        }
        GradientDrawable gradientDrawable2 = new GradientDrawable();
        this.q = gradientDrawable2;
        gradientDrawable2.setCornerRadius(this.f + 1.0E-5f);
        this.q.setColor(-1);
        Drawable q2 = androidx.core.graphics.drawable.a.q(this.q);
        this.r = q2;
        androidx.core.graphics.drawable.a.o(q2, this.k);
        return y(new LayerDrawable(new Drawable[]{this.p, this.r}));
    }

    @TargetApi(21)
    private Drawable b() {
        GradientDrawable gradientDrawable = new GradientDrawable();
        this.s = gradientDrawable;
        gradientDrawable.setCornerRadius(this.f + 1.0E-5f);
        this.s.setColor(-1);
        x();
        GradientDrawable gradientDrawable2 = new GradientDrawable();
        this.t = gradientDrawable2;
        gradientDrawable2.setCornerRadius(this.f + 1.0E-5f);
        this.t.setColor(0);
        this.t.setStroke(this.g, this.j);
        InsetDrawable y = y(new LayerDrawable(new Drawable[]{this.s, this.t}));
        GradientDrawable gradientDrawable3 = new GradientDrawable();
        this.u = gradientDrawable3;
        gradientDrawable3.setCornerRadius(this.f + 1.0E-5f);
        this.u.setColor(-1);
        return new b(b.d.a.a.q.a.a(this.k), y, this.u);
    }

    private GradientDrawable t() {
        if (!w || this.f1488a.getBackground() == null) {
            return null;
        }
        return (GradientDrawable) ((LayerDrawable) ((InsetDrawable) ((RippleDrawable) this.f1488a.getBackground()).getDrawable(0)).getDrawable()).getDrawable(0);
    }

    private GradientDrawable u() {
        if (!w || this.f1488a.getBackground() == null) {
            return null;
        }
        return (GradientDrawable) ((LayerDrawable) ((InsetDrawable) ((RippleDrawable) this.f1488a.getBackground()).getDrawable(0)).getDrawable()).getDrawable(1);
    }

    private void w() {
        boolean z = w;
        if (z && this.t != null) {
            this.f1488a.setInternalBackground(b());
        } else if (z) {
        } else {
            this.f1488a.invalidate();
        }
    }

    private void x() {
        GradientDrawable gradientDrawable = this.s;
        if (gradientDrawable != null) {
            androidx.core.graphics.drawable.a.o(gradientDrawable, this.i);
            PorterDuff.Mode mode = this.h;
            if (mode != null) {
                androidx.core.graphics.drawable.a.p(this.s, mode);
            }
        }
    }

    private InsetDrawable y(Drawable drawable) {
        return new InsetDrawable(drawable, this.f1489b, this.f1491d, this.f1490c, this.e);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void c(Canvas canvas) {
        if (canvas == null || this.j == null || this.g <= 0) {
            return;
        }
        this.m.set(this.f1488a.getBackground().getBounds());
        RectF rectF = this.n;
        Rect rect = this.m;
        int i = this.g;
        rectF.set(rect.left + (i / 2.0f) + this.f1489b, rect.top + (i / 2.0f) + this.f1491d, (rect.right - (i / 2.0f)) - this.f1490c, (rect.bottom - (i / 2.0f)) - this.e);
        float f = this.f - (this.g / 2.0f);
        canvas.drawRoundRect(this.n, f, f, this.l);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int d() {
        return this.f;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public ColorStateList e() {
        return this.k;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public ColorStateList f() {
        return this.j;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int g() {
        return this.g;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public ColorStateList h() {
        return this.i;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public PorterDuff.Mode i() {
        return this.h;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean j() {
        return this.v;
    }

    public void k(TypedArray typedArray) {
        this.f1489b = typedArray.getDimensionPixelOffset(j.MaterialButton_android_insetLeft, 0);
        this.f1490c = typedArray.getDimensionPixelOffset(j.MaterialButton_android_insetRight, 0);
        this.f1491d = typedArray.getDimensionPixelOffset(j.MaterialButton_android_insetTop, 0);
        this.e = typedArray.getDimensionPixelOffset(j.MaterialButton_android_insetBottom, 0);
        this.f = typedArray.getDimensionPixelSize(j.MaterialButton_cornerRadius, 0);
        this.g = typedArray.getDimensionPixelSize(j.MaterialButton_strokeWidth, 0);
        this.h = g.a(typedArray.getInt(j.MaterialButton_backgroundTintMode, -1), PorterDuff.Mode.SRC_IN);
        this.i = b.d.a.a.p.a.a(this.f1488a.getContext(), typedArray, j.MaterialButton_backgroundTint);
        this.j = b.d.a.a.p.a.a(this.f1488a.getContext(), typedArray, j.MaterialButton_strokeColor);
        this.k = b.d.a.a.p.a.a(this.f1488a.getContext(), typedArray, j.MaterialButton_rippleColor);
        this.l.setStyle(Paint.Style.STROKE);
        this.l.setStrokeWidth(this.g);
        Paint paint = this.l;
        ColorStateList colorStateList = this.j;
        paint.setColor(colorStateList != null ? colorStateList.getColorForState(this.f1488a.getDrawableState(), 0) : 0);
        int u = r.u(this.f1488a);
        int paddingTop = this.f1488a.getPaddingTop();
        int t = r.t(this.f1488a);
        int paddingBottom = this.f1488a.getPaddingBottom();
        this.f1488a.setInternalBackground(w ? b() : a());
        r.c0(this.f1488a, u + this.f1489b, paddingTop + this.f1491d, t + this.f1490c, paddingBottom + this.e);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void l(int i) {
        GradientDrawable gradientDrawable;
        GradientDrawable gradientDrawable2;
        boolean z = w;
        if (z && (gradientDrawable2 = this.s) != null) {
            gradientDrawable2.setColor(i);
        } else if (z || (gradientDrawable = this.o) == null) {
        } else {
            gradientDrawable.setColor(i);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void m() {
        this.v = true;
        this.f1488a.setSupportBackgroundTintList(this.i);
        this.f1488a.setSupportBackgroundTintMode(this.h);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void n(int i) {
        GradientDrawable gradientDrawable;
        if (this.f != i) {
            this.f = i;
            boolean z = w;
            if (!z || this.s == null || this.t == null || this.u == null) {
                if (z || (gradientDrawable = this.o) == null || this.q == null) {
                    return;
                }
                float f = i + 1.0E-5f;
                gradientDrawable.setCornerRadius(f);
                this.q.setCornerRadius(f);
                this.f1488a.invalidate();
                return;
            }
            if (Build.VERSION.SDK_INT == 21) {
                float f2 = i + 1.0E-5f;
                t().setCornerRadius(f2);
                u().setCornerRadius(f2);
            }
            float f3 = i + 1.0E-5f;
            this.s.setCornerRadius(f3);
            this.t.setCornerRadius(f3);
            this.u.setCornerRadius(f3);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void o(ColorStateList colorStateList) {
        Drawable drawable;
        if (this.k != colorStateList) {
            this.k = colorStateList;
            boolean z = w;
            if (z && (this.f1488a.getBackground() instanceof RippleDrawable)) {
                ((RippleDrawable) this.f1488a.getBackground()).setColor(colorStateList);
            } else if (z || (drawable = this.r) == null) {
            } else {
                androidx.core.graphics.drawable.a.o(drawable, colorStateList);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void p(ColorStateList colorStateList) {
        if (this.j != colorStateList) {
            this.j = colorStateList;
            this.l.setColor(colorStateList != null ? colorStateList.getColorForState(this.f1488a.getDrawableState(), 0) : 0);
            w();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void q(int i) {
        if (this.g != i) {
            this.g = i;
            this.l.setStrokeWidth(i);
            w();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void r(ColorStateList colorStateList) {
        if (this.i != colorStateList) {
            this.i = colorStateList;
            if (w) {
                x();
                return;
            }
            Drawable drawable = this.p;
            if (drawable != null) {
                androidx.core.graphics.drawable.a.o(drawable, colorStateList);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void s(PorterDuff.Mode mode) {
        if (this.h != mode) {
            this.h = mode;
            if (w) {
                x();
                return;
            }
            Drawable drawable = this.p;
            if (drawable == null || mode == null) {
                return;
            }
            androidx.core.graphics.drawable.a.p(drawable, mode);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void v(int i, int i2) {
        GradientDrawable gradientDrawable = this.u;
        if (gradientDrawable != null) {
            gradientDrawable.setBounds(this.f1489b, this.f1491d, i2 - this.f1490c, i - this.e);
        }
    }
}
