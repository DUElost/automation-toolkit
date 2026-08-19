package androidx.appcompat.widget;

import android.content.res.ColorStateList;
import android.graphics.Canvas;
import android.graphics.PorterDuff;
import android.graphics.drawable.Drawable;
import android.util.AttributeSet;
import android.widget.SeekBar;
/* loaded from: classes.dex */
class s extends p {

    /* renamed from: d  reason: collision with root package name */
    private final SeekBar f763d;
    private Drawable e;
    private ColorStateList f;
    private PorterDuff.Mode g;
    private boolean h;
    private boolean i;

    /* JADX INFO: Access modifiers changed from: package-private */
    public s(SeekBar seekBar) {
        super(seekBar);
        this.f = null;
        this.g = null;
        this.h = false;
        this.i = false;
        this.f763d = seekBar;
    }

    private void f() {
        Drawable drawable = this.e;
        if (drawable != null) {
            if (this.h || this.i) {
                Drawable q = androidx.core.graphics.drawable.a.q(drawable.mutate());
                this.e = q;
                if (this.h) {
                    androidx.core.graphics.drawable.a.o(q, this.f);
                }
                if (this.i) {
                    androidx.core.graphics.drawable.a.p(this.e, this.g);
                }
                if (this.e.isStateful()) {
                    this.e.setState(this.f763d.getDrawableState());
                }
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // androidx.appcompat.widget.p
    public void c(AttributeSet attributeSet, int i) {
        super.c(attributeSet, i);
        q0 t = q0.t(this.f763d.getContext(), attributeSet, a.a.j.AppCompatSeekBar, i, 0);
        Drawable g = t.g(a.a.j.AppCompatSeekBar_android_thumb);
        if (g != null) {
            this.f763d.setThumb(g);
        }
        j(t.f(a.a.j.AppCompatSeekBar_tickMark));
        int i2 = a.a.j.AppCompatSeekBar_tickMarkTintMode;
        if (t.q(i2)) {
            this.g = z.d(t.j(i2, -1), this.g);
            this.i = true;
        }
        int i3 = a.a.j.AppCompatSeekBar_tickMarkTint;
        if (t.q(i3)) {
            this.f = t.c(i3);
            this.h = true;
        }
        t.u();
        f();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void g(Canvas canvas) {
        if (this.e != null) {
            int max = this.f763d.getMax();
            if (max > 1) {
                int intrinsicWidth = this.e.getIntrinsicWidth();
                int intrinsicHeight = this.e.getIntrinsicHeight();
                int i = intrinsicWidth >= 0 ? intrinsicWidth / 2 : 1;
                int i2 = intrinsicHeight >= 0 ? intrinsicHeight / 2 : 1;
                this.e.setBounds(-i, -i2, i, i2);
                float width = ((this.f763d.getWidth() - this.f763d.getPaddingLeft()) - this.f763d.getPaddingRight()) / max;
                int save = canvas.save();
                canvas.translate(this.f763d.getPaddingLeft(), this.f763d.getHeight() / 2);
                for (int i3 = 0; i3 <= max; i3++) {
                    this.e.draw(canvas);
                    canvas.translate(width, 0.0f);
                }
                canvas.restoreToCount(save);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void h() {
        Drawable drawable = this.e;
        if (drawable != null && drawable.isStateful() && drawable.setState(this.f763d.getDrawableState())) {
            this.f763d.invalidateDrawable(drawable);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void i() {
        Drawable drawable = this.e;
        if (drawable != null) {
            drawable.jumpToCurrentState();
        }
    }

    void j(Drawable drawable) {
        Drawable drawable2 = this.e;
        if (drawable2 != null) {
            drawable2.setCallback(null);
        }
        this.e = drawable;
        if (drawable != null) {
            drawable.setCallback(this.f763d);
            androidx.core.graphics.drawable.a.m(drawable, a.f.l.r.q(this.f763d));
            if (drawable.isStateful()) {
                drawable.setState(this.f763d.getDrawableState());
            }
            f();
        }
        this.f763d.invalidate();
    }
}
