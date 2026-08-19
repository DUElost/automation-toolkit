package androidx.appcompat.view.menu;

import android.content.Context;
import android.content.res.Resources;
import android.graphics.Rect;
import android.os.Build;
import android.os.Handler;
import android.os.SystemClock;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewTreeObserver;
import android.widget.FrameLayout;
import android.widget.HeaderViewListAdapter;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.PopupWindow;
import android.widget.TextView;
import androidx.appcompat.view.menu.o;
import androidx.appcompat.widget.f0;
import androidx.appcompat.widget.g0;
import java.util.ArrayList;
import java.util.List;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public final class e extends m implements o, View.OnKeyListener, PopupWindow.OnDismissListener {
    private static final int C = a.a.g.abc_cascading_menu_item_layout;
    private PopupWindow.OnDismissListener A;
    boolean B;

    /* renamed from: c  reason: collision with root package name */
    private final Context f538c;

    /* renamed from: d  reason: collision with root package name */
    private final int f539d;
    private final int e;
    private final int f;
    private final boolean g;
    final Handler h;
    private View p;
    View q;
    private boolean s;
    private boolean t;
    private int u;
    private int v;
    private boolean x;
    private o.a y;
    ViewTreeObserver z;
    private final List<h> i = new ArrayList();
    final List<d> j = new ArrayList();
    final ViewTreeObserver.OnGlobalLayoutListener k = new a();
    private final View.OnAttachStateChangeListener l = new b();
    private final f0 m = new c();
    private int n = 0;
    private int o = 0;
    private boolean w = false;
    private int r = D();

    /* loaded from: classes.dex */
    class a implements ViewTreeObserver.OnGlobalLayoutListener {
        a() {
        }

        @Override // android.view.ViewTreeObserver.OnGlobalLayoutListener
        public void onGlobalLayout() {
            if (!e.this.f() || e.this.j.size() <= 0 || e.this.j.get(0).f546a.p()) {
                return;
            }
            View view = e.this.q;
            if (view == null || !view.isShown()) {
                e.this.dismiss();
                return;
            }
            for (d dVar : e.this.j) {
                dVar.f546a.a();
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
            ViewTreeObserver viewTreeObserver = e.this.z;
            if (viewTreeObserver != null) {
                if (!viewTreeObserver.isAlive()) {
                    e.this.z = view.getViewTreeObserver();
                }
                e eVar = e.this;
                eVar.z.removeGlobalOnLayoutListener(eVar.k);
            }
            view.removeOnAttachStateChangeListener(this);
        }
    }

    /* loaded from: classes.dex */
    class c implements f0 {

        /* loaded from: classes.dex */
        class a implements Runnable {

            /* renamed from: b  reason: collision with root package name */
            final /* synthetic */ d f543b;

            /* renamed from: c  reason: collision with root package name */
            final /* synthetic */ MenuItem f544c;

            /* renamed from: d  reason: collision with root package name */
            final /* synthetic */ h f545d;

            a(d dVar, MenuItem menuItem, h hVar) {
                this.f543b = dVar;
                this.f544c = menuItem;
                this.f545d = hVar;
            }

            @Override // java.lang.Runnable
            public void run() {
                d dVar = this.f543b;
                if (dVar != null) {
                    e.this.B = true;
                    dVar.f547b.e(false);
                    e.this.B = false;
                }
                if (this.f544c.isEnabled() && this.f544c.hasSubMenu()) {
                    this.f545d.L(this.f544c, 4);
                }
            }
        }

        c() {
        }

        @Override // androidx.appcompat.widget.f0
        public void b(h hVar, MenuItem menuItem) {
            e.this.h.removeCallbacksAndMessages(null);
            int size = e.this.j.size();
            int i = 0;
            while (true) {
                if (i >= size) {
                    i = -1;
                    break;
                } else if (hVar == e.this.j.get(i).f547b) {
                    break;
                } else {
                    i++;
                }
            }
            if (i == -1) {
                return;
            }
            int i2 = i + 1;
            e.this.h.postAtTime(new a(i2 < e.this.j.size() ? e.this.j.get(i2) : null, menuItem, hVar), hVar, SystemClock.uptimeMillis() + 200);
        }

        @Override // androidx.appcompat.widget.f0
        public void c(h hVar, MenuItem menuItem) {
            e.this.h.removeCallbacksAndMessages(hVar);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class d {

        /* renamed from: a  reason: collision with root package name */
        public final g0 f546a;

        /* renamed from: b  reason: collision with root package name */
        public final h f547b;

        /* renamed from: c  reason: collision with root package name */
        public final int f548c;

        public d(g0 g0Var, h hVar, int i) {
            this.f546a = g0Var;
            this.f547b = hVar;
            this.f548c = i;
        }

        public ListView a() {
            return this.f546a.g();
        }
    }

    public e(Context context, View view, int i, int i2, boolean z) {
        this.f538c = context;
        this.p = view;
        this.e = i;
        this.f = i2;
        this.g = z;
        Resources resources = context.getResources();
        this.f539d = Math.max(resources.getDisplayMetrics().widthPixels / 2, resources.getDimensionPixelSize(a.a.d.abc_config_prefDialogWidth));
        this.h = new Handler();
    }

    private int A(h hVar) {
        int size = this.j.size();
        for (int i = 0; i < size; i++) {
            if (hVar == this.j.get(i).f547b) {
                return i;
            }
        }
        return -1;
    }

    private MenuItem B(h hVar, h hVar2) {
        int size = hVar.size();
        for (int i = 0; i < size; i++) {
            MenuItem item = hVar.getItem(i);
            if (item.hasSubMenu() && hVar2 == item.getSubMenu()) {
                return item;
            }
        }
        return null;
    }

    private View C(d dVar, h hVar) {
        g gVar;
        int i;
        int firstVisiblePosition;
        MenuItem B = B(dVar.f547b, hVar);
        if (B == null) {
            return null;
        }
        ListView a2 = dVar.a();
        ListAdapter adapter = a2.getAdapter();
        int i2 = 0;
        if (adapter instanceof HeaderViewListAdapter) {
            HeaderViewListAdapter headerViewListAdapter = (HeaderViewListAdapter) adapter;
            i = headerViewListAdapter.getHeadersCount();
            gVar = (g) headerViewListAdapter.getWrappedAdapter();
        } else {
            gVar = (g) adapter;
            i = 0;
        }
        int count = gVar.getCount();
        while (true) {
            if (i2 >= count) {
                i2 = -1;
                break;
            } else if (B == gVar.getItem(i2)) {
                break;
            } else {
                i2++;
            }
        }
        if (i2 != -1 && (firstVisiblePosition = (i2 + i) - a2.getFirstVisiblePosition()) >= 0 && firstVisiblePosition < a2.getChildCount()) {
            return a2.getChildAt(firstVisiblePosition);
        }
        return null;
    }

    private int D() {
        return a.f.l.r.q(this.p) == 1 ? 0 : 1;
    }

    private int E(int i) {
        List<d> list = this.j;
        ListView a2 = list.get(list.size() - 1).a();
        int[] iArr = new int[2];
        a2.getLocationOnScreen(iArr);
        Rect rect = new Rect();
        this.q.getWindowVisibleDisplayFrame(rect);
        return this.r == 1 ? (iArr[0] + a2.getWidth()) + i > rect.right ? 0 : 1 : iArr[0] - i < 0 ? 1 : 0;
    }

    private void F(h hVar) {
        d dVar;
        View view;
        int i;
        int i2;
        int i3;
        LayoutInflater from = LayoutInflater.from(this.f538c);
        g gVar = new g(hVar, from, this.g, C);
        if (!f() && this.w) {
            gVar.d(true);
        } else if (f()) {
            gVar.d(m.x(hVar));
        }
        int o = m.o(gVar, null, this.f538c, this.f539d);
        g0 z = z();
        z.r(gVar);
        z.v(o);
        z.w(this.o);
        if (this.j.size() > 0) {
            List<d> list = this.j;
            dVar = list.get(list.size() - 1);
            view = C(dVar, hVar);
        } else {
            dVar = null;
            view = null;
        }
        if (view != null) {
            z.M(false);
            z.J(null);
            int E = E(o);
            boolean z2 = E == 1;
            this.r = E;
            if (Build.VERSION.SDK_INT >= 26) {
                z.s(view);
                i2 = 0;
                i = 0;
            } else {
                int[] iArr = new int[2];
                this.p.getLocationOnScreen(iArr);
                int[] iArr2 = new int[2];
                view.getLocationOnScreen(iArr2);
                if ((this.o & 7) == 5) {
                    iArr[0] = iArr[0] + this.p.getWidth();
                    iArr2[0] = iArr2[0] + view.getWidth();
                }
                i = iArr2[0] - iArr[0];
                i2 = iArr2[1] - iArr[1];
            }
            if ((this.o & 5) == 5) {
                if (!z2) {
                    o = view.getWidth();
                    i3 = i - o;
                }
                i3 = i + o;
            } else {
                if (z2) {
                    o = view.getWidth();
                    i3 = i + o;
                }
                i3 = i - o;
            }
            z.y(i3);
            z.D(true);
            z.H(i2);
        } else {
            if (this.s) {
                z.y(this.u);
            }
            if (this.t) {
                z.H(this.v);
            }
            z.x(n());
        }
        this.j.add(new d(z, hVar, this.r));
        z.a();
        ListView g = z.g();
        g.setOnKeyListener(this);
        if (dVar == null && this.x && hVar.x() != null) {
            FrameLayout frameLayout = (FrameLayout) from.inflate(a.a.g.abc_popup_menu_header_item_layout, (ViewGroup) g, false);
            frameLayout.setEnabled(false);
            ((TextView) frameLayout.findViewById(16908310)).setText(hVar.x());
            g.addHeaderView(frameLayout, null, false);
            z.a();
        }
    }

    private g0 z() {
        g0 g0Var = new g0(this.f538c, null, this.e, this.f);
        g0Var.L(this.m);
        g0Var.C(this);
        g0Var.B(this);
        g0Var.s(this.p);
        g0Var.w(this.o);
        g0Var.A(true);
        g0Var.z(2);
        return g0Var;
    }

    @Override // androidx.appcompat.view.menu.s
    public void a() {
        if (f()) {
            return;
        }
        for (h hVar : this.i) {
            F(hVar);
        }
        this.i.clear();
        View view = this.p;
        this.q = view;
        if (view != null) {
            boolean z = this.z == null;
            ViewTreeObserver viewTreeObserver = view.getViewTreeObserver();
            this.z = viewTreeObserver;
            if (z) {
                viewTreeObserver.addOnGlobalLayoutListener(this.k);
            }
            this.q.addOnAttachStateChangeListener(this.l);
        }
    }

    @Override // androidx.appcompat.view.menu.o
    public void b(h hVar, boolean z) {
        int A = A(hVar);
        if (A < 0) {
            return;
        }
        int i = A + 1;
        if (i < this.j.size()) {
            this.j.get(i).f547b.e(false);
        }
        d remove = this.j.remove(A);
        remove.f547b.O(this);
        if (this.B) {
            remove.f546a.K(null);
            remove.f546a.t(0);
        }
        remove.f546a.dismiss();
        int size = this.j.size();
        this.r = size > 0 ? this.j.get(size - 1).f548c : D();
        if (size != 0) {
            if (z) {
                this.j.get(0).f547b.e(false);
                return;
            }
            return;
        }
        dismiss();
        o.a aVar = this.y;
        if (aVar != null) {
            aVar.b(hVar, true);
        }
        ViewTreeObserver viewTreeObserver = this.z;
        if (viewTreeObserver != null) {
            if (viewTreeObserver.isAlive()) {
                this.z.removeGlobalOnLayoutListener(this.k);
            }
            this.z = null;
        }
        this.q.removeOnAttachStateChangeListener(this.l);
        this.A.onDismiss();
    }

    @Override // androidx.appcompat.view.menu.o
    public boolean c() {
        return false;
    }

    @Override // androidx.appcompat.view.menu.s
    public void dismiss() {
        int size = this.j.size();
        if (size > 0) {
            d[] dVarArr = (d[]) this.j.toArray(new d[size]);
            for (int i = size - 1; i >= 0; i--) {
                d dVar = dVarArr[i];
                if (dVar.f546a.f()) {
                    dVar.f546a.dismiss();
                }
            }
        }
    }

    @Override // androidx.appcompat.view.menu.s
    public boolean f() {
        return this.j.size() > 0 && this.j.get(0).f546a.f();
    }

    @Override // androidx.appcompat.view.menu.s
    public ListView g() {
        if (this.j.isEmpty()) {
            return null;
        }
        List<d> list = this.j;
        return list.get(list.size() - 1).a();
    }

    @Override // androidx.appcompat.view.menu.o
    public void i(o.a aVar) {
        this.y = aVar;
    }

    @Override // androidx.appcompat.view.menu.o
    public boolean j(u uVar) {
        for (d dVar : this.j) {
            if (uVar == dVar.f547b) {
                dVar.a().requestFocus();
                return true;
            }
        }
        if (uVar.hasVisibleItems()) {
            l(uVar);
            o.a aVar = this.y;
            if (aVar != null) {
                aVar.c(uVar);
            }
            return true;
        }
        return false;
    }

    @Override // androidx.appcompat.view.menu.o
    public void k(boolean z) {
        for (d dVar : this.j) {
            m.y(dVar.a().getAdapter()).notifyDataSetChanged();
        }
    }

    @Override // androidx.appcompat.view.menu.m
    public void l(h hVar) {
        hVar.c(this, this.f538c);
        if (f()) {
            F(hVar);
        } else {
            this.i.add(hVar);
        }
    }

    @Override // androidx.appcompat.view.menu.m
    protected boolean m() {
        return false;
    }

    @Override // android.widget.PopupWindow.OnDismissListener
    public void onDismiss() {
        d dVar;
        int size = this.j.size();
        int i = 0;
        while (true) {
            if (i >= size) {
                dVar = null;
                break;
            }
            dVar = this.j.get(i);
            if (!dVar.f546a.f()) {
                break;
            }
            i++;
        }
        if (dVar != null) {
            dVar.f547b.e(false);
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
        if (this.p != view) {
            this.p = view;
            this.o = a.f.l.c.b(this.n, a.f.l.r.q(view));
        }
    }

    @Override // androidx.appcompat.view.menu.m
    public void r(boolean z) {
        this.w = z;
    }

    @Override // androidx.appcompat.view.menu.m
    public void s(int i) {
        if (this.n != i) {
            this.n = i;
            this.o = a.f.l.c.b(i, a.f.l.r.q(this.p));
        }
    }

    @Override // androidx.appcompat.view.menu.m
    public void t(int i) {
        this.s = true;
        this.u = i;
    }

    @Override // androidx.appcompat.view.menu.m
    public void u(PopupWindow.OnDismissListener onDismissListener) {
        this.A = onDismissListener;
    }

    @Override // androidx.appcompat.view.menu.m
    public void v(boolean z) {
        this.x = z;
    }

    @Override // androidx.appcompat.view.menu.m
    public void w(int i) {
        this.t = true;
        this.v = i;
    }
}
