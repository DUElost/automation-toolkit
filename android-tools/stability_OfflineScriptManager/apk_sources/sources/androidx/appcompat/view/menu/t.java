package androidx.appcompat.view.menu;

import android.content.Context;
import android.content.res.Resources;
import android.view.Gravity;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewTreeObserver;
import android.widget.AdapterView;
import android.widget.FrameLayout;
import android.widget.ListView;
import android.widget.PopupWindow;
import android.widget.TextView;
import androidx.appcompat.view.menu.o;
import androidx.appcompat.widget.g0;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public final class t extends m implements PopupWindow.OnDismissListener, AdapterView.OnItemClickListener, o, View.OnKeyListener {
    private static final int w = a.a.g.abc_popup_menu_item_layout;

    /* renamed from: c  reason: collision with root package name */
    private final Context f581c;

    /* renamed from: d  reason: collision with root package name */
    private final h f582d;
    private final g e;
    private final boolean f;
    private final int g;
    private final int h;
    private final int i;
    final g0 j;
    private PopupWindow.OnDismissListener m;
    private View n;
    View o;
    private o.a p;
    ViewTreeObserver q;
    private boolean r;
    private boolean s;
    private int t;
    private boolean v;
    final ViewTreeObserver.OnGlobalLayoutListener k = new a();
    private final View.OnAttachStateChangeListener l = new b();
    private int u = 0;

    /* loaded from: classes.dex */
    class a implements ViewTreeObserver.OnGlobalLayoutListener {
        a() {
        }

        @Override // android.view.ViewTreeObserver.OnGlobalLayoutListener
        public void onGlobalLayout() {
            if (!t.this.f() || t.this.j.p()) {
                return;
            }
            View view = t.this.o;
            if (view == null || !view.isShown()) {
                t.this.dismiss();
            } else {
                t.this.j.a();
            }
        }
    }

    /* loaded from: classes.dex */
    class b implements View.OnAttachStateChangeListener {
        b() {
        }

        @Override // android.view.View.OnAttachStateChangeListener
        public void onViewAttachedToWindow(View view) {
        }

        @Override // android.view.View.OnAttachStateChangeListener
        public void onViewDetachedFromWindow(View view) {
            ViewTreeObserver viewTreeObserver = t.this.q;
            if (viewTreeObserver != null) {
                if (!viewTreeObserver.isAlive()) {
                    t.this.q = view.getViewTreeObserver();
                }
                t tVar = t.this;
                tVar.q.removeGlobalOnLayoutListener(tVar.k);
            }
            view.removeOnAttachStateChangeListener(this);
        }
    }

    public t(Context context, h hVar, View view, int i, int i2, boolean z) {
        this.f581c = context;
        this.f582d = hVar;
        this.f = z;
        this.e = new g(hVar, LayoutInflater.from(context), z, w);
        this.h = i;
        this.i = i2;
        Resources resources = context.getResources();
        this.g = Math.max(resources.getDisplayMetrics().widthPixels / 2, resources.getDimensionPixelSize(a.a.d.abc_config_prefDialogWidth));
        this.n = view;
        this.j = new g0(context, null, i, i2);
        hVar.c(this, context);
    }

    private boolean z() {
        View view;
        if (f()) {
            return true;
        }
        if (this.r || (view = this.n) == null) {
            return false;
        }
        this.o = view;
        this.j.B(this);
        this.j.C(this);
        this.j.A(true);
        View view2 = this.o;
        boolean z = this.q == null;
        ViewTreeObserver viewTreeObserver = view2.getViewTreeObserver();
        this.q = viewTreeObserver;
        if (z) {
            viewTreeObserver.addOnGlobalLayoutListener(this.k);
        }
        view2.addOnAttachStateChangeListener(this.l);
        this.j.s(view2);
        this.j.w(this.u);
        if (!this.s) {
            this.t = m.o(this.e, null, this.f581c, this.g);
            this.s = true;
        }
        this.j.v(this.t);
        this.j.z(2);
        this.j.x(n());
        this.j.a();
        ListView g = this.j.g();
        g.setOnKeyListener(this);
        if (this.v && this.f582d.x() != null) {
            FrameLayout frameLayout = (FrameLayout) LayoutInflater.from(this.f581c).inflate(a.a.g.abc_popup_menu_header_item_layout, (ViewGroup) g, false);
            TextView textView = (TextView) frameLayout.findViewById(16908310);
            if (textView != null) {
                textView.setText(this.f582d.x());
            }
            frameLayout.setEnabled(false);
            g.addHeaderView(frameLayout, null, false);
        }
        this.j.r(this.e);
        this.j.a();
        return true;
    }

    @Override // androidx.appcompat.view.menu.s
    public void a() {
        if (!z()) {
            throw new IllegalStateException("StandardMenuPopup cannot be used without an anchor");
        }
    }

    @Override // androidx.appcompat.view.menu.o
    public void b(h hVar, boolean z) {
        if (hVar != this.f582d) {
            return;
        }
        dismiss();
        o.a aVar = this.p;
        if (aVar != null) {
            aVar.b(hVar, z);
        }
    }

    @Override // androidx.appcompat.view.menu.o
    public boolean c() {
        return false;
    }

    @Override // androidx.appcompat.view.menu.s
    public void dismiss() {
        if (f()) {
            this.j.dismiss();
        }
    }

    @Override // androidx.appcompat.view.menu.s
    public boolean f() {
        return !this.r && this.j.f();
    }

    @Override // androidx.appcompat.view.menu.s
    public ListView g() {
        return this.j.g();
    }

    @Override // androidx.appcompat.view.menu.o
    public void i(o.a aVar) {
        this.p = aVar;
    }

    @Override // androidx.appcompat.view.menu.o
    public boolean j(u uVar) {
        if (uVar.hasVisibleItems()) {
            n nVar = new n(this.f581c, uVar, this.o, this.f, this.h, this.i);
            nVar.j(this.p);
            nVar.g(m.x(uVar));
            nVar.i(this.m);
            this.m = null;
            this.f582d.e(false);
            int k = this.j.k();
            int m = this.j.m();
            if ((Gravity.getAbsoluteGravity(this.u, a.f.l.r.q(this.n)) & 7) == 5) {
                k += this.n.getWidth();
            }
            if (nVar.n(k, m)) {
                o.a aVar = this.p;
                if (aVar != null) {
                    aVar.c(uVar);
                    return true;
                }
                return true;
            }
        }
        return false;
    }

    @Override // androidx.appcompat.view.menu.o
    public void k(boolean z) {
        this.s = false;
        g gVar = this.e;
        if (gVar != null) {
            gVar.notifyDataSetChanged();
        }
    }

    @Override // androidx.appcompat.view.menu.m
    public void l(h hVar) {
    }

    @Override // android.widget.PopupWindow.OnDismissListener
    public void onDismiss() {
        this.r = true;
        this.f582d.close();
        ViewTreeObserver viewTreeObserver = this.q;
        if (viewTreeObserver != null) {
            if (!viewTreeObserver.isAlive()) {
                this.q = this.o.getViewTreeObserver();
            }
            this.q.removeGlobalOnLayoutListener(this.k);
            this.q = null;
        }
        this.o.removeOnAttachStateChangeListener(this.l);
        PopupWindow.OnDismissListener onDismissListener = this.m;
        if (onDismissListener != null) {
            onDismissListener.onDismiss();
        }
    }

    @Override // android.view.View.OnKeyListener
    public boolean onKey(View view, int i, KeyEvent keyEvent) {
        if (keyEvent.getAction() == 1 && i == 82) {
            dismiss();
            return true;
        }
        return false;
    }

    @Override // androidx.appcompat.view.menu.m
    public void p(View view) {
        this.n = view;
    }

    @Override // androidx.appcompat.view.menu.m
    public void r(boolean z) {
        this.e.d(z);
    }

    @Override // androidx.appcompat.view.menu.m
    public void s(int i) {
        this.u = i;
    }

    @Override // androidx.appcompat.view.menu.m
    public void t(int i) {
        this.j.y(i);
    }

    @Override // androidx.appcompat.view.menu.m
    public void u(PopupWindow.OnDismissListener onDismissListener) {
        this.m = onDismissListener;
    }

    @Override // androidx.appcompat.view.menu.m
    public void v(boolean z) {
        this.v = z;
    }

    @Override // androidx.appcompat.view.menu.m
    public void w(int i) {
        this.j.H(i);
    }
}
