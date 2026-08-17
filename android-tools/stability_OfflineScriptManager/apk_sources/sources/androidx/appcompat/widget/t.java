package androidx.appcompat.widget;

import android.content.Context;
import android.content.res.ColorStateList;
import android.content.res.Resources;
import android.database.DataSetObserver;
import android.graphics.PorterDuff;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewTreeObserver;
import android.widget.AdapterView;
import android.widget.ListAdapter;
import android.widget.PopupWindow;
import android.widget.Spinner;
import android.widget.SpinnerAdapter;
import android.widget.ThemedSpinnerAdapter;
/* loaded from: classes.dex */
public class t extends Spinner implements a.f.l.q {
    private static final int[] j = {16843505};

    /* renamed from: b  reason: collision with root package name */
    private final d f764b;

    /* renamed from: c  reason: collision with root package name */
    private final Context f765c;

    /* renamed from: d  reason: collision with root package name */
    private c0 f766d;
    private SpinnerAdapter e;
    private final boolean f;
    c g;
    int h;
    final Rect i;

    /* loaded from: classes.dex */
    class a extends c0 {
        final /* synthetic */ c k;

        /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
        a(View view, c cVar) {
            super(view);
            this.k = cVar;
        }

        @Override // androidx.appcompat.widget.c0
        public androidx.appcompat.view.menu.s b() {
            return this.k;
        }

        @Override // androidx.appcompat.widget.c0
        public boolean c() {
            if (t.this.g.f()) {
                return true;
            }
            t.this.g.a();
            return true;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class b implements ListAdapter, SpinnerAdapter {

        /* renamed from: b  reason: collision with root package name */
        private SpinnerAdapter f767b;

        /* renamed from: c  reason: collision with root package name */
        private ListAdapter f768c;

        public b(SpinnerAdapter spinnerAdapter, Resources.Theme theme) {
            this.f767b = spinnerAdapter;
            if (spinnerAdapter instanceof ListAdapter) {
                this.f768c = (ListAdapter) spinnerAdapter;
            }
            if (theme != null) {
                if (Build.VERSION.SDK_INT >= 23 && (spinnerAdapter instanceof ThemedSpinnerAdapter)) {
                    ThemedSpinnerAdapter themedSpinnerAdapter = (ThemedSpinnerAdapter) spinnerAdapter;
                    if (themedSpinnerAdapter.getDropDownViewTheme() != theme) {
                        themedSpinnerAdapter.setDropDownViewTheme(theme);
                    }
                } else if (spinnerAdapter instanceof m0) {
                    m0 m0Var = (m0) spinnerAdapter;
                    if (m0Var.getDropDownViewTheme() == null) {
                        m0Var.setDropDownViewTheme(theme);
                    }
                }
            }
        }

        @Override // android.widget.ListAdapter
        public boolean areAllItemsEnabled() {
            ListAdapter listAdapter = this.f768c;
            if (listAdapter != null) {
                return listAdapter.areAllItemsEnabled();
            }
            return true;
        }

        @Override // android.widget.Adapter
        public int getCount() {
            SpinnerAdapter spinnerAdapter = this.f767b;
            if (spinnerAdapter == null) {
                return 0;
            }
            return spinnerAdapter.getCount();
        }

        @Override // android.widget.SpinnerAdapter
        public View getDropDownView(int i, View view, ViewGroup viewGroup) {
            SpinnerAdapter spinnerAdapter = this.f767b;
            if (spinnerAdapter == null) {
                return null;
            }
            return spinnerAdapter.getDropDownView(i, view, viewGroup);
        }

        @Override // android.widget.Adapter
        public Object getItem(int i) {
            SpinnerAdapter spinnerAdapter = this.f767b;
            if (spinnerAdapter == null) {
                return null;
            }
            return spinnerAdapter.getItem(i);
        }

        @Override // android.widget.Adapter
        public long getItemId(int i) {
            SpinnerAdapter spinnerAdapter = this.f767b;
            if (spinnerAdapter == null) {
                return -1L;
            }
            return spinnerAdapter.getItemId(i);
        }

        @Override // android.widget.Adapter
        public int getItemViewType(int i) {
            return 0;
        }

        @Override // android.widget.Adapter
        public View getView(int i, View view, ViewGroup viewGroup) {
            return getDropDownView(i, view, viewGroup);
        }

        @Override // android.widget.Adapter
        public int getViewTypeCount() {
            return 1;
        }

        @Override // android.widget.Adapter
        public boolean hasStableIds() {
            SpinnerAdapter spinnerAdapter = this.f767b;
            return spinnerAdapter != null && spinnerAdapter.hasStableIds();
        }

        @Override // android.widget.Adapter
        public boolean isEmpty() {
            return getCount() == 0;
        }

        @Override // android.widget.ListAdapter
        public boolean isEnabled(int i) {
            ListAdapter listAdapter = this.f768c;
            if (listAdapter != null) {
                return listAdapter.isEnabled(i);
            }
            return true;
        }

        @Override // android.widget.Adapter
        public void registerDataSetObserver(DataSetObserver dataSetObserver) {
            SpinnerAdapter spinnerAdapter = this.f767b;
            if (spinnerAdapter != null) {
                spinnerAdapter.registerDataSetObserver(dataSetObserver);
            }
        }

        @Override // android.widget.Adapter
        public void unregisterDataSetObserver(DataSetObserver dataSetObserver) {
            SpinnerAdapter spinnerAdapter = this.f767b;
            if (spinnerAdapter != null) {
                spinnerAdapter.unregisterDataSetObserver(dataSetObserver);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class c extends e0 {
        private CharSequence J;
        ListAdapter K;
        private final Rect L;

        /* loaded from: classes.dex */
        class a implements AdapterView.OnItemClickListener {
            a(t tVar) {
            }

            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                t.this.setSelection(i);
                if (t.this.getOnItemClickListener() != null) {
                    c cVar = c.this;
                    t.this.performItemClick(view, i, cVar.K.getItemId(i));
                }
                c.this.dismiss();
            }
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        /* loaded from: classes.dex */
        public class b implements ViewTreeObserver.OnGlobalLayoutListener {
            b() {
            }

            @Override // android.view.ViewTreeObserver.OnGlobalLayoutListener
            public void onGlobalLayout() {
                c cVar = c.this;
                if (!cVar.M(t.this)) {
                    c.this.dismiss();
                    return;
                }
                c.this.K();
                c.super.a();
            }
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        /* renamed from: androidx.appcompat.widget.t$c$c  reason: collision with other inner class name */
        /* loaded from: classes.dex */
        public class C0028c implements PopupWindow.OnDismissListener {

            /* renamed from: b  reason: collision with root package name */
            final /* synthetic */ ViewTreeObserver.OnGlobalLayoutListener f771b;

            C0028c(ViewTreeObserver.OnGlobalLayoutListener onGlobalLayoutListener) {
                this.f771b = onGlobalLayoutListener;
            }

            @Override // android.widget.PopupWindow.OnDismissListener
            public void onDismiss() {
                ViewTreeObserver viewTreeObserver = t.this.getViewTreeObserver();
                if (viewTreeObserver != null) {
                    viewTreeObserver.removeGlobalOnLayoutListener(this.f771b);
                }
            }
        }

        public c(Context context, AttributeSet attributeSet, int i) {
            super(context, attributeSet, i);
            this.L = new Rect();
            s(t.this);
            A(true);
            F(0);
            C(new a(t.this));
        }

        /* JADX WARN: Removed duplicated region for block: B:23:0x008d  */
        /* JADX WARN: Removed duplicated region for block: B:24:0x0095  */
        /*
            Code decompiled incorrectly, please refer to instructions dump.
            To view partially-correct add '--show-bad-code' argument
        */
        void K() {
            /*
                r8 = this;
                android.graphics.drawable.Drawable r0 = r8.j()
                r1 = 0
                if (r0 == 0) goto L26
                androidx.appcompat.widget.t r1 = androidx.appcompat.widget.t.this
                android.graphics.Rect r1 = r1.i
                r0.getPadding(r1)
                androidx.appcompat.widget.t r0 = androidx.appcompat.widget.t.this
                boolean r0 = androidx.appcompat.widget.w0.b(r0)
                if (r0 == 0) goto L1d
                androidx.appcompat.widget.t r0 = androidx.appcompat.widget.t.this
                android.graphics.Rect r0 = r0.i
                int r0 = r0.right
                goto L24
            L1d:
                androidx.appcompat.widget.t r0 = androidx.appcompat.widget.t.this
                android.graphics.Rect r0 = r0.i
                int r0 = r0.left
                int r0 = -r0
            L24:
                r1 = r0
                goto L2e
            L26:
                androidx.appcompat.widget.t r0 = androidx.appcompat.widget.t.this
                android.graphics.Rect r0 = r0.i
                r0.right = r1
                r0.left = r1
            L2e:
                androidx.appcompat.widget.t r0 = androidx.appcompat.widget.t.this
                int r0 = r0.getPaddingLeft()
                androidx.appcompat.widget.t r2 = androidx.appcompat.widget.t.this
                int r2 = r2.getPaddingRight()
                androidx.appcompat.widget.t r3 = androidx.appcompat.widget.t.this
                int r3 = r3.getWidth()
                androidx.appcompat.widget.t r4 = androidx.appcompat.widget.t.this
                int r5 = r4.h
                r6 = -2
                if (r5 != r6) goto L78
                android.widget.ListAdapter r5 = r8.K
                android.widget.SpinnerAdapter r5 = (android.widget.SpinnerAdapter) r5
                android.graphics.drawable.Drawable r6 = r8.j()
                int r4 = r4.a(r5, r6)
                androidx.appcompat.widget.t r5 = androidx.appcompat.widget.t.this
                android.content.Context r5 = r5.getContext()
                android.content.res.Resources r5 = r5.getResources()
                android.util.DisplayMetrics r5 = r5.getDisplayMetrics()
                int r5 = r5.widthPixels
                androidx.appcompat.widget.t r6 = androidx.appcompat.widget.t.this
                android.graphics.Rect r6 = r6.i
                int r7 = r6.left
                int r5 = r5 - r7
                int r6 = r6.right
                int r5 = r5 - r6
                if (r4 <= r5) goto L70
                r4 = r5
            L70:
                int r5 = r3 - r0
                int r5 = r5 - r2
                int r4 = java.lang.Math.max(r4, r5)
                goto L7e
            L78:
                r4 = -1
                if (r5 != r4) goto L82
                int r4 = r3 - r0
                int r4 = r4 - r2
            L7e:
                r8.v(r4)
                goto L85
            L82:
                r8.v(r5)
            L85:
                androidx.appcompat.widget.t r4 = androidx.appcompat.widget.t.this
                boolean r4 = androidx.appcompat.widget.w0.b(r4)
                if (r4 == 0) goto L95
                int r3 = r3 - r2
                int r0 = r8.n()
                int r3 = r3 - r0
                int r1 = r1 + r3
                goto L96
            L95:
                int r1 = r1 + r0
            L96:
                r8.y(r1)
                return
            */
            throw new UnsupportedOperationException("Method not decompiled: androidx.appcompat.widget.t.c.K():void");
        }

        public CharSequence L() {
            return this.J;
        }

        boolean M(View view) {
            return a.f.l.r.D(view) && view.getGlobalVisibleRect(this.L);
        }

        public void N(CharSequence charSequence) {
            this.J = charSequence;
        }

        @Override // androidx.appcompat.widget.e0, androidx.appcompat.view.menu.s
        public void a() {
            ViewTreeObserver viewTreeObserver;
            boolean f = f();
            K();
            z(2);
            super.a();
            g().setChoiceMode(1);
            G(t.this.getSelectedItemPosition());
            if (f || (viewTreeObserver = t.this.getViewTreeObserver()) == null) {
                return;
            }
            b bVar = new b();
            viewTreeObserver.addOnGlobalLayoutListener(bVar);
            B(new C0028c(bVar));
        }

        @Override // androidx.appcompat.widget.e0
        public void r(ListAdapter listAdapter) {
            super.r(listAdapter);
            this.K = listAdapter;
        }
    }

    public t(Context context, AttributeSet attributeSet) {
        this(context, attributeSet, a.a.a.spinnerStyle);
    }

    public t(Context context, AttributeSet attributeSet, int i) {
        this(context, attributeSet, i, -1);
    }

    public t(Context context, AttributeSet attributeSet, int i, int i2) {
        this(context, attributeSet, i, i2, null);
    }

    /* JADX WARN: Code restructure failed: missing block: B:22:0x0054, code lost:
        if (r12 != null) goto L19;
     */
    /* JADX WARN: Code restructure failed: missing block: B:23:0x0056, code lost:
        r12.recycle();
     */
    /* JADX WARN: Code restructure failed: missing block: B:31:0x0067, code lost:
        if (r12 == null) goto L9;
     */
    /* JADX WARN: Removed duplicated region for block: B:16:0x0041  */
    /* JADX WARN: Removed duplicated region for block: B:36:0x006e  */
    /* JADX WARN: Removed duplicated region for block: B:42:0x00b2  */
    /* JADX WARN: Removed duplicated region for block: B:45:0x00cb  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public t(android.content.Context r8, android.util.AttributeSet r9, int r10, int r11, android.content.res.Resources.Theme r12) {
        /*
            r7 = this;
            r7.<init>(r8, r9, r10)
            android.graphics.Rect r0 = new android.graphics.Rect
            r0.<init>()
            r7.i = r0
            int[] r0 = a.a.j.Spinner
            r1 = 0
            androidx.appcompat.widget.q0 r0 = androidx.appcompat.widget.q0.t(r8, r9, r0, r10, r1)
            androidx.appcompat.widget.d r2 = new androidx.appcompat.widget.d
            r2.<init>(r7)
            r7.f764b = r2
            r2 = 0
            if (r12 == 0) goto L23
            a.a.m.d r3 = new a.a.m.d
            r3.<init>(r8, r12)
        L20:
            r7.f765c = r3
            goto L3c
        L23:
            int r12 = a.a.j.Spinner_popupTheme
            int r12 = r0.m(r12, r1)
            if (r12 == 0) goto L31
            a.a.m.d r3 = new a.a.m.d
            r3.<init>(r8, r12)
            goto L20
        L31:
            int r12 = android.os.Build.VERSION.SDK_INT
            r3 = 23
            if (r12 >= r3) goto L39
            r12 = r8
            goto L3a
        L39:
            r12 = r2
        L3a:
            r7.f765c = r12
        L3c:
            android.content.Context r12 = r7.f765c
            r3 = 1
            if (r12 == 0) goto Laa
            r12 = -1
            if (r11 != r12) goto L72
            int[] r12 = androidx.appcompat.widget.t.j     // Catch: java.lang.Throwable -> L5c java.lang.Exception -> L5e
            android.content.res.TypedArray r12 = r8.obtainStyledAttributes(r9, r12, r10, r1)     // Catch: java.lang.Throwable -> L5c java.lang.Exception -> L5e
            boolean r4 = r12.hasValue(r1)     // Catch: java.lang.Exception -> L5a java.lang.Throwable -> L6a
            if (r4 == 0) goto L54
            int r11 = r12.getInt(r1, r1)     // Catch: java.lang.Exception -> L5a java.lang.Throwable -> L6a
        L54:
            if (r12 == 0) goto L72
        L56:
            r12.recycle()
            goto L72
        L5a:
            r4 = move-exception
            goto L60
        L5c:
            r8 = move-exception
            goto L6c
        L5e:
            r4 = move-exception
            r12 = r2
        L60:
            java.lang.String r5 = "AppCompatSpinner"
            java.lang.String r6 = "Could not read android:spinnerMode"
            android.util.Log.i(r5, r6, r4)     // Catch: java.lang.Throwable -> L6a
            if (r12 == 0) goto L72
            goto L56
        L6a:
            r8 = move-exception
            r2 = r12
        L6c:
            if (r2 == 0) goto L71
            r2.recycle()
        L71:
            throw r8
        L72:
            if (r11 != r3) goto Laa
            androidx.appcompat.widget.t$c r11 = new androidx.appcompat.widget.t$c
            android.content.Context r12 = r7.f765c
            r11.<init>(r12, r9, r10)
            android.content.Context r12 = r7.f765c
            int[] r4 = a.a.j.Spinner
            androidx.appcompat.widget.q0 r12 = androidx.appcompat.widget.q0.t(r12, r9, r4, r10, r1)
            int r1 = a.a.j.Spinner_android_dropDownWidth
            r4 = -2
            int r1 = r12.l(r1, r4)
            r7.h = r1
            int r1 = a.a.j.Spinner_android_popupBackground
            android.graphics.drawable.Drawable r1 = r12.f(r1)
            r11.u(r1)
            int r1 = a.a.j.Spinner_android_prompt
            java.lang.String r1 = r0.n(r1)
            r11.N(r1)
            r12.u()
            r7.g = r11
            androidx.appcompat.widget.t$a r12 = new androidx.appcompat.widget.t$a
            r12.<init>(r7, r11)
            r7.f766d = r12
        Laa:
            int r11 = a.a.j.Spinner_android_entries
            java.lang.CharSequence[] r11 = r0.p(r11)
            if (r11 == 0) goto Lc2
            android.widget.ArrayAdapter r12 = new android.widget.ArrayAdapter
            r1 = 17367048(0x1090008, float:2.5162948E-38)
            r12.<init>(r8, r1, r11)
            int r8 = a.a.g.support_simple_spinner_dropdown_item
            r12.setDropDownViewResource(r8)
            r7.setAdapter(r12)
        Lc2:
            r0.u()
            r7.f = r3
            android.widget.SpinnerAdapter r8 = r7.e
            if (r8 == 0) goto Ld0
            r7.setAdapter(r8)
            r7.e = r2
        Ld0:
            androidx.appcompat.widget.d r8 = r7.f764b
            r8.e(r9, r10)
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: androidx.appcompat.widget.t.<init>(android.content.Context, android.util.AttributeSet, int, int, android.content.res.Resources$Theme):void");
    }

    int a(SpinnerAdapter spinnerAdapter, Drawable drawable) {
        int i = 0;
        if (spinnerAdapter == null) {
            return 0;
        }
        int makeMeasureSpec = View.MeasureSpec.makeMeasureSpec(getMeasuredWidth(), 0);
        int makeMeasureSpec2 = View.MeasureSpec.makeMeasureSpec(getMeasuredHeight(), 0);
        int max = Math.max(0, getSelectedItemPosition());
        int min = Math.min(spinnerAdapter.getCount(), max + 15);
        View view = null;
        int i2 = 0;
        for (int max2 = Math.max(0, max - (15 - (min - max))); max2 < min; max2++) {
            int itemViewType = spinnerAdapter.getItemViewType(max2);
            if (itemViewType != i) {
                view = null;
                i = itemViewType;
            }
            view = spinnerAdapter.getView(max2, view, this);
            if (view.getLayoutParams() == null) {
                view.setLayoutParams(new ViewGroup.LayoutParams(-2, -2));
            }
            view.measure(makeMeasureSpec, makeMeasureSpec2);
            i2 = Math.max(i2, view.getMeasuredWidth());
        }
        if (drawable != null) {
            drawable.getPadding(this.i);
            Rect rect = this.i;
            return i2 + rect.left + rect.right;
        }
        return i2;
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void drawableStateChanged() {
        super.drawableStateChanged();
        d dVar = this.f764b;
        if (dVar != null) {
            dVar.b();
        }
    }

    @Override // android.widget.Spinner
    public int getDropDownHorizontalOffset() {
        c cVar = this.g;
        if (cVar != null) {
            return cVar.k();
        }
        if (Build.VERSION.SDK_INT >= 16) {
            return super.getDropDownHorizontalOffset();
        }
        return 0;
    }

    @Override // android.widget.Spinner
    public int getDropDownVerticalOffset() {
        c cVar = this.g;
        if (cVar != null) {
            return cVar.m();
        }
        if (Build.VERSION.SDK_INT >= 16) {
            return super.getDropDownVerticalOffset();
        }
        return 0;
    }

    @Override // android.widget.Spinner
    public int getDropDownWidth() {
        if (this.g != null) {
            return this.h;
        }
        if (Build.VERSION.SDK_INT >= 16) {
            return super.getDropDownWidth();
        }
        return 0;
    }

    @Override // android.widget.Spinner
    public Drawable getPopupBackground() {
        c cVar = this.g;
        if (cVar != null) {
            return cVar.j();
        }
        if (Build.VERSION.SDK_INT >= 16) {
            return super.getPopupBackground();
        }
        return null;
    }

    @Override // android.widget.Spinner
    public Context getPopupContext() {
        if (this.g != null) {
            return this.f765c;
        }
        if (Build.VERSION.SDK_INT >= 23) {
            return super.getPopupContext();
        }
        return null;
    }

    @Override // android.widget.Spinner
    public CharSequence getPrompt() {
        c cVar = this.g;
        return cVar != null ? cVar.L() : super.getPrompt();
    }

    @Override // a.f.l.q
    public ColorStateList getSupportBackgroundTintList() {
        d dVar = this.f764b;
        if (dVar != null) {
            return dVar.c();
        }
        return null;
    }

    @Override // a.f.l.q
    public PorterDuff.Mode getSupportBackgroundTintMode() {
        d dVar = this.f764b;
        if (dVar != null) {
            return dVar.d();
        }
        return null;
    }

    @Override // android.widget.Spinner, android.widget.AdapterView, android.view.ViewGroup, android.view.View
    protected void onDetachedFromWindow() {
        super.onDetachedFromWindow();
        c cVar = this.g;
        if (cVar == null || !cVar.f()) {
            return;
        }
        this.g.dismiss();
    }

    @Override // android.widget.Spinner, android.widget.AbsSpinner, android.view.View
    protected void onMeasure(int i, int i2) {
        super.onMeasure(i, i2);
        if (this.g == null || View.MeasureSpec.getMode(i) != Integer.MIN_VALUE) {
            return;
        }
        setMeasuredDimension(Math.min(Math.max(getMeasuredWidth(), a(getAdapter(), getBackground())), View.MeasureSpec.getSize(i)), getMeasuredHeight());
    }

    @Override // android.widget.Spinner, android.view.View
    public boolean onTouchEvent(MotionEvent motionEvent) {
        c0 c0Var = this.f766d;
        if (c0Var == null || !c0Var.onTouch(this, motionEvent)) {
            return super.onTouchEvent(motionEvent);
        }
        return true;
    }

    @Override // android.widget.Spinner, android.view.View
    public boolean performClick() {
        c cVar = this.g;
        if (cVar != null) {
            if (cVar.f()) {
                return true;
            }
            this.g.a();
            return true;
        }
        return super.performClick();
    }

    @Override // android.widget.AdapterView
    public void setAdapter(SpinnerAdapter spinnerAdapter) {
        if (!this.f) {
            this.e = spinnerAdapter;
            return;
        }
        super.setAdapter(spinnerAdapter);
        if (this.g != null) {
            Context context = this.f765c;
            if (context == null) {
                context = getContext();
            }
            this.g.r(new b(spinnerAdapter, context.getTheme()));
        }
    }

    @Override // android.view.View
    public void setBackgroundDrawable(Drawable drawable) {
        super.setBackgroundDrawable(drawable);
        d dVar = this.f764b;
        if (dVar != null) {
            dVar.f(drawable);
        }
    }

    @Override // android.view.View
    public void setBackgroundResource(int i) {
        super.setBackgroundResource(i);
        d dVar = this.f764b;
        if (dVar != null) {
            dVar.g(i);
        }
    }

    @Override // android.widget.Spinner
    public void setDropDownHorizontalOffset(int i) {
        c cVar = this.g;
        if (cVar != null) {
            cVar.y(i);
        } else if (Build.VERSION.SDK_INT >= 16) {
            super.setDropDownHorizontalOffset(i);
        }
    }

    @Override // android.widget.Spinner
    public void setDropDownVerticalOffset(int i) {
        c cVar = this.g;
        if (cVar != null) {
            cVar.H(i);
        } else if (Build.VERSION.SDK_INT >= 16) {
            super.setDropDownVerticalOffset(i);
        }
    }

    @Override // android.widget.Spinner
    public void setDropDownWidth(int i) {
        if (this.g != null) {
            this.h = i;
        } else if (Build.VERSION.SDK_INT >= 16) {
            super.setDropDownWidth(i);
        }
    }

    @Override // android.widget.Spinner
    public void setPopupBackgroundDrawable(Drawable drawable) {
        c cVar = this.g;
        if (cVar != null) {
            cVar.u(drawable);
        } else if (Build.VERSION.SDK_INT >= 16) {
            super.setPopupBackgroundDrawable(drawable);
        }
    }

    @Override // android.widget.Spinner
    public void setPopupBackgroundResource(int i) {
        setPopupBackgroundDrawable(a.a.k.a.a.d(getPopupContext(), i));
    }

    @Override // android.widget.Spinner
    public void setPrompt(CharSequence charSequence) {
        c cVar = this.g;
        if (cVar != null) {
            cVar.N(charSequence);
        } else {
            super.setPrompt(charSequence);
        }
    }

    @Override // a.f.l.q
    public void setSupportBackgroundTintList(ColorStateList colorStateList) {
        d dVar = this.f764b;
        if (dVar != null) {
            dVar.i(colorStateList);
        }
    }

    @Override // a.f.l.q
    public void setSupportBackgroundTintMode(PorterDuff.Mode mode) {
        d dVar = this.f764b;
        if (dVar != null) {
            dVar.j(mode);
        }
    }
}
