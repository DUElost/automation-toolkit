package b.c.a.i;

import c.b.a.a.a;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class d extends b.e.a.c {
    private static final /* synthetic */ a.InterfaceC0057a n = null;
    private static final /* synthetic */ a.InterfaceC0057a o = null;
    List<a> m;

    /* loaded from: classes.dex */
    public static class a {

        /* renamed from: a  reason: collision with root package name */
        int f1441a;

        /* renamed from: b  reason: collision with root package name */
        int f1442b;

        public a(int i, int i2) {
            this.f1441a = i;
            this.f1442b = i2;
        }

        public int a() {
            return this.f1441a;
        }

        public int b() {
            return this.f1442b;
        }

        public void c(int i) {
            this.f1441a = i;
        }

        public String toString() {
            return "Entry{count=" + this.f1441a + ", offset=" + this.f1442b + '}';
        }
    }

    static {
        k();
    }

    public d() {
        super("ctts");
        this.m = Collections.emptyList();
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("CompositionTimeToSample.java", d.class);
        n = bVar.f("method-execution", bVar.e("1", "getEntries", "com.coremedia.iso.boxes.CompositionTimeToSample", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.util.List"), 57);
        o = bVar.f("method-execution", bVar.e("1", "setEntries", "com.coremedia.iso.boxes.CompositionTimeToSample", "java.util.List", "entries", BuildConfig.FLAVOR, "void"), 61);
    }

    public static int[] s(List<a> list) {
        Iterator<a> it;
        long j = 0;
        while (list.iterator().hasNext()) {
            j += it.next().a();
        }
        int[] iArr = new int[(int) j];
        int i = 0;
        for (a aVar : list) {
            int i2 = 0;
            while (i2 < aVar.a()) {
                iArr[i] = aVar.b();
                i2++;
                i++;
            }
        }
        return iArr;
    }

    @Override // b.e.a.a
    public void c(ByteBuffer byteBuffer) {
        o(byteBuffer);
        int a2 = b.e.a.j.b.a(b.c.a.e.k(byteBuffer));
        this.m = new ArrayList(a2);
        for (int i = 0; i < a2; i++) {
            this.m.add(new a(b.e.a.j.b.a(b.c.a.e.k(byteBuffer)), byteBuffer.getInt()));
        }
    }

    @Override // b.e.a.a
    protected void d(ByteBuffer byteBuffer) {
        r(byteBuffer);
        b.c.a.f.g(byteBuffer, this.m.size());
        for (a aVar : this.m) {
            b.c.a.f.g(byteBuffer, aVar.a());
            byteBuffer.putInt(aVar.b());
        }
    }

    @Override // b.e.a.a
    protected long e() {
        return (this.m.size() * 8) + 8;
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
