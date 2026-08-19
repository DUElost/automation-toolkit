package androidx.appcompat.widget;

import android.text.TextUtils;
import android.util.Log;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewConfiguration;
import android.view.accessibility.AccessibilityManager;
/* loaded from: classes.dex */
class t0 implements View.OnLongClickListener, View.OnHoverListener, View.OnAttachStateChangeListener {
    private static t0 k;
    private static t0 l;

    /* renamed from: b  reason: collision with root package name */
    private final View f773b;

    /* renamed from: c  reason: collision with root package name */
    private final CharSequence f774c;

    /* renamed from: d  reason: collision with root package name */
    private final int f775d;
    private final Runnable e = new a();
    private final Runnable f = new b();
    private int g;
    private int h;
    private u0 i;
    private boolean j;

    /* loaded from: classes.dex */
    class a implements Runnable {
        a() {
        }

        @Override // java.lang.Runnable
        public void run() {
            t0.this.g(false);
        }
    }

    /* loaded from: classes.dex */
    class b implements Runnable {
        b() {
        }

        @Override // java.lang.Runnable
        public void run() {
            t0.this.c();
        }
    }

    private t0(View view, CharSequence charSequence) {
        this.f773b = view;
        this.f774c = charSequence;
        this.f775d = a.f.l.s.c(ViewConfiguration.get(view.getContext()));
        b();
        view.setOnLongClickListener(this);
        view.setOnHoverListener(this);
    }

    private void a() {
        this.f773b.removeCallbacks(this.e);
    }

    private void b() {
        this.g = Integer.MAX_VALUE;
        this.h = Integer.MAX_VALUE;
    }

    private void d() {
        this.f773b.postDelayed(this.e, ViewConfiguration.getLongPressTimeout());
    }

    private static void e(t0 t0Var) {
        t0 t0Var2 = k;
        if (t0Var2 != null) {
            t0Var2.a();
        }
        k = t0Var;
        if (t0Var != null) {
            t0Var.d();
        }
    }

    public static void f(View view, CharSequence charSequence) {
        t0 t0Var = k;
        if (t0Var != null && t0Var.f773b == view) {
            e(null);
        }
        if (!TextUtils.isEmpty(charSequence)) {
            new t0(view, charSequence);
            return;
        }
        t0 t0Var2 = l;
        if (t0Var2 != null && t0Var2.f773b == view) {
            t0Var2.c();
        }
        view.setOnLongClickListener(null);
        view.setLongClickable(false);
        view.setOnHoverListener(null);
    }

    private boolean h(MotionEvent motionEvent) {
        int x = (int) motionEvent.getX();
        int y = (int) motionEvent.getY();
        if (Math.abs(x - this.g) > this.f775d || Math.abs(y - this.h) > this.f775d) {
            this.g = x;
            this.h = y;
            return true;
        }
        return false;
    }

    void c() {
        if (l == this) {
            l = null;
            u0 u0Var = this.i;
            if (u0Var != null) {
                u0Var.c();
                this.i = null;
                b();
                this.f773b.removeOnAttachStateChangeListener(this);
            } else {
                Log.e("TooltipCompatHandler", "sActiveHandler.mPopup == null");
            }
        }
        if (k == this) {
            e(null);
        }
        this.f773b.removeCallbacks(this.f);
    }

    void g(boolean z) {
        long longPressTimeout;
        if (a.f.l.r.D(this.f773b)) {
            e(null);
            t0 t0Var = l;
            if (t0Var != null) {
                t0Var.c();
            }
            l = this;
            this.j = z;
            u0 u0Var = new u0(this.f773b.getContext());
            this.i = u0Var;
            u0Var.e(this.f773b, this.g, this.h, this.j, this.f774c);
            this.f773b.addOnAttachStateChangeListener(this);
            if (this.j) {
                longPressTimeout = 2500;
            } else {
                longPressTimeout = ((a.f.l.r.x(this.f773b) & 1) == 1 ? 3000L : 15000L) - ViewConfiguration.getLongPressTimeout();
            }
            this.f773b.removeCallbacks(this.f);
            this.f773b.postDelayed(this.f, longPressTimeout);
        }
    }

    @Override // android.view.View.OnHoverListener
    public boolean onHover(View view, MotionEvent motionEvent) {
        if (this.i == null || !this.j) {
            AccessibilityManager accessibilityManager = (AccessibilityManager) this.f773b.getContext().getSystemService("accessibility");
            if (accessibilityManager.isEnabled() && accessibilityManager.isTouchExplorationEnabled()) {
                return false;
            }
            int action = motionEvent.getAction();
            if (action != 7) {
                if (action == 10) {
                    b();
                    c();
                }
            } else if (this.f773b.isEnabled() && this.i == null && h(motionEvent)) {
                e(this);
            }
            return false;
        }
        return false;
    }

    @Override // android.view.View.OnLongClickListener
    public boolean onLongClick(View view) {
        this.g = view.getWidth() / 2;
        this.h = view.getHeight() / 2;
        g(true);
        return true;
    }

    @Override // android.view.View.OnAttachStateChangeListener
    public void onViewAttachedToWindow(View view) {
    }

    @Override // android.view.View.OnAttachStateChangeListener
    public void onViewDetachedFromWindow(View view) {
        c();
    }
}
