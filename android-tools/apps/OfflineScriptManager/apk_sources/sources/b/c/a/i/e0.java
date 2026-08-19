package b.c.a.i;

import c.b.a.a.a;
import java.lang.ref.SoftReference;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.WeakHashMap;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class e0 extends b.e.a.c {
    static Map<List<a>, SoftReference<long[]>> n;
    private static final /* synthetic */ a.InterfaceC0057a o = null;
    private static final /* synthetic */ a.InterfaceC0057a p = null;
    private static final /* synthetic */ a.InterfaceC0057a q = null;
    List<a> m;

    /* loaded from: classes.dex */
    public static class a {

        /* renamed from: a  reason: collision with root package name */
        long f1443a;

        /* renamed from: b  reason: collision with root package name */
        long f1444b;

        public a(long j, long j2) {
            this.f1443a = j;
            this.f1444b = j2;
        }

        public long a() {
            return this.f1443a;
        }

        public long b() {
            return this.f1444b;
        }

        public void c(long j) {
            this.f1443a = j;
        }

        public String toString() {
            return "Entry{count=" + this.f1443a + ", delta=" + this.f1444b + '}';
        }
    }

    static {
        k();
        n = new WeakHashMap();
    }

    public e0() {
        super("stts");
        this.m = Collections.emptyList();
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("TimeToSampleBox.java", e0.class);
        o = bVar.f("method-execution", bVar.e("1", "getEntries", "com.coremedia.iso.boxes.TimeToSampleBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.util.List"), 79);
        p = bVar.f("method-execution", bVar.e("1", "setEntries", "com.coremedia.iso.boxes.TimeToSampleBox", "java.util.List", "entries", BuildConfig.FLAVOR, "void"), 83);
        q = bVar.f("method-execution", bVar.e("1", "toString", "com.coremedia.iso.boxes.TimeToSampleBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 87);
    }

    public static synchronized long[] s(List<a> list) {
        long[] jArr;
        synchronized (e0.class) {
            SoftReference<long[]> softReference = n.get(list);
            if (softReference == null || (jArr = softReference.get()) == null) {
                long j = 0;
                for (a aVar : list) {
                    j += aVar.a();
                }
                long[] jArr2 = new long[(int) j];
                int i = 0;
                for (a aVar2 : list) {
                    int i2 = 0;
                    while (i2 < aVar2.a()) {
                        jArr2[i] = aVar2.b();
                        i2++;
                        i++;
                    }
                }
                n.put(list, new SoftReference<>(jArr2));
                return jArr2;
            }
            return jArr;
        }
    }

    @Override // b.e.a.a
    public void c(ByteBuffer byteBuffer) {
        o(byteBuffer);
        int a2 = b.e.a.j.b.a(b.c.a.e.k(byteBuffer));
        this.m = new ArrayList(a2);
        for (int i = 0; i < a2; i++) {
            this.m.add(new a(b.c.a.e.k(byteBuffer), b.c.a.e.k(byteBuffer)));
        }
    }

    @Override // b.e.a.a
    protected void d(ByteBuffer byteBuffer) {
        r(byteBuffer);
        b.c.a.f.g(byteBuffer, this.m.size());
        for (a aVar : this.m) {
            b.c.a.f.g(byteBuffer, aVar.a());
            b.c.a.f.g(byteBuffer, aVar.b());
        }
    }

    @Override // b.e.a.a
    protected long e() {
        return (this.m.size() * 8) + 8;
    }

    public String toString() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(q, this, this));
        return "TimeToSampleBox[entryCount=" + this.m.size() + "]";
    }

    public List<a> u() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(o, this, this));
        return this.m;
    }

    public void v(List<a> list) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(p, this, this, list));
        this.m = list;
    }
}
