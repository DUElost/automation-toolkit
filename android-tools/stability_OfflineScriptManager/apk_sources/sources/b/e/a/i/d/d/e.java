package b.e.a.i.d.d;

import c.b.a.a.a;
import java.nio.ByteBuffer;
import java.util.LinkedList;
import java.util.List;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class e extends b.e.a.c {
    private static final /* synthetic */ a.InterfaceC0057a p = null;
    private static final /* synthetic */ a.InterfaceC0057a q = null;
    private static final /* synthetic */ a.InterfaceC0057a r = null;
    private static final /* synthetic */ a.InterfaceC0057a s = null;
    private static final /* synthetic */ a.InterfaceC0057a t = null;
    private static final /* synthetic */ a.InterfaceC0057a u = null;
    private static final /* synthetic */ a.InterfaceC0057a v = null;
    private String m;
    private int n;
    private List<b> o;

    static {
        k();
    }

    public e() {
        super("sgpd");
        this.o = new LinkedList();
        q(1);
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("SampleGroupDescriptionBox.java", e.class);
        p = bVar.f("method-execution", bVar.e("1", "getGroupingType", "com.googlecode.mp4parser.boxes.mp4.samplegrouping.SampleGroupDescriptionBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 57);
        q = bVar.f("method-execution", bVar.e("1", "setGroupingType", "com.googlecode.mp4parser.boxes.mp4.samplegrouping.SampleGroupDescriptionBox", "java.lang.String", "groupingType", BuildConfig.FLAVOR, "void"), 61);
        bVar.f("method-execution", bVar.e("1", "getDefaultLength", "com.googlecode.mp4parser.boxes.mp4.samplegrouping.SampleGroupDescriptionBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "int"), 153);
        bVar.f("method-execution", bVar.e("1", "setDefaultLength", "com.googlecode.mp4parser.boxes.mp4.samplegrouping.SampleGroupDescriptionBox", "int", "defaultLength", BuildConfig.FLAVOR, "void"), 157);
        r = bVar.f("method-execution", bVar.e("1", "getGroupEntries", "com.googlecode.mp4parser.boxes.mp4.samplegrouping.SampleGroupDescriptionBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.util.List"), 161);
        s = bVar.f("method-execution", bVar.e("1", "setGroupEntries", "com.googlecode.mp4parser.boxes.mp4.samplegrouping.SampleGroupDescriptionBox", "java.util.List", "groupEntries", BuildConfig.FLAVOR, "void"), 165);
        t = bVar.f("method-execution", bVar.e("1", "equals", "com.googlecode.mp4parser.boxes.mp4.samplegrouping.SampleGroupDescriptionBox", "java.lang.Object", "o", BuildConfig.FLAVOR, "boolean"), 170);
        u = bVar.f("method-execution", bVar.e("1", "hashCode", "com.googlecode.mp4parser.boxes.mp4.samplegrouping.SampleGroupDescriptionBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "int"), 191);
        v = bVar.f("method-execution", bVar.e("1", "toString", "com.googlecode.mp4parser.boxes.mp4.samplegrouping.SampleGroupDescriptionBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 199);
    }

    private b v(ByteBuffer byteBuffer, String str) {
        b dVar = "roll".equals(str) ? new d() : "rash".equals(str) ? new c() : "seig".equals(str) ? new a() : "rap ".equals(str) ? new i() : "tele".equals(str) ? new g() : "sync".equals(str) ? new b.g.a.b.b() : "tscl".equals(str) ? new b.g.a.b.c() : "tsas".equals(str) ? new b.g.a.b.d() : "stsa".equals(str) ? new b.g.a.b.a() : new h(str);
        dVar.c(byteBuffer);
        return dVar;
    }

    @Override // b.e.a.a
    protected void c(ByteBuffer byteBuffer) {
        o(byteBuffer);
        if (n() != 1) {
            throw new RuntimeException("SampleGroupDescriptionBox are only supported in version 1");
        }
        this.m = b.c.a.e.b(byteBuffer);
        if (n() == 1) {
            this.n = b.e.a.j.b.a(b.c.a.e.k(byteBuffer));
        }
        long k = b.c.a.e.k(byteBuffer);
        while (true) {
            long j = k - 1;
            if (k <= 0) {
                return;
            }
            int i = this.n;
            if (n() != 1) {
                throw new RuntimeException("This should be implemented");
            }
            if (this.n == 0) {
                i = b.e.a.j.b.a(b.c.a.e.k(byteBuffer));
            }
            int position = byteBuffer.position() + i;
            ByteBuffer slice = byteBuffer.slice();
            slice.limit(i);
            this.o.add(v(slice, this.m));
            byteBuffer.position(position);
            k = j;
        }
    }

    @Override // b.e.a.a
    protected void d(ByteBuffer byteBuffer) {
        r(byteBuffer);
        byteBuffer.put(b.c.a.d.F(this.m));
        if (n() == 1) {
            b.c.a.f.g(byteBuffer, this.n);
        }
        b.c.a.f.g(byteBuffer, this.o.size());
        for (b bVar : this.o) {
            if (n() == 1 && this.n == 0) {
                b.c.a.f.g(byteBuffer, bVar.a().limit());
            }
            byteBuffer.put(bVar.a());
        }
    }

    @Override // b.e.a.a
    protected long e() {
        long j = (n() == 1 ? 12L : 8L) + 4;
        for (b bVar : this.o) {
            if (n() == 1 && this.n == 0) {
                j += 4;
            }
            j += bVar.d();
        }
        return j;
    }

    public boolean equals(Object obj) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(t, this, this, obj));
        if (this == obj) {
            return true;
        }
        if (obj == null || e.class != obj.getClass()) {
            return false;
        }
        e eVar = (e) obj;
        if (this.n != eVar.n) {
            return false;
        }
        List<b> list = this.o;
        List<b> list2 = eVar.o;
        return list == null ? list2 == null : list.equals(list2);
    }

    public int hashCode() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(u, this, this));
        int i = (this.n + 0) * 31;
        List<b> list = this.o;
        return i + (list != null ? list.hashCode() : 0);
    }

    public List<b> s() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(r, this, this));
        return this.o;
    }

    public String toString() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(v, this, this));
        StringBuilder sb = new StringBuilder("SampleGroupDescriptionBox{groupingType='");
        sb.append(this.o.size() > 0 ? this.o.get(0).b() : "????");
        sb.append('\'');
        sb.append(", defaultLength=");
        sb.append(this.n);
        sb.append(", groupEntries=");
        sb.append(this.o);
        sb.append('}');
        return sb.toString();
    }

    public String u() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(p, this, this));
        return this.m;
    }

    public void w(List<b> list) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(s, this, this, list));
        this.o = list;
    }

    public void x(String str) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(q, this, this, str));
        this.m = str;
    }
}
