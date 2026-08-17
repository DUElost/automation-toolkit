package b.c.a.i;

import c.b.a.a.a;
import java.nio.ByteBuffer;
import java.util.LinkedList;
import java.util.List;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class j extends b.e.a.c {
    private static final /* synthetic */ a.InterfaceC0057a n = null;
    private static final /* synthetic */ a.InterfaceC0057a o = null;
    private static final /* synthetic */ a.InterfaceC0057a p = null;
    private List<a> m;

    /* loaded from: classes.dex */
    public static class a {

        /* renamed from: a  reason: collision with root package name */
        j f1453a;

        /* renamed from: b  reason: collision with root package name */
        private long f1454b;

        /* renamed from: c  reason: collision with root package name */
        private long f1455c;

        /* renamed from: d  reason: collision with root package name */
        private double f1456d;

        public a(j jVar, long j, long j2, double d2) {
            this.f1454b = j;
            this.f1455c = j2;
            this.f1456d = d2;
            this.f1453a = jVar;
        }

        public a(j jVar, ByteBuffer byteBuffer) {
            long j;
            if (jVar.n() == 1) {
                this.f1454b = b.c.a.e.m(byteBuffer);
                j = byteBuffer.getLong();
            } else {
                this.f1454b = b.c.a.e.k(byteBuffer);
                j = byteBuffer.getInt();
            }
            this.f1455c = j;
            this.f1456d = b.c.a.e.d(byteBuffer);
            this.f1453a = jVar;
        }

        public void a(ByteBuffer byteBuffer) {
            if (this.f1453a.n() == 1) {
                b.c.a.f.i(byteBuffer, this.f1454b);
                byteBuffer.putLong(this.f1455c);
            } else {
                b.c.a.f.g(byteBuffer, b.e.a.j.b.a(this.f1454b));
                byteBuffer.putInt(b.e.a.j.b.a(this.f1455c));
            }
            b.c.a.f.b(byteBuffer, this.f1456d);
        }

        public double b() {
            return this.f1456d;
        }

        public long c() {
            return this.f1455c;
        }

        public long d() {
            return this.f1454b;
        }

        public boolean equals(Object obj) {
            if (this == obj) {
                return true;
            }
            if (obj == null || a.class != obj.getClass()) {
                return false;
            }
            a aVar = (a) obj;
            return this.f1455c == aVar.f1455c && this.f1454b == aVar.f1454b;
        }

        public int hashCode() {
            long j = this.f1454b;
            long j2 = this.f1455c;
            return (((int) (j ^ (j >>> 32))) * 31) + ((int) ((j2 >>> 32) ^ j2));
        }

        public String toString() {
            return "Entry{segmentDuration=" + this.f1454b + ", mediaTime=" + this.f1455c + ", mediaRate=" + this.f1456d + '}';
        }
    }

    static {
        k();
    }

    public j() {
        super("elst");
        this.m = new LinkedList();
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("EditListBox.java", j.class);
        n = bVar.f("method-execution", bVar.e("1", "getEntries", "com.coremedia.iso.boxes.EditListBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.util.List"), 68);
        o = bVar.f("method-execution", bVar.e("1", "setEntries", "com.coremedia.iso.boxes.EditListBox", "java.util.List", "entries", BuildConfig.FLAVOR, "void"), 72);
        p = bVar.f("method-execution", bVar.e("1", "toString", "com.coremedia.iso.boxes.EditListBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 108);
    }

    @Override // b.e.a.a
    public void c(ByteBuffer byteBuffer) {
        o(byteBuffer);
        int a2 = b.e.a.j.b.a(b.c.a.e.k(byteBuffer));
        this.m = new LinkedList();
        for (int i = 0; i < a2; i++) {
            this.m.add(new a(this, byteBuffer));
        }
    }

    @Override // b.e.a.a
    protected void d(ByteBuffer byteBuffer) {
        r(byteBuffer);
        b.c.a.f.g(byteBuffer, this.m.size());
        for (a aVar : this.m) {
            aVar.a(byteBuffer);
        }
    }

    @Override // b.e.a.a
    protected long e() {
        return (n() == 1 ? this.m.size() * 20 : this.m.size() * 12) + 8;
    }

    public List<a> s() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(n, this, this));
        return this.m;
    }

    public String toString() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(p, this, this));
        return "EditListBox{entries=" + this.m + '}';
    }

    public void u(List<a> list) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(o, this, this, list));
        this.m = list;
    }
}
