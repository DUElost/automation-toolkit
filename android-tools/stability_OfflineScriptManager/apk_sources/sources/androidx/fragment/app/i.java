package androidx.fragment.app;

import android.os.Parcelable;
import android.view.View;
import android.view.ViewGroup;
/* loaded from: classes.dex */
public abstract class i extends androidx.viewpager.widget.a {

    /* renamed from: b  reason: collision with root package name */
    private final f f1008b;

    /* renamed from: c  reason: collision with root package name */
    private j f1009c = null;

    /* renamed from: d  reason: collision with root package name */
    private Fragment f1010d = null;

    public i(f fVar) {
        this.f1008b = fVar;
    }

    private static String r(int i, long j) {
        return "android:switcher:" + i + ":" + j;
    }

    @Override // androidx.viewpager.widget.a
    public void a(ViewGroup viewGroup, int i, Object obj) {
        if (this.f1009c == null) {
            this.f1009c = this.f1008b.a();
        }
        this.f1009c.g((Fragment) obj);
    }

    @Override // androidx.viewpager.widget.a
    public void b(ViewGroup viewGroup) {
        j jVar = this.f1009c;
        if (jVar != null) {
            jVar.f();
            this.f1009c = null;
        }
    }

    @Override // androidx.viewpager.widget.a
    public Object g(ViewGroup viewGroup, int i) {
        if (this.f1009c == null) {
            this.f1009c = this.f1008b.a();
        }
        long q = q(i);
        Fragment d2 = this.f1008b.d(r(viewGroup.getId(), q));
        if (d2 != null) {
            this.f1009c.d(d2);
        } else {
            d2 = p(i);
            this.f1009c.b(viewGroup.getId(), d2, r(viewGroup.getId(), q));
        }
        if (d2 != this.f1010d) {
            d2.c1(false);
            d2.h1(false);
        }
        return d2;
    }

    @Override // androidx.viewpager.widget.a
    public boolean h(View view, Object obj) {
        return ((Fragment) obj).F() == view;
    }

    @Override // androidx.viewpager.widget.a
    public void j(Parcelable parcelable, ClassLoader classLoader) {
    }

    @Override // androidx.viewpager.widget.a
    public Parcelable k() {
        return null;
    }

    @Override // androidx.viewpager.widget.a
    public void l(ViewGroup viewGroup, int i, Object obj) {
        Fragment fragment = (Fragment) obj;
        Fragment fragment2 = this.f1010d;
        if (fragment != fragment2) {
            if (fragment2 != null) {
                fragment2.c1(false);
                this.f1010d.h1(false);
            }
            fragment.c1(true);
            fragment.h1(true);
            this.f1010d = fragment;
        }
    }

    @Override // androidx.viewpager.widget.a
    public void n(ViewGroup viewGroup) {
        if (viewGroup.getId() != -1) {
            return;
        }
        throw new IllegalStateException("ViewPager with adapter " + this + " requires a view id");
    }

    public abstract Fragment p(int i);

    public long q(int i) {
        return i;
    }
}
