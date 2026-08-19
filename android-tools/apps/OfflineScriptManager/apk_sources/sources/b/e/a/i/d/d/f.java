package b.e.a.i.d.d;

import c.b.a.a.a;
import java.nio.ByteBuffer;
import java.util.LinkedList;
import java.util.List;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class f extends b.e.a.c {
    private static final /* synthetic */ a.InterfaceC0057a p = null;
    private static final /* synthetic */ a.InterfaceC0057a q = null;
    private static final /* synthetic */ a.InterfaceC0057a r = null;
    private String m;
    private String n;
    List<a> o;

    /* loaded from: classes.dex */
    public static class a {

        /* renamed from: a  reason: collision with root package name */
        private long f1589a;

        /* renamed from: b  reason: collision with root package name */
        private int f1590b;

        public a(long j, int i) {
            this.f1589a = j;
            this.f1590b = i;
        }

        public int a() {
            return this.f1590b;
        }

        public long b() {
            return this.f1589a;
        }

        public void c(long j) {
            this.f1589a = j;
        }

        public boolean equals(Object obj) {
            if (this == obj) {
                return true;
            }
            if (obj == null || a.class != obj.getClass()) {
                return false;
            }
            a aVar = (a) obj;
            return this.f1590b == aVar.f1590b && this.f1589a == aVar.f1589a;
        }

        public int hashCode() {
            long j = this.f1589a;
            return (((int) (j ^ (j >>> 32))) * 31) + this.f1590b;
        }

        public String toString() {
            return "Entry{sampleCount=" + this.f1589a + ", groupDescriptionIndex=" + this.f1590b + '}';
        }
    }

    static {
        k();
    }

    public f() {
        super("sbgp");
        this.o = new LinkedList();
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("SampleToGroupBox.java", f.class);
        p = bVar.f("method-execution", bVar.e("1", "getGroupingType", "com.googlecode.mp4parser.boxes.mp4.samplegrouping.SampleToGroupBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 150);
        q = bVar.f("method-execution", bVar.e("1", "setGroupingType", "com.googlecode.mp4parser.boxes.mp4.samplegrouping.SampleToGroupBox", "java.lang.String", "groupingType", BuildConfig.FLAVOR, "void"), 154);
        bVar.f("method-execution", bVar.e("1", "getGroupingTypeParameter", "com.googlecode.mp4parser.boxes.mp4.samplegrouping.SampleToGroupBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 158);
        bVar.f("method-execution", bVar.e("1", "setGroupingTypeParameter", "com.googlecode.mp4parser.boxes.mp4.samplegrouping.SampleToGroupBox", "java.lang.String", "groupingTypeParameter", BuildConfig.FLAVOR, "void"), 162);
        r = bVar.f("method-execution", bVar.e("1", "getEntries", "com.googlecode.mp4parser.boxes.mp4.samplegrouping.SampleToGroupBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.util.List"), 166);
        bVar.f("method-execution", bVar.e("1", "setEntries", "com.googlecode.mp4parser.boxes.mp4.samplegrouping.SampleToGroupBox", "java.util.List", "entries", BuildConfig.FLAVOR, "void"), 170);
    }

    @Override // b.e.a.a
    protected void c(ByteBuffer byteBuffer) {
        o(byteBuffer);
        this.m = b.c.a.e.b(byteBuffer);
        if (n() == 1) {
            this.n = b.c.a.e.b(byteBuffer);
        }
        long k = b.c.a.e.k(byteBuffer);
        while (true) {
            long j = k - 1;
            if (k <= 0) {
                return;
            }
            this.o.add(new a(b.e.a.j.b.a(b.c.a.e.k(byteBuffer)), b.e.a.j.b.a(b.c.a.e.k(byteBuffer))));
            k = j;
        }
    }

    @Override // b.e.a.a
    protected void d(ByteBuffer byteBuffer) {
        r(byteBuffer);
        byteBuffer.put(this.m.getBytes());
        if (n() == 1) {
            byteBuffer.put(this.n.getBytes());
        }
        b.c.a.f.g(byteBuffer, this.o.size());
        for (a aVar : this.o) {
            b.c.a.f.g(byteBuffer, aVar.b());
            b.c.a.f.g(byteBuffer, aVar.a());
        }
    }

    @Override // b.e.a.a
    protected long e() {
        return n() == 1 ? (this.o.size() * 8) + 16 : (this.o.size() * 8) + 12;
    }

    public List<a> s() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(r, this, this));
        return this.o;
    }

    public String u() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(p, this, this));
        return this.m;
    }

    public void v(String str) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(q, this, this, str));
        this.m = str;
    }
}
