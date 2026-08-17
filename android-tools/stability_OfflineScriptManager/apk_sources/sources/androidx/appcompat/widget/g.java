package androidx.appcompat.widget;

import android.content.res.ColorStateList;
import android.content.res.TypedArray;
import android.graphics.PorterDuff;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.util.AttributeSet;
import android.widget.CompoundButton;
/* loaded from: classes.dex */
class g {

    /* renamed from: a  reason: collision with root package name */
    private final CompoundButton f691a;

    /* renamed from: b  reason: collision with root package name */
    private ColorStateList f692b = null;

    /* renamed from: c  reason: collision with root package name */
    private PorterDuff.Mode f693c = null;

    /* renamed from: d  reason: collision with root package name */
    private boolean f694d = false;
    private boolean e = false;
    private boolean f;

    /* JADX INFO: Access modifiers changed from: package-private */
    public g(CompoundButton compoundButton) {
        this.f691a = compoundButton;
    }

    void a() {
        Drawable a2 = androidx.core.widget.c.a(this.f691a);
        if (a2 != null) {
            if (this.f694d || this.e) {
                Drawable mutate = androidx.core.graphics.drawable.a.q(a2).mutate();
                if (this.f694d) {
                    androidx.core.graphics.drawable.a.o(mutate, this.f692b);
                }
                if (this.e) {
                    androidx.core.graphics.drawable.a.p(mutate, this.f693c);
                }
                if (mutate.isStateful()) {
                    mutate.setState(this.f691a.getDrawableState());
                }
                this.f691a.setButtonDrawable(mutate);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int b(int i) {
        Drawable a2;
        return (Build.VERSION.SDK_INT >= 17 || (a2 = androidx.core.widget.c.a(this.f691a)) == null) ? i : i + a2.getIntrinsicWidth();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public ColorStateList c() {
        return this.f692b;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public PorterDuff.Mode d() {
        return this.f693c;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void e(AttributeSet attributeSet, int i) {
        int resourceId;
        TypedArray obtainStyledAttributes = this.f691a.getContext().obtainStyledAttributes(attributeSet, a.a.j.CompoundButton, i, 0);
        try {
            int i2 = a.a.j.CompoundButton_android_button;
            if (obtainStyledAttributes.hasValue(i2) && (resourceId = obtainStyledAttributes.getResourceId(i2, 0)) != 0) {
                CompoundButton compoundButton = this.f691a;
                compoundButton.setButtonDrawable(a.a.k.a.a.d(compoundButton.getContext(), resourceId));
            }
            int i3 = a.a.j.CompoundButton_buttonTint;
            if (obtainStyledAttributes.hasValue(i3)) {
                androidx.core.widget.c.b(this.f691a, obtainStyledAttributes.getColorStateList(i3));
            }
            int i4 = a.a.j.CompoundButton_buttonTintMode;
            if (obtainStyledAttributes.hasValue(i4)) {
                androidx.core.widget.c.c(this.f691a, z.d(obtainStyledAttributes.getInt(i4, -1), null));
            }
        } finally {
            obtainStyledAttributes.recycle();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void f() {
        if (this.f) {
            this.f = false;
            return;
        }
        this.f = true;
        a();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void g(ColorStateList colorStateList) {
        this.f692b = colorStateList;
        this.f694d = true;
        a();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void h(PorterDuff.Mode mode) {
        this.f693c = mode;
        this.e = true;
        a();
    }
}
