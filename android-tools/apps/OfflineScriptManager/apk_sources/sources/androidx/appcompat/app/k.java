package androidx.appcompat.app;

import a.a.m.b;
import a.f.l.r;
import a.f.l.v;
import a.f.l.w;
import a.f.l.x;
import a.f.l.y;
import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.content.res.Configuration;
import android.content.res.TypedArray;
import android.util.TypedValue;
import android.view.ContextThemeWrapper;
import android.view.KeyCharacterMap;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.animation.AccelerateInterpolator;
import android.view.animation.DecelerateInterpolator;
import android.view.animation.Interpolator;
import androidx.appcompat.app.a;
import androidx.appcompat.view.menu.h;
import androidx.appcompat.widget.ActionBarContainer;
import androidx.appcompat.widget.ActionBarContextView;
import androidx.appcompat.widget.ActionBarOverlayLayout;
import androidx.appcompat.widget.Toolbar;
import androidx.appcompat.widget.j0;
import java.lang.ref.WeakReference;
import java.util.ArrayList;
/* loaded from: classes.dex */
public class k extends androidx.appcompat.app.a implements ActionBarOverlayLayout.d {
    private static final Interpolator B = new AccelerateInterpolator();
    private static final Interpolator C = new DecelerateInterpolator();
    final y A;

    /* renamed from: a  reason: collision with root package name */
    Context f513a;

    /* renamed from: b  reason: collision with root package name */
    private Context f514b;

    /* renamed from: c  reason: collision with root package name */
    ActionBarOverlayLayout f515c;

    /* renamed from: d  reason: collision with root package name */
    ActionBarContainer f516d;
    androidx.appcompat.widget.y e;
    ActionBarContextView f;
    View g;
    j0 h;
    private boolean i;
    d j;
    a.a.m.b k;
    b.a l;
    private boolean m;
    private ArrayList<a.b> n;
    private boolean o;
    private int p;
    boolean q;
    boolean r;
    boolean s;
    private boolean t;
    private boolean u;
    a.a.m.h v;
    private boolean w;
    boolean x;
    final w y;
    final w z;

    /* loaded from: classes.dex */
    class a extends x {
        a() {
        }

        @Override // a.f.l.w
        public void a(View view) {
            View view2;
            k kVar = k.this;
            if (kVar.q && (view2 = kVar.g) != null) {
                view2.setTranslationY(0.0f);
                k.this.f516d.setTranslationY(0.0f);
            }
            k.this.f516d.setVisibility(8);
            k.this.f516d.setTransitioning(false);
            k kVar2 = k.this;
            kVar2.v = null;
            kVar2.z();
            ActionBarOverlayLayout actionBarOverlayLayout = k.this.f515c;
            if (actionBarOverlayLayout != null) {
                r.N(actionBarOverlayLayout);
            }
        }
    }

    /* loaded from: classes.dex */
    class b extends x {
        b() {
        }

        @Override // a.f.l.w
        public void a(View view) {
            k kVar = k.this;
            kVar.v = null;
            kVar.f516d.requestLayout();
        }
    }

    /* loaded from: classes.dex */
    class c implements y {
        c() {
        }

        @Override // a.f.l.y
        public void a(View view) {
            ((View) k.this.f516d.getParent()).invalidate();
        }
    }

    /* loaded from: classes.dex */
    public class d extends a.a.m.b implements h.a {

        /* renamed from: d  reason: collision with root package name */
        private final Context f520d;
        private final androidx.appcompat.view.menu.h e;
        private b.a f;
        private WeakReference<View> g;

        public d(Context context, b.a aVar) {
            this.f520d = context;
            this.f = aVar;
            androidx.appcompat.view.menu.h hVar = new androidx.appcompat.view.menu.h(context);
            hVar.S(1);
            this.e = hVar;
            hVar.R(this);
        }

        @Override // androidx.appcompat.view.menu.h.a
        public boolean a(androidx.appcompat.view.menu.h hVar, MenuItem menuItem) {
            b.a aVar = this.f;
            if (aVar != null) {
                return aVar.b(this, menuItem);
            }
            return false;
        }

        @Override // androidx.appcompat.view.menu.h.a
        public void b(androidx.appcompat.view.menu.h hVar) {
            if (this.f == null) {
                return;
            }
            k();
            k.this.f.l();
        }

        @Override // a.a.m.b
        public void c() {
            k kVar = k.this;
            if (kVar.j != this) {
                return;
            }
            if (k.y(kVar.r, kVar.s, false)) {
                this.f.d(this);
            } else {
                k kVar2 = k.this;
                kVar2.k = this;
                kVar2.l = this.f;
            }
            this.f = null;
            k.this.x(false);
            k.this.f.g();
            k.this.e.o().sendAccessibilityEvent(32);
            k kVar3 = k.this;
            kVar3.f515c.setHideOnContentScrollEnabled(kVar3.x);
            k.this.j = null;
        }

        @Override // a.a.m.b
        public View d() {
            WeakReference<View> weakReference = this.g;
            if (weakReference != null) {
                return weakReference.get();
            }
            return null;
        }

        @Override // a.a.m.b
        public Menu e() {
            return this.e;
        }

        @Override // a.a.m.b
        public MenuInflater f() {
            return new a.a.m.g(this.f520d);
        }

        @Override // a.a.m.b
        public CharSequence g() {
            return k.this.f.getSubtitle();
        }

        @Override // a.a.m.b
        public CharSequence i() {
            return k.this.f.getTitle();
        }

        @Override // a.a.m.b
        public void k() {
            if (k.this.j != this) {
                return;
            }
            this.e.d0();
            try {
                this.f.a(this, this.e);
            } finally {
                this.e.c0();
            }
        }

        @Override // a.a.m.b
        public boolean l() {
            return k.this.f.j();
        }

        @Override // a.a.m.b
        public void m(View view) {
            k.this.f.setCustomView(view);
            this.g = new WeakReference<>(view);
        }

        @Override // a.a.m.b
        public void n(int i) {
            o(k.this.f513a.getResources().getString(i));
        }

        @Override // a.a.m.b
        public void o(CharSequence charSequence) {
            k.this.f.setSubtitle(charSequence);
        }

        @Override // a.a.m.b
        public void q(int i) {
            r(k.this.f513a.getResources().getString(i));
        }

        @Override // a.a.m.b
        public void r(CharSequence charSequence) {
            k.this.f.setTitle(charSequence);
        }

        @Override // a.a.m.b
        public void s(boolean z) {
            super.s(z);
            k.this.f.setTitleOptional(z);
        }

        public boolean t() {
            this.e.d0();
            try {
                return this.f.c(this, this.e);
            } finally {
                this.e.c0();
            }
        }
    }

    public k(Activity activity, boolean z) {
        new ArrayList();
        this.n = new ArrayList<>();
        this.p = 0;
        this.q = true;
        this.u = true;
        this.y = new a();
        this.z = new b();
        this.A = new c();
        View decorView = activity.getWindow().getDecorView();
        F(decorView);
        if (z) {
            return;
        }
        this.g = decorView.findViewById(16908290);
    }

    public k(Dialog dialog) {
        new ArrayList();
        this.n = new ArrayList<>();
        this.p = 0;
        this.q = true;
        this.u = true;
        this.y = new a();
        this.z = new b();
        this.A = new c();
        F(dialog.getWindow().getDecorView());
    }

    private androidx.appcompat.widget.y C(View view) {
        if (view instanceof androidx.appcompat.widget.y) {
            return (androidx.appcompat.widget.y) view;
        }
        if (view instanceof Toolbar) {
            return ((Toolbar) view).getWrapper();
        }
        StringBuilder sb = new StringBuilder();
        sb.append("Can't make a decor toolbar out of ");
        sb.append(view != null ? view.getClass().getSimpleName() : "null");
        throw new IllegalStateException(sb.toString());
    }

    private void E() {
        if (this.t) {
            this.t = false;
            ActionBarOverlayLayout actionBarOverlayLayout = this.f515c;
            if (actionBarOverlayLayout != null) {
                actionBarOverlayLayout.setShowingForActionMode(false);
            }
            M(false);
        }
    }

    private void F(View view) {
        ActionBarOverlayLayout actionBarOverlayLayout = (ActionBarOverlayLayout) view.findViewById(a.a.f.decor_content_parent);
        this.f515c = actionBarOverlayLayout;
        if (actionBarOverlayLayout != null) {
            actionBarOverlayLayout.setActionBarVisibilityCallback(this);
        }
        this.e = C(view.findViewById(a.a.f.action_bar));
        this.f = (ActionBarContextView) view.findViewById(a.a.f.action_context_bar);
        ActionBarContainer actionBarContainer = (ActionBarContainer) view.findViewById(a.a.f.action_bar_container);
        this.f516d = actionBarContainer;
        androidx.appcompat.widget.y yVar = this.e;
        if (yVar == null || this.f == null || actionBarContainer == null) {
            throw new IllegalStateException(k.class.getSimpleName() + " can only be used with a compatible window decor layout");
        }
        this.f513a = yVar.q();
        boolean z = (this.e.j() & 4) != 0;
        if (z) {
            this.i = true;
        }
        a.a.m.a b2 = a.a.m.a.b(this.f513a);
        t(b2.a() || z);
        I(b2.g());
        TypedArray obtainStyledAttributes = this.f513a.obtainStyledAttributes(null, a.a.j.ActionBar, a.a.a.actionBarStyle, 0);
        if (obtainStyledAttributes.getBoolean(a.a.j.ActionBar_hideOnContentScroll, false)) {
            J(true);
        }
        int dimensionPixelSize = obtainStyledAttributes.getDimensionPixelSize(a.a.j.ActionBar_elevation, 0);
        if (dimensionPixelSize != 0) {
            H(dimensionPixelSize);
        }
        obtainStyledAttributes.recycle();
    }

    private void I(boolean z) {
        this.o = z;
        if (z) {
            this.f516d.setTabContainer(null);
            this.e.n(this.h);
        } else {
            this.e.n(null);
            this.f516d.setTabContainer(this.h);
        }
        boolean z2 = true;
        boolean z3 = D() == 2;
        j0 j0Var = this.h;
        if (j0Var != null) {
            if (z3) {
                j0Var.setVisibility(0);
                ActionBarOverlayLayout actionBarOverlayLayout = this.f515c;
                if (actionBarOverlayLayout != null) {
                    r.N(actionBarOverlayLayout);
                }
            } else {
                j0Var.setVisibility(8);
            }
        }
        this.e.w(!this.o && z3);
        ActionBarOverlayLayout actionBarOverlayLayout2 = this.f515c;
        if (this.o || !z3) {
            z2 = false;
        }
        actionBarOverlayLayout2.setHasNonEmbeddedTabs(z2);
    }

    private boolean K() {
        return r.E(this.f516d);
    }

    private void L() {
        if (this.t) {
            return;
        }
        this.t = true;
        ActionBarOverlayLayout actionBarOverlayLayout = this.f515c;
        if (actionBarOverlayLayout != null) {
            actionBarOverlayLayout.setShowingForActionMode(true);
        }
        M(false);
    }

    private void M(boolean z) {
        if (y(this.r, this.s, this.t)) {
            if (this.u) {
                return;
            }
            this.u = true;
            B(z);
        } else if (this.u) {
            this.u = false;
            A(z);
        }
    }

    static boolean y(boolean z, boolean z2, boolean z3) {
        if (z3) {
            return true;
        }
        return (z || z2) ? false : true;
    }

    public void A(boolean z) {
        View view;
        int[] iArr;
        a.a.m.h hVar = this.v;
        if (hVar != null) {
            hVar.a();
        }
        if (this.p != 0 || (!this.w && !z)) {
            this.y.a(null);
            return;
        }
        this.f516d.setAlpha(1.0f);
        this.f516d.setTransitioning(true);
        a.a.m.h hVar2 = new a.a.m.h();
        float f = -this.f516d.getHeight();
        if (z) {
            this.f516d.getLocationInWindow(new int[]{0, 0});
            f -= iArr[1];
        }
        v a2 = r.a(this.f516d);
        a2.k(f);
        a2.i(this.A);
        hVar2.c(a2);
        if (this.q && (view = this.g) != null) {
            v a3 = r.a(view);
            a3.k(f);
            hVar2.c(a3);
        }
        hVar2.f(B);
        hVar2.e(250L);
        hVar2.g(this.y);
        this.v = hVar2;
        hVar2.h();
    }

    public void B(boolean z) {
        View view;
        View view2;
        int[] iArr;
        a.a.m.h hVar = this.v;
        if (hVar != null) {
            hVar.a();
        }
        this.f516d.setVisibility(0);
        if (this.p == 0 && (this.w || z)) {
            this.f516d.setTranslationY(0.0f);
            float f = -this.f516d.getHeight();
            if (z) {
                this.f516d.getLocationInWindow(new int[]{0, 0});
                f -= iArr[1];
            }
            this.f516d.setTranslationY(f);
            a.a.m.h hVar2 = new a.a.m.h();
            v a2 = r.a(this.f516d);
            a2.k(0.0f);
            a2.i(this.A);
            hVar2.c(a2);
            if (this.q && (view2 = this.g) != null) {
                view2.setTranslationY(f);
                v a3 = r.a(this.g);
                a3.k(0.0f);
                hVar2.c(a3);
            }
            hVar2.f(C);
            hVar2.e(250L);
            hVar2.g(this.z);
            this.v = hVar2;
            hVar2.h();
        } else {
            this.f516d.setAlpha(1.0f);
            this.f516d.setTranslationY(0.0f);
            if (this.q && (view = this.g) != null) {
                view.setTranslationY(0.0f);
            }
            this.z.a(null);
        }
        ActionBarOverlayLayout actionBarOverlayLayout = this.f515c;
        if (actionBarOverlayLayout != null) {
            r.N(actionBarOverlayLayout);
        }
    }

    public int D() {
        return this.e.r();
    }

    public void G(int i, int i2) {
        int j = this.e.j();
        if ((i2 & 4) != 0) {
            this.i = true;
        }
        this.e.x((i & i2) | ((~i2) & j));
    }

    public void H(float f) {
        r.V(this.f516d, f);
    }

    public void J(boolean z) {
        if (z && !this.f515c.v()) {
            throw new IllegalStateException("Action bar must be in overlay mode (Window.FEATURE_OVERLAY_ACTION_BAR) to enable hide on content scroll");
        }
        this.x = z;
        this.f515c.setHideOnContentScrollEnabled(z);
    }

    @Override // androidx.appcompat.widget.ActionBarOverlayLayout.d
    public void a(boolean z) {
        this.q = z;
    }

    @Override // androidx.appcompat.widget.ActionBarOverlayLayout.d
    public void b() {
        if (this.s) {
            this.s = false;
            M(true);
        }
    }

    @Override // androidx.appcompat.widget.ActionBarOverlayLayout.d
    public void c() {
        a.a.m.h hVar = this.v;
        if (hVar != null) {
            hVar.a();
            this.v = null;
        }
    }

    @Override // androidx.appcompat.widget.ActionBarOverlayLayout.d
    public void d(int i) {
        this.p = i;
    }

    @Override // androidx.appcompat.widget.ActionBarOverlayLayout.d
    public void e() {
        if (this.s) {
            return;
        }
        this.s = true;
        M(true);
    }

    @Override // androidx.appcompat.widget.ActionBarOverlayLayout.d
    public void f() {
    }

    @Override // androidx.appcompat.app.a
    public boolean h() {
        androidx.appcompat.widget.y yVar = this.e;
        if (yVar == null || !yVar.u()) {
            return false;
        }
        this.e.collapseActionView();
        return true;
    }

    @Override // androidx.appcompat.app.a
    public void i(boolean z) {
        if (z == this.m) {
            return;
        }
        this.m = z;
        int size = this.n.size();
        for (int i = 0; i < size; i++) {
            this.n.get(i).a(z);
        }
    }

    @Override // androidx.appcompat.app.a
    public int j() {
        return this.e.j();
    }

    @Override // androidx.appcompat.app.a
    public Context k() {
        if (this.f514b == null) {
            TypedValue typedValue = new TypedValue();
            this.f513a.getTheme().resolveAttribute(a.a.a.actionBarWidgetTheme, typedValue, true);
            int i = typedValue.resourceId;
            if (i != 0) {
                this.f514b = new ContextThemeWrapper(this.f513a, i);
            } else {
                this.f514b = this.f513a;
            }
        }
        return this.f514b;
    }

    @Override // androidx.appcompat.app.a
    public void m(Configuration configuration) {
        I(a.a.m.a.b(this.f513a).g());
    }

    @Override // androidx.appcompat.app.a
    public boolean o(int i, KeyEvent keyEvent) {
        Menu e;
        d dVar = this.j;
        if (dVar == null || (e = dVar.e()) == null) {
            return false;
        }
        e.setQwertyMode(KeyCharacterMap.load(keyEvent != null ? keyEvent.getDeviceId() : -1).getKeyboardType() != 1);
        return e.performShortcut(i, keyEvent, 0);
    }

    @Override // androidx.appcompat.app.a
    public void r(boolean z) {
        if (this.i) {
            return;
        }
        s(z);
    }

    @Override // androidx.appcompat.app.a
    public void s(boolean z) {
        G(z ? 4 : 0, 4);
    }

    @Override // androidx.appcompat.app.a
    public void t(boolean z) {
        this.e.p(z);
    }

    @Override // androidx.appcompat.app.a
    public void u(boolean z) {
        a.a.m.h hVar;
        this.w = z;
        if (z || (hVar = this.v) == null) {
            return;
        }
        hVar.a();
    }

    @Override // androidx.appcompat.app.a
    public void v(CharSequence charSequence) {
        this.e.setWindowTitle(charSequence);
    }

    @Override // androidx.appcompat.app.a
    public a.a.m.b w(b.a aVar) {
        d dVar = this.j;
        if (dVar != null) {
            dVar.c();
        }
        this.f515c.setHideOnContentScrollEnabled(false);
        this.f.k();
        d dVar2 = new d(this.f.getContext(), aVar);
        if (dVar2.t()) {
            this.j = dVar2;
            dVar2.k();
            this.f.h(dVar2);
            x(true);
            this.f.sendAccessibilityEvent(32);
            return dVar2;
        }
        return null;
    }

    public void x(boolean z) {
        v s;
        v f;
        if (z) {
            L();
        } else {
            E();
        }
        if (!K()) {
            if (z) {
                this.e.k(4);
                this.f.setVisibility(0);
                return;
            }
            this.e.k(0);
            this.f.setVisibility(8);
            return;
        }
        if (z) {
            f = this.e.s(4, 100L);
            s = this.f.f(0, 200L);
        } else {
            s = this.e.s(0, 200L);
            f = this.f.f(8, 100L);
        }
        a.a.m.h hVar = new a.a.m.h();
        hVar.d(f, s);
        hVar.h();
    }

    void z() {
        b.a aVar = this.l;
        if (aVar != null) {
            aVar.d(this.k);
            this.k = null;
            this.l = null;
        }
    }
}
