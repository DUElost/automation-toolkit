package com.google.android.material.floatingactionbutton;

import android.animation.Animator;
import android.animation.AnimatorSet;
import android.animation.ObjectAnimator;
import android.animation.StateListAnimator;
import android.content.res.ColorStateList;
import android.graphics.PorterDuff;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.GradientDrawable;
import android.graphics.drawable.InsetDrawable;
import android.graphics.drawable.LayerDrawable;
import android.graphics.drawable.RippleDrawable;
import android.os.Build;
import android.view.View;
import com.google.android.material.internal.h;
import java.util.ArrayList;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class b extends com.google.android.material.floatingactionbutton.a {
    private InsetDrawable I;

    /* loaded from: classes.dex */
    static class a extends GradientDrawable {
        a() {
        }

        @Override // android.graphics.drawable.GradientDrawable, android.graphics.drawable.Drawable
        public boolean isStateful() {
            return true;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public b(h hVar, b.d.a.a.r.b bVar) {
        super(hVar, bVar);
    }

    private Animator X(float f, float f2) {
        AnimatorSet animatorSet = new AnimatorSet();
        animatorSet.play(ObjectAnimator.ofFloat(this.u, "elevation", f).setDuration(0L)).with(ObjectAnimator.ofFloat(this.u, View.TRANSLATION_Z, f2).setDuration(100L));
        animatorSet.setInterpolator(com.google.android.material.floatingactionbutton.a.B);
        return animatorSet;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // com.google.android.material.floatingactionbutton.a
    public void A(int[] iArr) {
        h hVar;
        if (Build.VERSION.SDK_INT == 21) {
            float f = 0.0f;
            if (this.u.isEnabled()) {
                this.u.setElevation(this.n);
                if (this.u.isPressed()) {
                    hVar = this.u;
                    f = this.p;
                } else if (this.u.isFocused() || this.u.isHovered()) {
                    hVar = this.u;
                    f = this.o;
                }
                hVar.setTranslationZ(f);
            }
            this.u.setElevation(0.0f);
            hVar = this.u;
            hVar.setTranslationZ(f);
        }
    }

    @Override // com.google.android.material.floatingactionbutton.a
    void B(float f, float f2, float f3) {
        int i = Build.VERSION.SDK_INT;
        if (i == 21) {
            this.u.refreshDrawableState();
        } else {
            StateListAnimator stateListAnimator = new StateListAnimator();
            stateListAnimator.addState(com.google.android.material.floatingactionbutton.a.C, X(f, f3));
            stateListAnimator.addState(com.google.android.material.floatingactionbutton.a.D, X(f, f2));
            stateListAnimator.addState(com.google.android.material.floatingactionbutton.a.E, X(f, f2));
            stateListAnimator.addState(com.google.android.material.floatingactionbutton.a.F, X(f, f2));
            AnimatorSet animatorSet = new AnimatorSet();
            ArrayList arrayList = new ArrayList();
            arrayList.add(ObjectAnimator.ofFloat(this.u, "elevation", f).setDuration(0L));
            if (i >= 22 && i <= 24) {
                h hVar = this.u;
                arrayList.add(ObjectAnimator.ofFloat(hVar, View.TRANSLATION_Z, hVar.getTranslationZ()).setDuration(100L));
            }
            arrayList.add(ObjectAnimator.ofFloat(this.u, View.TRANSLATION_Z, 0.0f).setDuration(100L));
            animatorSet.playSequentially((Animator[]) arrayList.toArray(new Animator[0]));
            animatorSet.setInterpolator(com.google.android.material.floatingactionbutton.a.B);
            stateListAnimator.addState(com.google.android.material.floatingactionbutton.a.G, animatorSet);
            stateListAnimator.addState(com.google.android.material.floatingactionbutton.a.H, X(0.0f, 0.0f));
            this.u.setStateListAnimator(stateListAnimator);
        }
        if (this.v.d()) {
            W();
        }
    }

    @Override // com.google.android.material.floatingactionbutton.a
    void C(Rect rect) {
        b.d.a.a.r.b bVar;
        InsetDrawable insetDrawable;
        if (this.v.d()) {
            InsetDrawable insetDrawable2 = new InsetDrawable(this.k, rect.left, rect.top, rect.right, rect.bottom);
            this.I = insetDrawable2;
            insetDrawable = insetDrawable2;
            bVar = this.v;
        } else {
            b.d.a.a.r.b bVar2 = this.v;
            insetDrawable = this.k;
            bVar = bVar2;
        }
        bVar.c(insetDrawable);
    }

    @Override // com.google.android.material.floatingactionbutton.a
    boolean G() {
        return false;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // com.google.android.material.floatingactionbutton.a
    public void H(ColorStateList colorStateList, PorterDuff.Mode mode, ColorStateList colorStateList2, int i) {
        Drawable drawable;
        Drawable q = androidx.core.graphics.drawable.a.q(g());
        this.j = q;
        androidx.core.graphics.drawable.a.o(q, colorStateList);
        if (mode != null) {
            androidx.core.graphics.drawable.a.p(this.j, mode);
        }
        if (i > 0) {
            this.l = e(i, colorStateList);
            drawable = new LayerDrawable(new Drawable[]{this.l, this.j});
        } else {
            this.l = null;
            drawable = this.j;
        }
        RippleDrawable rippleDrawable = new RippleDrawable(b.d.a.a.q.a.a(colorStateList2), drawable, null);
        this.k = rippleDrawable;
        this.m = rippleDrawable;
        this.v.c(rippleDrawable);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // com.google.android.material.floatingactionbutton.a
    public void Q(ColorStateList colorStateList) {
        Drawable drawable = this.k;
        if (drawable instanceof RippleDrawable) {
            ((RippleDrawable) drawable).setColor(b.d.a.a.q.a.a(colorStateList));
        } else {
            super.Q(colorStateList);
        }
    }

    @Override // com.google.android.material.floatingactionbutton.a
    public float l() {
        return this.u.getElevation();
    }

    @Override // com.google.android.material.floatingactionbutton.a
    void o(Rect rect) {
        if (!this.v.d()) {
            rect.set(0, 0, 0, 0);
            return;
        }
        float b2 = this.v.b();
        float l = l() + this.p;
        int ceil = (int) Math.ceil(b.d.a.a.r.a.e(l, b2, false));
        int ceil2 = (int) Math.ceil(b.d.a.a.r.a.f(l, b2, false));
        rect.set(ceil, ceil2, ceil, ceil2);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // com.google.android.material.floatingactionbutton.a
    public void u() {
    }

    @Override // com.google.android.material.floatingactionbutton.a
    com.google.android.material.internal.a v() {
        return new com.google.android.material.internal.b();
    }

    @Override // com.google.android.material.floatingactionbutton.a
    GradientDrawable w() {
        return new a();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // com.google.android.material.floatingactionbutton.a
    public void y() {
        W();
    }
}
