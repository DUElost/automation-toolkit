package b.h.a.a.d;

import android.content.Context;
import android.view.ContextThemeWrapper;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.Transformation;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import b.h.a.a.c.a;
/* loaded from: classes.dex */
public class a {

    /* renamed from: a  reason: collision with root package name */
    protected b.h.a.a.c.a f1667a;

    /* renamed from: b  reason: collision with root package name */
    private Context f1668b;

    /* renamed from: c  reason: collision with root package name */
    private boolean f1669c;
    private a.b f;
    private a.c g;
    private boolean h;

    /* renamed from: d  reason: collision with root package name */
    private int f1670d = 0;
    private Class<? extends a.AbstractC0055a> e = b.h.a.a.b.a.class;
    private boolean i = false;
    private boolean j = false;
    private boolean k = true;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: b.h.a.a.d.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public class C0056a extends a.AbstractC0055a {
        final /* synthetic */ LinearLayout f;

        /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
        C0056a(a aVar, Context context, LinearLayout linearLayout) {
            super(context);
            this.f = linearLayout;
        }

        @Override // b.h.a.a.c.a.AbstractC0055a
        public View c(b.h.a.a.c.a aVar, Object obj) {
            return null;
        }

        @Override // b.h.a.a.c.a.AbstractC0055a
        public ViewGroup e() {
            return this.f;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b implements View.OnClickListener {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ b.h.a.a.c.a f1671b;

        b(b.h.a.a.c.a aVar) {
            this.f1671b = aVar;
        }

        /* JADX WARN: Removed duplicated region for block: B:11:0x002f  */
        /* JADX WARN: Removed duplicated region for block: B:13:? A[RETURN, SYNTHETIC] */
        @Override // android.view.View.OnClickListener
        /*
            Code decompiled incorrectly, please refer to instructions dump.
            To view partially-correct add '--show-bad-code' argument
        */
        public void onClick(android.view.View r3) {
            /*
                r2 = this;
                b.h.a.a.c.a r3 = r2.f1671b
                b.h.a.a.c.a$b r3 = r3.e()
                if (r3 == 0) goto L18
                b.h.a.a.c.a r3 = r2.f1671b
                b.h.a.a.c.a$b r3 = r3.e()
            Le:
                b.h.a.a.c.a r0 = r2.f1671b
                java.lang.Object r1 = r0.i()
                r3.a(r0, r1)
                goto L27
            L18:
                b.h.a.a.d.a r3 = b.h.a.a.d.a.this
                b.h.a.a.c.a$b r3 = b.h.a.a.d.a.a(r3)
                if (r3 == 0) goto L27
                b.h.a.a.d.a r3 = b.h.a.a.d.a.this
                b.h.a.a.c.a$b r3 = b.h.a.a.d.a.a(r3)
                goto Le
            L27:
                b.h.a.a.d.a r3 = b.h.a.a.d.a.this
                boolean r3 = b.h.a.a.d.a.b(r3)
                if (r3 == 0) goto L36
                b.h.a.a.d.a r3 = b.h.a.a.d.a.this
                b.h.a.a.c.a r0 = r2.f1671b
                r3.v(r0)
            L36:
                return
            */
            throw new UnsupportedOperationException("Method not decompiled: b.h.a.a.d.a.b.onClick(android.view.View):void");
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class c implements View.OnLongClickListener {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ b.h.a.a.c.a f1673b;

        c(b.h.a.a.c.a aVar) {
            this.f1673b = aVar;
        }

        @Override // android.view.View.OnLongClickListener
        public boolean onLongClick(View view) {
            a.c cVar;
            if (this.f1673b.g() != null) {
                cVar = this.f1673b.g();
            } else if (a.this.g == null) {
                if (a.this.k) {
                    a.this.v(this.f1673b);
                    return false;
                }
                return false;
            } else {
                cVar = a.this.g;
            }
            b.h.a.a.c.a aVar = this.f1673b;
            return cVar.a(aVar, aVar.i());
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class d extends Animation {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ View f1675b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ int f1676c;

        d(View view, int i) {
            this.f1675b = view;
            this.f1676c = i;
        }

        @Override // android.view.animation.Animation
        protected void applyTransformation(float f, Transformation transformation) {
            this.f1675b.getLayoutParams().height = f == 1.0f ? -2 : (int) (this.f1676c * f);
            this.f1675b.requestLayout();
        }

        @Override // android.view.animation.Animation
        public boolean willChangeBounds() {
            return true;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class e extends Animation {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ View f1677b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ int f1678c;

        e(View view, int i) {
            this.f1677b = view;
            this.f1678c = i;
        }

        @Override // android.view.animation.Animation
        protected void applyTransformation(float f, Transformation transformation) {
            if (f == 1.0f) {
                this.f1677b.setVisibility(8);
                return;
            }
            ViewGroup.LayoutParams layoutParams = this.f1677b.getLayoutParams();
            int i = this.f1678c;
            layoutParams.height = i - ((int) (i * f));
            this.f1677b.requestLayout();
        }

        @Override // android.view.animation.Animation
        public boolean willChangeBounds() {
            return true;
        }
    }

    public a(Context context, b.h.a.a.c.a aVar) {
        this.f1667a = aVar;
        this.f1668b = context;
    }

    private void d(ViewGroup viewGroup, b.h.a.a.c.a aVar) {
        a.AbstractC0055a o = o(aVar);
        View h = o.h();
        viewGroup.addView(h);
        boolean z = this.h;
        if (z) {
            o.m(z);
        }
        h.setOnClickListener(new b(aVar));
        h.setOnLongClickListener(new c(aVar));
    }

    private static void e(View view) {
        int measuredHeight = view.getMeasuredHeight();
        e eVar = new e(view, measuredHeight);
        eVar.setDuration((int) (measuredHeight / view.getContext().getResources().getDisplayMetrics().density));
        view.startAnimation(eVar);
    }

    private void g(b.h.a.a.c.a aVar, boolean z) {
        aVar.q(false);
        a.AbstractC0055a o = o(aVar);
        if (this.i) {
            e(o.e());
        } else {
            o.e().setVisibility(8);
        }
        o.l(false);
        if (z) {
            for (b.h.a.a.c.a aVar2 : aVar.d()) {
                g(aVar2, z);
            }
        }
    }

    private static void i(View view) {
        view.measure(-1, -2);
        int measuredHeight = view.getMeasuredHeight();
        view.getLayoutParams().height = 0;
        view.setVisibility(0);
        d dVar = new d(view, measuredHeight);
        dVar.setDuration((int) (measuredHeight / view.getContext().getResources().getDisplayMetrics().density));
        view.startAnimation(dVar);
    }

    private void l(b.h.a.a.c.a aVar, boolean z) {
        aVar.q(true);
        a.AbstractC0055a o = o(aVar);
        o.e().removeAllViews();
        o.l(true);
        for (b.h.a.a.c.a aVar2 : aVar.d()) {
            d(o.e(), aVar2);
            if (aVar2.k() || z) {
                l(aVar2, z);
            }
        }
        if (this.i) {
            i(o.e());
        } else {
            o.e().setVisibility(0);
        }
    }

    private a.AbstractC0055a o(b.h.a.a.c.a aVar) {
        a.AbstractC0055a j = aVar.j();
        if (j == null) {
            try {
                j = this.e.getConstructor(Context.class).newInstance(this.f1668b);
                aVar.u(j);
            } catch (Exception unused) {
                throw new RuntimeException("Could not instantiate class " + this.e);
            }
        }
        if (j.d() <= 0) {
            j.j(this.f1670d);
        }
        if (j.g() == null) {
            j.k(this);
        }
        return j;
    }

    private void q(boolean z, boolean z2) {
        if (this.h) {
            for (b.h.a.a.c.a aVar : this.f1667a.d()) {
                t(aVar, z, z2);
            }
        }
    }

    private void t(b.h.a.a.c.a aVar, boolean z, boolean z2) {
        aVar.t(z);
        x(aVar, true);
        if (z2 ? aVar.k() : true) {
            for (b.h.a.a.c.a aVar2 : aVar.d()) {
                t(aVar2, z, z2);
            }
        }
    }

    private void w(b.h.a.a.c.a aVar, boolean z) {
        x(aVar, z);
        if (aVar.k()) {
            for (b.h.a.a.c.a aVar2 : aVar.d()) {
                w(aVar2, z);
            }
        }
    }

    private void x(b.h.a.a.c.a aVar, boolean z) {
        if (o(aVar).i()) {
            o(aVar).m(z);
        }
    }

    public void f() {
        for (b.h.a.a.c.a aVar : this.f1667a.d()) {
            g(aVar, true);
        }
    }

    public void h() {
        q(false, false);
    }

    public void j() {
        l(this.f1667a, true);
    }

    public void k(b.h.a.a.c.a aVar) {
        l(aVar, false);
    }

    public View m() {
        return n(-1);
    }

    public View n(int i) {
        FrameLayout cVar;
        if (i > 0) {
            ContextThemeWrapper contextThemeWrapper = new ContextThemeWrapper(this.f1668b, i);
            cVar = this.j ? new b.h.a.a.d.c(contextThemeWrapper) : new ScrollView(contextThemeWrapper);
        } else {
            cVar = this.j ? new b.h.a.a.d.c(this.f1668b) : new ScrollView(this.f1668b);
        }
        Context context = this.f1668b;
        if (this.f1670d != 0 && this.f1669c) {
            context = new ContextThemeWrapper(this.f1668b, this.f1670d);
        }
        LinearLayout linearLayout = new LinearLayout(context, null, this.f1670d);
        linearLayout.setId(b.h.a.a.a.tree_items);
        linearLayout.setOrientation(1);
        cVar.addView(linearLayout);
        this.f1667a.u(new C0056a(this, this.f1668b, linearLayout));
        l(this.f1667a, false);
        return cVar;
    }

    public boolean p() {
        return this.h;
    }

    public void r(boolean z) {
        q(true, z);
    }

    public void s(b.h.a.a.c.a aVar, boolean z) {
        if (this.h) {
            aVar.t(z);
            x(aVar, true);
        }
    }

    public void u(boolean z) {
        if (!z) {
            h();
        }
        this.h = z;
        for (b.h.a.a.c.a aVar : this.f1667a.d()) {
            w(aVar, z);
        }
    }

    public void v(b.h.a.a.c.a aVar) {
        if (aVar.k()) {
            g(aVar, false);
        } else {
            l(aVar, false);
        }
    }
}
