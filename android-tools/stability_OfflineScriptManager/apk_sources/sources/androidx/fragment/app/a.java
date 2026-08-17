package androidx.fragment.app;

import android.util.Log;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.g;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.lang.reflect.Modifier;
import java.util.ArrayList;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public final class a extends j implements g.l {

    /* renamed from: a  reason: collision with root package name */
    final g f952a;

    /* renamed from: c  reason: collision with root package name */
    int f954c;

    /* renamed from: d  reason: collision with root package name */
    int f955d;
    int e;
    int f;
    int g;
    int h;
    boolean i;
    String k;
    boolean l;
    int n;
    CharSequence o;
    int p;
    CharSequence q;
    ArrayList<String> r;
    ArrayList<String> s;
    ArrayList<Runnable> u;

    /* renamed from: b  reason: collision with root package name */
    ArrayList<C0034a> f953b = new ArrayList<>();
    boolean j = true;
    int m = -1;
    boolean t = false;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: androidx.fragment.app.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public static final class C0034a {

        /* renamed from: a  reason: collision with root package name */
        int f956a;

        /* renamed from: b  reason: collision with root package name */
        Fragment f957b;

        /* renamed from: c  reason: collision with root package name */
        int f958c;

        /* renamed from: d  reason: collision with root package name */
        int f959d;
        int e;
        int f;

        /* JADX INFO: Access modifiers changed from: package-private */
        public C0034a() {
        }

        C0034a(int i, Fragment fragment) {
            this.f956a = i;
            this.f957b = fragment;
        }
    }

    public a(g gVar) {
        this.f952a = gVar;
    }

    private void n(int i, Fragment fragment, String str, int i2) {
        Class<?> cls = fragment.getClass();
        int modifiers = cls.getModifiers();
        if (cls.isAnonymousClass() || !Modifier.isPublic(modifiers) || (cls.isMemberClass() && !Modifier.isStatic(modifiers))) {
            throw new IllegalStateException("Fragment " + cls.getCanonicalName() + " must be a public static class to be  properly recreated from instance state.");
        }
        fragment.s = this.f952a;
        if (str != null) {
            String str2 = fragment.A;
            if (str2 != null && !str.equals(str2)) {
                throw new IllegalStateException("Can't change tag of fragment " + fragment + ": was " + fragment.A + " now " + str);
            }
            fragment.A = str;
        }
        if (i != 0) {
            if (i == -1) {
                throw new IllegalArgumentException("Can't add fragment " + fragment + " with tag " + str + " to container view with no id");
            }
            int i3 = fragment.y;
            if (i3 != 0 && i3 != i) {
                throw new IllegalStateException("Can't change container ID of fragment " + fragment + ": was " + fragment.y + " now " + i);
            }
            fragment.y = i;
            fragment.z = i;
        }
        j(new C0034a(i2, fragment));
    }

    private static boolean w(C0034a c0034a) {
        Fragment fragment = c0034a.f957b;
        return (fragment == null || !fragment.l || fragment.J == null || fragment.C || fragment.B || !fragment.O()) ? false : true;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public Fragment A(ArrayList<Fragment> arrayList, Fragment fragment) {
        for (int i = 0; i < this.f953b.size(); i++) {
            C0034a c0034a = this.f953b.get(i);
            int i2 = c0034a.f956a;
            if (i2 != 1) {
                if (i2 != 3) {
                    switch (i2) {
                        case 8:
                            fragment = null;
                            break;
                        case 9:
                            fragment = c0034a.f957b;
                            break;
                    }
                }
                arrayList.add(c0034a.f957b);
            }
            arrayList.remove(c0034a.f957b);
        }
        return fragment;
    }

    @Override // androidx.fragment.app.g.l
    public boolean a(ArrayList<a> arrayList, ArrayList<Boolean> arrayList2) {
        if (g.F) {
            Log.v("FragmentManager", "Run: " + this);
        }
        arrayList.add(this);
        arrayList2.add(Boolean.FALSE);
        if (this.i) {
            this.f952a.k(this);
            return true;
        }
        return true;
    }

    @Override // androidx.fragment.app.j
    public j b(int i, Fragment fragment, String str) {
        n(i, fragment, str, 1);
        return this;
    }

    @Override // androidx.fragment.app.j
    public j c(String str) {
        if (this.j) {
            this.i = true;
            this.k = str;
            return this;
        }
        throw new IllegalStateException("This FragmentTransaction is not allowed to be added to the back stack.");
    }

    @Override // androidx.fragment.app.j
    public j d(Fragment fragment) {
        j(new C0034a(7, fragment));
        return this;
    }

    @Override // androidx.fragment.app.j
    public int e() {
        return l(false);
    }

    @Override // androidx.fragment.app.j
    public void f() {
        m();
        this.f952a.i0(this, true);
    }

    @Override // androidx.fragment.app.j
    public j g(Fragment fragment) {
        j(new C0034a(6, fragment));
        return this;
    }

    @Override // androidx.fragment.app.j
    public j h(int i, Fragment fragment) {
        i(i, fragment, null);
        return this;
    }

    @Override // androidx.fragment.app.j
    public j i(int i, Fragment fragment, String str) {
        if (i != 0) {
            n(i, fragment, str, 2);
            return this;
        }
        throw new IllegalArgumentException("Must use non-zero containerViewId");
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void j(C0034a c0034a) {
        this.f953b.add(c0034a);
        c0034a.f958c = this.f954c;
        c0034a.f959d = this.f955d;
        c0034a.e = this.e;
        c0034a.f = this.f;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void k(int i) {
        C0034a c0034a;
        if (this.i) {
            if (g.F) {
                Log.v("FragmentManager", "Bump nesting in " + this + " by " + i);
            }
            int size = this.f953b.size();
            for (int i2 = 0; i2 < size; i2++) {
                Fragment fragment = this.f953b.get(i2).f957b;
                if (fragment != null) {
                    fragment.r += i;
                    if (g.F) {
                        Log.v("FragmentManager", "Bump nesting of " + c0034a.f957b + " to " + c0034a.f957b.r);
                    }
                }
            }
        }
    }

    int l(boolean z) {
        if (this.l) {
            throw new IllegalStateException("commit already called");
        }
        if (g.F) {
            Log.v("FragmentManager", "Commit: " + this);
            PrintWriter printWriter = new PrintWriter(new a.f.k.b("FragmentManager"));
            o("  ", null, printWriter, null);
            printWriter.close();
        }
        this.l = true;
        this.m = this.i ? this.f952a.m(this) : -1;
        this.f952a.e0(this, z);
        return this.m;
    }

    public j m() {
        if (this.i) {
            throw new IllegalStateException("This transaction is already being added to the back stack");
        }
        this.j = false;
        return this;
    }

    public void o(String str, FileDescriptor fileDescriptor, PrintWriter printWriter, String[] strArr) {
        p(str, printWriter, true);
    }

    public void p(String str, PrintWriter printWriter, boolean z) {
        String str2;
        if (z) {
            printWriter.print(str);
            printWriter.print("mName=");
            printWriter.print(this.k);
            printWriter.print(" mIndex=");
            printWriter.print(this.m);
            printWriter.print(" mCommitted=");
            printWriter.println(this.l);
            if (this.g != 0) {
                printWriter.print(str);
                printWriter.print("mTransition=#");
                printWriter.print(Integer.toHexString(this.g));
                printWriter.print(" mTransitionStyle=#");
                printWriter.println(Integer.toHexString(this.h));
            }
            if (this.f954c != 0 || this.f955d != 0) {
                printWriter.print(str);
                printWriter.print("mEnterAnim=#");
                printWriter.print(Integer.toHexString(this.f954c));
                printWriter.print(" mExitAnim=#");
                printWriter.println(Integer.toHexString(this.f955d));
            }
            if (this.e != 0 || this.f != 0) {
                printWriter.print(str);
                printWriter.print("mPopEnterAnim=#");
                printWriter.print(Integer.toHexString(this.e));
                printWriter.print(" mPopExitAnim=#");
                printWriter.println(Integer.toHexString(this.f));
            }
            if (this.n != 0 || this.o != null) {
                printWriter.print(str);
                printWriter.print("mBreadCrumbTitleRes=#");
                printWriter.print(Integer.toHexString(this.n));
                printWriter.print(" mBreadCrumbTitleText=");
                printWriter.println(this.o);
            }
            if (this.p != 0 || this.q != null) {
                printWriter.print(str);
                printWriter.print("mBreadCrumbShortTitleRes=#");
                printWriter.print(Integer.toHexString(this.p));
                printWriter.print(" mBreadCrumbShortTitleText=");
                printWriter.println(this.q);
            }
        }
        if (this.f953b.isEmpty()) {
            return;
        }
        printWriter.print(str);
        printWriter.println("Operations:");
        String str3 = str + "    ";
        int size = this.f953b.size();
        for (int i = 0; i < size; i++) {
            C0034a c0034a = this.f953b.get(i);
            switch (c0034a.f956a) {
                case 0:
                    str2 = "NULL";
                    break;
                case 1:
                    str2 = "ADD";
                    break;
                case 2:
                    str2 = "REPLACE";
                    break;
                case 3:
                    str2 = "REMOVE";
                    break;
                case 4:
                    str2 = "HIDE";
                    break;
                case 5:
                    str2 = "SHOW";
                    break;
                case 6:
                    str2 = "DETACH";
                    break;
                case 7:
                    str2 = "ATTACH";
                    break;
                case 8:
                    str2 = "SET_PRIMARY_NAV";
                    break;
                case 9:
                    str2 = "UNSET_PRIMARY_NAV";
                    break;
                default:
                    str2 = "cmd=" + c0034a.f956a;
                    break;
            }
            printWriter.print(str);
            printWriter.print("  Op #");
            printWriter.print(i);
            printWriter.print(": ");
            printWriter.print(str2);
            printWriter.print(" ");
            printWriter.println(c0034a.f957b);
            if (z) {
                if (c0034a.f958c != 0 || c0034a.f959d != 0) {
                    printWriter.print(str);
                    printWriter.print("enterAnim=#");
                    printWriter.print(Integer.toHexString(c0034a.f958c));
                    printWriter.print(" exitAnim=#");
                    printWriter.println(Integer.toHexString(c0034a.f959d));
                }
                if (c0034a.e != 0 || c0034a.f != 0) {
                    printWriter.print(str);
                    printWriter.print("popEnterAnim=#");
                    printWriter.print(Integer.toHexString(c0034a.e));
                    printWriter.print(" popExitAnim=#");
                    printWriter.println(Integer.toHexString(c0034a.f));
                }
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void q() {
        int size = this.f953b.size();
        for (int i = 0; i < size; i++) {
            C0034a c0034a = this.f953b.get(i);
            Fragment fragment = c0034a.f957b;
            if (fragment != null) {
                fragment.e1(this.g, this.h);
            }
            switch (c0034a.f956a) {
                case 1:
                    fragment.d1(c0034a.f958c);
                    this.f952a.l(fragment, false);
                    break;
                case 2:
                default:
                    throw new IllegalArgumentException("Unknown cmd: " + c0034a.f956a);
                case 3:
                    fragment.d1(c0034a.f959d);
                    this.f952a.Q0(fragment);
                    break;
                case 4:
                    fragment.d1(c0034a.f959d);
                    this.f952a.w0(fragment);
                    break;
                case 5:
                    fragment.d1(c0034a.f958c);
                    this.f952a.g1(fragment);
                    break;
                case 6:
                    fragment.d1(c0034a.f959d);
                    this.f952a.v(fragment);
                    break;
                case 7:
                    fragment.d1(c0034a.f958c);
                    this.f952a.p(fragment);
                    break;
                case 8:
                    this.f952a.d1(fragment);
                    break;
                case 9:
                    this.f952a.d1(null);
                    break;
            }
            if (!this.t && c0034a.f956a != 1 && fragment != null) {
                this.f952a.G0(fragment);
            }
        }
        if (this.t) {
            return;
        }
        g gVar = this.f952a;
        gVar.H0(gVar.m, true);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void r(boolean z) {
        for (int size = this.f953b.size() - 1; size >= 0; size--) {
            C0034a c0034a = this.f953b.get(size);
            Fragment fragment = c0034a.f957b;
            if (fragment != null) {
                fragment.e1(g.V0(this.g), this.h);
            }
            switch (c0034a.f956a) {
                case 1:
                    fragment.d1(c0034a.f);
                    this.f952a.Q0(fragment);
                    break;
                case 2:
                default:
                    throw new IllegalArgumentException("Unknown cmd: " + c0034a.f956a);
                case 3:
                    fragment.d1(c0034a.e);
                    this.f952a.l(fragment, false);
                    break;
                case 4:
                    fragment.d1(c0034a.e);
                    this.f952a.g1(fragment);
                    break;
                case 5:
                    fragment.d1(c0034a.f);
                    this.f952a.w0(fragment);
                    break;
                case 6:
                    fragment.d1(c0034a.e);
                    this.f952a.p(fragment);
                    break;
                case 7:
                    fragment.d1(c0034a.f);
                    this.f952a.v(fragment);
                    break;
                case 8:
                    this.f952a.d1(null);
                    break;
                case 9:
                    this.f952a.d1(fragment);
                    break;
            }
            if (!this.t && c0034a.f956a != 3 && fragment != null) {
                this.f952a.G0(fragment);
            }
        }
        if (this.t || !z) {
            return;
        }
        g gVar = this.f952a;
        gVar.H0(gVar.m, true);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public Fragment s(ArrayList<Fragment> arrayList, Fragment fragment) {
        Fragment fragment2 = fragment;
        int i = 0;
        while (i < this.f953b.size()) {
            C0034a c0034a = this.f953b.get(i);
            int i2 = c0034a.f956a;
            if (i2 != 1) {
                if (i2 == 2) {
                    Fragment fragment3 = c0034a.f957b;
                    int i3 = fragment3.z;
                    boolean z = false;
                    for (int size = arrayList.size() - 1; size >= 0; size--) {
                        Fragment fragment4 = arrayList.get(size);
                        if (fragment4.z == i3) {
                            if (fragment4 == fragment3) {
                                z = true;
                            } else {
                                if (fragment4 == fragment2) {
                                    this.f953b.add(i, new C0034a(9, fragment4));
                                    i++;
                                    fragment2 = null;
                                }
                                C0034a c0034a2 = new C0034a(3, fragment4);
                                c0034a2.f958c = c0034a.f958c;
                                c0034a2.e = c0034a.e;
                                c0034a2.f959d = c0034a.f959d;
                                c0034a2.f = c0034a.f;
                                this.f953b.add(i, c0034a2);
                                arrayList.remove(fragment4);
                                i++;
                            }
                        }
                    }
                    if (z) {
                        this.f953b.remove(i);
                        i--;
                    } else {
                        c0034a.f956a = 1;
                        arrayList.add(fragment3);
                    }
                } else if (i2 == 3 || i2 == 6) {
                    arrayList.remove(c0034a.f957b);
                    Fragment fragment5 = c0034a.f957b;
                    if (fragment5 == fragment2) {
                        this.f953b.add(i, new C0034a(9, fragment5));
                        i++;
                        fragment2 = null;
                    }
                } else if (i2 != 7) {
                    if (i2 == 8) {
                        this.f953b.add(i, new C0034a(9, fragment2));
                        i++;
                        fragment2 = c0034a.f957b;
                    }
                }
                i++;
            }
            arrayList.add(c0034a.f957b);
            i++;
        }
        return fragment2;
    }

    public String t() {
        return this.k;
    }

    public String toString() {
        StringBuilder sb = new StringBuilder(128);
        sb.append("BackStackEntry{");
        sb.append(Integer.toHexString(System.identityHashCode(this)));
        if (this.m >= 0) {
            sb.append(" #");
            sb.append(this.m);
        }
        if (this.k != null) {
            sb.append(" ");
            sb.append(this.k);
        }
        sb.append("}");
        return sb.toString();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean u(int i) {
        int size = this.f953b.size();
        for (int i2 = 0; i2 < size; i2++) {
            Fragment fragment = this.f953b.get(i2).f957b;
            int i3 = fragment != null ? fragment.z : 0;
            if (i3 != 0 && i3 == i) {
                return true;
            }
        }
        return false;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean v(ArrayList<a> arrayList, int i, int i2) {
        if (i2 == i) {
            return false;
        }
        int size = this.f953b.size();
        int i3 = -1;
        for (int i4 = 0; i4 < size; i4++) {
            Fragment fragment = this.f953b.get(i4).f957b;
            int i5 = fragment != null ? fragment.z : 0;
            if (i5 != 0 && i5 != i3) {
                for (int i6 = i; i6 < i2; i6++) {
                    a aVar = arrayList.get(i6);
                    int size2 = aVar.f953b.size();
                    for (int i7 = 0; i7 < size2; i7++) {
                        Fragment fragment2 = aVar.f953b.get(i7).f957b;
                        if ((fragment2 != null ? fragment2.z : 0) == i5) {
                            return true;
                        }
                    }
                }
                i3 = i5;
            }
        }
        return false;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean x() {
        for (int i = 0; i < this.f953b.size(); i++) {
            if (w(this.f953b.get(i))) {
                return true;
            }
        }
        return false;
    }

    public void y() {
        ArrayList<Runnable> arrayList = this.u;
        if (arrayList != null) {
            int size = arrayList.size();
            for (int i = 0; i < size; i++) {
                this.u.get(i).run();
            }
            this.u = null;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void z(Fragment.f fVar) {
        for (int i = 0; i < this.f953b.size(); i++) {
            C0034a c0034a = this.f953b.get(i);
            if (w(c0034a)) {
                c0034a.f957b.f1(fVar);
            }
        }
    }
}
