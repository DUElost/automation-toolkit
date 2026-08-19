package a.m;

import a.m.a;
import a.m.m;
import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.view.View;
import android.view.ViewGroup;
/* loaded from: classes.dex */
public abstract class i0 extends m {
    private static final String[] L = {"android:visibility:visibility", "android:visibility:parent"};
    private int K = 3;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a extends AnimatorListenerAdapter {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ w f278a;

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ View f279b;

        a(i0 i0Var, w wVar, View view) {
            this.f278a = wVar;
            this.f279b = view;
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            this.f278a.c(this.f279b);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class b extends AnimatorListenerAdapter implements m.f, a.InterfaceC0016a {

        /* renamed from: a  reason: collision with root package name */
        private final View f280a;

        /* renamed from: b  reason: collision with root package name */
        private final int f281b;

        /* renamed from: c  reason: collision with root package name */
        private final ViewGroup f282c;

        /* renamed from: d  reason: collision with root package name */
        private final boolean f283d;
        private boolean e;
        boolean f = false;

        b(View view, int i, boolean z) {
            this.f280a = view;
            this.f281b = i;
            this.f282c = (ViewGroup) view.getParent();
            this.f283d = z;
            f(true);
        }

        private void e() {
            if (!this.f) {
                d0.i(this.f280a, this.f281b);
                ViewGroup viewGroup = this.f282c;
                if (viewGroup != null) {
                    viewGroup.invalidate();
                }
            }
            f(false);
        }

        private void f(boolean z) {
            ViewGroup viewGroup;
            if (!this.f283d || this.e == z || (viewGroup = this.f282c) == null) {
                return;
            }
            this.e = z;
            x.b(viewGroup, z);
        }

        @Override // a.m.m.f
        public void a(m mVar) {
            f(false);
        }

        @Override // a.m.m.f
        public void b(m mVar) {
            f(true);
        }

        @Override // a.m.m.f
        public void c(m mVar) {
        }

        @Override // a.m.m.f
        public void d(m mVar) {
            e();
            mVar.O(this);
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationCancel(Animator animator) {
            this.f = true;
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            e();
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorPauseListener, a.m.a.InterfaceC0016a
        public void onAnimationPause(Animator animator) {
            if (this.f) {
                return;
            }
            d0.i(this.f280a, this.f281b);
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationRepeat(Animator animator) {
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorPauseListener, a.m.a.InterfaceC0016a
        public void onAnimationResume(Animator animator) {
            if (this.f) {
                return;
            }
            d0.i(this.f280a, 0);
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationStart(Animator animator) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class c {

        /* renamed from: a  reason: collision with root package name */
        boolean f284a;

        /* renamed from: b  reason: collision with root package name */
        boolean f285b;

        /* renamed from: c  reason: collision with root package name */
        int f286c;

        /* renamed from: d  reason: collision with root package name */
        int f287d;
        ViewGroup e;
        ViewGroup f;

        c() {
        }
    }

    private void b0(s sVar) {
        sVar.f315a.put("android:visibility:visibility", Integer.valueOf(sVar.f316b.getVisibility()));
        sVar.f315a.put("android:visibility:parent", sVar.f316b.getParent());
        int[] iArr = new int[2];
        sVar.f316b.getLocationOnScreen(iArr);
        sVar.f315a.put("android:visibility:screenLocation", iArr);
    }

    /* JADX WARN: Code restructure failed: missing block: B:24:0x0075, code lost:
        if (r9 == 0) goto L23;
     */
    /* JADX WARN: Code restructure failed: missing block: B:30:0x007f, code lost:
        if (r0.e == null) goto L23;
     */
    /* JADX WARN: Code restructure failed: missing block: B:39:0x0091, code lost:
        if (r0.f286c == 0) goto L25;
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private a.m.i0.c c0(a.m.s r8, a.m.s r9) {
        /*
            r7 = this;
            a.m.i0$c r0 = new a.m.i0$c
            r0.<init>()
            r1 = 0
            r0.f284a = r1
            r0.f285b = r1
            java.lang.String r2 = "android:visibility:parent"
            r3 = 0
            r4 = -1
            java.lang.String r5 = "android:visibility:visibility"
            if (r8 == 0) goto L33
            java.util.Map<java.lang.String, java.lang.Object> r6 = r8.f315a
            boolean r6 = r6.containsKey(r5)
            if (r6 == 0) goto L33
            java.util.Map<java.lang.String, java.lang.Object> r6 = r8.f315a
            java.lang.Object r6 = r6.get(r5)
            java.lang.Integer r6 = (java.lang.Integer) r6
            int r6 = r6.intValue()
            r0.f286c = r6
            java.util.Map<java.lang.String, java.lang.Object> r6 = r8.f315a
            java.lang.Object r6 = r6.get(r2)
            android.view.ViewGroup r6 = (android.view.ViewGroup) r6
            r0.e = r6
            goto L37
        L33:
            r0.f286c = r4
            r0.e = r3
        L37:
            if (r9 == 0) goto L5a
            java.util.Map<java.lang.String, java.lang.Object> r6 = r9.f315a
            boolean r6 = r6.containsKey(r5)
            if (r6 == 0) goto L5a
            java.util.Map<java.lang.String, java.lang.Object> r3 = r9.f315a
            java.lang.Object r3 = r3.get(r5)
            java.lang.Integer r3 = (java.lang.Integer) r3
            int r3 = r3.intValue()
            r0.f287d = r3
            java.util.Map<java.lang.String, java.lang.Object> r3 = r9.f315a
            java.lang.Object r2 = r3.get(r2)
            android.view.ViewGroup r2 = (android.view.ViewGroup) r2
            r0.f = r2
            goto L5e
        L5a:
            r0.f287d = r4
            r0.f = r3
        L5e:
            r2 = 1
            if (r8 == 0) goto L82
            if (r9 == 0) goto L82
            int r8 = r0.f286c
            int r9 = r0.f287d
            if (r8 != r9) goto L70
            android.view.ViewGroup r3 = r0.e
            android.view.ViewGroup r4 = r0.f
            if (r3 != r4) goto L70
            return r0
        L70:
            if (r8 == r9) goto L78
            if (r8 != 0) goto L75
            goto L93
        L75:
            if (r9 != 0) goto L96
            goto L88
        L78:
            android.view.ViewGroup r8 = r0.f
            if (r8 != 0) goto L7d
            goto L93
        L7d:
            android.view.ViewGroup r8 = r0.e
            if (r8 != 0) goto L96
            goto L88
        L82:
            if (r8 != 0) goto L8d
            int r8 = r0.f287d
            if (r8 != 0) goto L8d
        L88:
            r0.f285b = r2
        L8a:
            r0.f284a = r2
            goto L96
        L8d:
            if (r9 != 0) goto L96
            int r8 = r0.f286c
            if (r8 != 0) goto L96
        L93:
            r0.f285b = r1
            goto L8a
        L96:
            return r0
        */
        throw new UnsupportedOperationException("Method not decompiled: a.m.i0.c0(a.m.s, a.m.s):a.m.i0$c");
    }

    @Override // a.m.m
    public String[] C() {
        return L;
    }

    @Override // a.m.m
    public boolean E(s sVar, s sVar2) {
        if (sVar == null && sVar2 == null) {
            return false;
        }
        if (sVar == null || sVar2 == null || sVar2.f315a.containsKey("android:visibility:visibility") == sVar.f315a.containsKey("android:visibility:visibility")) {
            c c0 = c0(sVar, sVar2);
            if (c0.f284a) {
                return c0.f286c == 0 || c0.f287d == 0;
            }
            return false;
        }
        return false;
    }

    public abstract Animator d0(ViewGroup viewGroup, View view, s sVar, s sVar2);

    public Animator e0(ViewGroup viewGroup, s sVar, int i, s sVar2, int i2) {
        if ((this.K & 1) != 1 || sVar2 == null) {
            return null;
        }
        if (sVar == null) {
            View view = (View) sVar2.f316b.getParent();
            if (c0(s(view, false), D(view, false)).f284a) {
                return null;
            }
        }
        return d0(viewGroup, sVar2.f316b, sVar, sVar2);
    }

    @Override // a.m.m
    public void f(s sVar) {
        b0(sVar);
    }

    public abstract Animator f0(ViewGroup viewGroup, View view, s sVar, s sVar2);

    /* JADX WARN: Removed duplicated region for block: B:51:0x0082 A[ADDED_TO_REGION] */
    /* JADX WARN: Removed duplicated region for block: B:58:0x00c9  */
    /* JADX WARN: Removed duplicated region for block: B:63:0x00e9 A[RETURN] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public android.animation.Animator g0(android.view.ViewGroup r7, a.m.s r8, int r9, a.m.s r10, int r11) {
        /*
            Method dump skipped, instructions count: 234
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: a.m.i0.g0(android.view.ViewGroup, a.m.s, int, a.m.s, int):android.animation.Animator");
    }

    public void h0(int i) {
        if ((i & (-4)) != 0) {
            throw new IllegalArgumentException("Only MODE_IN and MODE_OUT flags are allowed");
        }
        this.K = i;
    }

    @Override // a.m.m
    public void i(s sVar) {
        b0(sVar);
    }

    @Override // a.m.m
    public Animator m(ViewGroup viewGroup, s sVar, s sVar2) {
        c c0 = c0(sVar, sVar2);
        if (c0.f284a) {
            if (c0.e == null && c0.f == null) {
                return null;
            }
            return c0.f285b ? e0(viewGroup, sVar, c0.f286c, sVar2, c0.f287d) : g0(viewGroup, sVar, c0.f286c, sVar2, c0.f287d);
        }
        return null;
    }
}
