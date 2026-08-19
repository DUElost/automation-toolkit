package androidx.recyclerview.widget;

import androidx.recyclerview.widget.RecyclerView;
import androidx.recyclerview.widget.h;
import java.util.ArrayList;
import java.util.List;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class a implements h.a {

    /* renamed from: a  reason: collision with root package name */
    private a.f.k.d<b> f1184a;

    /* renamed from: b  reason: collision with root package name */
    final ArrayList<b> f1185b;

    /* renamed from: c  reason: collision with root package name */
    final ArrayList<b> f1186c;

    /* renamed from: d  reason: collision with root package name */
    final InterfaceC0039a f1187d;
    Runnable e;
    final boolean f;
    final h g;
    private int h;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: androidx.recyclerview.widget.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public interface InterfaceC0039a {
        void a(int i, int i2);

        void b(b bVar);

        RecyclerView.c0 c(int i);

        void d(int i, int i2);

        void e(int i, int i2);

        void f(b bVar);

        void g(int i, int i2);

        void h(int i, int i2, Object obj);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class b {

        /* renamed from: a  reason: collision with root package name */
        int f1188a;

        /* renamed from: b  reason: collision with root package name */
        int f1189b;

        /* renamed from: c  reason: collision with root package name */
        Object f1190c;

        /* renamed from: d  reason: collision with root package name */
        int f1191d;

        b(int i, int i2, int i3, Object obj) {
            this.f1188a = i;
            this.f1189b = i2;
            this.f1191d = i3;
            this.f1190c = obj;
        }

        String a() {
            int i = this.f1188a;
            return i != 1 ? i != 2 ? i != 4 ? i != 8 ? "??" : "mv" : "up" : "rm" : "add";
        }

        public boolean equals(Object obj) {
            if (this == obj) {
                return true;
            }
            if (obj == null || b.class != obj.getClass()) {
                return false;
            }
            b bVar = (b) obj;
            int i = this.f1188a;
            if (i != bVar.f1188a) {
                return false;
            }
            if (i == 8 && Math.abs(this.f1191d - this.f1189b) == 1 && this.f1191d == bVar.f1189b && this.f1189b == bVar.f1191d) {
                return true;
            }
            if (this.f1191d == bVar.f1191d && this.f1189b == bVar.f1189b) {
                Object obj2 = this.f1190c;
                Object obj3 = bVar.f1190c;
                if (obj2 != null) {
                    if (!obj2.equals(obj3)) {
                        return false;
                    }
                } else if (obj3 != null) {
                    return false;
                }
                return true;
            }
            return false;
        }

        public int hashCode() {
            return (((this.f1188a * 31) + this.f1189b) * 31) + this.f1191d;
        }

        public String toString() {
            return Integer.toHexString(System.identityHashCode(this)) + "[" + a() + ",s:" + this.f1189b + "c:" + this.f1191d + ",p:" + this.f1190c + "]";
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public a(InterfaceC0039a interfaceC0039a) {
        this(interfaceC0039a, false);
    }

    a(InterfaceC0039a interfaceC0039a, boolean z) {
        this.f1184a = new a.f.k.e(30);
        this.f1185b = new ArrayList<>();
        this.f1186c = new ArrayList<>();
        this.h = 0;
        this.f1187d = interfaceC0039a;
        this.f = z;
        this.g = new h(this);
    }

    private void c(b bVar) {
        t(bVar);
    }

    private void d(b bVar) {
        t(bVar);
    }

    private void f(b bVar) {
        boolean z;
        char c2;
        int i = bVar.f1189b;
        int i2 = bVar.f1191d + i;
        char c3 = 65535;
        int i3 = i;
        int i4 = 0;
        while (i3 < i2) {
            if (this.f1187d.c(i3) != null || h(i3)) {
                if (c3 == 0) {
                    k(b(2, i, i4, null));
                    z = true;
                } else {
                    z = false;
                }
                c2 = 1;
            } else {
                if (c3 == 1) {
                    t(b(2, i, i4, null));
                    z = true;
                } else {
                    z = false;
                }
                c2 = 0;
            }
            if (z) {
                i3 -= i4;
                i2 -= i4;
                i4 = 1;
            } else {
                i4++;
            }
            i3++;
            c3 = c2;
        }
        if (i4 != bVar.f1191d) {
            a(bVar);
            bVar = b(2, i, i4, null);
        }
        if (c3 == 0) {
            k(bVar);
        } else {
            t(bVar);
        }
    }

    private void g(b bVar) {
        int i = bVar.f1189b;
        int i2 = bVar.f1191d + i;
        int i3 = 0;
        boolean z = true;
        int i4 = i;
        while (i < i2) {
            if (this.f1187d.c(i) != null || h(i)) {
                if (!z) {
                    k(b(4, i4, i3, bVar.f1190c));
                    i4 = i;
                    i3 = 0;
                }
                z = true;
            } else {
                if (z) {
                    t(b(4, i4, i3, bVar.f1190c));
                    i4 = i;
                    i3 = 0;
                }
                z = false;
            }
            i3++;
            i++;
        }
        if (i3 != bVar.f1191d) {
            Object obj = bVar.f1190c;
            a(bVar);
            bVar = b(4, i4, i3, obj);
        }
        if (z) {
            t(bVar);
        } else {
            k(bVar);
        }
    }

    private boolean h(int i) {
        int size = this.f1186c.size();
        for (int i2 = 0; i2 < size; i2++) {
            b bVar = this.f1186c.get(i2);
            int i3 = bVar.f1188a;
            if (i3 == 8) {
                if (n(bVar.f1191d, i2 + 1) == i) {
                    return true;
                }
            } else if (i3 == 1) {
                int i4 = bVar.f1189b;
                int i5 = bVar.f1191d + i4;
                while (i4 < i5) {
                    if (n(i4, i2 + 1) == i) {
                        return true;
                    }
                    i4++;
                }
                continue;
            } else {
                continue;
            }
        }
        return false;
    }

    private void k(b bVar) {
        int i;
        int i2 = bVar.f1188a;
        if (i2 == 1 || i2 == 8) {
            throw new IllegalArgumentException("should not dispatch add or move for pre layout");
        }
        int x = x(bVar.f1189b, i2);
        int i3 = bVar.f1189b;
        int i4 = bVar.f1188a;
        if (i4 == 2) {
            i = 0;
        } else if (i4 != 4) {
            throw new IllegalArgumentException("op should be remove or update." + bVar);
        } else {
            i = 1;
        }
        int i5 = 1;
        for (int i6 = 1; i6 < bVar.f1191d; i6++) {
            int x2 = x(bVar.f1189b + (i * i6), bVar.f1188a);
            int i7 = bVar.f1188a;
            if (i7 == 2 ? x2 == x : i7 == 4 && x2 == x + 1) {
                i5++;
            } else {
                b b2 = b(i7, x, i5, bVar.f1190c);
                l(b2, i3);
                a(b2);
                if (bVar.f1188a == 4) {
                    i3 += i5;
                }
                i5 = 1;
                x = x2;
            }
        }
        Object obj = bVar.f1190c;
        a(bVar);
        if (i5 > 0) {
            b b3 = b(bVar.f1188a, x, i5, obj);
            l(b3, i3);
            a(b3);
        }
    }

    private void t(b bVar) {
        this.f1186c.add(bVar);
        int i = bVar.f1188a;
        if (i == 1) {
            this.f1187d.g(bVar.f1189b, bVar.f1191d);
        } else if (i == 2) {
            this.f1187d.e(bVar.f1189b, bVar.f1191d);
        } else if (i == 4) {
            this.f1187d.h(bVar.f1189b, bVar.f1191d, bVar.f1190c);
        } else if (i == 8) {
            this.f1187d.a(bVar.f1189b, bVar.f1191d);
        } else {
            throw new IllegalArgumentException("Unknown update op type for " + bVar);
        }
    }

    private int x(int i, int i2) {
        int i3;
        int i4;
        int i5;
        int i6;
        int i7;
        int i8;
        for (int size = this.f1186c.size() - 1; size >= 0; size--) {
            b bVar = this.f1186c.get(size);
            int i9 = bVar.f1188a;
            if (i9 == 8) {
                int i10 = bVar.f1189b;
                int i11 = bVar.f1191d;
                if (i10 < i11) {
                    i5 = i10;
                    i4 = i11;
                } else {
                    i4 = i10;
                    i5 = i11;
                }
                if (i < i5 || i > i4) {
                    if (i < i10) {
                        if (i2 == 1) {
                            bVar.f1189b = i10 + 1;
                            i6 = i11 + 1;
                        } else if (i2 == 2) {
                            bVar.f1189b = i10 - 1;
                            i6 = i11 - 1;
                        }
                        bVar.f1191d = i6;
                    }
                } else if (i5 == i10) {
                    if (i2 == 1) {
                        i8 = i11 + 1;
                    } else {
                        if (i2 == 2) {
                            i8 = i11 - 1;
                        }
                        i++;
                    }
                    bVar.f1191d = i8;
                    i++;
                } else {
                    if (i2 == 1) {
                        i7 = i10 + 1;
                    } else {
                        if (i2 == 2) {
                            i7 = i10 - 1;
                        }
                        i--;
                    }
                    bVar.f1189b = i7;
                    i--;
                }
            } else {
                int i12 = bVar.f1189b;
                if (i12 > i) {
                    if (i2 == 1) {
                        i3 = i12 + 1;
                    } else if (i2 == 2) {
                        i3 = i12 - 1;
                    }
                    bVar.f1189b = i3;
                } else if (i9 == 1) {
                    i -= bVar.f1191d;
                } else if (i9 == 2) {
                    i += bVar.f1191d;
                }
            }
        }
        for (int size2 = this.f1186c.size() - 1; size2 >= 0; size2--) {
            b bVar2 = this.f1186c.get(size2);
            if (bVar2.f1188a == 8) {
                int i13 = bVar2.f1191d;
                if (i13 != bVar2.f1189b && i13 >= 0) {
                }
                this.f1186c.remove(size2);
                a(bVar2);
            } else {
                if (bVar2.f1191d > 0) {
                }
                this.f1186c.remove(size2);
                a(bVar2);
            }
        }
        return i;
    }

    @Override // androidx.recyclerview.widget.h.a
    public void a(b bVar) {
        if (this.f) {
            return;
        }
        bVar.f1190c = null;
        this.f1184a.a(bVar);
    }

    @Override // androidx.recyclerview.widget.h.a
    public b b(int i, int i2, int i3, Object obj) {
        b b2 = this.f1184a.b();
        if (b2 == null) {
            return new b(i, i2, i3, obj);
        }
        b2.f1188a = i;
        b2.f1189b = i2;
        b2.f1191d = i3;
        b2.f1190c = obj;
        return b2;
    }

    public int e(int i) {
        int size = this.f1185b.size();
        for (int i2 = 0; i2 < size; i2++) {
            b bVar = this.f1185b.get(i2);
            int i3 = bVar.f1188a;
            if (i3 != 1) {
                if (i3 == 2) {
                    int i4 = bVar.f1189b;
                    if (i4 <= i) {
                        int i5 = bVar.f1191d;
                        if (i4 + i5 > i) {
                            return -1;
                        }
                        i -= i5;
                    } else {
                        continue;
                    }
                } else if (i3 == 8) {
                    int i6 = bVar.f1189b;
                    if (i6 == i) {
                        i = bVar.f1191d;
                    } else {
                        if (i6 < i) {
                            i--;
                        }
                        if (bVar.f1191d <= i) {
                            i++;
                        }
                    }
                }
            } else if (bVar.f1189b <= i) {
                i += bVar.f1191d;
            }
        }
        return i;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void i() {
        int size = this.f1186c.size();
        for (int i = 0; i < size; i++) {
            this.f1187d.b(this.f1186c.get(i));
        }
        v(this.f1186c);
        this.h = 0;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void j() {
        i();
        int size = this.f1185b.size();
        for (int i = 0; i < size; i++) {
            b bVar = this.f1185b.get(i);
            int i2 = bVar.f1188a;
            if (i2 == 1) {
                this.f1187d.b(bVar);
                this.f1187d.g(bVar.f1189b, bVar.f1191d);
            } else if (i2 == 2) {
                this.f1187d.b(bVar);
                this.f1187d.d(bVar.f1189b, bVar.f1191d);
            } else if (i2 == 4) {
                this.f1187d.b(bVar);
                this.f1187d.h(bVar.f1189b, bVar.f1191d, bVar.f1190c);
            } else if (i2 == 8) {
                this.f1187d.b(bVar);
                this.f1187d.a(bVar.f1189b, bVar.f1191d);
            }
            Runnable runnable = this.e;
            if (runnable != null) {
                runnable.run();
            }
        }
        v(this.f1185b);
        this.h = 0;
    }

    void l(b bVar, int i) {
        this.f1187d.f(bVar);
        int i2 = bVar.f1188a;
        if (i2 == 2) {
            this.f1187d.d(i, bVar.f1191d);
        } else if (i2 != 4) {
            throw new IllegalArgumentException("only remove and update ops can be dispatched in first pass");
        } else {
            this.f1187d.h(i, bVar.f1191d, bVar.f1190c);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int m(int i) {
        return n(i, 0);
    }

    int n(int i, int i2) {
        int size = this.f1186c.size();
        while (i2 < size) {
            b bVar = this.f1186c.get(i2);
            int i3 = bVar.f1188a;
            if (i3 == 8) {
                int i4 = bVar.f1189b;
                if (i4 == i) {
                    i = bVar.f1191d;
                } else {
                    if (i4 < i) {
                        i--;
                    }
                    if (bVar.f1191d <= i) {
                        i++;
                    }
                }
            } else {
                int i5 = bVar.f1189b;
                if (i5 > i) {
                    continue;
                } else if (i3 == 2) {
                    int i6 = bVar.f1191d;
                    if (i < i5 + i6) {
                        return -1;
                    }
                    i -= i6;
                } else if (i3 == 1) {
                    i += bVar.f1191d;
                }
            }
            i2++;
        }
        return i;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean o(int i) {
        return (i & this.h) != 0;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean p() {
        return this.f1185b.size() > 0;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean q() {
        return (this.f1186c.isEmpty() || this.f1185b.isEmpty()) ? false : true;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean r(int i, int i2, Object obj) {
        if (i2 < 1) {
            return false;
        }
        this.f1185b.add(b(4, i, i2, obj));
        this.h |= 4;
        return this.f1185b.size() == 1;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean s(int i, int i2) {
        if (i2 < 1) {
            return false;
        }
        this.f1185b.add(b(2, i, i2, null));
        this.h |= 2;
        return this.f1185b.size() == 1;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void u() {
        this.g.b(this.f1185b);
        int size = this.f1185b.size();
        for (int i = 0; i < size; i++) {
            b bVar = this.f1185b.get(i);
            int i2 = bVar.f1188a;
            if (i2 == 1) {
                c(bVar);
            } else if (i2 == 2) {
                f(bVar);
            } else if (i2 == 4) {
                g(bVar);
            } else if (i2 == 8) {
                d(bVar);
            }
            Runnable runnable = this.e;
            if (runnable != null) {
                runnable.run();
            }
        }
        this.f1185b.clear();
    }

    void v(List<b> list) {
        int size = list.size();
        for (int i = 0; i < size; i++) {
            a(list.get(i));
        }
        list.clear();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void w() {
        v(this.f1185b);
        v(this.f1186c);
        this.h = 0;
    }
}
