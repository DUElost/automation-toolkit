package com.google.android.material.behavior;

import a.f.l.r;
import a.h.a.a;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewParent;
import androidx.coordinatorlayout.widget.CoordinatorLayout;
/* loaded from: classes.dex */
public class SwipeDismissBehavior<V extends View> extends CoordinatorLayout.c<V> {

    /* renamed from: a  reason: collision with root package name */
    a.h.a.a f2294a;

    /* renamed from: b  reason: collision with root package name */
    b f2295b;

    /* renamed from: c  reason: collision with root package name */
    private boolean f2296c;
    private boolean e;

    /* renamed from: d  reason: collision with root package name */
    private float f2297d = 0.0f;
    int f = 2;
    float g = 0.5f;
    float h = 0.0f;
    float i = 0.5f;
    private final a.c j = new a();

    /* loaded from: classes.dex */
    class a extends a.c {

        /* renamed from: a  reason: collision with root package name */
        private int f2298a;

        /* renamed from: b  reason: collision with root package name */
        private int f2299b = -1;

        a() {
        }

        private boolean n(View view, float f) {
            int i = (f > 0.0f ? 1 : (f == 0.0f ? 0 : -1));
            if (i == 0) {
                return Math.abs(view.getLeft() - this.f2298a) >= Math.round(((float) view.getWidth()) * SwipeDismissBehavior.this.g);
            }
            boolean z = r.q(view) == 1;
            int i2 = SwipeDismissBehavior.this.f;
            if (i2 == 2) {
                return true;
            }
            if (i2 == 0) {
                if (z) {
                    if (f >= 0.0f) {
                        return false;
                    }
                } else if (i <= 0) {
                    return false;
                }
                return true;
            } else if (i2 == 1) {
                if (z) {
                    if (i <= 0) {
                        return false;
                    }
                } else if (f >= 0.0f) {
                    return false;
                }
                return true;
            } else {
                return false;
            }
        }

        /* JADX WARN: Code restructure failed: missing block: B:10:0x001c, code lost:
            r5 = r2.f2298a;
            r3 = r3.getWidth() + r5;
         */
        /* JADX WARN: Code restructure failed: missing block: B:12:0x0026, code lost:
            if (r5 != false) goto L11;
         */
        /* JADX WARN: Code restructure failed: missing block: B:8:0x0010, code lost:
            if (r5 != false) goto L7;
         */
        /* JADX WARN: Code restructure failed: missing block: B:9:0x0012, code lost:
            r5 = r2.f2298a - r3.getWidth();
            r3 = r2.f2298a;
         */
        @Override // a.h.a.a.c
        /*
            Code decompiled incorrectly, please refer to instructions dump.
            To view partially-correct add '--show-bad-code' argument
        */
        public int a(android.view.View r3, int r4, int r5) {
            /*
                r2 = this;
                int r5 = a.f.l.r.q(r3)
                r0 = 1
                if (r5 != r0) goto L9
                r5 = r0
                goto La
            L9:
                r5 = 0
            La:
                com.google.android.material.behavior.SwipeDismissBehavior r1 = com.google.android.material.behavior.SwipeDismissBehavior.this
                int r1 = r1.f
                if (r1 != 0) goto L24
                if (r5 == 0) goto L1c
            L12:
                int r5 = r2.f2298a
                int r3 = r3.getWidth()
                int r5 = r5 - r3
                int r3 = r2.f2298a
                goto L37
            L1c:
                int r5 = r2.f2298a
                int r3 = r3.getWidth()
                int r3 = r3 + r5
                goto L37
            L24:
                if (r1 != r0) goto L29
                if (r5 == 0) goto L12
                goto L1c
            L29:
                int r5 = r2.f2298a
                int r0 = r3.getWidth()
                int r5 = r5 - r0
                int r0 = r2.f2298a
                int r3 = r3.getWidth()
                int r3 = r3 + r0
            L37:
                int r3 = com.google.android.material.behavior.SwipeDismissBehavior.F(r5, r4, r3)
                return r3
            */
            throw new UnsupportedOperationException("Method not decompiled: com.google.android.material.behavior.SwipeDismissBehavior.a.a(android.view.View, int, int):int");
        }

        @Override // a.h.a.a.c
        public int b(View view, int i, int i2) {
            return view.getTop();
        }

        @Override // a.h.a.a.c
        public int d(View view) {
            return view.getWidth();
        }

        @Override // a.h.a.a.c
        public void i(View view, int i) {
            this.f2299b = i;
            this.f2298a = view.getLeft();
            ViewParent parent = view.getParent();
            if (parent != null) {
                parent.requestDisallowInterceptTouchEvent(true);
            }
        }

        @Override // a.h.a.a.c
        public void j(int i) {
            b bVar = SwipeDismissBehavior.this.f2295b;
            if (bVar != null) {
                bVar.b(i);
            }
        }

        @Override // a.h.a.a.c
        public void k(View view, int i, int i2, int i3, int i4) {
            float width = this.f2298a + (view.getWidth() * SwipeDismissBehavior.this.h);
            float width2 = this.f2298a + (view.getWidth() * SwipeDismissBehavior.this.i);
            float f = i;
            if (f <= width) {
                view.setAlpha(1.0f);
            } else if (f >= width2) {
                view.setAlpha(0.0f);
            } else {
                view.setAlpha(SwipeDismissBehavior.E(0.0f, 1.0f - SwipeDismissBehavior.H(width, width2, f), 1.0f));
            }
        }

        @Override // a.h.a.a.c
        public void l(View view, float f, float f2) {
            int i;
            boolean z;
            b bVar;
            this.f2299b = -1;
            int width = view.getWidth();
            if (n(view, f)) {
                int left = view.getLeft();
                int i2 = this.f2298a;
                i = left < i2 ? i2 - width : i2 + width;
                z = true;
            } else {
                i = this.f2298a;
                z = false;
            }
            if (SwipeDismissBehavior.this.f2294a.F(i, view.getTop())) {
                r.L(view, new c(view, z));
            } else if (!z || (bVar = SwipeDismissBehavior.this.f2295b) == null) {
            } else {
                bVar.a(view);
            }
        }

        @Override // a.h.a.a.c
        public boolean m(View view, int i) {
            return this.f2299b == -1 && SwipeDismissBehavior.this.D(view);
        }
    }

    /* loaded from: classes.dex */
    public interface b {
        void a(View view);

        void b(int i);
    }

    /* loaded from: classes.dex */
    private class c implements Runnable {

        /* renamed from: b  reason: collision with root package name */
        private final View f2301b;

        /* renamed from: c  reason: collision with root package name */
        private final boolean f2302c;

        c(View view, boolean z) {
            this.f2301b = view;
            this.f2302c = z;
        }

        @Override // java.lang.Runnable
        public void run() {
            b bVar;
            a.h.a.a aVar = SwipeDismissBehavior.this.f2294a;
            if (aVar != null && aVar.k(true)) {
                r.L(this.f2301b, this);
            } else if (!this.f2302c || (bVar = SwipeDismissBehavior.this.f2295b) == null) {
            } else {
                bVar.a(this.f2301b);
            }
        }
    }

    static float E(float f, float f2, float f3) {
        return Math.min(Math.max(f, f2), f3);
    }

    static int F(int i, int i2, int i3) {
        return Math.min(Math.max(i, i2), i3);
    }

    private void G(ViewGroup viewGroup) {
        if (this.f2294a == null) {
            this.f2294a = this.e ? a.h.a.a.l(viewGroup, this.f2297d, this.j) : a.h.a.a.m(viewGroup, this.j);
        }
    }

    static float H(float f, float f2, float f3) {
        return (f3 - f) / (f2 - f);
    }

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public boolean C(CoordinatorLayout coordinatorLayout, V v, MotionEvent motionEvent) {
        a.h.a.a aVar = this.f2294a;
        if (aVar != null) {
            aVar.z(motionEvent);
            return true;
        }
        return false;
    }

    public boolean D(View view) {
        return true;
    }

    public void I(float f) {
        this.i = E(0.0f, f, 1.0f);
    }

    public void J(b bVar) {
        this.f2295b = bVar;
    }

    public void K(float f) {
        this.h = E(0.0f, f, 1.0f);
    }

    public void L(int i) {
        this.f = i;
    }

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public boolean k(CoordinatorLayout coordinatorLayout, V v, MotionEvent motionEvent) {
        boolean z = this.f2296c;
        int actionMasked = motionEvent.getActionMasked();
        if (actionMasked == 0) {
            z = coordinatorLayout.A(v, (int) motionEvent.getX(), (int) motionEvent.getY());
            this.f2296c = z;
        } else if (actionMasked == 1 || actionMasked == 3) {
            this.f2296c = false;
        }
        if (z) {
            G(coordinatorLayout);
            return this.f2294a.G(motionEvent);
        }
        return false;
    }
}
