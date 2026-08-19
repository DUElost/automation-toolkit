package androidx.appcompat.widget;

import android.content.Context;
import android.content.res.TypedArray;
import android.database.DataSetObserver;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.os.Handler;
import android.util.AttributeSet;
import android.util.Log;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewParent;
import android.widget.AbsListView;
import android.widget.AdapterView;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.PopupWindow;
import java.lang.reflect.Method;
/* loaded from: classes.dex */
public class e0 implements androidx.appcompat.view.menu.s {
    private static Method G;
    private static Method H;
    private static Method I;
    private final b A;
    final Handler B;
    private final Rect C;
    private Rect D;
    private boolean E;
    PopupWindow F;

    /* renamed from: b  reason: collision with root package name */
    private Context f680b;

    /* renamed from: c  reason: collision with root package name */
    private ListAdapter f681c;

    /* renamed from: d  reason: collision with root package name */
    a0 f682d;
    private int e;
    private int f;
    private int g;
    private int h;
    private int i;
    private boolean j;
    private boolean k;
    private boolean l;
    private int m;
    private boolean n;
    private boolean o;
    int p;
    private View q;
    private int r;
    private DataSetObserver s;
    private View t;
    private Drawable u;
    private AdapterView.OnItemClickListener v;
    private AdapterView.OnItemSelectedListener w;
    final f x;
    private final e y;
    private final d z;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a implements AdapterView.OnItemSelectedListener {
        a() {
        }

        @Override // android.widget.AdapterView.OnItemSelectedListener
        public void onItemSelected(AdapterView<?> adapterView, View view, int i, long j) {
            a0 a0Var;
            if (i == -1 || (a0Var = e0.this.f682d) == null) {
                return;
            }
            a0Var.setListSelectionHidden(false);
        }

        @Override // android.widget.AdapterView.OnItemSelectedListener
        public void onNothingSelected(AdapterView<?> adapterView) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class b implements Runnable {
        b() {
        }

        @Override // java.lang.Runnable
        public void run() {
            e0.this.e();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class c extends DataSetObserver {
        c() {
        }

        @Override // android.database.DataSetObserver
        public void onChanged() {
            if (e0.this.f()) {
                e0.this.a();
            }
        }

        @Override // android.database.DataSetObserver
        public void onInvalidated() {
            e0.this.dismiss();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class d implements AbsListView.OnScrollListener {
        d() {
        }

        @Override // android.widget.AbsListView.OnScrollListener
        public void onScroll(AbsListView absListView, int i, int i2, int i3) {
        }

        @Override // android.widget.AbsListView.OnScrollListener
        public void onScrollStateChanged(AbsListView absListView, int i) {
            if (i != 1 || e0.this.o() || e0.this.F.getContentView() == null) {
                return;
            }
            e0 e0Var = e0.this;
            e0Var.B.removeCallbacks(e0Var.x);
            e0.this.x.run();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class e implements View.OnTouchListener {
        e() {
        }

        @Override // android.view.View.OnTouchListener
        public boolean onTouch(View view, MotionEvent motionEvent) {
            PopupWindow popupWindow;
            int action = motionEvent.getAction();
            int x = (int) motionEvent.getX();
            int y = (int) motionEvent.getY();
            if (action == 0 && (popupWindow = e0.this.F) != null && popupWindow.isShowing() && x >= 0 && x < e0.this.F.getWidth() && y >= 0 && y < e0.this.F.getHeight()) {
                e0 e0Var = e0.this;
                e0Var.B.postDelayed(e0Var.x, 250L);
                return false;
            } else if (action == 1) {
                e0 e0Var2 = e0.this;
                e0Var2.B.removeCallbacks(e0Var2.x);
                return false;
            } else {
                return false;
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class f implements Runnable {
        f() {
        }

        @Override // java.lang.Runnable
        public void run() {
            a0 a0Var = e0.this.f682d;
            if (a0Var == null || !a.f.l.r.D(a0Var) || e0.this.f682d.getCount() <= e0.this.f682d.getChildCount()) {
                return;
            }
            int childCount = e0.this.f682d.getChildCount();
            e0 e0Var = e0.this;
            if (childCount <= e0Var.p) {
                e0Var.F.setInputMethodMode(2);
                e0.this.a();
            }
        }
    }

    static {
        try {
            G = PopupWindow.class.getDeclaredMethod("setClipToScreenEnabled", Boolean.TYPE);
        } catch (NoSuchMethodException unused) {
            Log.i("ListPopupWindow", "Could not find method setClipToScreenEnabled() on PopupWindow. Oh well.");
        }
        try {
            H = PopupWindow.class.getDeclaredMethod("getMaxAvailableHeight", View.class, Integer.TYPE, Boolean.TYPE);
        } catch (NoSuchMethodException unused2) {
            Log.i("ListPopupWindow", "Could not find method getMaxAvailableHeight(View, int, boolean) on PopupWindow. Oh well.");
        }
        try {
            I = PopupWindow.class.getDeclaredMethod("setEpicenterBounds", Rect.class);
        } catch (NoSuchMethodException unused3) {
            Log.i("ListPopupWindow", "Could not find method setEpicenterBounds(Rect) on PopupWindow. Oh well.");
        }
    }

    public e0(Context context, AttributeSet attributeSet, int i) {
        this(context, attributeSet, i, 0);
    }

    public e0(Context context, AttributeSet attributeSet, int i, int i2) {
        this.e = -2;
        this.f = -2;
        this.i = 1002;
        this.m = 0;
        this.n = false;
        this.o = false;
        this.p = Integer.MAX_VALUE;
        this.r = 0;
        this.x = new f();
        this.y = new e();
        this.z = new d();
        this.A = new b();
        this.C = new Rect();
        this.f680b = context;
        this.B = new Handler(context.getMainLooper());
        TypedArray obtainStyledAttributes = context.obtainStyledAttributes(attributeSet, a.a.j.ListPopupWindow, i, i2);
        this.g = obtainStyledAttributes.getDimensionPixelOffset(a.a.j.ListPopupWindow_android_dropDownHorizontalOffset, 0);
        int dimensionPixelOffset = obtainStyledAttributes.getDimensionPixelOffset(a.a.j.ListPopupWindow_android_dropDownVerticalOffset, 0);
        this.h = dimensionPixelOffset;
        if (dimensionPixelOffset != 0) {
            this.j = true;
        }
        obtainStyledAttributes.recycle();
        o oVar = new o(context, attributeSet, i, i2);
        this.F = oVar;
        oVar.setInputMethodMode(1);
    }

    private void E(boolean z) {
        Method method = G;
        if (method != null) {
            try {
                method.invoke(this.F, Boolean.valueOf(z));
            } catch (Exception unused) {
                Log.i("ListPopupWindow", "Could not call setClipToScreenEnabled() on PopupWindow. Oh well.");
            }
        }
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Removed duplicated region for block: B:52:0x0149  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private int d() {
        /*
            Method dump skipped, instructions count: 348
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: androidx.appcompat.widget.e0.d():int");
    }

    private int l(View view, int i, boolean z) {
        Method method = H;
        if (method != null) {
            try {
                return ((Integer) method.invoke(this.F, view, Integer.valueOf(i), Boolean.valueOf(z))).intValue();
            } catch (Exception unused) {
                Log.i("ListPopupWindow", "Could not call getMaxAvailableHeightMethod(View, int, boolean) on PopupWindow. Using the public version.");
            }
        }
        return this.F.getMaxAvailableHeight(view, i);
    }

    private void q() {
        View view = this.q;
        if (view != null) {
            ViewParent parent = view.getParent();
            if (parent instanceof ViewGroup) {
                ((ViewGroup) parent).removeView(this.q);
            }
        }
    }

    public void A(boolean z) {
        this.E = z;
        this.F.setFocusable(z);
    }

    public void B(PopupWindow.OnDismissListener onDismissListener) {
        this.F.setOnDismissListener(onDismissListener);
    }

    public void C(AdapterView.OnItemClickListener onItemClickListener) {
        this.v = onItemClickListener;
    }

    public void D(boolean z) {
        this.l = true;
        this.k = z;
    }

    public void F(int i) {
        this.r = i;
    }

    public void G(int i) {
        a0 a0Var = this.f682d;
        if (!f() || a0Var == null) {
            return;
        }
        a0Var.setListSelectionHidden(false);
        a0Var.setSelection(i);
        if (a0Var.getChoiceMode() != 0) {
            a0Var.setItemChecked(i, true);
        }
    }

    public void H(int i) {
        this.h = i;
        this.j = true;
    }

    public void I(int i) {
        this.f = i;
    }

    @Override // androidx.appcompat.view.menu.s
    public void a() {
        int d2 = d();
        boolean o = o();
        androidx.core.widget.h.b(this.F, this.i);
        boolean z = true;
        if (this.F.isShowing()) {
            if (a.f.l.r.D(i())) {
                int i = this.f;
                if (i == -1) {
                    i = -1;
                } else if (i == -2) {
                    i = i().getWidth();
                }
                int i2 = this.e;
                if (i2 == -1) {
                    if (!o) {
                        d2 = -1;
                    }
                    if (o) {
                        this.F.setWidth(this.f == -1 ? -1 : 0);
                        this.F.setHeight(0);
                    } else {
                        this.F.setWidth(this.f == -1 ? -1 : 0);
                        this.F.setHeight(-1);
                    }
                } else if (i2 != -2) {
                    d2 = i2;
                }
                PopupWindow popupWindow = this.F;
                if (this.o || this.n) {
                    z = false;
                }
                popupWindow.setOutsideTouchable(z);
                this.F.update(i(), this.g, this.h, i < 0 ? -1 : i, d2 < 0 ? -1 : d2);
                return;
            }
            return;
        }
        int i3 = this.f;
        if (i3 == -1) {
            i3 = -1;
        } else if (i3 == -2) {
            i3 = i().getWidth();
        }
        int i4 = this.e;
        if (i4 == -1) {
            d2 = -1;
        } else if (i4 != -2) {
            d2 = i4;
        }
        this.F.setWidth(i3);
        this.F.setHeight(d2);
        E(true);
        this.F.setOutsideTouchable((this.o || this.n) ? false : true);
        this.F.setTouchInterceptor(this.y);
        if (this.l) {
            androidx.core.widget.h.a(this.F, this.k);
        }
        Method method = I;
        if (method != null) {
            try {
                method.invoke(this.F, this.D);
            } catch (Exception e2) {
                Log.e("ListPopupWindow", "Could not invoke setEpicenterBounds on PopupWindow", e2);
            }
        }
        androidx.core.widget.h.c(this.F, i(), this.g, this.h, this.m);
        this.f682d.setSelection(-1);
        if (!this.E || this.f682d.isInTouchMode()) {
            e();
        }
        if (this.E) {
            return;
        }
        this.B.post(this.A);
    }

    @Override // androidx.appcompat.view.menu.s
    public void dismiss() {
        this.F.dismiss();
        q();
        this.F.setContentView(null);
        this.f682d = null;
        this.B.removeCallbacks(this.x);
    }

    public void e() {
        a0 a0Var = this.f682d;
        if (a0Var != null) {
            a0Var.setListSelectionHidden(true);
            a0Var.requestLayout();
        }
    }

    @Override // androidx.appcompat.view.menu.s
    public boolean f() {
        return this.F.isShowing();
    }

    @Override // androidx.appcompat.view.menu.s
    public ListView g() {
        return this.f682d;
    }

    a0 h(Context context, boolean z) {
        return new a0(context, z);
    }

    public View i() {
        return this.t;
    }

    public Drawable j() {
        return this.F.getBackground();
    }

    public int k() {
        return this.g;
    }

    public int m() {
        if (this.j) {
            return this.h;
        }
        return 0;
    }

    public int n() {
        return this.f;
    }

    public boolean o() {
        return this.F.getInputMethodMode() == 2;
    }

    public boolean p() {
        return this.E;
    }

    public void r(ListAdapter listAdapter) {
        DataSetObserver dataSetObserver = this.s;
        if (dataSetObserver == null) {
            this.s = new c();
        } else {
            ListAdapter listAdapter2 = this.f681c;
            if (listAdapter2 != null) {
                listAdapter2.unregisterDataSetObserver(dataSetObserver);
            }
        }
        this.f681c = listAdapter;
        if (listAdapter != null) {
            listAdapter.registerDataSetObserver(this.s);
        }
        a0 a0Var = this.f682d;
        if (a0Var != null) {
            a0Var.setAdapter(this.f681c);
        }
    }

    public void s(View view) {
        this.t = view;
    }

    public void t(int i) {
        this.F.setAnimationStyle(i);
    }

    public void u(Drawable drawable) {
        this.F.setBackgroundDrawable(drawable);
    }

    public void v(int i) {
        Drawable background = this.F.getBackground();
        if (background == null) {
            I(i);
            return;
        }
        background.getPadding(this.C);
        Rect rect = this.C;
        this.f = rect.left + rect.right + i;
    }

    public void w(int i) {
        this.m = i;
    }

    public void x(Rect rect) {
        this.D = rect;
    }

    public void y(int i) {
        this.g = i;
    }

    public void z(int i) {
        this.F.setInputMethodMode(i);
    }
}
