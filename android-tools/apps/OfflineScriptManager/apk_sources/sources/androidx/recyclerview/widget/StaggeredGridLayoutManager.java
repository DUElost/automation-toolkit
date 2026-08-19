package androidx.recyclerview.widget;

import a.f.l.a0.c;
import android.content.Context;
import android.graphics.Rect;
import android.os.Parcel;
import android.os.Parcelable;
import android.util.AttributeSet;
import android.view.View;
import android.view.ViewGroup;
import android.view.accessibility.AccessibilityEvent;
import androidx.recyclerview.widget.RecyclerView;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.BitSet;
import java.util.List;
/* loaded from: classes.dex */
public class StaggeredGridLayoutManager extends RecyclerView.o {
    private BitSet B;
    private boolean G;
    private boolean H;
    private SavedState I;
    private int J;
    private int[] O;
    d[] t;
    i u;
    i v;
    private int w;
    private int x;
    private final g y;
    private int s = -1;
    boolean z = false;
    boolean A = false;
    int C = -1;
    int D = Integer.MIN_VALUE;
    LazySpanLookup E = new LazySpanLookup();
    private int F = 2;
    private final Rect K = new Rect();
    private final b L = new b();
    private boolean M = false;
    private boolean N = true;
    private final Runnable P = new a();

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class LazySpanLookup {

        /* renamed from: a  reason: collision with root package name */
        int[] f1167a;

        /* renamed from: b  reason: collision with root package name */
        List<FullSpanItem> f1168b;

        /* JADX INFO: Access modifiers changed from: package-private */
        /* loaded from: classes.dex */
        public static class FullSpanItem implements Parcelable {
            public static final Parcelable.Creator<FullSpanItem> CREATOR = new a();

            /* renamed from: b  reason: collision with root package name */
            int f1169b;

            /* renamed from: c  reason: collision with root package name */
            int f1170c;

            /* renamed from: d  reason: collision with root package name */
            int[] f1171d;
            boolean e;

            /* loaded from: classes.dex */
            static class a implements Parcelable.Creator<FullSpanItem> {
                a() {
                }

                @Override // android.os.Parcelable.Creator
                /* renamed from: a */
                public FullSpanItem createFromParcel(Parcel parcel) {
                    return new FullSpanItem(parcel);
                }

                @Override // android.os.Parcelable.Creator
                /* renamed from: b */
                public FullSpanItem[] newArray(int i) {
                    return new FullSpanItem[i];
                }
            }

            FullSpanItem() {
            }

            FullSpanItem(Parcel parcel) {
                this.f1169b = parcel.readInt();
                this.f1170c = parcel.readInt();
                this.e = parcel.readInt() == 1;
                int readInt = parcel.readInt();
                if (readInt > 0) {
                    int[] iArr = new int[readInt];
                    this.f1171d = iArr;
                    parcel.readIntArray(iArr);
                }
            }

            int a(int i) {
                int[] iArr = this.f1171d;
                if (iArr == null) {
                    return 0;
                }
                return iArr[i];
            }

            @Override // android.os.Parcelable
            public int describeContents() {
                return 0;
            }

            public String toString() {
                return "FullSpanItem{mPosition=" + this.f1169b + ", mGapDir=" + this.f1170c + ", mHasUnwantedGapAfter=" + this.e + ", mGapPerSpan=" + Arrays.toString(this.f1171d) + '}';
            }

            @Override // android.os.Parcelable
            public void writeToParcel(Parcel parcel, int i) {
                parcel.writeInt(this.f1169b);
                parcel.writeInt(this.f1170c);
                parcel.writeInt(this.e ? 1 : 0);
                int[] iArr = this.f1171d;
                if (iArr == null || iArr.length <= 0) {
                    parcel.writeInt(0);
                    return;
                }
                parcel.writeInt(iArr.length);
                parcel.writeIntArray(this.f1171d);
            }
        }

        LazySpanLookup() {
        }

        private int i(int i) {
            if (this.f1168b == null) {
                return -1;
            }
            FullSpanItem f = f(i);
            if (f != null) {
                this.f1168b.remove(f);
            }
            int size = this.f1168b.size();
            int i2 = 0;
            while (true) {
                if (i2 >= size) {
                    i2 = -1;
                    break;
                } else if (this.f1168b.get(i2).f1169b >= i) {
                    break;
                } else {
                    i2++;
                }
            }
            if (i2 != -1) {
                this.f1168b.remove(i2);
                return this.f1168b.get(i2).f1169b;
            }
            return -1;
        }

        private void l(int i, int i2) {
            List<FullSpanItem> list = this.f1168b;
            if (list == null) {
                return;
            }
            for (int size = list.size() - 1; size >= 0; size--) {
                FullSpanItem fullSpanItem = this.f1168b.get(size);
                int i3 = fullSpanItem.f1169b;
                if (i3 >= i) {
                    fullSpanItem.f1169b = i3 + i2;
                }
            }
        }

        private void m(int i, int i2) {
            List<FullSpanItem> list = this.f1168b;
            if (list == null) {
                return;
            }
            int i3 = i + i2;
            for (int size = list.size() - 1; size >= 0; size--) {
                FullSpanItem fullSpanItem = this.f1168b.get(size);
                int i4 = fullSpanItem.f1169b;
                if (i4 >= i) {
                    if (i4 < i3) {
                        this.f1168b.remove(size);
                    } else {
                        fullSpanItem.f1169b = i4 - i2;
                    }
                }
            }
        }

        public void a(FullSpanItem fullSpanItem) {
            if (this.f1168b == null) {
                this.f1168b = new ArrayList();
            }
            int size = this.f1168b.size();
            for (int i = 0; i < size; i++) {
                FullSpanItem fullSpanItem2 = this.f1168b.get(i);
                if (fullSpanItem2.f1169b == fullSpanItem.f1169b) {
                    this.f1168b.remove(i);
                }
                if (fullSpanItem2.f1169b >= fullSpanItem.f1169b) {
                    this.f1168b.add(i, fullSpanItem);
                    return;
                }
            }
            this.f1168b.add(fullSpanItem);
        }

        void b() {
            int[] iArr = this.f1167a;
            if (iArr != null) {
                Arrays.fill(iArr, -1);
            }
            this.f1168b = null;
        }

        void c(int i) {
            int[] iArr = this.f1167a;
            if (iArr == null) {
                int[] iArr2 = new int[Math.max(i, 10) + 1];
                this.f1167a = iArr2;
                Arrays.fill(iArr2, -1);
            } else if (i >= iArr.length) {
                int[] iArr3 = new int[o(i)];
                this.f1167a = iArr3;
                System.arraycopy(iArr, 0, iArr3, 0, iArr.length);
                int[] iArr4 = this.f1167a;
                Arrays.fill(iArr4, iArr.length, iArr4.length, -1);
            }
        }

        int d(int i) {
            List<FullSpanItem> list = this.f1168b;
            if (list != null) {
                for (int size = list.size() - 1; size >= 0; size--) {
                    if (this.f1168b.get(size).f1169b >= i) {
                        this.f1168b.remove(size);
                    }
                }
            }
            return h(i);
        }

        public FullSpanItem e(int i, int i2, int i3, boolean z) {
            List<FullSpanItem> list = this.f1168b;
            if (list == null) {
                return null;
            }
            int size = list.size();
            for (int i4 = 0; i4 < size; i4++) {
                FullSpanItem fullSpanItem = this.f1168b.get(i4);
                int i5 = fullSpanItem.f1169b;
                if (i5 >= i2) {
                    return null;
                }
                if (i5 >= i && (i3 == 0 || fullSpanItem.f1170c == i3 || (z && fullSpanItem.e))) {
                    return fullSpanItem;
                }
            }
            return null;
        }

        public FullSpanItem f(int i) {
            List<FullSpanItem> list = this.f1168b;
            if (list == null) {
                return null;
            }
            for (int size = list.size() - 1; size >= 0; size--) {
                FullSpanItem fullSpanItem = this.f1168b.get(size);
                if (fullSpanItem.f1169b == i) {
                    return fullSpanItem;
                }
            }
            return null;
        }

        int g(int i) {
            int[] iArr = this.f1167a;
            if (iArr == null || i >= iArr.length) {
                return -1;
            }
            return iArr[i];
        }

        int h(int i) {
            int[] iArr = this.f1167a;
            if (iArr != null && i < iArr.length) {
                int i2 = i(i);
                if (i2 == -1) {
                    int[] iArr2 = this.f1167a;
                    Arrays.fill(iArr2, i, iArr2.length, -1);
                    return this.f1167a.length;
                }
                int i3 = i2 + 1;
                Arrays.fill(this.f1167a, i, i3, -1);
                return i3;
            }
            return -1;
        }

        void j(int i, int i2) {
            int[] iArr = this.f1167a;
            if (iArr == null || i >= iArr.length) {
                return;
            }
            int i3 = i + i2;
            c(i3);
            int[] iArr2 = this.f1167a;
            System.arraycopy(iArr2, i, iArr2, i3, (iArr2.length - i) - i2);
            Arrays.fill(this.f1167a, i, i3, -1);
            l(i, i2);
        }

        void k(int i, int i2) {
            int[] iArr = this.f1167a;
            if (iArr == null || i >= iArr.length) {
                return;
            }
            int i3 = i + i2;
            c(i3);
            int[] iArr2 = this.f1167a;
            System.arraycopy(iArr2, i3, iArr2, i, (iArr2.length - i) - i2);
            int[] iArr3 = this.f1167a;
            Arrays.fill(iArr3, iArr3.length - i2, iArr3.length, -1);
            m(i, i2);
        }

        void n(int i, d dVar) {
            c(i);
            this.f1167a[i] = dVar.e;
        }

        int o(int i) {
            int length = this.f1167a.length;
            while (length <= i) {
                length *= 2;
            }
            return length;
        }
    }

    /* loaded from: classes.dex */
    public static class SavedState implements Parcelable {
        public static final Parcelable.Creator<SavedState> CREATOR = new a();

        /* renamed from: b  reason: collision with root package name */
        int f1172b;

        /* renamed from: c  reason: collision with root package name */
        int f1173c;

        /* renamed from: d  reason: collision with root package name */
        int f1174d;
        int[] e;
        int f;
        int[] g;
        List<LazySpanLookup.FullSpanItem> h;
        boolean i;
        boolean j;
        boolean k;

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

        public SavedState() {
        }

        SavedState(Parcel parcel) {
            this.f1172b = parcel.readInt();
            this.f1173c = parcel.readInt();
            int readInt = parcel.readInt();
            this.f1174d = readInt;
            if (readInt > 0) {
                int[] iArr = new int[readInt];
                this.e = iArr;
                parcel.readIntArray(iArr);
            }
            int readInt2 = parcel.readInt();
            this.f = readInt2;
            if (readInt2 > 0) {
                int[] iArr2 = new int[readInt2];
                this.g = iArr2;
                parcel.readIntArray(iArr2);
            }
            this.i = parcel.readInt() == 1;
            this.j = parcel.readInt() == 1;
            this.k = parcel.readInt() == 1;
            this.h = parcel.readArrayList(LazySpanLookup.FullSpanItem.class.getClassLoader());
        }

        public SavedState(SavedState savedState) {
            this.f1174d = savedState.f1174d;
            this.f1172b = savedState.f1172b;
            this.f1173c = savedState.f1173c;
            this.e = savedState.e;
            this.f = savedState.f;
            this.g = savedState.g;
            this.i = savedState.i;
            this.j = savedState.j;
            this.k = savedState.k;
            this.h = savedState.h;
        }

        void a() {
            this.e = null;
            this.f1174d = 0;
            this.f1172b = -1;
            this.f1173c = -1;
        }

        void b() {
            this.e = null;
            this.f1174d = 0;
            this.f = 0;
            this.g = null;
            this.h = null;
        }

        @Override // android.os.Parcelable
        public int describeContents() {
            return 0;
        }

        @Override // android.os.Parcelable
        public void writeToParcel(Parcel parcel, int i) {
            parcel.writeInt(this.f1172b);
            parcel.writeInt(this.f1173c);
            parcel.writeInt(this.f1174d);
            if (this.f1174d > 0) {
                parcel.writeIntArray(this.e);
            }
            parcel.writeInt(this.f);
            if (this.f > 0) {
                parcel.writeIntArray(this.g);
            }
            parcel.writeInt(this.i ? 1 : 0);
            parcel.writeInt(this.j ? 1 : 0);
            parcel.writeInt(this.k ? 1 : 0);
            parcel.writeList(this.h);
        }
    }

    /* loaded from: classes.dex */
    class a implements Runnable {
        a() {
        }

        @Override // java.lang.Runnable
        public void run() {
            StaggeredGridLayoutManager.this.N1();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b {

        /* renamed from: a  reason: collision with root package name */
        int f1176a;

        /* renamed from: b  reason: collision with root package name */
        int f1177b;

        /* renamed from: c  reason: collision with root package name */
        boolean f1178c;

        /* renamed from: d  reason: collision with root package name */
        boolean f1179d;
        boolean e;
        int[] f;

        b() {
            c();
        }

        void a() {
            this.f1177b = this.f1178c ? StaggeredGridLayoutManager.this.u.i() : StaggeredGridLayoutManager.this.u.m();
        }

        void b(int i) {
            this.f1177b = this.f1178c ? StaggeredGridLayoutManager.this.u.i() - i : StaggeredGridLayoutManager.this.u.m() + i;
        }

        void c() {
            this.f1176a = -1;
            this.f1177b = Integer.MIN_VALUE;
            this.f1178c = false;
            this.f1179d = false;
            this.e = false;
            int[] iArr = this.f;
            if (iArr != null) {
                Arrays.fill(iArr, -1);
            }
        }

        void d(d[] dVarArr) {
            int length = dVarArr.length;
            int[] iArr = this.f;
            if (iArr == null || iArr.length < length) {
                this.f = new int[StaggeredGridLayoutManager.this.t.length];
            }
            for (int i = 0; i < length; i++) {
                this.f[i] = dVarArr[i].p(Integer.MIN_VALUE);
            }
        }
    }

    /* loaded from: classes.dex */
    public static class c extends RecyclerView.p {
        d e;
        boolean f;

        public c(int i, int i2) {
            super(i, i2);
        }

        public c(Context context, AttributeSet attributeSet) {
            super(context, attributeSet);
        }

        public c(ViewGroup.LayoutParams layoutParams) {
            super(layoutParams);
        }

        public c(ViewGroup.MarginLayoutParams marginLayoutParams) {
            super(marginLayoutParams);
        }

        public final int e() {
            d dVar = this.e;
            if (dVar == null) {
                return -1;
            }
            return dVar.e;
        }

        public boolean f() {
            return this.f;
        }

        public void g(boolean z) {
            this.f = z;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class d {

        /* renamed from: a  reason: collision with root package name */
        ArrayList<View> f1180a = new ArrayList<>();

        /* renamed from: b  reason: collision with root package name */
        int f1181b = Integer.MIN_VALUE;

        /* renamed from: c  reason: collision with root package name */
        int f1182c = Integer.MIN_VALUE;

        /* renamed from: d  reason: collision with root package name */
        int f1183d = 0;
        final int e;

        d(int i) {
            this.e = i;
        }

        void a(View view) {
            c n = n(view);
            n.e = this;
            this.f1180a.add(view);
            this.f1182c = Integer.MIN_VALUE;
            if (this.f1180a.size() == 1) {
                this.f1181b = Integer.MIN_VALUE;
            }
            if (n.c() || n.b()) {
                this.f1183d += StaggeredGridLayoutManager.this.u.e(view);
            }
        }

        void b(boolean z, int i) {
            int l = z ? l(Integer.MIN_VALUE) : p(Integer.MIN_VALUE);
            e();
            if (l == Integer.MIN_VALUE) {
                return;
            }
            if (!z || l >= StaggeredGridLayoutManager.this.u.i()) {
                if (z || l <= StaggeredGridLayoutManager.this.u.m()) {
                    if (i != Integer.MIN_VALUE) {
                        l += i;
                    }
                    this.f1182c = l;
                    this.f1181b = l;
                }
            }
        }

        void c() {
            LazySpanLookup.FullSpanItem f;
            ArrayList<View> arrayList = this.f1180a;
            View view = arrayList.get(arrayList.size() - 1);
            c n = n(view);
            this.f1182c = StaggeredGridLayoutManager.this.u.d(view);
            if (n.f && (f = StaggeredGridLayoutManager.this.E.f(n.a())) != null && f.f1170c == 1) {
                this.f1182c += f.a(this.e);
            }
        }

        void d() {
            LazySpanLookup.FullSpanItem f;
            View view = this.f1180a.get(0);
            c n = n(view);
            this.f1181b = StaggeredGridLayoutManager.this.u.g(view);
            if (n.f && (f = StaggeredGridLayoutManager.this.E.f(n.a())) != null && f.f1170c == -1) {
                this.f1181b -= f.a(this.e);
            }
        }

        void e() {
            this.f1180a.clear();
            q();
            this.f1183d = 0;
        }

        public int f() {
            int i;
            int size;
            if (StaggeredGridLayoutManager.this.z) {
                i = this.f1180a.size() - 1;
                size = -1;
            } else {
                i = 0;
                size = this.f1180a.size();
            }
            return i(i, size, true);
        }

        public int g() {
            int size;
            int i;
            if (StaggeredGridLayoutManager.this.z) {
                size = 0;
                i = this.f1180a.size();
            } else {
                size = this.f1180a.size() - 1;
                i = -1;
            }
            return i(size, i, true);
        }

        int h(int i, int i2, boolean z, boolean z2, boolean z3) {
            int m = StaggeredGridLayoutManager.this.u.m();
            int i3 = StaggeredGridLayoutManager.this.u.i();
            int i4 = i2 > i ? 1 : -1;
            while (i != i2) {
                View view = this.f1180a.get(i);
                int g = StaggeredGridLayoutManager.this.u.g(view);
                int d2 = StaggeredGridLayoutManager.this.u.d(view);
                boolean z4 = false;
                boolean z5 = !z3 ? g >= i3 : g > i3;
                if (!z3 ? d2 > m : d2 >= m) {
                    z4 = true;
                }
                if (z5 && z4) {
                    if (!z || !z2) {
                        if (!z2 && g >= m && d2 <= i3) {
                        }
                        return StaggeredGridLayoutManager.this.f0(view);
                    } else if (g >= m && d2 <= i3) {
                        return StaggeredGridLayoutManager.this.f0(view);
                    }
                }
                i += i4;
            }
            return -1;
        }

        int i(int i, int i2, boolean z) {
            return h(i, i2, false, false, z);
        }

        public int j() {
            return this.f1183d;
        }

        int k() {
            int i = this.f1182c;
            if (i != Integer.MIN_VALUE) {
                return i;
            }
            c();
            return this.f1182c;
        }

        int l(int i) {
            int i2 = this.f1182c;
            if (i2 != Integer.MIN_VALUE) {
                return i2;
            }
            if (this.f1180a.size() == 0) {
                return i;
            }
            c();
            return this.f1182c;
        }

        public View m(int i, int i2) {
            View view = null;
            if (i2 != -1) {
                int size = this.f1180a.size() - 1;
                while (size >= 0) {
                    View view2 = this.f1180a.get(size);
                    StaggeredGridLayoutManager staggeredGridLayoutManager = StaggeredGridLayoutManager.this;
                    if (staggeredGridLayoutManager.z && staggeredGridLayoutManager.f0(view2) >= i) {
                        break;
                    }
                    StaggeredGridLayoutManager staggeredGridLayoutManager2 = StaggeredGridLayoutManager.this;
                    if ((!staggeredGridLayoutManager2.z && staggeredGridLayoutManager2.f0(view2) <= i) || !view2.hasFocusable()) {
                        break;
                    }
                    size--;
                    view = view2;
                }
            } else {
                int size2 = this.f1180a.size();
                int i3 = 0;
                while (i3 < size2) {
                    View view3 = this.f1180a.get(i3);
                    StaggeredGridLayoutManager staggeredGridLayoutManager3 = StaggeredGridLayoutManager.this;
                    if (staggeredGridLayoutManager3.z && staggeredGridLayoutManager3.f0(view3) <= i) {
                        break;
                    }
                    StaggeredGridLayoutManager staggeredGridLayoutManager4 = StaggeredGridLayoutManager.this;
                    if ((!staggeredGridLayoutManager4.z && staggeredGridLayoutManager4.f0(view3) >= i) || !view3.hasFocusable()) {
                        break;
                    }
                    i3++;
                    view = view3;
                }
            }
            return view;
        }

        c n(View view) {
            return (c) view.getLayoutParams();
        }

        int o() {
            int i = this.f1181b;
            if (i != Integer.MIN_VALUE) {
                return i;
            }
            d();
            return this.f1181b;
        }

        int p(int i) {
            int i2 = this.f1181b;
            if (i2 != Integer.MIN_VALUE) {
                return i2;
            }
            if (this.f1180a.size() == 0) {
                return i;
            }
            d();
            return this.f1181b;
        }

        void q() {
            this.f1181b = Integer.MIN_VALUE;
            this.f1182c = Integer.MIN_VALUE;
        }

        void r(int i) {
            int i2 = this.f1181b;
            if (i2 != Integer.MIN_VALUE) {
                this.f1181b = i2 + i;
            }
            int i3 = this.f1182c;
            if (i3 != Integer.MIN_VALUE) {
                this.f1182c = i3 + i;
            }
        }

        void s() {
            int size = this.f1180a.size();
            View remove = this.f1180a.remove(size - 1);
            c n = n(remove);
            n.e = null;
            if (n.c() || n.b()) {
                this.f1183d -= StaggeredGridLayoutManager.this.u.e(remove);
            }
            if (size == 1) {
                this.f1181b = Integer.MIN_VALUE;
            }
            this.f1182c = Integer.MIN_VALUE;
        }

        void t() {
            View remove = this.f1180a.remove(0);
            c n = n(remove);
            n.e = null;
            if (this.f1180a.size() == 0) {
                this.f1182c = Integer.MIN_VALUE;
            }
            if (n.c() || n.b()) {
                this.f1183d -= StaggeredGridLayoutManager.this.u.e(remove);
            }
            this.f1181b = Integer.MIN_VALUE;
        }

        void u(View view) {
            c n = n(view);
            n.e = this;
            this.f1180a.add(0, view);
            this.f1181b = Integer.MIN_VALUE;
            if (this.f1180a.size() == 1) {
                this.f1182c = Integer.MIN_VALUE;
            }
            if (n.c() || n.b()) {
                this.f1183d += StaggeredGridLayoutManager.this.u.e(view);
            }
        }

        void v(int i) {
            this.f1181b = i;
            this.f1182c = i;
        }
    }

    public StaggeredGridLayoutManager(Context context, AttributeSet attributeSet, int i, int i2) {
        RecyclerView.o.d g0 = RecyclerView.o.g0(context, attributeSet, i, i2);
        C2(g0.f1144a);
        E2(g0.f1145b);
        D2(g0.f1146c);
        this.y = new g();
        V1();
    }

    private void B2(int i) {
        g gVar = this.y;
        gVar.e = i;
        gVar.f1258d = this.A != (i == -1) ? -1 : 1;
    }

    private void F2(int i, int i2) {
        for (int i3 = 0; i3 < this.s; i3++) {
            if (!this.t[i3].f1180a.isEmpty()) {
                L2(this.t[i3], i, i2);
            }
        }
    }

    private boolean G2(RecyclerView.z zVar, b bVar) {
        boolean z = this.G;
        int b2 = zVar.b();
        bVar.f1176a = z ? b2(b2) : X1(b2);
        bVar.f1177b = Integer.MIN_VALUE;
        return true;
    }

    private void H1(View view) {
        for (int i = this.s - 1; i >= 0; i--) {
            this.t[i].a(view);
        }
    }

    private void I1(b bVar) {
        boolean z;
        SavedState savedState = this.I;
        int i = savedState.f1174d;
        if (i > 0) {
            if (i == this.s) {
                for (int i2 = 0; i2 < this.s; i2++) {
                    this.t[i2].e();
                    SavedState savedState2 = this.I;
                    int i3 = savedState2.e[i2];
                    if (i3 != Integer.MIN_VALUE) {
                        i3 += savedState2.j ? this.u.i() : this.u.m();
                    }
                    this.t[i2].v(i3);
                }
            } else {
                savedState.b();
                SavedState savedState3 = this.I;
                savedState3.f1172b = savedState3.f1173c;
            }
        }
        SavedState savedState4 = this.I;
        this.H = savedState4.k;
        D2(savedState4.i);
        z2();
        SavedState savedState5 = this.I;
        int i4 = savedState5.f1172b;
        if (i4 != -1) {
            this.C = i4;
            z = savedState5.j;
        } else {
            z = this.A;
        }
        bVar.f1178c = z;
        if (savedState5.f > 1) {
            LazySpanLookup lazySpanLookup = this.E;
            lazySpanLookup.f1167a = savedState5.g;
            lazySpanLookup.f1168b = savedState5.h;
        }
    }

    private void J2(int i, RecyclerView.z zVar) {
        int i2;
        int i3;
        int c2;
        g gVar = this.y;
        boolean z = false;
        gVar.f1256b = 0;
        gVar.f1257c = i;
        if (!v0() || (c2 = zVar.c()) == -1) {
            i2 = 0;
            i3 = 0;
        } else {
            if (this.A == (c2 < i)) {
                i2 = this.u.n();
                i3 = 0;
            } else {
                i3 = this.u.n();
                i2 = 0;
            }
        }
        if (L()) {
            this.y.f = this.u.m() - i3;
            this.y.g = this.u.i() + i2;
        } else {
            this.y.g = this.u.h() + i2;
            this.y.f = -i3;
        }
        g gVar2 = this.y;
        gVar2.h = false;
        gVar2.f1255a = true;
        if (this.u.k() == 0 && this.u.h() == 0) {
            z = true;
        }
        gVar2.i = z;
    }

    private void L1(View view, c cVar, g gVar) {
        if (gVar.e == 1) {
            if (cVar.f) {
                H1(view);
            } else {
                cVar.e.a(view);
            }
        } else if (cVar.f) {
            u2(view);
        } else {
            cVar.e.u(view);
        }
    }

    private void L2(d dVar, int i, int i2) {
        int j = dVar.j();
        if (i == -1) {
            if (dVar.o() + j > i2) {
                return;
            }
        } else if (dVar.k() - j < i2) {
            return;
        }
        this.B.set(dVar.e, false);
    }

    private int M1(int i) {
        if (I() == 0) {
            return this.A ? 1 : -1;
        }
        return (i < e2()) != this.A ? -1 : 1;
    }

    private int M2(int i, int i2, int i3) {
        if (i2 == 0 && i3 == 0) {
            return i;
        }
        int mode = View.MeasureSpec.getMode(i);
        return (mode == Integer.MIN_VALUE || mode == 1073741824) ? View.MeasureSpec.makeMeasureSpec(Math.max(0, (View.MeasureSpec.getSize(i) - i2) - i3), mode) : i;
    }

    private boolean O1(d dVar) {
        if (this.A) {
            if (dVar.k() < this.u.i()) {
                ArrayList<View> arrayList = dVar.f1180a;
                return !dVar.n(arrayList.get(arrayList.size() - 1)).f;
            }
        } else if (dVar.o() > this.u.m()) {
            return !dVar.n(dVar.f1180a.get(0)).f;
        }
        return false;
    }

    private int P1(RecyclerView.z zVar) {
        if (I() == 0) {
            return 0;
        }
        return k.a(zVar, this.u, Z1(!this.N), Y1(!this.N), this, this.N);
    }

    private int Q1(RecyclerView.z zVar) {
        if (I() == 0) {
            return 0;
        }
        return k.b(zVar, this.u, Z1(!this.N), Y1(!this.N), this, this.N, this.A);
    }

    private int R1(RecyclerView.z zVar) {
        if (I() == 0) {
            return 0;
        }
        return k.c(zVar, this.u, Z1(!this.N), Y1(!this.N), this, this.N);
    }

    private int S1(int i) {
        return i != 1 ? i != 2 ? i != 17 ? i != 33 ? i != 66 ? (i == 130 && this.w == 1) ? 1 : Integer.MIN_VALUE : this.w == 0 ? 1 : Integer.MIN_VALUE : this.w == 1 ? -1 : Integer.MIN_VALUE : this.w == 0 ? -1 : Integer.MIN_VALUE : (this.w != 1 && o2()) ? -1 : 1 : (this.w != 1 && o2()) ? 1 : -1;
    }

    private LazySpanLookup.FullSpanItem T1(int i) {
        LazySpanLookup.FullSpanItem fullSpanItem = new LazySpanLookup.FullSpanItem();
        fullSpanItem.f1171d = new int[this.s];
        for (int i2 = 0; i2 < this.s; i2++) {
            fullSpanItem.f1171d[i2] = i - this.t[i2].l(i);
        }
        return fullSpanItem;
    }

    private LazySpanLookup.FullSpanItem U1(int i) {
        LazySpanLookup.FullSpanItem fullSpanItem = new LazySpanLookup.FullSpanItem();
        fullSpanItem.f1171d = new int[this.s];
        for (int i2 = 0; i2 < this.s; i2++) {
            fullSpanItem.f1171d[i2] = this.t[i2].p(i) - i;
        }
        return fullSpanItem;
    }

    private void V1() {
        this.u = i.b(this, this.w);
        this.v = i.b(this, 1 - this.w);
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r9v0 */
    /* JADX WARN: Type inference failed for: r9v1, types: [int, boolean] */
    /* JADX WARN: Type inference failed for: r9v7 */
    private int W1(RecyclerView.v vVar, g gVar, RecyclerView.z zVar) {
        d dVar;
        int e;
        int i;
        int i2;
        int e2;
        RecyclerView.o oVar;
        View view;
        int i3;
        int i4;
        boolean z;
        ?? r9 = 0;
        this.B.set(0, this.s, true);
        int i5 = this.y.i ? gVar.e == 1 ? Integer.MAX_VALUE : Integer.MIN_VALUE : gVar.e == 1 ? gVar.g + gVar.f1256b : gVar.f - gVar.f1256b;
        F2(gVar.e, i5);
        int i6 = this.A ? this.u.i() : this.u.m();
        boolean z2 = false;
        while (gVar.a(zVar) && (this.y.i || !this.B.isEmpty())) {
            View b2 = gVar.b(vVar);
            c cVar = (c) b2.getLayoutParams();
            int a2 = cVar.a();
            int g = this.E.g(a2);
            boolean z3 = g == -1 ? true : r9;
            if (z3) {
                dVar = cVar.f ? this.t[r9] : k2(gVar);
                this.E.n(a2, dVar);
            } else {
                dVar = this.t[g];
            }
            d dVar2 = dVar;
            cVar.e = dVar2;
            if (gVar.e == 1) {
                c(b2);
            } else {
                d(b2, r9);
            }
            q2(b2, cVar, r9);
            if (gVar.e == 1) {
                int g2 = cVar.f ? g2(i6) : dVar2.l(i6);
                int e3 = this.u.e(b2) + g2;
                if (z3 && cVar.f) {
                    LazySpanLookup.FullSpanItem T1 = T1(g2);
                    T1.f1170c = -1;
                    T1.f1169b = a2;
                    this.E.a(T1);
                }
                i = e3;
                e = g2;
            } else {
                int j2 = cVar.f ? j2(i6) : dVar2.p(i6);
                e = j2 - this.u.e(b2);
                if (z3 && cVar.f) {
                    LazySpanLookup.FullSpanItem U1 = U1(j2);
                    U1.f1170c = 1;
                    U1.f1169b = a2;
                    this.E.a(U1);
                }
                i = j2;
            }
            if (cVar.f && gVar.f1258d == -1) {
                if (!z3) {
                    if (!(gVar.e == 1 ? J1() : K1())) {
                        LazySpanLookup.FullSpanItem f = this.E.f(a2);
                        if (f != null) {
                            f.e = true;
                        }
                    }
                }
                this.M = true;
            }
            L1(b2, cVar, gVar);
            if (o2() && this.w == 1) {
                int i7 = cVar.f ? this.v.i() : this.v.i() - (((this.s - 1) - dVar2.e) * this.x);
                e2 = i7;
                i2 = i7 - this.v.e(b2);
            } else {
                int m = cVar.f ? this.v.m() : (dVar2.e * this.x) + this.v.m();
                i2 = m;
                e2 = this.v.e(b2) + m;
            }
            if (this.w == 1) {
                oVar = this;
                view = b2;
                i3 = i2;
                i2 = e;
                i4 = e2;
            } else {
                oVar = this;
                view = b2;
                i3 = e;
                i4 = i;
                i = e2;
            }
            oVar.x0(view, i3, i2, i4, i);
            if (cVar.f) {
                F2(this.y.e, i5);
            } else {
                L2(dVar2, this.y.e, i5);
            }
            v2(vVar, this.y);
            if (this.y.h && b2.hasFocusable()) {
                if (cVar.f) {
                    this.B.clear();
                } else {
                    z = false;
                    this.B.set(dVar2.e, false);
                    r9 = z;
                    z2 = true;
                }
            }
            z = false;
            r9 = z;
            z2 = true;
        }
        int i8 = r9;
        if (!z2) {
            v2(vVar, this.y);
        }
        int m2 = this.y.e == -1 ? this.u.m() - j2(this.u.m()) : g2(this.u.i()) - this.u.i();
        return m2 > 0 ? Math.min(gVar.f1256b, m2) : i8;
    }

    private int X1(int i) {
        int I = I();
        for (int i2 = 0; i2 < I; i2++) {
            int f0 = f0(H(i2));
            if (f0 >= 0 && f0 < i) {
                return f0;
            }
        }
        return 0;
    }

    private int b2(int i) {
        for (int I = I() - 1; I >= 0; I--) {
            int f0 = f0(H(I));
            if (f0 >= 0 && f0 < i) {
                return f0;
            }
        }
        return 0;
    }

    private void c2(RecyclerView.v vVar, RecyclerView.z zVar, boolean z) {
        int i;
        int g2 = g2(Integer.MIN_VALUE);
        if (g2 != Integer.MIN_VALUE && (i = this.u.i() - g2) > 0) {
            int i2 = i - (-A2(-i, vVar, zVar));
            if (!z || i2 <= 0) {
                return;
            }
            this.u.r(i2);
        }
    }

    private void d2(RecyclerView.v vVar, RecyclerView.z zVar, boolean z) {
        int m;
        int j2 = j2(Integer.MAX_VALUE);
        if (j2 != Integer.MAX_VALUE && (m = j2 - this.u.m()) > 0) {
            int A2 = m - A2(m, vVar, zVar);
            if (!z || A2 <= 0) {
                return;
            }
            this.u.r(-A2);
        }
    }

    private int g2(int i) {
        int l = this.t[0].l(i);
        for (int i2 = 1; i2 < this.s; i2++) {
            int l2 = this.t[i2].l(i);
            if (l2 > l) {
                l = l2;
            }
        }
        return l;
    }

    private int h2(int i) {
        int p = this.t[0].p(i);
        for (int i2 = 1; i2 < this.s; i2++) {
            int p2 = this.t[i2].p(i);
            if (p2 > p) {
                p = p2;
            }
        }
        return p;
    }

    private int i2(int i) {
        int l = this.t[0].l(i);
        for (int i2 = 1; i2 < this.s; i2++) {
            int l2 = this.t[i2].l(i);
            if (l2 < l) {
                l = l2;
            }
        }
        return l;
    }

    private int j2(int i) {
        int p = this.t[0].p(i);
        for (int i2 = 1; i2 < this.s; i2++) {
            int p2 = this.t[i2].p(i);
            if (p2 < p) {
                p = p2;
            }
        }
        return p;
    }

    private d k2(g gVar) {
        int i;
        int i2;
        int i3 = -1;
        if (s2(gVar.e)) {
            i = this.s - 1;
            i2 = -1;
        } else {
            i = 0;
            i3 = this.s;
            i2 = 1;
        }
        d dVar = null;
        if (gVar.e == 1) {
            int i4 = Integer.MAX_VALUE;
            int m = this.u.m();
            while (i != i3) {
                d dVar2 = this.t[i];
                int l = dVar2.l(m);
                if (l < i4) {
                    dVar = dVar2;
                    i4 = l;
                }
                i += i2;
            }
            return dVar;
        }
        int i5 = Integer.MIN_VALUE;
        int i6 = this.u.i();
        while (i != i3) {
            d dVar3 = this.t[i];
            int p = dVar3.p(i6);
            if (p > i5) {
                dVar = dVar3;
                i5 = p;
            }
            i += i2;
        }
        return dVar;
    }

    /* JADX WARN: Removed duplicated region for block: B:15:0x0025  */
    /* JADX WARN: Removed duplicated region for block: B:21:0x003c  */
    /* JADX WARN: Removed duplicated region for block: B:23:0x0043 A[RETURN] */
    /* JADX WARN: Removed duplicated region for block: B:24:0x0044  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private void l2(int r7, int r8, int r9) {
        /*
            r6 = this;
            boolean r0 = r6.A
            if (r0 == 0) goto L9
            int r0 = r6.f2()
            goto Ld
        L9:
            int r0 = r6.e2()
        Ld:
            r1 = 8
            if (r9 != r1) goto L1a
            if (r7 >= r8) goto L16
            int r2 = r8 + 1
            goto L1c
        L16:
            int r2 = r7 + 1
            r3 = r8
            goto L1d
        L1a:
            int r2 = r7 + r8
        L1c:
            r3 = r7
        L1d:
            androidx.recyclerview.widget.StaggeredGridLayoutManager$LazySpanLookup r4 = r6.E
            r4.h(r3)
            r4 = 1
            if (r9 == r4) goto L3c
            r5 = 2
            if (r9 == r5) goto L36
            if (r9 == r1) goto L2b
            goto L41
        L2b:
            androidx.recyclerview.widget.StaggeredGridLayoutManager$LazySpanLookup r9 = r6.E
            r9.k(r7, r4)
            androidx.recyclerview.widget.StaggeredGridLayoutManager$LazySpanLookup r7 = r6.E
            r7.j(r8, r4)
            goto L41
        L36:
            androidx.recyclerview.widget.StaggeredGridLayoutManager$LazySpanLookup r9 = r6.E
            r9.k(r7, r8)
            goto L41
        L3c:
            androidx.recyclerview.widget.StaggeredGridLayoutManager$LazySpanLookup r9 = r6.E
            r9.j(r7, r8)
        L41:
            if (r2 > r0) goto L44
            return
        L44:
            boolean r7 = r6.A
            if (r7 == 0) goto L4d
            int r7 = r6.e2()
            goto L51
        L4d:
            int r7 = r6.f2()
        L51:
            if (r3 > r7) goto L56
            r6.q1()
        L56:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: androidx.recyclerview.widget.StaggeredGridLayoutManager.l2(int, int, int):void");
    }

    private void p2(View view, int i, int i2, boolean z) {
        i(view, this.K);
        c cVar = (c) view.getLayoutParams();
        int i3 = ((ViewGroup.MarginLayoutParams) cVar).leftMargin;
        Rect rect = this.K;
        int M2 = M2(i, i3 + rect.left, ((ViewGroup.MarginLayoutParams) cVar).rightMargin + rect.right);
        int i4 = ((ViewGroup.MarginLayoutParams) cVar).topMargin;
        Rect rect2 = this.K;
        int M22 = M2(i2, i4 + rect2.top, ((ViewGroup.MarginLayoutParams) cVar).bottomMargin + rect2.bottom);
        if (z ? E1(view, M2, M22, cVar) : C1(view, M2, M22, cVar)) {
            view.measure(M2, M22);
        }
    }

    private void q2(View view, c cVar, boolean z) {
        int J;
        int J2;
        if (cVar.f) {
            if (this.w != 1) {
                p2(view, RecyclerView.o.J(m0(), n0(), c0() + d0(), ((ViewGroup.MarginLayoutParams) cVar).width, true), this.J, z);
                return;
            }
            J = this.J;
        } else if (this.w != 1) {
            J = RecyclerView.o.J(m0(), n0(), c0() + d0(), ((ViewGroup.MarginLayoutParams) cVar).width, true);
            J2 = RecyclerView.o.J(this.x, W(), 0, ((ViewGroup.MarginLayoutParams) cVar).height, false);
            p2(view, J, J2, z);
        } else {
            J = RecyclerView.o.J(this.x, n0(), 0, ((ViewGroup.MarginLayoutParams) cVar).width, false);
        }
        J2 = RecyclerView.o.J(V(), W(), e0() + b0(), ((ViewGroup.MarginLayoutParams) cVar).height, true);
        p2(view, J, J2, z);
    }

    /* JADX WARN: Code restructure failed: missing block: B:87:0x014b, code lost:
        if (N1() != false) goto L83;
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private void r2(androidx.recyclerview.widget.RecyclerView.v r9, androidx.recyclerview.widget.RecyclerView.z r10, boolean r11) {
        /*
            Method dump skipped, instructions count: 367
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: androidx.recyclerview.widget.StaggeredGridLayoutManager.r2(androidx.recyclerview.widget.RecyclerView$v, androidx.recyclerview.widget.RecyclerView$z, boolean):void");
    }

    private boolean s2(int i) {
        if (this.w == 0) {
            return (i == -1) != this.A;
        }
        return ((i == -1) == this.A) == o2();
    }

    private void u2(View view) {
        for (int i = this.s - 1; i >= 0; i--) {
            this.t[i].u(view);
        }
    }

    /* JADX WARN: Code restructure failed: missing block: B:10:0x0010, code lost:
        if (r4.e == (-1)) goto L9;
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private void v2(androidx.recyclerview.widget.RecyclerView.v r3, androidx.recyclerview.widget.g r4) {
        /*
            r2 = this;
            boolean r0 = r4.f1255a
            if (r0 == 0) goto L4d
            boolean r0 = r4.i
            if (r0 == 0) goto L9
            goto L4d
        L9:
            int r0 = r4.f1256b
            r1 = -1
            if (r0 != 0) goto L1e
            int r0 = r4.e
            if (r0 != r1) goto L18
        L12:
            int r4 = r4.g
        L14:
            r2.w2(r3, r4)
            goto L4d
        L18:
            int r4 = r4.f
        L1a:
            r2.x2(r3, r4)
            goto L4d
        L1e:
            int r0 = r4.e
            if (r0 != r1) goto L37
            int r0 = r4.f
            int r1 = r2.h2(r0)
            int r0 = r0 - r1
            if (r0 >= 0) goto L2c
            goto L12
        L2c:
            int r1 = r4.g
            int r4 = r4.f1256b
            int r4 = java.lang.Math.min(r0, r4)
            int r4 = r1 - r4
            goto L14
        L37:
            int r0 = r4.g
            int r0 = r2.i2(r0)
            int r1 = r4.g
            int r0 = r0 - r1
            if (r0 >= 0) goto L43
            goto L18
        L43:
            int r1 = r4.f
            int r4 = r4.f1256b
            int r4 = java.lang.Math.min(r0, r4)
            int r4 = r4 + r1
            goto L1a
        L4d:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: androidx.recyclerview.widget.StaggeredGridLayoutManager.v2(androidx.recyclerview.widget.RecyclerView$v, androidx.recyclerview.widget.g):void");
    }

    private void w2(RecyclerView.v vVar, int i) {
        for (int I = I() - 1; I >= 0; I--) {
            View H = H(I);
            if (this.u.g(H) < i || this.u.q(H) < i) {
                return;
            }
            c cVar = (c) H.getLayoutParams();
            if (cVar.f) {
                for (int i2 = 0; i2 < this.s; i2++) {
                    if (this.t[i2].f1180a.size() == 1) {
                        return;
                    }
                }
                for (int i3 = 0; i3 < this.s; i3++) {
                    this.t[i3].s();
                }
            } else if (cVar.e.f1180a.size() == 1) {
                return;
            } else {
                cVar.e.s();
            }
            j1(H, vVar);
        }
    }

    private void x2(RecyclerView.v vVar, int i) {
        while (I() > 0) {
            View H = H(0);
            if (this.u.d(H) > i || this.u.p(H) > i) {
                return;
            }
            c cVar = (c) H.getLayoutParams();
            if (cVar.f) {
                for (int i2 = 0; i2 < this.s; i2++) {
                    if (this.t[i2].f1180a.size() == 1) {
                        return;
                    }
                }
                for (int i3 = 0; i3 < this.s; i3++) {
                    this.t[i3].t();
                }
            } else if (cVar.e.f1180a.size() == 1) {
                return;
            } else {
                cVar.e.t();
            }
            j1(H, vVar);
        }
    }

    private void y2() {
        if (this.v.k() == 1073741824) {
            return;
        }
        float f = 0.0f;
        int I = I();
        for (int i = 0; i < I; i++) {
            View H = H(i);
            float e = this.v.e(H);
            if (e >= f) {
                if (((c) H.getLayoutParams()).f()) {
                    e = (e * 1.0f) / this.s;
                }
                f = Math.max(f, e);
            }
        }
        int i2 = this.x;
        int round = Math.round(f * this.s);
        if (this.v.k() == Integer.MIN_VALUE) {
            round = Math.min(round, this.v.n());
        }
        K2(round);
        if (this.x == i2) {
            return;
        }
        for (int i3 = 0; i3 < I; i3++) {
            View H2 = H(i3);
            c cVar = (c) H2.getLayoutParams();
            if (!cVar.f) {
                if (o2() && this.w == 1) {
                    int i4 = this.s;
                    int i5 = cVar.e.e;
                    H2.offsetLeftAndRight(((-((i4 - 1) - i5)) * this.x) - ((-((i4 - 1) - i5)) * i2));
                } else {
                    int i6 = cVar.e.e;
                    int i7 = this.w;
                    int i8 = (this.x * i6) - (i6 * i2);
                    if (i7 == 1) {
                        H2.offsetLeftAndRight(i8);
                    } else {
                        H2.offsetTopAndBottom(i8);
                    }
                }
            }
        }
    }

    private void z2() {
        this.A = (this.w == 1 || !o2()) ? this.z : !this.z;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void A0(int i) {
        super.A0(i);
        for (int i2 = 0; i2 < this.s; i2++) {
            this.t[i2].r(i);
        }
    }

    int A2(int i, RecyclerView.v vVar, RecyclerView.z zVar) {
        if (I() == 0 || i == 0) {
            return 0;
        }
        t2(i, zVar);
        int W1 = W1(vVar, this.y, zVar);
        if (this.y.f1256b >= W1) {
            i = i < 0 ? -W1 : W1;
        }
        this.u.r(-i);
        this.G = this.A;
        g gVar = this.y;
        gVar.f1256b = 0;
        v2(vVar, gVar);
        return i;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void B0(int i) {
        super.B0(i);
        for (int i2 = 0; i2 < this.s; i2++) {
            this.t[i2].r(i);
        }
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public RecyclerView.p C() {
        return this.w == 0 ? new c(-2, -1) : new c(-1, -2);
    }

    public void C2(int i) {
        if (i != 0 && i != 1) {
            throw new IllegalArgumentException("invalid orientation.");
        }
        f(null);
        if (i == this.w) {
            return;
        }
        this.w = i;
        i iVar = this.u;
        this.u = this.v;
        this.v = iVar;
        q1();
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public RecyclerView.p D(Context context, AttributeSet attributeSet) {
        return new c(context, attributeSet);
    }

    public void D2(boolean z) {
        f(null);
        SavedState savedState = this.I;
        if (savedState != null && savedState.i != z) {
            savedState.i = z;
        }
        this.z = z;
        q1();
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public RecyclerView.p E(ViewGroup.LayoutParams layoutParams) {
        return layoutParams instanceof ViewGroup.MarginLayoutParams ? new c((ViewGroup.MarginLayoutParams) layoutParams) : new c(layoutParams);
    }

    public void E2(int i) {
        f(null);
        if (i != this.s) {
            n2();
            this.s = i;
            this.B = new BitSet(this.s);
            this.t = new d[this.s];
            for (int i2 = 0; i2 < this.s; i2++) {
                this.t[i2] = new d(i2);
            }
            q1();
        }
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void G0(RecyclerView recyclerView, RecyclerView.v vVar) {
        super.G0(recyclerView, vVar);
        l1(this.P);
        for (int i = 0; i < this.s; i++) {
            this.t[i].e();
        }
        recyclerView.requestLayout();
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public boolean G1() {
        return this.I == null;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public View H0(View view, int i, RecyclerView.v vVar, RecyclerView.z zVar) {
        View A;
        View m;
        if (I() == 0 || (A = A(view)) == null) {
            return null;
        }
        z2();
        int S1 = S1(i);
        if (S1 == Integer.MIN_VALUE) {
            return null;
        }
        c cVar = (c) A.getLayoutParams();
        boolean z = cVar.f;
        d dVar = cVar.e;
        int f2 = S1 == 1 ? f2() : e2();
        J2(f2, zVar);
        B2(S1);
        g gVar = this.y;
        gVar.f1257c = gVar.f1258d + f2;
        gVar.f1256b = (int) (this.u.n() * 0.33333334f);
        g gVar2 = this.y;
        gVar2.h = true;
        gVar2.f1255a = false;
        W1(vVar, gVar2, zVar);
        this.G = this.A;
        if (z || (m = dVar.m(f2, S1)) == null || m == A) {
            if (s2(S1)) {
                for (int i2 = this.s - 1; i2 >= 0; i2--) {
                    View m2 = this.t[i2].m(f2, S1);
                    if (m2 != null && m2 != A) {
                        return m2;
                    }
                }
            } else {
                for (int i3 = 0; i3 < this.s; i3++) {
                    View m3 = this.t[i3].m(f2, S1);
                    if (m3 != null && m3 != A) {
                        return m3;
                    }
                }
            }
            boolean z2 = (this.z ^ true) == (S1 == -1);
            if (!z) {
                View B = B(z2 ? dVar.f() : dVar.g());
                if (B != null && B != A) {
                    return B;
                }
            }
            if (s2(S1)) {
                for (int i4 = this.s - 1; i4 >= 0; i4--) {
                    if (i4 != dVar.e) {
                        d[] dVarArr = this.t;
                        View B2 = B(z2 ? dVarArr[i4].f() : dVarArr[i4].g());
                        if (B2 != null && B2 != A) {
                            return B2;
                        }
                    }
                }
            } else {
                for (int i5 = 0; i5 < this.s; i5++) {
                    d[] dVarArr2 = this.t;
                    View B3 = B(z2 ? dVarArr2[i5].f() : dVarArr2[i5].g());
                    if (B3 != null && B3 != A) {
                        return B3;
                    }
                }
            }
            return null;
        }
        return m;
    }

    boolean H2(RecyclerView.z zVar, b bVar) {
        int i;
        int m;
        int g;
        if (!zVar.e() && (i = this.C) != -1) {
            if (i >= 0 && i < zVar.b()) {
                SavedState savedState = this.I;
                if (savedState == null || savedState.f1172b == -1 || savedState.f1174d < 1) {
                    View B = B(this.C);
                    if (B != null) {
                        bVar.f1176a = this.A ? f2() : e2();
                        if (this.D != Integer.MIN_VALUE) {
                            if (bVar.f1178c) {
                                m = this.u.i() - this.D;
                                g = this.u.d(B);
                            } else {
                                m = this.u.m() + this.D;
                                g = this.u.g(B);
                            }
                            bVar.f1177b = m - g;
                            return true;
                        } else if (this.u.e(B) > this.u.n()) {
                            bVar.f1177b = bVar.f1178c ? this.u.i() : this.u.m();
                            return true;
                        } else {
                            int g2 = this.u.g(B) - this.u.m();
                            if (g2 < 0) {
                                bVar.f1177b = -g2;
                                return true;
                            }
                            int i2 = this.u.i() - this.u.d(B);
                            if (i2 < 0) {
                                bVar.f1177b = i2;
                                return true;
                            }
                            bVar.f1177b = Integer.MIN_VALUE;
                        }
                    } else {
                        int i3 = this.C;
                        bVar.f1176a = i3;
                        int i4 = this.D;
                        if (i4 == Integer.MIN_VALUE) {
                            bVar.f1178c = M1(i3) == 1;
                            bVar.a();
                        } else {
                            bVar.b(i4);
                        }
                        bVar.f1179d = true;
                    }
                } else {
                    bVar.f1177b = Integer.MIN_VALUE;
                    bVar.f1176a = this.C;
                }
                return true;
            }
            this.C = -1;
            this.D = Integer.MIN_VALUE;
        }
        return false;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void I0(AccessibilityEvent accessibilityEvent) {
        super.I0(accessibilityEvent);
        if (I() > 0) {
            View Z1 = Z1(false);
            View Y1 = Y1(false);
            if (Z1 == null || Y1 == null) {
                return;
            }
            int f0 = f0(Z1);
            int f02 = f0(Y1);
            if (f0 < f02) {
                accessibilityEvent.setFromIndex(f0);
                accessibilityEvent.setToIndex(f02);
                return;
            }
            accessibilityEvent.setFromIndex(f02);
            accessibilityEvent.setToIndex(f0);
        }
    }

    void I2(RecyclerView.z zVar, b bVar) {
        if (H2(zVar, bVar) || G2(zVar, bVar)) {
            return;
        }
        bVar.a();
        bVar.f1176a = 0;
    }

    boolean J1() {
        int l = this.t[0].l(Integer.MIN_VALUE);
        for (int i = 1; i < this.s; i++) {
            if (this.t[i].l(Integer.MIN_VALUE) != l) {
                return false;
            }
        }
        return true;
    }

    boolean K1() {
        int p = this.t[0].p(Integer.MIN_VALUE);
        for (int i = 1; i < this.s; i++) {
            if (this.t[i].p(Integer.MIN_VALUE) != p) {
                return false;
            }
        }
        return true;
    }

    void K2(int i) {
        this.x = i / this.s;
        this.J = View.MeasureSpec.makeMeasureSpec(i, this.v.k());
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public int M(RecyclerView.v vVar, RecyclerView.z zVar) {
        return this.w == 1 ? this.s : super.M(vVar, zVar);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void N0(RecyclerView.v vVar, RecyclerView.z zVar, View view, a.f.l.a0.c cVar) {
        int i;
        int i2;
        int e;
        boolean z;
        int i3;
        ViewGroup.LayoutParams layoutParams = view.getLayoutParams();
        if (!(layoutParams instanceof c)) {
            super.M0(view, cVar);
            return;
        }
        c cVar2 = (c) layoutParams;
        if (this.w == 0) {
            i = cVar2.e();
            z = cVar2.f;
            i2 = z ? this.s : 1;
            e = -1;
            i3 = -1;
        } else {
            i = -1;
            i2 = -1;
            e = cVar2.e();
            z = cVar2.f;
            i3 = z ? this.s : 1;
        }
        cVar.y(c.b.a(i, i2, e, i3, z, false));
    }

    boolean N1() {
        int e2;
        int f2;
        if (I() == 0 || this.F == 0 || !p0()) {
            return false;
        }
        if (this.A) {
            e2 = f2();
            f2 = e2();
        } else {
            e2 = e2();
            f2 = f2();
        }
        if (e2 == 0 && m2() != null) {
            this.E.b();
        } else if (!this.M) {
            return false;
        } else {
            int i = this.A ? -1 : 1;
            int i2 = f2 + 1;
            LazySpanLookup.FullSpanItem e = this.E.e(e2, i2, i, true);
            if (e == null) {
                this.M = false;
                this.E.d(i2);
                return false;
            }
            LazySpanLookup.FullSpanItem e3 = this.E.e(e2, e.f1169b, i * (-1), true);
            if (e3 == null) {
                this.E.d(e.f1169b);
            } else {
                this.E.d(e3.f1169b + 1);
            }
        }
        r1();
        q1();
        return true;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void P0(RecyclerView recyclerView, int i, int i2) {
        l2(i, i2, 1);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void Q0(RecyclerView recyclerView) {
        this.E.b();
        q1();
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void R0(RecyclerView recyclerView, int i, int i2, int i3) {
        l2(i, i2, 8);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void S0(RecyclerView recyclerView, int i, int i2) {
        l2(i, i2, 2);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void U0(RecyclerView recyclerView, int i, int i2, Object obj) {
        l2(i, i2, 4);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void V0(RecyclerView.v vVar, RecyclerView.z zVar) {
        r2(vVar, zVar, true);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void W0(RecyclerView.z zVar) {
        super.W0(zVar);
        this.C = -1;
        this.D = Integer.MIN_VALUE;
        this.I = null;
        this.L.c();
    }

    View Y1(boolean z) {
        int m = this.u.m();
        int i = this.u.i();
        View view = null;
        for (int I = I() - 1; I >= 0; I--) {
            View H = H(I);
            int g = this.u.g(H);
            int d2 = this.u.d(H);
            if (d2 > m && g < i) {
                if (d2 <= i || !z) {
                    return H;
                }
                if (view == null) {
                    view = H;
                }
            }
        }
        return view;
    }

    View Z1(boolean z) {
        int m = this.u.m();
        int i = this.u.i();
        int I = I();
        View view = null;
        for (int i2 = 0; i2 < I; i2++) {
            View H = H(i2);
            int g = this.u.g(H);
            if (this.u.d(H) > m && g < i) {
                if (g >= m || !z) {
                    return H;
                }
                if (view == null) {
                    view = H;
                }
            }
        }
        return view;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void a1(Parcelable parcelable) {
        if (parcelable instanceof SavedState) {
            this.I = (SavedState) parcelable;
            q1();
        }
    }

    int a2() {
        View Y1 = this.A ? Y1(true) : Z1(true);
        if (Y1 == null) {
            return -1;
        }
        return f0(Y1);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public Parcelable b1() {
        int p;
        int m;
        int[] iArr;
        if (this.I != null) {
            return new SavedState(this.I);
        }
        SavedState savedState = new SavedState();
        savedState.i = this.z;
        savedState.j = this.G;
        savedState.k = this.H;
        LazySpanLookup lazySpanLookup = this.E;
        if (lazySpanLookup == null || (iArr = lazySpanLookup.f1167a) == null) {
            savedState.f = 0;
        } else {
            savedState.g = iArr;
            savedState.f = iArr.length;
            savedState.h = lazySpanLookup.f1168b;
        }
        if (I() > 0) {
            savedState.f1172b = this.G ? f2() : e2();
            savedState.f1173c = a2();
            int i = this.s;
            savedState.f1174d = i;
            savedState.e = new int[i];
            for (int i2 = 0; i2 < this.s; i2++) {
                if (this.G) {
                    p = this.t[i2].l(Integer.MIN_VALUE);
                    if (p != Integer.MIN_VALUE) {
                        m = this.u.i();
                        p -= m;
                        savedState.e[i2] = p;
                    } else {
                        savedState.e[i2] = p;
                    }
                } else {
                    p = this.t[i2].p(Integer.MIN_VALUE);
                    if (p != Integer.MIN_VALUE) {
                        m = this.u.m();
                        p -= m;
                        savedState.e[i2] = p;
                    } else {
                        savedState.e[i2] = p;
                    }
                }
            }
        } else {
            savedState.f1172b = -1;
            savedState.f1173c = -1;
            savedState.f1174d = 0;
        }
        return savedState;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void c1(int i) {
        if (i == 0) {
            N1();
        }
    }

    int e2() {
        if (I() == 0) {
            return 0;
        }
        return f0(H(0));
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void f(String str) {
        if (this.I == null) {
            super.f(str);
        }
    }

    int f2() {
        int I = I();
        if (I == 0) {
            return 0;
        }
        return f0(H(I - 1));
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public int i0(RecyclerView.v vVar, RecyclerView.z zVar) {
        return this.w == 0 ? this.s : super.i0(vVar, zVar);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public boolean j() {
        return this.w == 0;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public boolean k() {
        return this.w == 1;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public boolean l(RecyclerView.p pVar) {
        return pVar instanceof c;
    }

    /* JADX WARN: Code restructure failed: missing block: B:31:0x0074, code lost:
        if (r10 == r11) goto L45;
     */
    /* JADX WARN: Code restructure failed: missing block: B:36:0x0086, code lost:
        if (r10 == r11) goto L45;
     */
    /* JADX WARN: Code restructure failed: missing block: B:37:0x0088, code lost:
        r10 = true;
     */
    /* JADX WARN: Code restructure failed: missing block: B:38:0x008a, code lost:
        r10 = false;
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    android.view.View m2() {
        /*
            r12 = this;
            int r0 = r12.I()
            r1 = 1
            int r0 = r0 - r1
            java.util.BitSet r2 = new java.util.BitSet
            int r3 = r12.s
            r2.<init>(r3)
            int r3 = r12.s
            r4 = 0
            r2.set(r4, r3, r1)
            int r3 = r12.w
            r5 = -1
            if (r3 != r1) goto L20
            boolean r3 = r12.o2()
            if (r3 == 0) goto L20
            r3 = r1
            goto L21
        L20:
            r3 = r5
        L21:
            boolean r6 = r12.A
            if (r6 == 0) goto L27
            r6 = r5
            goto L2b
        L27:
            int r0 = r0 + 1
            r6 = r0
            r0 = r4
        L2b:
            if (r0 >= r6) goto L2e
            r5 = r1
        L2e:
            if (r0 == r6) goto Lab
            android.view.View r7 = r12.H(r0)
            android.view.ViewGroup$LayoutParams r8 = r7.getLayoutParams()
            androidx.recyclerview.widget.StaggeredGridLayoutManager$c r8 = (androidx.recyclerview.widget.StaggeredGridLayoutManager.c) r8
            androidx.recyclerview.widget.StaggeredGridLayoutManager$d r9 = r8.e
            int r9 = r9.e
            boolean r9 = r2.get(r9)
            if (r9 == 0) goto L54
            androidx.recyclerview.widget.StaggeredGridLayoutManager$d r9 = r8.e
            boolean r9 = r12.O1(r9)
            if (r9 == 0) goto L4d
            return r7
        L4d:
            androidx.recyclerview.widget.StaggeredGridLayoutManager$d r9 = r8.e
            int r9 = r9.e
            r2.clear(r9)
        L54:
            boolean r9 = r8.f
            if (r9 == 0) goto L59
            goto La9
        L59:
            int r9 = r0 + r5
            if (r9 == r6) goto La9
            android.view.View r9 = r12.H(r9)
            boolean r10 = r12.A
            if (r10 == 0) goto L77
            androidx.recyclerview.widget.i r10 = r12.u
            int r10 = r10.d(r7)
            androidx.recyclerview.widget.i r11 = r12.u
            int r11 = r11.d(r9)
            if (r10 >= r11) goto L74
            return r7
        L74:
            if (r10 != r11) goto L8a
            goto L88
        L77:
            androidx.recyclerview.widget.i r10 = r12.u
            int r10 = r10.g(r7)
            androidx.recyclerview.widget.i r11 = r12.u
            int r11 = r11.g(r9)
            if (r10 <= r11) goto L86
            return r7
        L86:
            if (r10 != r11) goto L8a
        L88:
            r10 = r1
            goto L8b
        L8a:
            r10 = r4
        L8b:
            if (r10 == 0) goto La9
            android.view.ViewGroup$LayoutParams r9 = r9.getLayoutParams()
            androidx.recyclerview.widget.StaggeredGridLayoutManager$c r9 = (androidx.recyclerview.widget.StaggeredGridLayoutManager.c) r9
            androidx.recyclerview.widget.StaggeredGridLayoutManager$d r8 = r8.e
            int r8 = r8.e
            androidx.recyclerview.widget.StaggeredGridLayoutManager$d r9 = r9.e
            int r9 = r9.e
            int r8 = r8 - r9
            if (r8 >= 0) goto La0
            r8 = r1
            goto La1
        La0:
            r8 = r4
        La1:
            if (r3 >= 0) goto La5
            r9 = r1
            goto La6
        La5:
            r9 = r4
        La6:
            if (r8 == r9) goto La9
            return r7
        La9:
            int r0 = r0 + r5
            goto L2e
        Lab:
            r0 = 0
            return r0
        */
        throw new UnsupportedOperationException("Method not decompiled: androidx.recyclerview.widget.StaggeredGridLayoutManager.m2():android.view.View");
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void n(int i, int i2, RecyclerView.z zVar, RecyclerView.o.c cVar) {
        int l;
        int i3;
        if (this.w != 0) {
            i = i2;
        }
        if (I() == 0 || i == 0) {
            return;
        }
        t2(i, zVar);
        int[] iArr = this.O;
        if (iArr == null || iArr.length < this.s) {
            this.O = new int[this.s];
        }
        int i4 = 0;
        for (int i5 = 0; i5 < this.s; i5++) {
            g gVar = this.y;
            if (gVar.f1258d == -1) {
                l = gVar.f;
                i3 = this.t[i5].p(l);
            } else {
                l = this.t[i5].l(gVar.g);
                i3 = this.y.g;
            }
            int i6 = l - i3;
            if (i6 >= 0) {
                this.O[i4] = i6;
                i4++;
            }
        }
        Arrays.sort(this.O, 0, i4);
        for (int i7 = 0; i7 < i4 && this.y.a(zVar); i7++) {
            cVar.a(this.y.f1257c, this.O[i7]);
            g gVar2 = this.y;
            gVar2.f1257c += gVar2.f1258d;
        }
    }

    public void n2() {
        this.E.b();
        q1();
    }

    boolean o2() {
        return X() == 1;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public int p(RecyclerView.z zVar) {
        return P1(zVar);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public int q(RecyclerView.z zVar) {
        return Q1(zVar);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public boolean q0() {
        return this.F != 0;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public int r(RecyclerView.z zVar) {
        return R1(zVar);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public int s(RecyclerView.z zVar) {
        return P1(zVar);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public int t(RecyclerView.z zVar) {
        return Q1(zVar);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public int t1(int i, RecyclerView.v vVar, RecyclerView.z zVar) {
        return A2(i, vVar, zVar);
    }

    void t2(int i, RecyclerView.z zVar) {
        int i2;
        int e2;
        if (i > 0) {
            e2 = f2();
            i2 = 1;
        } else {
            i2 = -1;
            e2 = e2();
        }
        this.y.f1255a = true;
        J2(e2, zVar);
        B2(i2);
        g gVar = this.y;
        gVar.f1257c = e2 + gVar.f1258d;
        gVar.f1256b = Math.abs(i);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public int u(RecyclerView.z zVar) {
        return R1(zVar);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void u1(int i) {
        SavedState savedState = this.I;
        if (savedState != null && savedState.f1172b != i) {
            savedState.a();
        }
        this.C = i;
        this.D = Integer.MIN_VALUE;
        q1();
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public int v1(int i, RecyclerView.v vVar, RecyclerView.z zVar) {
        return A2(i, vVar, zVar);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void z1(Rect rect, int i, int i2) {
        int m;
        int m2;
        int c0 = c0() + d0();
        int e0 = e0() + b0();
        if (this.w == 1) {
            m2 = RecyclerView.o.m(i2, rect.height() + e0, Z());
            m = RecyclerView.o.m(i, (this.x * this.s) + c0, a0());
        } else {
            m = RecyclerView.o.m(i, rect.width() + c0, a0());
            m2 = RecyclerView.o.m(i2, (this.x * this.s) + e0, Z());
        }
        y1(m, m2);
    }
}
