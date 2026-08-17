package b.c.a.i.i0;

import c.b.a.a.a;
import java.nio.ByteBuffer;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class d extends b.e.a.c {
    private static final /* synthetic */ a.InterfaceC0057a r = null;
    private static final /* synthetic */ a.InterfaceC0057a s = null;
    private static final /* synthetic */ a.InterfaceC0057a t = null;
    private static final /* synthetic */ a.InterfaceC0057a u = null;
    private long m;
    private long n;
    private long o;
    private long p;
    private c q;

    static {
        k();
    }

    public d() {
        super("trex");
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("TrackExtendsBox.java", d.class);
        r = bVar.f("method-execution", bVar.e("1", "getTrackId", "com.coremedia.iso.boxes.fragment.TrackExtendsBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "long"), 72);
        bVar.f("method-execution", bVar.e("1", "getDefaultSampleDescriptionIndex", "com.coremedia.iso.boxes.fragment.TrackExtendsBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "long"), 76);
        bVar.f("method-execution", bVar.e("1", "setDefaultSampleFlags", "com.coremedia.iso.boxes.fragment.TrackExtendsBox", "com.coremedia.iso.boxes.fragment.SampleFlags", "defaultSampleFlags", BuildConfig.FLAVOR, "void"), 112);
        s = bVar.f("method-execution", bVar.e("1", "getDefaultSampleDuration", "com.coremedia.iso.boxes.fragment.TrackExtendsBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "long"), 80);
        t = bVar.f("method-execution", bVar.e("1", "getDefaultSampleSize", "com.coremedia.iso.boxes.fragment.TrackExtendsBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "long"), 84);
        u = bVar.f("method-execution", bVar.e("1", "getDefaultSampleFlags", "com.coremedia.iso.boxes.fragment.TrackExtendsBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "com.coremedia.iso.boxes.fragment.SampleFlags"), 88);
        bVar.f("method-execution", bVar.e("1", "getDefaultSampleFlagsStr", "com.coremedia.iso.boxes.fragment.TrackExtendsBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 92);
        bVar.f("method-execution", bVar.e("1", "setTrackId", "com.coremedia.iso.boxes.fragment.TrackExtendsBox", "long", "trackId", BuildConfig.FLAVOR, "void"), 96);
        bVar.f("method-execution", bVar.e("1", "setDefaultSampleDescriptionIndex", "com.coremedia.iso.boxes.fragment.TrackExtendsBox", "long", "defaultSampleDescriptionIndex", BuildConfig.FLAVOR, "void"), 100);
        bVar.f("method-execution", bVar.e("1", "setDefaultSampleDuration", "com.coremedia.iso.boxes.fragment.TrackExtendsBox", "long", "defaultSampleDuration", BuildConfig.FLAVOR, "void"), 104);
        bVar.f("method-execution", bVar.e("1", "setDefaultSampleSize", "com.coremedia.iso.boxes.fragment.TrackExtendsBox", "long", "defaultSampleSize", BuildConfig.FLAVOR, "void"), 108);
    }

    @Override // b.e.a.a
    public void c(ByteBuffer byteBuffer) {
        o(byteBuffer);
        this.m = b.c.a.e.k(byteBuffer);
        this.n = b.c.a.e.k(byteBuffer);
        this.o = b.c.a.e.k(byteBuffer);
        this.p = b.c.a.e.k(byteBuffer);
        this.q = new c(byteBuffer);
    }

    @Override // b.e.a.a
    protected void d(ByteBuffer byteBuffer) {
        r(byteBuffer);
        b.c.a.f.g(byteBuffer, this.m);
        b.c.a.f.g(byteBuffer, this.n);
        b.c.a.f.g(byteBuffer, this.o);
        b.c.a.f.g(byteBuffer, this.p);
        this.q.a(byteBuffer);
    }

    @Override // b.e.a.a
    protected long e() {
        return 24L;
    }

    public long s() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(s, this, this));
        return this.o;
    }

    public c u() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(u, this, this));
        return this.q;
    }

    public long v() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(t, this, this));
        return this.p;
    }

    public long w() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(r, this, this));
        return this.m;
    }
}
