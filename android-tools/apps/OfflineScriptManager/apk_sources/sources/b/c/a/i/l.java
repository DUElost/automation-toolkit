package b.c.a.i;

import c.b.a.a.a;
import java.nio.ByteBuffer;
import java.util.Collections;
import java.util.HashMap;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class l extends b.e.a.c {
    private static final /* synthetic */ a.InterfaceC0057a t = null;
    private static final /* synthetic */ a.InterfaceC0057a u = null;
    private static final /* synthetic */ a.InterfaceC0057a v = null;
    private static final /* synthetic */ a.InterfaceC0057a w = null;
    private String m;
    private String n;
    private long o;
    private long p;
    private long q;
    private boolean r;
    private long s;

    static {
        k();
        HashMap hashMap = new HashMap();
        hashMap.put("odsm", "ObjectDescriptorStream - defined in ISO/IEC JTC1/SC29/WG11 - CODING OF MOVING PICTURES AND AUDIO");
        hashMap.put("crsm", "ClockReferenceStream - defined in ISO/IEC JTC1/SC29/WG11 - CODING OF MOVING PICTURES AND AUDIO");
        hashMap.put("sdsm", "SceneDescriptionStream - defined in ISO/IEC JTC1/SC29/WG11 - CODING OF MOVING PICTURES AND AUDIO");
        hashMap.put("m7sm", "MPEG7Stream - defined in ISO/IEC JTC1/SC29/WG11 - CODING OF MOVING PICTURES AND AUDIO");
        hashMap.put("ocsm", "ObjectContentInfoStream - defined in ISO/IEC JTC1/SC29/WG11 - CODING OF MOVING PICTURES AND AUDIO");
        hashMap.put("ipsm", "IPMP Stream - defined in ISO/IEC JTC1/SC29/WG11 - CODING OF MOVING PICTURES AND AUDIO");
        hashMap.put("mjsm", "MPEG-J Stream - defined in ISO/IEC JTC1/SC29/WG11 - CODING OF MOVING PICTURES AND AUDIO");
        hashMap.put("mdir", "Apple Meta Data iTunes Reader");
        hashMap.put("mp7b", "MPEG-7 binary XML");
        hashMap.put("mp7t", "MPEG-7 XML");
        hashMap.put("vide", "Video Track");
        hashMap.put("soun", "Sound Track");
        hashMap.put("hint", "Hint Track");
        hashMap.put("appl", "Apple specific");
        hashMap.put("meta", "Timed Metadata track - defined in ISO/IEC JTC1/SC29/WG11 - CODING OF MOVING PICTURES AND AUDIO");
        Collections.unmodifiableMap(hashMap);
    }

    public l() {
        super("hdlr");
        this.n = null;
        this.r = true;
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("HandlerBox.java", l.class);
        t = bVar.f("method-execution", bVar.e("1", "getHandlerType", "com.coremedia.iso.boxes.HandlerBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 78);
        bVar.f("method-execution", bVar.e("1", "setName", "com.coremedia.iso.boxes.HandlerBox", "java.lang.String", "name", BuildConfig.FLAVOR, "void"), 87);
        u = bVar.f("method-execution", bVar.e("1", "setHandlerType", "com.coremedia.iso.boxes.HandlerBox", "java.lang.String", "handlerType", BuildConfig.FLAVOR, "void"), 91);
        v = bVar.f("method-execution", bVar.e("1", "getName", "com.coremedia.iso.boxes.HandlerBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 95);
        bVar.f("method-execution", bVar.e("1", "getHumanReadableTrackType", "com.coremedia.iso.boxes.HandlerBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 99);
        w = bVar.f("method-execution", bVar.e("1", "toString", "com.coremedia.iso.boxes.HandlerBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 149);
    }

    @Override // b.e.a.a
    public void c(ByteBuffer byteBuffer) {
        o(byteBuffer);
        this.s = b.c.a.e.k(byteBuffer);
        this.m = b.c.a.e.b(byteBuffer);
        this.o = b.c.a.e.k(byteBuffer);
        this.p = b.c.a.e.k(byteBuffer);
        this.q = b.c.a.e.k(byteBuffer);
        if (byteBuffer.remaining() > 0) {
            String h = b.c.a.e.h(byteBuffer, byteBuffer.remaining());
            this.n = h;
            if (h.endsWith("\u0000")) {
                String str = this.n;
                this.n = str.substring(0, str.length() - 1);
                this.r = true;
                return;
            }
        }
        this.r = false;
    }

    @Override // b.e.a.a
    protected void d(ByteBuffer byteBuffer) {
        r(byteBuffer);
        b.c.a.f.g(byteBuffer, this.s);
        byteBuffer.put(b.c.a.d.F(this.m));
        b.c.a.f.g(byteBuffer, this.o);
        b.c.a.f.g(byteBuffer, this.p);
        b.c.a.f.g(byteBuffer, this.q);
        String str = this.n;
        if (str != null) {
            byteBuffer.put(b.c.a.h.b(str));
        }
        if (this.r) {
            byteBuffer.put((byte) 0);
        }
    }

    @Override // b.e.a.a
    protected long e() {
        return this.r ? b.c.a.h.c(this.n) + 25 : b.c.a.h.c(this.n) + 24;
    }

    public String s() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(t, this, this));
        return this.m;
    }

    public String toString() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(w, this, this));
        return "HandlerBox[handlerType=" + s() + ";name=" + u() + "]";
    }

    public String u() {
        b.e.a.g.b().c(c.b.a.b.b.b.c(v, this, this));
        return this.n;
    }

    public void v(String str) {
        b.e.a.g.b().c(c.b.a.b.b.b.d(u, this, this, str));
        this.m = str;
    }
}
