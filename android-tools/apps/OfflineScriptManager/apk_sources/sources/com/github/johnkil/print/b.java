package com.github.johnkil.print;

import android.content.Context;
import android.content.res.ColorStateList;
import android.graphics.Canvas;
import android.graphics.ColorFilter;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.Rect;
import android.graphics.RectF;
import android.graphics.Typeface;
import android.graphics.drawable.Drawable;
import android.util.Log;
import android.util.TypedValue;
/* loaded from: classes.dex */
public class b extends Drawable {

    /* renamed from: a  reason: collision with root package name */
    private final Context f2258a;

    /* renamed from: b  reason: collision with root package name */
    private final Paint f2259b;

    /* renamed from: c  reason: collision with root package name */
    private final Path f2260c;

    /* renamed from: d  reason: collision with root package name */
    private final RectF f2261d;
    private CharSequence e;
    private ColorStateList f;
    private Typeface g;
    private int h;
    private int i;

    /* renamed from: com.github.johnkil.print.b$b  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public static class C0095b {

        /* renamed from: a  reason: collision with root package name */
        private final Context f2262a;

        /* renamed from: b  reason: collision with root package name */
        private CharSequence f2263b;

        /* renamed from: c  reason: collision with root package name */
        private ColorStateList f2264c;

        /* renamed from: d  reason: collision with root package name */
        private Typeface f2265d;
        private int e;

        public C0095b(Context context) {
            this.f2262a = context;
        }

        public b a() {
            if (this.f2265d == null) {
                com.github.johnkil.print.a a2 = com.github.johnkil.print.a.a();
                if (a2.c()) {
                    this.f2265d = a2.b();
                } else {
                    Log.w("Print", "The iconic font is not set.");
                }
            }
            return new b(this.f2262a, this.f2263b, this.f2264c, this.f2265d, this.e);
        }

        public C0095b b(ColorStateList colorStateList) {
            if (colorStateList != null) {
                this.f2264c = colorStateList;
                return this;
            }
            throw new IllegalArgumentException("Color must not be null.");
        }

        public C0095b c(Typeface typeface) {
            if (typeface != null) {
                this.f2265d = typeface;
                return this;
            }
            throw new IllegalArgumentException("Font must not be null.");
        }

        public C0095b d(int i, float f) {
            this.e = (int) TypedValue.applyDimension(i, f, this.f2262a.getResources().getDisplayMetrics());
            return this;
        }

        public C0095b e(CharSequence charSequence) {
            this.f2263b = charSequence;
            return this;
        }
    }

    private b(Context context, CharSequence charSequence, ColorStateList colorStateList, Typeface typeface, int i) {
        this.f2258a = context;
        Paint paint = new Paint();
        this.f2259b = paint;
        paint.setFlags(paint.getFlags() | 1 | 128);
        this.f2260c = new Path();
        this.f2261d = new RectF();
        this.e = charSequence;
        this.f = colorStateList;
        this.g = typeface;
        this.h = i;
        paint.setTextSize(i);
        paint.setTypeface(this.g);
        n();
    }

    private void e(Rect rect) {
        this.f2260c.offset((rect.centerX() - (this.f2261d.width() / 2.0f)) - this.f2261d.left, (rect.centerY() - (this.f2261d.height() / 2.0f)) - this.f2261d.top);
    }

    private void n() {
        int colorForState = this.f.getColorForState(getState(), 0);
        if (colorForState != this.i) {
            this.i = colorForState;
            this.f2259b.setColor(colorForState);
        }
    }

    public ColorStateList a() {
        return this.f;
    }

    public Typeface b() {
        return this.g;
    }

    public int c() {
        return this.h;
    }

    public CharSequence d() {
        return this.e;
    }

    @Override // android.graphics.drawable.Drawable
    public void draw(Canvas canvas) {
        if (this.e != null) {
            Rect bounds = getBounds();
            this.f2259b.getTextPath(this.e.toString(), 0, this.e.length(), 0.0f, bounds.height(), this.f2260c);
            this.f2260c.computeBounds(this.f2261d, true);
            e(bounds);
            this.f2260c.close();
            canvas.drawPath(this.f2260c, this.f2259b);
        }
    }

    public void f(int i) {
        g(this.f2258a.getResources().getColorStateList(i));
    }

    public void g(ColorStateList colorStateList) {
        if (colorStateList == null) {
            throw new IllegalArgumentException("Color must not be null.");
        }
        this.f = colorStateList;
        n();
        invalidateSelf();
    }

    @Override // android.graphics.drawable.Drawable
    public int getIntrinsicHeight() {
        return this.h;
    }

    @Override // android.graphics.drawable.Drawable
    public int getIntrinsicWidth() {
        return this.h;
    }

    @Override // android.graphics.drawable.Drawable
    public int getOpacity() {
        return -3;
    }

    public void h(Typeface typeface) {
        if (typeface == null) {
            throw new IllegalArgumentException("Font must not be null.");
        }
        this.g = typeface;
        this.f2259b.setTypeface(typeface);
        invalidateSelf();
    }

    public void i(String str) {
        h(e.a(this.f2258a.getAssets(), str));
    }

    @Override // android.graphics.drawable.Drawable
    public boolean isStateful() {
        return true;
    }

    public void j(int i) {
        k(0, this.f2258a.getResources().getDimensionPixelSize(i));
    }

    public void k(int i, float f) {
        int applyDimension = (int) TypedValue.applyDimension(i, f, this.f2258a.getResources().getDisplayMetrics());
        this.h = applyDimension;
        this.f2259b.setTextSize(applyDimension);
        invalidateSelf();
    }

    public void l(int i) {
        m(this.f2258a.getText(i));
    }

    public void m(CharSequence charSequence) {
        this.e = charSequence;
        invalidateSelf();
    }

    @Override // android.graphics.drawable.Drawable
    protected boolean onStateChange(int[] iArr) {
        ColorStateList colorStateList = this.f;
        if (colorStateList != null && colorStateList.isStateful()) {
            n();
            invalidateSelf();
        }
        return super.onStateChange(iArr);
    }

    @Override // android.graphics.drawable.Drawable
    public void setAlpha(int i) {
        this.f2259b.setAlpha(i);
    }

    @Override // android.graphics.drawable.Drawable
    public void setColorFilter(ColorFilter colorFilter) {
        this.f2259b.setColorFilter(colorFilter);
    }
}
