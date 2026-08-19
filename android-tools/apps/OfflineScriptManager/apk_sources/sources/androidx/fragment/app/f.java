package androidx.fragment.app;

import android.content.Context;
import android.os.Bundle;
import android.view.View;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.List;
/* loaded from: classes.dex */
public abstract class f {

    /* loaded from: classes.dex */
    public static abstract class a {
        public abstract void a(f fVar, Fragment fragment, Bundle bundle);

        public abstract void b(f fVar, Fragment fragment, Context context);

        public abstract void c(f fVar, Fragment fragment, Bundle bundle);

        public abstract void d(f fVar, Fragment fragment);

        public abstract void e(f fVar, Fragment fragment);

        public abstract void f(f fVar, Fragment fragment);

        public abstract void g(f fVar, Fragment fragment, Context context);

        public abstract void h(f fVar, Fragment fragment, Bundle bundle);

        public abstract void i(f fVar, Fragment fragment);

        public abstract void j(f fVar, Fragment fragment, Bundle bundle);

        public abstract void k(f fVar, Fragment fragment);

        public abstract void l(f fVar, Fragment fragment);

        public abstract void m(f fVar, Fragment fragment, View view, Bundle bundle);

        public abstract void n(f fVar, Fragment fragment);
    }

    /* loaded from: classes.dex */
    public interface b {
        void a();
    }

    public abstract j a();

    public abstract void b(String str, FileDescriptor fileDescriptor, PrintWriter printWriter, String[] strArr);

    public abstract boolean c();

    public abstract Fragment d(String str);

    public abstract int e();

    public abstract List<Fragment> f();

    public abstract boolean g();

    public abstract void h();

    public abstract boolean i();
}
