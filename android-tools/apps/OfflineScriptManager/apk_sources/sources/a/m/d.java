package a.m;

import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.animation.ObjectAnimator;
import android.view.View;
import android.view.ViewGroup;
/* loaded from: classes.dex */
public class d extends i0 {

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a extends n {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ View f257a;

        a(d dVar, View view) {
            this.f257a = view;
        }

        @Override // a.m.m.f
        public void d(m mVar) {
            d0.h(this.f257a, 1.0f);
            d0.a(this.f257a);
            mVar.O(this);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class b extends AnimatorListenerAdapter {

        /* renamed from: a  reason: collision with root package name */
        private final View f258a;

        /* renamed from: b  reason: collision with root package name */
        private boolean f259b = false;

        b(View view) {
            this.f258a = view;
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            d0.h(this.f258a, 1.0f);
            if (this.f259b) {
                this.f258a.setLayerType(0, null);
            }
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationStart(Animator animator) {
            if (a.f.l.r.B(this.f258a) && this.f258a.getLayerType() == 0) {
                this.f259b = true;
                this.f258a.setLayerType(2, null);
            }
        }
    }

    public d(int i) {
        h0(i);
    }

    private Animator i0(View view, float f, float f2) {
        if (f == f2) {
            return null;
        }
        d0.h(view, f);
        ObjectAnimator ofFloat = ObjectAnimator.ofFloat(view, d0.f263d, f2);
        ofFloat.addListener(new b(view));
        a(new a(this, view));
        return ofFloat;
    }

    private static float j0(s sVar, float f) {
        Float f2;
        return (sVar == null || (f2 = (Float) sVar.f315a.get("android:fade:transitionAlpha")) == null) ? f : f2.floatValue();
    }

    @Override // a.m.i0
    public Animator d0(ViewGroup viewGroup, View view, s sVar, s sVar2) {
        float j0 = j0(sVar, 0.0f);
        return i0(view, j0 != 1.0f ? j0 : 0.0f, 1.0f);
    }

    @Override // a.m.i0
    public Animator f0(ViewGroup viewGroup, View view, s sVar, s sVar2) {
        d0.f(view);
        return i0(view, j0(sVar, 1.0f), 0.0f);
    }

    @Override // a.m.i0, a.m.m
    public void i(s sVar) {
        super.i(sVar);
        sVar.f315a.put("android:fade:transitionAlpha", Float.valueOf(d0.d(sVar.f316b)));
    }
}
