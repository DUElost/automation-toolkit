package b.c.a.i;

import c.b.a.a.a;
import java.nio.ByteBuffer;
import java.util.Date;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class o extends b.e.a.c {
    private static final /* synthetic */ a.InterfaceC0057a A = null;
    private static final /* synthetic */ a.InterfaceC0057a B = null;
    private static b.e.a.j.f r;
    private static final /* synthetic */ a.InterfaceC0057a s = null;
    private static final /* synthetic */ a.InterfaceC0057a t = null;
    private static final /* synthetic */ a.InterfaceC0057a u = null;
    private static final /* synthetic */ a.InterfaceC0057a v = null;
    private static final /* synthetic */ a.InterfaceC0057a w = null;
    private static final /* synthetic */ a.InterfaceC0057a x = null;
    private static final /* synthetic */ a.InterfaceC0057a y = null;
    private static final /* synthetic */ a.InterfaceC0057a z = null;
    private Date m;
    private Date n;
    private long o;
    private long p;
    private String q;

    static {
        k();
        r = b.e.a.j.f.a(o.class);
    }

    public o() {
        super("mdhd");
        this.m = new Date();
        this.n = new Date();
        this.q = "eng";
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("MediaHeaderBox.java", o.class);
        s = bVar.f("method-execution", bVar.e("1", "getCreationTime", "com.coremedia.iso.boxes.MediaHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.util.Date"), 48);
        t = bVar.f("method-execution", bVar.e("1", "getModificationTime", "com.coremedia.iso.boxes.MediaHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.util.Date"), 52);
        B = bVar.f("method-execution", bVar.e("1", "toString", "com.coremedia.iso.boxes.MediaHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 125);
        u = bVar.f("method-execution", bVar.e("1", "getTimescale", "com.coremedia.iso.boxes.MediaHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "long"), 56);
        v = bVar.f("method-execution", bVar.e("1", "getDuration", "com.coremedia.iso.boxes.MediaHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "long"), 60);
        w = bVar.f("method-execution", bVar.e("1", "getLanguage", "com.coremedia.iso.boxes.MediaHeaderBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 64);
        x = bVar.f("method-execution", bVar.e("1", "setCreationTime", "com.coremedia.iso.boxes.MediaHeaderBox", "java.util.Date", "creationTime", BuildConfig.FLAVOR, "void"), 81);
        bVar.f("method-execution", bVar.e("1", "setModificationTime", "com.coremedia.iso.boxes.MediaHeaderBox", "java.util.Date", "modificationTime", BuildConfig.FLAVOR, "void"), 85);
        y = bVar.f("method-execution", bVar.e("1", "setTimescale", "com.coremedia.iso.boxes.MediaHeaderBox", "long", "timescale", BuildConfig.FLAVOR, "void"), 89);
        z = bVar.f("method-execution", bVar.e("1", "setDuration", "com.coremedia.iso.boxes.MediaHeaderBox", "long", "duration", BuildConfig.FLAVOR, "void"), 93);
        A = bVar.f("method-execution", bVar.e("1", "setLanguage", "com.coremedia.iso.boxes.MediaHeaderBox", "java.lang.String", "language", BuildConfig.FLAVOR, "void"), 97);
    }

    public void A(String str) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(A, this, this, str));
        this.q = str;
    }

    public void B(long j) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(y, this, this, c.b.a.b.a.a.e(j)));
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
            r.d("mdhd duration is not in expected range");
        }
        this.q = b.c.a.e.f(byteBuffer);
        b.c.a.e.i(byteBuffer);
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
        b.c.a.f.d(byteBuffer, this.q);
        b.c.a.f.e(byteBuffer, 0);
    }

    @Override // b.e.a.a
    protected long e() {
        return (n() == 1 ? 32L : 20L) + 2 + 2;
    }

    public Date s() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(s, this, this));
        return this.m;
    }

    public String toString() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(B, this, this));
        return "MediaHeaderBox[creationTime=" + s() + ";modificationTime=" + w() + ";timescale=" + x() + ";duration=" + u() + ";language=" + v() + "]";
    }

    public long u() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(v, this, this));
        return this.p;
    }

    public String v() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(w, this, this));
        return this.q;
    }

    public Date w() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(t, this, this));
        return this.n;
    }

    public long x() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(u, this, this));
        return this.o;
    }

    public void y(Date date) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(x, this, this, date));
        this.m = date;
    }

    public void z(long j) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(z, this, this, c.b.a.b.a.a.e(j)));
        this.p = j;
    }
}
