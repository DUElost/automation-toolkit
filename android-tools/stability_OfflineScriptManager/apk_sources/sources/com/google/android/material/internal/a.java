package com.google.android.material.internal;

import android.content.res.ColorStateList;
import android.graphics.Canvas;
import android.graphics.ColorFilter;
import android.graphics.LinearGradient;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.RectF;
import android.graphics.Shader;
import android.graphics.drawable.Drawable;
/* loaded from: classes.dex */
public class a extends Drawable {

    /* renamed from: a  reason: collision with root package name */
    final Paint f2351a;
    float e;
    private int f;
    private int g;
    private int h;
    private int i;
    private ColorStateList j;
    private int k;
    private float m;

    /* renamed from: b  reason: collision with root package name */
    final Rect f2352b = new Rect();

    /* renamed from: c  reason: collision with root package name */
    final RectF f2353c = new RectF();

    /* renamed from: d  reason: collision with root package name */
    final b f2354d = new b();
    private boolean l = true;

    /* loaded from: classes.dex */
    private class b extends Drawable.ConstantState {
        private b() {
        }

        @Override // android.graphics.drawable.Drawable.ConstantState
        public int getChangingConfigurations() {
            return 0;
        }

        @Override // android.graphics.drawable.Drawable.ConstantState
        public Drawable newDrawable() {
            return a.this;
        }
    }

    public a() {
        Paint paint = new Paint(1);
        this.f2351a = paint;
        paint.setStyle(Paint.Style.STROKE);
    }

    private Shader a() {
        Rect rect = this.f2352b;
        copyBounds(rect);
        float height = this.e / rect.height();
        return new LinearGradient(0.0f, rect.top, 0.0f, rect.bottom, new int[]{a.f.e.a.b(this.f, this.k), a.f.e.a.b(this.g, this.k), a.f.e.a.b(a.f.e.a.d(this.g, 0), this.k), a.f.e.a.b(a.f.e.a.d(this.i, 0), this.k), a.f.e.a.b(this.i, this.k), a.f.e.a.b(this.h, this.k)}, new float[]{0.0f, height, 0.5f, 0.5f, 1.0f - height, 1.0f}, Shader.TileMode.CLAMP);
    }

    public void b(ColorStateList colorStateList) {
        if (colorStateList != null) {
            this.k = colorStateList.getColorForState(getState(), this.k);
        }
        this.j = colorStateList;
        this.l = true;
        invalidateSelf();
    }

    public void c(float f) {
        if (this.e != f) {
            this.e = f;
            this.f2351a.setStrokeWidth(f * 1.3333f);
            this.l = true;
            invalidateSelf();
        }
    }

    public void d(int i, int i2, int i3, int i4) {
        this.f = i;
        this.g = i2;
        this.h = i3;
        this.i = i4;
    }

    @Override // android.graphics.drawable.Drawable
    public void draw(Canvas canvas) {
        if (this.l) {
            this.f2351a.setShader(a());
            this.l = false;
        }
        float strokeWidth = this.f2351a.getStrokeWidth() / 2.0f;
        RectF rectF = this.f2353c;
        copyBounds(this.f2352b);
        rectF.set(this.f2352b);
        rectF.left += strokeWidth;
        rectF.top += strokeWidth;
        rectF.right -= strokeWidth;
        rectF.bottom -= strokeWidth;
        canvas.save();
        canvas.rotate(this.m, rectF.centerX(), rectF.centerY());
        canvas.drawOval(rectF, this.f2351a);
        canvas.restore();
    }

    public final void e(float f) {
        if (f != this.m) {
            this.m = f;
            invalidateSelf();
        }
    }

    @Override // android.graphics.drawable.Drawable
    public Drawable.ConstantState getConstantState() {
        return this.f2354d;
    }

    @Override // android.graphics.drawable.Drawable
    public int getOpacity() {
        return this.e > 0.0f ? -3 : -2;
    }

    @Override // android.graphics.drawable.Drawable
    public boolean getPadding(Rect rect) {
        int round = Math.round(this.e);
        rect.set(round, round, round, round);
        return true;
    }

    @Override // android.graphics.drawable.Drawable
    public boolean isStateful() {
        ColorStateList colorStateList = this.j;
        return (colorStateList != null && colorStateList.isStateful()) || super.isStateful();
    }

    @Override // android.graphics.drawable.Drawable
    protected void onBoundsChange(Rect rect) {
        this.l = true;
    }

    @Override // android.graphics.drawable.Drawable
    protected boolean onStateChange(int[] iArr) {
        int colorForState;
        ColorStateList colorStateList = this.j;
        if (colorStateList != null && (colorForState = colorStateList.getColorForState(iArr, this.k)) != this.k) {
            this.l = true;
            this.k = colorForState;
        }
        if (this.l) {
            invalidateSelf();
        }
        return this.l;
    }

    @Override // android.graphics.drawable.Drawable
    public void setAlpha(int i) {
        this.f2351a.setAlpha(i);
        invalidateSelf();
    }

    @Override // android.graphics.drawable.Drawable
    public void setColorFilter(ColorFilter colorFilter) {
        this.f2351a.setColorFilter(colorFilter);
        invalidateSelf();
    }
}
