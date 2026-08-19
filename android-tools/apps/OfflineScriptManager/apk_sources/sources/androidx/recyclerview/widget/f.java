package androidx.recyclerview.widget;

import androidx.recyclerview.widget.RecyclerView;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.concurrent.TimeUnit;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public final class f implements Runnable {
    static final ThreadLocal<f> f = new ThreadLocal<>();
    static Comparator<c> g = new a();

    /* renamed from: c  reason: collision with root package name */
    long f1245c;

    /* renamed from: d  reason: collision with root package name */
    long f1246d;

    /* renamed from: b  reason: collision with root package name */
    ArrayList<RecyclerView> f1244b = new ArrayList<>();
    private ArrayList<c> e = new ArrayList<>();

    /* loaded from: classes.dex */
    static class a implements Comparator<c> {
        a() {
        }

        @Override // java.util.Comparator
        /* renamed from: a */
        public int compare(c cVar, c cVar2) {
            RecyclerView recyclerView = cVar.f1254d;
            if ((recyclerView == null) != (cVar2.f1254d == null)) {
                return recyclerView == null ? 1 : -1;
            }
            boolean z = cVar.f1251a;
            if (z != cVar2.f1251a) {
                return z ? -1 : 1;
            }
            int i = cVar2.f1252b - cVar.f1252b;
            if (i != 0) {
                return i;
            }
            int i2 = cVar.f1253c - cVar2.f1253c;
            if (i2 != 0) {
                return i2;
            }
            return 0;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class b implements RecyclerView.o.c {

        /* renamed from: a  reason: collision with root package name */
        int f1247a;

        /* renamed from: b  reason: collision with root package name */
        int f1248b;

        /* renamed from: c  reason: collision with root package name */
        int[] f1249c;

        /* renamed from: d  reason: collision with root package name */
        int f1250d;

        @Override // androidx.recyclerview.widget.RecyclerView.o.c
        public void a(int i, int i2) {
            if (i < 0) {
                throw new IllegalArgumentException("Layout positions must be non-negative");
            }
            if (i2 < 0) {
                throw new IllegalArgumentException("Pixel distance must be non-negative");
            }
            int i3 = this.f1250d * 2;
            int[] iArr = this.f1249c;
            if (iArr == null) {
                int[] iArr2 = new int[4];
                this.f1249c = iArr2;
                Arrays.fill(iArr2, -1);
            } else if (i3 >= iArr.length) {
                int[] iArr3 = new int[i3 * 2];
                this.f1249c = iArr3;
                System.arraycopy(iArr, 0, iArr3, 0, iArr.length);
            }
            int[] iArr4 = this.f1249c;
            iArr4[i3] = i;
            iArr4[i3 + 1] = i2;
            this.f1250d++;
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        public void b() {
            int[] iArr = this.f1249c;
            if (iArr != null) {
                Arrays.fill(iArr, -1);
            }
            this.f1250d = 0;
        }

        void c(RecyclerView recyclerView, boolean z) {
            this.f1250d = 0;
            int[] iArr = this.f1249c;
            if (iArr != null) {
                Arrays.fill(iArr, -1);
            }
            RecyclerView.o oVar = recyclerView.n;
            if (recyclerView.m == null || oVar == null || !oVar.s0()) {
                return;
            }
            if (z) {
                if (!recyclerView.e.p()) {
                    oVar.o(recyclerView.m.c(), this);
                }
            } else if (!recyclerView.n0()) {
                oVar.n(this.f1247a, this.f1248b, recyclerView.i0, this);
            }
            int i = this.f1250d;
            if (i > oVar.m) {
                oVar.m = i;
                oVar.n = z;
                recyclerView.f1115c.K();
            }
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        public boolean d(int i) {
            if (this.f1249c != null) {
                int i2 = this.f1250d * 2;
                for (int i3 = 0; i3 < i2; i3 += 2) {
                    if (this.f1249c[i3] == i) {
                        return true;
                    }
                }
            }
            return false;
        }

        void e(int i, int i2) {
            this.f1247a = i;
            this.f1248b = i2;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class c {

        /* renamed from: a  reason: collision with root package name */
        public boolean f1251a;

        /* renamed from: b  reason: collision with root package name */
        public int f1252b;

        /* renamed from: c  reason: collision with root package name */
        public int f1253c;

        /* renamed from: d  reason: collision with root package name */
        public RecyclerView f1254d;
        public int e;

        c() {
        }

        public void a() {
            this.f1251a = false;
            this.f1252b = 0;
            this.f1253c = 0;
            this.f1254d = null;
            this.e = 0;
        }
    }

    private void b() {
        c cVar;
        int size = this.f1244b.size();
        int i = 0;
        for (int i2 = 0; i2 < size; i2++) {
            RecyclerView recyclerView = this.f1244b.get(i2);
            if (recyclerView.getWindowVisibility() == 0) {
                recyclerView.h0.c(recyclerView, false);
                i += recyclerView.h0.f1250d;
            }
        }
        this.e.ensureCapacity(i);
        int i3 = 0;
        for (int i4 = 0; i4 < size; i4++) {
            RecyclerView recyclerView2 = this.f1244b.get(i4);
            if (recyclerView2.getWindowVisibility() == 0) {
                b bVar = recyclerView2.h0;
                int abs = Math.abs(bVar.f1247a) + Math.abs(bVar.f1248b);
                for (int i5 = 0; i5 < bVar.f1250d * 2; i5 += 2) {
                    if (i3 >= this.e.size()) {
                        cVar = new c();
                        this.e.add(cVar);
                    } else {
                        cVar = this.e.get(i3);
                    }
                    int[] iArr = bVar.f1249c;
                    int i6 = iArr[i5 + 1];
                    cVar.f1251a = i6 <= abs;
                    cVar.f1252b = abs;
                    cVar.f1253c = i6;
                    cVar.f1254d = recyclerView2;
                    cVar.e = iArr[i5];
                    i3++;
                }
            }
        }
        Collections.sort(this.e, g);
    }

    private void c(c cVar, long j) {
        RecyclerView.c0 i = i(cVar.f1254d, cVar.e, cVar.f1251a ? Long.MAX_VALUE : j);
        if (i == null || i.f1124c == null || !i.s() || i.t()) {
            return;
        }
        h(i.f1124c.get(), j);
    }

    private void d(long j) {
        for (int i = 0; i < this.e.size(); i++) {
            c cVar = this.e.get(i);
            if (cVar.f1254d == null) {
                return;
            }
            c(cVar, j);
            cVar.a();
        }
    }

    static boolean e(RecyclerView recyclerView, int i) {
        int j = recyclerView.f.j();
        for (int i2 = 0; i2 < j; i2++) {
            RecyclerView.c0 f0 = RecyclerView.f0(recyclerView.f.i(i2));
            if (f0.f1125d == i && !f0.t()) {
                return true;
            }
        }
        return false;
    }

    private void h(RecyclerView recyclerView, long j) {
        if (recyclerView == null) {
            return;
        }
        if (recyclerView.E && recyclerView.f.j() != 0) {
            recyclerView.U0();
        }
        b bVar = recyclerView.h0;
        bVar.c(recyclerView, true);
        if (bVar.f1250d != 0) {
            try {
                a.f.h.a.a("RV Nested Prefetch");
                recyclerView.i0.f(recyclerView.m);
                for (int i = 0; i < bVar.f1250d * 2; i += 2) {
                    i(recyclerView, bVar.f1249c[i], j);
                }
            } finally {
                a.f.h.a.b();
            }
        }
    }

    private RecyclerView.c0 i(RecyclerView recyclerView, int i, long j) {
        if (e(recyclerView, i)) {
            return null;
        }
        RecyclerView.v vVar = recyclerView.f1115c;
        try {
            recyclerView.G0();
            RecyclerView.c0 I = vVar.I(i, false, j);
            if (I != null) {
                if (!I.s() || I.t()) {
                    vVar.a(I, false);
                } else {
                    vVar.B(I.f1123b);
                }
            }
            return I;
        } finally {
            recyclerView.I0(false);
        }
    }

    public void a(RecyclerView recyclerView) {
        this.f1244b.add(recyclerView);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void f(RecyclerView recyclerView, int i, int i2) {
        if (recyclerView.isAttachedToWindow() && this.f1245c == 0) {
            this.f1245c = recyclerView.getNanoTime();
            recyclerView.post(this);
        }
        recyclerView.h0.e(i, i2);
    }

    void g(long j) {
        b();
        d(j);
    }

    public void j(RecyclerView recyclerView) {
        this.f1244b.remove(recyclerView);
    }

    @Override // java.lang.Runnable
    public void run() {
        try {
            a.f.h.a.a("RV Prefetch");
            if (!this.f1244b.isEmpty()) {
                int size = this.f1244b.size();
                long j = 0;
                for (int i = 0; i < size; i++) {
                    RecyclerView recyclerView = this.f1244b.get(i);
                    if (recyclerView.getWindowVisibility() == 0) {
                        j = Math.max(recyclerView.getDrawingTime(), j);
                    }
                }
                if (j != 0) {
                    g(TimeUnit.MILLISECONDS.toNanos(j) + this.f1246d);
                }
            }
        } finally {
            this.f1245c = 0L;
            a.f.h.a.b();
        }
    }
}
