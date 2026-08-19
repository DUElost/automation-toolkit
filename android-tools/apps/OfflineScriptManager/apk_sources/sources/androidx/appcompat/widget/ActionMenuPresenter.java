package androidx.appcompat.widget;

import a.f.l.b;
import android.content.Context;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.graphics.drawable.Drawable;
import android.os.Parcel;
import android.os.Parcelable;
import android.util.SparseBooleanArray;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewParent;
import androidx.appcompat.view.menu.ActionMenuItemView;
import androidx.appcompat.view.menu.o;
import androidx.appcompat.view.menu.p;
import androidx.appcompat.widget.ActionMenuView;
import java.util.ArrayList;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class ActionMenuPresenter extends androidx.appcompat.view.menu.b implements b.a {
    c A;
    private b B;
    final f C;
    int D;
    d j;
    private Drawable k;
    private boolean l;
    private boolean m;
    private boolean n;
    private int o;
    private int p;
    private int q;
    private boolean r;
    private boolean s;
    private boolean t;
    private boolean u;
    private int v;
    private final SparseBooleanArray w;
    private View x;
    e y;
    a z;

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class SavedState implements Parcelable {
        public static final Parcelable.Creator<SavedState> CREATOR = new a();

        /* renamed from: b  reason: collision with root package name */
        public int f595b;

        /* loaded from: classes.dex */
        static class a implements Parcelable.Creator<SavedState> {
            a() {
            }

            @Override // android.os.Parcelable.Creator
            /* renamed from: a */
            public SavedState createFromParcel(Parcel parcel) {
                return new SavedState(parcel);
            }

            @Override // android.os.Parcelable.Creator
            /* renamed from: b */
            public SavedState[] newArray(int i) {
                return new SavedState[i];
            }
        }

        SavedState() {
        }

        SavedState(Parcel parcel) {
            this.f595b = parcel.readInt();
        }

        @Override // android.os.Parcelable
        public int describeContents() {
            return 0;
        }

        @Override // android.os.Parcelable
        public void writeToParcel(Parcel parcel, int i) {
            parcel.writeInt(this.f595b);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class a extends androidx.appcompat.view.menu.n {
        public a(Context context, androidx.appcompat.view.menu.u uVar, View view) {
            super(context, uVar, view, false, a.a.a.actionOverflowMenuStyle);
            if (!((androidx.appcompat.view.menu.j) uVar.getItem()).l()) {
                View view2 = ActionMenuPresenter.this.j;
                f(view2 == null ? (View) ((androidx.appcompat.view.menu.b) ActionMenuPresenter.this).i : view2);
            }
            j(ActionMenuPresenter.this.C);
        }

        @Override // androidx.appcompat.view.menu.n
        protected void e() {
            ActionMenuPresenter actionMenuPresenter = ActionMenuPresenter.this;
            actionMenuPresenter.z = null;
            actionMenuPresenter.D = 0;
            super.e();
        }
    }

    /* loaded from: classes.dex */
    private class b extends ActionMenuItemView.b {
        b() {
        }

        @Override // androidx.appcompat.view.menu.ActionMenuItemView.b
        public androidx.appcompat.view.menu.s a() {
            a aVar = ActionMenuPresenter.this.z;
            if (aVar != null) {
                return aVar.c();
            }
            return null;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class c implements Runnable {

        /* renamed from: b  reason: collision with root package name */
        private e f597b;

        public c(e eVar) {
            this.f597b = eVar;
        }

        @Override // java.lang.Runnable
        public void run() {
            if (((androidx.appcompat.view.menu.b) ActionMenuPresenter.this).f533d != null) {
                ((androidx.appcompat.view.menu.b) ActionMenuPresenter.this).f533d.d();
            }
            View view = (View) ((androidx.appcompat.view.menu.b) ActionMenuPresenter.this).i;
            if (view != null && view.getWindowToken() != null && this.f597b.m()) {
                ActionMenuPresenter.this.y = this.f597b;
            }
            ActionMenuPresenter.this.A = null;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class d extends m implements ActionMenuView.a {

        /* loaded from: classes.dex */
        class a extends c0 {
            a(View view, ActionMenuPresenter actionMenuPresenter) {
                super(view);
            }

            @Override // androidx.appcompat.widget.c0
            public androidx.appcompat.view.menu.s b() {
                e eVar = ActionMenuPresenter.this.y;
                if (eVar == null) {
                    return null;
                }
                return eVar.c();
            }

            @Override // androidx.appcompat.widget.c0
            public boolean c() {
                ActionMenuPresenter.this.J();
                return true;
            }

            @Override // androidx.appcompat.widget.c0
            public boolean d() {
                ActionMenuPresenter actionMenuPresenter = ActionMenuPresenter.this;
                if (actionMenuPresenter.A != null) {
                    return false;
                }
                actionMenuPresenter.A();
                return true;
            }
        }

        public d(Context context) {
            super(context, null, a.a.a.actionOverflowButtonStyle);
            setClickable(true);
            setFocusable(true);
            setVisibility(0);
            setEnabled(true);
            s0.a(this, getContentDescription());
            setOnTouchListener(new a(this, ActionMenuPresenter.this));
        }

        @Override // androidx.appcompat.widget.ActionMenuView.a
        public boolean a() {
            return false;
        }

        @Override // androidx.appcompat.widget.ActionMenuView.a
        public boolean b() {
            return false;
        }

        @Override // android.view.View
        public boolean performClick() {
            if (super.performClick()) {
                return true;
            }
            playSoundEffect(0);
            ActionMenuPresenter.this.J();
            return true;
        }

        @Override // android.widget.ImageView
        protected boolean setFrame(int i, int i2, int i3, int i4) {
            boolean frame = super.setFrame(i, i2, i3, i4);
            Drawable drawable = getDrawable();
            Drawable background = getBackground();
            if (drawable != null && background != null) {
                int width = getWidth();
                int height = getHeight();
                int max = Math.max(width, height) / 2;
                int paddingLeft = (width + (getPaddingLeft() - getPaddingRight())) / 2;
                int paddingTop = (height + (getPaddingTop() - getPaddingBottom())) / 2;
                androidx.core.graphics.drawable.a.l(background, paddingLeft - max, paddingTop - max, paddingLeft + max, paddingTop + max);
            }
            return frame;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class e extends androidx.appcompat.view.menu.n {
        public e(Context context, androidx.appcompat.view.menu.h hVar, View view, boolean z) {
            super(context, hVar, view, z, a.a.a.actionOverflowMenuStyle);
            h(8388613);
            j(ActionMenuPresenter.this.C);
        }

        @Override // androidx.appcompat.view.menu.n
        protected void e() {
            if (((androidx.appcompat.view.menu.b) ActionMenuPresenter.this).f533d != null) {
                ((androidx.appcompat.view.menu.b) ActionMenuPresenter.this).f533d.close();
            }
            ActionMenuPresenter.this.y = null;
            super.e();
        }
    }

    /* loaded from: classes.dex */
    private class f implements o.a {
        f() {
        }

        @Override // androidx.appcompat.view.menu.o.a
        public void b(androidx.appcompat.view.menu.h hVar, boolean z) {
            if (hVar instanceof androidx.appcompat.view.menu.u) {
                hVar.D().e(false);
            }
            o.a m = ActionMenuPresenter.this.m();
            if (m != null) {
                m.b(hVar, z);
            }
        }

        @Override // androidx.appcompat.view.menu.o.a
        public boolean c(androidx.appcompat.view.menu.h hVar) {
            if (hVar == null) {
                return false;
            }
            ActionMenuPresenter.this.D = ((androidx.appcompat.view.menu.u) hVar).getItem().getItemId();
            o.a m = ActionMenuPresenter.this.m();
            if (m != null) {
                return m.c(hVar);
            }
            return false;
        }
    }

    public ActionMenuPresenter(Context context) {
        super(context, a.a.g.abc_action_menu_layout, a.a.g.abc_action_menu_item_layout);
        this.w = new SparseBooleanArray();
        this.C = new f();
    }

    private View y(MenuItem menuItem) {
        ViewGroup viewGroup = (ViewGroup) this.i;
        if (viewGroup == null) {
            return null;
        }
        int childCount = viewGroup.getChildCount();
        for (int i = 0; i < childCount; i++) {
            View childAt = viewGroup.getChildAt(i);
            if ((childAt instanceof p.a) && ((p.a) childAt).getItemData() == menuItem) {
                return childAt;
            }
        }
        return null;
    }

    public boolean A() {
        androidx.appcompat.view.menu.p pVar;
        c cVar = this.A;
        if (cVar != null && (pVar = this.i) != null) {
            ((View) pVar).removeCallbacks(cVar);
            this.A = null;
            return true;
        }
        e eVar = this.y;
        if (eVar != null) {
            eVar.b();
            return true;
        }
        return false;
    }

    public boolean B() {
        a aVar = this.z;
        if (aVar != null) {
            aVar.b();
            return true;
        }
        return false;
    }

    public boolean C() {
        return this.A != null || D();
    }

    public boolean D() {
        e eVar = this.y;
        return eVar != null && eVar.d();
    }

    public void E(Configuration configuration) {
        if (!this.r) {
            this.q = a.a.m.a.b(this.f532c).d();
        }
        androidx.appcompat.view.menu.h hVar = this.f533d;
        if (hVar != null) {
            hVar.K(true);
        }
    }

    public void F(boolean z) {
        this.u = z;
    }

    public void G(ActionMenuView actionMenuView) {
        this.i = actionMenuView;
        actionMenuView.b(this.f533d);
    }

    public void H(Drawable drawable) {
        d dVar = this.j;
        if (dVar != null) {
            dVar.setImageDrawable(drawable);
            return;
        }
        this.l = true;
        this.k = drawable;
    }

    public void I(boolean z) {
        this.m = z;
        this.n = true;
    }

    public boolean J() {
        androidx.appcompat.view.menu.h hVar;
        if (!this.m || D() || (hVar = this.f533d) == null || this.i == null || this.A != null || hVar.z().isEmpty()) {
            return false;
        }
        c cVar = new c(new e(this.f532c, this.f533d, this.j, true));
        this.A = cVar;
        ((View) this.i).post(cVar);
        super.j(null);
        return true;
    }

    @Override // androidx.appcompat.view.menu.b, androidx.appcompat.view.menu.o
    public void b(androidx.appcompat.view.menu.h hVar, boolean z) {
        x();
        super.b(hVar, z);
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r2v0 */
    /* JADX WARN: Type inference failed for: r2v1, types: [int] */
    /* JADX WARN: Type inference failed for: r2v17 */
    @Override // androidx.appcompat.view.menu.o
    public boolean c() {
        ArrayList<androidx.appcompat.view.menu.j> arrayList;
        int i;
        int i2;
        int i3;
        boolean z;
        int i4;
        ActionMenuPresenter actionMenuPresenter = this;
        androidx.appcompat.view.menu.h hVar = actionMenuPresenter.f533d;
        ?? r2 = 0;
        if (hVar != null) {
            arrayList = hVar.E();
            i = arrayList.size();
        } else {
            arrayList = null;
            i = 0;
        }
        int i5 = actionMenuPresenter.q;
        int i6 = actionMenuPresenter.p;
        int makeMeasureSpec = View.MeasureSpec.makeMeasureSpec(0, 0);
        ViewGroup viewGroup = (ViewGroup) actionMenuPresenter.i;
        boolean z2 = false;
        int i7 = 0;
        int i8 = 0;
        for (int i9 = 0; i9 < i; i9++) {
            androidx.appcompat.view.menu.j jVar = arrayList.get(i9);
            if (jVar.o()) {
                i7++;
            } else if (jVar.n()) {
                i8++;
            } else {
                z2 = true;
            }
            if (actionMenuPresenter.u && jVar.isActionViewExpanded()) {
                i5 = 0;
            }
        }
        if (actionMenuPresenter.m && (z2 || i8 + i7 > i5)) {
            i5--;
        }
        int i10 = i5 - i7;
        SparseBooleanArray sparseBooleanArray = actionMenuPresenter.w;
        sparseBooleanArray.clear();
        if (actionMenuPresenter.s) {
            int i11 = actionMenuPresenter.v;
            i3 = i6 / i11;
            i2 = i11 + ((i6 % i11) / i3);
        } else {
            i2 = 0;
            i3 = 0;
        }
        int i12 = 0;
        int i13 = 0;
        while (i12 < i) {
            androidx.appcompat.view.menu.j jVar2 = arrayList.get(i12);
            if (jVar2.o()) {
                View n = actionMenuPresenter.n(jVar2, actionMenuPresenter.x, viewGroup);
                if (actionMenuPresenter.x == null) {
                    actionMenuPresenter.x = n;
                }
                if (actionMenuPresenter.s) {
                    i3 -= ActionMenuView.L(n, i2, i3, makeMeasureSpec, r2);
                } else {
                    n.measure(makeMeasureSpec, makeMeasureSpec);
                }
                int measuredWidth = n.getMeasuredWidth();
                i6 -= measuredWidth;
                if (i13 == 0) {
                    i13 = measuredWidth;
                }
                int groupId = jVar2.getGroupId();
                if (groupId != 0) {
                    sparseBooleanArray.put(groupId, true);
                }
                jVar2.u(true);
                z = r2;
                i4 = i;
            } else if (jVar2.n()) {
                int groupId2 = jVar2.getGroupId();
                boolean z3 = sparseBooleanArray.get(groupId2);
                boolean z4 = (i10 > 0 || z3) && i6 > 0 && (!actionMenuPresenter.s || i3 > 0);
                boolean z5 = z4;
                if (z4) {
                    View n2 = actionMenuPresenter.n(jVar2, actionMenuPresenter.x, viewGroup);
                    i4 = i;
                    if (actionMenuPresenter.x == null) {
                        actionMenuPresenter.x = n2;
                    }
                    if (actionMenuPresenter.s) {
                        int L = ActionMenuView.L(n2, i2, i3, makeMeasureSpec, 0);
                        i3 -= L;
                        if (L == 0) {
                            z5 = false;
                        }
                    } else {
                        n2.measure(makeMeasureSpec, makeMeasureSpec);
                    }
                    int measuredWidth2 = n2.getMeasuredWidth();
                    i6 -= measuredWidth2;
                    if (i13 == 0) {
                        i13 = measuredWidth2;
                    }
                    z4 = z5 & (!actionMenuPresenter.s ? i6 + i13 <= 0 : i6 < 0);
                } else {
                    i4 = i;
                }
                if (z4 && groupId2 != 0) {
                    sparseBooleanArray.put(groupId2, true);
                } else if (z3) {
                    sparseBooleanArray.put(groupId2, false);
                    for (int i14 = 0; i14 < i12; i14++) {
                        androidx.appcompat.view.menu.j jVar3 = arrayList.get(i14);
                        if (jVar3.getGroupId() == groupId2) {
                            if (jVar3.l()) {
                                i10++;
                            }
                            jVar3.u(false);
                        }
                    }
                }
                if (z4) {
                    i10--;
                }
                jVar2.u(z4);
                z = false;
            } else {
                z = r2;
                i4 = i;
                jVar2.u(z);
            }
            i12++;
            r2 = z;
            i = i4;
            actionMenuPresenter = this;
        }
        return true;
    }

    @Override // androidx.appcompat.view.menu.b, androidx.appcompat.view.menu.o
    public void d(Context context, androidx.appcompat.view.menu.h hVar) {
        super.d(context, hVar);
        Resources resources = context.getResources();
        a.a.m.a b2 = a.a.m.a.b(context);
        if (!this.n) {
            this.m = b2.h();
        }
        if (!this.t) {
            this.o = b2.c();
        }
        if (!this.r) {
            this.q = b2.d();
        }
        int i = this.o;
        if (this.m) {
            if (this.j == null) {
                d dVar = new d(this.f531b);
                this.j = dVar;
                if (this.l) {
                    dVar.setImageDrawable(this.k);
                    this.k = null;
                    this.l = false;
                }
                int makeMeasureSpec = View.MeasureSpec.makeMeasureSpec(0, 0);
                this.j.measure(makeMeasureSpec, makeMeasureSpec);
            }
            i -= this.j.getMeasuredWidth();
        } else {
            this.j = null;
        }
        this.p = i;
        this.v = (int) (resources.getDisplayMetrics().density * 56.0f);
        this.x = null;
    }

    @Override // androidx.appcompat.view.menu.b
    public void f(androidx.appcompat.view.menu.j jVar, p.a aVar) {
        aVar.e(jVar, 0);
        ActionMenuItemView actionMenuItemView = (ActionMenuItemView) aVar;
        actionMenuItemView.setItemInvoker((ActionMenuView) this.i);
        if (this.B == null) {
            this.B = new b();
        }
        actionMenuItemView.setPopupCallback(this.B);
    }

    @Override // androidx.appcompat.view.menu.b, androidx.appcompat.view.menu.o
    public boolean j(androidx.appcompat.view.menu.u uVar) {
        boolean z = false;
        if (uVar.hasVisibleItems()) {
            androidx.appcompat.view.menu.u uVar2 = uVar;
            while (uVar2.e0() != this.f533d) {
                uVar2 = (androidx.appcompat.view.menu.u) uVar2.e0();
            }
            View y = y(uVar2.getItem());
            if (y == null) {
                return false;
            }
            uVar.getItem().getItemId();
            int size = uVar.size();
            int i = 0;
            while (true) {
                if (i >= size) {
                    break;
                }
                MenuItem item = uVar.getItem(i);
                if (item.isVisible() && item.getIcon() != null) {
                    z = true;
                    break;
                }
                i++;
            }
            a aVar = new a(this.f532c, uVar, y);
            this.z = aVar;
            aVar.g(z);
            this.z.k();
            super.j(uVar);
            return true;
        }
        return false;
    }

    @Override // androidx.appcompat.view.menu.b, androidx.appcompat.view.menu.o
    public void k(boolean z) {
        super.k(z);
        ((View) this.i).requestLayout();
        androidx.appcompat.view.menu.h hVar = this.f533d;
        boolean z2 = false;
        if (hVar != null) {
            ArrayList<androidx.appcompat.view.menu.j> s = hVar.s();
            int size = s.size();
            for (int i = 0; i < size; i++) {
                a.f.l.b b2 = s.get(i).b();
                if (b2 != null) {
                    b2.i(this);
                }
            }
        }
        androidx.appcompat.view.menu.h hVar2 = this.f533d;
        ArrayList<androidx.appcompat.view.menu.j> z3 = hVar2 != null ? hVar2.z() : null;
        if (this.m && z3 != null) {
            int size2 = z3.size();
            if (size2 == 1) {
                z2 = !z3.get(0).isActionViewExpanded();
            } else if (size2 > 0) {
                z2 = true;
            }
        }
        d dVar = this.j;
        if (z2) {
            if (dVar == null) {
                this.j = new d(this.f531b);
            }
            ViewGroup viewGroup = (ViewGroup) this.j.getParent();
            if (viewGroup != this.i) {
                if (viewGroup != null) {
                    viewGroup.removeView(this.j);
                }
                ActionMenuView actionMenuView = (ActionMenuView) this.i;
                actionMenuView.addView(this.j, actionMenuView.F());
            }
        } else if (dVar != null) {
            ViewParent parent = dVar.getParent();
            androidx.appcompat.view.menu.p pVar = this.i;
            if (parent == pVar) {
                ((ViewGroup) pVar).removeView(this.j);
            }
        }
        ((ActionMenuView) this.i).setOverflowReserved(this.m);
    }

    @Override // androidx.appcompat.view.menu.b
    public boolean l(ViewGroup viewGroup, int i) {
        if (viewGroup.getChildAt(i) == this.j) {
            return false;
        }
        return super.l(viewGroup, i);
    }

    @Override // androidx.appcompat.view.menu.b
    public View n(androidx.appcompat.view.menu.j jVar, View view, ViewGroup viewGroup) {
        View actionView = jVar.getActionView();
        if (actionView == null || jVar.j()) {
            actionView = super.n(jVar, view, viewGroup);
        }
        actionView.setVisibility(jVar.isActionViewExpanded() ? 8 : 0);
        ActionMenuView actionMenuView = (ActionMenuView) viewGroup;
        ViewGroup.LayoutParams layoutParams = actionView.getLayoutParams();
        if (!actionMenuView.checkLayoutParams(layoutParams)) {
            actionView.setLayoutParams(actionMenuView.o(layoutParams));
        }
        return actionView;
    }

    @Override // androidx.appcompat.view.menu.b
    public androidx.appcompat.view.menu.p o(ViewGroup viewGroup) {
        androidx.appcompat.view.menu.p pVar = this.i;
        androidx.appcompat.view.menu.p o = super.o(viewGroup);
        if (pVar != o) {
            ((ActionMenuView) o).setPresenter(this);
        }
        return o;
    }

    @Override // androidx.appcompat.view.menu.b
    public boolean q(int i, androidx.appcompat.view.menu.j jVar) {
        return jVar.l();
    }

    public boolean x() {
        return A() | B();
    }

    public Drawable z() {
        d dVar = this.j;
        if (dVar != null) {
            return dVar.getDrawable();
        }
        if (this.l) {
            return this.k;
        }
        return null;
    }
}
