package b.c.a.i;

import c.b.a.a.a;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class x extends b.e.a.c {
    private static final /* synthetic */ a.InterfaceC0057a n = null;
    private static final /* synthetic */ a.InterfaceC0057a o = null;
    private static final /* synthetic */ a.InterfaceC0057a p = null;
    private static final /* synthetic */ a.InterfaceC0057a q = null;
    List<a> m;

    /* loaded from: classes.dex */
    public static class a {

        /* renamed from: a  reason: collision with root package name */
        long f1464a;

        /* renamed from: b  reason: collision with root package name */
        long f1465b;

        /* renamed from: c  reason: collision with root package name */
        long f1466c;

        public a(long j, long j2, long j3) {
            this.f1464a = j;
            this.f1465b = j2;
            this.f1466c = j3;
        }

        public long a() {
            return this.f1464a;
        }

        public long b() {
            return this.f1466c;
        }

        public long c() {
            return this.f1465b;
        }

        public boolean equals(Object obj) {
            if (this == obj) {
                return true;
            }
            if (obj == null || a.class != obj.getClass()) {
                return false;
            }
            a aVar = (a) obj;
            return this.f1464a == aVar.f1464a && this.f1466c == aVar.f1466c && this.f1465b == aVar.f1465b;
        }

        public int hashCode() {
            long j = this.f1464a;
            long j2 = this.f1465b;
            long j3 = this.f1466c;
            return (((((int) (j ^ (j >>> 32))) * 31) + ((int) (j2 ^ (j2 >>> 32)))) * 31) + ((int) ((j3 >>> 32) ^ j3));
        }

        public String toString() {
            return "Entry{firstChunk=" + this.f1464a + ", samplesPerChunk=" + this.f1465b + ", sampleDescriptionIndex=" + this.f1466c + '}';
        }
    }

    static {
        k();
    }

    public x() {
        super("stsc");
        this.m = Collections.emptyList();
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("SampleToChunkBox.java", x.class);
        n = bVar.f("method-execution", bVar.e("1", "getEntries", "com.coremedia.iso.boxes.SampleToChunkBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.util.List"), 47);
        o = bVar.f("method-execution", bVar.e("1", "setEntries", "com.coremedia.iso.boxes.SampleToChunkBox", "java.util.List", "entries", BuildConfig.FLAVOR, "void"), 51);
        p = bVar.f("method-execution", bVar.e("1", "toString", "com.coremedia.iso.boxes.SampleToChunkBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 84);
        q = bVar.f("method-execution", bVar.e("1", "blowup", "com.coremedia.iso.boxes.SampleToChunkBox", "int", "chunkCount", BuildConfig.FLAVOR, "[J"), 95);
    }

    @Override // b.e.a.a
    public void c(ByteBuffer byteBuffer) {
        o(byteBuffer);
        int a2 = b.e.a.j.b.a(b.c.a.e.k(byteBuffer));
        this.m = new ArrayList(a2);
        for (int i = 0; i < a2; i++) {
            this.m.add(new a(b.c.a.e.k(byteBuffer), b.c.a.e.k(byteBuffer), b.c.a.e.k(byteBuffer)));
        }
    }

    @Override // b.e.a.a
    protected void d(ByteBuffer byteBuffer) {
        r(byteBuffer);
        b.c.a.f.g(byteBuffer, this.m.size());
        for (a aVar : this.m) {
            b.c.a.f.g(byteBuffer, aVar.a());
            b.c.a.f.g(byteBuffer, aVar.c());
            b.c.a.f.g(byteBuffer, aVar.b());
        }
    }

    @Override // b.e.a.a
    protected long e() {
        return (this.m.size() * 12) + 8;
    }

    public long[] s(int i) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(q, this, this, c.b.a.b.a.a.d(i)));
        long[] jArr = new long[i];
        LinkedList linkedList = new LinkedList(this.m);
        Collections.reverse(linkedList);
        Iterator it = linkedList.iterator();
        a aVar = (a) it.next();
        while (i > 1) {
            jArr[i - 1] = aVar.c();
            if (i == aVar.a()) {
                aVar = (a) it.next();
            }
            i--;
        }
        jArr[0] = aVar.c();
        return jArr;
    }

    public String toString() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(p, this, this));
        return "SampleToChunkBox[entryCount=" + this.m.size() + "]";
    }

    public List<a> u() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(n, this, this));
        return this.m;
    }

    public void v(List<a> list) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(o, this, this, list));
        this.m = list;
    }
}
