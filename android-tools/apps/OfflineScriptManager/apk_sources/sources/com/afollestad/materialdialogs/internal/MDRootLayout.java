package com.afollestad.materialdialogs.internal;

import android.content.Context;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.os.Build;
import android.util.AttributeSet;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewTreeObserver;
import android.webkit.WebView;
import android.widget.AdapterView;
import android.widget.ScrollView;
import androidx.recyclerview.widget.RecyclerView;
import b.a.a.e;
import b.a.a.g;
import b.a.a.i;
import b.a.a.k;
import b.a.a.n;
import b.a.a.o;
/* loaded from: classes.dex */
public class MDRootLayout extends ViewGroup {

    /* renamed from: b  reason: collision with root package name */
    private final MDButton[] f1856b;

    /* renamed from: c  reason: collision with root package name */
    private int f1857c;

    /* renamed from: d  reason: collision with root package name */
    private View f1858d;
    private View e;
    private boolean f;
    private boolean g;
    private o h;
    private boolean i;
    private boolean j;
    private boolean k;
    private boolean l;
    private int m;
    private int n;
    private int o;
    private e p;
    private int q;
    private Paint r;
    private ViewTreeObserver.OnScrollChangedListener s;
    private ViewTreeObserver.OnScrollChangedListener t;
    private int u;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a implements ViewTreeObserver.OnPreDrawListener {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ View f1859b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ boolean f1860c;

        /* renamed from: d  reason: collision with root package name */
        final /* synthetic */ boolean f1861d;

        a(View view, boolean z, boolean z2) {
            this.f1859b = view;
            this.f1860c = z;
            this.f1861d = z2;
        }

        @Override // android.view.ViewTreeObserver.OnPreDrawListener
        public boolean onPreDraw() {
            if (this.f1859b.getMeasuredHeight() != 0) {
                if (MDRootLayout.l((WebView) this.f1859b)) {
                    MDRootLayout.this.h((ViewGroup) this.f1859b, this.f1860c, this.f1861d);
                } else {
                    if (this.f1860c) {
                        MDRootLayout.this.f = false;
                    }
                    if (this.f1861d) {
                        MDRootLayout.this.g = false;
                    }
                }
                this.f1859b.getViewTreeObserver().removeOnPreDrawListener(this);
                return true;
            }
            return true;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b extends RecyclerView.t {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ ViewGroup f1862a;

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ boolean f1863b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ boolean f1864c;

        b(ViewGroup viewGroup, boolean z, boolean z2) {
            this.f1862a = viewGroup;
            this.f1863b = z;
            this.f1864c = z2;
        }

        @Override // androidx.recyclerview.widget.RecyclerView.t
        public void b(RecyclerView recyclerView, int i, int i2) {
            super.b(recyclerView, i, i2);
            MDButton[] mDButtonArr = MDRootLayout.this.f1856b;
            int length = mDButtonArr.length;
            boolean z = false;
            int i3 = 0;
            while (true) {
                if (i3 < length) {
                    MDButton mDButton = mDButtonArr[i3];
                    if (mDButton != null && mDButton.getVisibility() != 8) {
                        z = true;
                        break;
                    }
                    i3++;
                } else {
                    break;
                }
            }
            MDRootLayout.this.p(this.f1862a, this.f1863b, this.f1864c, z);
            MDRootLayout.this.invalidate();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class c implements ViewTreeObserver.OnScrollChangedListener {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ ViewGroup f1866a;

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ boolean f1867b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ boolean f1868c;

        c(ViewGroup viewGroup, boolean z, boolean z2) {
            this.f1866a = viewGroup;
            this.f1867b = z;
            this.f1868c = z2;
        }

        @Override // android.view.ViewTreeObserver.OnScrollChangedListener
        public void onScrollChanged() {
            MDButton[] mDButtonArr = MDRootLayout.this.f1856b;
            int length = mDButtonArr.length;
            boolean z = false;
            int i = 0;
            while (true) {
                if (i < length) {
                    MDButton mDButton = mDButtonArr[i];
                    if (mDButton != null && mDButton.getVisibility() != 8) {
                        z = true;
                        break;
                    }
                    i++;
                } else {
                    break;
                }
            }
            ViewGroup viewGroup = this.f1866a;
            if (viewGroup instanceof WebView) {
                MDRootLayout.this.q((WebView) viewGroup, this.f1867b, this.f1868c, z);
            } else {
                MDRootLayout.this.p(viewGroup, this.f1867b, this.f1868c, z);
            }
            MDRootLayout.this.invalidate();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static /* synthetic */ class d {

        /* renamed from: a  reason: collision with root package name */
        static final /* synthetic */ int[] f1870a;

        static {
            int[] iArr = new int[e.values().length];
            f1870a = iArr;
            try {
                iArr[e.START.ordinal()] = 1;
            } catch (NoSuchFieldError unused) {
            }
            try {
                f1870a[e.END.ordinal()] = 2;
            } catch (NoSuchFieldError unused2) {
            }
        }
    }

    public MDRootLayout(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.f1856b = new MDButton[3];
        this.f = false;
        this.g = false;
        this.h = o.ADAPTIVE;
        this.i = false;
        this.j = true;
        this.p = e.START;
        o(context, attributeSet, 0);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void h(ViewGroup viewGroup, boolean z, boolean z2) {
        ViewTreeObserver viewTreeObserver;
        ViewTreeObserver.OnScrollChangedListener onScrollChangedListener;
        if ((z2 || this.s != null) && !(z2 && this.t == null)) {
            return;
        }
        if (viewGroup instanceof RecyclerView) {
            b bVar = new b(viewGroup, z, z2);
            RecyclerView recyclerView = (RecyclerView) viewGroup;
            recyclerView.l(bVar);
            bVar.b(recyclerView, 0, 0);
            return;
        }
        c cVar = new c(viewGroup, z, z2);
        if (z2) {
            this.t = cVar;
            viewTreeObserver = viewGroup.getViewTreeObserver();
            onScrollChangedListener = this.t;
        } else {
            this.s = cVar;
            viewTreeObserver = viewGroup.getViewTreeObserver();
            onScrollChangedListener = this.s;
        }
        viewTreeObserver.addOnScrollChangedListener(onScrollChangedListener);
        cVar.onScrollChanged();
    }

    private static boolean i(AdapterView adapterView) {
        if (adapterView.getLastVisiblePosition() == -1) {
            return false;
        }
        return !(adapterView.getFirstVisiblePosition() == 0) || !(adapterView.getLastVisiblePosition() == adapterView.getCount() - 1) || adapterView.getChildCount() <= 0 || adapterView.getChildAt(0).getTop() < adapterView.getPaddingTop() || adapterView.getChildAt(adapterView.getChildCount() - 1).getBottom() > adapterView.getHeight() - adapterView.getPaddingBottom();
    }

    public static boolean j(RecyclerView recyclerView) {
        return (recyclerView == null || recyclerView.getLayoutManager() == null || !recyclerView.getLayoutManager().k()) ? false : true;
    }

    private static boolean k(ScrollView scrollView) {
        if (scrollView.getChildCount() == 0) {
            return false;
        }
        return (scrollView.getMeasuredHeight() - scrollView.getPaddingTop()) - scrollView.getPaddingBottom() < scrollView.getChildAt(0).getMeasuredHeight();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static boolean l(WebView webView) {
        return ((float) webView.getMeasuredHeight()) < ((float) webView.getContentHeight()) * webView.getScale();
    }

    private static View m(ViewGroup viewGroup) {
        if (viewGroup == null || viewGroup.getChildCount() == 0) {
            return null;
        }
        for (int childCount = viewGroup.getChildCount() - 1; childCount >= 0; childCount--) {
            View childAt = viewGroup.getChildAt(childCount);
            if (childAt.getVisibility() == 0 && childAt.getBottom() == viewGroup.getMeasuredHeight()) {
                return childAt;
            }
        }
        return null;
    }

    private static View n(ViewGroup viewGroup) {
        if (viewGroup == null || viewGroup.getChildCount() == 0) {
            return null;
        }
        for (int childCount = viewGroup.getChildCount() - 1; childCount >= 0; childCount--) {
            View childAt = viewGroup.getChildAt(childCount);
            if (childAt.getVisibility() == 0 && childAt.getTop() == 0) {
                return childAt;
            }
        }
        return null;
    }

    private void o(Context context, AttributeSet attributeSet, int i) {
        Resources resources = context.getResources();
        TypedArray obtainStyledAttributes = context.obtainStyledAttributes(attributeSet, n.MDRootLayout, i, 0);
        this.k = obtainStyledAttributes.getBoolean(n.MDRootLayout_md_reduce_padding_no_title_no_buttons, true);
        obtainStyledAttributes.recycle();
        this.m = resources.getDimensionPixelSize(i.md_notitle_vertical_padding);
        this.n = resources.getDimensionPixelSize(i.md_button_frame_vertical_padding);
        this.q = resources.getDimensionPixelSize(i.md_button_padding_frame_side);
        this.o = resources.getDimensionPixelSize(i.md_button_height);
        this.r = new Paint();
        this.u = resources.getDimensionPixelSize(i.md_divider_height);
        this.r.setColor(b.a.a.q.a.l(context, g.md_divider_color));
        setWillNotDraw(false);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void p(ViewGroup viewGroup, boolean z, boolean z2, boolean z3) {
        boolean z4 = true;
        if (z && viewGroup.getChildCount() > 0) {
            View view = this.f1858d;
            this.f = (view == null || view.getVisibility() == 8 || viewGroup.getScrollY() + viewGroup.getPaddingTop() <= viewGroup.getChildAt(0).getTop()) ? false : true;
        }
        if (!z2 || viewGroup.getChildCount() <= 0) {
            return;
        }
        if (!z3 || (viewGroup.getScrollY() + viewGroup.getHeight()) - viewGroup.getPaddingBottom() >= viewGroup.getChildAt(viewGroup.getChildCount() - 1).getBottom()) {
            z4 = false;
        }
        this.g = z4;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void q(WebView webView, boolean z, boolean z2, boolean z3) {
        boolean z4 = true;
        if (z) {
            View view = this.f1858d;
            this.f = (view == null || view.getVisibility() == 8 || webView.getScrollY() + webView.getPaddingTop() <= 0) ? false : true;
        }
        if (z2) {
            if (!z3 || (webView.getScrollY() + webView.getMeasuredHeight()) - webView.getPaddingBottom() >= webView.getContentHeight() * webView.getScale()) {
                z4 = false;
            }
            this.g = z4;
        }
    }

    private void r() {
        e eVar;
        if (Build.VERSION.SDK_INT >= 17 && getResources().getConfiguration().getLayoutDirection() == 1) {
            int i = d.f1870a[this.p.ordinal()];
            if (i == 1) {
                eVar = e.END;
            } else if (i != 2) {
                return;
            } else {
                eVar = e.START;
            }
            this.p = eVar;
        }
    }

    private static boolean s(View view) {
        boolean z = (view == null || view.getVisibility() == 8) ? false : true;
        if (z && (view instanceof MDButton)) {
            return ((MDButton) view).getText().toString().trim().length() > 0;
        }
        return z;
    }

    private void u(View view, boolean z, boolean z2) {
        ScrollView scrollView;
        if (view == null) {
            return;
        }
        if (view instanceof ScrollView) {
            ScrollView scrollView2 = (ScrollView) view;
            boolean k = k(scrollView2);
            scrollView = scrollView2;
            if (!k) {
                if (z) {
                    this.f = false;
                }
                if (!z2) {
                    return;
                }
                this.g = false;
                return;
            }
            h(scrollView, z, z2);
        }
        if (view instanceof AdapterView) {
            AdapterView adapterView = (AdapterView) view;
            boolean i = i(adapterView);
            scrollView = adapterView;
            if (!i) {
                if (z) {
                    this.f = false;
                }
                if (!z2) {
                    return;
                }
                this.g = false;
                return;
            }
        } else if (view instanceof WebView) {
            view.getViewTreeObserver().addOnPreDrawListener(new a(view, z, z2));
            return;
        } else if (!(view instanceof RecyclerView)) {
            if (view instanceof ViewGroup) {
                ViewGroup viewGroup = (ViewGroup) view;
                View n = n(viewGroup);
                u(n, z, z2);
                View m = m(viewGroup);
                if (m != n) {
                    u(m, false, true);
                    return;
                }
                return;
            }
            return;
        } else {
            boolean j = j((RecyclerView) view);
            if (z) {
                this.f = j;
            }
            if (z2) {
                this.g = j;
            }
            if (!j) {
                return;
            }
            scrollView = (ViewGroup) view;
        }
        h(scrollView, z, z2);
    }

    @Override // android.view.View
    public void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        View view = this.e;
        if (view != null) {
            if (this.f) {
                int top = view.getTop();
                canvas.drawRect(0.0f, top - this.u, getMeasuredWidth(), top, this.r);
            }
            if (this.g) {
                int bottom = this.e.getBottom();
                canvas.drawRect(0.0f, bottom, getMeasuredWidth(), bottom + this.u, this.r);
            }
        }
    }

    @Override // android.view.View
    public void onFinishInflate() {
        super.onFinishInflate();
        for (int i = 0; i < getChildCount(); i++) {
            View childAt = getChildAt(i);
            if (childAt.getId() == k.md_titleFrame) {
                this.f1858d = childAt;
            } else if (childAt.getId() == k.md_buttonDefaultNeutral) {
                this.f1856b[0] = (MDButton) childAt;
            } else if (childAt.getId() == k.md_buttonDefaultNegative) {
                this.f1856b[1] = (MDButton) childAt;
            } else if (childAt.getId() == k.md_buttonDefaultPositive) {
                this.f1856b[2] = (MDButton) childAt;
            } else {
                this.e = childAt;
            }
        }
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void onLayout(boolean z, int i, int i2, int i3, int i4) {
        int i5;
        int i6;
        MDButton mDButton;
        int i7;
        int i8;
        int i9;
        int measuredWidth;
        int measuredWidth2;
        int i10;
        MDButton[] mDButtonArr;
        if (s(this.f1858d)) {
            int measuredHeight = this.f1858d.getMeasuredHeight() + i2;
            this.f1858d.layout(i, i2, i3, measuredHeight);
            i2 = measuredHeight;
        } else if (!this.l && this.j) {
            i2 += this.m;
        }
        if (s(this.e)) {
            View view = this.e;
            view.layout(i, i2, i3, view.getMeasuredHeight() + i2);
        }
        if (this.i) {
            int i11 = i4 - this.n;
            for (MDButton mDButton2 : this.f1856b) {
                if (s(mDButton2)) {
                    mDButton2.layout(i, i11 - mDButton2.getMeasuredHeight(), i3, i11);
                    i11 -= mDButton2.getMeasuredHeight();
                }
            }
        } else {
            if (this.j) {
                i4 -= this.n;
            }
            int i12 = i4 - this.o;
            int i13 = this.q;
            if (s(this.f1856b[2])) {
                if (this.p == e.END) {
                    measuredWidth2 = i + i13;
                    i10 = this.f1856b[2].getMeasuredWidth() + measuredWidth2;
                    i5 = -1;
                } else {
                    int i14 = i3 - i13;
                    measuredWidth2 = i14 - this.f1856b[2].getMeasuredWidth();
                    i10 = i14;
                    i5 = measuredWidth2;
                }
                this.f1856b[2].layout(measuredWidth2, i12, i10, i4);
                i13 += this.f1856b[2].getMeasuredWidth();
            } else {
                i5 = -1;
            }
            if (s(this.f1856b[1])) {
                e eVar = this.p;
                if (eVar == e.END) {
                    i9 = i13 + i;
                    measuredWidth = this.f1856b[1].getMeasuredWidth() + i9;
                } else if (eVar == e.START) {
                    measuredWidth = i3 - i13;
                    i9 = measuredWidth - this.f1856b[1].getMeasuredWidth();
                } else {
                    i9 = this.q + i;
                    measuredWidth = this.f1856b[1].getMeasuredWidth() + i9;
                    i6 = measuredWidth;
                    this.f1856b[1].layout(i9, i12, measuredWidth, i4);
                }
                i6 = -1;
                this.f1856b[1].layout(i9, i12, measuredWidth, i4);
            } else {
                i6 = -1;
            }
            if (s(this.f1856b[0])) {
                e eVar2 = this.p;
                if (eVar2 == e.END) {
                    i7 = i3 - this.q;
                    i8 = i7 - this.f1856b[0].getMeasuredWidth();
                } else if (eVar2 == e.START) {
                    i8 = i + this.q;
                    i7 = this.f1856b[0].getMeasuredWidth() + i8;
                } else {
                    if (i6 != -1 || i5 == -1) {
                        if (i5 == -1 && i6 != -1) {
                            mDButton = this.f1856b[0];
                        } else if (i5 == -1) {
                            i6 = ((i3 - i) / 2) - (this.f1856b[0].getMeasuredWidth() / 2);
                            mDButton = this.f1856b[0];
                        }
                        i5 = i6 + mDButton.getMeasuredWidth();
                    } else {
                        i6 = i5 - this.f1856b[0].getMeasuredWidth();
                    }
                    i7 = i5;
                    i8 = i6;
                }
                this.f1856b[0].layout(i8, i12, i7, i4);
            }
        }
        u(this.e, true, true);
    }

    /* JADX WARN: Removed duplicated region for block: B:43:0x00ac  */
    /* JADX WARN: Removed duplicated region for block: B:44:0x00bd  */
    /* JADX WARN: Removed duplicated region for block: B:49:0x00cc  */
    /* JADX WARN: Removed duplicated region for block: B:60:0x0111  */
    @Override // android.view.View
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void onMeasure(int r12, int r13) {
        /*
            Method dump skipped, instructions count: 279
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.afollestad.materialdialogs.internal.MDRootLayout.onMeasure(int, int):void");
    }

    public void setButtonGravity(e eVar) {
        this.p = eVar;
        r();
    }

    public void setButtonStackedGravity(e eVar) {
        MDButton[] mDButtonArr;
        for (MDButton mDButton : this.f1856b) {
            if (mDButton != null) {
                mDButton.setStackedGravity(eVar);
            }
        }
    }

    public void setDividerColor(int i) {
        this.r.setColor(i);
        invalidate();
    }

    public void setMaxHeight(int i) {
        this.f1857c = i;
    }

    public void setStackingBehavior(o oVar) {
        this.h = oVar;
        invalidate();
    }

    public void t() {
        this.l = true;
    }
}
