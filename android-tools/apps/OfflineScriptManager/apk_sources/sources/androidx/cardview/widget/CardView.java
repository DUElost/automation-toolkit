package androidx.cardview.widget;

import android.content.Context;
import android.content.res.ColorStateList;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.graphics.Color;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.util.AttributeSet;
import android.view.View;
import android.widget.FrameLayout;
/* loaded from: classes.dex */
public class CardView extends FrameLayout {
    private static final int[] i = {16842801};
    private static final e j;

    /* renamed from: b  reason: collision with root package name */
    private boolean f798b;

    /* renamed from: c  reason: collision with root package name */
    private boolean f799c;

    /* renamed from: d  reason: collision with root package name */
    int f800d;
    int e;
    final Rect f;
    final Rect g;
    private final d h;

    /* loaded from: classes.dex */
    class a implements d {

        /* renamed from: a  reason: collision with root package name */
        private Drawable f801a;

        a() {
        }

        @Override // androidx.cardview.widget.d
        public void a(int i, int i2, int i3, int i4) {
            CardView.this.g.set(i, i2, i3, i4);
            CardView cardView = CardView.this;
            Rect rect = cardView.f;
            CardView.super.setPadding(i + rect.left, i2 + rect.top, i3 + rect.right, i4 + rect.bottom);
        }

        @Override // androidx.cardview.widget.d
        public View b() {
            return CardView.this;
        }

        @Override // androidx.cardview.widget.d
        public boolean c() {
            return CardView.this.getUseCompatPadding();
        }

        @Override // androidx.cardview.widget.d
        public Drawable d() {
            return this.f801a;
        }

        @Override // androidx.cardview.widget.d
        public void e(int i, int i2) {
            CardView cardView = CardView.this;
            if (i > cardView.f800d) {
                CardView.super.setMinimumWidth(i);
            }
            CardView cardView2 = CardView.this;
            if (i2 > cardView2.e) {
                CardView.super.setMinimumHeight(i2);
            }
        }

        @Override // androidx.cardview.widget.d
        public void f(Drawable drawable) {
            this.f801a = drawable;
            CardView.this.setBackgroundDrawable(drawable);
        }

        @Override // androidx.cardview.widget.d
        public boolean g() {
            return CardView.this.getPreventCornerOverlap();
        }
    }

    static {
        int i2 = Build.VERSION.SDK_INT;
        j = i2 >= 21 ? new b() : i2 >= 17 ? new androidx.cardview.widget.a() : new c();
        j.n();
    }

    public CardView(Context context, AttributeSet attributeSet) {
        this(context, attributeSet, a.c.a.cardViewStyle);
    }

    public CardView(Context context, AttributeSet attributeSet, int i2) {
        super(context, attributeSet, i2);
        Resources resources;
        int i3;
        ColorStateList valueOf;
        Rect rect = new Rect();
        this.f = rect;
        this.g = new Rect();
        a aVar = new a();
        this.h = aVar;
        TypedArray obtainStyledAttributes = context.obtainStyledAttributes(attributeSet, a.c.e.CardView, i2, a.c.d.CardView);
        int i4 = a.c.e.CardView_cardBackgroundColor;
        if (obtainStyledAttributes.hasValue(i4)) {
            valueOf = obtainStyledAttributes.getColorStateList(i4);
        } else {
            TypedArray obtainStyledAttributes2 = getContext().obtainStyledAttributes(i);
            int color = obtainStyledAttributes2.getColor(0, 0);
            obtainStyledAttributes2.recycle();
            float[] fArr = new float[3];
            Color.colorToHSV(color, fArr);
            if (fArr[2] > 0.5f) {
                resources = getResources();
                i3 = a.c.b.cardview_light_background;
            } else {
                resources = getResources();
                i3 = a.c.b.cardview_dark_background;
            }
            valueOf = ColorStateList.valueOf(resources.getColor(i3));
        }
        ColorStateList colorStateList = valueOf;
        float dimension = obtainStyledAttributes.getDimension(a.c.e.CardView_cardCornerRadius, 0.0f);
        float dimension2 = obtainStyledAttributes.getDimension(a.c.e.CardView_cardElevation, 0.0f);
        float dimension3 = obtainStyledAttributes.getDimension(a.c.e.CardView_cardMaxElevation, 0.0f);
        this.f798b = obtainStyledAttributes.getBoolean(a.c.e.CardView_cardUseCompatPadding, false);
        this.f799c = obtainStyledAttributes.getBoolean(a.c.e.CardView_cardPreventCornerOverlap, true);
        int dimensionPixelSize = obtainStyledAttributes.getDimensionPixelSize(a.c.e.CardView_contentPadding, 0);
        rect.left = obtainStyledAttributes.getDimensionPixelSize(a.c.e.CardView_contentPaddingLeft, dimensionPixelSize);
        rect.top = obtainStyledAttributes.getDimensionPixelSize(a.c.e.CardView_contentPaddingTop, dimensionPixelSize);
        rect.right = obtainStyledAttributes.getDimensionPixelSize(a.c.e.CardView_contentPaddingRight, dimensionPixelSize);
        rect.bottom = obtainStyledAttributes.getDimensionPixelSize(a.c.e.CardView_contentPaddingBottom, dimensionPixelSize);
        float f = dimension2 > dimension3 ? dimension2 : dimension3;
        this.f800d = obtainStyledAttributes.getDimensionPixelSize(a.c.e.CardView_android_minWidth, 0);
        this.e = obtainStyledAttributes.getDimensionPixelSize(a.c.e.CardView_android_minHeight, 0);
        obtainStyledAttributes.recycle();
        j.h(aVar, context, colorStateList, dimension, dimension2, f);
    }

    public ColorStateList getCardBackgroundColor() {
        return j.f(this.h);
    }

    public float getCardElevation() {
        return j.l(this.h);
    }

    public int getContentPaddingBottom() {
        return this.f.bottom;
    }

    public int getContentPaddingLeft() {
        return this.f.left;
    }

    public int getContentPaddingRight() {
        return this.f.right;
    }

    public int getContentPaddingTop() {
        return this.f.top;
    }

    public float getMaxCardElevation() {
        return j.a(this.h);
    }

    public boolean getPreventCornerOverlap() {
        return this.f799c;
    }

    public float getRadius() {
        return j.b(this.h);
    }

    public boolean getUseCompatPadding() {
        return this.f798b;
    }

    @Override // android.widget.FrameLayout, android.view.View
    protected void onMeasure(int i2, int i3) {
        e eVar = j;
        if (!(eVar instanceof b)) {
            int mode = View.MeasureSpec.getMode(i2);
            if (mode == Integer.MIN_VALUE || mode == 1073741824) {
                i2 = View.MeasureSpec.makeMeasureSpec(Math.max((int) Math.ceil(eVar.d(this.h)), View.MeasureSpec.getSize(i2)), mode);
            }
            int mode2 = View.MeasureSpec.getMode(i3);
            if (mode2 == Integer.MIN_VALUE || mode2 == 1073741824) {
                i3 = View.MeasureSpec.makeMeasureSpec(Math.max((int) Math.ceil(eVar.c(this.h)), View.MeasureSpec.getSize(i3)), mode2);
            }
        }
        super.onMeasure(i2, i3);
    }

    public void setCardBackgroundColor(int i2) {
        j.k(this.h, ColorStateList.valueOf(i2));
    }

    public void setCardBackgroundColor(ColorStateList colorStateList) {
        j.k(this.h, colorStateList);
    }

    public void setCardElevation(float f) {
        j.g(this.h, f);
    }

    public void setMaxCardElevation(float f) {
        j.m(this.h, f);
    }

    @Override // android.view.View
    public void setMinimumHeight(int i2) {
        this.e = i2;
        super.setMinimumHeight(i2);
    }

    @Override // android.view.View
    public void setMinimumWidth(int i2) {
        this.f800d = i2;
        super.setMinimumWidth(i2);
    }

    @Override // android.view.View
    public void setPadding(int i2, int i3, int i4, int i5) {
    }

    @Override // android.view.View
    public void setPaddingRelative(int i2, int i3, int i4, int i5) {
    }

    public void setPreventCornerOverlap(boolean z) {
        if (z != this.f799c) {
            this.f799c = z;
            j.j(this.h);
        }
    }

    public void setRadius(float f) {
        j.i(this.h, f);
    }

    public void setUseCompatPadding(boolean z) {
        if (this.f798b != z) {
            this.f798b = z;
            j.e(this.h);
        }
    }
}
