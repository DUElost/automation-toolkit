package androidx.appcompat.widget;

import android.content.Context;
import android.graphics.drawable.Drawable;
import android.text.TextUtils;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewParent;
import android.view.Window;
import androidx.appcompat.view.menu.h;
import androidx.appcompat.view.menu.o;
import androidx.appcompat.widget.Toolbar;
/* loaded from: classes.dex */
public class r0 implements y {

    /* renamed from: a  reason: collision with root package name */
    Toolbar f754a;

    /* renamed from: b  reason: collision with root package name */
    private int f755b;

    /* renamed from: c  reason: collision with root package name */
    private View f756c;

    /* renamed from: d  reason: collision with root package name */
    private View f757d;
    private Drawable e;
    private Drawable f;
    private Drawable g;
    private boolean h;
    CharSequence i;
    private CharSequence j;
    private CharSequence k;
    Window.Callback l;
    boolean m;
    private ActionMenuPresenter n;
    private int o;
    private int p;
    private Drawable q;

    /* loaded from: classes.dex */
    class a implements View.OnClickListener {

        /* renamed from: b  reason: collision with root package name */
        final androidx.appcompat.view.menu.a f758b;

        a() {
            this.f758b = new androidx.appcompat.view.menu.a(r0.this.f754a.getContext(), 0, 16908332, 0, 0, r0.this.i);
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            r0 r0Var = r0.this;
            Window.Callback callback = r0Var.l;
            if (callback == null || !r0Var.m) {
                return;
            }
            callback.onMenuItemSelected(0, this.f758b);
        }
    }

    /* loaded from: classes.dex */
    class b extends a.f.l.x {

        /* renamed from: a  reason: collision with root package name */
        private boolean f760a = false;

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ int f761b;

        b(int i) {
            this.f761b = i;
        }

        @Override // a.f.l.w
        public void a(View view) {
            if (this.f760a) {
                return;
            }
            r0.this.f754a.setVisibility(this.f761b);
        }

        @Override // a.f.l.x, a.f.l.w
        public void b(View view) {
            r0.this.f754a.setVisibility(0);
        }

        @Override // a.f.l.x, a.f.l.w
        public void c(View view) {
            this.f760a = true;
        }
    }

    public r0(Toolbar toolbar, boolean z) {
        this(toolbar, z, a.a.h.abc_action_bar_up_description, a.a.e.abc_ic_ab_back_material);
    }

    public r0(Toolbar toolbar, boolean z, int i, int i2) {
        Drawable drawable;
        this.o = 0;
        this.p = 0;
        this.f754a = toolbar;
        this.i = toolbar.getTitle();
        this.j = toolbar.getSubtitle();
        this.h = this.i != null;
        this.g = toolbar.getNavigationIcon();
        q0 t = q0.t(toolbar.getContext(), null, a.a.j.ActionBar, a.a.a.actionBarStyle, 0);
        this.q = t.f(a.a.j.ActionBar_homeAsUpIndicator);
        if (z) {
            CharSequence o = t.o(a.a.j.ActionBar_title);
            if (!TextUtils.isEmpty(o)) {
                G(o);
            }
            CharSequence o2 = t.o(a.a.j.ActionBar_subtitle);
            if (!TextUtils.isEmpty(o2)) {
                F(o2);
            }
            Drawable f = t.f(a.a.j.ActionBar_logo);
            if (f != null) {
                B(f);
            }
            Drawable f2 = t.f(a.a.j.ActionBar_icon);
            if (f2 != null) {
                setIcon(f2);
            }
            if (this.g == null && (drawable = this.q) != null) {
                E(drawable);
            }
            x(t.j(a.a.j.ActionBar_displayOptions, 0));
            int m = t.m(a.a.j.ActionBar_customNavigationLayout, 0);
            if (m != 0) {
                z(LayoutInflater.from(this.f754a.getContext()).inflate(m, (ViewGroup) this.f754a, false));
                x(this.f755b | 16);
            }
            int l = t.l(a.a.j.ActionBar_height, 0);
            if (l > 0) {
                ViewGroup.LayoutParams layoutParams = this.f754a.getLayoutParams();
                layoutParams.height = l;
                this.f754a.setLayoutParams(layoutParams);
            }
            int d2 = t.d(a.a.j.ActionBar_contentInsetStart, -1);
            int d3 = t.d(a.a.j.ActionBar_contentInsetEnd, -1);
            if (d2 >= 0 || d3 >= 0) {
                this.f754a.G(Math.max(d2, 0), Math.max(d3, 0));
            }
            int m2 = t.m(a.a.j.ActionBar_titleTextStyle, 0);
            if (m2 != 0) {
                Toolbar toolbar2 = this.f754a;
                toolbar2.K(toolbar2.getContext(), m2);
            }
            int m3 = t.m(a.a.j.ActionBar_subtitleTextStyle, 0);
            if (m3 != 0) {
                Toolbar toolbar3 = this.f754a;
                toolbar3.J(toolbar3.getContext(), m3);
            }
            int m4 = t.m(a.a.j.ActionBar_popupTheme, 0);
            if (m4 != 0) {
                this.f754a.setPopupTheme(m4);
            }
        } else {
            this.f755b = y();
        }
        t.u();
        A(i);
        this.k = this.f754a.getNavigationContentDescription();
        this.f754a.setNavigationOnClickListener(new a());
    }

    private void H(CharSequence charSequence) {
        this.i = charSequence;
        if ((this.f755b & 8) != 0) {
            this.f754a.setTitle(charSequence);
        }
    }

    private void I() {
        if ((this.f755b & 4) != 0) {
            if (TextUtils.isEmpty(this.k)) {
                this.f754a.setNavigationContentDescription(this.p);
            } else {
                this.f754a.setNavigationContentDescription(this.k);
            }
        }
    }

    private void J() {
        Toolbar toolbar;
        Drawable drawable;
        if ((this.f755b & 4) != 0) {
            toolbar = this.f754a;
            drawable = this.g;
            if (drawable == null) {
                drawable = this.q;
            }
        } else {
            toolbar = this.f754a;
            drawable = null;
        }
        toolbar.setNavigationIcon(drawable);
    }

    private void K() {
        Drawable drawable;
        int i = this.f755b;
        if ((i & 2) == 0) {
            drawable = null;
        } else if ((i & 1) == 0 || (drawable = this.f) == null) {
            drawable = this.e;
        }
        this.f754a.setLogo(drawable);
    }

    private int y() {
        if (this.f754a.getNavigationIcon() != null) {
            this.q = this.f754a.getNavigationIcon();
            return 15;
        }
        return 11;
    }

    public void A(int i) {
        if (i == this.p) {
            return;
        }
        this.p = i;
        if (TextUtils.isEmpty(this.f754a.getNavigationContentDescription())) {
            C(this.p);
        }
    }

    public void B(Drawable drawable) {
        this.f = drawable;
        K();
    }

    public void C(int i) {
        D(i == 0 ? null : q().getString(i));
    }

    public void D(CharSequence charSequence) {
        this.k = charSequence;
        I();
    }

    public void E(Drawable drawable) {
        this.g = drawable;
        J();
    }

    public void F(CharSequence charSequence) {
        this.j = charSequence;
        if ((this.f755b & 8) != 0) {
            this.f754a.setSubtitle(charSequence);
        }
    }

    public void G(CharSequence charSequence) {
        this.h = true;
        H(charSequence);
    }

    @Override // androidx.appcompat.widget.y
    public void a(Menu menu, o.a aVar) {
        if (this.n == null) {
            ActionMenuPresenter actionMenuPresenter = new ActionMenuPresenter(this.f754a.getContext());
            this.n = actionMenuPresenter;
            actionMenuPresenter.p(a.a.f.action_menu_presenter);
        }
        this.n.i(aVar);
        this.f754a.H((androidx.appcompat.view.menu.h) menu, this.n);
    }

    @Override // androidx.appcompat.widget.y
    public boolean b() {
        return this.f754a.y();
    }

    @Override // androidx.appcompat.widget.y
    public boolean c() {
        return this.f754a.z();
    }

    @Override // androidx.appcompat.widget.y
    public void collapseActionView() {
        this.f754a.e();
    }

    @Override // androidx.appcompat.widget.y
    public boolean d() {
        return this.f754a.w();
    }

    @Override // androidx.appcompat.widget.y
    public boolean e() {
        return this.f754a.N();
    }

    @Override // androidx.appcompat.widget.y
    public void f() {
        this.m = true;
    }

    @Override // androidx.appcompat.widget.y
    public boolean g() {
        return this.f754a.d();
    }

    @Override // androidx.appcompat.widget.y
    public CharSequence getTitle() {
        return this.f754a.getTitle();
    }

    @Override // androidx.appcompat.widget.y
    public void h() {
        this.f754a.f();
    }

    @Override // androidx.appcompat.widget.y
    public void i(o.a aVar, h.a aVar2) {
        this.f754a.I(aVar, aVar2);
    }

    @Override // androidx.appcompat.widget.y
    public int j() {
        return this.f755b;
    }

    @Override // androidx.appcompat.widget.y
    public void k(int i) {
        this.f754a.setVisibility(i);
    }

    @Override // androidx.appcompat.widget.y
    public Menu l() {
        return this.f754a.getMenu();
    }

    @Override // androidx.appcompat.widget.y
    public void m(int i) {
        B(i != 0 ? a.a.k.a.a.d(q(), i) : null);
    }

    @Override // androidx.appcompat.widget.y
    public void n(j0 j0Var) {
        View view = this.f756c;
        if (view != null) {
            ViewParent parent = view.getParent();
            Toolbar toolbar = this.f754a;
            if (parent == toolbar) {
                toolbar.removeView(this.f756c);
            }
        }
        this.f756c = j0Var;
        if (j0Var == null || this.o != 2) {
            return;
        }
        this.f754a.addView(j0Var, 0);
        Toolbar.e eVar = (Toolbar.e) this.f756c.getLayoutParams();
        ((ViewGroup.MarginLayoutParams) eVar).width = -2;
        ((ViewGroup.MarginLayoutParams) eVar).height = -2;
        eVar.f479a = 8388691;
        j0Var.setAllowCollapse(true);
    }

    @Override // androidx.appcompat.widget.y
    public ViewGroup o() {
        return this.f754a;
    }

    @Override // androidx.appcompat.widget.y
    public void p(boolean z) {
    }

    @Override // androidx.appcompat.widget.y
    public Context q() {
        return this.f754a.getContext();
    }

    @Override // androidx.appcompat.widget.y
    public int r() {
        return this.o;
    }

    @Override // androidx.appcompat.widget.y
    public a.f.l.v s(int i, long j) {
        a.f.l.v a2 = a.f.l.r.a(this.f754a);
        a2.a(i == 0 ? 1.0f : 0.0f);
        a2.d(j);
        a2.f(new b(i));
        return a2;
    }

    @Override // androidx.appcompat.widget.y
    public void setIcon(int i) {
        setIcon(i != 0 ? a.a.k.a.a.d(q(), i) : null);
    }

    @Override // androidx.appcompat.widget.y
    public void setIcon(Drawable drawable) {
        this.e = drawable;
        K();
    }

    @Override // androidx.appcompat.widget.y
    public void setWindowCallback(Window.Callback callback) {
        this.l = callback;
    }

    @Override // androidx.appcompat.widget.y
    public void setWindowTitle(CharSequence charSequence) {
        if (this.h) {
            return;
        }
        H(charSequence);
    }

    @Override // androidx.appcompat.widget.y
    public void t() {
        Log.i("ToolbarWidgetWrapper", "Progress display unsupported");
    }

    @Override // androidx.appcompat.widget.y
    public boolean u() {
        return this.f754a.v();
    }

    @Override // androidx.appcompat.widget.y
    public void v() {
        Log.i("ToolbarWidgetWrapper", "Progress display unsupported");
    }

    @Override // androidx.appcompat.widget.y
    public void w(boolean z) {
        this.f754a.setCollapsible(z);
    }

    @Override // androidx.appcompat.widget.y
    public void x(int i) {
        View view;
        CharSequence charSequence;
        Toolbar toolbar;
        int i2 = this.f755b ^ i;
        this.f755b = i;
        if (i2 != 0) {
            if ((i2 & 4) != 0) {
                if ((i & 4) != 0) {
                    I();
                }
                J();
            }
            if ((i2 & 3) != 0) {
                K();
            }
            if ((i2 & 8) != 0) {
                if ((i & 8) != 0) {
                    this.f754a.setTitle(this.i);
                    toolbar = this.f754a;
                    charSequence = this.j;
                } else {
                    charSequence = null;
                    this.f754a.setTitle((CharSequence) null);
                    toolbar = this.f754a;
                }
                toolbar.setSubtitle(charSequence);
            }
            if ((i2 & 16) == 0 || (view = this.f757d) == null) {
                return;
            }
            if ((i & 16) != 0) {
                this.f754a.addView(view);
            } else {
                this.f754a.removeView(view);
            }
        }
    }

    public void z(View view) {
        View view2 = this.f757d;
        if (view2 != null && (this.f755b & 16) != 0) {
            this.f754a.removeView(view2);
        }
        this.f757d = view;
        if (view == null || (this.f755b & 16) == 0) {
            return;
        }
        this.f754a.addView(view);
    }
}
