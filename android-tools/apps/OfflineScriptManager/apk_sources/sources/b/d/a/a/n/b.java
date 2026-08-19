package b.d.a.a.n;

import android.os.Bundle;
import android.view.View;
import android.view.ViewParent;
import androidx.coordinatorlayout.widget.CoordinatorLayout;
/* loaded from: classes.dex */
public final class b {

    /* renamed from: a  reason: collision with root package name */
    private final View f1502a;

    /* renamed from: b  reason: collision with root package name */
    private boolean f1503b = false;

    /* renamed from: c  reason: collision with root package name */
    private int f1504c = 0;

    public b(a aVar) {
        this.f1502a = (View) aVar;
    }

    private void a() {
        ViewParent parent = this.f1502a.getParent();
        if (parent instanceof CoordinatorLayout) {
            ((CoordinatorLayout) parent).f(this.f1502a);
        }
    }

    public int b() {
        return this.f1504c;
    }

    public boolean c() {
        return this.f1503b;
    }

    public void d(Bundle bundle) {
        this.f1503b = bundle.getBoolean("expanded", false);
        this.f1504c = bundle.getInt("expandedComponentIdHint", 0);
        if (this.f1503b) {
            a();
        }
    }

    public Bundle e() {
        Bundle bundle = new Bundle();
        bundle.putBoolean("expanded", this.f1503b);
        bundle.putInt("expandedComponentIdHint", this.f1504c);
        return bundle;
    }

    public void f(int i) {
        this.f1504c = i;
    }
}
