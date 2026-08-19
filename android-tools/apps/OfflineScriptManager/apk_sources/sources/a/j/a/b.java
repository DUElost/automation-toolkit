package a.j.a;

import a.d.h;
import android.os.Bundle;
import android.util.Log;
import androidx.lifecycle.g;
import androidx.lifecycle.l;
import androidx.lifecycle.m;
import androidx.lifecycle.p;
import androidx.lifecycle.q;
import androidx.lifecycle.r;
import java.io.FileDescriptor;
import java.io.PrintWriter;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class b extends a.j.a.a {

    /* renamed from: c  reason: collision with root package name */
    static boolean f231c = false;

    /* renamed from: a  reason: collision with root package name */
    private final g f232a;

    /* renamed from: b  reason: collision with root package name */
    private final c f233b;

    /* loaded from: classes.dex */
    public static class a<D> extends l<D> {
        private final int j;
        private final Bundle k;
        private final a.j.b.a<D> l;
        private g m;
        private C0015b<D> n;
        private a.j.b.a<D> o;

        @Override // androidx.lifecycle.LiveData
        protected void e() {
            if (b.f231c) {
                Log.v("LoaderManager", "  Starting: " + this);
            }
            this.l.d();
            throw null;
        }

        @Override // androidx.lifecycle.LiveData
        protected void f() {
            if (b.f231c) {
                Log.v("LoaderManager", "  Stopping: " + this);
            }
            this.l.e();
            throw null;
        }

        /* JADX WARN: Multi-variable type inference failed */
        @Override // androidx.lifecycle.LiveData
        public void g(m<? super D> mVar) {
            super.g(mVar);
            this.m = null;
        }

        @Override // androidx.lifecycle.l, androidx.lifecycle.LiveData
        public void h(D d2) {
            super.h(d2);
            a.j.b.a<D> aVar = this.o;
            if (aVar == null) {
                return;
            }
            aVar.c();
            throw null;
        }

        a.j.b.a<D> i(boolean z) {
            if (b.f231c) {
                Log.v("LoaderManager", "  Destroying: " + this);
            }
            this.l.a();
            throw null;
        }

        public void j(String str, FileDescriptor fileDescriptor, PrintWriter printWriter, String[] strArr) {
            printWriter.print(str);
            printWriter.print("mId=");
            printWriter.print(this.j);
            printWriter.print(" mArgs=");
            printWriter.println(this.k);
            printWriter.print(str);
            printWriter.print("mLoader=");
            printWriter.println(this.l);
            a.j.b.a<D> aVar = this.l;
            aVar.b(str + "  ", fileDescriptor, printWriter, strArr);
            throw null;
        }

        void k() {
            g gVar = this.m;
            C0015b<D> c0015b = this.n;
            if (gVar == null || c0015b == null) {
                return;
            }
            super.g(c0015b);
            d(gVar, c0015b);
        }

        public String toString() {
            StringBuilder sb = new StringBuilder(64);
            sb.append("LoaderInfo{");
            sb.append(Integer.toHexString(System.identityHashCode(this)));
            sb.append(" #");
            sb.append(this.j);
            sb.append(" : ");
            a.f.k.a.a(this.l, sb);
            sb.append("}}");
            return sb.toString();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: a.j.a.b$b  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public static class C0015b<D> implements m<D> {
    }

    /* loaded from: classes.dex */
    static class c extends p {

        /* renamed from: b  reason: collision with root package name */
        private static final q.a f234b = new a();

        /* renamed from: a  reason: collision with root package name */
        private h<a> f235a = new h<>();

        /* loaded from: classes.dex */
        static class a implements q.a {
            a() {
            }

            @Override // androidx.lifecycle.q.a
            public <T extends p> T a(Class<T> cls) {
                return new c();
            }
        }

        c() {
        }

        static c c(r rVar) {
            return (c) new q(rVar, f234b).a(c.class);
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // androidx.lifecycle.p
        public void a() {
            super.a();
            if (this.f235a.l() <= 0) {
                this.f235a.b();
            } else {
                this.f235a.m(0).i(true);
                throw null;
            }
        }

        public void b(String str, FileDescriptor fileDescriptor, PrintWriter printWriter, String[] strArr) {
            if (this.f235a.l() > 0) {
                printWriter.print(str);
                printWriter.println("Loaders:");
                String str2 = str + "    ";
                if (this.f235a.l() <= 0) {
                    return;
                }
                a m = this.f235a.m(0);
                printWriter.print(str);
                printWriter.print("  #");
                printWriter.print(this.f235a.i(0));
                printWriter.print(": ");
                printWriter.println(m.toString());
                m.j(str2, fileDescriptor, printWriter, strArr);
                throw null;
            }
        }

        void d() {
            int l = this.f235a.l();
            for (int i = 0; i < l; i++) {
                this.f235a.m(i).k();
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public b(g gVar, r rVar) {
        this.f232a = gVar;
        this.f233b = c.c(rVar);
    }

    @Override // a.j.a.a
    @Deprecated
    public void a(String str, FileDescriptor fileDescriptor, PrintWriter printWriter, String[] strArr) {
        this.f233b.b(str, fileDescriptor, printWriter, strArr);
    }

    @Override // a.j.a.a
    public void c() {
        this.f233b.d();
    }

    public String toString() {
        StringBuilder sb = new StringBuilder(128);
        sb.append("LoaderManager{");
        sb.append(Integer.toHexString(System.identityHashCode(this)));
        sb.append(" in ");
        a.f.k.a.a(this.f232a, sb);
        sb.append("}}");
        return sb.toString();
    }
}
