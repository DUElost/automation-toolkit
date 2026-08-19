package androidx.recyclerview.widget;

import android.os.Bundle;
import android.view.View;
import android.view.accessibility.AccessibilityEvent;
/* loaded from: classes.dex */
public class j extends a.f.l.a {

    /* renamed from: c  reason: collision with root package name */
    final RecyclerView f1263c;

    /* renamed from: d  reason: collision with root package name */
    final a.f.l.a f1264d = new a(this);

    /* loaded from: classes.dex */
    public static class a extends a.f.l.a {

        /* renamed from: c  reason: collision with root package name */
        final j f1265c;

        public a(j jVar) {
            this.f1265c = jVar;
        }

        @Override // a.f.l.a
        public void e(View view, a.f.l.a0.c cVar) {
            super.e(view, cVar);
            if (this.f1265c.l() || this.f1265c.f1263c.getLayoutManager() == null) {
                return;
            }
            this.f1265c.f1263c.getLayoutManager().M0(view, cVar);
        }

        @Override // a.f.l.a
        public boolean h(View view, int i, Bundle bundle) {
            if (super.h(view, i, bundle)) {
                return true;
            }
            if (this.f1265c.l() || this.f1265c.f1263c.getLayoutManager() == null) {
                return false;
            }
            return this.f1265c.f1263c.getLayoutManager().f1(view, i, bundle);
        }
    }

    public j(RecyclerView recyclerView) {
        this.f1263c = recyclerView;
    }

    @Override // a.f.l.a
    public void d(View view, AccessibilityEvent accessibilityEvent) {
        super.d(view, accessibilityEvent);
        accessibilityEvent.setClassName(RecyclerView.class.getName());
        if (!(view instanceof RecyclerView) || l()) {
            return;
        }
        RecyclerView recyclerView = (RecyclerView) view;
        if (recyclerView.getLayoutManager() != null) {
            recyclerView.getLayoutManager().I0(accessibilityEvent);
        }
    }

    @Override // a.f.l.a
    public void e(View view, a.f.l.a0.c cVar) {
        super.e(view, cVar);
        cVar.w(RecyclerView.class.getName());
        if (l() || this.f1263c.getLayoutManager() == null) {
            return;
        }
        this.f1263c.getLayoutManager().K0(cVar);
    }

    @Override // a.f.l.a
    public boolean h(View view, int i, Bundle bundle) {
        if (super.h(view, i, bundle)) {
            return true;
        }
        if (l() || this.f1263c.getLayoutManager() == null) {
            return false;
        }
        return this.f1263c.getLayoutManager().d1(i, bundle);
    }

    public a.f.l.a k() {
        return this.f1264d;
    }

    boolean l() {
        return this.f1263c.n0();
    }
}
