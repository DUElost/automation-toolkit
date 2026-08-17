package androidx.fragment.app;

import android.animation.Animator;
import android.app.Activity;
import android.content.ComponentCallbacks;
import android.content.Context;
import android.content.Intent;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.os.Bundle;
import android.os.Looper;
import android.os.Parcel;
import android.os.Parcelable;
import android.util.AttributeSet;
import android.util.SparseArray;
import android.view.ContextMenu;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import androidx.lifecycle.e;
import androidx.lifecycle.r;
import androidx.lifecycle.s;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
/* loaded from: classes.dex */
public class Fragment implements ComponentCallbacks, View.OnCreateContextMenuListener, androidx.lifecycle.g, s {
    private static final a.d.g<String, Class<?>> X = new a.d.g<>();
    static final Object Y = new Object();
    String A;
    boolean B;
    boolean C;
    boolean D;
    boolean E;
    boolean F;
    boolean H;
    ViewGroup I;
    View J;
    View K;
    boolean L;
    d N;
    boolean O;
    boolean P;
    float Q;
    LayoutInflater R;
    boolean S;
    androidx.lifecycle.h U;
    androidx.lifecycle.g V;

    /* renamed from: c  reason: collision with root package name */
    Bundle f927c;

    /* renamed from: d  reason: collision with root package name */
    SparseArray<Parcelable> f928d;
    Boolean e;
    String g;
    Bundle h;
    Fragment i;
    int k;
    boolean l;
    boolean m;
    boolean n;
    boolean o;
    boolean p;
    boolean q;
    int r;
    g s;
    androidx.fragment.app.e t;
    g u;
    h v;
    r w;
    Fragment x;
    int y;
    int z;

    /* renamed from: b  reason: collision with root package name */
    int f926b = 0;
    int f = -1;
    int j = -1;
    boolean G = true;
    boolean M = true;
    androidx.lifecycle.h T = new androidx.lifecycle.h(this);
    androidx.lifecycle.l<androidx.lifecycle.g> W = new androidx.lifecycle.l<>();

    /* loaded from: classes.dex */
    public static class SavedState implements Parcelable {
        public static final Parcelable.Creator<SavedState> CREATOR = new a();

        /* renamed from: b  reason: collision with root package name */
        final Bundle f929b;

        /* loaded from: classes.dex */
        static class a implements Parcelable.ClassLoaderCreator<SavedState> {
            a() {
            }

            @Override // android.os.Parcelable.Creator
            /* renamed from: a */
            public SavedState createFromParcel(Parcel parcel) {
                return new SavedState(parcel, null);
            }

            @Override // android.os.Parcelable.ClassLoaderCreator
            /* renamed from: b */
            public SavedState createFromParcel(Parcel parcel, ClassLoader classLoader) {
                return new SavedState(parcel, classLoader);
            }

            @Override // android.os.Parcelable.Creator
            /* renamed from: c */
            public SavedState[] newArray(int i) {
                return new SavedState[i];
            }
        }

        SavedState(Parcel parcel, ClassLoader classLoader) {
            Bundle readBundle = parcel.readBundle();
            this.f929b = readBundle;
            if (classLoader == null || readBundle == null) {
                return;
            }
            readBundle.setClassLoader(classLoader);
        }

        @Override // android.os.Parcelable
        public int describeContents() {
            return 0;
        }

        @Override // android.os.Parcelable
        public void writeToParcel(Parcel parcel, int i) {
            parcel.writeBundle(this.f929b);
        }
    }

    /* loaded from: classes.dex */
    class a implements Runnable {
        a() {
        }

        @Override // java.lang.Runnable
        public void run() {
            Fragment.this.b();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b extends androidx.fragment.app.c {
        b() {
        }

        @Override // androidx.fragment.app.c
        public Fragment a(Context context, String str, Bundle bundle) {
            return Fragment.this.t.a(context, str, bundle);
        }

        @Override // androidx.fragment.app.c
        public View b(int i) {
            View view = Fragment.this.J;
            if (view != null) {
                return view.findViewById(i);
            }
            throw new IllegalStateException("Fragment does not have a view");
        }

        @Override // androidx.fragment.app.c
        public boolean c() {
            return Fragment.this.J != null;
        }
    }

    /* loaded from: classes.dex */
    class c implements androidx.lifecycle.g {
        c() {
        }

        @Override // androidx.lifecycle.g
        public androidx.lifecycle.e a() {
            Fragment fragment = Fragment.this;
            if (fragment.U == null) {
                fragment.U = new androidx.lifecycle.h(fragment.V);
            }
            return Fragment.this.U;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class d {

        /* renamed from: a  reason: collision with root package name */
        View f933a;

        /* renamed from: b  reason: collision with root package name */
        Animator f934b;

        /* renamed from: c  reason: collision with root package name */
        int f935c;

        /* renamed from: d  reason: collision with root package name */
        int f936d;
        int e;
        int f;
        Object g = null;
        Object h;
        Object i;
        Object j;
        Object k;
        Object l;
        Boolean m;
        Boolean n;
        androidx.core.app.k o;
        androidx.core.app.k p;
        boolean q;
        f r;
        boolean s;

        d() {
            Object obj = Fragment.Y;
            this.h = obj;
            this.i = null;
            this.j = obj;
            this.k = null;
            this.l = obj;
        }
    }

    /* loaded from: classes.dex */
    public static class e extends RuntimeException {
        public e(String str, Exception exc) {
            super(str, exc);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public interface f {
        void a();

        void b();
    }

    public static Fragment H(Context context, String str, Bundle bundle) {
        try {
            a.d.g<String, Class<?>> gVar = X;
            Class<?> cls = gVar.get(str);
            if (cls == null) {
                cls = context.getClassLoader().loadClass(str);
                gVar.put(str, cls);
            }
            Fragment fragment = (Fragment) cls.getConstructor(new Class[0]).newInstance(new Object[0]);
            if (bundle != null) {
                bundle.setClassLoader(fragment.getClass().getClassLoader());
                fragment.Z0(bundle);
            }
            return fragment;
        } catch (ClassNotFoundException e2) {
            throw new e("Unable to instantiate fragment " + str + ": make sure class name exists, is public, and has an empty constructor that is public", e2);
        } catch (IllegalAccessException e3) {
            throw new e("Unable to instantiate fragment " + str + ": make sure class name exists, is public, and has an empty constructor that is public", e3);
        } catch (InstantiationException e4) {
            throw new e("Unable to instantiate fragment " + str + ": make sure class name exists, is public, and has an empty constructor that is public", e4);
        } catch (NoSuchMethodException e5) {
            throw new e("Unable to instantiate fragment " + str + ": could not find Fragment constructor", e5);
        } catch (InvocationTargetException e6) {
            throw new e("Unable to instantiate fragment " + str + ": calling Fragment constructor caused an exception", e6);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static boolean Q(Context context, String str) {
        try {
            a.d.g<String, Class<?>> gVar = X;
            Class<?> cls = gVar.get(str);
            if (cls == null) {
                cls = context.getClassLoader().loadClass(str);
                gVar.put(str, cls);
            }
            return Fragment.class.isAssignableFrom(cls);
        } catch (ClassNotFoundException unused) {
            return false;
        }
    }

    private d d() {
        if (this.N == null) {
            this.N = new d();
        }
        return this.N;
    }

    public Object A() {
        d dVar = this.N;
        if (dVar == null) {
            return null;
        }
        return dVar.k;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void A0(Configuration configuration) {
        onConfigurationChanged(configuration);
        g gVar = this.u;
        if (gVar != null) {
            gVar.x(configuration);
        }
    }

    public Object B() {
        d dVar = this.N;
        if (dVar == null) {
            return null;
        }
        Object obj = dVar.l;
        return obj == Y ? A() : obj;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean B0(MenuItem menuItem) {
        if (this.B) {
            return false;
        }
        if (X(menuItem)) {
            return true;
        }
        g gVar = this.u;
        return gVar != null && gVar.y(menuItem);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int C() {
        d dVar = this.N;
        if (dVar == null) {
            return 0;
        }
        return dVar.f935c;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void C0(Bundle bundle) {
        g gVar = this.u;
        if (gVar != null) {
            gVar.K0();
        }
        this.f926b = 1;
        this.H = false;
        Y(bundle);
        this.S = true;
        if (this.H) {
            this.T.i(e.a.ON_CREATE);
            return;
        }
        throw new o("Fragment " + this + " did not call through to super.onCreate()");
    }

    public final String D(int i) {
        return y().getString(i);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean D0(Menu menu, MenuInflater menuInflater) {
        boolean z = false;
        if (this.B) {
            return false;
        }
        if (this.F && this.G) {
            b0(menu, menuInflater);
            z = true;
        }
        g gVar = this.u;
        return gVar != null ? z | gVar.A(menu, menuInflater) : z;
    }

    public final String E() {
        return this.A;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void E0(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        g gVar = this.u;
        if (gVar != null) {
            gVar.K0();
        }
        this.q = true;
        this.V = new c();
        this.U = null;
        View c0 = c0(layoutInflater, viewGroup, bundle);
        this.J = c0;
        if (c0 != null) {
            this.V.a();
            this.W.h(this.V);
        } else if (this.U != null) {
            throw new IllegalStateException("Called getViewLifecycleOwner() but onCreateView() returned null");
        } else {
            this.V = null;
        }
    }

    public View F() {
        return this.J;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void F0() {
        this.T.i(e.a.ON_DESTROY);
        g gVar = this.u;
        if (gVar != null) {
            gVar.B();
        }
        this.f926b = 0;
        this.H = false;
        this.S = false;
        d0();
        if (this.H) {
            this.u = null;
            return;
        }
        throw new o("Fragment " + this + " did not call through to super.onDestroy()");
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void G() {
        this.f = -1;
        this.g = null;
        this.l = false;
        this.m = false;
        this.n = false;
        this.o = false;
        this.p = false;
        this.r = 0;
        this.s = null;
        this.u = null;
        this.t = null;
        this.y = 0;
        this.z = 0;
        this.A = null;
        this.B = false;
        this.C = false;
        this.E = false;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void G0() {
        if (this.J != null) {
            this.U.i(e.a.ON_DESTROY);
        }
        g gVar = this.u;
        if (gVar != null) {
            gVar.C();
        }
        this.f926b = 1;
        this.H = false;
        f0();
        if (this.H) {
            a.j.a.a.b(this).c();
            this.q = false;
            return;
        }
        throw new o("Fragment " + this + " did not call through to super.onDestroyView()");
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void H0() {
        this.H = false;
        g0();
        this.R = null;
        if (!this.H) {
            throw new o("Fragment " + this + " did not call through to super.onDetach()");
        }
        g gVar = this.u;
        if (gVar != null) {
            if (this.E) {
                gVar.B();
                this.u = null;
                return;
            }
            throw new IllegalStateException("Child FragmentManager of " + this + " was not  destroyed and this fragment is not retaining instance");
        }
    }

    void I() {
        if (this.t == null) {
            throw new IllegalStateException("Fragment has not been attached yet.");
        }
        g gVar = new g();
        this.u = gVar;
        gVar.o(this.t, new b(), this);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public LayoutInflater I0(Bundle bundle) {
        LayoutInflater h0 = h0(bundle);
        this.R = h0;
        return h0;
    }

    public final boolean J() {
        return this.t != null && this.l;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void J0() {
        onLowMemory();
        g gVar = this.u;
        if (gVar != null) {
            gVar.D();
        }
    }

    public final boolean K() {
        return this.C;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void K0(boolean z) {
        l0(z);
        g gVar = this.u;
        if (gVar != null) {
            gVar.E(z);
        }
    }

    public final boolean L() {
        return this.B;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean L0(MenuItem menuItem) {
        if (this.B) {
            return false;
        }
        if (this.F && this.G && m0(menuItem)) {
            return true;
        }
        g gVar = this.u;
        return gVar != null && gVar.T(menuItem);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean M() {
        d dVar = this.N;
        if (dVar == null) {
            return false;
        }
        return dVar.s;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void M0(Menu menu) {
        if (this.B) {
            return;
        }
        if (this.F && this.G) {
            n0(menu);
        }
        g gVar = this.u;
        if (gVar != null) {
            gVar.U(menu);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final boolean N() {
        return this.r > 0;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void N0() {
        if (this.J != null) {
            this.U.i(e.a.ON_PAUSE);
        }
        this.T.i(e.a.ON_PAUSE);
        g gVar = this.u;
        if (gVar != null) {
            gVar.V();
        }
        this.f926b = 3;
        this.H = false;
        o0();
        if (this.H) {
            return;
        }
        throw new o("Fragment " + this + " did not call through to super.onPause()");
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean O() {
        d dVar = this.N;
        if (dVar == null) {
            return false;
        }
        return dVar.q;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void O0(boolean z) {
        p0(z);
        g gVar = this.u;
        if (gVar != null) {
            gVar.W(z);
        }
    }

    public final boolean P() {
        g gVar = this.s;
        if (gVar == null) {
            return false;
        }
        return gVar.g();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean P0(Menu menu) {
        boolean z = false;
        if (this.B) {
            return false;
        }
        if (this.F && this.G) {
            q0(menu);
            z = true;
        }
        g gVar = this.u;
        return gVar != null ? z | gVar.X(menu) : z;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void Q0() {
        g gVar = this.u;
        if (gVar != null) {
            gVar.K0();
            this.u.h0();
        }
        this.f926b = 4;
        this.H = false;
        s0();
        if (!this.H) {
            throw new o("Fragment " + this + " did not call through to super.onResume()");
        }
        g gVar2 = this.u;
        if (gVar2 != null) {
            gVar2.Y();
            this.u.h0();
        }
        androidx.lifecycle.h hVar = this.T;
        e.a aVar = e.a.ON_RESUME;
        hVar.i(aVar);
        if (this.J != null) {
            this.U.i(aVar);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void R() {
        g gVar = this.u;
        if (gVar != null) {
            gVar.K0();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void R0(Bundle bundle) {
        Parcelable W0;
        t0(bundle);
        g gVar = this.u;
        if (gVar == null || (W0 = gVar.W0()) == null) {
            return;
        }
        bundle.putParcelable("android:support:fragments", W0);
    }

    public void S(Bundle bundle) {
        this.H = true;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void S0() {
        g gVar = this.u;
        if (gVar != null) {
            gVar.K0();
            this.u.h0();
        }
        this.f926b = 3;
        this.H = false;
        u0();
        if (!this.H) {
            throw new o("Fragment " + this + " did not call through to super.onStart()");
        }
        g gVar2 = this.u;
        if (gVar2 != null) {
            gVar2.Z();
        }
        androidx.lifecycle.h hVar = this.T;
        e.a aVar = e.a.ON_START;
        hVar.i(aVar);
        if (this.J != null) {
            this.U.i(aVar);
        }
    }

    public void T(int i, int i2, Intent intent) {
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void T0() {
        if (this.J != null) {
            this.U.i(e.a.ON_STOP);
        }
        this.T.i(e.a.ON_STOP);
        g gVar = this.u;
        if (gVar != null) {
            gVar.b0();
        }
        this.f926b = 2;
        this.H = false;
        v0();
        if (this.H) {
            return;
        }
        throw new o("Fragment " + this + " did not call through to super.onStop()");
    }

    @Deprecated
    public void U(Activity activity) {
        this.H = true;
    }

    public final Context U0() {
        Context n = n();
        if (n != null) {
            return n;
        }
        throw new IllegalStateException("Fragment " + this + " not attached to a context.");
    }

    public void V(Context context) {
        this.H = true;
        androidx.fragment.app.e eVar = this.t;
        Activity d2 = eVar == null ? null : eVar.d();
        if (d2 != null) {
            this.H = false;
            U(d2);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void V0(Bundle bundle) {
        Parcelable parcelable;
        if (bundle == null || (parcelable = bundle.getParcelable("android:support:fragments")) == null) {
            return;
        }
        if (this.u == null) {
            I();
        }
        this.u.T0(parcelable, this.v);
        this.v = null;
        this.u.z();
    }

    public void W(Fragment fragment) {
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final void W0(Bundle bundle) {
        SparseArray<Parcelable> sparseArray = this.f928d;
        if (sparseArray != null) {
            this.K.restoreHierarchyState(sparseArray);
            this.f928d = null;
        }
        this.H = false;
        x0(bundle);
        if (this.H) {
            if (this.J != null) {
                this.U.i(e.a.ON_CREATE);
                return;
            }
            return;
        }
        throw new o("Fragment " + this + " did not call through to super.onViewStateRestored()");
    }

    public boolean X(MenuItem menuItem) {
        return false;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void X0(View view) {
        d().f933a = view;
    }

    public void Y(Bundle bundle) {
        this.H = true;
        V0(bundle);
        g gVar = this.u;
        if (gVar == null || gVar.x0(1)) {
            return;
        }
        this.u.z();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void Y0(Animator animator) {
        d().f934b = animator;
    }

    public Animation Z(int i, boolean z, int i2) {
        return null;
    }

    public void Z0(Bundle bundle) {
        if (this.f >= 0 && P()) {
            throw new IllegalStateException("Fragment already active and state has been saved");
        }
        this.h = bundle;
    }

    @Override // androidx.lifecycle.g
    public androidx.lifecycle.e a() {
        return this.T;
    }

    public Animator a0(int i, boolean z, int i2) {
        return null;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void a1(boolean z) {
        d().s = z;
    }

    void b() {
        d dVar = this.N;
        f fVar = null;
        if (dVar != null) {
            dVar.q = false;
            f fVar2 = dVar.r;
            dVar.r = null;
            fVar = fVar2;
        }
        if (fVar != null) {
            fVar.a();
        }
    }

    public void b0(Menu menu, MenuInflater menuInflater) {
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final void b1(int i, Fragment fragment) {
        StringBuilder sb;
        String str;
        this.f = i;
        if (fragment != null) {
            sb = new StringBuilder();
            sb.append(fragment.g);
            str = ":";
        } else {
            sb = new StringBuilder();
            str = "android:fragment:";
        }
        sb.append(str);
        sb.append(this.f);
        this.g = sb.toString();
    }

    public void c(String str, FileDescriptor fileDescriptor, PrintWriter printWriter, String[] strArr) {
        printWriter.print(str);
        printWriter.print("mFragmentId=#");
        printWriter.print(Integer.toHexString(this.y));
        printWriter.print(" mContainerId=#");
        printWriter.print(Integer.toHexString(this.z));
        printWriter.print(" mTag=");
        printWriter.println(this.A);
        printWriter.print(str);
        printWriter.print("mState=");
        printWriter.print(this.f926b);
        printWriter.print(" mIndex=");
        printWriter.print(this.f);
        printWriter.print(" mWho=");
        printWriter.print(this.g);
        printWriter.print(" mBackStackNesting=");
        printWriter.println(this.r);
        printWriter.print(str);
        printWriter.print("mAdded=");
        printWriter.print(this.l);
        printWriter.print(" mRemoving=");
        printWriter.print(this.m);
        printWriter.print(" mFromLayout=");
        printWriter.print(this.n);
        printWriter.print(" mInLayout=");
        printWriter.println(this.o);
        printWriter.print(str);
        printWriter.print("mHidden=");
        printWriter.print(this.B);
        printWriter.print(" mDetached=");
        printWriter.print(this.C);
        printWriter.print(" mMenuVisible=");
        printWriter.print(this.G);
        printWriter.print(" mHasMenu=");
        printWriter.println(this.F);
        printWriter.print(str);
        printWriter.print("mRetainInstance=");
        printWriter.print(this.D);
        printWriter.print(" mRetaining=");
        printWriter.print(this.E);
        printWriter.print(" mUserVisibleHint=");
        printWriter.println(this.M);
        if (this.s != null) {
            printWriter.print(str);
            printWriter.print("mFragmentManager=");
            printWriter.println(this.s);
        }
        if (this.t != null) {
            printWriter.print(str);
            printWriter.print("mHost=");
            printWriter.println(this.t);
        }
        if (this.x != null) {
            printWriter.print(str);
            printWriter.print("mParentFragment=");
            printWriter.println(this.x);
        }
        if (this.h != null) {
            printWriter.print(str);
            printWriter.print("mArguments=");
            printWriter.println(this.h);
        }
        if (this.f927c != null) {
            printWriter.print(str);
            printWriter.print("mSavedFragmentState=");
            printWriter.println(this.f927c);
        }
        if (this.f928d != null) {
            printWriter.print(str);
            printWriter.print("mSavedViewState=");
            printWriter.println(this.f928d);
        }
        if (this.i != null) {
            printWriter.print(str);
            printWriter.print("mTarget=");
            printWriter.print(this.i);
            printWriter.print(" mTargetRequestCode=");
            printWriter.println(this.k);
        }
        if (u() != 0) {
            printWriter.print(str);
            printWriter.print("mNextAnim=");
            printWriter.println(u());
        }
        if (this.I != null) {
            printWriter.print(str);
            printWriter.print("mContainer=");
            printWriter.println(this.I);
        }
        if (this.J != null) {
            printWriter.print(str);
            printWriter.print("mView=");
            printWriter.println(this.J);
        }
        if (this.K != null) {
            printWriter.print(str);
            printWriter.print("mInnerView=");
            printWriter.println(this.J);
        }
        if (i() != null) {
            printWriter.print(str);
            printWriter.print("mAnimatingAway=");
            printWriter.println(i());
            printWriter.print(str);
            printWriter.print("mStateAfterAnimating=");
            printWriter.println(C());
        }
        if (n() != null) {
            a.j.a.a.b(this).a(str, fileDescriptor, printWriter, strArr);
        }
        if (this.u != null) {
            printWriter.print(str);
            printWriter.println("Child " + this.u + ":");
            g gVar = this.u;
            gVar.b(str + "  ", fileDescriptor, printWriter, strArr);
        }
    }

    public View c0(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        return null;
    }

    public void c1(boolean z) {
        if (this.G != z) {
            this.G = z;
            if (this.F && J() && !L()) {
                this.t.o();
            }
        }
    }

    public void d0() {
        boolean z = true;
        this.H = true;
        androidx.fragment.app.b f2 = f();
        z = (f2 == null || !f2.isChangingConfigurations()) ? false : false;
        r rVar = this.w;
        if (rVar == null || z) {
            return;
        }
        rVar.a();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void d1(int i) {
        if (this.N == null && i == 0) {
            return;
        }
        d().f936d = i;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public Fragment e(String str) {
        if (str.equals(this.g)) {
            return this;
        }
        g gVar = this.u;
        if (gVar != null) {
            return gVar.n0(str);
        }
        return null;
    }

    public void e0() {
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void e1(int i, int i2) {
        if (this.N == null && i == 0 && i2 == 0) {
            return;
        }
        d();
        d dVar = this.N;
        dVar.e = i;
        dVar.f = i2;
    }

    public final boolean equals(Object obj) {
        return super.equals(obj);
    }

    public final androidx.fragment.app.b f() {
        androidx.fragment.app.e eVar = this.t;
        if (eVar == null) {
            return null;
        }
        return (androidx.fragment.app.b) eVar.d();
    }

    public void f0() {
        this.H = true;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void f1(f fVar) {
        d();
        d dVar = this.N;
        f fVar2 = dVar.r;
        if (fVar == fVar2) {
            return;
        }
        if (fVar != null && fVar2 != null) {
            throw new IllegalStateException("Trying to set a replacement startPostponedEnterTransition on " + this);
        }
        if (dVar.q) {
            dVar.r = fVar;
        }
        if (fVar != null) {
            fVar.b();
        }
    }

    public boolean g() {
        Boolean bool;
        d dVar = this.N;
        if (dVar == null || (bool = dVar.n) == null) {
            return true;
        }
        return bool.booleanValue();
    }

    public void g0() {
        this.H = true;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void g1(int i) {
        d().f935c = i;
    }

    public boolean h() {
        Boolean bool;
        d dVar = this.N;
        if (dVar == null || (bool = dVar.m) == null) {
            return true;
        }
        return bool.booleanValue();
    }

    public LayoutInflater h0(Bundle bundle) {
        return t(bundle);
    }

    public void h1(boolean z) {
        if (!this.M && z && this.f926b < 3 && this.s != null && J() && this.S) {
            this.s.L0(this);
        }
        this.M = z;
        this.L = this.f926b < 3 && !z;
        if (this.f927c != null) {
            this.e = Boolean.valueOf(z);
        }
    }

    public final int hashCode() {
        return super.hashCode();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public View i() {
        d dVar = this.N;
        if (dVar == null) {
            return null;
        }
        return dVar.f933a;
    }

    public void i0(boolean z) {
    }

    public void i1(Intent intent, int i) {
        j1(intent, i, null);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public Animator j() {
        d dVar = this.N;
        if (dVar == null) {
            return null;
        }
        return dVar.f934b;
    }

    @Deprecated
    public void j0(Activity activity, AttributeSet attributeSet, Bundle bundle) {
        this.H = true;
    }

    public void j1(Intent intent, int i, Bundle bundle) {
        androidx.fragment.app.e eVar = this.t;
        if (eVar != null) {
            eVar.n(this, intent, i, bundle);
            return;
        }
        throw new IllegalStateException("Fragment " + this + " not attached to Activity");
    }

    @Override // androidx.lifecycle.s
    public r k() {
        if (n() != null) {
            if (this.w == null) {
                this.w = new r();
            }
            return this.w;
        }
        throw new IllegalStateException("Can't access ViewModels from detached fragment");
    }

    public void k0(Context context, AttributeSet attributeSet, Bundle bundle) {
        this.H = true;
        androidx.fragment.app.e eVar = this.t;
        Activity d2 = eVar == null ? null : eVar.d();
        if (d2 != null) {
            this.H = false;
            j0(d2, attributeSet, bundle);
        }
    }

    public void k1() {
        g gVar = this.s;
        if (gVar == null || gVar.n == null) {
            d().q = false;
        } else if (Looper.myLooper() != this.s.n.g().getLooper()) {
            this.s.n.g().postAtFrontOfQueue(new a());
        } else {
            b();
        }
    }

    public final Bundle l() {
        return this.h;
    }

    public void l0(boolean z) {
    }

    public final androidx.fragment.app.f m() {
        if (this.u == null) {
            I();
            int i = this.f926b;
            if (i >= 4) {
                this.u.Y();
            } else if (i >= 3) {
                this.u.Z();
            } else if (i >= 2) {
                this.u.w();
            } else if (i >= 1) {
                this.u.z();
            }
        }
        return this.u;
    }

    public boolean m0(MenuItem menuItem) {
        return false;
    }

    public Context n() {
        androidx.fragment.app.e eVar = this.t;
        if (eVar == null) {
            return null;
        }
        return eVar.e();
    }

    public void n0(Menu menu) {
    }

    public Object o() {
        d dVar = this.N;
        if (dVar == null) {
            return null;
        }
        return dVar.g;
    }

    public void o0() {
        this.H = true;
    }

    @Override // android.content.ComponentCallbacks
    public void onConfigurationChanged(Configuration configuration) {
        this.H = true;
    }

    @Override // android.view.View.OnCreateContextMenuListener
    public void onCreateContextMenu(ContextMenu contextMenu, View view, ContextMenu.ContextMenuInfo contextMenuInfo) {
        f().onCreateContextMenu(contextMenu, view, contextMenuInfo);
    }

    @Override // android.content.ComponentCallbacks
    public void onLowMemory() {
        this.H = true;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public androidx.core.app.k p() {
        d dVar = this.N;
        if (dVar == null) {
            return null;
        }
        return dVar.o;
    }

    public void p0(boolean z) {
    }

    public Object q() {
        d dVar = this.N;
        if (dVar == null) {
            return null;
        }
        return dVar.i;
    }

    public void q0(Menu menu) {
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public androidx.core.app.k r() {
        d dVar = this.N;
        if (dVar == null) {
            return null;
        }
        return dVar.p;
    }

    public void r0(int i, String[] strArr, int[] iArr) {
    }

    public final androidx.fragment.app.f s() {
        return this.s;
    }

    public void s0() {
        this.H = true;
    }

    @Deprecated
    public LayoutInflater t(Bundle bundle) {
        androidx.fragment.app.e eVar = this.t;
        if (eVar != null) {
            LayoutInflater j = eVar.j();
            m();
            g gVar = this.u;
            gVar.u0();
            a.f.l.e.b(j, gVar);
            return j;
        }
        throw new IllegalStateException("onGetLayoutInflater() cannot be executed until the Fragment is attached to the FragmentManager.");
    }

    public void t0(Bundle bundle) {
    }

    public String toString() {
        StringBuilder sb = new StringBuilder(128);
        a.f.k.a.a(this, sb);
        if (this.f >= 0) {
            sb.append(" #");
            sb.append(this.f);
        }
        if (this.y != 0) {
            sb.append(" id=0x");
            sb.append(Integer.toHexString(this.y));
        }
        if (this.A != null) {
            sb.append(" ");
            sb.append(this.A);
        }
        sb.append('}');
        return sb.toString();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int u() {
        d dVar = this.N;
        if (dVar == null) {
            return 0;
        }
        return dVar.f936d;
    }

    public void u0() {
        this.H = true;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int v() {
        d dVar = this.N;
        if (dVar == null) {
            return 0;
        }
        return dVar.e;
    }

    public void v0() {
        this.H = true;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int w() {
        d dVar = this.N;
        if (dVar == null) {
            return 0;
        }
        return dVar.f;
    }

    public void w0(View view, Bundle bundle) {
    }

    public Object x() {
        d dVar = this.N;
        if (dVar == null) {
            return null;
        }
        Object obj = dVar.j;
        return obj == Y ? q() : obj;
    }

    public void x0(Bundle bundle) {
        this.H = true;
    }

    public final Resources y() {
        return U0().getResources();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public androidx.fragment.app.f y0() {
        return this.u;
    }

    public Object z() {
        d dVar = this.N;
        if (dVar == null) {
            return null;
        }
        Object obj = dVar.h;
        return obj == Y ? o() : obj;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void z0(Bundle bundle) {
        g gVar = this.u;
        if (gVar != null) {
            gVar.K0();
        }
        this.f926b = 2;
        this.H = false;
        S(bundle);
        if (this.H) {
            g gVar2 = this.u;
            if (gVar2 != null) {
                gVar2.w();
                return;
            }
            return;
        }
        throw new o("Fragment " + this + " did not call through to super.onActivityCreated()");
    }
}
