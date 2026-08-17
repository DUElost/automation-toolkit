package a.a.m;

import a.f.l.v;
import a.f.l.w;
import a.f.l.x;
import android.view.View;
import android.view.animation.Interpolator;
import java.util.ArrayList;
import java.util.Iterator;
/* loaded from: classes.dex */
public class h {

    /* renamed from: c  reason: collision with root package name */
    private Interpolator f49c;

    /* renamed from: d  reason: collision with root package name */
    w f50d;
    private boolean e;

    /* renamed from: b  reason: collision with root package name */
    private long f48b = -1;
    private final x f = new a();

    /* renamed from: a  reason: collision with root package name */
    final ArrayList<v> f47a = new ArrayList<>();

    /* loaded from: classes.dex */
    class a extends x {

        /* renamed from: a  reason: collision with root package name */
        private boolean f51a = false;

        /* renamed from: b  reason: collision with root package name */
        private int f52b = 0;

        a() {
        }

        @Override // a.f.l.w
        public void a(View view) {
            int i = this.f52b + 1;
            this.f52b = i;
            if (i == h.this.f47a.size()) {
                w wVar = h.this.f50d;
                if (wVar != null) {
                    wVar.a(null);
                }
                d();
            }
        }

        @Override // a.f.l.x, a.f.l.w
        public void b(View view) {
            if (this.f51a) {
                return;
            }
            this.f51a = true;
            w wVar = h.this.f50d;
            if (wVar != null) {
                wVar.b(null);
            }
        }

        void d() {
            this.f52b = 0;
            this.f51a = false;
            h.this.b();
        }
    }

    public void a() {
        if (this.e) {
            Iterator<v> it = this.f47a.iterator();
            while (it.hasNext()) {
                it.next().b();
            }
            this.e = false;
        }
    }

    void b() {
        this.e = false;
    }

    public h c(v vVar) {
        if (!this.e) {
            this.f47a.add(vVar);
        }
        return this;
    }

    public h d(v vVar, v vVar2) {
        this.f47a.add(vVar);
        vVar2.h(vVar.c());
        this.f47a.add(vVar2);
        return this;
    }

    public h e(long j) {
        if (!this.e) {
            this.f48b = j;
        }
        return this;
    }

    public h f(Interpolator interpolator) {
        if (!this.e) {
            this.f49c = interpolator;
        }
        return this;
    }

    public h g(w wVar) {
        if (!this.e) {
            this.f50d = wVar;
        }
        return this;
    }

    public void h() {
        if (this.e) {
            return;
        }
        Iterator<v> it = this.f47a.iterator();
        while (it.hasNext()) {
            v next = it.next();
            long j = this.f48b;
            if (j >= 0) {
                next.d(j);
            }
            Interpolator interpolator = this.f49c;
            if (interpolator != null) {
                next.e(interpolator);
            }
            if (this.f50d != null) {
                next.f(this.f);
            }
            next.j();
        }
        this.e = true;
    }
}
