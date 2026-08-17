package androidx.coordinatorlayout.widget;

import a.f.l.l;
import a.f.l.n;
import a.f.l.o;
import a.f.l.r;
import a.f.l.z;
import android.content.Context;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.Region;
import android.graphics.drawable.ColorDrawable;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.SystemClock;
import android.text.TextUtils;
import android.util.AttributeSet;
import android.util.Log;
import android.util.SparseArray;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewParent;
import android.view.ViewTreeObserver;
import androidx.customview.view.AbsSavedState;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.reflect.Constructor;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jxl.SheetSettings;
/* loaded from: classes.dex */
public class CoordinatorLayout extends ViewGroup implements l {
    static final String u;
    static final Class<?>[] v;
    static final ThreadLocal<Map<String, Constructor<c>>> w;
    static final Comparator<View> x;
    private static final a.f.k.d<Rect> y;

    /* renamed from: b  reason: collision with root package name */
    private final List<View> f813b;

    /* renamed from: c  reason: collision with root package name */
    private final androidx.coordinatorlayout.widget.a<View> f814c;

    /* renamed from: d  reason: collision with root package name */
    private final List<View> f815d;
    private final List<View> e;
    private final int[] f;
    private Paint g;
    private boolean h;
    private boolean i;
    private int[] j;
    private View k;
    private View l;
    private g m;
    private boolean n;
    private z o;
    private boolean p;
    private Drawable q;
    ViewGroup.OnHierarchyChangeListener r;
    private o s;
    private final n t;

    /* JADX INFO: Access modifiers changed from: protected */
    /* loaded from: classes.dex */
    public static class SavedState extends AbsSavedState {
        public static final Parcelable.Creator<SavedState> CREATOR = new a();

        /* renamed from: d  reason: collision with root package name */
        SparseArray<Parcelable> f816d;

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
            int readInt = parcel.readInt();
            int[] iArr = new int[readInt];
            parcel.readIntArray(iArr);
            Parcelable[] readParcelableArray = parcel.readParcelableArray(classLoader);
            this.f816d = new SparseArray<>(readInt);
            for (int i = 0; i < readInt; i++) {
                this.f816d.append(iArr[i], readParcelableArray[i]);
            }
        }

        public SavedState(Parcelable parcelable) {
            super(parcelable);
        }

        @Override // androidx.customview.view.AbsSavedState, android.os.Parcelable
        public void writeToParcel(Parcel parcel, int i) {
            super.writeToParcel(parcel, i);
            SparseArray<Parcelable> sparseArray = this.f816d;
            int size = sparseArray != null ? sparseArray.size() : 0;
            parcel.writeInt(size);
            int[] iArr = new int[size];
            Parcelable[] parcelableArr = new Parcelable[size];
            for (int i2 = 0; i2 < size; i2++) {
                iArr[i2] = this.f816d.keyAt(i2);
                parcelableArr[i2] = this.f816d.valueAt(i2);
            }
            parcel.writeIntArray(iArr);
            parcel.writeParcelableArray(parcelableArr, i);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a implements o {
        a() {
        }

        @Override // a.f.l.o
        public z a(View view, z zVar) {
            return CoordinatorLayout.this.V(zVar);
        }
    }

    /* loaded from: classes.dex */
    public interface b {
        c getBehavior();
    }

    /* loaded from: classes.dex */
    public static abstract class c<V extends View> {
        public c() {
        }

        public c(Context context, AttributeSet attributeSet) {
        }

        @Deprecated
        public void A(CoordinatorLayout coordinatorLayout, V v, View view) {
        }

        public void B(CoordinatorLayout coordinatorLayout, V v, View view, int i) {
            if (i == 0) {
                A(coordinatorLayout, v, view);
            }
        }

        public boolean C(CoordinatorLayout coordinatorLayout, V v, MotionEvent motionEvent) {
            return false;
        }

        public boolean a(CoordinatorLayout coordinatorLayout, V v) {
            return d(coordinatorLayout, v) > 0.0f;
        }

        public boolean b(CoordinatorLayout coordinatorLayout, V v, Rect rect) {
            return false;
        }

        public int c(CoordinatorLayout coordinatorLayout, V v) {
            return -16777216;
        }

        public float d(CoordinatorLayout coordinatorLayout, V v) {
            return 0.0f;
        }

        public boolean e(CoordinatorLayout coordinatorLayout, V v, View view) {
            return false;
        }

        public z f(CoordinatorLayout coordinatorLayout, V v, z zVar) {
            return zVar;
        }

        public void g(f fVar) {
        }

        public boolean h(CoordinatorLayout coordinatorLayout, V v, View view) {
            return false;
        }

        public void i(CoordinatorLayout coordinatorLayout, V v, View view) {
        }

        public void j() {
        }

        public boolean k(CoordinatorLayout coordinatorLayout, V v, MotionEvent motionEvent) {
            return false;
        }

        public boolean l(CoordinatorLayout coordinatorLayout, V v, int i) {
            return false;
        }

        public boolean m(CoordinatorLayout coordinatorLayout, V v, int i, int i2, int i3, int i4) {
            return false;
        }

        public boolean n(CoordinatorLayout coordinatorLayout, V v, View view, float f, float f2, boolean z) {
            return false;
        }

        public boolean o(CoordinatorLayout coordinatorLayout, V v, View view, float f, float f2) {
            return false;
        }

        @Deprecated
        public void p(CoordinatorLayout coordinatorLayout, V v, View view, int i, int i2, int[] iArr) {
        }

        public void q(CoordinatorLayout coordinatorLayout, V v, View view, int i, int i2, int[] iArr, int i3) {
            if (i3 == 0) {
                p(coordinatorLayout, v, view, i, i2, iArr);
            }
        }

        @Deprecated
        public void r(CoordinatorLayout coordinatorLayout, V v, View view, int i, int i2, int i3, int i4) {
        }

        public void s(CoordinatorLayout coordinatorLayout, V v, View view, int i, int i2, int i3, int i4, int i5) {
            if (i5 == 0) {
                r(coordinatorLayout, v, view, i, i2, i3, i4);
            }
        }

        @Deprecated
        public void t(CoordinatorLayout coordinatorLayout, V v, View view, View view2, int i) {
        }

        public void u(CoordinatorLayout coordinatorLayout, V v, View view, View view2, int i, int i2) {
            if (i2 == 0) {
                t(coordinatorLayout, v, view, view2, i);
            }
        }

        public boolean v(CoordinatorLayout coordinatorLayout, V v, Rect rect, boolean z) {
            return false;
        }

        public void w(CoordinatorLayout coordinatorLayout, V v, Parcelable parcelable) {
        }

        public Parcelable x(CoordinatorLayout coordinatorLayout, V v) {
            return View.BaseSavedState.EMPTY_STATE;
        }

        @Deprecated
        public boolean y(CoordinatorLayout coordinatorLayout, V v, View view, View view2, int i) {
            return false;
        }

        public boolean z(CoordinatorLayout coordinatorLayout, V v, View view, View view2, int i, int i2) {
            if (i2 == 0) {
                return y(coordinatorLayout, v, view, view2, i);
            }
            return false;
        }
    }

    @Retention(RetentionPolicy.RUNTIME)
    @Deprecated
    /* loaded from: classes.dex */
    public @interface d {
        Class<? extends c> value();
    }

    /* loaded from: classes.dex */
    private class e implements ViewGroup.OnHierarchyChangeListener {
        e() {
        }

        @Override // android.view.ViewGroup.OnHierarchyChangeListener
        public void onChildViewAdded(View view, View view2) {
            ViewGroup.OnHierarchyChangeListener onHierarchyChangeListener = CoordinatorLayout.this.r;
            if (onHierarchyChangeListener != null) {
                onHierarchyChangeListener.onChildViewAdded(view, view2);
            }
        }

        @Override // android.view.ViewGroup.OnHierarchyChangeListener
        public void onChildViewRemoved(View view, View view2) {
            CoordinatorLayout.this.G(2);
            ViewGroup.OnHierarchyChangeListener onHierarchyChangeListener = CoordinatorLayout.this.r;
            if (onHierarchyChangeListener != null) {
                onHierarchyChangeListener.onChildViewRemoved(view, view2);
            }
        }
    }

    /* loaded from: classes.dex */
    public static class f extends ViewGroup.MarginLayoutParams {

        /* renamed from: a  reason: collision with root package name */
        c f819a;

        /* renamed from: b  reason: collision with root package name */
        boolean f820b;

        /* renamed from: c  reason: collision with root package name */
        public int f821c;

        /* renamed from: d  reason: collision with root package name */
        public int f822d;
        public int e;
        int f;
        public int g;
        public int h;
        int i;
        int j;
        View k;
        View l;
        private boolean m;
        private boolean n;
        private boolean o;
        private boolean p;
        final Rect q;

        public f(int i, int i2) {
            super(i, i2);
            this.f820b = false;
            this.f821c = 0;
            this.f822d = 0;
            this.e = -1;
            this.f = -1;
            this.g = 0;
            this.h = 0;
            this.q = new Rect();
        }

        f(Context context, AttributeSet attributeSet) {
            super(context, attributeSet);
            this.f820b = false;
            this.f821c = 0;
            this.f822d = 0;
            this.e = -1;
            this.f = -1;
            this.g = 0;
            this.h = 0;
            this.q = new Rect();
            TypedArray obtainStyledAttributes = context.obtainStyledAttributes(attributeSet, a.e.c.CoordinatorLayout_Layout);
            this.f821c = obtainStyledAttributes.getInteger(a.e.c.CoordinatorLayout_Layout_android_layout_gravity, 0);
            this.f = obtainStyledAttributes.getResourceId(a.e.c.CoordinatorLayout_Layout_layout_anchor, -1);
            this.f822d = obtainStyledAttributes.getInteger(a.e.c.CoordinatorLayout_Layout_layout_anchorGravity, 0);
            this.e = obtainStyledAttributes.getInteger(a.e.c.CoordinatorLayout_Layout_layout_keyline, -1);
            this.g = obtainStyledAttributes.getInt(a.e.c.CoordinatorLayout_Layout_layout_insetEdge, 0);
            this.h = obtainStyledAttributes.getInt(a.e.c.CoordinatorLayout_Layout_layout_dodgeInsetEdges, 0);
            int i = a.e.c.CoordinatorLayout_Layout_layout_behavior;
            boolean hasValue = obtainStyledAttributes.hasValue(i);
            this.f820b = hasValue;
            if (hasValue) {
                this.f819a = CoordinatorLayout.J(context, attributeSet, obtainStyledAttributes.getString(i));
            }
            obtainStyledAttributes.recycle();
            c cVar = this.f819a;
            if (cVar != null) {
                cVar.g(this);
            }
        }

        public f(ViewGroup.LayoutParams layoutParams) {
            super(layoutParams);
            this.f820b = false;
            this.f821c = 0;
            this.f822d = 0;
            this.e = -1;
            this.f = -1;
            this.g = 0;
            this.h = 0;
            this.q = new Rect();
        }

        public f(ViewGroup.MarginLayoutParams marginLayoutParams) {
            super(marginLayoutParams);
            this.f820b = false;
            this.f821c = 0;
            this.f822d = 0;
            this.e = -1;
            this.f = -1;
            this.g = 0;
            this.h = 0;
            this.q = new Rect();
        }

        public f(f fVar) {
            super((ViewGroup.MarginLayoutParams) fVar);
            this.f820b = false;
            this.f821c = 0;
            this.f822d = 0;
            this.e = -1;
            this.f = -1;
            this.g = 0;
            this.h = 0;
            this.q = new Rect();
        }

        private void n(View view, CoordinatorLayout coordinatorLayout) {
            View findViewById = coordinatorLayout.findViewById(this.f);
            this.k = findViewById;
            if (findViewById != null) {
                if (findViewById != coordinatorLayout) {
                    for (ViewParent parent = findViewById.getParent(); parent != coordinatorLayout && parent != null; parent = parent.getParent()) {
                        if (parent != view) {
                            if (parent instanceof View) {
                                findViewById = (View) parent;
                            }
                        } else if (!coordinatorLayout.isInEditMode()) {
                            throw new IllegalStateException("Anchor must not be a descendant of the anchored view");
                        }
                    }
                    this.l = findViewById;
                    return;
                } else if (!coordinatorLayout.isInEditMode()) {
                    throw new IllegalStateException("View can not be anchored to the the parent CoordinatorLayout");
                }
            } else if (!coordinatorLayout.isInEditMode()) {
                throw new IllegalStateException("Could not find CoordinatorLayout descendant view with id " + coordinatorLayout.getResources().getResourceName(this.f) + " to anchor view " + view);
            }
            this.l = null;
            this.k = null;
        }

        private boolean s(View view, int i) {
            int b2 = a.f.l.c.b(((f) view.getLayoutParams()).g, i);
            return b2 != 0 && (a.f.l.c.b(this.h, i) & b2) == b2;
        }

        private boolean t(View view, CoordinatorLayout coordinatorLayout) {
            if (this.k.getId() != this.f) {
                return false;
            }
            View view2 = this.k;
            for (ViewParent parent = view2.getParent(); parent != coordinatorLayout; parent = parent.getParent()) {
                if (parent == null || parent == view) {
                    this.l = null;
                    this.k = null;
                    return false;
                }
                if (parent instanceof View) {
                    view2 = (View) parent;
                }
            }
            this.l = view2;
            return true;
        }

        boolean a() {
            return this.k == null && this.f != -1;
        }

        boolean b(CoordinatorLayout coordinatorLayout, View view, View view2) {
            c cVar;
            return view2 == this.l || s(view2, r.q(coordinatorLayout)) || ((cVar = this.f819a) != null && cVar.e(coordinatorLayout, view, view2));
        }

        boolean c() {
            if (this.f819a == null) {
                this.m = false;
            }
            return this.m;
        }

        View d(CoordinatorLayout coordinatorLayout, View view) {
            if (this.f == -1) {
                this.l = null;
                this.k = null;
                return null;
            }
            if (this.k == null || !t(view, coordinatorLayout)) {
                n(view, coordinatorLayout);
            }
            return this.k;
        }

        public int e() {
            return this.f;
        }

        public c f() {
            return this.f819a;
        }

        boolean g() {
            return this.p;
        }

        Rect h() {
            return this.q;
        }

        boolean i(CoordinatorLayout coordinatorLayout, View view) {
            boolean z = this.m;
            if (z) {
                return true;
            }
            c cVar = this.f819a;
            boolean a2 = (cVar != null ? cVar.a(coordinatorLayout, view) : false) | z;
            this.m = a2;
            return a2;
        }

        boolean j(int i) {
            if (i != 0) {
                if (i != 1) {
                    return false;
                }
                return this.o;
            }
            return this.n;
        }

        void k() {
            this.p = false;
        }

        void l(int i) {
            r(i, false);
        }

        void m() {
            this.m = false;
        }

        public void o(c cVar) {
            c cVar2 = this.f819a;
            if (cVar2 != cVar) {
                if (cVar2 != null) {
                    cVar2.j();
                }
                this.f819a = cVar;
                this.f820b = true;
                if (cVar != null) {
                    cVar.g(this);
                }
            }
        }

        void p(boolean z) {
            this.p = z;
        }

        void q(Rect rect) {
            this.q.set(rect);
        }

        void r(int i, boolean z) {
            if (i == 0) {
                this.n = z;
            } else if (i != 1) {
            } else {
                this.o = z;
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class g implements ViewTreeObserver.OnPreDrawListener {
        g() {
        }

        @Override // android.view.ViewTreeObserver.OnPreDrawListener
        public boolean onPreDraw() {
            CoordinatorLayout.this.G(0);
            return true;
        }
    }

    /* loaded from: classes.dex */
    static class h implements Comparator<View> {
        h() {
        }

        @Override // java.util.Comparator
        /* renamed from: a */
        public int compare(View view, View view2) {
            float y = r.y(view);
            float y2 = r.y(view2);
            if (y > y2) {
                return -1;
            }
            return y < y2 ? 1 : 0;
        }
    }

    static {
        Package r0 = CoordinatorLayout.class.getPackage();
        u = r0 != null ? r0.getName() : null;
        if (Build.VERSION.SDK_INT >= 21) {
            x = new h();
        } else {
            x = null;
        }
        v = new Class[]{Context.class, AttributeSet.class};
        w = new ThreadLocal<>();
        y = new a.f.k.f(12);
    }

    public CoordinatorLayout(Context context, AttributeSet attributeSet) {
        this(context, attributeSet, a.e.a.coordinatorLayoutStyle);
    }

    public CoordinatorLayout(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.f813b = new ArrayList();
        this.f814c = new androidx.coordinatorlayout.widget.a<>();
        this.f815d = new ArrayList();
        this.e = new ArrayList();
        this.f = new int[2];
        this.t = new n(this);
        TypedArray obtainStyledAttributes = i == 0 ? context.obtainStyledAttributes(attributeSet, a.e.c.CoordinatorLayout, 0, a.e.b.Widget_Support_CoordinatorLayout) : context.obtainStyledAttributes(attributeSet, a.e.c.CoordinatorLayout, i, 0);
        int resourceId = obtainStyledAttributes.getResourceId(a.e.c.CoordinatorLayout_keylines, 0);
        if (resourceId != 0) {
            Resources resources = context.getResources();
            this.j = resources.getIntArray(resourceId);
            float f2 = resources.getDisplayMetrics().density;
            int length = this.j.length;
            for (int i2 = 0; i2 < length; i2++) {
                int[] iArr = this.j;
                iArr[i2] = (int) (iArr[i2] * f2);
            }
        }
        this.q = obtainStyledAttributes.getDrawable(a.e.c.CoordinatorLayout_statusBarBackground);
        obtainStyledAttributes.recycle();
        W();
        super.setOnHierarchyChangeListener(new e());
    }

    private void B(View view, int i) {
        f fVar = (f) view.getLayoutParams();
        Rect a2 = a();
        a2.set(getPaddingLeft() + ((ViewGroup.MarginLayoutParams) fVar).leftMargin, getPaddingTop() + ((ViewGroup.MarginLayoutParams) fVar).topMargin, (getWidth() - getPaddingRight()) - ((ViewGroup.MarginLayoutParams) fVar).rightMargin, (getHeight() - getPaddingBottom()) - ((ViewGroup.MarginLayoutParams) fVar).bottomMargin);
        if (this.o != null && r.n(this) && !r.n(view)) {
            a2.left += this.o.b();
            a2.top += this.o.d();
            a2.right -= this.o.c();
            a2.bottom -= this.o.a();
        }
        Rect a3 = a();
        a.f.l.c.a(R(fVar.f821c), view.getMeasuredWidth(), view.getMeasuredHeight(), a2, a3, i);
        view.layout(a3.left, a3.top, a3.right, a3.bottom);
        N(a2);
        N(a3);
    }

    private void C(View view, View view2, int i) {
        Rect a2 = a();
        Rect a3 = a();
        try {
            s(view2, a2);
            t(view, i, a2, a3);
            view.layout(a3.left, a3.top, a3.right, a3.bottom);
        } finally {
            N(a2);
            N(a3);
        }
    }

    private void D(View view, int i, int i2) {
        f fVar = (f) view.getLayoutParams();
        int b2 = a.f.l.c.b(S(fVar.f821c), i2);
        int i3 = b2 & 7;
        int i4 = b2 & 112;
        int width = getWidth();
        int height = getHeight();
        int measuredWidth = view.getMeasuredWidth();
        int measuredHeight = view.getMeasuredHeight();
        if (i2 == 1) {
            i = width - i;
        }
        int v2 = v(i) - measuredWidth;
        int i5 = 0;
        if (i3 == 1) {
            v2 += measuredWidth / 2;
        } else if (i3 == 5) {
            v2 += measuredWidth;
        }
        if (i4 == 16) {
            i5 = 0 + (measuredHeight / 2);
        } else if (i4 == 80) {
            i5 = measuredHeight + 0;
        }
        int max = Math.max(getPaddingLeft() + ((ViewGroup.MarginLayoutParams) fVar).leftMargin, Math.min(v2, ((width - getPaddingRight()) - measuredWidth) - ((ViewGroup.MarginLayoutParams) fVar).rightMargin));
        int max2 = Math.max(getPaddingTop() + ((ViewGroup.MarginLayoutParams) fVar).topMargin, Math.min(i5, ((height - getPaddingBottom()) - measuredHeight) - ((ViewGroup.MarginLayoutParams) fVar).bottomMargin));
        view.layout(max, max2, measuredWidth + max, measuredHeight + max2);
    }

    private void E(View view, Rect rect, int i) {
        boolean z;
        boolean z2;
        int width;
        int i2;
        int i3;
        int i4;
        int height;
        int i5;
        int i6;
        int i7;
        if (r.E(view) && view.getWidth() > 0 && view.getHeight() > 0) {
            f fVar = (f) view.getLayoutParams();
            c f2 = fVar.f();
            Rect a2 = a();
            Rect a3 = a();
            a3.set(view.getLeft(), view.getTop(), view.getRight(), view.getBottom());
            if (f2 == null || !f2.b(this, view, a2)) {
                a2.set(a3);
            } else if (!a3.contains(a2)) {
                throw new IllegalArgumentException("Rect should be within the child's bounds. Rect:" + a2.toShortString() + " | Bounds:" + a3.toShortString());
            }
            N(a3);
            if (a2.isEmpty()) {
                N(a2);
                return;
            }
            int b2 = a.f.l.c.b(fVar.h, i);
            boolean z3 = true;
            if ((b2 & 48) != 48 || (i6 = (a2.top - ((ViewGroup.MarginLayoutParams) fVar).topMargin) - fVar.j) >= (i7 = rect.top)) {
                z = false;
            } else {
                U(view, i7 - i6);
                z = true;
            }
            if ((b2 & 80) == 80 && (height = ((getHeight() - a2.bottom) - ((ViewGroup.MarginLayoutParams) fVar).bottomMargin) + fVar.j) < (i5 = rect.bottom)) {
                U(view, height - i5);
                z = true;
            }
            if (!z) {
                U(view, 0);
            }
            if ((b2 & 3) != 3 || (i3 = (a2.left - ((ViewGroup.MarginLayoutParams) fVar).leftMargin) - fVar.i) >= (i4 = rect.left)) {
                z2 = false;
            } else {
                T(view, i4 - i3);
                z2 = true;
            }
            if ((b2 & 5) != 5 || (width = ((getWidth() - a2.right) - ((ViewGroup.MarginLayoutParams) fVar).rightMargin) + fVar.i) >= (i2 = rect.right)) {
                z3 = z2;
            } else {
                T(view, width - i2);
            }
            if (!z3) {
                T(view, 0);
            }
            N(a2);
        }
    }

    /* JADX WARN: Multi-variable type inference failed */
    static c J(Context context, AttributeSet attributeSet, String str) {
        if (TextUtils.isEmpty(str)) {
            return null;
        }
        if (str.startsWith(".")) {
            str = context.getPackageName() + str;
        } else if (str.indexOf(46) < 0) {
            String str2 = u;
            if (!TextUtils.isEmpty(str2)) {
                str = str2 + '.' + str;
            }
        }
        try {
            ThreadLocal<Map<String, Constructor<c>>> threadLocal = w;
            Map map = (Map) threadLocal.get();
            if (map == null) {
                map = new HashMap();
                threadLocal.set(map);
            }
            Constructor<?> constructor = (Constructor) map.get(str);
            if (constructor == null) {
                constructor = context.getClassLoader().loadClass(str).getConstructor(v);
                constructor.setAccessible(true);
                map.put(str, constructor);
            }
            return (c) constructor.newInstance(context, attributeSet);
        } catch (Exception e2) {
            throw new RuntimeException("Could not inflate Behavior subclass " + str, e2);
        }
    }

    private boolean K(MotionEvent motionEvent, int i) {
        int actionMasked = motionEvent.getActionMasked();
        List<View> list = this.f815d;
        y(list);
        int size = list.size();
        MotionEvent motionEvent2 = null;
        boolean z = false;
        boolean z2 = false;
        for (int i2 = 0; i2 < size; i2++) {
            View view = list.get(i2);
            f fVar = (f) view.getLayoutParams();
            c f2 = fVar.f();
            if (!(z || z2) || actionMasked == 0) {
                if (!z && f2 != null) {
                    if (i == 0) {
                        z = f2.k(this, view, motionEvent);
                    } else if (i == 1) {
                        z = f2.C(this, view, motionEvent);
                    }
                    if (z) {
                        this.k = view;
                    }
                }
                boolean c2 = fVar.c();
                boolean i3 = fVar.i(this, view);
                z2 = i3 && !c2;
                if (i3 && !z2) {
                    break;
                }
            } else if (f2 != null) {
                if (motionEvent2 == null) {
                    long uptimeMillis = SystemClock.uptimeMillis();
                    motionEvent2 = MotionEvent.obtain(uptimeMillis, uptimeMillis, 3, 0.0f, 0.0f, 0);
                }
                if (i == 0) {
                    f2.k(this, view, motionEvent2);
                } else if (i == 1) {
                    f2.C(this, view, motionEvent2);
                }
            }
        }
        list.clear();
        return z;
    }

    private void L() {
        this.f813b.clear();
        this.f814c.c();
        int childCount = getChildCount();
        for (int i = 0; i < childCount; i++) {
            View childAt = getChildAt(i);
            f x2 = x(childAt);
            x2.d(this, childAt);
            this.f814c.b(childAt);
            for (int i2 = 0; i2 < childCount; i2++) {
                if (i2 != i) {
                    View childAt2 = getChildAt(i2);
                    if (x2.b(this, childAt, childAt2)) {
                        if (!this.f814c.d(childAt2)) {
                            this.f814c.b(childAt2);
                        }
                        this.f814c.a(childAt2, childAt);
                    }
                }
            }
        }
        this.f813b.addAll(this.f814c.i());
        Collections.reverse(this.f813b);
    }

    private static void N(Rect rect) {
        rect.setEmpty();
        y.a(rect);
    }

    private void P(boolean z) {
        int childCount = getChildCount();
        for (int i = 0; i < childCount; i++) {
            View childAt = getChildAt(i);
            c f2 = ((f) childAt.getLayoutParams()).f();
            if (f2 != null) {
                long uptimeMillis = SystemClock.uptimeMillis();
                MotionEvent obtain = MotionEvent.obtain(uptimeMillis, uptimeMillis, 3, 0.0f, 0.0f, 0);
                if (z) {
                    f2.k(this, childAt, obtain);
                } else {
                    f2.C(this, childAt, obtain);
                }
                obtain.recycle();
            }
        }
        for (int i2 = 0; i2 < childCount; i2++) {
            ((f) getChildAt(i2).getLayoutParams()).m();
        }
        this.k = null;
        this.h = false;
    }

    private static int Q(int i) {
        if (i == 0) {
            return 17;
        }
        return i;
    }

    private static int R(int i) {
        if ((i & 7) == 0) {
            i |= 8388611;
        }
        return (i & 112) == 0 ? i | 48 : i;
    }

    private static int S(int i) {
        if (i == 0) {
            return 8388661;
        }
        return i;
    }

    private void T(View view, int i) {
        f fVar = (f) view.getLayoutParams();
        int i2 = fVar.i;
        if (i2 != i) {
            r.H(view, i - i2);
            fVar.i = i;
        }
    }

    private void U(View view, int i) {
        f fVar = (f) view.getLayoutParams();
        int i2 = fVar.j;
        if (i2 != i) {
            r.I(view, i - i2);
            fVar.j = i;
        }
    }

    private void W() {
        if (Build.VERSION.SDK_INT < 21) {
            return;
        }
        if (!r.n(this)) {
            r.b0(this, null);
            return;
        }
        if (this.s == null) {
            this.s = new a();
        }
        r.b0(this, this.s);
        setSystemUiVisibility(1280);
    }

    private static Rect a() {
        Rect b2 = y.b();
        return b2 == null ? new Rect() : b2;
    }

    private static int c(int i, int i2, int i3) {
        return i < i2 ? i2 : i > i3 ? i3 : i;
    }

    private void d(f fVar, Rect rect, int i, int i2) {
        int width = getWidth();
        int height = getHeight();
        int max = Math.max(getPaddingLeft() + ((ViewGroup.MarginLayoutParams) fVar).leftMargin, Math.min(rect.left, ((width - getPaddingRight()) - i) - ((ViewGroup.MarginLayoutParams) fVar).rightMargin));
        int max2 = Math.max(getPaddingTop() + ((ViewGroup.MarginLayoutParams) fVar).topMargin, Math.min(rect.top, ((height - getPaddingBottom()) - i2) - ((ViewGroup.MarginLayoutParams) fVar).bottomMargin));
        rect.set(max, max2, i + max, i2 + max2);
    }

    private z e(z zVar) {
        c f2;
        if (zVar.e()) {
            return zVar;
        }
        int childCount = getChildCount();
        for (int i = 0; i < childCount; i++) {
            View childAt = getChildAt(i);
            if (r.n(childAt) && (f2 = ((f) childAt.getLayoutParams()).f()) != null) {
                zVar = f2.f(this, childAt, zVar);
                if (zVar.e()) {
                    break;
                }
            }
        }
        return zVar;
    }

    private void u(View view, int i, Rect rect, Rect rect2, f fVar, int i2, int i3) {
        int b2 = a.f.l.c.b(Q(fVar.f821c), i);
        int b3 = a.f.l.c.b(R(fVar.f822d), i);
        int i4 = b2 & 7;
        int i5 = b2 & 112;
        int i6 = b3 & 7;
        int i7 = b3 & 112;
        int width = i6 != 1 ? i6 != 5 ? rect.left : rect.right : rect.left + (rect.width() / 2);
        int height = i7 != 16 ? i7 != 80 ? rect.top : rect.bottom : rect.top + (rect.height() / 2);
        if (i4 == 1) {
            width -= i2 / 2;
        } else if (i4 != 5) {
            width -= i2;
        }
        if (i5 == 16) {
            height -= i3 / 2;
        } else if (i5 != 80) {
            height -= i3;
        }
        rect2.set(width, height, i2 + width, i3 + height);
    }

    private int v(int i) {
        StringBuilder sb;
        int[] iArr = this.j;
        if (iArr == null) {
            sb = new StringBuilder();
            sb.append("No keylines defined for ");
            sb.append(this);
            sb.append(" - attempted index lookup ");
            sb.append(i);
        } else if (i >= 0 && i < iArr.length) {
            return iArr[i];
        } else {
            sb = new StringBuilder();
            sb.append("Keyline index ");
            sb.append(i);
            sb.append(" out of range for ");
            sb.append(this);
        }
        Log.e("CoordinatorLayout", sb.toString());
        return 0;
    }

    private void y(List<View> list) {
        list.clear();
        boolean isChildrenDrawingOrderEnabled = isChildrenDrawingOrderEnabled();
        int childCount = getChildCount();
        for (int i = childCount - 1; i >= 0; i--) {
            list.add(getChildAt(isChildrenDrawingOrderEnabled ? getChildDrawingOrder(childCount, i) : i));
        }
        Comparator<View> comparator = x;
        if (comparator != null) {
            Collections.sort(list, comparator);
        }
    }

    private boolean z(View view) {
        return this.f814c.j(view);
    }

    public boolean A(View view, int i, int i2) {
        Rect a2 = a();
        s(view, a2);
        try {
            return a2.contains(i, i2);
        } finally {
            N(a2);
        }
    }

    void F(View view, int i) {
        c f2;
        f fVar = (f) view.getLayoutParams();
        if (fVar.k != null) {
            Rect a2 = a();
            Rect a3 = a();
            Rect a4 = a();
            s(fVar.k, a2);
            boolean z = false;
            p(view, false, a3);
            int measuredWidth = view.getMeasuredWidth();
            int measuredHeight = view.getMeasuredHeight();
            u(view, i, a2, a4, fVar, measuredWidth, measuredHeight);
            z = (a4.left == a3.left && a4.top == a3.top) ? true : true;
            d(fVar, a4, measuredWidth, measuredHeight);
            int i2 = a4.left - a3.left;
            int i3 = a4.top - a3.top;
            if (i2 != 0) {
                r.H(view, i2);
            }
            if (i3 != 0) {
                r.I(view, i3);
            }
            if (z && (f2 = fVar.f()) != null) {
                f2.h(this, view, fVar.k);
            }
            N(a2);
            N(a3);
            N(a4);
        }
    }

    final void G(int i) {
        boolean z;
        int q = r.q(this);
        int size = this.f813b.size();
        Rect a2 = a();
        Rect a3 = a();
        Rect a4 = a();
        for (int i2 = 0; i2 < size; i2++) {
            View view = this.f813b.get(i2);
            f fVar = (f) view.getLayoutParams();
            if (i != 0 || view.getVisibility() != 8) {
                for (int i3 = 0; i3 < i2; i3++) {
                    if (fVar.l == this.f813b.get(i3)) {
                        F(view, q);
                    }
                }
                p(view, true, a3);
                if (fVar.g != 0 && !a3.isEmpty()) {
                    int b2 = a.f.l.c.b(fVar.g, q);
                    int i4 = b2 & 112;
                    if (i4 == 48) {
                        a2.top = Math.max(a2.top, a3.bottom);
                    } else if (i4 == 80) {
                        a2.bottom = Math.max(a2.bottom, getHeight() - a3.top);
                    }
                    int i5 = b2 & 7;
                    if (i5 == 3) {
                        a2.left = Math.max(a2.left, a3.right);
                    } else if (i5 == 5) {
                        a2.right = Math.max(a2.right, getWidth() - a3.left);
                    }
                }
                if (fVar.h != 0 && view.getVisibility() == 0) {
                    E(view, a2, q);
                }
                if (i != 2) {
                    w(view, a4);
                    if (!a4.equals(a3)) {
                        M(view, a3);
                    }
                }
                for (int i6 = i2 + 1; i6 < size; i6++) {
                    View view2 = this.f813b.get(i6);
                    f fVar2 = (f) view2.getLayoutParams();
                    c f2 = fVar2.f();
                    if (f2 != null && f2.e(this, view2, view)) {
                        if (i == 0 && fVar2.g()) {
                            fVar2.k();
                        } else {
                            if (i != 2) {
                                z = f2.h(this, view2, view);
                            } else {
                                f2.i(this, view2, view);
                                z = true;
                            }
                            if (i == 1) {
                                fVar2.p(z);
                            }
                        }
                    }
                }
            }
        }
        N(a2);
        N(a3);
        N(a4);
    }

    public void H(View view, int i) {
        f fVar = (f) view.getLayoutParams();
        if (fVar.a()) {
            throw new IllegalStateException("An anchor may not be changed after CoordinatorLayout measurement begins before layout is complete.");
        }
        View view2 = fVar.k;
        if (view2 != null) {
            C(view, view2, i);
            return;
        }
        int i2 = fVar.e;
        if (i2 >= 0) {
            D(view, i2, i);
        } else {
            B(view, i);
        }
    }

    public void I(View view, int i, int i2, int i3, int i4) {
        measureChildWithMargins(view, i, i2, i3, i4);
    }

    void M(View view, Rect rect) {
        ((f) view.getLayoutParams()).q(rect);
    }

    void O() {
        if (this.i && this.m != null) {
            getViewTreeObserver().removeOnPreDrawListener(this.m);
        }
        this.n = false;
    }

    final z V(z zVar) {
        if (a.f.k.c.a(this.o, zVar)) {
            return zVar;
        }
        this.o = zVar;
        boolean z = true;
        boolean z2 = zVar != null && zVar.d() > 0;
        this.p = z2;
        if (z2 || getBackground() != null) {
            z = false;
        }
        setWillNotDraw(z);
        z e2 = e(zVar);
        requestLayout();
        return e2;
    }

    void b() {
        if (this.i) {
            if (this.m == null) {
                this.m = new g();
            }
            getViewTreeObserver().addOnPreDrawListener(this.m);
        }
        this.n = true;
    }

    @Override // android.view.ViewGroup
    protected boolean checkLayoutParams(ViewGroup.LayoutParams layoutParams) {
        return (layoutParams instanceof f) && super.checkLayoutParams(layoutParams);
    }

    @Override // android.view.ViewGroup
    protected boolean drawChild(Canvas canvas, View view, long j) {
        f fVar = (f) view.getLayoutParams();
        c cVar = fVar.f819a;
        if (cVar != null) {
            float d2 = cVar.d(this, view);
            if (d2 > 0.0f) {
                if (this.g == null) {
                    this.g = new Paint();
                }
                this.g.setColor(fVar.f819a.c(this, view));
                this.g.setAlpha(c(Math.round(d2 * 255.0f), 0, SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT));
                int save = canvas.save();
                if (view.isOpaque()) {
                    canvas.clipRect(view.getLeft(), view.getTop(), view.getRight(), view.getBottom(), Region.Op.DIFFERENCE);
                }
                canvas.drawRect(getPaddingLeft(), getPaddingTop(), getWidth() - getPaddingRight(), getHeight() - getPaddingBottom(), this.g);
                canvas.restoreToCount(save);
            }
        }
        return super.drawChild(canvas, view, j);
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void drawableStateChanged() {
        super.drawableStateChanged();
        int[] drawableState = getDrawableState();
        Drawable drawable = this.q;
        boolean z = false;
        if (drawable != null && drawable.isStateful()) {
            z = false | drawable.setState(drawableState);
        }
        if (z) {
            invalidate();
        }
    }

    public void f(View view) {
        List g2 = this.f814c.g(view);
        if (g2 == null || g2.isEmpty()) {
            return;
        }
        for (int i = 0; i < g2.size(); i++) {
            View view2 = (View) g2.get(i);
            c f2 = ((f) view2.getLayoutParams()).f();
            if (f2 != null) {
                f2.h(this, view2, view);
            }
        }
    }

    void g() {
        int childCount = getChildCount();
        boolean z = false;
        int i = 0;
        while (true) {
            if (i >= childCount) {
                break;
            } else if (z(getChildAt(i))) {
                z = true;
                break;
            } else {
                i++;
            }
        }
        if (z != this.n) {
            if (z) {
                b();
            } else {
                O();
            }
        }
    }

    final List<View> getDependencySortedChildren() {
        L();
        return Collections.unmodifiableList(this.f813b);
    }

    public final z getLastWindowInsets() {
        return this.o;
    }

    @Override // android.view.ViewGroup
    public int getNestedScrollAxes() {
        return this.t.a();
    }

    public Drawable getStatusBarBackground() {
        return this.q;
    }

    @Override // android.view.View
    protected int getSuggestedMinimumHeight() {
        return Math.max(super.getSuggestedMinimumHeight(), getPaddingTop() + getPaddingBottom());
    }

    @Override // android.view.View
    protected int getSuggestedMinimumWidth() {
        return Math.max(super.getSuggestedMinimumWidth(), getPaddingLeft() + getPaddingRight());
    }

    @Override // a.f.l.l
    public void h(View view, View view2, int i, int i2) {
        c f2;
        this.t.c(view, view2, i, i2);
        this.l = view2;
        int childCount = getChildCount();
        for (int i3 = 0; i3 < childCount; i3++) {
            View childAt = getChildAt(i3);
            f fVar = (f) childAt.getLayoutParams();
            if (fVar.j(i2) && (f2 = fVar.f()) != null) {
                f2.u(this, childAt, view, view2, i, i2);
            }
        }
    }

    @Override // a.f.l.l
    public void i(View view, int i) {
        this.t.d(view, i);
        int childCount = getChildCount();
        for (int i2 = 0; i2 < childCount; i2++) {
            View childAt = getChildAt(i2);
            f fVar = (f) childAt.getLayoutParams();
            if (fVar.j(i)) {
                c f2 = fVar.f();
                if (f2 != null) {
                    f2.B(this, childAt, view, i);
                }
                fVar.l(i);
                fVar.k();
            }
        }
        this.l = null;
    }

    @Override // a.f.l.l
    public void j(View view, int i, int i2, int[] iArr, int i3) {
        c f2;
        int childCount = getChildCount();
        boolean z = false;
        int i4 = 0;
        int i5 = 0;
        for (int i6 = 0; i6 < childCount; i6++) {
            View childAt = getChildAt(i6);
            if (childAt.getVisibility() != 8) {
                f fVar = (f) childAt.getLayoutParams();
                if (fVar.j(i3) && (f2 = fVar.f()) != null) {
                    int[] iArr2 = this.f;
                    iArr2[1] = 0;
                    iArr2[0] = 0;
                    f2.q(this, childAt, view, i, i2, iArr2, i3);
                    int[] iArr3 = this.f;
                    i4 = i > 0 ? Math.max(i4, iArr3[0]) : Math.min(i4, iArr3[0]);
                    int[] iArr4 = this.f;
                    i5 = i2 > 0 ? Math.max(i5, iArr4[1]) : Math.min(i5, iArr4[1]);
                    z = true;
                }
            }
        }
        iArr[0] = i4;
        iArr[1] = i5;
        if (z) {
            G(1);
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.view.ViewGroup
    /* renamed from: k */
    public f generateDefaultLayoutParams() {
        return new f(-2, -2);
    }

    @Override // android.view.ViewGroup
    /* renamed from: l */
    public f generateLayoutParams(AttributeSet attributeSet) {
        return new f(getContext(), attributeSet);
    }

    @Override // a.f.l.l
    public void m(View view, int i, int i2, int i3, int i4, int i5) {
        c f2;
        int childCount = getChildCount();
        boolean z = false;
        for (int i6 = 0; i6 < childCount; i6++) {
            View childAt = getChildAt(i6);
            if (childAt.getVisibility() != 8) {
                f fVar = (f) childAt.getLayoutParams();
                if (fVar.j(i5) && (f2 = fVar.f()) != null) {
                    f2.s(this, childAt, view, i, i2, i3, i4, i5);
                    z = true;
                }
            }
        }
        if (z) {
            G(1);
        }
    }

    @Override // a.f.l.l
    public boolean n(View view, View view2, int i, int i2) {
        int childCount = getChildCount();
        boolean z = false;
        for (int i3 = 0; i3 < childCount; i3++) {
            View childAt = getChildAt(i3);
            if (childAt.getVisibility() != 8) {
                f fVar = (f) childAt.getLayoutParams();
                c f2 = fVar.f();
                if (f2 != null) {
                    boolean z2 = f2.z(this, childAt, view, view2, i, i2);
                    z |= z2;
                    fVar.r(i2, z2);
                } else {
                    fVar.r(i2, false);
                }
            }
        }
        return z;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.view.ViewGroup
    /* renamed from: o */
    public f generateLayoutParams(ViewGroup.LayoutParams layoutParams) {
        return layoutParams instanceof f ? new f((f) layoutParams) : layoutParams instanceof ViewGroup.MarginLayoutParams ? new f((ViewGroup.MarginLayoutParams) layoutParams) : new f(layoutParams);
    }

    @Override // android.view.ViewGroup, android.view.View
    public void onAttachedToWindow() {
        super.onAttachedToWindow();
        P(false);
        if (this.n) {
            if (this.m == null) {
                this.m = new g();
            }
            getViewTreeObserver().addOnPreDrawListener(this.m);
        }
        if (this.o == null && r.n(this)) {
            r.N(this);
        }
        this.i = true;
    }

    @Override // android.view.ViewGroup, android.view.View
    public void onDetachedFromWindow() {
        super.onDetachedFromWindow();
        P(false);
        if (this.n && this.m != null) {
            getViewTreeObserver().removeOnPreDrawListener(this.m);
        }
        View view = this.l;
        if (view != null) {
            onStopNestedScroll(view);
        }
        this.i = false;
    }

    @Override // android.view.View
    public void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        if (!this.p || this.q == null) {
            return;
        }
        z zVar = this.o;
        int d2 = zVar != null ? zVar.d() : 0;
        if (d2 > 0) {
            this.q.setBounds(0, 0, getWidth(), d2);
            this.q.draw(canvas);
        }
    }

    @Override // android.view.ViewGroup
    public boolean onInterceptTouchEvent(MotionEvent motionEvent) {
        int actionMasked = motionEvent.getActionMasked();
        if (actionMasked == 0) {
            P(true);
        }
        boolean K = K(motionEvent, 0);
        if (actionMasked == 1 || actionMasked == 3) {
            P(true);
        }
        return K;
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void onLayout(boolean z, int i, int i2, int i3, int i4) {
        c f2;
        int q = r.q(this);
        int size = this.f813b.size();
        for (int i5 = 0; i5 < size; i5++) {
            View view = this.f813b.get(i5);
            if (view.getVisibility() != 8 && ((f2 = ((f) view.getLayoutParams()).f()) == null || !f2.l(this, view, q))) {
                H(view, q);
            }
        }
    }

    /* JADX WARN: Code restructure failed: missing block: B:43:0x011a, code lost:
        if (r0.m(r30, r20, r11, r21, r23, 0) == false) goto L33;
     */
    /* JADX WARN: Removed duplicated region for block: B:42:0x00fb  */
    /* JADX WARN: Removed duplicated region for block: B:45:0x011d  */
    @Override // android.view.View
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    protected void onMeasure(int r31, int r32) {
        /*
            Method dump skipped, instructions count: 391
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: androidx.coordinatorlayout.widget.CoordinatorLayout.onMeasure(int, int):void");
    }

    @Override // android.view.ViewGroup, android.view.ViewParent, a.f.l.m
    public boolean onNestedFling(View view, float f2, float f3, boolean z) {
        c f4;
        int childCount = getChildCount();
        boolean z2 = false;
        for (int i = 0; i < childCount; i++) {
            View childAt = getChildAt(i);
            if (childAt.getVisibility() != 8) {
                f fVar = (f) childAt.getLayoutParams();
                if (fVar.j(0) && (f4 = fVar.f()) != null) {
                    z2 |= f4.n(this, childAt, view, f2, f3, z);
                }
            }
        }
        if (z2) {
            G(1);
        }
        return z2;
    }

    @Override // android.view.ViewGroup, android.view.ViewParent, a.f.l.m
    public boolean onNestedPreFling(View view, float f2, float f3) {
        c f4;
        int childCount = getChildCount();
        boolean z = false;
        for (int i = 0; i < childCount; i++) {
            View childAt = getChildAt(i);
            if (childAt.getVisibility() != 8) {
                f fVar = (f) childAt.getLayoutParams();
                if (fVar.j(0) && (f4 = fVar.f()) != null) {
                    z |= f4.o(this, childAt, view, f2, f3);
                }
            }
        }
        return z;
    }

    @Override // android.view.ViewGroup, android.view.ViewParent, a.f.l.m
    public void onNestedPreScroll(View view, int i, int i2, int[] iArr) {
        j(view, i, i2, iArr, 0);
    }

    @Override // android.view.ViewGroup, android.view.ViewParent, a.f.l.m
    public void onNestedScroll(View view, int i, int i2, int i3, int i4) {
        m(view, i, i2, i3, i4, 0);
    }

    @Override // android.view.ViewGroup, android.view.ViewParent, a.f.l.m
    public void onNestedScrollAccepted(View view, View view2, int i) {
        h(view, view2, i, 0);
    }

    @Override // android.view.View
    protected void onRestoreInstanceState(Parcelable parcelable) {
        Parcelable parcelable2;
        if (!(parcelable instanceof SavedState)) {
            super.onRestoreInstanceState(parcelable);
            return;
        }
        SavedState savedState = (SavedState) parcelable;
        super.onRestoreInstanceState(savedState.a());
        SparseArray<Parcelable> sparseArray = savedState.f816d;
        int childCount = getChildCount();
        for (int i = 0; i < childCount; i++) {
            View childAt = getChildAt(i);
            int id = childAt.getId();
            c f2 = x(childAt).f();
            if (id != -1 && f2 != null && (parcelable2 = sparseArray.get(id)) != null) {
                f2.w(this, childAt, parcelable2);
            }
        }
    }

    @Override // android.view.View
    protected Parcelable onSaveInstanceState() {
        Parcelable x2;
        SavedState savedState = new SavedState(super.onSaveInstanceState());
        SparseArray<Parcelable> sparseArray = new SparseArray<>();
        int childCount = getChildCount();
        for (int i = 0; i < childCount; i++) {
            View childAt = getChildAt(i);
            int id = childAt.getId();
            c f2 = ((f) childAt.getLayoutParams()).f();
            if (id != -1 && f2 != null && (x2 = f2.x(this, childAt)) != null) {
                sparseArray.append(id, x2);
            }
        }
        savedState.f816d = sparseArray;
        return savedState;
    }

    @Override // android.view.ViewGroup, android.view.ViewParent, a.f.l.m
    public boolean onStartNestedScroll(View view, View view2, int i) {
        return n(view, view2, i, 0);
    }

    @Override // android.view.ViewGroup, android.view.ViewParent, a.f.l.m
    public void onStopNestedScroll(View view) {
        i(view, 0);
    }

    /* JADX WARN: Code restructure failed: missing block: B:5:0x0012, code lost:
        if (r3 != false) goto L19;
     */
    /* JADX WARN: Removed duplicated region for block: B:14:0x0031  */
    /* JADX WARN: Removed duplicated region for block: B:15:0x0037  */
    /* JADX WARN: Removed duplicated region for block: B:18:0x004c  */
    @Override // android.view.View
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public boolean onTouchEvent(android.view.MotionEvent r18) {
        /*
            r17 = this;
            r0 = r17
            r1 = r18
            int r2 = r18.getActionMasked()
            android.view.View r3 = r0.k
            r4 = 1
            r5 = 0
            if (r3 != 0) goto L15
            boolean r3 = r0.K(r1, r4)
            if (r3 == 0) goto L2b
            goto L16
        L15:
            r3 = r5
        L16:
            android.view.View r6 = r0.k
            android.view.ViewGroup$LayoutParams r6 = r6.getLayoutParams()
            androidx.coordinatorlayout.widget.CoordinatorLayout$f r6 = (androidx.coordinatorlayout.widget.CoordinatorLayout.f) r6
            androidx.coordinatorlayout.widget.CoordinatorLayout$c r6 = r6.f()
            if (r6 == 0) goto L2b
            android.view.View r7 = r0.k
            boolean r6 = r6.C(r0, r7, r1)
            goto L2c
        L2b:
            r6 = r5
        L2c:
            android.view.View r7 = r0.k
            r8 = 0
            if (r7 != 0) goto L37
            boolean r1 = super.onTouchEvent(r18)
            r6 = r6 | r1
            goto L4a
        L37:
            if (r3 == 0) goto L4a
            long r11 = android.os.SystemClock.uptimeMillis()
            r13 = 3
            r14 = 0
            r15 = 0
            r16 = 0
            r9 = r11
            android.view.MotionEvent r8 = android.view.MotionEvent.obtain(r9, r11, r13, r14, r15, r16)
            super.onTouchEvent(r8)
        L4a:
            if (r8 == 0) goto L4f
            r8.recycle()
        L4f:
            if (r2 == r4) goto L54
            r1 = 3
            if (r2 != r1) goto L57
        L54:
            r0.P(r5)
        L57:
            return r6
        */
        throw new UnsupportedOperationException("Method not decompiled: androidx.coordinatorlayout.widget.CoordinatorLayout.onTouchEvent(android.view.MotionEvent):boolean");
    }

    void p(View view, boolean z, Rect rect) {
        if (view.isLayoutRequested() || view.getVisibility() == 8) {
            rect.setEmpty();
        } else if (z) {
            s(view, rect);
        } else {
            rect.set(view.getLeft(), view.getTop(), view.getRight(), view.getBottom());
        }
    }

    public List<View> q(View view) {
        List<View> h2 = this.f814c.h(view);
        this.e.clear();
        if (h2 != null) {
            this.e.addAll(h2);
        }
        return this.e;
    }

    public List<View> r(View view) {
        List g2 = this.f814c.g(view);
        this.e.clear();
        if (g2 != null) {
            this.e.addAll(g2);
        }
        return this.e;
    }

    @Override // android.view.ViewGroup, android.view.ViewParent
    public boolean requestChildRectangleOnScreen(View view, Rect rect, boolean z) {
        c f2 = ((f) view.getLayoutParams()).f();
        if (f2 == null || !f2.v(this, view, rect, z)) {
            return super.requestChildRectangleOnScreen(view, rect, z);
        }
        return true;
    }

    @Override // android.view.ViewGroup, android.view.ViewParent
    public void requestDisallowInterceptTouchEvent(boolean z) {
        super.requestDisallowInterceptTouchEvent(z);
        if (!z || this.h) {
            return;
        }
        P(false);
        this.h = true;
    }

    void s(View view, Rect rect) {
        androidx.coordinatorlayout.widget.b.a(this, view, rect);
    }

    @Override // android.view.View
    public void setFitsSystemWindows(boolean z) {
        super.setFitsSystemWindows(z);
        W();
    }

    @Override // android.view.ViewGroup
    public void setOnHierarchyChangeListener(ViewGroup.OnHierarchyChangeListener onHierarchyChangeListener) {
        this.r = onHierarchyChangeListener;
    }

    public void setStatusBarBackground(Drawable drawable) {
        Drawable drawable2 = this.q;
        if (drawable2 != drawable) {
            if (drawable2 != null) {
                drawable2.setCallback(null);
            }
            Drawable mutate = drawable != null ? drawable.mutate() : null;
            this.q = mutate;
            if (mutate != null) {
                if (mutate.isStateful()) {
                    this.q.setState(getDrawableState());
                }
                androidx.core.graphics.drawable.a.m(this.q, r.q(this));
                this.q.setVisible(getVisibility() == 0, false);
                this.q.setCallback(this);
            }
            r.K(this);
        }
    }

    public void setStatusBarBackgroundColor(int i) {
        setStatusBarBackground(new ColorDrawable(i));
    }

    public void setStatusBarBackgroundResource(int i) {
        setStatusBarBackground(i != 0 ? androidx.core.content.a.d(getContext(), i) : null);
    }

    @Override // android.view.View
    public void setVisibility(int i) {
        super.setVisibility(i);
        boolean z = i == 0;
        Drawable drawable = this.q;
        if (drawable == null || drawable.isVisible() == z) {
            return;
        }
        this.q.setVisible(z, false);
    }

    void t(View view, int i, Rect rect, Rect rect2) {
        f fVar = (f) view.getLayoutParams();
        int measuredWidth = view.getMeasuredWidth();
        int measuredHeight = view.getMeasuredHeight();
        u(view, i, rect, rect2, fVar, measuredWidth, measuredHeight);
        d(fVar, rect2, measuredWidth, measuredHeight);
    }

    @Override // android.view.View
    protected boolean verifyDrawable(Drawable drawable) {
        return super.verifyDrawable(drawable) || drawable == this.q;
    }

    void w(View view, Rect rect) {
        rect.set(((f) view.getLayoutParams()).h());
    }

    f x(View view) {
        f fVar = (f) view.getLayoutParams();
        if (!fVar.f820b) {
            if (view instanceof b) {
                c behavior = ((b) view).getBehavior();
                if (behavior == null) {
                    Log.e("CoordinatorLayout", "Attached behavior class is null");
                }
                fVar.o(behavior);
            } else {
                d dVar = null;
                for (Class<?> cls = view.getClass(); cls != null; cls = cls.getSuperclass()) {
                    dVar = (d) cls.getAnnotation(d.class);
                    if (dVar != null) {
                        break;
                    }
                }
                if (dVar != null) {
                    try {
                        fVar.o(dVar.value().getDeclaredConstructor(new Class[0]).newInstance(new Object[0]));
                    } catch (Exception e2) {
                        Log.e("CoordinatorLayout", "Default behavior class " + dVar.value().getName() + " could not be instantiated. Did you forget a default constructor?", e2);
                    }
                }
            }
            fVar.f820b = true;
        }
        return fVar;
    }
}
