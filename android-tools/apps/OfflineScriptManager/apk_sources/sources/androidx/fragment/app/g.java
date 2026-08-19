package androidx.fragment.app;

import a.f.l.r;
import android.animation.Animator;
import android.animation.AnimatorInflater;
import android.animation.AnimatorListenerAdapter;
import android.animation.AnimatorSet;
import android.animation.PropertyValuesHolder;
import android.animation.ValueAnimator;
import android.content.Context;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.os.Build;
import android.os.Bundle;
import android.os.Looper;
import android.os.Parcelable;
import android.util.AttributeSet;
import android.util.Log;
import android.util.SparseArray;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.AccelerateInterpolator;
import android.view.animation.AlphaAnimation;
import android.view.animation.Animation;
import android.view.animation.AnimationSet;
import android.view.animation.AnimationUtils;
import android.view.animation.DecelerateInterpolator;
import android.view.animation.Interpolator;
import android.view.animation.ScaleAnimation;
import android.view.animation.Transformation;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.f;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public final class g extends androidx.fragment.app.f implements LayoutInflater.Factory2 {
    static boolean F = false;
    static Field G;
    static final Interpolator H = new DecelerateInterpolator(2.5f);
    static final Interpolator I = new DecelerateInterpolator(1.5f);
    ArrayList<n> C;
    androidx.fragment.app.h D;

    /* renamed from: b  reason: collision with root package name */
    ArrayList<l> f971b;

    /* renamed from: c  reason: collision with root package name */
    boolean f972c;
    SparseArray<Fragment> f;
    ArrayList<androidx.fragment.app.a> g;
    ArrayList<Fragment> h;
    ArrayList<androidx.fragment.app.a> i;
    ArrayList<Integer> j;
    ArrayList<f.b> k;
    androidx.fragment.app.e n;
    androidx.fragment.app.c o;
    Fragment p;
    Fragment q;
    boolean r;
    boolean s;
    boolean t;
    boolean u;
    String v;
    boolean w;
    ArrayList<androidx.fragment.app.a> x;
    ArrayList<Boolean> y;
    ArrayList<Fragment> z;

    /* renamed from: d  reason: collision with root package name */
    int f973d = 0;
    final ArrayList<Fragment> e = new ArrayList<>();
    private final CopyOnWriteArrayList<j> l = new CopyOnWriteArrayList<>();
    int m = 0;
    Bundle A = null;
    SparseArray<Parcelable> B = null;
    Runnable E = new a();

    /* loaded from: classes.dex */
    class a implements Runnable {
        a() {
        }

        @Override // java.lang.Runnable
        public void run() {
            g.this.h0();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b extends f {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ ViewGroup f975b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ Fragment f976c;

        /* loaded from: classes.dex */
        class a implements Runnable {
            a() {
            }

            @Override // java.lang.Runnable
            public void run() {
                if (b.this.f976c.i() != null) {
                    b.this.f976c.X0(null);
                    b bVar = b.this;
                    g gVar = g.this;
                    Fragment fragment = bVar.f976c;
                    gVar.J0(fragment, fragment.C(), 0, 0, false);
                }
            }
        }

        /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
        b(Animation.AnimationListener animationListener, ViewGroup viewGroup, Fragment fragment) {
            super(animationListener);
            this.f975b = viewGroup;
            this.f976c = fragment;
        }

        @Override // androidx.fragment.app.g.f, android.view.animation.Animation.AnimationListener
        public void onAnimationEnd(Animation animation) {
            super.onAnimationEnd(animation);
            this.f975b.post(new a());
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class c extends AnimatorListenerAdapter {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ ViewGroup f979a;

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ View f980b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ Fragment f981c;

        c(ViewGroup viewGroup, View view, Fragment fragment) {
            this.f979a = viewGroup;
            this.f980b = view;
            this.f981c = fragment;
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            this.f979a.endViewTransition(this.f980b);
            Animator j = this.f981c.j();
            this.f981c.Y0(null);
            if (j == null || this.f979a.indexOfChild(this.f980b) >= 0) {
                return;
            }
            g gVar = g.this;
            Fragment fragment = this.f981c;
            gVar.J0(fragment, fragment.C(), 0, 0, false);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class d extends AnimatorListenerAdapter {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ ViewGroup f983a;

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ View f984b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ Fragment f985c;

        d(g gVar, ViewGroup viewGroup, View view, Fragment fragment) {
            this.f983a = viewGroup;
            this.f984b = view;
            this.f985c = fragment;
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            this.f983a.endViewTransition(this.f984b);
            animator.removeListener(this);
            View view = this.f985c.J;
            if (view != null) {
                view.setVisibility(8);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class e extends f {

        /* renamed from: b  reason: collision with root package name */
        View f986b;

        /* loaded from: classes.dex */
        class a implements Runnable {
            a() {
            }

            @Override // java.lang.Runnable
            public void run() {
                e.this.f986b.setLayerType(0, null);
            }
        }

        e(View view, Animation.AnimationListener animationListener) {
            super(animationListener);
            this.f986b = view;
        }

        @Override // androidx.fragment.app.g.f, android.view.animation.Animation.AnimationListener
        public void onAnimationEnd(Animation animation) {
            if (r.D(this.f986b) || Build.VERSION.SDK_INT >= 24) {
                this.f986b.post(new a());
            } else {
                this.f986b.setLayerType(0, null);
            }
            super.onAnimationEnd(animation);
        }
    }

    /* loaded from: classes.dex */
    private static class f implements Animation.AnimationListener {

        /* renamed from: a  reason: collision with root package name */
        private final Animation.AnimationListener f988a;

        f(Animation.AnimationListener animationListener) {
            this.f988a = animationListener;
        }

        @Override // android.view.animation.Animation.AnimationListener
        public void onAnimationEnd(Animation animation) {
            Animation.AnimationListener animationListener = this.f988a;
            if (animationListener != null) {
                animationListener.onAnimationEnd(animation);
            }
        }

        @Override // android.view.animation.Animation.AnimationListener
        public void onAnimationRepeat(Animation animation) {
            Animation.AnimationListener animationListener = this.f988a;
            if (animationListener != null) {
                animationListener.onAnimationRepeat(animation);
            }
        }

        @Override // android.view.animation.Animation.AnimationListener
        public void onAnimationStart(Animation animation) {
            Animation.AnimationListener animationListener = this.f988a;
            if (animationListener != null) {
                animationListener.onAnimationStart(animation);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* renamed from: androidx.fragment.app.g$g  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public static class C0036g {

        /* renamed from: a  reason: collision with root package name */
        public final Animation f989a;

        /* renamed from: b  reason: collision with root package name */
        public final Animator f990b;

        C0036g(Animator animator) {
            this.f989a = null;
            this.f990b = animator;
            if (animator == null) {
                throw new IllegalStateException("Animator cannot be null");
            }
        }

        C0036g(Animation animation) {
            this.f989a = animation;
            this.f990b = null;
            if (animation == null) {
                throw new IllegalStateException("Animation cannot be null");
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class h extends AnimatorListenerAdapter {

        /* renamed from: a  reason: collision with root package name */
        View f991a;

        h(View view) {
            this.f991a = view;
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            this.f991a.setLayerType(0, null);
            animator.removeListener(this);
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationStart(Animator animator) {
            this.f991a.setLayerType(2, null);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class i extends AnimationSet implements Runnable {

        /* renamed from: b  reason: collision with root package name */
        private final ViewGroup f992b;

        /* renamed from: c  reason: collision with root package name */
        private final View f993c;

        /* renamed from: d  reason: collision with root package name */
        private boolean f994d;
        private boolean e;
        private boolean f;

        i(Animation animation, ViewGroup viewGroup, View view) {
            super(false);
            this.f = true;
            this.f992b = viewGroup;
            this.f993c = view;
            addAnimation(animation);
            viewGroup.post(this);
        }

        @Override // android.view.animation.AnimationSet, android.view.animation.Animation
        public boolean getTransformation(long j, Transformation transformation) {
            this.f = true;
            if (this.f994d) {
                return !this.e;
            }
            if (!super.getTransformation(j, transformation)) {
                this.f994d = true;
                androidx.fragment.app.n.a(this.f992b, this);
            }
            return true;
        }

        @Override // android.view.animation.Animation
        public boolean getTransformation(long j, Transformation transformation, float f) {
            this.f = true;
            if (this.f994d) {
                return !this.e;
            }
            if (!super.getTransformation(j, transformation, f)) {
                this.f994d = true;
                androidx.fragment.app.n.a(this.f992b, this);
            }
            return true;
        }

        @Override // java.lang.Runnable
        public void run() {
            if (this.f994d || !this.f) {
                this.f992b.endViewTransition(this.f993c);
                this.e = true;
                return;
            }
            this.f = false;
            this.f992b.post(this);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static final class j {

        /* renamed from: a  reason: collision with root package name */
        final f.a f995a;

        /* renamed from: b  reason: collision with root package name */
        final boolean f996b;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class k {

        /* renamed from: a  reason: collision with root package name */
        public static final int[] f997a = {16842755, 16842960, 16842961};
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public interface l {
        boolean a(ArrayList<androidx.fragment.app.a> arrayList, ArrayList<Boolean> arrayList2);
    }

    /* loaded from: classes.dex */
    private class m implements l {

        /* renamed from: a  reason: collision with root package name */
        final String f998a;

        /* renamed from: b  reason: collision with root package name */
        final int f999b;

        /* renamed from: c  reason: collision with root package name */
        final int f1000c;

        m(String str, int i, int i2) {
            this.f998a = str;
            this.f999b = i;
            this.f1000c = i2;
        }

        @Override // androidx.fragment.app.g.l
        public boolean a(ArrayList<androidx.fragment.app.a> arrayList, ArrayList<Boolean> arrayList2) {
            androidx.fragment.app.f y0;
            Fragment fragment = g.this.q;
            if (fragment == null || this.f999b >= 0 || this.f998a != null || (y0 = fragment.y0()) == null || !y0.i()) {
                return g.this.N0(arrayList, arrayList2, this.f998a, this.f999b, this.f1000c);
            }
            return false;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class n implements Fragment.f {

        /* renamed from: a  reason: collision with root package name */
        final boolean f1002a;

        /* renamed from: b  reason: collision with root package name */
        final androidx.fragment.app.a f1003b;

        /* renamed from: c  reason: collision with root package name */
        private int f1004c;

        n(androidx.fragment.app.a aVar, boolean z) {
            this.f1002a = z;
            this.f1003b = aVar;
        }

        @Override // androidx.fragment.app.Fragment.f
        public void a() {
            int i = this.f1004c - 1;
            this.f1004c = i;
            if (i != 0) {
                return;
            }
            this.f1003b.f952a.a1();
        }

        @Override // androidx.fragment.app.Fragment.f
        public void b() {
            this.f1004c++;
        }

        public void c() {
            androidx.fragment.app.a aVar = this.f1003b;
            aVar.f952a.t(aVar, this.f1002a, false, false);
        }

        public void d() {
            boolean z = this.f1004c > 0;
            g gVar = this.f1003b.f952a;
            int size = gVar.e.size();
            for (int i = 0; i < size; i++) {
                Fragment fragment = gVar.e.get(i);
                fragment.f1(null);
                if (z && fragment.O()) {
                    fragment.k1();
                }
            }
            androidx.fragment.app.a aVar = this.f1003b;
            aVar.f952a.t(aVar, this.f1002a, !z, true);
        }

        public boolean e() {
            return this.f1004c == 0;
        }
    }

    static {
        new AccelerateInterpolator(2.5f);
        new AccelerateInterpolator(1.5f);
    }

    static C0036g A0(Context context, float f2, float f3) {
        AlphaAnimation alphaAnimation = new AlphaAnimation(f2, f3);
        alphaAnimation.setInterpolator(I);
        alphaAnimation.setDuration(220L);
        return new C0036g(alphaAnimation);
    }

    static C0036g C0(Context context, float f2, float f3, float f4, float f5) {
        AnimationSet animationSet = new AnimationSet(false);
        ScaleAnimation scaleAnimation = new ScaleAnimation(f2, f3, f2, f3, 1, 0.5f, 1, 0.5f);
        scaleAnimation.setInterpolator(H);
        scaleAnimation.setDuration(220L);
        animationSet.addAnimation(scaleAnimation);
        AlphaAnimation alphaAnimation = new AlphaAnimation(f4, f5);
        alphaAnimation.setInterpolator(I);
        alphaAnimation.setDuration(220L);
        animationSet.addAnimation(alphaAnimation);
        return new C0036g(animationSet);
    }

    private void D0(a.d.b<Fragment> bVar) {
        int size = bVar.size();
        for (int i2 = 0; i2 < size; i2++) {
            Fragment h2 = bVar.h(i2);
            if (!h2.l) {
                View F2 = h2.F();
                h2.Q = F2.getAlpha();
                F2.setAlpha(0.0f);
            }
        }
    }

    static boolean E0(Animator animator) {
        if (animator == null) {
            return false;
        }
        if (animator instanceof ValueAnimator) {
            for (PropertyValuesHolder propertyValuesHolder : ((ValueAnimator) animator).getValues()) {
                if ("alpha".equals(propertyValuesHolder.getPropertyName())) {
                    return true;
                }
            }
        } else if (animator instanceof AnimatorSet) {
            ArrayList<Animator> childAnimations = ((AnimatorSet) animator).getChildAnimations();
            for (int i2 = 0; i2 < childAnimations.size(); i2++) {
                if (E0(childAnimations.get(i2))) {
                    return true;
                }
            }
        }
        return false;
    }

    static boolean F0(C0036g c0036g) {
        Animation animation = c0036g.f989a;
        if (animation instanceof AlphaAnimation) {
            return true;
        }
        if (animation instanceof AnimationSet) {
            List<Animation> animations = ((AnimationSet) animation).getAnimations();
            for (int i2 = 0; i2 < animations.size(); i2++) {
                if (animations.get(i2) instanceof AlphaAnimation) {
                    return true;
                }
            }
            return false;
        }
        return E0(c0036g.f990b);
    }

    private boolean M0(String str, int i2, int i3) {
        androidx.fragment.app.f y0;
        h0();
        f0(true);
        Fragment fragment = this.q;
        if (fragment == null || i2 >= 0 || str != null || (y0 = fragment.y0()) == null || !y0.i()) {
            boolean N0 = N0(this.x, this.y, str, i2, i3);
            if (N0) {
                this.f972c = true;
                try {
                    R0(this.x, this.y);
                } finally {
                    s();
                }
            }
            c0();
            q();
            return N0;
        }
        return true;
    }

    private int O0(ArrayList<androidx.fragment.app.a> arrayList, ArrayList<Boolean> arrayList2, int i2, int i3, a.d.b<Fragment> bVar) {
        int i4 = i3;
        for (int i5 = i3 - 1; i5 >= i2; i5--) {
            androidx.fragment.app.a aVar = arrayList.get(i5);
            boolean booleanValue = arrayList2.get(i5).booleanValue();
            if (aVar.x() && !aVar.v(arrayList, i5 + 1, i3)) {
                if (this.C == null) {
                    this.C = new ArrayList<>();
                }
                n nVar = new n(aVar, booleanValue);
                this.C.add(nVar);
                aVar.z(nVar);
                if (booleanValue) {
                    aVar.q();
                } else {
                    aVar.r(false);
                }
                i4--;
                if (i5 != i4) {
                    arrayList.remove(i5);
                    arrayList.add(i4, aVar);
                }
                j(bVar);
            }
        }
        return i4;
    }

    private void R0(ArrayList<androidx.fragment.app.a> arrayList, ArrayList<Boolean> arrayList2) {
        if (arrayList == null || arrayList.isEmpty()) {
            return;
        }
        if (arrayList2 == null || arrayList.size() != arrayList2.size()) {
            throw new IllegalStateException("Internal error with the back stack records");
        }
        l0(arrayList, arrayList2);
        int size = arrayList.size();
        int i2 = 0;
        int i3 = 0;
        while (i2 < size) {
            if (!arrayList.get(i2).t) {
                if (i3 != i2) {
                    k0(arrayList, arrayList2, i3, i2);
                }
                i3 = i2 + 1;
                if (arrayList2.get(i2).booleanValue()) {
                    while (i3 < size && arrayList2.get(i3).booleanValue() && !arrayList.get(i3).t) {
                        i3++;
                    }
                }
                k0(arrayList, arrayList2, i2, i3);
                i2 = i3 - 1;
            }
            i2++;
        }
        if (i3 != size) {
            k0(arrayList, arrayList2, i3, size);
        }
    }

    public static int V0(int i2) {
        if (i2 != 4097) {
            if (i2 != 4099) {
                return i2 != 8194 ? 0 : 4097;
            }
            return 4099;
        }
        return 8194;
    }

    private void a0(int i2) {
        try {
            this.f972c = true;
            H0(i2, false);
            this.f972c = false;
            h0();
        } catch (Throwable th) {
            this.f972c = false;
            throw th;
        }
    }

    private static void c1(View view, C0036g c0036g) {
        if (view == null || c0036g == null || !f1(view, c0036g)) {
            return;
        }
        Animator animator = c0036g.f990b;
        if (animator != null) {
            animator.addListener(new h(view));
            return;
        }
        Animation.AnimationListener s0 = s0(c0036g.f989a);
        view.setLayerType(2, null);
        c0036g.f989a.setAnimationListener(new e(view, s0));
    }

    private void d0() {
        SparseArray<Fragment> sparseArray = this.f;
        int size = sparseArray == null ? 0 : sparseArray.size();
        for (int i2 = 0; i2 < size; i2++) {
            Fragment valueAt = this.f.valueAt(i2);
            if (valueAt != null) {
                if (valueAt.i() != null) {
                    int C = valueAt.C();
                    View i3 = valueAt.i();
                    Animation animation = i3.getAnimation();
                    if (animation != null) {
                        animation.cancel();
                        i3.clearAnimation();
                    }
                    valueAt.X0(null);
                    J0(valueAt, C, 0, 0, false);
                } else if (valueAt.j() != null) {
                    valueAt.j().end();
                }
            }
        }
    }

    private static void e1(androidx.fragment.app.h hVar) {
        if (hVar == null) {
            return;
        }
        List<Fragment> b2 = hVar.b();
        if (b2 != null) {
            for (Fragment fragment : b2) {
                fragment.E = true;
            }
        }
        List<androidx.fragment.app.h> a2 = hVar.a();
        if (a2 != null) {
            for (androidx.fragment.app.h hVar2 : a2) {
                e1(hVar2);
            }
        }
    }

    private void f0(boolean z) {
        if (this.f972c) {
            throw new IllegalStateException("FragmentManager is already executing transactions");
        }
        if (this.n == null) {
            throw new IllegalStateException("Fragment host has been destroyed");
        }
        if (Looper.myLooper() != this.n.g().getLooper()) {
            throw new IllegalStateException("Must be called from main thread of fragment host");
        }
        if (!z) {
            r();
        }
        if (this.x == null) {
            this.x = new ArrayList<>();
            this.y = new ArrayList<>();
        }
        this.f972c = true;
        try {
            l0(null, null);
        } finally {
            this.f972c = false;
        }
    }

    static boolean f1(View view, C0036g c0036g) {
        return view != null && c0036g != null && Build.VERSION.SDK_INT >= 19 && view.getLayerType() == 0 && r.B(view) && F0(c0036g);
    }

    private void i1(RuntimeException runtimeException) {
        Log.e("FragmentManager", runtimeException.getMessage());
        Log.e("FragmentManager", "Activity state:");
        PrintWriter printWriter = new PrintWriter(new a.f.k.b("FragmentManager"));
        androidx.fragment.app.e eVar = this.n;
        try {
            if (eVar != null) {
                eVar.i("  ", null, printWriter, new String[0]);
            } else {
                b("  ", null, printWriter, new String[0]);
            }
        } catch (Exception e2) {
            Log.e("FragmentManager", "Failed dumping state", e2);
        }
        throw runtimeException;
    }

    private void j(a.d.b<Fragment> bVar) {
        int i2 = this.m;
        if (i2 < 1) {
            return;
        }
        int min = Math.min(i2, 3);
        int size = this.e.size();
        for (int i3 = 0; i3 < size; i3++) {
            Fragment fragment = this.e.get(i3);
            if (fragment.f926b < min) {
                J0(fragment, min, fragment.u(), fragment.v(), false);
                if (fragment.J != null && !fragment.B && fragment.O) {
                    bVar.add(fragment);
                }
            }
        }
    }

    private static void j0(ArrayList<androidx.fragment.app.a> arrayList, ArrayList<Boolean> arrayList2, int i2, int i3) {
        while (i2 < i3) {
            androidx.fragment.app.a aVar = arrayList.get(i2);
            if (arrayList2.get(i2).booleanValue()) {
                aVar.k(-1);
                aVar.r(i2 == i3 + (-1));
            } else {
                aVar.k(1);
                aVar.q();
            }
            i2++;
        }
    }

    public static int j1(int i2, boolean z) {
        if (i2 == 4097) {
            return z ? 1 : 2;
        } else if (i2 == 4099) {
            return z ? 5 : 6;
        } else if (i2 != 8194) {
            return -1;
        } else {
            return z ? 3 : 4;
        }
    }

    private void k0(ArrayList<androidx.fragment.app.a> arrayList, ArrayList<Boolean> arrayList2, int i2, int i3) {
        int i4;
        int i5;
        int i6 = i2;
        boolean z = arrayList.get(i6).t;
        ArrayList<Fragment> arrayList3 = this.z;
        if (arrayList3 == null) {
            this.z = new ArrayList<>();
        } else {
            arrayList3.clear();
        }
        this.z.addAll(this.e);
        Fragment v0 = v0();
        boolean z2 = false;
        for (int i7 = i6; i7 < i3; i7++) {
            androidx.fragment.app.a aVar = arrayList.get(i7);
            v0 = !arrayList2.get(i7).booleanValue() ? aVar.s(this.z, v0) : aVar.A(this.z, v0);
            z2 = z2 || aVar.i;
        }
        this.z.clear();
        if (!z) {
            androidx.fragment.app.k.C(this, arrayList, arrayList2, i2, i3, false);
        }
        j0(arrayList, arrayList2, i2, i3);
        if (z) {
            a.d.b<Fragment> bVar = new a.d.b<>();
            j(bVar);
            int O0 = O0(arrayList, arrayList2, i2, i3, bVar);
            D0(bVar);
            i4 = O0;
        } else {
            i4 = i3;
        }
        if (i4 != i6 && z) {
            androidx.fragment.app.k.C(this, arrayList, arrayList2, i2, i4, true);
            H0(this.m, true);
        }
        while (i6 < i3) {
            androidx.fragment.app.a aVar2 = arrayList.get(i6);
            if (arrayList2.get(i6).booleanValue() && (i5 = aVar2.m) >= 0) {
                q0(i5);
                aVar2.m = -1;
            }
            aVar2.y();
            i6++;
        }
        if (z2) {
            S0();
        }
    }

    private void l0(ArrayList<androidx.fragment.app.a> arrayList, ArrayList<Boolean> arrayList2) {
        int indexOf;
        int indexOf2;
        ArrayList<n> arrayList3 = this.C;
        int size = arrayList3 == null ? 0 : arrayList3.size();
        int i2 = 0;
        while (i2 < size) {
            n nVar = this.C.get(i2);
            if (arrayList == null || nVar.f1002a || (indexOf2 = arrayList.indexOf(nVar.f1003b)) == -1 || !arrayList2.get(indexOf2).booleanValue()) {
                if (nVar.e() || (arrayList != null && nVar.f1003b.v(arrayList, 0, arrayList.size()))) {
                    this.C.remove(i2);
                    i2--;
                    size--;
                    if (arrayList == null || nVar.f1002a || (indexOf = arrayList.indexOf(nVar.f1003b)) == -1 || !arrayList2.get(indexOf).booleanValue()) {
                        nVar.d();
                    }
                }
                i2++;
            }
            nVar.c();
            i2++;
        }
    }

    private void n(Fragment fragment, C0036g c0036g, int i2) {
        View view = fragment.J;
        ViewGroup viewGroup = fragment.I;
        viewGroup.startViewTransition(view);
        fragment.g1(i2);
        if (c0036g.f989a != null) {
            i iVar = new i(c0036g.f989a, viewGroup, view);
            fragment.X0(fragment.J);
            iVar.setAnimationListener(new b(s0(iVar), viewGroup, fragment));
            c1(view, c0036g);
            fragment.J.startAnimation(iVar);
            return;
        }
        Animator animator = c0036g.f990b;
        fragment.Y0(animator);
        animator.addListener(new c(viewGroup, view, fragment));
        animator.setTarget(fragment.J);
        c1(fragment.J, c0036g);
        animator.start();
    }

    private Fragment o0(Fragment fragment) {
        ViewGroup viewGroup = fragment.I;
        View view = fragment.J;
        if (viewGroup != null && view != null) {
            for (int indexOf = this.e.indexOf(fragment) - 1; indexOf >= 0; indexOf--) {
                Fragment fragment2 = this.e.get(indexOf);
                if (fragment2.I == viewGroup && fragment2.J != null) {
                    return fragment2;
                }
            }
        }
        return null;
    }

    private void p0() {
        if (this.C != null) {
            while (!this.C.isEmpty()) {
                this.C.remove(0).d();
            }
        }
    }

    private void q() {
        SparseArray<Fragment> sparseArray = this.f;
        if (sparseArray != null) {
            for (int size = sparseArray.size() - 1; size >= 0; size--) {
                if (this.f.valueAt(size) == null) {
                    SparseArray<Fragment> sparseArray2 = this.f;
                    sparseArray2.delete(sparseArray2.keyAt(size));
                }
            }
        }
    }

    private void r() {
        if (g()) {
            throw new IllegalStateException("Can not perform this action after onSaveInstanceState");
        }
        if (this.v == null) {
            return;
        }
        throw new IllegalStateException("Can not perform this action inside of " + this.v);
    }

    private boolean r0(ArrayList<androidx.fragment.app.a> arrayList, ArrayList<Boolean> arrayList2) {
        synchronized (this) {
            ArrayList<l> arrayList3 = this.f971b;
            if (arrayList3 != null && arrayList3.size() != 0) {
                int size = this.f971b.size();
                boolean z = false;
                for (int i2 = 0; i2 < size; i2++) {
                    z |= this.f971b.get(i2).a(arrayList, arrayList2);
                }
                this.f971b.clear();
                this.n.g().removeCallbacks(this.E);
                return z;
            }
            return false;
        }
    }

    private void s() {
        this.f972c = false;
        this.y.clear();
        this.x.clear();
    }

    private static Animation.AnimationListener s0(Animation animation) {
        String str;
        try {
            if (G == null) {
                Field declaredField = Animation.class.getDeclaredField("mListener");
                G = declaredField;
                declaredField.setAccessible(true);
            }
            return (Animation.AnimationListener) G.get(animation);
        } catch (IllegalAccessException e2) {
            e = e2;
            str = "Cannot access Animation's mListener field";
            Log.e("FragmentManager", str, e);
            return null;
        } catch (NoSuchFieldException e3) {
            e = e3;
            str = "No field with the name mListener is found in Animation class";
            Log.e("FragmentManager", str, e);
            return null;
        }
    }

    public boolean A(Menu menu, MenuInflater menuInflater) {
        if (this.m < 1) {
            return false;
        }
        ArrayList<Fragment> arrayList = null;
        boolean z = false;
        for (int i2 = 0; i2 < this.e.size(); i2++) {
            Fragment fragment = this.e.get(i2);
            if (fragment != null && fragment.D0(menu, menuInflater)) {
                if (arrayList == null) {
                    arrayList = new ArrayList<>();
                }
                arrayList.add(fragment);
                z = true;
            }
        }
        if (this.h != null) {
            for (int i3 = 0; i3 < this.h.size(); i3++) {
                Fragment fragment2 = this.h.get(i3);
                if (arrayList == null || !arrayList.contains(fragment2)) {
                    fragment2.e0();
                }
            }
        }
        this.h = arrayList;
        return z;
    }

    public void B() {
        this.u = true;
        h0();
        a0(0);
        this.n = null;
        this.o = null;
        this.p = null;
    }

    void B0(Fragment fragment) {
        if (fragment.f < 0) {
            return;
        }
        if (F) {
            Log.v("FragmentManager", "Freeing fragment index " + fragment);
        }
        this.f.put(fragment.f, null);
        fragment.G();
    }

    public void C() {
        a0(1);
    }

    public void D() {
        for (int i2 = 0; i2 < this.e.size(); i2++) {
            Fragment fragment = this.e.get(i2);
            if (fragment != null) {
                fragment.J0();
            }
        }
    }

    public void E(boolean z) {
        int size = this.e.size();
        while (true) {
            size--;
            if (size < 0) {
                return;
            }
            Fragment fragment = this.e.get(size);
            if (fragment != null) {
                fragment.K0(z);
            }
        }
    }

    void F(Fragment fragment, Bundle bundle, boolean z) {
        Fragment fragment2 = this.p;
        if (fragment2 != null) {
            androidx.fragment.app.f s = fragment2.s();
            if (s instanceof g) {
                ((g) s).F(fragment, bundle, true);
            }
        }
        Iterator<j> it = this.l.iterator();
        while (it.hasNext()) {
            j next = it.next();
            if (!z || next.f996b) {
                next.f995a.a(this, fragment, bundle);
            }
        }
    }

    void G(Fragment fragment, Context context, boolean z) {
        Fragment fragment2 = this.p;
        if (fragment2 != null) {
            androidx.fragment.app.f s = fragment2.s();
            if (s instanceof g) {
                ((g) s).G(fragment, context, true);
            }
        }
        Iterator<j> it = this.l.iterator();
        while (it.hasNext()) {
            j next = it.next();
            if (!z || next.f996b) {
                next.f995a.b(this, fragment, context);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void G0(Fragment fragment) {
        if (fragment == null) {
            return;
        }
        int i2 = this.m;
        if (fragment.m) {
            i2 = fragment.N() ? Math.min(i2, 1) : Math.min(i2, 0);
        }
        J0(fragment, i2, fragment.v(), fragment.w(), false);
        if (fragment.J != null) {
            Fragment o0 = o0(fragment);
            if (o0 != null) {
                View view = o0.J;
                ViewGroup viewGroup = fragment.I;
                int indexOfChild = viewGroup.indexOfChild(view);
                int indexOfChild2 = viewGroup.indexOfChild(fragment.J);
                if (indexOfChild2 < indexOfChild) {
                    viewGroup.removeViewAt(indexOfChild2);
                    viewGroup.addView(fragment.J, indexOfChild);
                }
            }
            if (fragment.O && fragment.I != null) {
                float f2 = fragment.Q;
                if (f2 > 0.0f) {
                    fragment.J.setAlpha(f2);
                }
                fragment.Q = 0.0f;
                fragment.O = false;
                C0036g y0 = y0(fragment, fragment.v(), true, fragment.w());
                if (y0 != null) {
                    c1(fragment.J, y0);
                    Animation animation = y0.f989a;
                    if (animation != null) {
                        fragment.J.startAnimation(animation);
                    } else {
                        y0.f990b.setTarget(fragment.J);
                        y0.f990b.start();
                    }
                }
            }
        }
        if (fragment.P) {
            u(fragment);
        }
    }

    void H(Fragment fragment, Bundle bundle, boolean z) {
        Fragment fragment2 = this.p;
        if (fragment2 != null) {
            androidx.fragment.app.f s = fragment2.s();
            if (s instanceof g) {
                ((g) s).H(fragment, bundle, true);
            }
        }
        Iterator<j> it = this.l.iterator();
        while (it.hasNext()) {
            j next = it.next();
            if (!z || next.f996b) {
                next.f995a.c(this, fragment, bundle);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void H0(int i2, boolean z) {
        androidx.fragment.app.e eVar;
        if (this.n == null && i2 != 0) {
            throw new IllegalStateException("No activity");
        }
        if (z || i2 != this.m) {
            this.m = i2;
            if (this.f != null) {
                int size = this.e.size();
                for (int i3 = 0; i3 < size; i3++) {
                    G0(this.e.get(i3));
                }
                int size2 = this.f.size();
                for (int i4 = 0; i4 < size2; i4++) {
                    Fragment valueAt = this.f.valueAt(i4);
                    if (valueAt != null && ((valueAt.m || valueAt.C) && !valueAt.O)) {
                        G0(valueAt);
                    }
                }
                h1();
                if (this.r && (eVar = this.n) != null && this.m == 4) {
                    eVar.o();
                    this.r = false;
                }
            }
        }
    }

    void I(Fragment fragment, boolean z) {
        Fragment fragment2 = this.p;
        if (fragment2 != null) {
            androidx.fragment.app.f s = fragment2.s();
            if (s instanceof g) {
                ((g) s).I(fragment, true);
            }
        }
        Iterator<j> it = this.l.iterator();
        while (it.hasNext()) {
            j next = it.next();
            if (!z || next.f996b) {
                next.f995a.d(this, fragment);
            }
        }
    }

    void I0(Fragment fragment) {
        J0(fragment, this.m, 0, 0, false);
    }

    void J(Fragment fragment, boolean z) {
        Fragment fragment2 = this.p;
        if (fragment2 != null) {
            androidx.fragment.app.f s = fragment2.s();
            if (s instanceof g) {
                ((g) s).J(fragment, true);
            }
        }
        Iterator<j> it = this.l.iterator();
        while (it.hasNext()) {
            j next = it.next();
            if (!z || next.f996b) {
                next.f995a.e(this, fragment);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* JADX WARN: Code restructure failed: missing block: B:43:0x0072, code lost:
        if (r0 != 3) goto L43;
     */
    /* JADX WARN: Removed duplicated region for block: B:134:0x0292  */
    /* JADX WARN: Removed duplicated region for block: B:139:0x02b2  */
    /* JADX WARN: Removed duplicated region for block: B:221:0x041d  */
    /* JADX WARN: Removed duplicated region for block: B:225:? A[RETURN, SYNTHETIC] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void J0(androidx.fragment.app.Fragment r17, int r18, int r19, int r20, boolean r21) {
        /*
            Method dump skipped, instructions count: 1099
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: androidx.fragment.app.g.J0(androidx.fragment.app.Fragment, int, int, int, boolean):void");
    }

    void K(Fragment fragment, boolean z) {
        Fragment fragment2 = this.p;
        if (fragment2 != null) {
            androidx.fragment.app.f s = fragment2.s();
            if (s instanceof g) {
                ((g) s).K(fragment, true);
            }
        }
        Iterator<j> it = this.l.iterator();
        while (it.hasNext()) {
            j next = it.next();
            if (!z || next.f996b) {
                next.f995a.f(this, fragment);
            }
        }
    }

    public void K0() {
        this.D = null;
        this.s = false;
        this.t = false;
        int size = this.e.size();
        for (int i2 = 0; i2 < size; i2++) {
            Fragment fragment = this.e.get(i2);
            if (fragment != null) {
                fragment.R();
            }
        }
    }

    void L(Fragment fragment, Context context, boolean z) {
        Fragment fragment2 = this.p;
        if (fragment2 != null) {
            androidx.fragment.app.f s = fragment2.s();
            if (s instanceof g) {
                ((g) s).L(fragment, context, true);
            }
        }
        Iterator<j> it = this.l.iterator();
        while (it.hasNext()) {
            j next = it.next();
            if (!z || next.f996b) {
                next.f995a.g(this, fragment, context);
            }
        }
    }

    public void L0(Fragment fragment) {
        if (fragment.L) {
            if (this.f972c) {
                this.w = true;
                return;
            }
            fragment.L = false;
            J0(fragment, this.m, 0, 0, false);
        }
    }

    void M(Fragment fragment, Bundle bundle, boolean z) {
        Fragment fragment2 = this.p;
        if (fragment2 != null) {
            androidx.fragment.app.f s = fragment2.s();
            if (s instanceof g) {
                ((g) s).M(fragment, bundle, true);
            }
        }
        Iterator<j> it = this.l.iterator();
        while (it.hasNext()) {
            j next = it.next();
            if (!z || next.f996b) {
                next.f995a.h(this, fragment, bundle);
            }
        }
    }

    void N(Fragment fragment, boolean z) {
        Fragment fragment2 = this.p;
        if (fragment2 != null) {
            androidx.fragment.app.f s = fragment2.s();
            if (s instanceof g) {
                ((g) s).N(fragment, true);
            }
        }
        Iterator<j> it = this.l.iterator();
        while (it.hasNext()) {
            j next = it.next();
            if (!z || next.f996b) {
                next.f995a.i(this, fragment);
            }
        }
    }

    boolean N0(ArrayList<androidx.fragment.app.a> arrayList, ArrayList<Boolean> arrayList2, String str, int i2, int i3) {
        int i4;
        ArrayList<androidx.fragment.app.a> arrayList3 = this.g;
        if (arrayList3 == null) {
            return false;
        }
        if (str == null && i2 < 0 && (i3 & 1) == 0) {
            int size = arrayList3.size() - 1;
            if (size < 0) {
                return false;
            }
            arrayList.add(this.g.remove(size));
            arrayList2.add(Boolean.TRUE);
        } else {
            if (str != null || i2 >= 0) {
                int size2 = arrayList3.size() - 1;
                while (size2 >= 0) {
                    androidx.fragment.app.a aVar = this.g.get(size2);
                    if ((str != null && str.equals(aVar.t())) || (i2 >= 0 && i2 == aVar.m)) {
                        break;
                    }
                    size2--;
                }
                if (size2 < 0) {
                    return false;
                }
                if ((i3 & 1) != 0) {
                    while (true) {
                        size2--;
                        if (size2 < 0) {
                            break;
                        }
                        androidx.fragment.app.a aVar2 = this.g.get(size2);
                        if (str == null || !str.equals(aVar2.t())) {
                            if (i2 < 0 || i2 != aVar2.m) {
                                break;
                            }
                        }
                    }
                }
                i4 = size2;
            } else {
                i4 = -1;
            }
            if (i4 == this.g.size() - 1) {
                return false;
            }
            for (int size3 = this.g.size() - 1; size3 > i4; size3--) {
                arrayList.add(this.g.remove(size3));
                arrayList2.add(Boolean.TRUE);
            }
        }
        return true;
    }

    void O(Fragment fragment, Bundle bundle, boolean z) {
        Fragment fragment2 = this.p;
        if (fragment2 != null) {
            androidx.fragment.app.f s = fragment2.s();
            if (s instanceof g) {
                ((g) s).O(fragment, bundle, true);
            }
        }
        Iterator<j> it = this.l.iterator();
        while (it.hasNext()) {
            j next = it.next();
            if (!z || next.f996b) {
                next.f995a.j(this, fragment, bundle);
            }
        }
    }

    void P(Fragment fragment, boolean z) {
        Fragment fragment2 = this.p;
        if (fragment2 != null) {
            androidx.fragment.app.f s = fragment2.s();
            if (s instanceof g) {
                ((g) s).P(fragment, true);
            }
        }
        Iterator<j> it = this.l.iterator();
        while (it.hasNext()) {
            j next = it.next();
            if (!z || next.f996b) {
                next.f995a.k(this, fragment);
            }
        }
    }

    public void P0(Bundle bundle, String str, Fragment fragment) {
        int i2 = fragment.f;
        if (i2 >= 0) {
            bundle.putInt(str, i2);
            return;
        }
        i1(new IllegalStateException("Fragment " + fragment + " is not currently in the FragmentManager"));
        throw null;
    }

    void Q(Fragment fragment, boolean z) {
        Fragment fragment2 = this.p;
        if (fragment2 != null) {
            androidx.fragment.app.f s = fragment2.s();
            if (s instanceof g) {
                ((g) s).Q(fragment, true);
            }
        }
        Iterator<j> it = this.l.iterator();
        while (it.hasNext()) {
            j next = it.next();
            if (!z || next.f996b) {
                next.f995a.l(this, fragment);
            }
        }
    }

    public void Q0(Fragment fragment) {
        if (F) {
            Log.v("FragmentManager", "remove: " + fragment + " nesting=" + fragment.r);
        }
        boolean z = !fragment.N();
        if (!fragment.C || z) {
            synchronized (this.e) {
                this.e.remove(fragment);
            }
            if (fragment.F && fragment.G) {
                this.r = true;
            }
            fragment.l = false;
            fragment.m = true;
        }
    }

    void R(Fragment fragment, View view, Bundle bundle, boolean z) {
        Fragment fragment2 = this.p;
        if (fragment2 != null) {
            androidx.fragment.app.f s = fragment2.s();
            if (s instanceof g) {
                ((g) s).R(fragment, view, bundle, true);
            }
        }
        Iterator<j> it = this.l.iterator();
        while (it.hasNext()) {
            j next = it.next();
            if (!z || next.f996b) {
                next.f995a.m(this, fragment, view, bundle);
            }
        }
    }

    void S(Fragment fragment, boolean z) {
        Fragment fragment2 = this.p;
        if (fragment2 != null) {
            androidx.fragment.app.f s = fragment2.s();
            if (s instanceof g) {
                ((g) s).S(fragment, true);
            }
        }
        Iterator<j> it = this.l.iterator();
        while (it.hasNext()) {
            j next = it.next();
            if (!z || next.f996b) {
                next.f995a.n(this, fragment);
            }
        }
    }

    void S0() {
        if (this.k != null) {
            for (int i2 = 0; i2 < this.k.size(); i2++) {
                this.k.get(i2).a();
            }
        }
    }

    public boolean T(MenuItem menuItem) {
        if (this.m < 1) {
            return false;
        }
        for (int i2 = 0; i2 < this.e.size(); i2++) {
            Fragment fragment = this.e.get(i2);
            if (fragment != null && fragment.L0(menuItem)) {
                return true;
            }
        }
        return false;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void T0(Parcelable parcelable, androidx.fragment.app.h hVar) {
        List<androidx.fragment.app.h> list;
        List<androidx.lifecycle.r> list2;
        FragmentState[] fragmentStateArr;
        if (parcelable == null) {
            return;
        }
        FragmentManagerState fragmentManagerState = (FragmentManagerState) parcelable;
        if (fragmentManagerState.f937b == null) {
            return;
        }
        if (hVar != null) {
            List<Fragment> b2 = hVar.b();
            list = hVar.a();
            list2 = hVar.c();
            int size = b2 != null ? b2.size() : 0;
            for (int i2 = 0; i2 < size; i2++) {
                Fragment fragment = b2.get(i2);
                if (F) {
                    Log.v("FragmentManager", "restoreAllState: re-attaching retained " + fragment);
                }
                int i3 = 0;
                while (true) {
                    fragmentStateArr = fragmentManagerState.f937b;
                    if (i3 >= fragmentStateArr.length || fragmentStateArr[i3].f941c == fragment.f) {
                        break;
                    }
                    i3++;
                }
                if (i3 == fragmentStateArr.length) {
                    i1(new IllegalStateException("Could not find active fragment with index " + fragment.f));
                    throw null;
                }
                FragmentState fragmentState = fragmentStateArr[i3];
                fragmentState.m = fragment;
                fragment.f928d = null;
                fragment.r = 0;
                fragment.o = false;
                fragment.l = false;
                fragment.i = null;
                Bundle bundle = fragmentState.l;
                if (bundle != null) {
                    bundle.setClassLoader(this.n.e().getClassLoader());
                    fragment.f928d = fragmentState.l.getSparseParcelableArray("android:view_state");
                    fragment.f927c = fragmentState.l;
                }
            }
        } else {
            list = null;
            list2 = null;
        }
        this.f = new SparseArray<>(fragmentManagerState.f937b.length);
        int i4 = 0;
        while (true) {
            FragmentState[] fragmentStateArr2 = fragmentManagerState.f937b;
            if (i4 >= fragmentStateArr2.length) {
                break;
            }
            FragmentState fragmentState2 = fragmentStateArr2[i4];
            if (fragmentState2 != null) {
                Fragment a2 = fragmentState2.a(this.n, this.o, this.p, (list == null || i4 >= list.size()) ? null : list.get(i4), (list2 == null || i4 >= list2.size()) ? null : list2.get(i4));
                if (F) {
                    Log.v("FragmentManager", "restoreAllState: active #" + i4 + ": " + a2);
                }
                this.f.put(a2.f, a2);
                fragmentState2.m = null;
            }
            i4++;
        }
        if (hVar != null) {
            List<Fragment> b3 = hVar.b();
            int size2 = b3 != null ? b3.size() : 0;
            for (int i5 = 0; i5 < size2; i5++) {
                Fragment fragment2 = b3.get(i5);
                int i6 = fragment2.j;
                if (i6 >= 0) {
                    Fragment fragment3 = this.f.get(i6);
                    fragment2.i = fragment3;
                    if (fragment3 == null) {
                        Log.w("FragmentManager", "Re-attaching retained fragment " + fragment2 + " target no longer exists: " + fragment2.j);
                    }
                }
            }
        }
        this.e.clear();
        if (fragmentManagerState.f938c != null) {
            int i7 = 0;
            while (true) {
                int[] iArr = fragmentManagerState.f938c;
                if (i7 >= iArr.length) {
                    break;
                }
                Fragment fragment4 = this.f.get(iArr[i7]);
                if (fragment4 == null) {
                    i1(new IllegalStateException("No instantiated fragment for index #" + fragmentManagerState.f938c[i7]));
                    throw null;
                }
                fragment4.l = true;
                if (F) {
                    Log.v("FragmentManager", "restoreAllState: added #" + i7 + ": " + fragment4);
                }
                if (this.e.contains(fragment4)) {
                    throw new IllegalStateException("Already added!");
                }
                synchronized (this.e) {
                    this.e.add(fragment4);
                }
                i7++;
            }
        }
        if (fragmentManagerState.f939d != null) {
            this.g = new ArrayList<>(fragmentManagerState.f939d.length);
            int i8 = 0;
            while (true) {
                BackStackState[] backStackStateArr = fragmentManagerState.f939d;
                if (i8 >= backStackStateArr.length) {
                    break;
                }
                androidx.fragment.app.a a3 = backStackStateArr[i8].a(this);
                if (F) {
                    Log.v("FragmentManager", "restoreAllState: back stack #" + i8 + " (index " + a3.m + "): " + a3);
                    PrintWriter printWriter = new PrintWriter(new a.f.k.b("FragmentManager"));
                    a3.p("  ", printWriter, false);
                    printWriter.close();
                }
                this.g.add(a3);
                int i9 = a3.m;
                if (i9 >= 0) {
                    b1(i9, a3);
                }
                i8++;
            }
        } else {
            this.g = null;
        }
        int i10 = fragmentManagerState.e;
        if (i10 >= 0) {
            this.q = this.f.get(i10);
        }
        this.f973d = fragmentManagerState.f;
    }

    public void U(Menu menu) {
        if (this.m < 1) {
            return;
        }
        for (int i2 = 0; i2 < this.e.size(); i2++) {
            Fragment fragment = this.e.get(i2);
            if (fragment != null) {
                fragment.M0(menu);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public androidx.fragment.app.h U0() {
        e1(this.D);
        return this.D;
    }

    public void V() {
        a0(3);
    }

    public void W(boolean z) {
        int size = this.e.size();
        while (true) {
            size--;
            if (size < 0) {
                return;
            }
            Fragment fragment = this.e.get(size);
            if (fragment != null) {
                fragment.O0(z);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public Parcelable W0() {
        int[] iArr;
        int size;
        p0();
        d0();
        h0();
        this.s = true;
        BackStackState[] backStackStateArr = null;
        this.D = null;
        SparseArray<Fragment> sparseArray = this.f;
        if (sparseArray == null || sparseArray.size() <= 0) {
            return null;
        }
        int size2 = this.f.size();
        FragmentState[] fragmentStateArr = new FragmentState[size2];
        boolean z = false;
        for (int i2 = 0; i2 < size2; i2++) {
            Fragment valueAt = this.f.valueAt(i2);
            if (valueAt != null) {
                if (valueAt.f < 0) {
                    i1(new IllegalStateException("Failure saving state: active " + valueAt + " has cleared index: " + valueAt.f));
                    throw null;
                }
                FragmentState fragmentState = new FragmentState(valueAt);
                fragmentStateArr[i2] = fragmentState;
                if (valueAt.f926b <= 0 || fragmentState.l != null) {
                    fragmentState.l = valueAt.f927c;
                } else {
                    Bundle X0 = X0(valueAt);
                    fragmentState.l = X0;
                    Fragment fragment = valueAt.i;
                    if (fragment != null) {
                        if (fragment.f < 0) {
                            i1(new IllegalStateException("Failure saving state: " + valueAt + " has target not in fragment manager: " + valueAt.i));
                            throw null;
                        }
                        if (X0 == null) {
                            fragmentState.l = new Bundle();
                        }
                        P0(fragmentState.l, "android:target_state", valueAt.i);
                        int i3 = valueAt.k;
                        if (i3 != 0) {
                            fragmentState.l.putInt("android:target_req_state", i3);
                        }
                    }
                }
                if (F) {
                    Log.v("FragmentManager", "Saved state of " + valueAt + ": " + fragmentState.l);
                }
                z = true;
            }
        }
        if (!z) {
            if (F) {
                Log.v("FragmentManager", "saveAllState: no fragments!");
            }
            return null;
        }
        int size3 = this.e.size();
        if (size3 > 0) {
            iArr = new int[size3];
            for (int i4 = 0; i4 < size3; i4++) {
                iArr[i4] = this.e.get(i4).f;
                if (iArr[i4] < 0) {
                    i1(new IllegalStateException("Failure saving state: active " + this.e.get(i4) + " has cleared index: " + iArr[i4]));
                    throw null;
                }
                if (F) {
                    Log.v("FragmentManager", "saveAllState: adding fragment #" + i4 + ": " + this.e.get(i4));
                }
            }
        } else {
            iArr = null;
        }
        ArrayList<androidx.fragment.app.a> arrayList = this.g;
        if (arrayList != null && (size = arrayList.size()) > 0) {
            backStackStateArr = new BackStackState[size];
            for (int i5 = 0; i5 < size; i5++) {
                backStackStateArr[i5] = new BackStackState(this.g.get(i5));
                if (F) {
                    Log.v("FragmentManager", "saveAllState: adding back stack #" + i5 + ": " + this.g.get(i5));
                }
            }
        }
        FragmentManagerState fragmentManagerState = new FragmentManagerState();
        fragmentManagerState.f937b = fragmentStateArr;
        fragmentManagerState.f938c = iArr;
        fragmentManagerState.f939d = backStackStateArr;
        Fragment fragment2 = this.q;
        if (fragment2 != null) {
            fragmentManagerState.e = fragment2.f;
        }
        fragmentManagerState.f = this.f973d;
        Z0();
        return fragmentManagerState;
    }

    public boolean X(Menu menu) {
        if (this.m < 1) {
            return false;
        }
        boolean z = false;
        for (int i2 = 0; i2 < this.e.size(); i2++) {
            Fragment fragment = this.e.get(i2);
            if (fragment != null && fragment.P0(menu)) {
                z = true;
            }
        }
        return z;
    }

    Bundle X0(Fragment fragment) {
        if (this.A == null) {
            this.A = new Bundle();
        }
        fragment.R0(this.A);
        O(fragment, this.A, false);
        Bundle bundle = null;
        if (!this.A.isEmpty()) {
            Bundle bundle2 = this.A;
            this.A = null;
            bundle = bundle2;
        }
        if (fragment.J != null) {
            Y0(fragment);
        }
        if (fragment.f928d != null) {
            if (bundle == null) {
                bundle = new Bundle();
            }
            bundle.putSparseParcelableArray("android:view_state", fragment.f928d);
        }
        if (!fragment.M) {
            if (bundle == null) {
                bundle = new Bundle();
            }
            bundle.putBoolean("android:user_visible_hint", fragment.M);
        }
        return bundle;
    }

    public void Y() {
        this.s = false;
        this.t = false;
        a0(4);
    }

    void Y0(Fragment fragment) {
        if (fragment.K == null) {
            return;
        }
        SparseArray<Parcelable> sparseArray = this.B;
        if (sparseArray == null) {
            this.B = new SparseArray<>();
        } else {
            sparseArray.clear();
        }
        fragment.K.saveHierarchyState(this.B);
        if (this.B.size() > 0) {
            fragment.f928d = this.B;
            this.B = null;
        }
    }

    public void Z() {
        this.s = false;
        this.t = false;
        a0(3);
    }

    void Z0() {
        ArrayList arrayList;
        ArrayList arrayList2;
        ArrayList arrayList3;
        androidx.fragment.app.h hVar;
        if (this.f != null) {
            arrayList = null;
            arrayList2 = null;
            arrayList3 = null;
            for (int i2 = 0; i2 < this.f.size(); i2++) {
                Fragment valueAt = this.f.valueAt(i2);
                if (valueAt != null) {
                    if (valueAt.D) {
                        if (arrayList == null) {
                            arrayList = new ArrayList();
                        }
                        arrayList.add(valueAt);
                        Fragment fragment = valueAt.i;
                        valueAt.j = fragment != null ? fragment.f : -1;
                        if (F) {
                            Log.v("FragmentManager", "retainNonConfig: keeping retained " + valueAt);
                        }
                    }
                    g gVar = valueAt.u;
                    if (gVar != null) {
                        gVar.Z0();
                        hVar = valueAt.u.D;
                    } else {
                        hVar = valueAt.v;
                    }
                    if (arrayList2 == null && hVar != null) {
                        arrayList2 = new ArrayList(this.f.size());
                        for (int i3 = 0; i3 < i2; i3++) {
                            arrayList2.add(null);
                        }
                    }
                    if (arrayList2 != null) {
                        arrayList2.add(hVar);
                    }
                    if (arrayList3 == null && valueAt.w != null) {
                        arrayList3 = new ArrayList(this.f.size());
                        for (int i4 = 0; i4 < i2; i4++) {
                            arrayList3.add(null);
                        }
                    }
                    if (arrayList3 != null) {
                        arrayList3.add(valueAt.w);
                    }
                }
            }
        } else {
            arrayList = null;
            arrayList2 = null;
            arrayList3 = null;
        }
        if (arrayList == null && arrayList2 == null && arrayList3 == null) {
            this.D = null;
        } else {
            this.D = new androidx.fragment.app.h(arrayList, arrayList2, arrayList3);
        }
    }

    @Override // androidx.fragment.app.f
    public androidx.fragment.app.j a() {
        return new androidx.fragment.app.a(this);
    }

    void a1() {
        synchronized (this) {
            ArrayList<n> arrayList = this.C;
            boolean z = false;
            boolean z2 = (arrayList == null || arrayList.isEmpty()) ? false : true;
            ArrayList<l> arrayList2 = this.f971b;
            if (arrayList2 != null && arrayList2.size() == 1) {
                z = true;
            }
            if (z2 || z) {
                this.n.g().removeCallbacks(this.E);
                this.n.g().post(this.E);
            }
        }
    }

    @Override // androidx.fragment.app.f
    public void b(String str, FileDescriptor fileDescriptor, PrintWriter printWriter, String[] strArr) {
        int size;
        int size2;
        int size3;
        int size4;
        int size5;
        String str2 = str + "    ";
        SparseArray<Fragment> sparseArray = this.f;
        if (sparseArray != null && (size5 = sparseArray.size()) > 0) {
            printWriter.print(str);
            printWriter.print("Active Fragments in ");
            printWriter.print(Integer.toHexString(System.identityHashCode(this)));
            printWriter.println(":");
            for (int i2 = 0; i2 < size5; i2++) {
                Fragment valueAt = this.f.valueAt(i2);
                printWriter.print(str);
                printWriter.print("  #");
                printWriter.print(i2);
                printWriter.print(": ");
                printWriter.println(valueAt);
                if (valueAt != null) {
                    valueAt.c(str2, fileDescriptor, printWriter, strArr);
                }
            }
        }
        int size6 = this.e.size();
        if (size6 > 0) {
            printWriter.print(str);
            printWriter.println("Added Fragments:");
            for (int i3 = 0; i3 < size6; i3++) {
                printWriter.print(str);
                printWriter.print("  #");
                printWriter.print(i3);
                printWriter.print(": ");
                printWriter.println(this.e.get(i3).toString());
            }
        }
        ArrayList<Fragment> arrayList = this.h;
        if (arrayList != null && (size4 = arrayList.size()) > 0) {
            printWriter.print(str);
            printWriter.println("Fragments Created Menus:");
            for (int i4 = 0; i4 < size4; i4++) {
                printWriter.print(str);
                printWriter.print("  #");
                printWriter.print(i4);
                printWriter.print(": ");
                printWriter.println(this.h.get(i4).toString());
            }
        }
        ArrayList<androidx.fragment.app.a> arrayList2 = this.g;
        if (arrayList2 != null && (size3 = arrayList2.size()) > 0) {
            printWriter.print(str);
            printWriter.println("Back Stack:");
            for (int i5 = 0; i5 < size3; i5++) {
                androidx.fragment.app.a aVar = this.g.get(i5);
                printWriter.print(str);
                printWriter.print("  #");
                printWriter.print(i5);
                printWriter.print(": ");
                printWriter.println(aVar.toString());
                aVar.o(str2, fileDescriptor, printWriter, strArr);
            }
        }
        synchronized (this) {
            ArrayList<androidx.fragment.app.a> arrayList3 = this.i;
            if (arrayList3 != null && (size2 = arrayList3.size()) > 0) {
                printWriter.print(str);
                printWriter.println("Back Stack Indices:");
                for (int i6 = 0; i6 < size2; i6++) {
                    printWriter.print(str);
                    printWriter.print("  #");
                    printWriter.print(i6);
                    printWriter.print(": ");
                    printWriter.println((androidx.fragment.app.a) this.i.get(i6));
                }
            }
            ArrayList<Integer> arrayList4 = this.j;
            if (arrayList4 != null && arrayList4.size() > 0) {
                printWriter.print(str);
                printWriter.print("mAvailBackStackIndices: ");
                printWriter.println(Arrays.toString(this.j.toArray()));
            }
        }
        ArrayList<l> arrayList5 = this.f971b;
        if (arrayList5 != null && (size = arrayList5.size()) > 0) {
            printWriter.print(str);
            printWriter.println("Pending Actions:");
            for (int i7 = 0; i7 < size; i7++) {
                printWriter.print(str);
                printWriter.print("  #");
                printWriter.print(i7);
                printWriter.print(": ");
                printWriter.println((l) this.f971b.get(i7));
            }
        }
        printWriter.print(str);
        printWriter.println("FragmentManager misc state:");
        printWriter.print(str);
        printWriter.print("  mHost=");
        printWriter.println(this.n);
        printWriter.print(str);
        printWriter.print("  mContainer=");
        printWriter.println(this.o);
        if (this.p != null) {
            printWriter.print(str);
            printWriter.print("  mParent=");
            printWriter.println(this.p);
        }
        printWriter.print(str);
        printWriter.print("  mCurState=");
        printWriter.print(this.m);
        printWriter.print(" mStateSaved=");
        printWriter.print(this.s);
        printWriter.print(" mStopped=");
        printWriter.print(this.t);
        printWriter.print(" mDestroyed=");
        printWriter.println(this.u);
        if (this.r) {
            printWriter.print(str);
            printWriter.print("  mNeedMenuInvalidate=");
            printWriter.println(this.r);
        }
        if (this.v != null) {
            printWriter.print(str);
            printWriter.print("  mNoTransactionsBecause=");
            printWriter.println(this.v);
        }
    }

    public void b0() {
        this.t = true;
        a0(2);
    }

    public void b1(int i2, androidx.fragment.app.a aVar) {
        synchronized (this) {
            if (this.i == null) {
                this.i = new ArrayList<>();
            }
            int size = this.i.size();
            if (i2 < size) {
                if (F) {
                    Log.v("FragmentManager", "Setting back stack index " + i2 + " to " + aVar);
                }
                this.i.set(i2, aVar);
            } else {
                while (size < i2) {
                    this.i.add(null);
                    if (this.j == null) {
                        this.j = new ArrayList<>();
                    }
                    if (F) {
                        Log.v("FragmentManager", "Adding available back stack index " + size);
                    }
                    this.j.add(Integer.valueOf(size));
                    size++;
                }
                if (F) {
                    Log.v("FragmentManager", "Adding back stack index " + i2 + " with " + aVar);
                }
                this.i.add(aVar);
            }
        }
    }

    @Override // androidx.fragment.app.f
    public boolean c() {
        boolean h0 = h0();
        p0();
        return h0;
    }

    void c0() {
        if (this.w) {
            this.w = false;
            h1();
        }
    }

    @Override // androidx.fragment.app.f
    public Fragment d(String str) {
        if (str != null) {
            for (int size = this.e.size() - 1; size >= 0; size--) {
                Fragment fragment = this.e.get(size);
                if (fragment != null && str.equals(fragment.A)) {
                    return fragment;
                }
            }
        }
        SparseArray<Fragment> sparseArray = this.f;
        if (sparseArray == null || str == null) {
            return null;
        }
        for (int size2 = sparseArray.size() - 1; size2 >= 0; size2--) {
            Fragment valueAt = this.f.valueAt(size2);
            if (valueAt != null && str.equals(valueAt.A)) {
                return valueAt;
            }
        }
        return null;
    }

    public void d1(Fragment fragment) {
        if (fragment == null || (this.f.get(fragment.f) == fragment && (fragment.t == null || fragment.s() == this))) {
            this.q = fragment;
            return;
        }
        throw new IllegalArgumentException("Fragment " + fragment + " is not an active fragment of FragmentManager " + this);
    }

    @Override // androidx.fragment.app.f
    public int e() {
        ArrayList<androidx.fragment.app.a> arrayList = this.g;
        if (arrayList != null) {
            return arrayList.size();
        }
        return 0;
    }

    /* JADX WARN: Code restructure failed: missing block: B:18:0x0027, code lost:
        return;
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void e0(androidx.fragment.app.g.l r2, boolean r3) {
        /*
            r1 = this;
            if (r3 != 0) goto L5
            r1.r()
        L5:
            monitor-enter(r1)
            boolean r0 = r1.u     // Catch: java.lang.Throwable -> L30
            if (r0 != 0) goto L24
            androidx.fragment.app.e r0 = r1.n     // Catch: java.lang.Throwable -> L30
            if (r0 != 0) goto Lf
            goto L24
        Lf:
            java.util.ArrayList<androidx.fragment.app.g$l> r3 = r1.f971b     // Catch: java.lang.Throwable -> L30
            if (r3 != 0) goto L1a
            java.util.ArrayList r3 = new java.util.ArrayList     // Catch: java.lang.Throwable -> L30
            r3.<init>()     // Catch: java.lang.Throwable -> L30
            r1.f971b = r3     // Catch: java.lang.Throwable -> L30
        L1a:
            java.util.ArrayList<androidx.fragment.app.g$l> r3 = r1.f971b     // Catch: java.lang.Throwable -> L30
            r3.add(r2)     // Catch: java.lang.Throwable -> L30
            r1.a1()     // Catch: java.lang.Throwable -> L30
            monitor-exit(r1)     // Catch: java.lang.Throwable -> L30
            return
        L24:
            if (r3 == 0) goto L28
            monitor-exit(r1)     // Catch: java.lang.Throwable -> L30
            return
        L28:
            java.lang.IllegalStateException r2 = new java.lang.IllegalStateException     // Catch: java.lang.Throwable -> L30
            java.lang.String r3 = "Activity has been destroyed"
            r2.<init>(r3)     // Catch: java.lang.Throwable -> L30
            throw r2     // Catch: java.lang.Throwable -> L30
        L30:
            r2 = move-exception
            monitor-exit(r1)     // Catch: java.lang.Throwable -> L30
            throw r2
        */
        throw new UnsupportedOperationException("Method not decompiled: androidx.fragment.app.g.e0(androidx.fragment.app.g$l, boolean):void");
    }

    @Override // androidx.fragment.app.f
    public List<Fragment> f() {
        List<Fragment> list;
        if (this.e.isEmpty()) {
            return Collections.emptyList();
        }
        synchronized (this.e) {
            list = (List) this.e.clone();
        }
        return list;
    }

    @Override // androidx.fragment.app.f
    public boolean g() {
        return this.s || this.t;
    }

    void g0(Fragment fragment) {
        if (!fragment.n || fragment.q) {
            return;
        }
        fragment.E0(fragment.I0(fragment.f927c), null, fragment.f927c);
        View view = fragment.J;
        if (view == null) {
            fragment.K = null;
            return;
        }
        fragment.K = view;
        view.setSaveFromParentEnabled(false);
        if (fragment.B) {
            fragment.J.setVisibility(8);
        }
        fragment.w0(fragment.J, fragment.f927c);
        R(fragment, fragment.J, fragment.f927c, false);
    }

    public void g1(Fragment fragment) {
        if (F) {
            Log.v("FragmentManager", "show: " + fragment);
        }
        if (fragment.B) {
            fragment.B = false;
            fragment.P = !fragment.P;
        }
    }

    @Override // androidx.fragment.app.f
    public void h() {
        e0(new m(null, -1, 0), false);
    }

    public boolean h0() {
        f0(true);
        boolean z = false;
        while (r0(this.x, this.y)) {
            this.f972c = true;
            try {
                R0(this.x, this.y);
                s();
                z = true;
            } catch (Throwable th) {
                s();
                throw th;
            }
        }
        c0();
        q();
        return z;
    }

    void h1() {
        if (this.f == null) {
            return;
        }
        for (int i2 = 0; i2 < this.f.size(); i2++) {
            Fragment valueAt = this.f.valueAt(i2);
            if (valueAt != null) {
                L0(valueAt);
            }
        }
    }

    @Override // androidx.fragment.app.f
    public boolean i() {
        r();
        return M0(null, -1, 0);
    }

    public void i0(l lVar, boolean z) {
        if (z && (this.n == null || this.u)) {
            return;
        }
        f0(z);
        if (lVar.a(this.x, this.y)) {
            this.f972c = true;
            try {
                R0(this.x, this.y);
            } finally {
                s();
            }
        }
        c0();
        q();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void k(androidx.fragment.app.a aVar) {
        if (this.g == null) {
            this.g = new ArrayList<>();
        }
        this.g.add(aVar);
    }

    public void l(Fragment fragment, boolean z) {
        if (F) {
            Log.v("FragmentManager", "add: " + fragment);
        }
        z0(fragment);
        if (fragment.C) {
            return;
        }
        if (this.e.contains(fragment)) {
            throw new IllegalStateException("Fragment already added: " + fragment);
        }
        synchronized (this.e) {
            this.e.add(fragment);
        }
        fragment.l = true;
        fragment.m = false;
        if (fragment.J == null) {
            fragment.P = false;
        }
        if (fragment.F && fragment.G) {
            this.r = true;
        }
        if (z) {
            I0(fragment);
        }
    }

    public int m(androidx.fragment.app.a aVar) {
        synchronized (this) {
            ArrayList<Integer> arrayList = this.j;
            if (arrayList != null && arrayList.size() > 0) {
                ArrayList<Integer> arrayList2 = this.j;
                int intValue = arrayList2.remove(arrayList2.size() - 1).intValue();
                if (F) {
                    Log.v("FragmentManager", "Adding back stack index " + intValue + " with " + aVar);
                }
                this.i.set(intValue, aVar);
                return intValue;
            }
            if (this.i == null) {
                this.i = new ArrayList<>();
            }
            int size = this.i.size();
            if (F) {
                Log.v("FragmentManager", "Setting back stack index " + size + " to " + aVar);
            }
            this.i.add(aVar);
            return size;
        }
    }

    public Fragment m0(int i2) {
        for (int size = this.e.size() - 1; size >= 0; size--) {
            Fragment fragment = this.e.get(size);
            if (fragment != null && fragment.y == i2) {
                return fragment;
            }
        }
        SparseArray<Fragment> sparseArray = this.f;
        if (sparseArray != null) {
            for (int size2 = sparseArray.size() - 1; size2 >= 0; size2--) {
                Fragment valueAt = this.f.valueAt(size2);
                if (valueAt != null && valueAt.y == i2) {
                    return valueAt;
                }
            }
            return null;
        }
        return null;
    }

    public Fragment n0(String str) {
        Fragment e2;
        SparseArray<Fragment> sparseArray = this.f;
        if (sparseArray == null || str == null) {
            return null;
        }
        for (int size = sparseArray.size() - 1; size >= 0; size--) {
            Fragment valueAt = this.f.valueAt(size);
            if (valueAt != null && (e2 = valueAt.e(str)) != null) {
                return e2;
            }
        }
        return null;
    }

    public void o(androidx.fragment.app.e eVar, androidx.fragment.app.c cVar, Fragment fragment) {
        if (this.n != null) {
            throw new IllegalStateException("Already attached");
        }
        this.n = eVar;
        this.o = cVar;
        this.p = fragment;
    }

    @Override // android.view.LayoutInflater.Factory2
    public View onCreateView(View view, String str, Context context, AttributeSet attributeSet) {
        if ("fragment".equals(str)) {
            String attributeValue = attributeSet.getAttributeValue(null, "class");
            TypedArray obtainStyledAttributes = context.obtainStyledAttributes(attributeSet, k.f997a);
            if (attributeValue == null) {
                attributeValue = obtainStyledAttributes.getString(0);
            }
            String str2 = attributeValue;
            int resourceId = obtainStyledAttributes.getResourceId(1, -1);
            String string = obtainStyledAttributes.getString(2);
            obtainStyledAttributes.recycle();
            if (Fragment.Q(this.n.e(), str2)) {
                int id = view != null ? view.getId() : 0;
                if (id == -1 && resourceId == -1 && string == null) {
                    throw new IllegalArgumentException(attributeSet.getPositionDescription() + ": Must specify unique android:id, android:tag, or have a parent with an id for " + str2);
                }
                Fragment m0 = resourceId != -1 ? m0(resourceId) : null;
                if (m0 == null && string != null) {
                    m0 = d(string);
                }
                if (m0 == null && id != -1) {
                    m0 = m0(id);
                }
                if (F) {
                    Log.v("FragmentManager", "onCreateView: id=0x" + Integer.toHexString(resourceId) + " fname=" + str2 + " existing=" + m0);
                }
                if (m0 == null) {
                    m0 = this.o.a(context, str2, null);
                    m0.n = true;
                    m0.y = resourceId != 0 ? resourceId : id;
                    m0.z = id;
                    m0.A = string;
                    m0.o = true;
                    m0.s = this;
                    androidx.fragment.app.e eVar = this.n;
                    m0.t = eVar;
                    m0.k0(eVar.e(), attributeSet, m0.f927c);
                    l(m0, true);
                } else if (m0.o) {
                    throw new IllegalArgumentException(attributeSet.getPositionDescription() + ": Duplicate id 0x" + Integer.toHexString(resourceId) + ", tag " + string + ", or parent id 0x" + Integer.toHexString(id) + " with another fragment for " + str2);
                } else {
                    m0.o = true;
                    androidx.fragment.app.e eVar2 = this.n;
                    m0.t = eVar2;
                    if (!m0.E) {
                        m0.k0(eVar2.e(), attributeSet, m0.f927c);
                    }
                }
                Fragment fragment = m0;
                if (this.m >= 1 || !fragment.n) {
                    I0(fragment);
                } else {
                    J0(fragment, 1, 0, 0, false);
                }
                View view2 = fragment.J;
                if (view2 != null) {
                    if (resourceId != 0) {
                        view2.setId(resourceId);
                    }
                    if (fragment.J.getTag() == null) {
                        fragment.J.setTag(string);
                    }
                    return fragment.J;
                }
                throw new IllegalStateException("Fragment " + str2 + " did not create a view.");
            }
            return null;
        }
        return null;
    }

    @Override // android.view.LayoutInflater.Factory
    public View onCreateView(String str, Context context, AttributeSet attributeSet) {
        return onCreateView(null, str, context, attributeSet);
    }

    public void p(Fragment fragment) {
        if (F) {
            Log.v("FragmentManager", "attach: " + fragment);
        }
        if (fragment.C) {
            fragment.C = false;
            if (fragment.l) {
                return;
            }
            if (this.e.contains(fragment)) {
                throw new IllegalStateException("Fragment already added: " + fragment);
            }
            if (F) {
                Log.v("FragmentManager", "add from attach: " + fragment);
            }
            synchronized (this.e) {
                this.e.add(fragment);
            }
            fragment.l = true;
            if (fragment.F && fragment.G) {
                this.r = true;
            }
        }
    }

    public void q0(int i2) {
        synchronized (this) {
            this.i.set(i2, null);
            if (this.j == null) {
                this.j = new ArrayList<>();
            }
            if (F) {
                Log.v("FragmentManager", "Freeing back stack index " + i2);
            }
            this.j.add(Integer.valueOf(i2));
        }
    }

    void t(androidx.fragment.app.a aVar, boolean z, boolean z2, boolean z3) {
        if (z) {
            aVar.r(z3);
        } else {
            aVar.q();
        }
        ArrayList arrayList = new ArrayList(1);
        ArrayList arrayList2 = new ArrayList(1);
        arrayList.add(aVar);
        arrayList2.add(Boolean.valueOf(z));
        if (z2) {
            androidx.fragment.app.k.C(this, arrayList, arrayList2, 0, 1, true);
        }
        if (z3) {
            H0(this.m, true);
        }
        SparseArray<Fragment> sparseArray = this.f;
        if (sparseArray != null) {
            int size = sparseArray.size();
            for (int i2 = 0; i2 < size; i2++) {
                Fragment valueAt = this.f.valueAt(i2);
                if (valueAt != null && valueAt.J != null && valueAt.O && aVar.u(valueAt.z)) {
                    float f2 = valueAt.Q;
                    if (f2 > 0.0f) {
                        valueAt.J.setAlpha(f2);
                    }
                    if (z3) {
                        valueAt.Q = 0.0f;
                    } else {
                        valueAt.Q = -1.0f;
                        valueAt.O = false;
                    }
                }
            }
        }
    }

    public Fragment t0(Bundle bundle, String str) {
        int i2 = bundle.getInt(str, -1);
        if (i2 == -1) {
            return null;
        }
        Fragment fragment = this.f.get(i2);
        if (fragment != null) {
            return fragment;
        }
        i1(new IllegalStateException("Fragment no longer exists for key " + str + ": index " + i2));
        throw null;
    }

    public String toString() {
        StringBuilder sb = new StringBuilder(128);
        sb.append("FragmentManager{");
        sb.append(Integer.toHexString(System.identityHashCode(this)));
        sb.append(" in ");
        Object obj = this.p;
        if (obj == null) {
            obj = this.n;
        }
        a.f.k.a.a(obj, sb);
        sb.append("}}");
        return sb.toString();
    }

    void u(Fragment fragment) {
        Animator animator;
        if (fragment.J != null) {
            C0036g y0 = y0(fragment, fragment.v(), !fragment.B, fragment.w());
            if (y0 == null || (animator = y0.f990b) == null) {
                if (y0 != null) {
                    c1(fragment.J, y0);
                    fragment.J.startAnimation(y0.f989a);
                    y0.f989a.start();
                }
                fragment.J.setVisibility((!fragment.B || fragment.M()) ? 0 : 8);
                if (fragment.M()) {
                    fragment.a1(false);
                }
            } else {
                animator.setTarget(fragment.J);
                if (!fragment.B) {
                    fragment.J.setVisibility(0);
                } else if (fragment.M()) {
                    fragment.a1(false);
                } else {
                    ViewGroup viewGroup = fragment.I;
                    View view = fragment.J;
                    viewGroup.startViewTransition(view);
                    y0.f990b.addListener(new d(this, viewGroup, view, fragment));
                }
                c1(fragment.J, y0);
                y0.f990b.start();
            }
        }
        if (fragment.l && fragment.F && fragment.G) {
            this.r = true;
        }
        fragment.P = false;
        fragment.i0(fragment.B);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public LayoutInflater.Factory2 u0() {
        return this;
    }

    public void v(Fragment fragment) {
        if (F) {
            Log.v("FragmentManager", "detach: " + fragment);
        }
        if (fragment.C) {
            return;
        }
        fragment.C = true;
        if (fragment.l) {
            if (F) {
                Log.v("FragmentManager", "remove from detach: " + fragment);
            }
            synchronized (this.e) {
                this.e.remove(fragment);
            }
            if (fragment.F && fragment.G) {
                this.r = true;
            }
            fragment.l = false;
        }
    }

    public Fragment v0() {
        return this.q;
    }

    public void w() {
        this.s = false;
        this.t = false;
        a0(2);
    }

    public void w0(Fragment fragment) {
        if (F) {
            Log.v("FragmentManager", "hide: " + fragment);
        }
        if (fragment.B) {
            return;
        }
        fragment.B = true;
        fragment.P = true ^ fragment.P;
    }

    public void x(Configuration configuration) {
        for (int i2 = 0; i2 < this.e.size(); i2++) {
            Fragment fragment = this.e.get(i2);
            if (fragment != null) {
                fragment.A0(configuration);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean x0(int i2) {
        return this.m >= i2;
    }

    public boolean y(MenuItem menuItem) {
        if (this.m < 1) {
            return false;
        }
        for (int i2 = 0; i2 < this.e.size(); i2++) {
            Fragment fragment = this.e.get(i2);
            if (fragment != null && fragment.B0(menuItem)) {
                return true;
            }
        }
        return false;
    }

    C0036g y0(Fragment fragment, int i2, boolean z, int i3) {
        int j1;
        int u = fragment.u();
        Animation Z = fragment.Z(i2, z, u);
        if (Z != null) {
            return new C0036g(Z);
        }
        Animator a0 = fragment.a0(i2, z, u);
        if (a0 != null) {
            return new C0036g(a0);
        }
        if (u != 0) {
            boolean equals = "anim".equals(this.n.e().getResources().getResourceTypeName(u));
            boolean z2 = false;
            if (equals) {
                try {
                    Animation loadAnimation = AnimationUtils.loadAnimation(this.n.e(), u);
                    if (loadAnimation != null) {
                        return new C0036g(loadAnimation);
                    }
                    z2 = true;
                } catch (Resources.NotFoundException e2) {
                    throw e2;
                } catch (RuntimeException unused) {
                }
            }
            if (!z2) {
                try {
                    Animator loadAnimator = AnimatorInflater.loadAnimator(this.n.e(), u);
                    if (loadAnimator != null) {
                        return new C0036g(loadAnimator);
                    }
                } catch (RuntimeException e3) {
                    if (equals) {
                        throw e3;
                    }
                    Animation loadAnimation2 = AnimationUtils.loadAnimation(this.n.e(), u);
                    if (loadAnimation2 != null) {
                        return new C0036g(loadAnimation2);
                    }
                }
            }
        }
        if (i2 != 0 && (j1 = j1(i2, z)) >= 0) {
            switch (j1) {
                case 1:
                    return C0(this.n.e(), 1.125f, 1.0f, 0.0f, 1.0f);
                case 2:
                    return C0(this.n.e(), 1.0f, 0.975f, 1.0f, 0.0f);
                case 3:
                    return C0(this.n.e(), 0.975f, 1.0f, 0.0f, 1.0f);
                case 4:
                    return C0(this.n.e(), 1.0f, 1.075f, 1.0f, 0.0f);
                case 5:
                    return A0(this.n.e(), 0.0f, 1.0f);
                case 6:
                    return A0(this.n.e(), 1.0f, 0.0f);
                default:
                    if (i3 == 0 && this.n.l()) {
                        this.n.k();
                        return null;
                    }
                    return null;
            }
        }
        return null;
    }

    public void z() {
        this.s = false;
        this.t = false;
        a0(1);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void z0(Fragment fragment) {
        if (fragment.f >= 0) {
            return;
        }
        int i2 = this.f973d;
        this.f973d = i2 + 1;
        fragment.b1(i2, this.p);
        if (this.f == null) {
            this.f = new SparseArray<>();
        }
        this.f.put(fragment.f, fragment);
        if (F) {
            Log.v("FragmentManager", "Allocated fragment index " + fragment);
        }
    }
}
