package com.google.android.material.tabs;

import a.f.l.p;
import a.f.l.r;
import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.animation.ValueAnimator;
import android.annotation.TargetApi;
import android.content.Context;
import android.content.res.ColorStateList;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.database.DataSetObserver;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.PorterDuff;
import android.graphics.RectF;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.GradientDrawable;
import android.graphics.drawable.LayerDrawable;
import android.graphics.drawable.RippleDrawable;
import android.os.Build;
import android.text.Layout;
import android.text.TextUtils;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewParent;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.widget.FrameLayout;
import android.widget.HorizontalScrollView;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import androidx.appcompat.app.a;
import androidx.appcompat.widget.s0;
import androidx.viewpager.widget.ViewPager;
import b.d.a.a.j;
import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.Iterator;
@ViewPager.e
/* loaded from: classes.dex */
public class TabLayout extends HorizontalScrollView {
    private static final a.f.k.d<f> P = new a.f.k.f(16);
    int A;
    boolean B;
    boolean C;
    boolean D;
    private c E;
    private final ArrayList<c> F;
    private c G;
    private ValueAnimator H;
    ViewPager I;
    private androidx.viewpager.widget.a J;
    private DataSetObserver K;
    private g L;
    private b M;
    private boolean N;
    private final a.f.k.d<h> O;

    /* renamed from: b  reason: collision with root package name */
    private final ArrayList<f> f2406b;

    /* renamed from: c  reason: collision with root package name */
    private f f2407c;

    /* renamed from: d  reason: collision with root package name */
    private final RectF f2408d;
    private final e e;
    int f;
    int g;
    int h;
    int i;
    int j;
    ColorStateList k;
    ColorStateList l;
    ColorStateList m;
    Drawable n;
    PorterDuff.Mode o;
    float p;
    float q;
    final int r;
    int s;
    private final int t;
    private final int u;
    private final int v;
    private int w;
    int x;
    int y;
    int z;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a implements ValueAnimator.AnimatorUpdateListener {
        a() {
        }

        @Override // android.animation.ValueAnimator.AnimatorUpdateListener
        public void onAnimationUpdate(ValueAnimator valueAnimator) {
            TabLayout.this.scrollTo(((Integer) valueAnimator.getAnimatedValue()).intValue(), 0);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class b implements ViewPager.i {

        /* renamed from: a  reason: collision with root package name */
        private boolean f2410a;

        b() {
        }

        @Override // androidx.viewpager.widget.ViewPager.i
        public void a(ViewPager viewPager, androidx.viewpager.widget.a aVar, androidx.viewpager.widget.a aVar2) {
            TabLayout tabLayout = TabLayout.this;
            if (tabLayout.I == viewPager) {
                tabLayout.E(aVar2, this.f2410a);
            }
        }

        void b(boolean z) {
            this.f2410a = z;
        }
    }

    /* loaded from: classes.dex */
    public interface c<T extends f> {
        void a(T t);

        void b(T t);

        void c(T t);
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class d extends DataSetObserver {
        d() {
        }

        @Override // android.database.DataSetObserver
        public void onChanged() {
            TabLayout.this.x();
        }

        @Override // android.database.DataSetObserver
        public void onInvalidated() {
            TabLayout.this.x();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class e extends LinearLayout {

        /* renamed from: b  reason: collision with root package name */
        private int f2413b;

        /* renamed from: c  reason: collision with root package name */
        private final Paint f2414c;

        /* renamed from: d  reason: collision with root package name */
        private final GradientDrawable f2415d;
        int e;
        float f;
        private int g;
        private int h;
        private int i;
        private ValueAnimator j;

        /* JADX INFO: Access modifiers changed from: package-private */
        /* loaded from: classes.dex */
        public class a implements ValueAnimator.AnimatorUpdateListener {

            /* renamed from: a  reason: collision with root package name */
            final /* synthetic */ int f2416a;

            /* renamed from: b  reason: collision with root package name */
            final /* synthetic */ int f2417b;

            /* renamed from: c  reason: collision with root package name */
            final /* synthetic */ int f2418c;

            /* renamed from: d  reason: collision with root package name */
            final /* synthetic */ int f2419d;

            a(int i, int i2, int i3, int i4) {
                this.f2416a = i;
                this.f2417b = i2;
                this.f2418c = i3;
                this.f2419d = i4;
            }

            @Override // android.animation.ValueAnimator.AnimatorUpdateListener
            public void onAnimationUpdate(ValueAnimator valueAnimator) {
                float animatedFraction = valueAnimator.getAnimatedFraction();
                e.this.d(b.d.a.a.k.a.b(this.f2416a, this.f2417b, animatedFraction), b.d.a.a.k.a.b(this.f2418c, this.f2419d, animatedFraction));
            }
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        /* loaded from: classes.dex */
        public class b extends AnimatorListenerAdapter {

            /* renamed from: a  reason: collision with root package name */
            final /* synthetic */ int f2420a;

            b(int i) {
                this.f2420a = i;
            }

            @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
            public void onAnimationEnd(Animator animator) {
                e eVar = e.this;
                eVar.e = this.f2420a;
                eVar.f = 0.0f;
            }
        }

        e(Context context) {
            super(context);
            this.e = -1;
            this.g = -1;
            this.h = -1;
            this.i = -1;
            setWillNotDraw(false);
            this.f2414c = new Paint();
            this.f2415d = new GradientDrawable();
        }

        private void b(h hVar, RectF rectF) {
            int f = hVar.f();
            if (f < TabLayout.this.t(24)) {
                f = TabLayout.this.t(24);
            }
            int left = (hVar.getLeft() + hVar.getRight()) / 2;
            int i = f / 2;
            rectF.set(left - i, 0.0f, left + i, 0.0f);
        }

        private void h() {
            int i;
            int i2;
            View childAt = getChildAt(this.e);
            if (childAt == null || childAt.getWidth() <= 0) {
                i = -1;
                i2 = -1;
            } else {
                i = childAt.getLeft();
                i2 = childAt.getRight();
                TabLayout tabLayout = TabLayout.this;
                if (!tabLayout.C && (childAt instanceof h)) {
                    b((h) childAt, tabLayout.f2408d);
                    i = (int) TabLayout.this.f2408d.left;
                    i2 = (int) TabLayout.this.f2408d.right;
                }
                if (this.f > 0.0f && this.e < getChildCount() - 1) {
                    View childAt2 = getChildAt(this.e + 1);
                    int left = childAt2.getLeft();
                    int right = childAt2.getRight();
                    TabLayout tabLayout2 = TabLayout.this;
                    if (!tabLayout2.C && (childAt2 instanceof h)) {
                        b((h) childAt2, tabLayout2.f2408d);
                        left = (int) TabLayout.this.f2408d.left;
                        right = (int) TabLayout.this.f2408d.right;
                    }
                    float f = this.f;
                    i = (int) ((left * f) + ((1.0f - f) * i));
                    i2 = (int) ((right * f) + ((1.0f - f) * i2));
                }
            }
            d(i, i2);
        }

        void a(int i, int i2) {
            ValueAnimator valueAnimator = this.j;
            if (valueAnimator != null && valueAnimator.isRunning()) {
                this.j.cancel();
            }
            View childAt = getChildAt(i);
            if (childAt == null) {
                h();
                return;
            }
            int left = childAt.getLeft();
            int right = childAt.getRight();
            TabLayout tabLayout = TabLayout.this;
            if (!tabLayout.C && (childAt instanceof h)) {
                b((h) childAt, tabLayout.f2408d);
                left = (int) TabLayout.this.f2408d.left;
                right = (int) TabLayout.this.f2408d.right;
            }
            int i3 = left;
            int i4 = right;
            int i5 = this.h;
            int i6 = this.i;
            if (i5 == i3 && i6 == i4) {
                return;
            }
            ValueAnimator valueAnimator2 = new ValueAnimator();
            this.j = valueAnimator2;
            valueAnimator2.setInterpolator(b.d.a.a.k.a.f1467a);
            valueAnimator2.setDuration(i2);
            valueAnimator2.setFloatValues(0.0f, 1.0f);
            valueAnimator2.addUpdateListener(new a(i5, i3, i6, i4));
            valueAnimator2.addListener(new b(i));
            valueAnimator2.start();
        }

        boolean c() {
            int childCount = getChildCount();
            for (int i = 0; i < childCount; i++) {
                if (getChildAt(i).getWidth() <= 0) {
                    return true;
                }
            }
            return false;
        }

        void d(int i, int i2) {
            if (i == this.h && i2 == this.i) {
                return;
            }
            this.h = i;
            this.i = i2;
            r.K(this);
        }

        /* JADX WARN: Removed duplicated region for block: B:27:0x0049  */
        /* JADX WARN: Removed duplicated region for block: B:30:0x005a  */
        @Override // android.view.View
        /*
            Code decompiled incorrectly, please refer to instructions dump.
            To view partially-correct add '--show-bad-code' argument
        */
        public void draw(android.graphics.Canvas r6) {
            /*
                r5 = this;
                com.google.android.material.tabs.TabLayout r0 = com.google.android.material.tabs.TabLayout.this
                android.graphics.drawable.Drawable r0 = r0.n
                r1 = 0
                if (r0 == 0) goto Lc
                int r0 = r0.getIntrinsicHeight()
                goto Ld
            Lc:
                r0 = r1
            Ld:
                int r2 = r5.f2413b
                if (r2 < 0) goto L12
                r0 = r2
            L12:
                com.google.android.material.tabs.TabLayout r2 = com.google.android.material.tabs.TabLayout.this
                int r2 = r2.z
                if (r2 == 0) goto L31
                r3 = 1
                r4 = 2
                if (r2 == r3) goto L23
                if (r2 == r4) goto L3a
                r0 = 3
                if (r2 == r0) goto L36
                r0 = r1
                goto L3a
            L23:
                int r1 = r5.getHeight()
                int r1 = r1 - r0
                int r1 = r1 / r4
                int r2 = r5.getHeight()
                int r2 = r2 + r0
                int r0 = r2 / 2
                goto L3a
            L31:
                int r1 = r5.getHeight()
                int r1 = r1 - r0
            L36:
                int r0 = r5.getHeight()
            L3a:
                int r2 = r5.h
                if (r2 < 0) goto L70
                int r3 = r5.i
                if (r3 <= r2) goto L70
                com.google.android.material.tabs.TabLayout r2 = com.google.android.material.tabs.TabLayout.this
                android.graphics.drawable.Drawable r2 = r2.n
                if (r2 == 0) goto L49
                goto L4b
            L49:
                android.graphics.drawable.GradientDrawable r2 = r5.f2415d
            L4b:
                android.graphics.drawable.Drawable r2 = androidx.core.graphics.drawable.a.q(r2)
                int r3 = r5.h
                int r4 = r5.i
                r2.setBounds(r3, r1, r4, r0)
                android.graphics.Paint r0 = r5.f2414c
                if (r0 == 0) goto L6d
                int r1 = android.os.Build.VERSION.SDK_INT
                r3 = 21
                int r0 = r0.getColor()
                if (r1 != r3) goto L6a
                android.graphics.PorterDuff$Mode r1 = android.graphics.PorterDuff.Mode.SRC_IN
                r2.setColorFilter(r0, r1)
                goto L6d
            L6a:
                androidx.core.graphics.drawable.a.n(r2, r0)
            L6d:
                r2.draw(r6)
            L70:
                super.draw(r6)
                return
            */
            throw new UnsupportedOperationException("Method not decompiled: com.google.android.material.tabs.TabLayout.e.draw(android.graphics.Canvas):void");
        }

        void e(int i, float f) {
            ValueAnimator valueAnimator = this.j;
            if (valueAnimator != null && valueAnimator.isRunning()) {
                this.j.cancel();
            }
            this.e = i;
            this.f = f;
            h();
        }

        void f(int i) {
            if (this.f2414c.getColor() != i) {
                this.f2414c.setColor(i);
                r.K(this);
            }
        }

        void g(int i) {
            if (this.f2413b != i) {
                this.f2413b = i;
                r.K(this);
            }
        }

        @Override // android.widget.LinearLayout, android.view.ViewGroup, android.view.View
        protected void onLayout(boolean z, int i, int i2, int i3, int i4) {
            super.onLayout(z, i, i2, i3, i4);
            ValueAnimator valueAnimator = this.j;
            if (valueAnimator == null || !valueAnimator.isRunning()) {
                h();
                return;
            }
            this.j.cancel();
            a(this.e, Math.round((1.0f - this.j.getAnimatedFraction()) * ((float) this.j.getDuration())));
        }

        @Override // android.widget.LinearLayout, android.view.View
        protected void onMeasure(int i, int i2) {
            super.onMeasure(i, i2);
            if (View.MeasureSpec.getMode(i) != 1073741824) {
                return;
            }
            TabLayout tabLayout = TabLayout.this;
            boolean z = true;
            if (tabLayout.A == 1 && tabLayout.x == 1) {
                int childCount = getChildCount();
                int i3 = 0;
                for (int i4 = 0; i4 < childCount; i4++) {
                    View childAt = getChildAt(i4);
                    if (childAt.getVisibility() == 0) {
                        i3 = Math.max(i3, childAt.getMeasuredWidth());
                    }
                }
                if (i3 <= 0) {
                    return;
                }
                if (i3 * childCount <= getMeasuredWidth() - (TabLayout.this.t(16) * 2)) {
                    boolean z2 = false;
                    for (int i5 = 0; i5 < childCount; i5++) {
                        LinearLayout.LayoutParams layoutParams = (LinearLayout.LayoutParams) getChildAt(i5).getLayoutParams();
                        if (layoutParams.width != i3 || layoutParams.weight != 0.0f) {
                            layoutParams.width = i3;
                            layoutParams.weight = 0.0f;
                            z2 = true;
                        }
                    }
                    z = z2;
                } else {
                    TabLayout tabLayout2 = TabLayout.this;
                    tabLayout2.x = 0;
                    tabLayout2.L(false);
                }
                if (z) {
                    super.onMeasure(i, i2);
                }
            }
        }

        @Override // android.widget.LinearLayout, android.view.View
        public void onRtlPropertiesChanged(int i) {
            super.onRtlPropertiesChanged(i);
            if (Build.VERSION.SDK_INT >= 23 || this.g == i) {
                return;
            }
            requestLayout();
            this.g = i;
        }
    }

    /* loaded from: classes.dex */
    public static class f {

        /* renamed from: a  reason: collision with root package name */
        private Drawable f2422a;

        /* renamed from: b  reason: collision with root package name */
        private CharSequence f2423b;

        /* renamed from: c  reason: collision with root package name */
        private CharSequence f2424c;

        /* renamed from: d  reason: collision with root package name */
        private int f2425d = -1;
        private View e;
        public TabLayout f;
        public h g;

        public View c() {
            return this.e;
        }

        public Drawable d() {
            return this.f2422a;
        }

        public int e() {
            return this.f2425d;
        }

        public CharSequence f() {
            return this.f2423b;
        }

        public boolean g() {
            TabLayout tabLayout = this.f;
            if (tabLayout != null) {
                return tabLayout.getSelectedTabPosition() == this.f2425d;
            }
            throw new IllegalArgumentException("Tab not attached to a TabLayout");
        }

        void h() {
            this.f = null;
            this.g = null;
            this.f2422a = null;
            this.f2423b = null;
            this.f2424c = null;
            this.f2425d = -1;
            this.e = null;
        }

        public void i() {
            TabLayout tabLayout = this.f;
            if (tabLayout == null) {
                throw new IllegalArgumentException("Tab not attached to a TabLayout");
            }
            tabLayout.C(this);
        }

        public f j(CharSequence charSequence) {
            this.f2424c = charSequence;
            p();
            return this;
        }

        public f k(int i) {
            l(LayoutInflater.from(this.g.getContext()).inflate(i, (ViewGroup) this.g, false));
            return this;
        }

        public f l(View view) {
            this.e = view;
            p();
            return this;
        }

        public f m(Drawable drawable) {
            this.f2422a = drawable;
            p();
            return this;
        }

        void n(int i) {
            this.f2425d = i;
        }

        public f o(CharSequence charSequence) {
            if (TextUtils.isEmpty(this.f2424c) && !TextUtils.isEmpty(charSequence)) {
                this.g.setContentDescription(charSequence);
            }
            this.f2423b = charSequence;
            p();
            return this;
        }

        void p() {
            h hVar = this.g;
            if (hVar != null) {
                hVar.i();
            }
        }
    }

    /* loaded from: classes.dex */
    public static class g implements ViewPager.j {

        /* renamed from: b  reason: collision with root package name */
        private final WeakReference<TabLayout> f2426b;

        /* renamed from: c  reason: collision with root package name */
        private int f2427c;

        /* renamed from: d  reason: collision with root package name */
        private int f2428d;

        public g(TabLayout tabLayout) {
            this.f2426b = new WeakReference<>(tabLayout);
        }

        void a() {
            this.f2428d = 0;
            this.f2427c = 0;
        }

        @Override // androidx.viewpager.widget.ViewPager.j
        public void c(int i, float f, int i2) {
            TabLayout tabLayout = this.f2426b.get();
            if (tabLayout != null) {
                int i3 = this.f2428d;
                boolean z = false;
                boolean z2 = i3 != 2 || this.f2427c == 1;
                if (i3 != 2 || this.f2427c != 0) {
                    z = true;
                }
                tabLayout.G(i, f, z2, z);
            }
        }

        @Override // androidx.viewpager.widget.ViewPager.j
        public void f(int i) {
            this.f2427c = this.f2428d;
            this.f2428d = i;
        }

        @Override // androidx.viewpager.widget.ViewPager.j
        public void j(int i) {
            TabLayout tabLayout = this.f2426b.get();
            if (tabLayout == null || tabLayout.getSelectedTabPosition() == i || i >= tabLayout.getTabCount()) {
                return;
            }
            int i2 = this.f2428d;
            tabLayout.D(tabLayout.v(i), i2 == 0 || (i2 == 2 && this.f2427c == 0));
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class h extends LinearLayout {

        /* renamed from: b  reason: collision with root package name */
        private f f2429b;

        /* renamed from: c  reason: collision with root package name */
        private TextView f2430c;

        /* renamed from: d  reason: collision with root package name */
        private ImageView f2431d;
        private View e;
        private TextView f;
        private ImageView g;
        private Drawable h;
        private int i;

        public h(Context context) {
            super(context);
            this.i = 2;
            j(context);
            r.c0(this, TabLayout.this.f, TabLayout.this.g, TabLayout.this.h, TabLayout.this.i);
            setGravity(17);
            setOrientation(!TabLayout.this.B ? 1 : 0);
            setClickable(true);
            r.d0(this, p.b(getContext(), 1002));
        }

        private float d(Layout layout, int i, float f) {
            return layout.getLineWidth(i) * (f / layout.getPaint().getTextSize());
        }

        /* JADX INFO: Access modifiers changed from: private */
        public void e(Canvas canvas) {
            Drawable drawable = this.h;
            if (drawable != null) {
                drawable.setBounds(getLeft(), getTop(), getRight(), getBottom());
                this.h.draw(canvas);
            }
        }

        /* JADX INFO: Access modifiers changed from: private */
        public int f() {
            View[] viewArr = {this.f2430c, this.f2431d, this.e};
            int i = 0;
            int i2 = 0;
            boolean z = false;
            for (int i3 = 0; i3 < 3; i3++) {
                View view = viewArr[i3];
                if (view != null && view.getVisibility() == 0) {
                    i2 = z ? Math.min(i2, view.getLeft()) : view.getLeft();
                    i = z ? Math.max(i, view.getRight()) : view.getRight();
                    z = true;
                }
            }
            return i - i2;
        }

        /* JADX INFO: Access modifiers changed from: private */
        /* JADX WARN: Multi-variable type inference failed */
        /* JADX WARN: Type inference failed for: r0v3, types: [android.graphics.drawable.RippleDrawable] */
        /* JADX WARN: Type inference failed for: r2v3, types: [android.graphics.drawable.LayerDrawable] */
        public void j(Context context) {
            int i = TabLayout.this.r;
            if (i != 0) {
                Drawable d2 = a.a.k.a.a.d(context, i);
                this.h = d2;
                if (d2 != null && d2.isStateful()) {
                    this.h.setState(getDrawableState());
                }
            } else {
                this.h = null;
            }
            GradientDrawable gradientDrawable = new GradientDrawable();
            gradientDrawable.setColor(0);
            if (TabLayout.this.m != null) {
                GradientDrawable gradientDrawable2 = new GradientDrawable();
                gradientDrawable2.setCornerRadius(1.0E-5f);
                gradientDrawable2.setColor(-1);
                ColorStateList a2 = b.d.a.a.q.a.a(TabLayout.this.m);
                if (Build.VERSION.SDK_INT >= 21) {
                    boolean z = TabLayout.this.D;
                    if (z) {
                        gradientDrawable = null;
                    }
                    gradientDrawable = new RippleDrawable(a2, gradientDrawable, z ? null : gradientDrawable2);
                } else {
                    Drawable q = androidx.core.graphics.drawable.a.q(gradientDrawable2);
                    androidx.core.graphics.drawable.a.o(q, a2);
                    gradientDrawable = new LayerDrawable(new Drawable[]{gradientDrawable, q});
                }
            }
            r.Q(this, gradientDrawable);
            TabLayout.this.invalidate();
        }

        private void l(TextView textView, ImageView imageView) {
            f fVar = this.f2429b;
            Drawable mutate = (fVar == null || fVar.d() == null) ? null : androidx.core.graphics.drawable.a.q(this.f2429b.d()).mutate();
            f fVar2 = this.f2429b;
            CharSequence f = fVar2 != null ? fVar2.f() : null;
            if (imageView != null) {
                if (mutate != null) {
                    imageView.setImageDrawable(mutate);
                    imageView.setVisibility(0);
                    setVisibility(0);
                } else {
                    imageView.setVisibility(8);
                    imageView.setImageDrawable(null);
                }
            }
            boolean z = !TextUtils.isEmpty(f);
            if (textView != null) {
                if (z) {
                    textView.setText(f);
                    textView.setVisibility(0);
                    setVisibility(0);
                } else {
                    textView.setVisibility(8);
                    textView.setText((CharSequence) null);
                }
            }
            if (imageView != null) {
                ViewGroup.MarginLayoutParams marginLayoutParams = (ViewGroup.MarginLayoutParams) imageView.getLayoutParams();
                int t = (z && imageView.getVisibility() == 0) ? TabLayout.this.t(8) : 0;
                if (TabLayout.this.B) {
                    if (t != a.f.l.f.a(marginLayoutParams)) {
                        a.f.l.f.c(marginLayoutParams, t);
                        marginLayoutParams.bottomMargin = 0;
                        imageView.setLayoutParams(marginLayoutParams);
                        imageView.requestLayout();
                    }
                } else if (t != marginLayoutParams.bottomMargin) {
                    marginLayoutParams.bottomMargin = t;
                    a.f.l.f.c(marginLayoutParams, 0);
                    imageView.setLayoutParams(marginLayoutParams);
                    imageView.requestLayout();
                }
            }
            f fVar3 = this.f2429b;
            s0.a(this, z ? null : fVar3 != null ? fVar3.f2424c : null);
        }

        @Override // android.view.ViewGroup, android.view.View
        protected void drawableStateChanged() {
            super.drawableStateChanged();
            int[] drawableState = getDrawableState();
            Drawable drawable = this.h;
            boolean z = false;
            if (drawable != null && drawable.isStateful()) {
                z = false | this.h.setState(drawableState);
            }
            if (z) {
                invalidate();
                TabLayout.this.invalidate();
            }
        }

        void g() {
            h(null);
            setSelected(false);
        }

        void h(f fVar) {
            if (fVar != this.f2429b) {
                this.f2429b = fVar;
                i();
            }
        }

        final void i() {
            TextView textView;
            ImageView imageView;
            f fVar = this.f2429b;
            Drawable drawable = null;
            View c2 = fVar != null ? fVar.c() : null;
            if (c2 != null) {
                ViewParent parent = c2.getParent();
                if (parent != this) {
                    if (parent != null) {
                        ((ViewGroup) parent).removeView(c2);
                    }
                    addView(c2);
                }
                this.e = c2;
                TextView textView2 = this.f2430c;
                if (textView2 != null) {
                    textView2.setVisibility(8);
                }
                ImageView imageView2 = this.f2431d;
                if (imageView2 != null) {
                    imageView2.setVisibility(8);
                    this.f2431d.setImageDrawable(null);
                }
                TextView textView3 = (TextView) c2.findViewById(16908308);
                this.f = textView3;
                if (textView3 != null) {
                    this.i = androidx.core.widget.i.c(textView3);
                }
                this.g = (ImageView) c2.findViewById(16908294);
            } else {
                View view = this.e;
                if (view != null) {
                    removeView(view);
                    this.e = null;
                }
                this.f = null;
                this.g = null;
            }
            boolean z = false;
            if (this.e != null) {
                textView = this.f;
                if (textView != null || this.g != null) {
                    imageView = this.g;
                }
                if (fVar != null && !TextUtils.isEmpty(fVar.f2424c)) {
                    setContentDescription(fVar.f2424c);
                }
                if (fVar != null && fVar.g()) {
                    z = true;
                }
                setSelected(z);
            }
            if (this.f2431d == null) {
                ImageView imageView3 = (ImageView) LayoutInflater.from(getContext()).inflate(b.d.a.a.h.design_layout_tab_icon, (ViewGroup) this, false);
                addView(imageView3, 0);
                this.f2431d = imageView3;
            }
            if (fVar != null && fVar.d() != null) {
                drawable = androidx.core.graphics.drawable.a.q(fVar.d()).mutate();
            }
            if (drawable != null) {
                androidx.core.graphics.drawable.a.o(drawable, TabLayout.this.l);
                PorterDuff.Mode mode = TabLayout.this.o;
                if (mode != null) {
                    androidx.core.graphics.drawable.a.p(drawable, mode);
                }
            }
            if (this.f2430c == null) {
                TextView textView4 = (TextView) LayoutInflater.from(getContext()).inflate(b.d.a.a.h.design_layout_tab_text, (ViewGroup) this, false);
                addView(textView4);
                this.f2430c = textView4;
                this.i = androidx.core.widget.i.c(textView4);
            }
            androidx.core.widget.i.n(this.f2430c, TabLayout.this.j);
            ColorStateList colorStateList = TabLayout.this.k;
            if (colorStateList != null) {
                this.f2430c.setTextColor(colorStateList);
            }
            textView = this.f2430c;
            imageView = this.f2431d;
            l(textView, imageView);
            if (fVar != null) {
                setContentDescription(fVar.f2424c);
            }
            if (fVar != null) {
                z = true;
            }
            setSelected(z);
        }

        final void k() {
            ImageView imageView;
            setOrientation(!TabLayout.this.B ? 1 : 0);
            TextView textView = this.f;
            if (textView == null && this.g == null) {
                textView = this.f2430c;
                imageView = this.f2431d;
            } else {
                imageView = this.g;
            }
            l(textView, imageView);
        }

        @Override // android.view.View
        public void onInitializeAccessibilityEvent(AccessibilityEvent accessibilityEvent) {
            super.onInitializeAccessibilityEvent(accessibilityEvent);
            accessibilityEvent.setClassName(a.c.class.getName());
        }

        @Override // android.view.View
        @TargetApi(14)
        public void onInitializeAccessibilityNodeInfo(AccessibilityNodeInfo accessibilityNodeInfo) {
            super.onInitializeAccessibilityNodeInfo(accessibilityNodeInfo);
            accessibilityNodeInfo.setClassName(a.c.class.getName());
        }

        @Override // android.widget.LinearLayout, android.view.View
        public void onMeasure(int i, int i2) {
            Layout layout;
            int size = View.MeasureSpec.getSize(i);
            int mode = View.MeasureSpec.getMode(i);
            int tabMaxWidth = TabLayout.this.getTabMaxWidth();
            if (tabMaxWidth > 0 && (mode == 0 || size > tabMaxWidth)) {
                i = View.MeasureSpec.makeMeasureSpec(TabLayout.this.s, Integer.MIN_VALUE);
            }
            super.onMeasure(i, i2);
            if (this.f2430c != null) {
                float f = TabLayout.this.p;
                int i3 = this.i;
                ImageView imageView = this.f2431d;
                boolean z = true;
                if (imageView == null || imageView.getVisibility() != 0) {
                    TextView textView = this.f2430c;
                    if (textView != null && textView.getLineCount() > 1) {
                        f = TabLayout.this.q;
                    }
                } else {
                    i3 = 1;
                }
                float textSize = this.f2430c.getTextSize();
                int lineCount = this.f2430c.getLineCount();
                int c2 = androidx.core.widget.i.c(this.f2430c);
                int i4 = (f > textSize ? 1 : (f == textSize ? 0 : -1));
                if (i4 != 0 || (c2 >= 0 && i3 != c2)) {
                    if (TabLayout.this.A == 1 && i4 > 0 && lineCount == 1 && ((layout = this.f2430c.getLayout()) == null || d(layout, 0, f) > (getMeasuredWidth() - getPaddingLeft()) - getPaddingRight())) {
                        z = false;
                    }
                    if (z) {
                        this.f2430c.setTextSize(0, f);
                        this.f2430c.setMaxLines(i3);
                        super.onMeasure(i, i2);
                    }
                }
            }
        }

        @Override // android.view.View
        public boolean performClick() {
            boolean performClick = super.performClick();
            if (this.f2429b != null) {
                if (!performClick) {
                    playSoundEffect(0);
                }
                this.f2429b.i();
                return true;
            }
            return performClick;
        }

        @Override // android.view.View
        public void setSelected(boolean z) {
            boolean z2 = isSelected() != z;
            super.setSelected(z);
            if (z2 && z && Build.VERSION.SDK_INT < 16) {
                sendAccessibilityEvent(4);
            }
            TextView textView = this.f2430c;
            if (textView != null) {
                textView.setSelected(z);
            }
            ImageView imageView = this.f2431d;
            if (imageView != null) {
                imageView.setSelected(z);
            }
            View view = this.e;
            if (view != null) {
                view.setSelected(z);
            }
        }
    }

    /* loaded from: classes.dex */
    public static class i implements c {

        /* renamed from: a  reason: collision with root package name */
        private final ViewPager f2432a;

        public i(ViewPager viewPager) {
            this.f2432a = viewPager;
        }

        @Override // com.google.android.material.tabs.TabLayout.c
        public void a(f fVar) {
        }

        @Override // com.google.android.material.tabs.TabLayout.c
        public void b(f fVar) {
            this.f2432a.setCurrentItem(fVar.e());
        }

        @Override // com.google.android.material.tabs.TabLayout.c
        public void c(f fVar) {
        }
    }

    public TabLayout(Context context, AttributeSet attributeSet) {
        this(context, attributeSet, b.d.a.a.b.tabStyle);
    }

    public TabLayout(Context context, AttributeSet attributeSet, int i2) {
        super(context, attributeSet, i2);
        this.f2406b = new ArrayList<>();
        this.f2408d = new RectF();
        this.s = Integer.MAX_VALUE;
        this.F = new ArrayList<>();
        this.O = new a.f.k.e(12);
        setHorizontalScrollBarEnabled(false);
        e eVar = new e(context);
        this.e = eVar;
        super.addView(eVar, 0, new FrameLayout.LayoutParams(-2, -1));
        int[] iArr = j.TabLayout;
        int i3 = b.d.a.a.i.Widget_Design_TabLayout;
        int i4 = j.TabLayout_tabTextAppearance;
        TypedArray h2 = com.google.android.material.internal.f.h(context, attributeSet, iArr, i2, i3, i4);
        eVar.g(h2.getDimensionPixelSize(j.TabLayout_tabIndicatorHeight, -1));
        eVar.f(h2.getColor(j.TabLayout_tabIndicatorColor, 0));
        setSelectedTabIndicator(b.d.a.a.p.a.b(context, h2, j.TabLayout_tabIndicator));
        setSelectedTabIndicatorGravity(h2.getInt(j.TabLayout_tabIndicatorGravity, 0));
        setTabIndicatorFullWidth(h2.getBoolean(j.TabLayout_tabIndicatorFullWidth, true));
        int dimensionPixelSize = h2.getDimensionPixelSize(j.TabLayout_tabPadding, 0);
        this.i = dimensionPixelSize;
        this.h = dimensionPixelSize;
        this.g = dimensionPixelSize;
        this.f = dimensionPixelSize;
        this.f = h2.getDimensionPixelSize(j.TabLayout_tabPaddingStart, dimensionPixelSize);
        this.g = h2.getDimensionPixelSize(j.TabLayout_tabPaddingTop, this.g);
        this.h = h2.getDimensionPixelSize(j.TabLayout_tabPaddingEnd, this.h);
        this.i = h2.getDimensionPixelSize(j.TabLayout_tabPaddingBottom, this.i);
        int resourceId = h2.getResourceId(i4, b.d.a.a.i.TextAppearance_Design_Tab);
        this.j = resourceId;
        TypedArray obtainStyledAttributes = context.obtainStyledAttributes(resourceId, a.a.j.TextAppearance);
        try {
            this.p = obtainStyledAttributes.getDimensionPixelSize(a.a.j.TextAppearance_android_textSize, 0);
            this.k = b.d.a.a.p.a.a(context, obtainStyledAttributes, a.a.j.TextAppearance_android_textColor);
            obtainStyledAttributes.recycle();
            int i5 = j.TabLayout_tabTextColor;
            if (h2.hasValue(i5)) {
                this.k = b.d.a.a.p.a.a(context, h2, i5);
            }
            int i6 = j.TabLayout_tabSelectedTextColor;
            if (h2.hasValue(i6)) {
                this.k = m(this.k.getDefaultColor(), h2.getColor(i6, 0));
            }
            this.l = b.d.a.a.p.a.a(context, h2, j.TabLayout_tabIconTint);
            this.o = com.google.android.material.internal.g.a(h2.getInt(j.TabLayout_tabIconTintMode, -1), null);
            this.m = b.d.a.a.p.a.a(context, h2, j.TabLayout_tabRippleColor);
            this.y = h2.getInt(j.TabLayout_tabIndicatorAnimationDuration, 300);
            this.t = h2.getDimensionPixelSize(j.TabLayout_tabMinWidth, -1);
            this.u = h2.getDimensionPixelSize(j.TabLayout_tabMaxWidth, -1);
            this.r = h2.getResourceId(j.TabLayout_tabBackground, 0);
            this.w = h2.getDimensionPixelSize(j.TabLayout_tabContentStart, 0);
            this.A = h2.getInt(j.TabLayout_tabMode, 1);
            this.x = h2.getInt(j.TabLayout_tabGravity, 0);
            this.B = h2.getBoolean(j.TabLayout_tabInlineLabel, false);
            this.D = h2.getBoolean(j.TabLayout_tabUnboundedRipple, false);
            h2.recycle();
            Resources resources = getResources();
            this.q = resources.getDimensionPixelSize(b.d.a.a.d.design_tab_text_size_2line);
            this.v = resources.getDimensionPixelSize(b.d.a.a.d.design_tab_scrollable_min_width);
            j();
        } catch (Throwable th) {
            obtainStyledAttributes.recycle();
            throw th;
        }
    }

    private void B(int i2) {
        h hVar = (h) this.e.getChildAt(i2);
        this.e.removeViewAt(i2);
        if (hVar != null) {
            hVar.g();
            this.O.a(hVar);
        }
        requestLayout();
    }

    private void I(ViewPager viewPager, boolean z, boolean z2) {
        ViewPager viewPager2 = this.I;
        if (viewPager2 != null) {
            g gVar = this.L;
            if (gVar != null) {
                viewPager2.J(gVar);
            }
            b bVar = this.M;
            if (bVar != null) {
                this.I.I(bVar);
            }
        }
        c cVar = this.G;
        if (cVar != null) {
            A(cVar);
            this.G = null;
        }
        if (viewPager != null) {
            this.I = viewPager;
            if (this.L == null) {
                this.L = new g(this);
            }
            this.L.a();
            viewPager.c(this.L);
            i iVar = new i(viewPager);
            this.G = iVar;
            b(iVar);
            androidx.viewpager.widget.a adapter = viewPager.getAdapter();
            if (adapter != null) {
                E(adapter, z);
            }
            if (this.M == null) {
                this.M = new b();
            }
            this.M.b(z);
            viewPager.b(this.M);
            F(viewPager.getCurrentItem(), 0.0f, true);
        } else {
            this.I = null;
            E(null, false);
        }
        this.N = z2;
    }

    private void J() {
        int size = this.f2406b.size();
        for (int i2 = 0; i2 < size; i2++) {
            this.f2406b.get(i2).p();
        }
    }

    private void K(LinearLayout.LayoutParams layoutParams) {
        float f2;
        if (this.A == 1 && this.x == 0) {
            layoutParams.width = 0;
            f2 = 1.0f;
        } else {
            layoutParams.width = -2;
            f2 = 0.0f;
        }
        layoutParams.weight = f2;
    }

    private void f(com.google.android.material.tabs.a aVar) {
        f w = w();
        CharSequence charSequence = aVar.f2433b;
        if (charSequence != null) {
            w.o(charSequence);
        }
        Drawable drawable = aVar.f2434c;
        if (drawable != null) {
            w.m(drawable);
        }
        int i2 = aVar.f2435d;
        if (i2 != 0) {
            w.k(i2);
        }
        if (!TextUtils.isEmpty(aVar.getContentDescription())) {
            w.j(aVar.getContentDescription());
        }
        c(w);
    }

    private void g(f fVar) {
        this.e.addView(fVar.g, fVar.e(), n());
    }

    private int getDefaultHeight() {
        int size = this.f2406b.size();
        boolean z = false;
        int i2 = 0;
        while (true) {
            if (i2 < size) {
                f fVar = this.f2406b.get(i2);
                if (fVar != null && fVar.d() != null && !TextUtils.isEmpty(fVar.f())) {
                    z = true;
                    break;
                }
                i2++;
            } else {
                break;
            }
        }
        return (!z || this.B) ? 48 : 72;
    }

    private int getTabMinWidth() {
        int i2 = this.t;
        if (i2 != -1) {
            return i2;
        }
        if (this.A == 0) {
            return this.v;
        }
        return 0;
    }

    private int getTabScrollRange() {
        return Math.max(0, ((this.e.getWidth() - getWidth()) - getPaddingLeft()) - getPaddingRight());
    }

    private void h(View view) {
        if (!(view instanceof com.google.android.material.tabs.a)) {
            throw new IllegalArgumentException("Only TabItem instances can be added to TabLayout");
        }
        f((com.google.android.material.tabs.a) view);
    }

    private void i(int i2) {
        if (i2 == -1) {
            return;
        }
        if (getWindowToken() == null || !r.E(this) || this.e.c()) {
            F(i2, 0.0f, true);
            return;
        }
        int scrollX = getScrollX();
        int k = k(i2, 0.0f);
        if (scrollX != k) {
            u();
            this.H.setIntValues(scrollX, k);
            this.H.start();
        }
        this.e.a(i2, this.y);
    }

    private void j() {
        r.c0(this.e, this.A == 0 ? Math.max(0, this.w - this.f) : 0, 0, 0, 0);
        int i2 = this.A;
        if (i2 == 0) {
            this.e.setGravity(8388611);
        } else if (i2 == 1) {
            this.e.setGravity(1);
        }
        L(true);
    }

    private int k(int i2, float f2) {
        if (this.A == 0) {
            View childAt = this.e.getChildAt(i2);
            int i3 = i2 + 1;
            View childAt2 = i3 < this.e.getChildCount() ? this.e.getChildAt(i3) : null;
            int width = childAt != null ? childAt.getWidth() : 0;
            int width2 = childAt2 != null ? childAt2.getWidth() : 0;
            int left = (childAt.getLeft() + (width / 2)) - (getWidth() / 2);
            int i4 = (int) ((width + width2) * 0.5f * f2);
            return r.q(this) == 0 ? left + i4 : left - i4;
        }
        return 0;
    }

    private void l(f fVar, int i2) {
        fVar.n(i2);
        this.f2406b.add(i2, fVar);
        int size = this.f2406b.size();
        while (true) {
            i2++;
            if (i2 >= size) {
                return;
            }
            this.f2406b.get(i2).n(i2);
        }
    }

    private static ColorStateList m(int i2, int i3) {
        return new ColorStateList(new int[][]{HorizontalScrollView.SELECTED_STATE_SET, HorizontalScrollView.EMPTY_STATE_SET}, new int[]{i3, i2});
    }

    private LinearLayout.LayoutParams n() {
        LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(-2, -1);
        K(layoutParams);
        return layoutParams;
    }

    private h p(f fVar) {
        a.f.k.d<h> dVar = this.O;
        h b2 = dVar != null ? dVar.b() : null;
        if (b2 == null) {
            b2 = new h(getContext());
        }
        b2.h(fVar);
        b2.setFocusable(true);
        b2.setMinimumWidth(getTabMinWidth());
        b2.setContentDescription(TextUtils.isEmpty(fVar.f2424c) ? fVar.f2423b : fVar.f2424c);
        return b2;
    }

    private void q(f fVar) {
        for (int size = this.F.size() - 1; size >= 0; size--) {
            this.F.get(size).c(fVar);
        }
    }

    private void r(f fVar) {
        for (int size = this.F.size() - 1; size >= 0; size--) {
            this.F.get(size).b(fVar);
        }
    }

    private void s(f fVar) {
        for (int size = this.F.size() - 1; size >= 0; size--) {
            this.F.get(size).a(fVar);
        }
    }

    private void setSelectedTabView(int i2) {
        int childCount = this.e.getChildCount();
        if (i2 < childCount) {
            int i3 = 0;
            while (i3 < childCount) {
                View childAt = this.e.getChildAt(i3);
                boolean z = true;
                childAt.setSelected(i3 == i2);
                if (i3 != i2) {
                    z = false;
                }
                childAt.setActivated(z);
                i3++;
            }
        }
    }

    private void u() {
        if (this.H == null) {
            ValueAnimator valueAnimator = new ValueAnimator();
            this.H = valueAnimator;
            valueAnimator.setInterpolator(b.d.a.a.k.a.f1467a);
            this.H.setDuration(this.y);
            this.H.addUpdateListener(new a());
        }
    }

    public void A(c cVar) {
        this.F.remove(cVar);
    }

    void C(f fVar) {
        D(fVar, true);
    }

    void D(f fVar, boolean z) {
        f fVar2 = this.f2407c;
        if (fVar2 == fVar) {
            if (fVar2 != null) {
                q(fVar);
                i(fVar.e());
                return;
            }
            return;
        }
        int e2 = fVar != null ? fVar.e() : -1;
        if (z) {
            if ((fVar2 == null || fVar2.e() == -1) && e2 != -1) {
                F(e2, 0.0f, true);
            } else {
                i(e2);
            }
            if (e2 != -1) {
                setSelectedTabView(e2);
            }
        }
        this.f2407c = fVar;
        if (fVar2 != null) {
            s(fVar2);
        }
        if (fVar != null) {
            r(fVar);
        }
    }

    void E(androidx.viewpager.widget.a aVar, boolean z) {
        DataSetObserver dataSetObserver;
        androidx.viewpager.widget.a aVar2 = this.J;
        if (aVar2 != null && (dataSetObserver = this.K) != null) {
            aVar2.o(dataSetObserver);
        }
        this.J = aVar;
        if (z && aVar != null) {
            if (this.K == null) {
                this.K = new d();
            }
            aVar.i(this.K);
        }
        x();
    }

    public void F(int i2, float f2, boolean z) {
        G(i2, f2, z, true);
    }

    void G(int i2, float f2, boolean z, boolean z2) {
        int round = Math.round(i2 + f2);
        if (round < 0 || round >= this.e.getChildCount()) {
            return;
        }
        if (z2) {
            this.e.e(i2, f2);
        }
        ValueAnimator valueAnimator = this.H;
        if (valueAnimator != null && valueAnimator.isRunning()) {
            this.H.cancel();
        }
        scrollTo(k(i2, f2), 0);
        if (z) {
            setSelectedTabView(round);
        }
    }

    public void H(ViewPager viewPager, boolean z) {
        I(viewPager, z, false);
    }

    void L(boolean z) {
        for (int i2 = 0; i2 < this.e.getChildCount(); i2++) {
            View childAt = this.e.getChildAt(i2);
            childAt.setMinimumWidth(getTabMinWidth());
            K((LinearLayout.LayoutParams) childAt.getLayoutParams());
            if (z) {
                childAt.requestLayout();
            }
        }
    }

    @Override // android.widget.HorizontalScrollView, android.view.ViewGroup
    public void addView(View view) {
        h(view);
    }

    @Override // android.widget.HorizontalScrollView, android.view.ViewGroup
    public void addView(View view, int i2) {
        h(view);
    }

    @Override // android.widget.HorizontalScrollView, android.view.ViewGroup
    public void addView(View view, int i2, ViewGroup.LayoutParams layoutParams) {
        h(view);
    }

    @Override // android.widget.HorizontalScrollView, android.view.ViewGroup, android.view.ViewManager
    public void addView(View view, ViewGroup.LayoutParams layoutParams) {
        h(view);
    }

    public void b(c cVar) {
        if (this.F.contains(cVar)) {
            return;
        }
        this.F.add(cVar);
    }

    public void c(f fVar) {
        e(fVar, this.f2406b.isEmpty());
    }

    public void d(f fVar, int i2, boolean z) {
        if (fVar.f != this) {
            throw new IllegalArgumentException("Tab belongs to a different TabLayout.");
        }
        l(fVar, i2);
        g(fVar);
        if (z) {
            fVar.i();
        }
    }

    public void e(f fVar, boolean z) {
        d(fVar, this.f2406b.size(), z);
    }

    @Override // android.widget.FrameLayout, android.view.ViewGroup
    public FrameLayout.LayoutParams generateLayoutParams(AttributeSet attributeSet) {
        return generateDefaultLayoutParams();
    }

    public int getSelectedTabPosition() {
        f fVar = this.f2407c;
        if (fVar != null) {
            return fVar.e();
        }
        return -1;
    }

    public int getTabCount() {
        return this.f2406b.size();
    }

    public int getTabGravity() {
        return this.x;
    }

    public ColorStateList getTabIconTint() {
        return this.l;
    }

    public int getTabIndicatorGravity() {
        return this.z;
    }

    int getTabMaxWidth() {
        return this.s;
    }

    public int getTabMode() {
        return this.A;
    }

    public ColorStateList getTabRippleColor() {
        return this.m;
    }

    public Drawable getTabSelectedIndicator() {
        return this.n;
    }

    public ColorStateList getTabTextColors() {
        return this.k;
    }

    protected f o() {
        f b2 = P.b();
        return b2 == null ? new f() : b2;
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void onAttachedToWindow() {
        super.onAttachedToWindow();
        if (this.I == null) {
            ViewParent parent = getParent();
            if (parent instanceof ViewPager) {
                I((ViewPager) parent, true, true);
            }
        }
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void onDetachedFromWindow() {
        super.onDetachedFromWindow();
        if (this.N) {
            setupWithViewPager(null);
            this.N = false;
        }
    }

    @Override // android.view.View
    protected void onDraw(Canvas canvas) {
        for (int i2 = 0; i2 < this.e.getChildCount(); i2++) {
            View childAt = this.e.getChildAt(i2);
            if (childAt instanceof h) {
                ((h) childAt).e(canvas);
            }
        }
        super.onDraw(canvas);
    }

    /* JADX WARN: Code restructure failed: missing block: B:22:0x0067, code lost:
        if (r1.getMeasuredWidth() != getMeasuredWidth()) goto L19;
     */
    /* JADX WARN: Code restructure failed: missing block: B:25:0x0072, code lost:
        if (r1.getMeasuredWidth() < getMeasuredWidth()) goto L19;
     */
    /* JADX WARN: Code restructure failed: missing block: B:27:0x0075, code lost:
        r0 = false;
     */
    /* JADX WARN: Code restructure failed: missing block: B:28:0x0076, code lost:
        r6 = r0;
     */
    @Override // android.widget.HorizontalScrollView, android.widget.FrameLayout, android.view.View
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    protected void onMeasure(int r6, int r7) {
        /*
            r5 = this;
            int r0 = r5.getDefaultHeight()
            int r0 = r5.t(r0)
            int r1 = r5.getPaddingTop()
            int r0 = r0 + r1
            int r1 = r5.getPaddingBottom()
            int r0 = r0 + r1
            int r1 = android.view.View.MeasureSpec.getMode(r7)
            r2 = -2147483648(0xffffffff80000000, float:-0.0)
            r3 = 1073741824(0x40000000, float:2.0)
            if (r1 == r2) goto L24
            if (r1 == 0) goto L1f
            goto L30
        L1f:
            int r7 = android.view.View.MeasureSpec.makeMeasureSpec(r0, r3)
            goto L30
        L24:
            int r7 = android.view.View.MeasureSpec.getSize(r7)
            int r7 = java.lang.Math.min(r0, r7)
            int r7 = android.view.View.MeasureSpec.makeMeasureSpec(r7, r3)
        L30:
            int r0 = android.view.View.MeasureSpec.getSize(r6)
            int r1 = android.view.View.MeasureSpec.getMode(r6)
            if (r1 == 0) goto L49
            int r1 = r5.u
            if (r1 <= 0) goto L3f
            goto L47
        L3f:
            r1 = 56
            int r1 = r5.t(r1)
            int r1 = r0 - r1
        L47:
            r5.s = r1
        L49:
            super.onMeasure(r6, r7)
            int r6 = r5.getChildCount()
            r0 = 1
            if (r6 != r0) goto L97
            r6 = 0
            android.view.View r1 = r5.getChildAt(r6)
            int r2 = r5.A
            if (r2 == 0) goto L6a
            if (r2 == r0) goto L5f
            goto L77
        L5f:
            int r2 = r1.getMeasuredWidth()
            int r4 = r5.getMeasuredWidth()
            if (r2 == r4) goto L75
            goto L76
        L6a:
            int r2 = r1.getMeasuredWidth()
            int r4 = r5.getMeasuredWidth()
            if (r2 >= r4) goto L75
            goto L76
        L75:
            r0 = r6
        L76:
            r6 = r0
        L77:
            if (r6 == 0) goto L97
            int r6 = r5.getPaddingTop()
            int r0 = r5.getPaddingBottom()
            int r6 = r6 + r0
            android.view.ViewGroup$LayoutParams r0 = r1.getLayoutParams()
            int r0 = r0.height
            int r6 = android.widget.HorizontalScrollView.getChildMeasureSpec(r7, r6, r0)
            int r7 = r5.getMeasuredWidth()
            int r7 = android.view.View.MeasureSpec.makeMeasureSpec(r7, r3)
            r1.measure(r7, r6)
        L97:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.material.tabs.TabLayout.onMeasure(int, int):void");
    }

    public void setInlineLabel(boolean z) {
        if (this.B != z) {
            this.B = z;
            for (int i2 = 0; i2 < this.e.getChildCount(); i2++) {
                View childAt = this.e.getChildAt(i2);
                if (childAt instanceof h) {
                    ((h) childAt).k();
                }
            }
            j();
        }
    }

    public void setInlineLabelResource(int i2) {
        setInlineLabel(getResources().getBoolean(i2));
    }

    @Deprecated
    public void setOnTabSelectedListener(c cVar) {
        c cVar2 = this.E;
        if (cVar2 != null) {
            A(cVar2);
        }
        this.E = cVar;
        if (cVar != null) {
            b(cVar);
        }
    }

    void setScrollAnimatorListener(Animator.AnimatorListener animatorListener) {
        u();
        this.H.addListener(animatorListener);
    }

    public void setSelectedTabIndicator(int i2) {
        setSelectedTabIndicator(i2 != 0 ? a.a.k.a.a.d(getContext(), i2) : null);
    }

    public void setSelectedTabIndicator(Drawable drawable) {
        if (this.n != drawable) {
            this.n = drawable;
            r.K(this.e);
        }
    }

    public void setSelectedTabIndicatorColor(int i2) {
        this.e.f(i2);
    }

    public void setSelectedTabIndicatorGravity(int i2) {
        if (this.z != i2) {
            this.z = i2;
            r.K(this.e);
        }
    }

    @Deprecated
    public void setSelectedTabIndicatorHeight(int i2) {
        this.e.g(i2);
    }

    public void setTabGravity(int i2) {
        if (this.x != i2) {
            this.x = i2;
            j();
        }
    }

    public void setTabIconTint(ColorStateList colorStateList) {
        if (this.l != colorStateList) {
            this.l = colorStateList;
            J();
        }
    }

    public void setTabIconTintResource(int i2) {
        setTabIconTint(a.a.k.a.a.c(getContext(), i2));
    }

    public void setTabIndicatorFullWidth(boolean z) {
        this.C = z;
        r.K(this.e);
    }

    public void setTabMode(int i2) {
        if (i2 != this.A) {
            this.A = i2;
            j();
        }
    }

    public void setTabRippleColor(ColorStateList colorStateList) {
        if (this.m != colorStateList) {
            this.m = colorStateList;
            for (int i2 = 0; i2 < this.e.getChildCount(); i2++) {
                View childAt = this.e.getChildAt(i2);
                if (childAt instanceof h) {
                    ((h) childAt).j(getContext());
                }
            }
        }
    }

    public void setTabRippleColorResource(int i2) {
        setTabRippleColor(a.a.k.a.a.c(getContext(), i2));
    }

    public void setTabTextColors(ColorStateList colorStateList) {
        if (this.k != colorStateList) {
            this.k = colorStateList;
            J();
        }
    }

    @Deprecated
    public void setTabsFromPagerAdapter(androidx.viewpager.widget.a aVar) {
        E(aVar, false);
    }

    public void setUnboundedRipple(boolean z) {
        if (this.D != z) {
            this.D = z;
            for (int i2 = 0; i2 < this.e.getChildCount(); i2++) {
                View childAt = this.e.getChildAt(i2);
                if (childAt instanceof h) {
                    ((h) childAt).j(getContext());
                }
            }
        }
    }

    public void setUnboundedRippleResource(int i2) {
        setUnboundedRipple(getResources().getBoolean(i2));
    }

    public void setupWithViewPager(ViewPager viewPager) {
        H(viewPager, true);
    }

    @Override // android.widget.HorizontalScrollView, android.widget.FrameLayout, android.view.ViewGroup
    public boolean shouldDelayChildPressedState() {
        return getTabScrollRange() > 0;
    }

    int t(int i2) {
        return Math.round(getResources().getDisplayMetrics().density * i2);
    }

    public f v(int i2) {
        if (i2 < 0 || i2 >= getTabCount()) {
            return null;
        }
        return this.f2406b.get(i2);
    }

    public f w() {
        f o = o();
        o.f = this;
        o.g = p(o);
        return o;
    }

    void x() {
        int currentItem;
        z();
        androidx.viewpager.widget.a aVar = this.J;
        if (aVar != null) {
            int c2 = aVar.c();
            for (int i2 = 0; i2 < c2; i2++) {
                f w = w();
                w.o(this.J.e(i2));
                e(w, false);
            }
            ViewPager viewPager = this.I;
            if (viewPager == null || c2 <= 0 || (currentItem = viewPager.getCurrentItem()) == getSelectedTabPosition() || currentItem >= getTabCount()) {
                return;
            }
            C(v(currentItem));
        }
    }

    protected boolean y(f fVar) {
        return P.a(fVar);
    }

    public void z() {
        for (int childCount = this.e.getChildCount() - 1; childCount >= 0; childCount--) {
            B(childCount);
        }
        Iterator<f> it = this.f2406b.iterator();
        while (it.hasNext()) {
            f next = it.next();
            it.remove();
            next.h();
            y(next);
        }
        this.f2407c = null;
    }
}
