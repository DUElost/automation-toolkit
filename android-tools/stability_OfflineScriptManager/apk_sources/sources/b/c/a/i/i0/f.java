package b.c.a.i.i0;

import c.b.a.a.a;
import java.nio.ByteBuffer;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class f extends b.e.a.c {
    private static final /* synthetic */ a.InterfaceC0057a A = null;
    private static final /* synthetic */ a.InterfaceC0057a B = null;
    private static final /* synthetic */ a.InterfaceC0057a C = null;
    private static final /* synthetic */ a.InterfaceC0057a D = null;
    private static final /* synthetic */ a.InterfaceC0057a E = null;
    private static final /* synthetic */ a.InterfaceC0057a u = null;
    private static final /* synthetic */ a.InterfaceC0057a v = null;
    private static final /* synthetic */ a.InterfaceC0057a w = null;
    private static final /* synthetic */ a.InterfaceC0057a x = null;
    private static final /* synthetic */ a.InterfaceC0057a y = null;
    private static final /* synthetic */ a.InterfaceC0057a z = null;
    private long m;
    private long n;
    private long o;
    private long p;
    private long q;
    private c r;
    private boolean s;
    private boolean t;

    static {
        k();
    }

    public f() {
        super("tfhd");
        this.n = -1L;
        this.p = -1L;
        this.q = -1L;
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("TrackFragmentHeaderBox.java", f.class);
        u = bVar.f("method-execution", bVar.e("1", "hasBaseDataOffset", "com.coremedia.iso.boxes.fragment.TrackFragmentHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "boolean"), 126);
        bVar.f("method-execution", bVar.e("1", "hasSampleDescriptionIndex", "com.coremedia.iso.boxes.fragment.TrackFragmentHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "boolean"), 130);
        bVar.f("method-execution", bVar.e("1", "setSampleDescriptionIndex", "com.coremedia.iso.boxes.fragment.TrackFragmentHeaderBox", "long", "sampleDescriptionIndex", BuildConfig.FLAVOR, "void"), 171);
        B = bVar.f("method-execution", bVar.e("1", "getDefaultSampleDuration", "com.coremedia.iso.boxes.fragment.TrackFragmentHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "long"), 180);
        bVar.f("method-execution", bVar.e("1", "setDefaultSampleDuration", "com.coremedia.iso.boxes.fragment.TrackFragmentHeaderBox", "long", "defaultSampleDuration", BuildConfig.FLAVOR, "void"), 184);
        C = bVar.f("method-execution", bVar.e("1", "getDefaultSampleSize", "com.coremedia.iso.boxes.fragment.TrackFragmentHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "long"), 191);
        bVar.f("method-execution", bVar.e("1", "setDefaultSampleSize", "com.coremedia.iso.boxes.fragment.TrackFragmentHeaderBox", "long", "defaultSampleSize", BuildConfig.FLAVOR, "void"), 195);
        D = bVar.f("method-execution", bVar.e("1", "getDefaultSampleFlags", "com.coremedia.iso.boxes.fragment.TrackFragmentHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "com.coremedia.iso.boxes.fragment.SampleFlags"), 204);
        bVar.f("method-execution", bVar.e("1", "setDefaultSampleFlags", "com.coremedia.iso.boxes.fragment.TrackFragmentHeaderBox", "com.coremedia.iso.boxes.fragment.SampleFlags", "defaultSampleFlags", BuildConfig.FLAVOR, "void"), 208);
        bVar.f("method-execution", bVar.e("1", "isDurationIsEmpty", "com.coremedia.iso.boxes.fragment.TrackFragmentHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "boolean"), 217);
        bVar.f("method-execution", bVar.e("1", "setDurationIsEmpty", "com.coremedia.iso.boxes.fragment.TrackFragmentHeaderBox", "boolean", "durationIsEmpty", BuildConfig.FLAVOR, "void"), 221);
        bVar.f("method-execution", bVar.e("1", "isDefaultBaseIsMoof", "com.coremedia.iso.boxes.fragment.TrackFragmentHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "boolean"), 230);
        v = bVar.f("method-execution", bVar.e("1", "hasDefaultSampleDuration", "com.coremedia.iso.boxes.fragment.TrackFragmentHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "boolean"), 134);
        bVar.f("method-execution", bVar.e("1", "setDefaultBaseIsMoof", "com.coremedia.iso.boxes.fragment.TrackFragmentHeaderBox", "boolean", "defaultBaseIsMoof", BuildConfig.FLAVOR, "void"), 234);
        E = bVar.f("method-execution", bVar.e("1", "toString", "com.coremedia.iso.boxes.fragment.TrackFragmentHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 244);
        w = bVar.f("method-execution", bVar.e("1", "hasDefaultSampleSize", "com.coremedia.iso.boxes.fragment.TrackFragmentHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "boolean"), 138);
        x = bVar.f("method-execution", bVar.e("1", "hasDefaultSampleFlags", "com.coremedia.iso.boxes.fragment.TrackFragmentHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "boolean"), 142);
        y = bVar.f("method-execution", bVar.e("1", "getTrackId", "com.coremedia.iso.boxes.fragment.TrackFragmentHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "long"), 146);
        bVar.f("method-execution", bVar.e("1", "setTrackId", "com.coremedia.iso.boxes.fragment.TrackFragmentHeaderBox", "long", "trackId", BuildConfig.FLAVOR, "void"), 150);
        z = bVar.f("method-execution", bVar.e("1", "getBaseDataOffset", "com.coremedia.iso.boxes.fragment.TrackFragmentHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "long"), 154);
        bVar.f("method-execution", bVar.e("1", "setBaseDataOffset", "com.coremedia.iso.boxes.fragment.TrackFragmentHeaderBox", "long", "baseDataOffset", BuildConfig.FLAVOR, "void"), 158);
        A = bVar.f("method-execution", bVar.e("1", "getSampleDescriptionIndex", "com.coremedia.iso.boxes.fragment.TrackFragmentHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "long"), 167);
    }

    public boolean A() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(v, this, this));
        return (l() & 8) != 0;
    }

    public boolean B() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(x, this, this));
        return (l() & 32) != 0;
    }

    public boolean C() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(w, this, this));
        return (l() & 16) != 0;
    }

    @Override // b.e.a.a
    public void c(ByteBuffer byteBuffer) {
        o(byteBuffer);
        this.m = b.c.a.e.k(byteBuffer);
        if ((l() & 1) == 1) {
            this.n = b.c.a.e.m(byteBuffer);
        }
        if ((l() & 2) == 2) {
            this.o = b.c.a.e.k(byteBuffer);
        }
        if ((l() & 8) == 8) {
            this.p = b.c.a.e.k(byteBuffer);
        }
        if ((l() & 16) == 16) {
            this.q = b.c.a.e.k(byteBuffer);
        }
        if ((l() & 32) == 32) {
            this.r = new c(byteBuffer);
        }
        if ((l() & 65536) == 65536) {
            this.s = true;
        }
        if ((l() & 131072) == 131072) {
            this.t = true;
        }
    }

    @Override // b.e.a.a
    protected void d(ByteBuffer byteBuffer) {
        r(byteBuffer);
        b.c.a.f.g(byteBuffer, this.m);
        if ((l() & 1) == 1) {
            b.c.a.f.i(byteBuffer, s());
        }
        if ((l() & 2) == 2) {
            b.c.a.f.g(byteBuffer, x());
        }
        if ((l() & 8) == 8) {
            b.c.a.f.g(byteBuffer, u());
        }
        if ((l() & 16) == 16) {
            b.c.a.f.g(byteBuffer, w());
        }
        if ((l() & 32) == 32) {
            this.r.a(byteBuffer);
        }
    }

    @Override // b.e.a.a
    protected long e() {
        int l = l();
        long j = (l & 1) == 1 ? 16L : 8L;
        if ((l & 2) == 2) {
            j += 4;
        }
        if ((l & 8) == 8) {
            j += 4;
        }
        if ((l & 16) == 16) {
            j += 4;
        }
        return (l & 32) == 32 ? j + 4 : j;
    }

    public long s() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(z, this, this));
        return this.n;
    }

    public String toString() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(E, this, this));
        return "TrackFragmentHeaderBox{trackId=" + this.m + ", baseDataOffset=" + this.n + ", sampleDescriptionIndex=" + this.o + ", defaultSampleDuration=" + this.p + ", defaultSampleSize=" + this.q + ", defaultSampleFlags=" + this.r + ", durationIsEmpty=" + this.s + ", defaultBaseIsMoof=" + this.t + '}';
    }

    public long u() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(B, this, this));
        return this.p;
    }

    public c v() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(D, this, this));
        return this.r;
    }

    public long w() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(C, this, this));
        return this.q;
    }

    public long x() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(A, this, this));
        return this.o;
    }

    public long y() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(y, this, this));
        return this.m;
    }

    public boolean z() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(u, this, this));
        return (l() & 1) != 0;
    }
}
