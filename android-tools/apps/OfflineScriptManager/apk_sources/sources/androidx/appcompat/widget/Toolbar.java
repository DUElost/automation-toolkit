package androidx.appcompat.widget;

import android.content.Context;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.os.Parcel;
import android.os.Parcelable;
import android.text.TextUtils;
import android.util.AttributeSet;
import android.view.ContextThemeWrapper;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewParent;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;
import androidx.appcompat.app.a;
import androidx.appcompat.view.menu.h;
import androidx.appcompat.view.menu.o;
import androidx.appcompat.widget.ActionMenuView;
import androidx.customview.view.AbsSavedState;
import java.util.ArrayList;
import java.util.List;
/* loaded from: classes.dex */
public class Toolbar extends ViewGroup {
    private int A;
    private int B;
    private boolean C;
    private boolean D;
    private final ArrayList<View> E;
    private final ArrayList<View> F;
    private final int[] G;
    f H;
    private final ActionMenuView.e I;
    private r0 J;
    private ActionMenuPresenter K;
    private d L;
    private o.a M;
    private h.a N;
    private boolean O;
    private final Runnable P;

    /* renamed from: b  reason: collision with root package name */
    private ActionMenuView f635b;

    /* renamed from: c  reason: collision with root package name */
    private TextView f636c;

    /* renamed from: d  reason: collision with root package name */
    private TextView f637d;
    private ImageButton e;
    private ImageView f;
    private Drawable g;
    private CharSequence h;
    ImageButton i;
    View j;
    private Context k;
    private int l;
    private int m;
    private int n;
    int o;
    private int p;
    private int q;
    private int r;
    private int s;
    private int t;
    private i0 u;
    private int v;
    private int w;
    private int x;
    private CharSequence y;
    private CharSequence z;

    /* loaded from: classes.dex */
    public static class SavedState extends AbsSavedState {
        public static final Parcelable.Creator<SavedState> CREATOR = new a();

        /* renamed from: d  reason: collision with root package name */
        int f638d;
        boolean e;

        /* loaded from: classes.dex */
        static class a implements Parcelable.ClassLoaderCreator<SavedState> {
            a() {
            }

            @Override // android.os.Parcelable.Creator
            /* renamed from: a */
            public SavedState createFromParcel(Parcel parcel) {
                return new SavedState(parcel, null);
            }

            @Override // android.os.Parcelable.ClassLoaderCreator
            /* renamed from: b */
            public SavedState createFromParcel(Parcel parcel, ClassLoader classLoader) {
                return new SavedState(parcel, classLoader);
            }

            @Override // android.os.Parcelable.Creator
            /* renamed from: c */
            public SavedState[] newArray(int i) {
                return new SavedState[i];
            }
        }

        public SavedState(Parcel parcel, ClassLoader classLoader) {
            super(parcel, classLoader);
            this.f638d = parcel.readInt();
            this.e = parcel.readInt() != 0;
        }

        public SavedState(Parcelable parcelable) {
            super(parcelable);
        }

        @Override // androidx.customview.view.AbsSavedState, android.os.Parcelable
        public void writeToParcel(Parcel parcel, int i) {
            super.writeToParcel(parcel, i);
            parcel.writeInt(this.f638d);
            parcel.writeInt(this.e ? 1 : 0);
        }
    }

    /* loaded from: classes.dex */
    class a implements ActionMenuView.e {
        a() {
        }

        @Override // androidx.appcompat.widget.ActionMenuView.e
        public boolean onMenuItemClick(MenuItem menuItem) {
            f fVar = Toolbar.this.H;
            if (fVar != null) {
                return fVar.onMenuItemClick(menuItem);
            }
            return false;
        }
    }

    /* loaded from: classes.dex */
    class b implements Runnable {
        b() {
        }

        @Override // java.lang.Runnable
        public void run() {
            Toolbar.this.N();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class c implements View.OnClickListener {
        c() {
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            Toolbar.this.e();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class d implements androidx.appcompat.view.menu.o {

        /* renamed from: b  reason: collision with root package name */
        androidx.appcompat.view.menu.h f642b;

        /* renamed from: c  reason: collision with root package name */
        androidx.appcompat.view.menu.j f643c;

        d() {
        }

        @Override // androidx.appcompat.view.menu.o
        public void b(androidx.appcompat.view.menu.h hVar, boolean z) {
        }

        @Override // androidx.appcompat.view.menu.o
        public boolean c() {
            return false;
        }

        @Override // androidx.appcompat.view.menu.o
        public void d(Context context, androidx.appcompat.view.menu.h hVar) {
            androidx.appcompat.view.menu.j jVar;
            androidx.appcompat.view.menu.h hVar2 = this.f642b;
            if (hVar2 != null && (jVar = this.f643c) != null) {
                hVar2.f(jVar);
            }
            this.f642b = hVar;
        }

        @Override // androidx.appcompat.view.menu.o
        public boolean e(androidx.appcompat.view.menu.h hVar, androidx.appcompat.view.menu.j jVar) {
            View view = Toolbar.this.j;
            if (view instanceof a.a.m.c) {
                ((a.a.m.c) view).f();
            }
            Toolbar toolbar = Toolbar.this;
            toolbar.removeView(toolbar.j);
            Toolbar toolbar2 = Toolbar.this;
            toolbar2.removeView(toolbar2.i);
            Toolbar toolbar3 = Toolbar.this;
            toolbar3.j = null;
            toolbar3.a();
            this.f643c = null;
            Toolbar.this.requestLayout();
            jVar.r(false);
            return true;
        }

        @Override // androidx.appcompat.view.menu.o
        public boolean h(androidx.appcompat.view.menu.h hVar, androidx.appcompat.view.menu.j jVar) {
            Toolbar.this.g();
            ViewParent parent = Toolbar.this.i.getParent();
            Toolbar toolbar = Toolbar.this;
            if (parent != toolbar) {
                if (parent instanceof ViewGroup) {
                    ((ViewGroup) parent).removeView(toolbar.i);
                }
                Toolbar toolbar2 = Toolbar.this;
                toolbar2.addView(toolbar2.i);
            }
            Toolbar.this.j = jVar.getActionView();
            this.f643c = jVar;
            ViewParent parent2 = Toolbar.this.j.getParent();
            Toolbar toolbar3 = Toolbar.this;
            if (parent2 != toolbar3) {
                if (parent2 instanceof ViewGroup) {
                    ((ViewGroup) parent2).removeView(toolbar3.j);
                }
                e generateDefaultLayoutParams = Toolbar.this.generateDefaultLayoutParams();
                Toolbar toolbar4 = Toolbar.this;
                generateDefaultLayoutParams.f479a = 8388611 | (toolbar4.o & 112);
                generateDefaultLayoutParams.f645b = 2;
                toolbar4.j.setLayoutParams(generateDefaultLayoutParams);
                Toolbar toolbar5 = Toolbar.this;
                toolbar5.addView(toolbar5.j);
            }
            Toolbar.this.F();
            Toolbar.this.requestLayout();
            jVar.r(true);
            View view = Toolbar.this.j;
            if (view instanceof a.a.m.c) {
                ((a.a.m.c) view).c();
            }
            return true;
        }

        @Override // androidx.appcompat.view.menu.o
        public boolean j(androidx.appcompat.view.menu.u uVar) {
            return false;
        }

        @Override // androidx.appcompat.view.menu.o
        public void k(boolean z) {
            if (this.f643c != null) {
                androidx.appcompat.view.menu.h hVar = this.f642b;
                boolean z2 = false;
                if (hVar != null) {
                    int size = hVar.size();
                    int i = 0;
                    while (true) {
                        if (i >= size) {
                            break;
                        } else if (this.f642b.getItem(i) == this.f643c) {
                            z2 = true;
                            break;
                        } else {
                            i++;
                        }
                    }
                }
                if (z2) {
                    return;
                }
                e(this.f642b, this.f643c);
            }
        }
    }

    /* loaded from: classes.dex */
    public static class e extends a.C0026a {

        /* renamed from: b  reason: collision with root package name */
        int f645b;

        public e(int i, int i2) {
            super(i, i2);
            this.f645b = 0;
            this.f479a = 8388627;
        }

        public e(Context context, AttributeSet attributeSet) {
            super(context, attributeSet);
            this.f645b = 0;
        }

        public e(ViewGroup.LayoutParams layoutParams) {
            super(layoutParams);
            this.f645b = 0;
        }

        public e(ViewGroup.MarginLayoutParams marginLayoutParams) {
            super(marginLayoutParams);
            this.f645b = 0;
            a(marginLayoutParams);
        }

        public e(a.C0026a c0026a) {
            super(c0026a);
            this.f645b = 0;
        }

        public e(e eVar) {
            super((a.C0026a) eVar);
            this.f645b = 0;
            this.f645b = eVar.f645b;
        }

        void a(ViewGroup.MarginLayoutParams marginLayoutParams) {
            ((ViewGroup.MarginLayoutParams) this).leftMargin = marginLayoutParams.leftMargin;
            ((ViewGroup.MarginLayoutParams) this).topMargin = marginLayoutParams.topMargin;
            ((ViewGroup.MarginLayoutParams) this).rightMargin = marginLayoutParams.rightMargin;
            ((ViewGroup.MarginLayoutParams) this).bottomMargin = marginLayoutParams.bottomMargin;
        }
    }

    /* loaded from: classes.dex */
    public interface f {
        boolean onMenuItemClick(MenuItem menuItem);
    }

    public Toolbar(Context context, AttributeSet attributeSet) {
        this(context, attributeSet, a.a.a.toolbarStyle);
    }

    public Toolbar(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.x = 8388627;
        this.E = new ArrayList<>();
        this.F = new ArrayList<>();
        this.G = new int[2];
        this.I = new a();
        this.P = new b();
        q0 t = q0.t(getContext(), attributeSet, a.a.j.Toolbar, i, 0);
        this.m = t.m(a.a.j.Toolbar_titleTextAppearance, 0);
        this.n = t.m(a.a.j.Toolbar_subtitleTextAppearance, 0);
        this.x = t.k(a.a.j.Toolbar_android_gravity, this.x);
        this.o = t.k(a.a.j.Toolbar_buttonGravity, 48);
        int d2 = t.d(a.a.j.Toolbar_titleMargin, 0);
        int i2 = a.a.j.Toolbar_titleMargins;
        d2 = t.q(i2) ? t.d(i2, d2) : d2;
        this.t = d2;
        this.s = d2;
        this.r = d2;
        this.q = d2;
        int d3 = t.d(a.a.j.Toolbar_titleMarginStart, -1);
        if (d3 >= 0) {
            this.q = d3;
        }
        int d4 = t.d(a.a.j.Toolbar_titleMarginEnd, -1);
        if (d4 >= 0) {
            this.r = d4;
        }
        int d5 = t.d(a.a.j.Toolbar_titleMarginTop, -1);
        if (d5 >= 0) {
            this.s = d5;
        }
        int d6 = t.d(a.a.j.Toolbar_titleMarginBottom, -1);
        if (d6 >= 0) {
            this.t = d6;
        }
        this.p = t.e(a.a.j.Toolbar_maxButtonHeight, -1);
        int d7 = t.d(a.a.j.Toolbar_contentInsetStart, Integer.MIN_VALUE);
        int d8 = t.d(a.a.j.Toolbar_contentInsetEnd, Integer.MIN_VALUE);
        int e2 = t.e(a.a.j.Toolbar_contentInsetLeft, 0);
        int e3 = t.e(a.a.j.Toolbar_contentInsetRight, 0);
        h();
        this.u.e(e2, e3);
        if (d7 != Integer.MIN_VALUE || d8 != Integer.MIN_VALUE) {
            this.u.g(d7, d8);
        }
        this.v = t.d(a.a.j.Toolbar_contentInsetStartWithNavigation, Integer.MIN_VALUE);
        this.w = t.d(a.a.j.Toolbar_contentInsetEndWithActions, Integer.MIN_VALUE);
        this.g = t.f(a.a.j.Toolbar_collapseIcon);
        this.h = t.o(a.a.j.Toolbar_collapseContentDescription);
        CharSequence o = t.o(a.a.j.Toolbar_title);
        if (!TextUtils.isEmpty(o)) {
            setTitle(o);
        }
        CharSequence o2 = t.o(a.a.j.Toolbar_subtitle);
        if (!TextUtils.isEmpty(o2)) {
            setSubtitle(o2);
        }
        this.k = getContext();
        setPopupTheme(t.m(a.a.j.Toolbar_popupTheme, 0));
        Drawable f2 = t.f(a.a.j.Toolbar_navigationIcon);
        if (f2 != null) {
            setNavigationIcon(f2);
        }
        CharSequence o3 = t.o(a.a.j.Toolbar_navigationContentDescription);
        if (!TextUtils.isEmpty(o3)) {
            setNavigationContentDescription(o3);
        }
        Drawable f3 = t.f(a.a.j.Toolbar_logo);
        if (f3 != null) {
            setLogo(f3);
        }
        CharSequence o4 = t.o(a.a.j.Toolbar_logoDescription);
        if (!TextUtils.isEmpty(o4)) {
            setLogoDescription(o4);
        }
        int i3 = a.a.j.Toolbar_titleTextColor;
        if (t.q(i3)) {
            setTitleTextColor(t.b(i3, -1));
        }
        int i4 = a.a.j.Toolbar_subtitleTextColor;
        if (t.q(i4)) {
            setSubtitleTextColor(t.b(i4, -1));
        }
        t.u();
    }

    private int A(View view, int i, int[] iArr, int i2) {
        e eVar = (e) view.getLayoutParams();
        int i3 = ((ViewGroup.MarginLayoutParams) eVar).leftMargin - iArr[0];
        int max = i + Math.max(0, i3);
        iArr[0] = Math.max(0, -i3);
        int q = q(view, i2);
        int measuredWidth = view.getMeasuredWidth();
        view.layout(max, q, max + measuredWidth, view.getMeasuredHeight() + q);
        return max + measuredWidth + ((ViewGroup.MarginLayoutParams) eVar).rightMargin;
    }

    private int B(View view, int i, int[] iArr, int i2) {
        e eVar = (e) view.getLayoutParams();
        int i3 = ((ViewGroup.MarginLayoutParams) eVar).rightMargin - iArr[1];
        int max = i - Math.max(0, i3);
        iArr[1] = Math.max(0, -i3);
        int q = q(view, i2);
        int measuredWidth = view.getMeasuredWidth();
        view.layout(max - measuredWidth, q, max, view.getMeasuredHeight() + q);
        return max - (measuredWidth + ((ViewGroup.MarginLayoutParams) eVar).leftMargin);
    }

    private int C(View view, int i, int i2, int i3, int i4, int[] iArr) {
        ViewGroup.MarginLayoutParams marginLayoutParams = (ViewGroup.MarginLayoutParams) view.getLayoutParams();
        int i5 = marginLayoutParams.leftMargin - iArr[0];
        int i6 = marginLayoutParams.rightMargin - iArr[1];
        int max = Math.max(0, i5) + Math.max(0, i6);
        iArr[0] = Math.max(0, -i5);
        iArr[1] = Math.max(0, -i6);
        view.measure(ViewGroup.getChildMeasureSpec(i, getPaddingLeft() + getPaddingRight() + max + i2, marginLayoutParams.width), ViewGroup.getChildMeasureSpec(i3, getPaddingTop() + getPaddingBottom() + marginLayoutParams.topMargin + marginLayoutParams.bottomMargin + i4, marginLayoutParams.height));
        return view.getMeasuredWidth() + max;
    }

    private void D(View view, int i, int i2, int i3, int i4, int i5) {
        ViewGroup.MarginLayoutParams marginLayoutParams = (ViewGroup.MarginLayoutParams) view.getLayoutParams();
        int childMeasureSpec = ViewGroup.getChildMeasureSpec(i, getPaddingLeft() + getPaddingRight() + marginLayoutParams.leftMargin + marginLayoutParams.rightMargin + i2, marginLayoutParams.width);
        int childMeasureSpec2 = ViewGroup.getChildMeasureSpec(i3, getPaddingTop() + getPaddingBottom() + marginLayoutParams.topMargin + marginLayoutParams.bottomMargin + i4, marginLayoutParams.height);
        int mode = View.MeasureSpec.getMode(childMeasureSpec2);
        if (mode != 1073741824 && i5 >= 0) {
            if (mode != 0) {
                i5 = Math.min(View.MeasureSpec.getSize(childMeasureSpec2), i5);
            }
            childMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(i5, 1073741824);
        }
        view.measure(childMeasureSpec, childMeasureSpec2);
    }

    private void E() {
        removeCallbacks(this.P);
        post(this.P);
    }

    private boolean L() {
        if (this.O) {
            int childCount = getChildCount();
            for (int i = 0; i < childCount; i++) {
                View childAt = getChildAt(i);
                if (M(childAt) && childAt.getMeasuredWidth() > 0 && childAt.getMeasuredHeight() > 0) {
                    return false;
                }
            }
            return true;
        }
        return false;
    }

    private boolean M(View view) {
        return (view == null || view.getParent() != this || view.getVisibility() == 8) ? false : true;
    }

    private void b(List<View> list, int i) {
        boolean z = a.f.l.r.q(this) == 1;
        int childCount = getChildCount();
        int b2 = a.f.l.c.b(i, a.f.l.r.q(this));
        list.clear();
        if (!z) {
            for (int i2 = 0; i2 < childCount; i2++) {
                View childAt = getChildAt(i2);
                e eVar = (e) childAt.getLayoutParams();
                if (eVar.f645b == 0 && M(childAt) && p(eVar.f479a) == b2) {
                    list.add(childAt);
                }
            }
            return;
        }
        for (int i3 = childCount - 1; i3 >= 0; i3--) {
            View childAt2 = getChildAt(i3);
            e eVar2 = (e) childAt2.getLayoutParams();
            if (eVar2.f645b == 0 && M(childAt2) && p(eVar2.f479a) == b2) {
                list.add(childAt2);
            }
        }
    }

    private void c(View view, boolean z) {
        ViewGroup.LayoutParams layoutParams = view.getLayoutParams();
        e generateDefaultLayoutParams = layoutParams == null ? generateDefaultLayoutParams() : !checkLayoutParams(layoutParams) ? generateLayoutParams(layoutParams) : (e) layoutParams;
        generateDefaultLayoutParams.f645b = 1;
        if (!z || this.j == null) {
            addView(view, generateDefaultLayoutParams);
            return;
        }
        view.setLayoutParams(generateDefaultLayoutParams);
        this.F.add(view);
    }

    private MenuInflater getMenuInflater() {
        return new a.a.m.g(getContext());
    }

    private void h() {
        if (this.u == null) {
            this.u = new i0();
        }
    }

    private void i() {
        if (this.f == null) {
            this.f = new m(getContext());
        }
    }

    private void j() {
        k();
        if (this.f635b.N() == null) {
            androidx.appcompat.view.menu.h hVar = (androidx.appcompat.view.menu.h) this.f635b.getMenu();
            if (this.L == null) {
                this.L = new d();
            }
            this.f635b.setExpandedActionViewsExclusive(true);
            hVar.c(this.L, this.k);
        }
    }

    private void k() {
        if (this.f635b == null) {
            ActionMenuView actionMenuView = new ActionMenuView(getContext());
            this.f635b = actionMenuView;
            actionMenuView.setPopupTheme(this.l);
            this.f635b.setOnMenuItemClickListener(this.I);
            this.f635b.O(this.M, this.N);
            e generateDefaultLayoutParams = generateDefaultLayoutParams();
            generateDefaultLayoutParams.f479a = 8388613 | (this.o & 112);
            this.f635b.setLayoutParams(generateDefaultLayoutParams);
            c(this.f635b, false);
        }
    }

    private void l() {
        if (this.e == null) {
            this.e = new k(getContext(), null, a.a.a.toolbarNavigationButtonStyle);
            e generateDefaultLayoutParams = generateDefaultLayoutParams();
            generateDefaultLayoutParams.f479a = 8388611 | (this.o & 112);
            this.e.setLayoutParams(generateDefaultLayoutParams);
        }
    }

    private int p(int i) {
        int q = a.f.l.r.q(this);
        int b2 = a.f.l.c.b(i, q) & 7;
        return (b2 == 1 || b2 == 3 || b2 == 5) ? b2 : q == 1 ? 5 : 3;
    }

    private int q(View view, int i) {
        e eVar = (e) view.getLayoutParams();
        int measuredHeight = view.getMeasuredHeight();
        int i2 = i > 0 ? (measuredHeight - i) / 2 : 0;
        int r = r(eVar.f479a);
        if (r != 48) {
            if (r != 80) {
                int paddingTop = getPaddingTop();
                int paddingBottom = getPaddingBottom();
                int height = getHeight();
                int i3 = (((height - paddingTop) - paddingBottom) - measuredHeight) / 2;
                int i4 = ((ViewGroup.MarginLayoutParams) eVar).topMargin;
                if (i3 < i4) {
                    i3 = i4;
                } else {
                    int i5 = (((height - paddingBottom) - measuredHeight) - i3) - paddingTop;
                    int i6 = ((ViewGroup.MarginLayoutParams) eVar).bottomMargin;
                    if (i5 < i6) {
                        i3 = Math.max(0, i3 - (i6 - i5));
                    }
                }
                return paddingTop + i3;
            }
            return (((getHeight() - getPaddingBottom()) - measuredHeight) - ((ViewGroup.MarginLayoutParams) eVar).bottomMargin) - i2;
        }
        return getPaddingTop() - i2;
    }

    private int r(int i) {
        int i2 = i & 112;
        return (i2 == 16 || i2 == 48 || i2 == 80) ? i2 : this.x & 112;
    }

    private int s(View view) {
        ViewGroup.MarginLayoutParams marginLayoutParams = (ViewGroup.MarginLayoutParams) view.getLayoutParams();
        return a.f.l.f.b(marginLayoutParams) + a.f.l.f.a(marginLayoutParams);
    }

    private int t(View view) {
        ViewGroup.MarginLayoutParams marginLayoutParams = (ViewGroup.MarginLayoutParams) view.getLayoutParams();
        return marginLayoutParams.topMargin + marginLayoutParams.bottomMargin;
    }

    private int u(List<View> list, int[] iArr) {
        int i = iArr[0];
        int i2 = iArr[1];
        int size = list.size();
        int i3 = 0;
        int i4 = 0;
        while (i3 < size) {
            View view = list.get(i3);
            e eVar = (e) view.getLayoutParams();
            int i5 = ((ViewGroup.MarginLayoutParams) eVar).leftMargin - i;
            int i6 = ((ViewGroup.MarginLayoutParams) eVar).rightMargin - i2;
            int max = Math.max(0, i5);
            int max2 = Math.max(0, i6);
            int max3 = Math.max(0, -i5);
            int max4 = Math.max(0, -i6);
            i4 += max + view.getMeasuredWidth() + max2;
            i3++;
            i2 = max4;
            i = max3;
        }
        return i4;
    }

    private boolean x(View view) {
        return view.getParent() == this || this.F.contains(view);
    }

    void F() {
        for (int childCount = getChildCount() - 1; childCount >= 0; childCount--) {
            View childAt = getChildAt(childCount);
            if (((e) childAt.getLayoutParams()).f645b != 2 && childAt != this.f635b) {
                removeViewAt(childCount);
                this.F.add(childAt);
            }
        }
    }

    public void G(int i, int i2) {
        h();
        this.u.g(i, i2);
    }

    public void H(androidx.appcompat.view.menu.h hVar, ActionMenuPresenter actionMenuPresenter) {
        if (hVar == null && this.f635b == null) {
            return;
        }
        k();
        androidx.appcompat.view.menu.h N = this.f635b.N();
        if (N == hVar) {
            return;
        }
        if (N != null) {
            N.O(this.K);
            N.O(this.L);
        }
        if (this.L == null) {
            this.L = new d();
        }
        actionMenuPresenter.F(true);
        if (hVar != null) {
            hVar.c(actionMenuPresenter, this.k);
            hVar.c(this.L, this.k);
        } else {
            actionMenuPresenter.d(this.k, null);
            this.L.d(this.k, null);
            actionMenuPresenter.k(true);
            this.L.k(true);
        }
        this.f635b.setPopupTheme(this.l);
        this.f635b.setPresenter(actionMenuPresenter);
        this.K = actionMenuPresenter;
    }

    public void I(o.a aVar, h.a aVar2) {
        this.M = aVar;
        this.N = aVar2;
        ActionMenuView actionMenuView = this.f635b;
        if (actionMenuView != null) {
            actionMenuView.O(aVar, aVar2);
        }
    }

    public void J(Context context, int i) {
        this.n = i;
        TextView textView = this.f637d;
        if (textView != null) {
            textView.setTextAppearance(context, i);
        }
    }

    public void K(Context context, int i) {
        this.m = i;
        TextView textView = this.f636c;
        if (textView != null) {
            textView.setTextAppearance(context, i);
        }
    }

    public boolean N() {
        ActionMenuView actionMenuView = this.f635b;
        return actionMenuView != null && actionMenuView.P();
    }

    void a() {
        for (int size = this.F.size() - 1; size >= 0; size--) {
            addView(this.F.get(size));
        }
        this.F.clear();
    }

    @Override // android.view.ViewGroup
    protected boolean checkLayoutParams(ViewGroup.LayoutParams layoutParams) {
        return super.checkLayoutParams(layoutParams) && (layoutParams instanceof e);
    }

    public boolean d() {
        ActionMenuView actionMenuView;
        return getVisibility() == 0 && (actionMenuView = this.f635b) != null && actionMenuView.K();
    }

    public void e() {
        d dVar = this.L;
        androidx.appcompat.view.menu.j jVar = dVar == null ? null : dVar.f643c;
        if (jVar != null) {
            jVar.collapseActionView();
        }
    }

    public void f() {
        ActionMenuView actionMenuView = this.f635b;
        if (actionMenuView != null) {
            actionMenuView.B();
        }
    }

    void g() {
        if (this.i == null) {
            k kVar = new k(getContext(), null, a.a.a.toolbarNavigationButtonStyle);
            this.i = kVar;
            kVar.setImageDrawable(this.g);
            this.i.setContentDescription(this.h);
            e generateDefaultLayoutParams = generateDefaultLayoutParams();
            generateDefaultLayoutParams.f479a = 8388611 | (this.o & 112);
            generateDefaultLayoutParams.f645b = 2;
            this.i.setLayoutParams(generateDefaultLayoutParams);
            this.i.setOnClickListener(new c());
        }
    }

    public int getContentInsetEnd() {
        i0 i0Var = this.u;
        if (i0Var != null) {
            return i0Var.a();
        }
        return 0;
    }

    public int getContentInsetEndWithActions() {
        int i = this.w;
        return i != Integer.MIN_VALUE ? i : getContentInsetEnd();
    }

    public int getContentInsetLeft() {
        i0 i0Var = this.u;
        if (i0Var != null) {
            return i0Var.b();
        }
        return 0;
    }

    public int getContentInsetRight() {
        i0 i0Var = this.u;
        if (i0Var != null) {
            return i0Var.c();
        }
        return 0;
    }

    public int getContentInsetStart() {
        i0 i0Var = this.u;
        if (i0Var != null) {
            return i0Var.d();
        }
        return 0;
    }

    public int getContentInsetStartWithNavigation() {
        int i = this.v;
        return i != Integer.MIN_VALUE ? i : getContentInsetStart();
    }

    public int getCurrentContentInsetEnd() {
        androidx.appcompat.view.menu.h N;
        ActionMenuView actionMenuView = this.f635b;
        return actionMenuView != null && (N = actionMenuView.N()) != null && N.hasVisibleItems() ? Math.max(getContentInsetEnd(), Math.max(this.w, 0)) : getContentInsetEnd();
    }

    public int getCurrentContentInsetLeft() {
        return a.f.l.r.q(this) == 1 ? getCurrentContentInsetEnd() : getCurrentContentInsetStart();
    }

    public int getCurrentContentInsetRight() {
        return a.f.l.r.q(this) == 1 ? getCurrentContentInsetStart() : getCurrentContentInsetEnd();
    }

    public int getCurrentContentInsetStart() {
        return getNavigationIcon() != null ? Math.max(getContentInsetStart(), Math.max(this.v, 0)) : getContentInsetStart();
    }

    public Drawable getLogo() {
        ImageView imageView = this.f;
        if (imageView != null) {
            return imageView.getDrawable();
        }
        return null;
    }

    public CharSequence getLogoDescription() {
        ImageView imageView = this.f;
        if (imageView != null) {
            return imageView.getContentDescription();
        }
        return null;
    }

    public Menu getMenu() {
        j();
        return this.f635b.getMenu();
    }

    public CharSequence getNavigationContentDescription() {
        ImageButton imageButton = this.e;
        if (imageButton != null) {
            return imageButton.getContentDescription();
        }
        return null;
    }

    public Drawable getNavigationIcon() {
        ImageButton imageButton = this.e;
        if (imageButton != null) {
            return imageButton.getDrawable();
        }
        return null;
    }

    ActionMenuPresenter getOuterActionMenuPresenter() {
        return this.K;
    }

    public Drawable getOverflowIcon() {
        j();
        return this.f635b.getOverflowIcon();
    }

    Context getPopupContext() {
        return this.k;
    }

    public int getPopupTheme() {
        return this.l;
    }

    public CharSequence getSubtitle() {
        return this.z;
    }

    public CharSequence getTitle() {
        return this.y;
    }

    public int getTitleMarginBottom() {
        return this.t;
    }

    public int getTitleMarginEnd() {
        return this.r;
    }

    public int getTitleMarginStart() {
        return this.q;
    }

    public int getTitleMarginTop() {
        return this.s;
    }

    public y getWrapper() {
        if (this.J == null) {
            this.J = new r0(this, true);
        }
        return this.J;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.view.ViewGroup
    /* renamed from: m */
    public e generateDefaultLayoutParams() {
        return new e(-2, -2);
    }

    @Override // android.view.ViewGroup
    /* renamed from: n */
    public e generateLayoutParams(AttributeSet attributeSet) {
        return new e(getContext(), attributeSet);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.view.ViewGroup
    /* renamed from: o */
    public e generateLayoutParams(ViewGroup.LayoutParams layoutParams) {
        return layoutParams instanceof e ? new e((e) layoutParams) : layoutParams instanceof a.C0026a ? new e((a.C0026a) layoutParams) : layoutParams instanceof ViewGroup.MarginLayoutParams ? new e((ViewGroup.MarginLayoutParams) layoutParams) : new e(layoutParams);
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void onDetachedFromWindow() {
        super.onDetachedFromWindow();
        removeCallbacks(this.P);
    }

    @Override // android.view.View
    public boolean onHoverEvent(MotionEvent motionEvent) {
        int actionMasked = motionEvent.getActionMasked();
        if (actionMasked == 9) {
            this.D = false;
        }
        if (!this.D) {
            boolean onHoverEvent = super.onHoverEvent(motionEvent);
            if (actionMasked == 9 && !onHoverEvent) {
                this.D = true;
            }
        }
        if (actionMasked == 10 || actionMasked == 3) {
            this.D = false;
        }
        return true;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    /* JADX WARN: Removed duplicated region for block: B:110:0x0299 A[LOOP:0: B:109:0x0297->B:110:0x0299, LOOP_END] */
    /* JADX WARN: Removed duplicated region for block: B:113:0x02bb A[LOOP:1: B:112:0x02b9->B:113:0x02bb, LOOP_END] */
    /* JADX WARN: Removed duplicated region for block: B:117:0x02e5  */
    /* JADX WARN: Removed duplicated region for block: B:122:0x02f4 A[LOOP:2: B:121:0x02f2->B:122:0x02f4, LOOP_END] */
    /* JADX WARN: Removed duplicated region for block: B:20:0x005d  */
    /* JADX WARN: Removed duplicated region for block: B:26:0x0072  */
    /* JADX WARN: Removed duplicated region for block: B:32:0x00ad  */
    /* JADX WARN: Removed duplicated region for block: B:38:0x00c2  */
    /* JADX WARN: Removed duplicated region for block: B:44:0x00dd  */
    /* JADX WARN: Removed duplicated region for block: B:45:0x00f6  */
    /* JADX WARN: Removed duplicated region for block: B:47:0x00fb  */
    /* JADX WARN: Removed duplicated region for block: B:48:0x0113  */
    /* JADX WARN: Removed duplicated region for block: B:55:0x0123  */
    /* JADX WARN: Removed duplicated region for block: B:56:0x0126  */
    /* JADX WARN: Removed duplicated region for block: B:58:0x012a  */
    /* JADX WARN: Removed duplicated region for block: B:59:0x012d  */
    /* JADX WARN: Removed duplicated region for block: B:71:0x015e  */
    /* JADX WARN: Removed duplicated region for block: B:81:0x019c  */
    /* JADX WARN: Removed duplicated region for block: B:83:0x01ad  */
    /* JADX WARN: Removed duplicated region for block: B:96:0x021f  */
    @Override // android.view.ViewGroup, android.view.View
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void onLayout(boolean r20, int r21, int r22, int r23, int r24) {
        /*
            Method dump skipped, instructions count: 777
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: androidx.appcompat.widget.Toolbar.onLayout(boolean, int, int, int, int):void");
    }

    @Override // android.view.View
    protected void onMeasure(int i, int i2) {
        char c2;
        char c3;
        int i3;
        int i4;
        int i5;
        int i6;
        int i7;
        int i8;
        int i9;
        int[] iArr = this.G;
        if (w0.b(this)) {
            c3 = 1;
            c2 = 0;
        } else {
            c2 = 1;
            c3 = 0;
        }
        if (M(this.e)) {
            D(this.e, i, 0, i2, 0, this.p);
            i3 = this.e.getMeasuredWidth() + s(this.e);
            i4 = Math.max(0, this.e.getMeasuredHeight() + t(this.e));
            i5 = View.combineMeasuredStates(0, this.e.getMeasuredState());
        } else {
            i3 = 0;
            i4 = 0;
            i5 = 0;
        }
        if (M(this.i)) {
            D(this.i, i, 0, i2, 0, this.p);
            i3 = this.i.getMeasuredWidth() + s(this.i);
            i4 = Math.max(i4, this.i.getMeasuredHeight() + t(this.i));
            i5 = View.combineMeasuredStates(i5, this.i.getMeasuredState());
        }
        int currentContentInsetStart = getCurrentContentInsetStart();
        int max = 0 + Math.max(currentContentInsetStart, i3);
        iArr[c3] = Math.max(0, currentContentInsetStart - i3);
        if (M(this.f635b)) {
            D(this.f635b, i, max, i2, 0, this.p);
            i6 = this.f635b.getMeasuredWidth() + s(this.f635b);
            i4 = Math.max(i4, this.f635b.getMeasuredHeight() + t(this.f635b));
            i5 = View.combineMeasuredStates(i5, this.f635b.getMeasuredState());
        } else {
            i6 = 0;
        }
        int currentContentInsetEnd = getCurrentContentInsetEnd();
        int max2 = max + Math.max(currentContentInsetEnd, i6);
        iArr[c2] = Math.max(0, currentContentInsetEnd - i6);
        if (M(this.j)) {
            max2 += C(this.j, i, max2, i2, 0, iArr);
            i4 = Math.max(i4, this.j.getMeasuredHeight() + t(this.j));
            i5 = View.combineMeasuredStates(i5, this.j.getMeasuredState());
        }
        if (M(this.f)) {
            max2 += C(this.f, i, max2, i2, 0, iArr);
            i4 = Math.max(i4, this.f.getMeasuredHeight() + t(this.f));
            i5 = View.combineMeasuredStates(i5, this.f.getMeasuredState());
        }
        int childCount = getChildCount();
        for (int i10 = 0; i10 < childCount; i10++) {
            View childAt = getChildAt(i10);
            if (((e) childAt.getLayoutParams()).f645b == 0 && M(childAt)) {
                max2 += C(childAt, i, max2, i2, 0, iArr);
                i4 = Math.max(i4, childAt.getMeasuredHeight() + t(childAt));
                i5 = View.combineMeasuredStates(i5, childAt.getMeasuredState());
            }
        }
        int i11 = this.s + this.t;
        int i12 = this.q + this.r;
        if (M(this.f636c)) {
            C(this.f636c, i, max2 + i12, i2, i11, iArr);
            int measuredWidth = this.f636c.getMeasuredWidth() + s(this.f636c);
            i7 = this.f636c.getMeasuredHeight() + t(this.f636c);
            i8 = View.combineMeasuredStates(i5, this.f636c.getMeasuredState());
            i9 = measuredWidth;
        } else {
            i7 = 0;
            i8 = i5;
            i9 = 0;
        }
        if (M(this.f637d)) {
            i9 = Math.max(i9, C(this.f637d, i, max2 + i12, i2, i7 + i11, iArr));
            i7 += this.f637d.getMeasuredHeight() + t(this.f637d);
            i8 = View.combineMeasuredStates(i8, this.f637d.getMeasuredState());
        }
        setMeasuredDimension(View.resolveSizeAndState(Math.max(max2 + i9 + getPaddingLeft() + getPaddingRight(), getSuggestedMinimumWidth()), i, (-16777216) & i8), L() ? 0 : View.resolveSizeAndState(Math.max(Math.max(i4, i7) + getPaddingTop() + getPaddingBottom(), getSuggestedMinimumHeight()), i2, i8 << 16));
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.view.View
    public void onRestoreInstanceState(Parcelable parcelable) {
        MenuItem findItem;
        if (!(parcelable instanceof SavedState)) {
            super.onRestoreInstanceState(parcelable);
            return;
        }
        SavedState savedState = (SavedState) parcelable;
        super.onRestoreInstanceState(savedState.a());
        ActionMenuView actionMenuView = this.f635b;
        androidx.appcompat.view.menu.h N = actionMenuView != null ? actionMenuView.N() : null;
        int i = savedState.f638d;
        if (i != 0 && this.L != null && N != null && (findItem = N.findItem(i)) != null) {
            findItem.expandActionView();
        }
        if (savedState.e) {
            E();
        }
    }

    @Override // android.view.View
    public void onRtlPropertiesChanged(int i) {
        if (Build.VERSION.SDK_INT >= 17) {
            super.onRtlPropertiesChanged(i);
        }
        h();
        this.u.f(i == 1);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.view.View
    public Parcelable onSaveInstanceState() {
        androidx.appcompat.view.menu.j jVar;
        SavedState savedState = new SavedState(super.onSaveInstanceState());
        d dVar = this.L;
        if (dVar != null && (jVar = dVar.f643c) != null) {
            savedState.f638d = jVar.getItemId();
        }
        savedState.e = z();
        return savedState;
    }

    @Override // android.view.View
    public boolean onTouchEvent(MotionEvent motionEvent) {
        int actionMasked = motionEvent.getActionMasked();
        if (actionMasked == 0) {
            this.C = false;
        }
        if (!this.C) {
            boolean onTouchEvent = super.onTouchEvent(motionEvent);
            if (actionMasked == 0 && !onTouchEvent) {
                this.C = true;
            }
        }
        if (actionMasked == 1 || actionMasked == 3) {
            this.C = false;
        }
        return true;
    }

    public void setCollapsible(boolean z) {
        this.O = z;
        requestLayout();
    }

    public void setContentInsetEndWithActions(int i) {
        if (i < 0) {
            i = Integer.MIN_VALUE;
        }
        if (i != this.w) {
            this.w = i;
            if (getNavigationIcon() != null) {
                requestLayout();
            }
        }
    }

    public void setContentInsetStartWithNavigation(int i) {
        if (i < 0) {
            i = Integer.MIN_VALUE;
        }
        if (i != this.v) {
            this.v = i;
            if (getNavigationIcon() != null) {
                requestLayout();
            }
        }
    }

    public void setLogo(int i) {
        setLogo(a.a.k.a.a.d(getContext(), i));
    }

    public void setLogo(Drawable drawable) {
        if (drawable != null) {
            i();
            if (!x(this.f)) {
                c(this.f, true);
            }
        } else {
            ImageView imageView = this.f;
            if (imageView != null && x(imageView)) {
                removeView(this.f);
                this.F.remove(this.f);
            }
        }
        ImageView imageView2 = this.f;
        if (imageView2 != null) {
            imageView2.setImageDrawable(drawable);
        }
    }

    public void setLogoDescription(int i) {
        setLogoDescription(getContext().getText(i));
    }

    public void setLogoDescription(CharSequence charSequence) {
        if (!TextUtils.isEmpty(charSequence)) {
            i();
        }
        ImageView imageView = this.f;
        if (imageView != null) {
            imageView.setContentDescription(charSequence);
        }
    }

    public void setNavigationContentDescription(int i) {
        setNavigationContentDescription(i != 0 ? getContext().getText(i) : null);
    }

    public void setNavigationContentDescription(CharSequence charSequence) {
        if (!TextUtils.isEmpty(charSequence)) {
            l();
        }
        ImageButton imageButton = this.e;
        if (imageButton != null) {
            imageButton.setContentDescription(charSequence);
        }
    }

    public void setNavigationIcon(int i) {
        setNavigationIcon(a.a.k.a.a.d(getContext(), i));
    }

    public void setNavigationIcon(Drawable drawable) {
        if (drawable != null) {
            l();
            if (!x(this.e)) {
                c(this.e, true);
            }
        } else {
            ImageButton imageButton = this.e;
            if (imageButton != null && x(imageButton)) {
                removeView(this.e);
                this.F.remove(this.e);
            }
        }
        ImageButton imageButton2 = this.e;
        if (imageButton2 != null) {
            imageButton2.setImageDrawable(drawable);
        }
    }

    public void setNavigationOnClickListener(View.OnClickListener onClickListener) {
        l();
        this.e.setOnClickListener(onClickListener);
    }

    public void setOnMenuItemClickListener(f fVar) {
        this.H = fVar;
    }

    public void setOverflowIcon(Drawable drawable) {
        j();
        this.f635b.setOverflowIcon(drawable);
    }

    public void setPopupTheme(int i) {
        if (this.l != i) {
            this.l = i;
            if (i == 0) {
                this.k = getContext();
            } else {
                this.k = new ContextThemeWrapper(getContext(), i);
            }
        }
    }

    public void setSubtitle(int i) {
        setSubtitle(getContext().getText(i));
    }

    public void setSubtitle(CharSequence charSequence) {
        if (TextUtils.isEmpty(charSequence)) {
            TextView textView = this.f637d;
            if (textView != null && x(textView)) {
                removeView(this.f637d);
                this.F.remove(this.f637d);
            }
        } else {
            if (this.f637d == null) {
                Context context = getContext();
                v vVar = new v(context);
                this.f637d = vVar;
                vVar.setSingleLine();
                this.f637d.setEllipsize(TextUtils.TruncateAt.END);
                int i = this.n;
                if (i != 0) {
                    this.f637d.setTextAppearance(context, i);
                }
                int i2 = this.B;
                if (i2 != 0) {
                    this.f637d.setTextColor(i2);
                }
            }
            if (!x(this.f637d)) {
                c(this.f637d, true);
            }
        }
        TextView textView2 = this.f637d;
        if (textView2 != null) {
            textView2.setText(charSequence);
        }
        this.z = charSequence;
    }

    public void setSubtitleTextColor(int i) {
        this.B = i;
        TextView textView = this.f637d;
        if (textView != null) {
            textView.setTextColor(i);
        }
    }

    public void setTitle(int i) {
        setTitle(getContext().getText(i));
    }

    public void setTitle(CharSequence charSequence) {
        if (TextUtils.isEmpty(charSequence)) {
            TextView textView = this.f636c;
            if (textView != null && x(textView)) {
                removeView(this.f636c);
                this.F.remove(this.f636c);
            }
        } else {
            if (this.f636c == null) {
                Context context = getContext();
                v vVar = new v(context);
                this.f636c = vVar;
                vVar.setSingleLine();
                this.f636c.setEllipsize(TextUtils.TruncateAt.END);
                int i = this.m;
                if (i != 0) {
                    this.f636c.setTextAppearance(context, i);
                }
                int i2 = this.A;
                if (i2 != 0) {
                    this.f636c.setTextColor(i2);
                }
            }
            if (!x(this.f636c)) {
                c(this.f636c, true);
            }
        }
        TextView textView2 = this.f636c;
        if (textView2 != null) {
            textView2.setText(charSequence);
        }
        this.y = charSequence;
    }

    public void setTitleMarginBottom(int i) {
        this.t = i;
        requestLayout();
    }

    public void setTitleMarginEnd(int i) {
        this.r = i;
        requestLayout();
    }

    public void setTitleMarginStart(int i) {
        this.q = i;
        requestLayout();
    }

    public void setTitleMarginTop(int i) {
        this.s = i;
        requestLayout();
    }

    public void setTitleTextColor(int i) {
        this.A = i;
        TextView textView = this.f636c;
        if (textView != null) {
            textView.setTextColor(i);
        }
    }

    public boolean v() {
        d dVar = this.L;
        return (dVar == null || dVar.f643c == null) ? false : true;
    }

    public boolean w() {
        ActionMenuView actionMenuView = this.f635b;
        return actionMenuView != null && actionMenuView.H();
    }

    public boolean y() {
        ActionMenuView actionMenuView = this.f635b;
        return actionMenuView != null && actionMenuView.I();
    }

    public boolean z() {
        ActionMenuView actionMenuView = this.f635b;
        return actionMenuView != null && actionMenuView.J();
    }
}
