package b.c.a.i.i0;

import c.b.a.a.a;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.List;
import jxl.SheetSettings;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class g extends b.e.a.c {
    private static final /* synthetic */ a.InterfaceC0057a p = null;
    private static final /* synthetic */ a.InterfaceC0057a q = null;
    private static final /* synthetic */ a.InterfaceC0057a r = null;
    private static final /* synthetic */ a.InterfaceC0057a s = null;
    private static final /* synthetic */ a.InterfaceC0057a t = null;
    private static final /* synthetic */ a.InterfaceC0057a u = null;
    private static final /* synthetic */ a.InterfaceC0057a v = null;
    private static final /* synthetic */ a.InterfaceC0057a w = null;
    private static final /* synthetic */ a.InterfaceC0057a x = null;
    private static final /* synthetic */ a.InterfaceC0057a y = null;
    private static final /* synthetic */ a.InterfaceC0057a z = null;
    private int m;
    private c n;
    private List<a> o;

    /* loaded from: classes.dex */
    public static class a {

        /* renamed from: a  reason: collision with root package name */
        private long f1449a;

        /* renamed from: b  reason: collision with root package name */
        private long f1450b;

        /* renamed from: c  reason: collision with root package name */
        private c f1451c;

        /* renamed from: d  reason: collision with root package name */
        private long f1452d;

        public long i() {
            return this.f1452d;
        }

        public long j() {
            return this.f1449a;
        }

        public c k() {
            return this.f1451c;
        }

        public long l() {
            return this.f1450b;
        }

        public String toString() {
            return "Entry{duration=" + this.f1449a + ", size=" + this.f1450b + ", dlags=" + this.f1451c + ", compTimeOffset=" + this.f1452d + '}';
        }
    }

    static {
        k();
    }

    public g() {
        super("trun");
        this.o = new ArrayList();
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("TrackRunBox.java", g.class);
        p = bVar.f("method-execution", bVar.e("1", "getEntries", "com.coremedia.iso.boxes.fragment.TrackRunBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.util.List"), 57);
        bVar.f("method-execution", bVar.e("1", "setDataOffset", "com.coremedia.iso.boxes.fragment.TrackRunBox", "int", "dataOffset", BuildConfig.FLAVOR, "void"), 120);
        bVar.f("method-execution", bVar.e("1", "setDataOffsetPresent", "com.coremedia.iso.boxes.fragment.TrackRunBox", "boolean", "v", BuildConfig.FLAVOR, "void"), 267);
        bVar.f("method-execution", bVar.e("1", "setSampleSizePresent", "com.coremedia.iso.boxes.fragment.TrackRunBox", "boolean", "v", BuildConfig.FLAVOR, "void"), 275);
        bVar.f("method-execution", bVar.e("1", "setSampleDurationPresent", "com.coremedia.iso.boxes.fragment.TrackRunBox", "boolean", "v", BuildConfig.FLAVOR, "void"), 283);
        bVar.f("method-execution", bVar.e("1", "setSampleFlagsPresent", "com.coremedia.iso.boxes.fragment.TrackRunBox", "boolean", "v", BuildConfig.FLAVOR, "void"), 292);
        bVar.f("method-execution", bVar.e("1", "setSampleCompositionTimeOffsetPresent", "com.coremedia.iso.boxes.fragment.TrackRunBox", "boolean", "v", BuildConfig.FLAVOR, "void"), 300);
        x = bVar.f("method-execution", bVar.e("1", "getDataOffset", "com.coremedia.iso.boxes.fragment.TrackRunBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "int"), 309);
        y = bVar.f("method-execution", bVar.e("1", "getFirstSampleFlags", "com.coremedia.iso.boxes.fragment.TrackRunBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "com.coremedia.iso.boxes.fragment.SampleFlags"), 313);
        bVar.f("method-execution", bVar.e("1", "setFirstSampleFlags", "com.coremedia.iso.boxes.fragment.TrackRunBox", "com.coremedia.iso.boxes.fragment.SampleFlags", "firstSampleFlags", BuildConfig.FLAVOR, "void"), 317);
        z = bVar.f("method-execution", bVar.e("1", "toString", "com.coremedia.iso.boxes.fragment.TrackRunBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 327);
        bVar.f("method-execution", bVar.e("1", "setEntries", "com.coremedia.iso.boxes.fragment.TrackRunBox", "java.util.List", "entries", BuildConfig.FLAVOR, "void"), 342);
        bVar.f("method-execution", bVar.e("1", "getSampleCompositionTimeOffsets", "com.coremedia.iso.boxes.fragment.TrackRunBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "[J"), 129);
        q = bVar.f("method-execution", bVar.e("1", "getSampleCount", "com.coremedia.iso.boxes.fragment.TrackRunBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "long"), 238);
        r = bVar.f("method-execution", bVar.e("1", "isDataOffsetPresent", "com.coremedia.iso.boxes.fragment.TrackRunBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "boolean"), 242);
        s = bVar.f("method-execution", bVar.e("1", "isFirstSampleFlagsPresent", "com.coremedia.iso.boxes.fragment.TrackRunBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "boolean"), 246);
        t = bVar.f("method-execution", bVar.e("1", "isSampleSizePresent", "com.coremedia.iso.boxes.fragment.TrackRunBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "boolean"), 251);
        u = bVar.f("method-execution", bVar.e("1", "isSampleDurationPresent", "com.coremedia.iso.boxes.fragment.TrackRunBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "boolean"), SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT);
        v = bVar.f("method-execution", bVar.e("1", "isSampleFlagsPresent", "com.coremedia.iso.boxes.fragment.TrackRunBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "boolean"), 259);
        w = bVar.f("method-execution", bVar.e("1", "isSampleCompositionTimeOffsetPresent", "com.coremedia.iso.boxes.fragment.TrackRunBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "boolean"), 263);
    }

    public boolean A() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(u, this, this));
        return (l() & 256) == 256;
    }

    public boolean B() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(v, this, this));
        return (l() & 1024) == 1024;
    }

    public boolean C() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(t, this, this));
        return (l() & 512) == 512;
    }

    @Override // b.e.a.a
    public void c(ByteBuffer byteBuffer) {
        o(byteBuffer);
        long k = b.c.a.e.k(byteBuffer);
        this.m = (l() & 1) == 1 ? b.e.a.j.b.a(b.c.a.e.k(byteBuffer)) : -1;
        if ((l() & 4) == 4) {
            this.n = new c(byteBuffer);
        }
        for (int i = 0; i < k; i++) {
            a aVar = new a();
            if ((l() & 256) == 256) {
                aVar.f1449a = b.c.a.e.k(byteBuffer);
            }
            if ((l() & 512) == 512) {
                aVar.f1450b = b.c.a.e.k(byteBuffer);
            }
            if ((l() & 1024) == 1024) {
                aVar.f1451c = new c(byteBuffer);
            }
            if ((l() & 2048) == 2048) {
                aVar.f1452d = byteBuffer.getInt();
            }
            this.o.add(aVar);
        }
    }

    @Override // b.e.a.a
    protected void d(ByteBuffer byteBuffer) {
        r(byteBuffer);
        b.c.a.f.g(byteBuffer, this.o.size());
        int l = l();
        if ((l & 1) == 1) {
            b.c.a.f.g(byteBuffer, this.m);
        }
        if ((l & 4) == 4) {
            this.n.a(byteBuffer);
        }
        for (a aVar : this.o) {
            if ((l & 256) == 256) {
                b.c.a.f.g(byteBuffer, aVar.f1449a);
            }
            if ((l & 512) == 512) {
                b.c.a.f.g(byteBuffer, aVar.f1450b);
            }
            if ((l & 1024) == 1024) {
                aVar.f1451c.a(byteBuffer);
            }
            if ((l & 2048) == 2048) {
                if (n() == 0) {
                    b.c.a.f.g(byteBuffer, aVar.f1452d);
                } else {
                    byteBuffer.putInt((int) aVar.f1452d);
                }
            }
        }
    }

    @Override // b.e.a.a
    protected long e() {
        int l = l();
        long j = (l & 1) == 1 ? 12L : 8L;
        if ((l & 4) == 4) {
            j += 4;
        }
        long j2 = (l & 256) == 256 ? 4L : 0L;
        if ((l & 512) == 512) {
            j2 += 4;
        }
        if ((l & 1024) == 1024) {
            j2 += 4;
        }
        if ((l & 2048) == 2048) {
            j2 += 4;
        }
        return j + (j2 * this.o.size());
    }

    public int s() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(x, this, this));
        return this.m;
    }

    public String toString() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(z, this, this));
        return "TrackRunBox{sampleCount=" + this.o.size() + ", dataOffset=" + this.m + ", dataOffsetPresent=" + x() + ", sampleSizePresent=" + C() + ", sampleDurationPresent=" + A() + ", sampleFlagsPresentPresent=" + B() + ", sampleCompositionTimeOffsetPresent=" + z() + ", firstSampleFlags=" + this.n + '}';
    }

    public List<a> u() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(p, this, this));
        return this.o;
    }

    public c v() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(y, this, this));
        return this.n;
    }

    public long w() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(q, this, this));
        return this.o.size();
    }

    public boolean x() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(r, this, this));
        return (l() & 1) == 1;
    }

    public boolean y() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(s, this, this));
        return (l() & 4) == 4;
    }

    public boolean z() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(w, this, this));
        return (l() & 2048) == 2048;
    }
}
