package com.jude.easyrecyclerview;

import android.content.Context;
import android.content.res.TypedArray;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import androidx.recyclerview.widget.RecyclerView;
import com.jude.easyrecyclerview.swipe.SwipeRefreshLayout;
/* loaded from: classes.dex */
public class EasyRecyclerView extends FrameLayout {

    /* renamed from: b  reason: collision with root package name */
    protected RecyclerView f2458b;

    /* renamed from: c  reason: collision with root package name */
    protected ViewGroup f2459c;

    /* renamed from: d  reason: collision with root package name */
    protected ViewGroup f2460d;
    protected ViewGroup e;
    private int f;
    private int g;
    private int h;
    protected boolean i;
    protected int j;
    protected int k;
    protected int l;
    protected int m;
    protected int n;
    protected int o;
    protected RecyclerView.t p;
    protected RecyclerView.t q;
    protected SwipeRefreshLayout r;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a extends RecyclerView.t {
        a() {
        }

        @Override // androidx.recyclerview.widget.RecyclerView.t
        public void a(RecyclerView recyclerView, int i) {
            super.a(recyclerView, i);
            RecyclerView.t tVar = EasyRecyclerView.this.q;
            if (tVar != null) {
                tVar.a(recyclerView, i);
            }
        }

        @Override // androidx.recyclerview.widget.RecyclerView.t
        public void b(RecyclerView recyclerView, int i, int i2) {
            super.b(recyclerView, i, i2);
            RecyclerView.t tVar = EasyRecyclerView.this.q;
            if (tVar != null) {
                tVar.b(recyclerView, i, i2);
            }
        }
    }

    /* loaded from: classes.dex */
    class b implements Runnable {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ boolean f2462b;

        b(boolean z) {
            this.f2462b = z;
        }

        @Override // java.lang.Runnable
        public void run() {
            EasyRecyclerView.this.r.setRefreshing(this.f2462b);
        }
    }

    /* loaded from: classes.dex */
    private static class c extends RecyclerView.i {

        /* renamed from: a  reason: collision with root package name */
        private EasyRecyclerView f2464a;

        /* renamed from: b  reason: collision with root package name */
        private boolean f2465b = false;

        /* renamed from: c  reason: collision with root package name */
        private boolean f2466c;

        public c(EasyRecyclerView easyRecyclerView, boolean z) {
            this.f2466c = false;
            this.f2464a = easyRecyclerView;
            this.f2466c = z;
        }

        /* JADX WARN: Code restructure failed: missing block: B:15:0x0047, code lost:
            if (r5.f2465b == false) goto L13;
         */
        /* JADX WARN: Code restructure failed: missing block: B:28:0x0078, code lost:
            if (r5.f2465b == false) goto L13;
         */
        /* JADX WARN: Code restructure failed: missing block: B:29:0x007a, code lost:
            r5.f2464a.k();
         */
        /*
            Code decompiled incorrectly, please refer to instructions dump.
            To view partially-correct add '--show-bad-code' argument
        */
        private void e() {
            /*
                r5 = this;
                java.lang.String r0 = "update"
                com.jude.easyrecyclerview.EasyRecyclerView.a(r0)
                com.jude.easyrecyclerview.EasyRecyclerView r0 = r5.f2464a
                androidx.recyclerview.widget.RecyclerView$g r0 = r0.getAdapter()
                boolean r0 = r0 instanceof com.jude.easyrecyclerview.d.d
                java.lang.String r1 = "show progress"
                java.lang.String r2 = "show empty"
                java.lang.String r3 = "no data:"
                java.lang.String r4 = "has data"
                if (r0 == 0) goto L4a
                com.jude.easyrecyclerview.EasyRecyclerView r0 = r5.f2464a
                androidx.recyclerview.widget.RecyclerView$g r0 = r0.getAdapter()
                com.jude.easyrecyclerview.d.d r0 = (com.jude.easyrecyclerview.d.d) r0
                int r0 = r0.F()
                if (r0 != 0) goto L86
                java.lang.StringBuilder r0 = new java.lang.StringBuilder
                r0.<init>()
                r0.append(r3)
                boolean r3 = r5.f2466c
                if (r3 == 0) goto L36
                boolean r3 = r5.f2465b
                if (r3 != 0) goto L36
                goto L37
            L36:
                r1 = r2
            L37:
                r0.append(r1)
                java.lang.String r0 = r0.toString()
                com.jude.easyrecyclerview.EasyRecyclerView.a(r0)
                boolean r0 = r5.f2466c
                if (r0 == 0) goto L80
                boolean r0 = r5.f2465b
                if (r0 != 0) goto L80
                goto L7a
            L4a:
                com.jude.easyrecyclerview.EasyRecyclerView r0 = r5.f2464a
                androidx.recyclerview.widget.RecyclerView$g r0 = r0.getAdapter()
                int r0 = r0.c()
                if (r0 != 0) goto L86
                java.lang.StringBuilder r0 = new java.lang.StringBuilder
                r0.<init>()
                r0.append(r3)
                boolean r3 = r5.f2466c
                if (r3 == 0) goto L67
                boolean r3 = r5.f2465b
                if (r3 != 0) goto L67
                goto L68
            L67:
                r1 = r2
            L68:
                r0.append(r1)
                java.lang.String r0 = r0.toString()
                com.jude.easyrecyclerview.EasyRecyclerView.a(r0)
                boolean r0 = r5.f2466c
                if (r0 == 0) goto L80
                boolean r0 = r5.f2465b
                if (r0 != 0) goto L80
            L7a:
                com.jude.easyrecyclerview.EasyRecyclerView r0 = r5.f2464a
                r0.k()
                goto L8e
            L80:
                com.jude.easyrecyclerview.EasyRecyclerView r0 = r5.f2464a
                r0.i()
                goto L8e
            L86:
                com.jude.easyrecyclerview.EasyRecyclerView.a(r4)
                com.jude.easyrecyclerview.EasyRecyclerView r0 = r5.f2464a
                r0.l()
            L8e:
                r0 = 1
                r5.f2465b = r0
                return
            */
            throw new UnsupportedOperationException("Method not decompiled: com.jude.easyrecyclerview.EasyRecyclerView.c.e():void");
        }

        @Override // androidx.recyclerview.widget.RecyclerView.i
        public void a() {
            super.a();
            e();
        }

        @Override // androidx.recyclerview.widget.RecyclerView.i
        public void b(int i, int i2) {
            super.b(i, i2);
            e();
        }

        @Override // androidx.recyclerview.widget.RecyclerView.i
        public void d(int i, int i2) {
            super.d(i, i2);
            e();
        }
    }

    public EasyRecyclerView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        d(attributeSet);
        f();
    }

    private void c() {
        this.f2460d.setVisibility(8);
        this.f2459c.setVisibility(8);
        this.e.setVisibility(8);
        this.r.setRefreshing(false);
        this.f2458b.setVisibility(4);
    }

    private void f() {
        if (isInEditMode()) {
            return;
        }
        View inflate = LayoutInflater.from(getContext()).inflate(com.jude.easyrecyclerview.b.layout_progress_recyclerview, this);
        SwipeRefreshLayout swipeRefreshLayout = (SwipeRefreshLayout) inflate.findViewById(com.jude.easyrecyclerview.a.ptr_layout);
        this.r = swipeRefreshLayout;
        swipeRefreshLayout.setEnabled(false);
        this.f2459c = (ViewGroup) inflate.findViewById(com.jude.easyrecyclerview.a.progress);
        if (this.f != 0) {
            LayoutInflater.from(getContext()).inflate(this.f, this.f2459c);
        }
        this.f2460d = (ViewGroup) inflate.findViewById(com.jude.easyrecyclerview.a.empty);
        if (this.g != 0) {
            LayoutInflater.from(getContext()).inflate(this.g, this.f2460d);
        }
        this.e = (ViewGroup) inflate.findViewById(com.jude.easyrecyclerview.a.error);
        if (this.h != 0) {
            LayoutInflater.from(getContext()).inflate(this.h, this.e);
        }
        e(inflate);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void g(String str) {
    }

    public void b(RecyclerView.n nVar) {
        this.f2458b.i(nVar);
    }

    protected void d(AttributeSet attributeSet) {
        TypedArray obtainStyledAttributes = getContext().obtainStyledAttributes(attributeSet, com.jude.easyrecyclerview.c.superrecyclerview);
        try {
            this.i = obtainStyledAttributes.getBoolean(com.jude.easyrecyclerview.c.superrecyclerview_recyclerClipToPadding, false);
            this.j = (int) obtainStyledAttributes.getDimension(com.jude.easyrecyclerview.c.superrecyclerview_recyclerPadding, -1.0f);
            this.k = (int) obtainStyledAttributes.getDimension(com.jude.easyrecyclerview.c.superrecyclerview_recyclerPaddingTop, 0.0f);
            this.l = (int) obtainStyledAttributes.getDimension(com.jude.easyrecyclerview.c.superrecyclerview_recyclerPaddingBottom, 0.0f);
            this.m = (int) obtainStyledAttributes.getDimension(com.jude.easyrecyclerview.c.superrecyclerview_recyclerPaddingLeft, 0.0f);
            this.n = (int) obtainStyledAttributes.getDimension(com.jude.easyrecyclerview.c.superrecyclerview_recyclerPaddingRight, 0.0f);
            this.o = obtainStyledAttributes.getInteger(com.jude.easyrecyclerview.c.superrecyclerview_scrollbarStyle, -1);
            this.g = obtainStyledAttributes.getResourceId(com.jude.easyrecyclerview.c.superrecyclerview_layout_empty, 0);
            this.f = obtainStyledAttributes.getResourceId(com.jude.easyrecyclerview.c.superrecyclerview_layout_progress, 0);
            this.h = obtainStyledAttributes.getResourceId(com.jude.easyrecyclerview.c.superrecyclerview_layout_error, 0);
        } finally {
            obtainStyledAttributes.recycle();
        }
    }

    @Override // android.view.ViewGroup, android.view.View
    public boolean dispatchTouchEvent(MotionEvent motionEvent) {
        return this.r.dispatchTouchEvent(motionEvent);
    }

    protected void e(View view) {
        RecyclerView recyclerView = (RecyclerView) view.findViewById(16908298);
        this.f2458b = recyclerView;
        if (recyclerView != null) {
            recyclerView.setHasFixedSize(true);
            this.f2458b.setClipToPadding(this.i);
            a aVar = new a();
            this.p = aVar;
            this.f2458b.l(aVar);
            int i = this.j;
            if (i != -1.0f) {
                this.f2458b.setPadding(i, i, i, i);
            } else {
                this.f2458b.setPadding(this.m, this.k, this.n, this.l);
            }
            int i2 = this.o;
            if (i2 != -1) {
                this.f2458b.setScrollBarStyle(i2);
            }
        }
        l();
    }

    public RecyclerView.g getAdapter() {
        return this.f2458b.getAdapter();
    }

    public View getEmptyView() {
        if (this.f2460d.getChildCount() > 0) {
            return this.f2460d.getChildAt(0);
        }
        return null;
    }

    public View getErrorView() {
        if (this.e.getChildCount() > 0) {
            return this.e.getChildAt(0);
        }
        return null;
    }

    public View getProgressView() {
        if (this.f2459c.getChildCount() > 0) {
            return this.f2459c.getChildAt(0);
        }
        return null;
    }

    public RecyclerView getRecyclerView() {
        return this.f2458b;
    }

    public SwipeRefreshLayout getSwipeToRefresh() {
        return this.r;
    }

    public void h(int i, int i2, int i3, int i4) {
        this.r.setColorSchemeColors(i, i2, i3, i4);
    }

    public void i() {
        g("showEmpty");
        if (this.f2460d.getChildCount() <= 0) {
            l();
            return;
        }
        c();
        this.f2460d.setVisibility(0);
    }

    public void j() {
        g("showError");
        if (this.e.getChildCount() <= 0) {
            l();
            return;
        }
        c();
        this.e.setVisibility(0);
    }

    public void k() {
        g("showProgress");
        if (this.f2459c.getChildCount() <= 0) {
            l();
            return;
        }
        c();
        this.f2459c.setVisibility(0);
    }

    public void l() {
        g("showRecycler");
        c();
        this.f2458b.setVisibility(0);
    }

    public void setAdapter(RecyclerView.g gVar) {
        this.f2458b.setAdapter(gVar);
        gVar.t(new c(this, false));
        gVar.g();
    }

    public void setAdapterWithProgress(RecyclerView.g gVar) {
        this.f2458b.setAdapter(gVar);
        gVar.t(new c(this, true));
        gVar.g();
    }

    public void setEmptyView(int i) {
        this.f2460d.removeAllViews();
        LayoutInflater.from(getContext()).inflate(i, this.f2460d);
    }

    public void setEmptyView(View view) {
        this.f2460d.removeAllViews();
        this.f2460d.addView(view);
    }

    public void setErrorView(int i) {
        this.e.removeAllViews();
        LayoutInflater.from(getContext()).inflate(i, this.e);
    }

    public void setErrorView(View view) {
        this.e.removeAllViews();
        this.e.addView(view);
    }

    public void setItemAnimator(RecyclerView.l lVar) {
        this.f2458b.setItemAnimator(lVar);
    }

    public void setLayoutManager(RecyclerView.o oVar) {
        this.f2458b.setLayoutManager(oVar);
    }

    public void setOnScrollListener(RecyclerView.t tVar) {
        this.q = tVar;
    }

    @Override // android.view.View
    public void setOnTouchListener(View.OnTouchListener onTouchListener) {
        this.f2458b.setOnTouchListener(onTouchListener);
    }

    public void setProgressView(int i) {
        this.f2459c.removeAllViews();
        LayoutInflater.from(getContext()).inflate(i, this.f2459c);
    }

    public void setProgressView(View view) {
        this.f2459c.removeAllViews();
        this.f2459c.addView(view);
    }

    public void setRefreshListener(a.l.a.a aVar) {
        this.r.setEnabled(true);
        this.r.setOnRefreshListener(aVar);
    }

    public void setRefreshing(boolean z) {
        this.r.post(new b(z));
    }
}
