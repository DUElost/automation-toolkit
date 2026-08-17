package b.c.a.i;

import c.b.a.a.a;
import java.nio.ByteBuffer;
import java.util.Date;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class g0 extends b.e.a.c {
    private static final /* synthetic */ a.InterfaceC0057a A = null;
    private static final /* synthetic */ a.InterfaceC0057a B = null;
    private static final /* synthetic */ a.InterfaceC0057a C = null;
    private static final /* synthetic */ a.InterfaceC0057a D = null;
    private static final /* synthetic */ a.InterfaceC0057a E = null;
    private static final /* synthetic */ a.InterfaceC0057a F = null;
    private static final /* synthetic */ a.InterfaceC0057a G = null;
    private static final /* synthetic */ a.InterfaceC0057a H = null;
    private static final /* synthetic */ a.InterfaceC0057a I = null;
    private static final /* synthetic */ a.InterfaceC0057a J = null;
    private static final /* synthetic */ a.InterfaceC0057a K = null;
    private static final /* synthetic */ a.InterfaceC0057a L = null;
    private static final /* synthetic */ a.InterfaceC0057a M = null;
    private static final /* synthetic */ a.InterfaceC0057a N = null;
    private static final /* synthetic */ a.InterfaceC0057a O = null;
    private static final /* synthetic */ a.InterfaceC0057a P = null;
    private static final /* synthetic */ a.InterfaceC0057a Q = null;
    private static final /* synthetic */ a.InterfaceC0057a R = null;
    private static final /* synthetic */ a.InterfaceC0057a S = null;
    private static final /* synthetic */ a.InterfaceC0057a T = null;
    private static final /* synthetic */ a.InterfaceC0057a U = null;
    private static b.e.a.j.f w;
    private static final /* synthetic */ a.InterfaceC0057a x = null;
    private static final /* synthetic */ a.InterfaceC0057a y = null;
    private static final /* synthetic */ a.InterfaceC0057a z = null;
    private Date m;
    private Date n;
    private long o;
    private long p;
    private int q;
    private int r;
    private float s;
    private b.e.a.j.h t;
    private double u;
    private double v;

    static {
        k();
        w = b.e.a.j.f.a(g0.class);
    }

    public g0() {
        super("tkhd");
        this.m = new Date(0L);
        this.n = new Date(0L);
        this.t = b.e.a.j.h.j;
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("TrackHeaderBox.java", g0.class);
        x = bVar.f("method-execution", bVar.e("1", "getCreationTime", "com.coremedia.iso.boxes.TrackHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.util.Date"), 62);
        y = bVar.f("method-execution", bVar.e("1", "getModificationTime", "com.coremedia.iso.boxes.TrackHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.util.Date"), 66);
        H = bVar.f("method-execution", bVar.e("1", "getContent", "com.coremedia.iso.boxes.TrackHeaderBox", "java.nio.ByteBuffer", "byteBuffer", BuildConfig.FLAVOR, "void"), 145);
        I = bVar.f("method-execution", bVar.e("1", "toString", "com.coremedia.iso.boxes.TrackHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 173);
        J = bVar.f("method-execution", bVar.e("1", "setCreationTime", "com.coremedia.iso.boxes.TrackHeaderBox", "java.util.Date", "creationTime", BuildConfig.FLAVOR, "void"), 199);
        K = bVar.f("method-execution", bVar.e("1", "setModificationTime", "com.coremedia.iso.boxes.TrackHeaderBox", "java.util.Date", "modificationTime", BuildConfig.FLAVOR, "void"), 206);
        L = bVar.f("method-execution", bVar.e("1", "setTrackId", "com.coremedia.iso.boxes.TrackHeaderBox", "long", "trackId", BuildConfig.FLAVOR, "void"), 214);
        M = bVar.f("method-execution", bVar.e("1", "setDuration", "com.coremedia.iso.boxes.TrackHeaderBox", "long", "duration", BuildConfig.FLAVOR, "void"), 218);
        N = bVar.f("method-execution", bVar.e("1", "setLayer", "com.coremedia.iso.boxes.TrackHeaderBox", "int", "layer", BuildConfig.FLAVOR, "void"), 225);
        O = bVar.f("method-execution", bVar.e("1", "setAlternateGroup", "com.coremedia.iso.boxes.TrackHeaderBox", "int", "alternateGroup", BuildConfig.FLAVOR, "void"), 229);
        P = bVar.f("method-execution", bVar.e("1", "setVolume", "com.coremedia.iso.boxes.TrackHeaderBox", "float", "volume", BuildConfig.FLAVOR, "void"), 233);
        Q = bVar.f("method-execution", bVar.e("1", "setMatrix", "com.coremedia.iso.boxes.TrackHeaderBox", "com.googlecode.mp4parser.util.Matrix", "matrix", BuildConfig.FLAVOR, "void"), 237);
        z = bVar.f("method-execution", bVar.e("1", "getTrackId", "com.coremedia.iso.boxes.TrackHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "long"), 70);
        R = bVar.f("method-execution", bVar.e("1", "setWidth", "com.coremedia.iso.boxes.TrackHeaderBox", "double", "width", BuildConfig.FLAVOR, "void"), 241);
        S = bVar.f("method-execution", bVar.e("1", "setHeight", "com.coremedia.iso.boxes.TrackHeaderBox", "double", "height", BuildConfig.FLAVOR, "void"), 245);
        bVar.f("method-execution", bVar.e("1", "isEnabled", "com.coremedia.iso.boxes.TrackHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "boolean"), 250);
        bVar.f("method-execution", bVar.e("1", "isInMovie", "com.coremedia.iso.boxes.TrackHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "boolean"), 254);
        bVar.f("method-execution", bVar.e("1", "isInPreview", "com.coremedia.iso.boxes.TrackHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "boolean"), 258);
        bVar.f("method-execution", bVar.e("1", "isInPoster", "com.coremedia.iso.boxes.TrackHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "boolean"), 262);
        T = bVar.f("method-execution", bVar.e("1", "setEnabled", "com.coremedia.iso.boxes.TrackHeaderBox", "boolean", "enabled", BuildConfig.FLAVOR, "void"), 266);
        U = bVar.f("method-execution", bVar.e("1", "setInMovie", "com.coremedia.iso.boxes.TrackHeaderBox", "boolean", "inMovie", BuildConfig.FLAVOR, "void"), 274);
        bVar.f("method-execution", bVar.e("1", "setInPreview", "com.coremedia.iso.boxes.TrackHeaderBox", "boolean", "inPreview", BuildConfig.FLAVOR, "void"), 282);
        bVar.f("method-execution", bVar.e("1", "setInPoster", "com.coremedia.iso.boxes.TrackHeaderBox", "boolean", "inPoster", BuildConfig.FLAVOR, "void"), 290);
        A = bVar.f("method-execution", bVar.e("1", "getDuration", "com.coremedia.iso.boxes.TrackHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "long"), 74);
        B = bVar.f("method-execution", bVar.e("1", "getLayer", "com.coremedia.iso.boxes.TrackHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "int"), 78);
        C = bVar.f("method-execution", bVar.e("1", "getAlternateGroup", "com.coremedia.iso.boxes.TrackHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "int"), 82);
        D = bVar.f("method-execution", bVar.e("1", "getVolume", "com.coremedia.iso.boxes.TrackHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "float"), 86);
        E = bVar.f("method-execution", bVar.e("1", "getMatrix", "com.coremedia.iso.boxes.TrackHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "com.googlecode.mp4parser.util.Matrix"), 90);
        F = bVar.f("method-execution", bVar.e("1", "getWidth", "com.coremedia.iso.boxes.TrackHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "double"), 94);
        G = bVar.f("method-execution", bVar.e("1", "getHeight", "com.coremedia.iso.boxes.TrackHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "double"), 98);
    }

    public long A() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(z, this, this));
        return this.o;
    }

    public float B() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(D, this, this));
        return this.s;
    }

    public double C() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(F, this, this));
        return this.u;
    }

    public void D(int i) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(O, this, this, c.b.a.b.a.a.d(i)));
        this.r = i;
    }

    public void E(Date date) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(J, this, this, date));
        this.m = date;
        if (b.e.a.j.c.a(date) >= 4294967296L) {
            q(1);
        }
    }

    public void F(long j) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(M, this, this, c.b.a.b.a.a.e(j)));
        this.p = j;
        if (j >= 4294967296L) {
            p(1);
        }
    }

    public void G(boolean z2) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(T, this, this, c.b.a.b.a.a.a(z2)));
        p(z2 ? l() | 1 : l() & (-2));
    }

    public void H(double d2) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(S, this, this, c.b.a.b.a.a.b(d2)));
        this.v = d2;
    }

    public void I(boolean z2) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(U, this, this, c.b.a.b.a.a.a(z2)));
        p(z2 ? l() | 2 : l() & (-3));
    }

    public void J(int i) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(N, this, this, c.b.a.b.a.a.d(i)));
        this.q = i;
    }

    public void K(b.e.a.j.h hVar) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(Q, this, this, hVar));
        this.t = hVar;
    }

    public void L(Date date) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(K, this, this, date));
        this.n = date;
        if (b.e.a.j.c.a(date) >= 4294967296L) {
            q(1);
        }
    }

    public void M(long j) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(L, this, this, c.b.a.b.a.a.e(j)));
        this.o = j;
    }

    public void N(float f) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(P, this, this, c.b.a.b.a.a.c(f)));
        this.s = f;
    }

    public void O(double d2) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(R, this, this, c.b.a.b.a.a.b(d2)));
        this.u = d2;
    }

    @Override // b.e.a.a
    public void c(ByteBuffer byteBuffer) {
        long j;
        o(byteBuffer);
        if (n() == 1) {
            this.m = b.e.a.j.c.b(b.c.a.e.m(byteBuffer));
            this.n = b.e.a.j.c.b(b.c.a.e.m(byteBuffer));
            this.o = b.c.a.e.k(byteBuffer);
            b.c.a.e.k(byteBuffer);
            j = byteBuffer.getLong();
        } else {
            this.m = b.e.a.j.c.b(b.c.a.e.k(byteBuffer));
            this.n = b.e.a.j.c.b(b.c.a.e.k(byteBuffer));
            this.o = b.c.a.e.k(byteBuffer);
            b.c.a.e.k(byteBuffer);
            j = byteBuffer.getInt();
        }
        this.p = j;
        if (this.p < -1) {
            w.d("tkhd duration is not in expected range");
        }
        b.c.a.e.k(byteBuffer);
        b.c.a.e.k(byteBuffer);
        this.q = b.c.a.e.i(byteBuffer);
        this.r = b.c.a.e.i(byteBuffer);
        this.s = b.c.a.e.e(byteBuffer);
        b.c.a.e.i(byteBuffer);
        this.t = b.e.a.j.h.a(byteBuffer);
        this.u = b.c.a.e.d(byteBuffer);
        this.v = b.c.a.e.d(byteBuffer);
    }

    @Override // b.e.a.a
    public void d(ByteBuffer byteBuffer) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(H, this, this, byteBuffer));
        r(byteBuffer);
        if (n() == 1) {
            b.c.a.f.i(byteBuffer, b.e.a.j.c.a(this.m));
            b.c.a.f.i(byteBuffer, b.e.a.j.c.a(this.n));
            b.c.a.f.g(byteBuffer, this.o);
            b.c.a.f.g(byteBuffer, 0L);
            byteBuffer.putLong(this.p);
        } else {
            b.c.a.f.g(byteBuffer, b.e.a.j.c.a(this.m));
            b.c.a.f.g(byteBuffer, b.e.a.j.c.a(this.n));
            b.c.a.f.g(byteBuffer, this.o);
            b.c.a.f.g(byteBuffer, 0L);
            byteBuffer.putInt((int) this.p);
        }
        b.c.a.f.g(byteBuffer, 0L);
        b.c.a.f.g(byteBuffer, 0L);
        b.c.a.f.e(byteBuffer, this.q);
        b.c.a.f.e(byteBuffer, this.r);
        b.c.a.f.c(byteBuffer, this.s);
        b.c.a.f.e(byteBuffer, 0);
        this.t.c(byteBuffer);
        b.c.a.f.b(byteBuffer, this.u);
        b.c.a.f.b(byteBuffer, this.v);
    }

    @Override // b.e.a.a
    protected long e() {
        return (n() == 1 ? 36L : 24L) + 60;
    }

    public int s() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(C, this, this));
        return this.r;
    }

    public String toString() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(I, this, this));
        return "TrackHeaderBox[creationTime=" + u() + ";modificationTime=" + z() + ";trackId=" + A() + ";duration=" + v() + ";layer=" + x() + ";alternateGroup=" + s() + ";volume=" + B() + ";matrix=" + this.t + ";width=" + C() + ";height=" + w() + "]";
    }

    public Date u() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(x, this, this));
        return this.m;
    }

    public long v() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(A, this, this));
        return this.p;
    }

    public double w() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(G, this, this));
        return this.v;
    }

    public int x() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(B, this, this));
        return this.q;
    }

    public b.e.a.j.h y() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(E, this, this));
        return this.t;
    }

    public Date z() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(y, this, this));
        return this.n;
    }
}
