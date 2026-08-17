package com.google.android.material.transformation;

import a.f.l.r;
import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.animation.AnimatorSet;
import android.animation.ObjectAnimator;
import android.animation.ValueAnimator;
import android.annotation.TargetApi;
import android.content.Context;
import android.content.res.ColorStateList;
import android.graphics.Rect;
import android.graphics.RectF;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.util.AttributeSet;
import android.view.View;
import android.view.ViewAnimationUtils;
import android.view.ViewGroup;
import android.widget.ImageView;
import androidx.coordinatorlayout.widget.CoordinatorLayout;
import b.d.a.a.f;
import b.d.a.a.k.h;
import b.d.a.a.k.i;
import b.d.a.a.k.j;
import b.d.a.a.m.d;
import com.google.android.material.floatingactionbutton.FloatingActionButton;
import java.util.ArrayList;
import java.util.List;
import jxl.SheetSettings;
/* loaded from: classes.dex */
public abstract class FabTransformationBehavior extends ExpandableTransformationBehavior {

    /* renamed from: c  reason: collision with root package name */
    private final Rect f2443c;

    /* renamed from: d  reason: collision with root package name */
    private final RectF f2444d;
    private final RectF e;
    private final int[] f;

    /* loaded from: classes.dex */
    class a extends AnimatorListenerAdapter {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ boolean f2445a;

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ View f2446b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ View f2447c;

        a(FabTransformationBehavior fabTransformationBehavior, boolean z, View view, View view2) {
            this.f2445a = z;
            this.f2446b = view;
            this.f2447c = view2;
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            if (this.f2445a) {
                return;
            }
            this.f2446b.setVisibility(4);
            this.f2447c.setAlpha(1.0f);
            this.f2447c.setVisibility(0);
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationStart(Animator animator) {
            if (this.f2445a) {
                this.f2446b.setVisibility(0);
                this.f2447c.setAlpha(0.0f);
                this.f2447c.setVisibility(4);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b implements ValueAnimator.AnimatorUpdateListener {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ View f2448a;

        b(FabTransformationBehavior fabTransformationBehavior, View view) {
            this.f2448a = view;
        }

        @Override // android.animation.ValueAnimator.AnimatorUpdateListener
        public void onAnimationUpdate(ValueAnimator valueAnimator) {
            this.f2448a.invalidate();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class c extends AnimatorListenerAdapter {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ b.d.a.a.m.d f2449a;

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ Drawable f2450b;

        c(FabTransformationBehavior fabTransformationBehavior, b.d.a.a.m.d dVar, Drawable drawable) {
            this.f2449a = dVar;
            this.f2450b = drawable;
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            this.f2449a.setCircularRevealOverlayDrawable(null);
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationStart(Animator animator) {
            this.f2449a.setCircularRevealOverlayDrawable(this.f2450b);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class d extends AnimatorListenerAdapter {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ b.d.a.a.m.d f2451a;

        d(FabTransformationBehavior fabTransformationBehavior, b.d.a.a.m.d dVar) {
            this.f2451a = dVar;
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            d.e revealInfo = this.f2451a.getRevealInfo();
            revealInfo.f1501c = Float.MAX_VALUE;
            this.f2451a.setRevealInfo(revealInfo);
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    /* loaded from: classes.dex */
    public static class e {

        /* renamed from: a  reason: collision with root package name */
        public h f2452a;

        /* renamed from: b  reason: collision with root package name */
        public j f2453b;
    }

    public FabTransformationBehavior() {
        this.f2443c = new Rect();
        this.f2444d = new RectF();
        this.e = new RectF();
        this.f = new int[2];
    }

    public FabTransformationBehavior(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.f2443c = new Rect();
        this.f2444d = new RectF();
        this.e = new RectF();
        this.f = new int[2];
    }

    private ViewGroup J(View view) {
        View findViewById = view.findViewById(f.mtrl_child_content_container);
        return findViewById != null ? b0(findViewById) : ((view instanceof com.google.android.material.transformation.b) || (view instanceof com.google.android.material.transformation.a)) ? b0(((ViewGroup) view).getChildAt(0)) : b0(view);
    }

    private void K(View view, e eVar, i iVar, i iVar2, float f, float f2, float f3, float f4, RectF rectF) {
        float P = P(eVar, iVar, f, f3);
        float P2 = P(eVar, iVar2, f2, f4);
        Rect rect = this.f2443c;
        view.getWindowVisibleDisplayFrame(rect);
        RectF rectF2 = this.f2444d;
        rectF2.set(rect);
        RectF rectF3 = this.e;
        Q(view, rectF3);
        rectF3.offset(P, P2);
        rectF3.intersect(rectF2);
        rectF.set(rectF3);
    }

    private float L(View view, View view2, j jVar) {
        RectF rectF = this.f2444d;
        RectF rectF2 = this.e;
        Q(view, rectF);
        Q(view2, rectF2);
        rectF2.offset(-N(view, view2, jVar), 0.0f);
        return rectF.centerX() - rectF2.left;
    }

    private float M(View view, View view2, j jVar) {
        RectF rectF = this.f2444d;
        RectF rectF2 = this.e;
        Q(view, rectF);
        Q(view2, rectF2);
        rectF2.offset(0.0f, -O(view, view2, jVar));
        return rectF.centerY() - rectF2.top;
    }

    private float N(View view, View view2, j jVar) {
        float centerX;
        float centerX2;
        float f;
        RectF rectF = this.f2444d;
        RectF rectF2 = this.e;
        Q(view, rectF);
        Q(view2, rectF2);
        int i = jVar.f1484a & 7;
        if (i == 1) {
            centerX = rectF2.centerX();
            centerX2 = rectF.centerX();
        } else if (i == 3) {
            centerX = rectF2.left;
            centerX2 = rectF.left;
        } else if (i != 5) {
            f = 0.0f;
            return f + jVar.f1485b;
        } else {
            centerX = rectF2.right;
            centerX2 = rectF.right;
        }
        f = centerX - centerX2;
        return f + jVar.f1485b;
    }

    private float O(View view, View view2, j jVar) {
        float centerY;
        float centerY2;
        float f;
        RectF rectF = this.f2444d;
        RectF rectF2 = this.e;
        Q(view, rectF);
        Q(view2, rectF2);
        int i = jVar.f1484a & 112;
        if (i == 16) {
            centerY = rectF2.centerY();
            centerY2 = rectF.centerY();
        } else if (i == 48) {
            centerY = rectF2.top;
            centerY2 = rectF.top;
        } else if (i != 80) {
            f = 0.0f;
            return f + jVar.f1486c;
        } else {
            centerY = rectF2.bottom;
            centerY2 = rectF.bottom;
        }
        f = centerY - centerY2;
        return f + jVar.f1486c;
    }

    private float P(e eVar, i iVar, float f, float f2) {
        long c2 = iVar.c();
        long d2 = iVar.d();
        i e2 = eVar.f2452a.e("expansion");
        return b.d.a.a.k.a.a(f, f2, iVar.e().getInterpolation(((float) (((e2.c() + e2.d()) + 17) - c2)) / ((float) d2)));
    }

    private void Q(View view, RectF rectF) {
        rectF.set(0.0f, 0.0f, view.getWidth(), view.getHeight());
        int[] iArr = this.f;
        view.getLocationInWindow(iArr);
        rectF.offsetTo(iArr[0], iArr[1]);
        rectF.offset((int) (-view.getTranslationX()), (int) (-view.getTranslationY()));
    }

    private void R(View view, View view2, boolean z, boolean z2, e eVar, List<Animator> list, List<Animator.AnimatorListener> list2) {
        ViewGroup J;
        ObjectAnimator ofFloat;
        if (view2 instanceof ViewGroup) {
            if (((view2 instanceof b.d.a.a.m.d) && b.d.a.a.m.c.f1494a == 0) || (J = J(view2)) == null) {
                return;
            }
            if (z) {
                if (!z2) {
                    b.d.a.a.k.d.f1472a.set(J, Float.valueOf(0.0f));
                }
                ofFloat = ObjectAnimator.ofFloat(J, b.d.a.a.k.d.f1472a, 1.0f);
            } else {
                ofFloat = ObjectAnimator.ofFloat(J, b.d.a.a.k.d.f1472a, 0.0f);
            }
            eVar.f2452a.e("contentFade").a(ofFloat);
            list.add(ofFloat);
        }
    }

    private void S(View view, View view2, boolean z, boolean z2, e eVar, List<Animator> list, List<Animator.AnimatorListener> list2) {
        ObjectAnimator ofInt;
        if (view2 instanceof b.d.a.a.m.d) {
            b.d.a.a.m.d dVar = (b.d.a.a.m.d) view2;
            int Z = Z(view);
            int i = 16777215 & Z;
            if (z) {
                if (!z2) {
                    dVar.setCircularRevealScrimColor(Z);
                }
                ofInt = ObjectAnimator.ofInt(dVar, d.C0049d.f1498a, i);
            } else {
                ofInt = ObjectAnimator.ofInt(dVar, d.C0049d.f1498a, Z);
            }
            ofInt.setEvaluator(b.d.a.a.k.c.b());
            eVar.f2452a.e("color").a(ofInt);
            list.add(ofInt);
        }
    }

    @TargetApi(21)
    private void T(View view, View view2, boolean z, boolean z2, e eVar, List<Animator> list, List<Animator.AnimatorListener> list2) {
        ObjectAnimator ofFloat;
        float l = r.l(view2) - r.l(view);
        if (z) {
            if (!z2) {
                view2.setTranslationZ(-l);
            }
            ofFloat = ObjectAnimator.ofFloat(view2, View.TRANSLATION_Z, 0.0f);
        } else {
            ofFloat = ObjectAnimator.ofFloat(view2, View.TRANSLATION_Z, -l);
        }
        eVar.f2452a.e("elevation").a(ofFloat);
        list.add(ofFloat);
    }

    private void U(View view, View view2, boolean z, boolean z2, e eVar, float f, float f2, List<Animator> list, List<Animator.AnimatorListener> list2) {
        Animator animator;
        if (view2 instanceof b.d.a.a.m.d) {
            b.d.a.a.m.d dVar = (b.d.a.a.m.d) view2;
            float L = L(view, view2, eVar.f2453b);
            float M = M(view, view2, eVar.f2453b);
            ((FloatingActionButton) view).h(this.f2443c);
            float width = this.f2443c.width() / 2.0f;
            i e2 = eVar.f2452a.e("expansion");
            if (z) {
                if (!z2) {
                    dVar.setRevealInfo(new d.e(L, M, width));
                }
                if (z2) {
                    width = dVar.getRevealInfo().f1501c;
                }
                animator = b.d.a.a.m.a.a(dVar, L, M, b.d.a.a.o.a.b(L, M, 0.0f, 0.0f, f, f2));
                animator.addListener(new d(this, dVar));
                X(view2, e2.c(), (int) L, (int) M, width, list);
            } else {
                float f3 = dVar.getRevealInfo().f1501c;
                Animator a2 = b.d.a.a.m.a.a(dVar, L, M, width);
                int i = (int) L;
                int i2 = (int) M;
                X(view2, e2.c(), i, i2, f3, list);
                W(view2, e2.c(), e2.d(), eVar.f2452a.f(), i, i2, width, list);
                animator = a2;
            }
            e2.a(animator);
            list.add(animator);
            list2.add(b.d.a.a.m.a.b(dVar));
        }
    }

    private void V(View view, View view2, boolean z, boolean z2, e eVar, List<Animator> list, List<Animator.AnimatorListener> list2) {
        ObjectAnimator ofInt;
        if ((view2 instanceof b.d.a.a.m.d) && (view instanceof ImageView)) {
            b.d.a.a.m.d dVar = (b.d.a.a.m.d) view2;
            Drawable drawable = ((ImageView) view).getDrawable();
            if (drawable == null) {
                return;
            }
            drawable.mutate();
            if (z) {
                if (!z2) {
                    drawable.setAlpha(SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT);
                }
                ofInt = ObjectAnimator.ofInt(drawable, b.d.a.a.k.e.f1473b, 0);
            } else {
                ofInt = ObjectAnimator.ofInt(drawable, b.d.a.a.k.e.f1473b, SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT);
            }
            ofInt.addUpdateListener(new b(this, view2));
            eVar.f2452a.e("iconFade").a(ofInt);
            list.add(ofInt);
            list2.add(new c(this, dVar, drawable));
        }
    }

    private void W(View view, long j, long j2, long j3, int i, int i2, float f, List<Animator> list) {
        if (Build.VERSION.SDK_INT >= 21) {
            long j4 = j + j2;
            if (j4 < j3) {
                Animator createCircularReveal = ViewAnimationUtils.createCircularReveal(view, i, i2, f, f);
                createCircularReveal.setStartDelay(j4);
                createCircularReveal.setDuration(j3 - j4);
                list.add(createCircularReveal);
            }
        }
    }

    private void X(View view, long j, int i, int i2, float f, List<Animator> list) {
        if (Build.VERSION.SDK_INT < 21 || j <= 0) {
            return;
        }
        Animator createCircularReveal = ViewAnimationUtils.createCircularReveal(view, i, i2, f, f);
        createCircularReveal.setStartDelay(0L);
        createCircularReveal.setDuration(j);
        list.add(createCircularReveal);
    }

    private void Y(View view, View view2, boolean z, boolean z2, e eVar, List<Animator> list, List<Animator.AnimatorListener> list2, RectF rectF) {
        i e2;
        h hVar;
        String str;
        ObjectAnimator ofFloat;
        ObjectAnimator ofFloat2;
        int i;
        float N = N(view, view2, eVar.f2453b);
        float O = O(view, view2, eVar.f2453b);
        if (N == 0.0f || O == 0.0f) {
            e2 = eVar.f2452a.e("translationXLinear");
            hVar = eVar.f2452a;
            str = "translationYLinear";
        } else if ((!z || O >= 0.0f) && (z || i <= 0)) {
            e2 = eVar.f2452a.e("translationXCurveDownwards");
            hVar = eVar.f2452a;
            str = "translationYCurveDownwards";
        } else {
            e2 = eVar.f2452a.e("translationXCurveUpwards");
            hVar = eVar.f2452a;
            str = "translationYCurveUpwards";
        }
        i e3 = hVar.e(str);
        i iVar = e2;
        if (z) {
            if (!z2) {
                view2.setTranslationX(-N);
                view2.setTranslationY(-O);
            }
            ofFloat = ObjectAnimator.ofFloat(view2, View.TRANSLATION_X, 0.0f);
            ofFloat2 = ObjectAnimator.ofFloat(view2, View.TRANSLATION_Y, 0.0f);
            K(view2, eVar, iVar, e3, -N, -O, 0.0f, 0.0f, rectF);
        } else {
            ofFloat = ObjectAnimator.ofFloat(view2, View.TRANSLATION_X, -N);
            ofFloat2 = ObjectAnimator.ofFloat(view2, View.TRANSLATION_Y, -O);
        }
        iVar.a(ofFloat);
        e3.a(ofFloat2);
        list.add(ofFloat);
        list.add(ofFloat2);
    }

    private int Z(View view) {
        ColorStateList h = r.h(view);
        if (h != null) {
            return h.getColorForState(view.getDrawableState(), h.getDefaultColor());
        }
        return 0;
    }

    private ViewGroup b0(View view) {
        if (view instanceof ViewGroup) {
            return (ViewGroup) view;
        }
        return null;
    }

    @Override // com.google.android.material.transformation.ExpandableTransformationBehavior
    protected AnimatorSet I(View view, View view2, boolean z, boolean z2) {
        e a0 = a0(view2.getContext(), z);
        ArrayList arrayList = new ArrayList();
        ArrayList arrayList2 = new ArrayList();
        if (Build.VERSION.SDK_INT >= 21) {
            T(view, view2, z, z2, a0, arrayList, arrayList2);
        }
        RectF rectF = this.f2444d;
        Y(view, view2, z, z2, a0, arrayList, arrayList2, rectF);
        float width = rectF.width();
        float height = rectF.height();
        V(view, view2, z, z2, a0, arrayList, arrayList2);
        U(view, view2, z, z2, a0, width, height, arrayList, arrayList2);
        S(view, view2, z, z2, a0, arrayList, arrayList2);
        R(view, view2, z, z2, a0, arrayList, arrayList2);
        AnimatorSet animatorSet = new AnimatorSet();
        b.d.a.a.k.b.a(animatorSet, arrayList);
        animatorSet.addListener(new a(this, z, view2, view));
        int size = arrayList2.size();
        for (int i = 0; i < size; i++) {
            animatorSet.addListener(arrayList2.get(i));
        }
        return animatorSet;
    }

    protected abstract e a0(Context context, boolean z);

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public boolean e(CoordinatorLayout coordinatorLayout, View view, View view2) {
        if (view.getVisibility() != 8) {
            if (view2 instanceof FloatingActionButton) {
                int expandedComponentIdHint = ((FloatingActionButton) view2).getExpandedComponentIdHint();
                return expandedComponentIdHint == 0 || expandedComponentIdHint == view.getId();
            }
            return false;
        }
        throw new IllegalStateException("This behavior cannot be attached to a GONE view. Set the view to INVISIBLE instead.");
    }

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public void g(CoordinatorLayout.f fVar) {
        if (fVar.h == 0) {
            fVar.h = 80;
        }
    }
}
