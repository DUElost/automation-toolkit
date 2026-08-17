package androidx.recyclerview.widget;

import android.view.View;
/* loaded from: classes.dex */
class m {

    /* renamed from: a  reason: collision with root package name */
    final b f1266a;

    /* renamed from: b  reason: collision with root package name */
    a f1267b = new a();

    /* loaded from: classes.dex */
    static class a {

        /* renamed from: a  reason: collision with root package name */
        int f1268a = 0;

        /* renamed from: b  reason: collision with root package name */
        int f1269b;

        /* renamed from: c  reason: collision with root package name */
        int f1270c;

        /* renamed from: d  reason: collision with root package name */
        int f1271d;
        int e;

        a() {
        }

        void a(int i) {
            this.f1268a = i | this.f1268a;
        }

        boolean b() {
            int i = this.f1268a;
            if ((i & 7) == 0 || (i & (c(this.f1271d, this.f1269b) << 0)) != 0) {
                int i2 = this.f1268a;
                if ((i2 & 112) == 0 || (i2 & (c(this.f1271d, this.f1270c) << 4)) != 0) {
                    int i3 = this.f1268a;
                    if ((i3 & 1792) == 0 || (i3 & (c(this.e, this.f1269b) << 8)) != 0) {
                        int i4 = this.f1268a;
                        return (i4 & 28672) == 0 || (i4 & (c(this.e, this.f1270c) << 12)) != 0;
                    }
                    return false;
                }
                return false;
            }
            return false;
        }

        int c(int i, int i2) {
            if (i > i2) {
                return 1;
            }
            return i == i2 ? 2 : 4;
        }

        void d() {
            this.f1268a = 0;
        }

        void e(int i, int i2, int i3, int i4) {
            this.f1269b = i;
            this.f1270c = i2;
            this.f1271d = i3;
            this.e = i4;
        }
    }

    /* loaded from: classes.dex */
    interface b {
        View a(int i);

        int b();

        int c();

        int d(View view);

        int e(View view);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public m(b bVar) {
        this.f1266a = bVar;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public View a(int i, int i2, int i3, int i4) {
        int c2 = this.f1266a.c();
        int b2 = this.f1266a.b();
        int i5 = i2 > i ? 1 : -1;
        View view = null;
        while (i != i2) {
            View a2 = this.f1266a.a(i);
            this.f1267b.e(c2, b2, this.f1266a.e(a2), this.f1266a.d(a2));
            if (i3 != 0) {
                this.f1267b.d();
                this.f1267b.a(i3);
                if (this.f1267b.b()) {
                    return a2;
                }
            }
            if (i4 != 0) {
                this.f1267b.d();
                this.f1267b.a(i4);
                if (this.f1267b.b()) {
                    view = a2;
                }
            }
            i += i5;
        }
        return view;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean b(View view, int i) {
        this.f1267b.e(this.f1266a.c(), this.f1266a.b(), this.f1266a.e(view), this.f1266a.d(view));
        if (i != 0) {
            this.f1267b.d();
            this.f1267b.a(i);
            return this.f1267b.b();
        }
        return false;
    }
}
