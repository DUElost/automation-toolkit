package a.m;

import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.animation.AnimatorSet;
import android.animation.ObjectAnimator;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Path;
import android.graphics.PointF;
import android.graphics.Rect;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.Drawable;
import android.util.Property;
import android.view.View;
import android.view.ViewGroup;
import java.util.Map;
/* loaded from: classes.dex */
public class c extends m {
    private static final String[] N = {"android:changeBounds:bounds", "android:changeBounds:clip", "android:changeBounds:parent", "android:changeBounds:windowX", "android:changeBounds:windowY"};
    private static final Property<Drawable, PointF> O = new b(PointF.class, "boundsOrigin");
    private static final Property<k, PointF> P = new C0017c(PointF.class, "topLeft");
    private static final Property<k, PointF> Q = new d(PointF.class, "bottomRight");
    private static final Property<View, PointF> R = new e(PointF.class, "bottomRight");
    private static final Property<View, PointF> S = new f(PointF.class, "topLeft");
    private static final Property<View, PointF> T = new g(PointF.class, "position");
    private static a.m.k U = new a.m.k();
    private int[] K = new int[2];
    private boolean L = false;
    private boolean M = false;

    /* loaded from: classes.dex */
    class a extends AnimatorListenerAdapter {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ ViewGroup f241a;

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ BitmapDrawable f242b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ View f243c;

        /* renamed from: d  reason: collision with root package name */
        final /* synthetic */ float f244d;

        a(c cVar, ViewGroup viewGroup, BitmapDrawable bitmapDrawable, View view, float f) {
            this.f241a = viewGroup;
            this.f242b = bitmapDrawable;
            this.f243c = view;
            this.f244d = f;
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            d0.c(this.f241a).d(this.f242b);
            d0.h(this.f243c, this.f244d);
        }
    }

    /* loaded from: classes.dex */
    static class b extends Property<Drawable, PointF> {

        /* renamed from: a  reason: collision with root package name */
        private Rect f245a;

        b(Class cls, String str) {
            super(cls, str);
            this.f245a = new Rect();
        }

        @Override // android.util.Property
        /* renamed from: a */
        public PointF get(Drawable drawable) {
            drawable.copyBounds(this.f245a);
            Rect rect = this.f245a;
            return new PointF(rect.left, rect.top);
        }

        @Override // android.util.Property
        /* renamed from: b */
        public void set(Drawable drawable, PointF pointF) {
            drawable.copyBounds(this.f245a);
            this.f245a.offsetTo(Math.round(pointF.x), Math.round(pointF.y));
            drawable.setBounds(this.f245a);
        }
    }

    /* renamed from: a.m.c$c  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    static class C0017c extends Property<k, PointF> {
        C0017c(Class cls, String str) {
            super(cls, str);
        }

        @Override // android.util.Property
        /* renamed from: a */
        public PointF get(k kVar) {
            return null;
        }

        @Override // android.util.Property
        /* renamed from: b */
        public void set(k kVar, PointF pointF) {
            kVar.c(pointF);
        }
    }

    /* loaded from: classes.dex */
    static class d extends Property<k, PointF> {
        d(Class cls, String str) {
            super(cls, str);
        }

        @Override // android.util.Property
        /* renamed from: a */
        public PointF get(k kVar) {
            return null;
        }

        @Override // android.util.Property
        /* renamed from: b */
        public void set(k kVar, PointF pointF) {
            kVar.a(pointF);
        }
    }

    /* loaded from: classes.dex */
    static class e extends Property<View, PointF> {
        e(Class cls, String str) {
            super(cls, str);
        }

        @Override // android.util.Property
        /* renamed from: a */
        public PointF get(View view) {
            return null;
        }

        @Override // android.util.Property
        /* renamed from: b */
        public void set(View view, PointF pointF) {
            d0.g(view, view.getLeft(), view.getTop(), Math.round(pointF.x), Math.round(pointF.y));
        }
    }

    /* loaded from: classes.dex */
    static class f extends Property<View, PointF> {
        f(Class cls, String str) {
            super(cls, str);
        }

        @Override // android.util.Property
        /* renamed from: a */
        public PointF get(View view) {
            return null;
        }

        @Override // android.util.Property
        /* renamed from: b */
        public void set(View view, PointF pointF) {
            d0.g(view, Math.round(pointF.x), Math.round(pointF.y), view.getRight(), view.getBottom());
        }
    }

    /* loaded from: classes.dex */
    static class g extends Property<View, PointF> {
        g(Class cls, String str) {
            super(cls, str);
        }

        @Override // android.util.Property
        /* renamed from: a */
        public PointF get(View view) {
            return null;
        }

        @Override // android.util.Property
        /* renamed from: b */
        public void set(View view, PointF pointF) {
            int round = Math.round(pointF.x);
            int round2 = Math.round(pointF.y);
            d0.g(view, round, round2, view.getWidth() + round, view.getHeight() + round2);
        }
    }

    /* loaded from: classes.dex */
    class h extends AnimatorListenerAdapter {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ k f246a;
        private k mViewBounds;

        h(c cVar, k kVar) {
            this.f246a = kVar;
            this.mViewBounds = kVar;
        }
    }

    /* loaded from: classes.dex */
    class i extends AnimatorListenerAdapter {

        /* renamed from: a  reason: collision with root package name */
        private boolean f247a;

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ View f248b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ Rect f249c;

        /* renamed from: d  reason: collision with root package name */
        final /* synthetic */ int f250d;
        final /* synthetic */ int e;
        final /* synthetic */ int f;
        final /* synthetic */ int g;

        i(c cVar, View view, Rect rect, int i, int i2, int i3, int i4) {
            this.f248b = view;
            this.f249c = rect;
            this.f250d = i;
            this.e = i2;
            this.f = i3;
            this.g = i4;
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationCancel(Animator animator) {
            this.f247a = true;
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            if (this.f247a) {
                return;
            }
            a.f.l.r.U(this.f248b, this.f249c);
            d0.g(this.f248b, this.f250d, this.e, this.f, this.g);
        }
    }

    /* loaded from: classes.dex */
    class j extends n {

        /* renamed from: a  reason: collision with root package name */
        boolean f251a = false;

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ ViewGroup f252b;

        j(c cVar, ViewGroup viewGroup) {
            this.f252b = viewGroup;
        }

        @Override // a.m.n, a.m.m.f
        public void a(m mVar) {
            x.b(this.f252b, false);
        }

        @Override // a.m.n, a.m.m.f
        public void b(m mVar) {
            x.b(this.f252b, true);
        }

        @Override // a.m.m.f
        public void d(m mVar) {
            if (!this.f251a) {
                x.b(this.f252b, false);
            }
            mVar.O(this);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class k {

        /* renamed from: a  reason: collision with root package name */
        private int f253a;

        /* renamed from: b  reason: collision with root package name */
        private int f254b;

        /* renamed from: c  reason: collision with root package name */
        private int f255c;

        /* renamed from: d  reason: collision with root package name */
        private int f256d;
        private View e;
        private int f;
        private int g;

        k(View view) {
            this.e = view;
        }

        private void b() {
            d0.g(this.e, this.f253a, this.f254b, this.f255c, this.f256d);
            this.f = 0;
            this.g = 0;
        }

        void a(PointF pointF) {
            this.f255c = Math.round(pointF.x);
            this.f256d = Math.round(pointF.y);
            int i = this.g + 1;
            this.g = i;
            if (this.f == i) {
                b();
            }
        }

        void c(PointF pointF) {
            this.f253a = Math.round(pointF.x);
            this.f254b = Math.round(pointF.y);
            int i = this.f + 1;
            this.f = i;
            if (i == this.g) {
                b();
            }
        }
    }

    private void b0(s sVar) {
        View view = sVar.f316b;
        if (!a.f.l.r.E(view) && view.getWidth() == 0 && view.getHeight() == 0) {
            return;
        }
        sVar.f315a.put("android:changeBounds:bounds", new Rect(view.getLeft(), view.getTop(), view.getRight(), view.getBottom()));
        sVar.f315a.put("android:changeBounds:parent", sVar.f316b.getParent());
        if (this.M) {
            sVar.f316b.getLocationInWindow(this.K);
            sVar.f315a.put("android:changeBounds:windowX", Integer.valueOf(this.K[0]));
            sVar.f315a.put("android:changeBounds:windowY", Integer.valueOf(this.K[1]));
        }
        if (this.L) {
            sVar.f315a.put("android:changeBounds:clip", a.f.l.r.j(view));
        }
    }

    private boolean c0(View view, View view2) {
        if (this.M) {
            s s = s(view, true);
            if (s == null) {
                if (view == view2) {
                    return true;
                }
            } else if (view2 == s.f316b) {
                return true;
            }
            return false;
        }
        return true;
    }

    @Override // a.m.m
    public String[] C() {
        return N;
    }

    @Override // a.m.m
    public void f(s sVar) {
        b0(sVar);
    }

    @Override // a.m.m
    public void i(s sVar) {
        b0(sVar);
    }

    @Override // a.m.m
    public Animator m(ViewGroup viewGroup, s sVar, s sVar2) {
        int i2;
        View view;
        int i3;
        Rect rect;
        ObjectAnimator objectAnimator;
        Animator c2;
        Path a2;
        Property<View, PointF> property;
        if (sVar == null || sVar2 == null) {
            return null;
        }
        Map<String, Object> map = sVar.f315a;
        Map<String, Object> map2 = sVar2.f315a;
        ViewGroup viewGroup2 = (ViewGroup) map.get("android:changeBounds:parent");
        ViewGroup viewGroup3 = (ViewGroup) map2.get("android:changeBounds:parent");
        if (viewGroup2 == null || viewGroup3 == null) {
            return null;
        }
        View view2 = sVar2.f316b;
        if (!c0(viewGroup2, viewGroup3)) {
            int intValue = ((Integer) sVar.f315a.get("android:changeBounds:windowX")).intValue();
            int intValue2 = ((Integer) sVar.f315a.get("android:changeBounds:windowY")).intValue();
            int intValue3 = ((Integer) sVar2.f315a.get("android:changeBounds:windowX")).intValue();
            int intValue4 = ((Integer) sVar2.f315a.get("android:changeBounds:windowY")).intValue();
            if (intValue == intValue3 && intValue2 == intValue4) {
                return null;
            }
            viewGroup.getLocationInWindow(this.K);
            Bitmap createBitmap = Bitmap.createBitmap(view2.getWidth(), view2.getHeight(), Bitmap.Config.ARGB_8888);
            view2.draw(new Canvas(createBitmap));
            BitmapDrawable bitmapDrawable = new BitmapDrawable(createBitmap);
            float d2 = d0.d(view2);
            d0.h(view2, 0.0f);
            d0.c(viewGroup).b(bitmapDrawable);
            a.m.g u = u();
            int[] iArr = this.K;
            ObjectAnimator ofPropertyValuesHolder = ObjectAnimator.ofPropertyValuesHolder(bitmapDrawable, a.m.i.a(O, u.a(intValue - iArr[0], intValue2 - iArr[1], intValue3 - iArr[0], intValue4 - iArr[1])));
            ofPropertyValuesHolder.addListener(new a(this, viewGroup, bitmapDrawable, view2, d2));
            return ofPropertyValuesHolder;
        }
        Rect rect2 = (Rect) sVar.f315a.get("android:changeBounds:bounds");
        Rect rect3 = (Rect) sVar2.f315a.get("android:changeBounds:bounds");
        int i4 = rect2.left;
        int i5 = rect3.left;
        int i6 = rect2.top;
        int i7 = rect3.top;
        int i8 = rect2.right;
        int i9 = rect3.right;
        int i10 = rect2.bottom;
        int i11 = rect3.bottom;
        int i12 = i8 - i4;
        int i13 = i10 - i6;
        int i14 = i9 - i5;
        int i15 = i11 - i7;
        Rect rect4 = (Rect) sVar.f315a.get("android:changeBounds:clip");
        Rect rect5 = (Rect) sVar2.f315a.get("android:changeBounds:clip");
        if ((i12 == 0 || i13 == 0) && (i14 == 0 || i15 == 0)) {
            i2 = 0;
        } else {
            i2 = (i4 == i5 && i6 == i7) ? 0 : 1;
            if (i8 != i9 || i10 != i11) {
                i2++;
            }
        }
        if ((rect4 != null && !rect4.equals(rect5)) || (rect4 == null && rect5 != null)) {
            i2++;
        }
        if (i2 > 0) {
            if (this.L) {
                view = view2;
                d0.g(view, i4, i6, Math.max(i12, i14) + i4, Math.max(i13, i15) + i6);
                ObjectAnimator a3 = (i4 == i5 && i6 == i7) ? null : a.m.f.a(view, T, u().a(i4, i6, i5, i7));
                if (rect4 == null) {
                    i3 = 0;
                    rect = new Rect(0, 0, i12, i13);
                } else {
                    i3 = 0;
                    rect = rect4;
                }
                Rect rect6 = rect5 == null ? new Rect(i3, i3, i14, i15) : rect5;
                if (rect.equals(rect6)) {
                    objectAnimator = null;
                } else {
                    a.f.l.r.U(view, rect);
                    a.m.k kVar = U;
                    Object[] objArr = new Object[2];
                    objArr[i3] = rect;
                    objArr[1] = rect6;
                    ObjectAnimator ofObject = ObjectAnimator.ofObject(view, "clipBounds", kVar, objArr);
                    ofObject.addListener(new i(this, view, rect5, i5, i7, i9, i11));
                    objectAnimator = ofObject;
                }
                c2 = r.c(a3, objectAnimator);
            } else {
                view = view2;
                d0.g(view, i4, i6, i8, i10);
                if (i2 == 2) {
                    if (i12 == i14 && i13 == i15) {
                        a2 = u().a(i4, i6, i5, i7);
                        property = T;
                    } else {
                        k kVar2 = new k(view);
                        ObjectAnimator a4 = a.m.f.a(kVar2, P, u().a(i4, i6, i5, i7));
                        ObjectAnimator a5 = a.m.f.a(kVar2, Q, u().a(i8, i10, i9, i11));
                        AnimatorSet animatorSet = new AnimatorSet();
                        animatorSet.playTogether(a4, a5);
                        animatorSet.addListener(new h(this, kVar2));
                        c2 = animatorSet;
                    }
                } else if (i4 == i5 && i6 == i7) {
                    a2 = u().a(i8, i10, i9, i11);
                    property = R;
                } else {
                    a2 = u().a(i4, i6, i5, i7);
                    property = S;
                }
                c2 = a.m.f.a(view, property, a2);
            }
            if (view.getParent() instanceof ViewGroup) {
                ViewGroup viewGroup4 = (ViewGroup) view.getParent();
                x.b(viewGroup4, true);
                a(new j(this, viewGroup4));
            }
            return c2;
        }
        return null;
    }
}
