package b.c.a.i;

import c.b.a.a.a;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.List;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class t extends b.e.a.c {
    private static final /* synthetic */ a.InterfaceC0057a n = null;
    private static final /* synthetic */ a.InterfaceC0057a o = null;
    private static final /* synthetic */ a.InterfaceC0057a p = null;
    private List<a> m;

    /* loaded from: classes.dex */
    public static class a {

        /* renamed from: a  reason: collision with root package name */
        private int f1463a;

        public a(int i) {
            this.f1463a = i;
        }

        public int b() {
            return (this.f1463a >> 6) & 3;
        }

        public int c() {
            return (this.f1463a >> 4) & 3;
        }

        public int d() {
            return this.f1463a & 3;
        }

        public int e() {
            return (this.f1463a >> 2) & 3;
        }

        public boolean equals(Object obj) {
            if (this == obj) {
                return true;
            }
            return obj != null && a.class == obj.getClass() && this.f1463a == ((a) obj).f1463a;
        }

        public int hashCode() {
            return this.f1463a;
        }

        public String toString() {
            return "Entry{isLeading=" + b() + ", sampleDependsOn=" + c() + ", sampleIsDependentOn=" + e() + ", sampleHasRedundancy=" + d() + '}';
        }
    }

    static {
        k();
    }

    public t() {
        super("sdtp");
        this.m = new ArrayList();
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("SampleDependencyTypeBox.java", t.class);
        n = bVar.f("method-execution", bVar.e("1", "getEntries", "com.coremedia.iso.boxes.SampleDependencyTypeBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.util.List"), 139);
        o = bVar.f("method-execution", bVar.e("1", "setEntries", "com.coremedia.iso.boxes.SampleDependencyTypeBox", "java.util.List", "entries", BuildConfig.FLAVOR, "void"), 143);
        p = bVar.f("method-execution", bVar.e("1", "toString", "com.coremedia.iso.boxes.SampleDependencyTypeBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 148);
    }

    @Override // b.e.a.a
    public void c(ByteBuffer byteBuffer) {
        o(byteBuffer);
        while (byteBuffer.remaining() > 0) {
            this.m.add(new a(b.c.a.e.n(byteBuffer)));
        }
    }

    @Override // b.e.a.a
    protected void d(ByteBuffer byteBuffer) {
        r(byteBuffer);
        for (a aVar : this.m) {
            b.c.a.f.j(byteBuffer, aVar.f1463a);
        }
    }

    @Override // b.e.a.a
    protected long e() {
        return this.m.size() + 4;
    }

    public List<a> s() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(n, this, this));
        return this.m;
    }

    public String toString() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(p, this, this));
        return "SampleDependencyTypeBox{entries=" + this.m + '}';
    }

    public void u(List<a> list) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(o, this, this, list));
        this.m = list;
    }
}
