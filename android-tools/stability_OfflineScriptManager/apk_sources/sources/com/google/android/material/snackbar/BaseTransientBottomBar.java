package com.google.android.material.snackbar;

import a.f.l.a0.b;
import a.f.l.r;
import a.f.l.z;
import android.accessibilityservice.AccessibilityServiceInfo;
import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.animation.ValueAnimator;
import android.content.Context;
import android.content.res.TypedArray;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewParent;
import android.view.accessibility.AccessibilityManager;
import android.widget.FrameLayout;
import androidx.coordinatorlayout.widget.CoordinatorLayout;
import com.google.android.material.behavior.SwipeDismissBehavior;
import com.google.android.material.snackbar.BaseTransientBottomBar;
import com.google.android.material.snackbar.b;
import java.util.List;
/* loaded from: classes.dex */
public abstract class BaseTransientBottomBar<B extends BaseTransientBottomBar<B>> {
    static final Handler j;
    private static final boolean k;
    private static final int[] l;

    /* renamed from: a  reason: collision with root package name */
    private final ViewGroup f2369a;

    /* renamed from: b  reason: collision with root package name */
    private final Context f2370b;

    /* renamed from: c  reason: collision with root package name */
    protected final p f2371c;

    /* renamed from: d  reason: collision with root package name */
    private final com.google.android.material.snackbar.a f2372d;
    private int e;
    private List<l<B>> f;
    private Behavior g;
    private final AccessibilityManager h;
    final b.InterfaceC0099b i = new f();

    /* loaded from: classes.dex */
    public static class Behavior extends SwipeDismissBehavior<View> {
        private final m k = new m(this);

        /* JADX INFO: Access modifiers changed from: private */
        public void N(BaseTransientBottomBar<?> baseTransientBottomBar) {
            this.k.c(baseTransientBottomBar);
        }

        @Override // com.google.android.material.behavior.SwipeDismissBehavior
        public boolean D(View view) {
            return this.k.a(view);
        }

        @Override // com.google.android.material.behavior.SwipeDismissBehavior, androidx.coordinatorlayout.widget.CoordinatorLayout.c
        public boolean k(CoordinatorLayout coordinatorLayout, View view, MotionEvent motionEvent) {
            this.k.b(coordinatorLayout, view, motionEvent);
            return super.k(coordinatorLayout, view, motionEvent);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a extends AnimatorListenerAdapter {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ int f2373a;

        a(int i) {
            this.f2373a = i;
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            BaseTransientBottomBar.this.o(this.f2373a);
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationStart(Animator animator) {
            BaseTransientBottomBar.this.f2372d.a(0, 180);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b implements ValueAnimator.AnimatorUpdateListener {

        /* renamed from: a  reason: collision with root package name */
        private int f2375a = 0;

        b() {
        }

        @Override // android.animation.ValueAnimator.AnimatorUpdateListener
        public void onAnimationUpdate(ValueAnimator valueAnimator) {
            int intValue = ((Integer) valueAnimator.getAnimatedValue()).intValue();
            if (BaseTransientBottomBar.k) {
                r.I(BaseTransientBottomBar.this.f2371c, intValue - this.f2375a);
            } else {
                BaseTransientBottomBar.this.f2371c.setTranslationY(intValue);
            }
            this.f2375a = intValue;
        }
    }

    /* loaded from: classes.dex */
    static class c implements Handler.Callback {
        c() {
        }

        @Override // android.os.Handler.Callback
        public boolean handleMessage(Message message) {
            int i = message.what;
            if (i == 0) {
                ((BaseTransientBottomBar) message.obj).t();
                return true;
            } else if (i != 1) {
                return false;
            } else {
                ((BaseTransientBottomBar) message.obj).m(message.arg1);
                return true;
            }
        }
    }

    /* loaded from: classes.dex */
    class d implements a.f.l.o {
        d(BaseTransientBottomBar baseTransientBottomBar) {
        }

        @Override // a.f.l.o
        public z a(View view, z zVar) {
            view.setPadding(view.getPaddingLeft(), view.getPaddingTop(), view.getPaddingRight(), zVar.a());
            return zVar;
        }
    }

    /* loaded from: classes.dex */
    class e extends a.f.l.a {
        e() {
        }

        @Override // a.f.l.a
        public void e(View view, a.f.l.a0.c cVar) {
            super.e(view, cVar);
            cVar.a(1048576);
            cVar.z(true);
        }

        @Override // a.f.l.a
        public boolean h(View view, int i, Bundle bundle) {
            if (i == 1048576) {
                BaseTransientBottomBar.this.e();
                return true;
            }
            return super.h(view, i, bundle);
        }
    }

    /* loaded from: classes.dex */
    class f implements b.InterfaceC0099b {
        f() {
        }

        @Override // com.google.android.material.snackbar.b.InterfaceC0099b
        public void a() {
            Handler handler = BaseTransientBottomBar.j;
            handler.sendMessage(handler.obtainMessage(0, BaseTransientBottomBar.this));
        }

        @Override // com.google.android.material.snackbar.b.InterfaceC0099b
        public void b(int i) {
            Handler handler = BaseTransientBottomBar.j;
            handler.sendMessage(handler.obtainMessage(1, i, 0, BaseTransientBottomBar.this));
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class g implements SwipeDismissBehavior.b {
        g() {
        }

        @Override // com.google.android.material.behavior.SwipeDismissBehavior.b
        public void a(View view) {
            view.setVisibility(8);
            BaseTransientBottomBar.this.f(0);
        }

        @Override // com.google.android.material.behavior.SwipeDismissBehavior.b
        public void b(int i) {
            if (i == 0) {
                com.google.android.material.snackbar.b.c().k(BaseTransientBottomBar.this.i);
            } else if (i == 1 || i == 2) {
                com.google.android.material.snackbar.b.c().j(BaseTransientBottomBar.this.i);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class h implements n {

        /* loaded from: classes.dex */
        class a implements Runnable {
            a() {
            }

            @Override // java.lang.Runnable
            public void run() {
                BaseTransientBottomBar.this.o(3);
            }
        }

        h() {
        }

        @Override // com.google.android.material.snackbar.BaseTransientBottomBar.n
        public void onViewAttachedToWindow(View view) {
        }

        @Override // com.google.android.material.snackbar.BaseTransientBottomBar.n
        public void onViewDetachedFromWindow(View view) {
            if (BaseTransientBottomBar.this.n()) {
                BaseTransientBottomBar.j.post(new a());
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class i implements o {
        i() {
        }

        @Override // com.google.android.material.snackbar.BaseTransientBottomBar.o
        public void a(View view, int i, int i2, int i3, int i4) {
            BaseTransientBottomBar.this.f2371c.setOnLayoutChangeListener(null);
            if (BaseTransientBottomBar.this.r()) {
                BaseTransientBottomBar.this.c();
            } else {
                BaseTransientBottomBar.this.p();
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class j extends AnimatorListenerAdapter {
        j() {
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            BaseTransientBottomBar.this.p();
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationStart(Animator animator) {
            BaseTransientBottomBar.this.f2372d.b(70, 180);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class k implements ValueAnimator.AnimatorUpdateListener {

        /* renamed from: a  reason: collision with root package name */
        private int f2384a;

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ int f2385b;

        k(int i) {
            this.f2385b = i;
            this.f2384a = i;
        }

        @Override // android.animation.ValueAnimator.AnimatorUpdateListener
        public void onAnimationUpdate(ValueAnimator valueAnimator) {
            int intValue = ((Integer) valueAnimator.getAnimatedValue()).intValue();
            if (BaseTransientBottomBar.k) {
                r.I(BaseTransientBottomBar.this.f2371c, intValue - this.f2384a);
            } else {
                BaseTransientBottomBar.this.f2371c.setTranslationY(intValue);
            }
            this.f2384a = intValue;
        }
    }

    /* loaded from: classes.dex */
    public static abstract class l<B> {
        public void a(B b2, int i) {
        }

        public void b(B b2) {
        }
    }

    /* loaded from: classes.dex */
    public static class m {

        /* renamed from: a  reason: collision with root package name */
        private b.InterfaceC0099b f2387a;

        public m(SwipeDismissBehavior<?> swipeDismissBehavior) {
            swipeDismissBehavior.K(0.1f);
            swipeDismissBehavior.I(0.6f);
            swipeDismissBehavior.L(0);
        }

        public boolean a(View view) {
            return view instanceof p;
        }

        public void b(CoordinatorLayout coordinatorLayout, View view, MotionEvent motionEvent) {
            int actionMasked = motionEvent.getActionMasked();
            if (actionMasked == 0) {
                if (coordinatorLayout.A(view, (int) motionEvent.getX(), (int) motionEvent.getY())) {
                    com.google.android.material.snackbar.b.c().j(this.f2387a);
                }
            } else if (actionMasked == 1 || actionMasked == 3) {
                com.google.android.material.snackbar.b.c().k(this.f2387a);
            }
        }

        public void c(BaseTransientBottomBar<?> baseTransientBottomBar) {
            this.f2387a = baseTransientBottomBar.i;
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    /* loaded from: classes.dex */
    public interface n {
        void onViewAttachedToWindow(View view);

        void onViewDetachedFromWindow(View view);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    /* loaded from: classes.dex */
    public interface o {
        void a(View view, int i, int i2, int i3, int i4);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    /* loaded from: classes.dex */
    public static class p extends FrameLayout {

        /* renamed from: b  reason: collision with root package name */
        private final AccessibilityManager f2388b;

        /* renamed from: c  reason: collision with root package name */
        private final b.a f2389c;

        /* renamed from: d  reason: collision with root package name */
        private o f2390d;
        private n e;

        /* loaded from: classes.dex */
        class a implements b.a {
            a() {
            }

            @Override // a.f.l.a0.b.a
            public void onTouchExplorationStateChanged(boolean z) {
                p.this.setClickableOrFocusableBasedOnAccessibility(z);
            }
        }

        /* JADX INFO: Access modifiers changed from: protected */
        public p(Context context, AttributeSet attributeSet) {
            super(context, attributeSet);
            TypedArray obtainStyledAttributes = context.obtainStyledAttributes(attributeSet, b.d.a.a.j.SnackbarLayout);
            int i = b.d.a.a.j.SnackbarLayout_elevation;
            if (obtainStyledAttributes.hasValue(i)) {
                r.V(this, obtainStyledAttributes.getDimensionPixelSize(i, 0));
            }
            obtainStyledAttributes.recycle();
            AccessibilityManager accessibilityManager = (AccessibilityManager) context.getSystemService("accessibility");
            this.f2388b = accessibilityManager;
            a aVar = new a();
            this.f2389c = aVar;
            a.f.l.a0.b.a(accessibilityManager, aVar);
            setClickableOrFocusableBasedOnAccessibility(accessibilityManager.isTouchExplorationEnabled());
        }

        /* JADX INFO: Access modifiers changed from: private */
        public void setClickableOrFocusableBasedOnAccessibility(boolean z) {
            setClickable(!z);
            setFocusable(z);
        }

        @Override // android.view.ViewGroup, android.view.View
        protected void onAttachedToWindow() {
            super.onAttachedToWindow();
            n nVar = this.e;
            if (nVar != null) {
                nVar.onViewAttachedToWindow(this);
            }
            r.N(this);
        }

        @Override // android.view.ViewGroup, android.view.View
        protected void onDetachedFromWindow() {
            super.onDetachedFromWindow();
            n nVar = this.e;
            if (nVar != null) {
                nVar.onViewDetachedFromWindow(this);
            }
            a.f.l.a0.b.b(this.f2388b, this.f2389c);
        }

        @Override // android.widget.FrameLayout, android.view.ViewGroup, android.view.View
        protected void onLayout(boolean z, int i, int i2, int i3, int i4) {
            super.onLayout(z, i, i2, i3, i4);
            o oVar = this.f2390d;
            if (oVar != null) {
                oVar.a(this, i, i2, i3, i4);
            }
        }

        void setOnAttachStateChangeListener(n nVar) {
            this.e = nVar;
        }

        void setOnLayoutChangeListener(o oVar) {
            this.f2390d = oVar;
        }
    }

    static {
        int i2 = Build.VERSION.SDK_INT;
        k = i2 >= 16 && i2 <= 19;
        l = new int[]{b.d.a.a.b.snackbarStyle};
        j = new Handler(Looper.getMainLooper(), new c());
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public BaseTransientBottomBar(ViewGroup viewGroup, View view, com.google.android.material.snackbar.a aVar) {
        if (viewGroup == null) {
            throw new IllegalArgumentException("Transient bottom bar must have non-null parent");
        }
        if (view == null) {
            throw new IllegalArgumentException("Transient bottom bar must have non-null content");
        }
        if (aVar == null) {
            throw new IllegalArgumentException("Transient bottom bar must have non-null callback");
        }
        this.f2369a = viewGroup;
        this.f2372d = aVar;
        Context context = viewGroup.getContext();
        this.f2370b = context;
        com.google.android.material.internal.f.a(context);
        p pVar = (p) LayoutInflater.from(context).inflate(j(), viewGroup, false);
        this.f2371c = pVar;
        pVar.addView(view);
        r.P(pVar, 1);
        r.Y(pVar, 1);
        r.W(pVar, true);
        r.b0(pVar, new d(this));
        r.O(pVar, new e());
        this.h = (AccessibilityManager) context.getSystemService("accessibility");
    }

    private void d(int i2) {
        ValueAnimator valueAnimator = new ValueAnimator();
        valueAnimator.setIntValues(0, k());
        valueAnimator.setInterpolator(b.d.a.a.k.a.f1467a);
        valueAnimator.setDuration(250L);
        valueAnimator.addListener(new a(i2));
        valueAnimator.addUpdateListener(new b());
        valueAnimator.start();
    }

    private int k() {
        int height = this.f2371c.getHeight();
        ViewGroup.LayoutParams layoutParams = this.f2371c.getLayoutParams();
        return layoutParams instanceof ViewGroup.MarginLayoutParams ? height + ((ViewGroup.MarginLayoutParams) layoutParams).bottomMargin : height;
    }

    void c() {
        int k2 = k();
        if (k) {
            r.I(this.f2371c, k2);
        } else {
            this.f2371c.setTranslationY(k2);
        }
        ValueAnimator valueAnimator = new ValueAnimator();
        valueAnimator.setIntValues(k2, 0);
        valueAnimator.setInterpolator(b.d.a.a.k.a.f1467a);
        valueAnimator.setDuration(250L);
        valueAnimator.addListener(new j());
        valueAnimator.addUpdateListener(new k(k2));
        valueAnimator.start();
    }

    public void e() {
        f(3);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void f(int i2) {
        com.google.android.material.snackbar.b.c().b(this.i, i2);
    }

    public Context g() {
        return this.f2370b;
    }

    public int h() {
        return this.e;
    }

    protected SwipeDismissBehavior<? extends View> i() {
        return new Behavior();
    }

    protected int j() {
        return l() ? b.d.a.a.h.mtrl_layout_snackbar : b.d.a.a.h.design_layout_snackbar;
    }

    protected boolean l() {
        TypedArray obtainStyledAttributes = this.f2370b.obtainStyledAttributes(l);
        int resourceId = obtainStyledAttributes.getResourceId(0, -1);
        obtainStyledAttributes.recycle();
        return resourceId != -1;
    }

    final void m(int i2) {
        if (r() && this.f2371c.getVisibility() == 0) {
            d(i2);
        } else {
            o(i2);
        }
    }

    public boolean n() {
        return com.google.android.material.snackbar.b.c().e(this.i);
    }

    void o(int i2) {
        com.google.android.material.snackbar.b.c().h(this.i);
        List<l<B>> list = this.f;
        if (list != null) {
            for (int size = list.size() - 1; size >= 0; size--) {
                this.f.get(size).a(this, i2);
            }
        }
        ViewParent parent = this.f2371c.getParent();
        if (parent instanceof ViewGroup) {
            ((ViewGroup) parent).removeView(this.f2371c);
        }
    }

    void p() {
        com.google.android.material.snackbar.b.c().i(this.i);
        List<l<B>> list = this.f;
        if (list != null) {
            for (int size = list.size() - 1; size >= 0; size--) {
                this.f.get(size).b(this);
            }
        }
    }

    public B q(int i2) {
        this.e = i2;
        return this;
    }

    boolean r() {
        List<AccessibilityServiceInfo> enabledAccessibilityServiceList = this.h.getEnabledAccessibilityServiceList(1);
        return enabledAccessibilityServiceList != null && enabledAccessibilityServiceList.isEmpty();
    }

    public void s() {
        com.google.android.material.snackbar.b.c().m(h(), this.i);
    }

    final void t() {
        if (this.f2371c.getParent() == null) {
            ViewGroup.LayoutParams layoutParams = this.f2371c.getLayoutParams();
            if (layoutParams instanceof CoordinatorLayout.f) {
                CoordinatorLayout.f fVar = (CoordinatorLayout.f) layoutParams;
                SwipeDismissBehavior<? extends View> swipeDismissBehavior = this.g;
                if (swipeDismissBehavior == null) {
                    swipeDismissBehavior = i();
                }
                if (swipeDismissBehavior instanceof Behavior) {
                    ((Behavior) swipeDismissBehavior).N(this);
                }
                swipeDismissBehavior.J(new g());
                fVar.o(swipeDismissBehavior);
                fVar.g = 80;
            }
            this.f2369a.addView(this.f2371c);
        }
        this.f2371c.setOnAttachStateChangeListener(new h());
        if (!r.E(this.f2371c)) {
            this.f2371c.setOnLayoutChangeListener(new i());
        } else if (r()) {
            c();
        } else {
            p();
        }
    }
}
