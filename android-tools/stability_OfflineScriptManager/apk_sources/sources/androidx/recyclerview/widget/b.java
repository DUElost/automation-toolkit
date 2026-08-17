package androidx.recyclerview.widget;

import android.view.View;
import android.view.ViewGroup;
import androidx.recyclerview.widget.RecyclerView;
import java.util.ArrayList;
import java.util.List;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class b {

    /* renamed from: a  reason: collision with root package name */
    final InterfaceC0040b f1192a;

    /* renamed from: b  reason: collision with root package name */
    final a f1193b = new a();

    /* renamed from: c  reason: collision with root package name */
    final List<View> f1194c = new ArrayList();

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class a {

        /* renamed from: a  reason: collision with root package name */
        long f1195a = 0;

        /* renamed from: b  reason: collision with root package name */
        a f1196b;

        a() {
        }

        private void c() {
            if (this.f1196b == null) {
                this.f1196b = new a();
            }
        }

        void a(int i) {
            if (i < 64) {
                this.f1195a &= ~(1 << i);
                return;
            }
            a aVar = this.f1196b;
            if (aVar != null) {
                aVar.a(i - 64);
            }
        }

        int b(int i) {
            a aVar = this.f1196b;
            return aVar == null ? i >= 64 ? Long.bitCount(this.f1195a) : Long.bitCount(this.f1195a & ((1 << i) - 1)) : i < 64 ? Long.bitCount(this.f1195a & ((1 << i) - 1)) : aVar.b(i - 64) + Long.bitCount(this.f1195a);
        }

        boolean d(int i) {
            if (i < 64) {
                return (this.f1195a & (1 << i)) != 0;
            }
            c();
            return this.f1196b.d(i - 64);
        }

        void e(int i, boolean z) {
            if (i >= 64) {
                c();
                this.f1196b.e(i - 64, z);
                return;
            }
            long j = this.f1195a;
            boolean z2 = (Long.MIN_VALUE & j) != 0;
            long j2 = (1 << i) - 1;
            this.f1195a = ((j & (~j2)) << 1) | (j & j2);
            if (z) {
                h(i);
            } else {
                a(i);
            }
            if (z2 || this.f1196b != null) {
                c();
                this.f1196b.e(0, z2);
            }
        }

        boolean f(int i) {
            if (i >= 64) {
                c();
                return this.f1196b.f(i - 64);
            }
            long j = 1 << i;
            long j2 = this.f1195a;
            boolean z = (j2 & j) != 0;
            long j3 = j2 & (~j);
            this.f1195a = j3;
            long j4 = j - 1;
            this.f1195a = (j3 & j4) | Long.rotateRight((~j4) & j3, 1);
            a aVar = this.f1196b;
            if (aVar != null) {
                if (aVar.d(0)) {
                    h(63);
                }
                this.f1196b.f(0);
            }
            return z;
        }

        void g() {
            this.f1195a = 0L;
            a aVar = this.f1196b;
            if (aVar != null) {
                aVar.g();
            }
        }

        void h(int i) {
            if (i < 64) {
                this.f1195a |= 1 << i;
                return;
            }
            c();
            this.f1196b.h(i - 64);
        }

        public String toString() {
            if (this.f1196b == null) {
                return Long.toBinaryString(this.f1195a);
            }
            return this.f1196b.toString() + "xx" + Long.toBinaryString(this.f1195a);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: androidx.recyclerview.widget.b$b  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public interface InterfaceC0040b {
        View a(int i);

        void b(View view);

        void c(int i);

        void d();

        RecyclerView.c0 e(View view);

        void f(int i);

        void g(View view);

        void h(View view, int i, ViewGroup.LayoutParams layoutParams);

        void i(View view, int i);

        int j(View view);

        int k();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public b(InterfaceC0040b interfaceC0040b) {
        this.f1192a = interfaceC0040b;
    }

    private int h(int i) {
        if (i < 0) {
            return -1;
        }
        int k = this.f1192a.k();
        int i2 = i;
        while (i2 < k) {
            int b2 = i - (i2 - this.f1193b.b(i2));
            if (b2 == 0) {
                while (this.f1193b.d(i2)) {
                    i2++;
                }
                return i2;
            }
            i2 += b2;
        }
        return -1;
    }

    private void l(View view) {
        this.f1194c.add(view);
        this.f1192a.b(view);
    }

    private boolean t(View view) {
        if (this.f1194c.remove(view)) {
            this.f1192a.g(view);
            return true;
        }
        return false;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void a(View view, int i, boolean z) {
        int k = i < 0 ? this.f1192a.k() : h(i);
        this.f1193b.e(k, z);
        if (z) {
            l(view);
        }
        this.f1192a.i(view, k);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void b(View view, boolean z) {
        a(view, -1, z);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void c(View view, int i, ViewGroup.LayoutParams layoutParams, boolean z) {
        int k = i < 0 ? this.f1192a.k() : h(i);
        this.f1193b.e(k, z);
        if (z) {
            l(view);
        }
        this.f1192a.h(view, k, layoutParams);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void d(int i) {
        int h = h(i);
        this.f1193b.f(h);
        this.f1192a.f(h);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public View e(int i) {
        int size = this.f1194c.size();
        for (int i2 = 0; i2 < size; i2++) {
            View view = this.f1194c.get(i2);
            RecyclerView.c0 e = this.f1192a.e(view);
            if (e.m() == i && !e.t() && !e.v()) {
                return view;
            }
        }
        return null;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public View f(int i) {
        return this.f1192a.a(h(i));
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int g() {
        return this.f1192a.k() - this.f1194c.size();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public View i(int i) {
        return this.f1192a.a(i);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int j() {
        return this.f1192a.k();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void k(View view) {
        int j = this.f1192a.j(view);
        if (j >= 0) {
            this.f1193b.h(j);
            l(view);
            return;
        }
        throw new IllegalArgumentException("view is not a child, cannot hide " + view);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int m(View view) {
        int j = this.f1192a.j(view);
        if (j == -1 || this.f1193b.d(j)) {
            return -1;
        }
        return j - this.f1193b.b(j);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean n(View view) {
        return this.f1194c.contains(view);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void o() {
        this.f1193b.g();
        for (int size = this.f1194c.size() - 1; size >= 0; size--) {
            this.f1192a.g(this.f1194c.get(size));
            this.f1194c.remove(size);
        }
        this.f1192a.d();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void p(View view) {
        int j = this.f1192a.j(view);
        if (j < 0) {
            return;
        }
        if (this.f1193b.f(j)) {
            t(view);
        }
        this.f1192a.c(j);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void q(int i) {
        int h = h(i);
        View a2 = this.f1192a.a(h);
        if (a2 == null) {
            return;
        }
        if (this.f1193b.f(h)) {
            t(a2);
        }
        this.f1192a.c(h);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean r(View view) {
        int j = this.f1192a.j(view);
        if (j == -1) {
            t(view);
            return true;
        } else if (this.f1193b.d(j)) {
            this.f1193b.f(j);
            t(view);
            this.f1192a.c(j);
            return true;
        } else {
            return false;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void s(View view) {
        int j = this.f1192a.j(view);
        if (j < 0) {
            throw new IllegalArgumentException("view is not a child, cannot hide " + view);
        } else if (this.f1193b.d(j)) {
            this.f1193b.a(j);
            t(view);
        } else {
            throw new RuntimeException("trying to unhide a view that was not hidden" + view);
        }
    }

    public String toString() {
        return this.f1193b.toString() + ", hidden list:" + this.f1194c.size();
    }
}
