package b.d.a.a.l;

import a.f.l.r;
import android.content.Context;
import android.content.res.ColorStateList;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.PorterDuff;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.util.AttributeSet;
import android.util.Log;
import androidx.appcompat.widget.e;
import b.d.a.a.i;
import b.d.a.a.j;
import com.google.android.material.internal.f;
import com.google.android.material.internal.g;
/* loaded from: classes.dex */
public class a extends e {

    /* renamed from: d  reason: collision with root package name */
    private final c f1487d;
    private int e;
    private PorterDuff.Mode f;
    private ColorStateList g;
    private Drawable h;
    private int i;
    private int j;
    private int k;

    public a(Context context, AttributeSet attributeSet) {
        this(context, attributeSet, b.d.a.a.b.materialButtonStyle);
    }

    public a(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        TypedArray h = f.h(context, attributeSet, j.MaterialButton, i, i.Widget_MaterialComponents_Button, new int[0]);
        this.e = h.getDimensionPixelSize(j.MaterialButton_iconPadding, 0);
        this.f = g.a(h.getInt(j.MaterialButton_iconTintMode, -1), PorterDuff.Mode.SRC_IN);
        this.g = b.d.a.a.p.a.a(getContext(), h, j.MaterialButton_iconTint);
        this.h = b.d.a.a.p.a.b(getContext(), h, j.MaterialButton_icon);
        this.k = h.getInteger(j.MaterialButton_iconGravity, 1);
        this.i = h.getDimensionPixelSize(j.MaterialButton_iconSize, 0);
        c cVar = new c(this);
        this.f1487d = cVar;
        cVar.k(h);
        h.recycle();
        setCompoundDrawablePadding(this.e);
        c();
    }

    private boolean a() {
        return r.q(this) == 1;
    }

    private boolean b() {
        c cVar = this.f1487d;
        return (cVar == null || cVar.j()) ? false : true;
    }

    private void c() {
        Drawable drawable = this.h;
        if (drawable != null) {
            Drawable mutate = drawable.mutate();
            this.h = mutate;
            androidx.core.graphics.drawable.a.o(mutate, this.g);
            PorterDuff.Mode mode = this.f;
            if (mode != null) {
                androidx.core.graphics.drawable.a.p(this.h, mode);
            }
            int i = this.i;
            if (i == 0) {
                i = this.h.getIntrinsicWidth();
            }
            int i2 = this.i;
            if (i2 == 0) {
                i2 = this.h.getIntrinsicHeight();
            }
            Drawable drawable2 = this.h;
            int i3 = this.j;
            drawable2.setBounds(i3, 0, i + i3, i2);
        }
        androidx.core.widget.i.i(this, this.h, null, null, null);
    }

    @Override // android.view.View
    public ColorStateList getBackgroundTintList() {
        return getSupportBackgroundTintList();
    }

    @Override // android.view.View
    public PorterDuff.Mode getBackgroundTintMode() {
        return getSupportBackgroundTintMode();
    }

    public int getCornerRadius() {
        if (b()) {
            return this.f1487d.d();
        }
        return 0;
    }

    public Drawable getIcon() {
        return this.h;
    }

    public int getIconGravity() {
        return this.k;
    }

    public int getIconPadding() {
        return this.e;
    }

    public int getIconSize() {
        return this.i;
    }

    public ColorStateList getIconTint() {
        return this.g;
    }

    public PorterDuff.Mode getIconTintMode() {
        return this.f;
    }

    public ColorStateList getRippleColor() {
        if (b()) {
            return this.f1487d.e();
        }
        return null;
    }

    public ColorStateList getStrokeColor() {
        if (b()) {
            return this.f1487d.f();
        }
        return null;
    }

    public int getStrokeWidth() {
        if (b()) {
            return this.f1487d.g();
        }
        return 0;
    }

    @Override // androidx.appcompat.widget.e, a.f.l.q
    public ColorStateList getSupportBackgroundTintList() {
        return b() ? this.f1487d.h() : super.getSupportBackgroundTintList();
    }

    @Override // androidx.appcompat.widget.e, a.f.l.q
    public PorterDuff.Mode getSupportBackgroundTintMode() {
        return b() ? this.f1487d.i() : super.getSupportBackgroundTintMode();
    }

    @Override // android.widget.TextView, android.view.View
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        if (Build.VERSION.SDK_INT >= 21 || !b()) {
            return;
        }
        this.f1487d.c(canvas);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // androidx.appcompat.widget.e, android.widget.TextView, android.view.View
    public void onLayout(boolean z, int i, int i2, int i3, int i4) {
        c cVar;
        super.onLayout(z, i, i2, i3, i4);
        if (Build.VERSION.SDK_INT != 21 || (cVar = this.f1487d) == null) {
            return;
        }
        cVar.v(i4 - i2, i3 - i);
    }

    @Override // android.widget.TextView, android.view.View
    protected void onMeasure(int i, int i2) {
        super.onMeasure(i, i2);
        if (this.h == null || this.k != 2) {
            return;
        }
        int measureText = (int) getPaint().measureText(getText().toString());
        int i3 = this.i;
        if (i3 == 0) {
            i3 = this.h.getIntrinsicWidth();
        }
        int measuredWidth = (((((getMeasuredWidth() - measureText) - r.t(this)) - i3) - this.e) - r.u(this)) / 2;
        if (a()) {
            measuredWidth = -measuredWidth;
        }
        if (this.j != measuredWidth) {
            this.j = measuredWidth;
            c();
        }
    }

    @Override // android.view.View
    public void setBackground(Drawable drawable) {
        setBackgroundDrawable(drawable);
    }

    @Override // android.view.View
    public void setBackgroundColor(int i) {
        if (b()) {
            this.f1487d.l(i);
        } else {
            super.setBackgroundColor(i);
        }
    }

    @Override // androidx.appcompat.widget.e, android.view.View
    public void setBackgroundDrawable(Drawable drawable) {
        if (b()) {
            if (drawable == getBackground()) {
                getBackground().setState(drawable.getState());
                return;
            } else {
                Log.i("MaterialButton", "Setting a custom background is not supported.");
                this.f1487d.m();
            }
        }
        super.setBackgroundDrawable(drawable);
    }

    @Override // androidx.appcompat.widget.e, android.view.View
    public void setBackgroundResource(int i) {
        setBackgroundDrawable(i != 0 ? a.a.k.a.a.d(getContext(), i) : null);
    }

    @Override // android.view.View
    public void setBackgroundTintList(ColorStateList colorStateList) {
        setSupportBackgroundTintList(colorStateList);
    }

    @Override // android.view.View
    public void setBackgroundTintMode(PorterDuff.Mode mode) {
        setSupportBackgroundTintMode(mode);
    }

    public void setCornerRadius(int i) {
        if (b()) {
            this.f1487d.n(i);
        }
    }

    public void setCornerRadiusResource(int i) {
        if (b()) {
            setCornerRadius(getResources().getDimensionPixelSize(i));
        }
    }

    public void setIcon(Drawable drawable) {
        if (this.h != drawable) {
            this.h = drawable;
            c();
        }
    }

    public void setIconGravity(int i) {
        this.k = i;
    }

    public void setIconPadding(int i) {
        if (this.e != i) {
            this.e = i;
            setCompoundDrawablePadding(i);
        }
    }

    public void setIconResource(int i) {
        setIcon(i != 0 ? a.a.k.a.a.d(getContext(), i) : null);
    }

    public void setIconSize(int i) {
        if (i < 0) {
            throw new IllegalArgumentException("iconSize cannot be less than 0");
        }
        if (this.i != i) {
            this.i = i;
            c();
        }
    }

    public void setIconTint(ColorStateList colorStateList) {
        if (this.g != colorStateList) {
            this.g = colorStateList;
            c();
        }
    }

    public void setIconTintMode(PorterDuff.Mode mode) {
        if (this.f != mode) {
            this.f = mode;
            c();
        }
    }

    public void setIconTintResource(int i) {
        setIconTint(a.a.k.a.a.c(getContext(), i));
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setInternalBackground(Drawable drawable) {
        super.setBackgroundDrawable(drawable);
    }

    public void setRippleColor(ColorStateList colorStateList) {
        if (b()) {
            this.f1487d.o(colorStateList);
        }
    }

    public void setRippleColorResource(int i) {
        if (b()) {
            setRippleColor(a.a.k.a.a.c(getContext(), i));
        }
    }

    public void setStrokeColor(ColorStateList colorStateList) {
        if (b()) {
            this.f1487d.p(colorStateList);
        }
    }

    public void setStrokeColorResource(int i) {
        if (b()) {
            setStrokeColor(a.a.k.a.a.c(getContext(), i));
        }
    }

    public void setStrokeWidth(int i) {
        if (b()) {
            this.f1487d.q(i);
        }
    }

    public void setStrokeWidthResource(int i) {
        if (b()) {
            setStrokeWidth(getResources().getDimensionPixelSize(i));
        }
    }

    @Override // androidx.appcompat.widget.e, a.f.l.q
    public void setSupportBackgroundTintList(ColorStateList colorStateList) {
        if (b()) {
            this.f1487d.r(colorStateList);
        } else if (this.f1487d != null) {
            super.setSupportBackgroundTintList(colorStateList);
        }
    }

    @Override // androidx.appcompat.widget.e, a.f.l.q
    public void setSupportBackgroundTintMode(PorterDuff.Mode mode) {
        if (b()) {
            this.f1487d.s(mode);
        } else if (this.f1487d != null) {
            super.setSupportBackgroundTintMode(mode);
        }
    }
}
