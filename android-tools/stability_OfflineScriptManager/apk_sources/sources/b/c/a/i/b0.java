package b.c.a.i;

import c.b.a.a.a;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.List;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class b0 extends b.e.a.c {
    private static final /* synthetic */ a.InterfaceC0057a n = null;
    private static final /* synthetic */ a.InterfaceC0057a o = null;
    private List<a> m;

    /* loaded from: classes.dex */
    public static class a {

        /* renamed from: a  reason: collision with root package name */
        private long f1435a;

        /* renamed from: b  reason: collision with root package name */
        private List<C0047a> f1436b = new ArrayList();

        /* renamed from: b.c.a.i.b0$a$a  reason: collision with other inner class name */
        /* loaded from: classes.dex */
        public static class C0047a {

            /* renamed from: a  reason: collision with root package name */
            private long f1437a;

            /* renamed from: b  reason: collision with root package name */
            private int f1438b;

            /* renamed from: c  reason: collision with root package name */
            private int f1439c;

            /* renamed from: d  reason: collision with root package name */
            private long f1440d;

            public int a() {
                return this.f1439c;
            }

            public long b() {
                return this.f1440d;
            }

            public int c() {
                return this.f1438b;
            }

            public long d() {
                return this.f1437a;
            }

            public void e(int i) {
                this.f1439c = i;
            }

            public void f(long j) {
                this.f1440d = j;
            }

            public void g(int i) {
                this.f1438b = i;
            }

            public void h(long j) {
                this.f1437a = j;
            }

            public String toString() {
                return "SubsampleEntry{subsampleSize=" + this.f1437a + ", subsamplePriority=" + this.f1438b + ", discardable=" + this.f1439c + ", reserved=" + this.f1440d + '}';
            }
        }

        public long a() {
            return this.f1435a;
        }

        public int b() {
            return this.f1436b.size();
        }

        public List<C0047a> c() {
            return this.f1436b;
        }

        public void d(long j) {
            this.f1435a = j;
        }

        public String toString() {
            return "SampleEntry{sampleDelta=" + this.f1435a + ", subsampleCount=" + this.f1436b.size() + ", subsampleEntries=" + this.f1436b + '}';
        }
    }

    static {
        k();
    }

    public b0() {
        super("subs");
        this.m = new ArrayList();
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("SubSampleInformationBox.java", b0.class);
        n = bVar.f("method-execution", bVar.e("1", "getEntries", "com.coremedia.iso.boxes.SubSampleInformationBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.util.List"), 50);
        bVar.f("method-execution", bVar.e("1", "setEntries", "com.coremedia.iso.boxes.SubSampleInformationBox", "java.util.List", "entries", BuildConfig.FLAVOR, "void"), 54);
        o = bVar.f("method-execution", bVar.e("1", "toString", "com.coremedia.iso.boxes.SubSampleInformationBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 124);
    }

    @Override // b.e.a.a
    public void c(ByteBuffer byteBuffer) {
        o(byteBuffer);
        long k = b.c.a.e.k(byteBuffer);
        for (int i = 0; i < k; i++) {
            a aVar = new a();
            aVar.d(b.c.a.e.k(byteBuffer));
            int i2 = b.c.a.e.i(byteBuffer);
            for (int i3 = 0; i3 < i2; i3++) {
                a.C0047a c0047a = new a.C0047a();
                c0047a.h(n() == 1 ? b.c.a.e.k(byteBuffer) : b.c.a.e.i(byteBuffer));
                c0047a.g(b.c.a.e.n(byteBuffer));
                c0047a.e(b.c.a.e.n(byteBuffer));
                c0047a.f(b.c.a.e.k(byteBuffer));
                aVar.c().add(c0047a);
            }
            this.m.add(aVar);
        }
    }

    @Override // b.e.a.a
    protected void d(ByteBuffer byteBuffer) {
        r(byteBuffer);
        b.c.a.f.g(byteBuffer, this.m.size());
        for (a aVar : this.m) {
            b.c.a.f.g(byteBuffer, aVar.a());
            b.c.a.f.e(byteBuffer, aVar.b());
            for (a.C0047a c0047a : aVar.c()) {
                if (n() == 1) {
                    b.c.a.f.g(byteBuffer, c0047a.d());
                } else {
                    b.c.a.f.e(byteBuffer, b.e.a.j.b.a(c0047a.d()));
                }
                b.c.a.f.j(byteBuffer, c0047a.c());
                b.c.a.f.j(byteBuffer, c0047a.a());
                b.c.a.f.g(byteBuffer, c0047a.b());
            }
        }
    }

    @Override // b.e.a.a
    protected long e() {
        long j = 8;
        for (a aVar : this.m) {
            j = j + 4 + 2;
            for (int i = 0; i < aVar.c().size(); i++) {
                j = (n() == 1 ? j + 4 : j + 2) + 2 + 4;
            }
        }
        return j;
    }

    public List<a> s() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(n, this, this));
        return this.m;
    }

    public String toString() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(o, this, this));
        return "SubSampleInformationBox{entryCount=" + this.m.size() + ", entries=" + this.m + '}';
    }
}
