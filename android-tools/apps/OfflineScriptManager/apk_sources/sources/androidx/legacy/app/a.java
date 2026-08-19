package androidx.legacy.app;

import android.app.Fragment;
import android.os.Build;
@Deprecated
/* loaded from: classes.dex */
public class a {

    /* renamed from: a  reason: collision with root package name */
    static final e f1047a;

    /* renamed from: androidx.legacy.app.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    static class C0037a extends d {
        C0037a() {
        }

        @Override // androidx.legacy.app.a.d, androidx.legacy.app.a.e
        public void a(Fragment fragment, boolean z) {
            fragment.setUserVisibleHint(z);
        }
    }

    /* loaded from: classes.dex */
    static class b extends C0037a {
        b() {
        }
    }

    /* loaded from: classes.dex */
    static class c extends b {
        c() {
        }

        @Override // androidx.legacy.app.a.C0037a, androidx.legacy.app.a.d, androidx.legacy.app.a.e
        public void a(Fragment fragment, boolean z) {
            fragment.setUserVisibleHint(z);
        }
    }

    /* loaded from: classes.dex */
    static class d implements e {
        d() {
        }

        @Override // androidx.legacy.app.a.e
        public void a(Fragment fragment, boolean z) {
        }
    }

    /* loaded from: classes.dex */
    interface e {
        void a(Fragment fragment, boolean z);
    }

    static {
        int i = Build.VERSION.SDK_INT;
        f1047a = i >= 24 ? new c() : i >= 23 ? new b() : i >= 15 ? new C0037a() : new d();
    }

    @Deprecated
    public static void a(Fragment fragment, boolean z) {
        fragment.setMenuVisibility(z);
    }

    @Deprecated
    public static void b(Fragment fragment, boolean z) {
        f1047a.a(fragment, z);
    }
}
