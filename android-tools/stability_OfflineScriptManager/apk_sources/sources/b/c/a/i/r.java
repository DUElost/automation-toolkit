package b.c.a.i;

import c.b.a.a.a;
import java.nio.ByteBuffer;
import java.util.Date;
import jxl.SheetSettings;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class r extends b.e.a.c {
    private static b.e.a.j.f A;
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
    private Date m;
    private Date n;
    private long o;
    private long p;
    private double q;
    private float r;
    private b.e.a.j.h s;
    private long t;
    private int u;
    private int v;
    private int w;
    private int x;
    private int y;
    private int z;

    static {
        k();
        A = b.e.a.j.f.a(r.class);
    }

    public r() {
        super("mvhd");
        this.q = 1.0d;
        this.r = 1.0f;
        this.s = b.e.a.j.h.j;
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("MovieHeaderBox.java", r.class);
        B = bVar.f("method-execution", bVar.e("1", "getCreationTime", "com.coremedia.iso.boxes.MovieHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.util.Date"), 66);
        C = bVar.f("method-execution", bVar.e("1", "getModificationTime", "com.coremedia.iso.boxes.MovieHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.util.Date"), 70);
        L = bVar.f("method-execution", bVar.e("1", "setModificationTime", "com.coremedia.iso.boxes.MovieHeaderBox", "java.util.Date", "modificationTime", BuildConfig.FLAVOR, "void"), 212);
        M = bVar.f("method-execution", bVar.e("1", "setTimescale", "com.coremedia.iso.boxes.MovieHeaderBox", "long", "timescale", BuildConfig.FLAVOR, "void"), 220);
        N = bVar.f("method-execution", bVar.e("1", "setDuration", "com.coremedia.iso.boxes.MovieHeaderBox", "long", "duration", BuildConfig.FLAVOR, "void"), 224);
        bVar.f("method-execution", bVar.e("1", "setRate", "com.coremedia.iso.boxes.MovieHeaderBox", "double", "rate", BuildConfig.FLAVOR, "void"), 231);
        bVar.f("method-execution", bVar.e("1", "setVolume", "com.coremedia.iso.boxes.MovieHeaderBox", "float", "volume", BuildConfig.FLAVOR, "void"), 235);
        O = bVar.f("method-execution", bVar.e("1", "setMatrix", "com.coremedia.iso.boxes.MovieHeaderBox", "com.googlecode.mp4parser.util.Matrix", "matrix", BuildConfig.FLAVOR, "void"), 239);
        P = bVar.f("method-execution", bVar.e("1", "setNextTrackId", "com.coremedia.iso.boxes.MovieHeaderBox", "long", "nextTrackId", BuildConfig.FLAVOR, "void"), 243);
        bVar.f("method-execution", bVar.e("1", "getPreviewTime", "com.coremedia.iso.boxes.MovieHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "int"), 247);
        bVar.f("method-execution", bVar.e("1", "setPreviewTime", "com.coremedia.iso.boxes.MovieHeaderBox", "int", "previewTime", BuildConfig.FLAVOR, "void"), 251);
        bVar.f("method-execution", bVar.e("1", "getPreviewDuration", "com.coremedia.iso.boxes.MovieHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "int"), SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT);
        D = bVar.f("method-execution", bVar.e("1", "getTimescale", "com.coremedia.iso.boxes.MovieHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "long"), 74);
        bVar.f("method-execution", bVar.e("1", "setPreviewDuration", "com.coremedia.iso.boxes.MovieHeaderBox", "int", "previewDuration", BuildConfig.FLAVOR, "void"), 259);
        bVar.f("method-execution", bVar.e("1", "getPosterTime", "com.coremedia.iso.boxes.MovieHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "int"), 263);
        bVar.f("method-execution", bVar.e("1", "setPosterTime", "com.coremedia.iso.boxes.MovieHeaderBox", "int", "posterTime", BuildConfig.FLAVOR, "void"), 267);
        bVar.f("method-execution", bVar.e("1", "getSelectionTime", "com.coremedia.iso.boxes.MovieHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "int"), 271);
        bVar.f("method-execution", bVar.e("1", "setSelectionTime", "com.coremedia.iso.boxes.MovieHeaderBox", "int", "selectionTime", BuildConfig.FLAVOR, "void"), 275);
        bVar.f("method-execution", bVar.e("1", "getSelectionDuration", "com.coremedia.iso.boxes.MovieHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "int"), 279);
        bVar.f("method-execution", bVar.e("1", "setSelectionDuration", "com.coremedia.iso.boxes.MovieHeaderBox", "int", "selectionDuration", BuildConfig.FLAVOR, "void"), 283);
        bVar.f("method-execution", bVar.e("1", "getCurrentTime", "com.coremedia.iso.boxes.MovieHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "int"), 287);
        bVar.f("method-execution", bVar.e("1", "setCurrentTime", "com.coremedia.iso.boxes.MovieHeaderBox", "int", "currentTime", BuildConfig.FLAVOR, "void"), 291);
        E = bVar.f("method-execution", bVar.e("1", "getDuration", "com.coremedia.iso.boxes.MovieHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "long"), 78);
        F = bVar.f("method-execution", bVar.e("1", "getRate", "com.coremedia.iso.boxes.MovieHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "double"), 82);
        G = bVar.f("method-execution", bVar.e("1", "getVolume", "com.coremedia.iso.boxes.MovieHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "float"), 86);
        H = bVar.f("method-execution", bVar.e("1", "getMatrix", "com.coremedia.iso.boxes.MovieHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "com.googlecode.mp4parser.util.Matrix"), 90);
        I = bVar.f("method-execution", bVar.e("1", "getNextTrackId", "com.coremedia.iso.boxes.MovieHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "long"), 94);
        J = bVar.f("method-execution", bVar.e("1", "toString", "com.coremedia.iso.boxes.MovieHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 148);
        K = bVar.f("method-execution", bVar.e("1", "setCreationTime", "com.coremedia.iso.boxes.MovieHeaderBox", "java.util.Date", "creationTime", BuildConfig.FLAVOR, "void"), 204);
    }

    public float A() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(G, this, this));
        return this.r;
    }

    public void B(Date date) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(K, this, this, date));
        this.m = date;
        if (b.e.a.j.c.a(date) >= 4294967296L) {
            q(1);
        }
    }

    public void C(long j) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(N, this, this, c.b.a.b.a.a.e(j)));
        this.p = j;
        if (j >= 4294967296L) {
            q(1);
        }
    }

    public void D(b.e.a.j.h hVar) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(O, this, this, hVar));
        this.s = hVar;
    }

    public void E(Date date) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(L, this, this, date));
        this.n = date;
        if (b.e.a.j.c.a(date) >= 4294967296L) {
            q(1);
        }
    }

    public void F(long j) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(P, this, this, c.b.a.b.a.a.e(j)));
        this.t = j;
    }

    public void G(long j) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(M, this, this, c.b.a.b.a.a.e(j)));
        this.o = j;
    }

    @Override // b.e.a.a
    public void c(ByteBuffer byteBuffer) {
        long j;
        o(byteBuffer);
        if (n() == 1) {
            this.m = b.e.a.j.c.b(b.c.a.e.m(byteBuffer));
            this.n = b.e.a.j.c.b(b.c.a.e.m(byteBuffer));
            this.o = b.c.a.e.k(byteBuffer);
            j = byteBuffer.getLong();
        } else {
            this.m = b.e.a.j.c.b(b.c.a.e.k(byteBuffer));
            this.n = b.e.a.j.c.b(b.c.a.e.k(byteBuffer));
            this.o = b.c.a.e.k(byteBuffer);
            j = byteBuffer.getInt();
        }
        this.p = j;
        if (this.p < -1) {
            A.d("mvhd duration is not in expected range");
        }
        this.q = b.c.a.e.d(byteBuffer);
        this.r = b.c.a.e.e(byteBuffer);
        b.c.a.e.i(byteBuffer);
        b.c.a.e.k(byteBuffer);
        b.c.a.e.k(byteBuffer);
        this.s = b.e.a.j.h.a(byteBuffer);
        this.u = byteBuffer.getInt();
        this.v = byteBuffer.getInt();
        this.w = byteBuffer.getInt();
        this.x = byteBuffer.getInt();
        this.y = byteBuffer.getInt();
        this.z = byteBuffer.getInt();
        this.t = b.c.a.e.k(byteBuffer);
    }

    @Override // b.e.a.a
    protected void d(ByteBuffer byteBuffer) {
        r(byteBuffer);
        if (n() == 1) {
            b.c.a.f.i(byteBuffer, b.e.a.j.c.a(this.m));
            b.c.a.f.i(byteBuffer, b.e.a.j.c.a(this.n));
            b.c.a.f.g(byteBuffer, this.o);
            byteBuffer.putLong(this.p);
        } else {
            b.c.a.f.g(byteBuffer, b.e.a.j.c.a(this.m));
            b.c.a.f.g(byteBuffer, b.e.a.j.c.a(this.n));
            b.c.a.f.g(byteBuffer, this.o);
            byteBuffer.putInt((int) this.p);
        }
        b.c.a.f.b(byteBuffer, this.q);
        b.c.a.f.c(byteBuffer, this.r);
        b.c.a.f.e(byteBuffer, 0);
        b.c.a.f.g(byteBuffer, 0L);
        b.c.a.f.g(byteBuffer, 0L);
        this.s.c(byteBuffer);
        byteBuffer.putInt(this.u);
        byteBuffer.putInt(this.v);
        byteBuffer.putInt(this.w);
        byteBuffer.putInt(this.x);
        byteBuffer.putInt(this.y);
        byteBuffer.putInt(this.z);
        b.c.a.f.g(byteBuffer, this.t);
    }

    @Override // b.e.a.a
    protected long e() {
        return (n() == 1 ? 32L : 20L) + 80;
    }

    public Date s() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(B, this, this));
        return this.m;
    }

    public String toString() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(J, this, this));
        return "MovieHeaderBox[creationTime=" + s() + ";modificationTime=" + w() + ";timescale=" + z() + ";duration=" + u() + ";rate=" + y() + ";volume=" + A() + ";matrix=" + this.s + ";nextTrackId=" + x() + "]";
    }

    public long u() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(E, this, this));
        return this.p;
    }

    public b.e.a.j.h v() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(H, this, this));
        return this.s;
    }

    public Date w() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(C, this, this));
        return this.n;
    }

    public long x() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(I, this, this));
        return this.t;
    }

    public double y() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(F, this, this));
        return this.q;
    }

    public long z() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(D, this, this));
        return this.o;
    }
}
