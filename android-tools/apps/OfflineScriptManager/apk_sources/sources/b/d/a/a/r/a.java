package b.d.a.a.r;

import a.a.l.a.c;
import android.content.Context;
import android.graphics.Canvas;
import android.graphics.LinearGradient;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.RadialGradient;
import android.graphics.Rect;
import android.graphics.RectF;
import android.graphics.Shader;
import android.graphics.drawable.Drawable;
/* loaded from: classes.dex */
public class a extends c {
    static final double r = Math.cos(Math.toRadians(45.0d));

    /* renamed from: c  reason: collision with root package name */
    final Paint f1509c;

    /* renamed from: d  reason: collision with root package name */
    final Paint f1510d;
    final RectF e;
    float f;
    Path g;
    float h;
    float i;
    float j;
    private boolean k;
    private final int l;
    private final int m;
    private final int n;
    private boolean o;
    private float p;
    private boolean q;

    public a(Context context, Drawable drawable, float f, float f2, float f3) {
        super(drawable);
        this.k = true;
        this.o = true;
        this.q = false;
        this.l = androidx.core.content.a.b(context, b.d.a.a.c.design_fab_shadow_start_color);
        this.m = androidx.core.content.a.b(context, b.d.a.a.c.design_fab_shadow_mid_color);
        this.n = androidx.core.content.a.b(context, b.d.a.a.c.design_fab_shadow_end_color);
        Paint paint = new Paint(5);
        this.f1509c = paint;
        paint.setStyle(Paint.Style.FILL);
        this.f = Math.round(f);
        this.e = new RectF();
        Paint paint2 = new Paint(paint);
        this.f1510d = paint2;
        paint2.setAntiAlias(false);
        l(f2, f3);
    }

    private void c(Rect rect) {
        float f = this.h;
        float f2 = 1.5f * f;
        this.e.set(rect.left + f, rect.top + f2, rect.right - f, rect.bottom - f2);
        Drawable a2 = a();
        RectF rectF = this.e;
        a2.setBounds((int) rectF.left, (int) rectF.top, (int) rectF.right, (int) rectF.bottom);
        d();
    }

    private void d() {
        float f = this.f;
        RectF rectF = new RectF(-f, -f, f, f);
        RectF rectF2 = new RectF(rectF);
        float f2 = this.i;
        rectF2.inset(-f2, -f2);
        Path path = this.g;
        if (path == null) {
            this.g = new Path();
        } else {
            path.reset();
        }
        this.g.setFillType(Path.FillType.EVEN_ODD);
        this.g.moveTo(-this.f, 0.0f);
        this.g.rLineTo(-this.i, 0.0f);
        this.g.arcTo(rectF2, 180.0f, 90.0f, false);
        this.g.arcTo(rectF, 270.0f, -90.0f, false);
        this.g.close();
        float f3 = -rectF2.top;
        if (f3 > 0.0f) {
            float f4 = this.f / f3;
            this.f1509c.setShader(new RadialGradient(0.0f, 0.0f, f3, new int[]{0, this.l, this.m, this.n}, new float[]{0.0f, f4, ((1.0f - f4) / 2.0f) + f4, 1.0f}, Shader.TileMode.CLAMP));
        }
        this.f1510d.setShader(new LinearGradient(0.0f, rectF.top, 0.0f, rectF2.top, new int[]{this.l, this.m, this.n}, new float[]{0.0f, 0.5f, 1.0f}, Shader.TileMode.CLAMP));
        this.f1510d.setAntiAlias(false);
    }

    public static float e(float f, float f2, boolean z) {
        return z ? (float) (f + ((1.0d - r) * f2)) : f;
    }

    public static float f(float f, float f2, boolean z) {
        float f3 = f * 1.5f;
        return z ? (float) (f3 + ((1.0d - r) * f2)) : f3;
    }

    private void g(Canvas canvas) {
        int i;
        float f;
        int i2;
        float f2;
        float f3;
        float f4;
        int save = canvas.save();
        canvas.rotate(this.p, this.e.centerX(), this.e.centerY());
        float f5 = this.f;
        float f6 = (-f5) - this.i;
        float f7 = f5 * 2.0f;
        boolean z = this.e.width() - f7 > 0.0f;
        boolean z2 = this.e.height() - f7 > 0.0f;
        float f8 = this.j;
        float f9 = f5 / ((f8 - (0.5f * f8)) + f5);
        float f10 = f5 / ((f8 - (0.25f * f8)) + f5);
        float f11 = f5 / ((f8 - (f8 * 1.0f)) + f5);
        int save2 = canvas.save();
        RectF rectF = this.e;
        canvas.translate(rectF.left + f5, rectF.top + f5);
        canvas.scale(f9, f10);
        canvas.drawPath(this.g, this.f1509c);
        if (z) {
            canvas.scale(1.0f / f9, 1.0f);
            i = save2;
            f = f11;
            i2 = save;
            f2 = f10;
            canvas.drawRect(0.0f, f6, this.e.width() - f7, -this.f, this.f1510d);
        } else {
            i = save2;
            f = f11;
            i2 = save;
            f2 = f10;
        }
        canvas.restoreToCount(i);
        int save3 = canvas.save();
        RectF rectF2 = this.e;
        canvas.translate(rectF2.right - f5, rectF2.bottom - f5);
        float f12 = f;
        canvas.scale(f9, f12);
        canvas.rotate(180.0f);
        canvas.drawPath(this.g, this.f1509c);
        if (z) {
            canvas.scale(1.0f / f9, 1.0f);
            f3 = f2;
            f4 = f12;
            canvas.drawRect(0.0f, f6, this.e.width() - f7, (-this.f) + this.i, this.f1510d);
        } else {
            f3 = f2;
            f4 = f12;
        }
        canvas.restoreToCount(save3);
        int save4 = canvas.save();
        RectF rectF3 = this.e;
        canvas.translate(rectF3.left + f5, rectF3.bottom - f5);
        canvas.scale(f9, f4);
        canvas.rotate(270.0f);
        canvas.drawPath(this.g, this.f1509c);
        if (z2) {
            canvas.scale(1.0f / f4, 1.0f);
            canvas.drawRect(0.0f, f6, this.e.height() - f7, -this.f, this.f1510d);
        }
        canvas.restoreToCount(save4);
        int save5 = canvas.save();
        RectF rectF4 = this.e;
        canvas.translate(rectF4.right - f5, rectF4.top + f5);
        float f13 = f3;
        canvas.scale(f9, f13);
        canvas.rotate(90.0f);
        canvas.drawPath(this.g, this.f1509c);
        if (z2) {
            canvas.scale(1.0f / f13, 1.0f);
            canvas.drawRect(0.0f, f6, this.e.height() - f7, -this.f, this.f1510d);
        }
        canvas.restoreToCount(save5);
        canvas.restoreToCount(i2);
    }

    private static int m(float f) {
        int round = Math.round(f);
        return round % 2 == 1 ? round - 1 : round;
    }

    @Override // a.a.l.a.c, android.graphics.drawable.Drawable
    public void draw(Canvas canvas) {
        if (this.k) {
            c(getBounds());
            this.k = false;
        }
        g(canvas);
        super.draw(canvas);
    }

    @Override // a.a.l.a.c, android.graphics.drawable.Drawable
    public int getOpacity() {
        return -3;
    }

    @Override // a.a.l.a.c, android.graphics.drawable.Drawable
    public boolean getPadding(Rect rect) {
        int ceil = (int) Math.ceil(f(this.h, this.f, this.o));
        int ceil2 = (int) Math.ceil(e(this.h, this.f, this.o));
        rect.set(ceil2, ceil, ceil2, ceil);
        return true;
    }

    public float h() {
        return this.j;
    }

    public void i(boolean z) {
        this.o = z;
        invalidateSelf();
    }

    public final void j(float f) {
        if (this.p != f) {
            this.p = f;
            invalidateSelf();
        }
    }

    public void k(float f) {
        l(f, this.h);
    }

    public void l(float f, float f2) {
        if (f < 0.0f || f2 < 0.0f) {
            throw new IllegalArgumentException("invalid shadow size");
        }
        float m = m(f);
        float m2 = m(f2);
        if (m > m2) {
            if (!this.q) {
                this.q = true;
            }
            m = m2;
        }
        if (this.j == m && this.h == m2) {
            return;
        }
        this.j = m;
        this.h = m2;
        this.i = Math.round(m * 1.5f);
        this.k = true;
        invalidateSelf();
    }

    @Override // a.a.l.a.c, android.graphics.drawable.Drawable
    protected void onBoundsChange(Rect rect) {
        this.k = true;
    }

    @Override // a.a.l.a.c, android.graphics.drawable.Drawable
    public void setAlpha(int i) {
        super.setAlpha(i);
        this.f1509c.setAlpha(i);
        this.f1510d.setAlpha(i);
    }
}
