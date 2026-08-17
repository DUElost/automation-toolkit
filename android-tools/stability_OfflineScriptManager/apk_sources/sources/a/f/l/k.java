package a.f.l;

import android.view.View;
import android.view.ViewParent;
/* loaded from: classes.dex */
public class k {

    /* renamed from: a  reason: collision with root package name */
    private ViewParent f188a;

    /* renamed from: b  reason: collision with root package name */
    private ViewParent f189b;

    /* renamed from: c  reason: collision with root package name */
    private final View f190c;

    /* renamed from: d  reason: collision with root package name */
    private boolean f191d;
    private int[] e;

    public k(View view) {
        this.f190c = view;
    }

    private ViewParent g(int i) {
        if (i != 0) {
            if (i != 1) {
                return null;
            }
            return this.f189b;
        }
        return this.f188a;
    }

    private void l(int i, ViewParent viewParent) {
        if (i == 0) {
            this.f188a = viewParent;
        } else if (i != 1) {
        } else {
            this.f189b = viewParent;
        }
    }

    public boolean a(float f, float f2, boolean z) {
        ViewParent g;
        if (!j() || (g = g(0)) == null) {
            return false;
        }
        return u.a(g, this.f190c, f, f2, z);
    }

    public boolean b(float f, float f2) {
        ViewParent g;
        if (!j() || (g = g(0)) == null) {
            return false;
        }
        return u.b(g, this.f190c, f, f2);
    }

    public boolean c(int i, int i2, int[] iArr, int[] iArr2) {
        return d(i, i2, iArr, iArr2, 0);
    }

    public boolean d(int i, int i2, int[] iArr, int[] iArr2, int i3) {
        ViewParent g;
        int i4;
        int i5;
        if (!j() || (g = g(i3)) == null) {
            return false;
        }
        if (i == 0 && i2 == 0) {
            if (iArr2 != null) {
                iArr2[0] = 0;
                iArr2[1] = 0;
                return false;
            }
            return false;
        }
        if (iArr2 != null) {
            this.f190c.getLocationInWindow(iArr2);
            i4 = iArr2[0];
            i5 = iArr2[1];
        } else {
            i4 = 0;
            i5 = 0;
        }
        if (iArr == null) {
            if (this.e == null) {
                this.e = new int[2];
            }
            iArr = this.e;
        }
        iArr[0] = 0;
        iArr[1] = 0;
        u.c(g, this.f190c, i, i2, iArr, i3);
        if (iArr2 != null) {
            this.f190c.getLocationInWindow(iArr2);
            iArr2[0] = iArr2[0] - i4;
            iArr2[1] = iArr2[1] - i5;
        }
        return (iArr[0] == 0 && iArr[1] == 0) ? false : true;
    }

    public boolean e(int i, int i2, int i3, int i4, int[] iArr) {
        return f(i, i2, i3, i4, iArr, 0);
    }

    public boolean f(int i, int i2, int i3, int i4, int[] iArr, int i5) {
        ViewParent g;
        int i6;
        int i7;
        if (!j() || (g = g(i5)) == null) {
            return false;
        }
        if (i == 0 && i2 == 0 && i3 == 0 && i4 == 0) {
            if (iArr != null) {
                iArr[0] = 0;
                iArr[1] = 0;
            }
            return false;
        }
        if (iArr != null) {
            this.f190c.getLocationInWindow(iArr);
            i6 = iArr[0];
            i7 = iArr[1];
        } else {
            i6 = 0;
            i7 = 0;
        }
        u.d(g, this.f190c, i, i2, i3, i4, i5);
        if (iArr != null) {
            this.f190c.getLocationInWindow(iArr);
            iArr[0] = iArr[0] - i6;
            iArr[1] = iArr[1] - i7;
        }
        return true;
    }

    public boolean h() {
        return i(0);
    }

    public boolean i(int i) {
        return g(i) != null;
    }

    public boolean j() {
        return this.f191d;
    }

    public void k(boolean z) {
        if (this.f191d) {
            r.i0(this.f190c);
        }
        this.f191d = z;
    }

    public boolean m(int i) {
        return n(i, 0);
    }

    public boolean n(int i, int i2) {
        if (i(i2)) {
            return true;
        }
        if (j()) {
            View view = this.f190c;
            for (ViewParent parent = this.f190c.getParent(); parent != null; parent = parent.getParent()) {
                if (u.f(parent, view, this.f190c, i, i2)) {
                    l(i2, parent);
                    u.e(parent, view, this.f190c, i, i2);
                    return true;
                }
                if (parent instanceof View) {
                    view = (View) parent;
                }
            }
            return false;
        }
        return false;
    }

    public void o() {
        p(0);
    }

    public void p(int i) {
        ViewParent g = g(i);
        if (g != null) {
            u.g(g, this.f190c, i);
            l(i, null);
        }
    }
}
