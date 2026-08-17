package b.e.a.i.d;

import b.e.a.g;
import b.e.a.i.d.c.h;
import c.b.a.a.a;
import java.nio.ByteBuffer;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class b extends a {
    private static final /* synthetic */ a.InterfaceC0057a r = null;
    private static final /* synthetic */ a.InterfaceC0057a s = null;
    private static final /* synthetic */ a.InterfaceC0057a t = null;

    static {
        k();
    }

    public b() {
        super("esds");
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("ESDescriptorBox.java", b.class);
        r = bVar.f("method-execution", bVar.e("1", "getEsDescriptor", "com.googlecode.mp4parser.boxes.mp4.ESDescriptorBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "com.googlecode.mp4parser.boxes.mp4.objectdescriptors.ESDescriptor"), 35);
        bVar.f("method-execution", bVar.e("1", "setEsDescriptor", "com.googlecode.mp4parser.boxes.mp4.ESDescriptorBox", "com.googlecode.mp4parser.boxes.mp4.objectdescriptors.ESDescriptor", "esDescriptor", BuildConfig.FLAVOR, "void"), 39);
        s = bVar.f("method-execution", bVar.e("1", "equals", "com.googlecode.mp4parser.boxes.mp4.ESDescriptorBox", "java.lang.Object", "o", BuildConfig.FLAVOR, "boolean"), 44);
        t = bVar.f("method-execution", bVar.e("1", "hashCode", "com.googlecode.mp4parser.boxes.mp4.ESDescriptorBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "int"), 55);
    }

    @Override // b.e.a.i.d.a, b.e.a.a
    protected void d(ByteBuffer byteBuffer) {
        r(byteBuffer);
        h v = v();
        byteBuffer.put(v != null ? (ByteBuffer) v.t().rewind() : this.n.duplicate());
    }

    @Override // b.e.a.i.d.a, b.e.a.a
    protected long e() {
        h v = v();
        return (v != null ? v.b() : this.n.remaining()) + 4;
    }

    public boolean equals(Object obj) {
        g.b().c(c.b.a.b.b.b.d(s, this, this, obj));
        if (this == obj) {
            return true;
        }
        if (obj == null || b.class != obj.getClass()) {
            return false;
        }
        ByteBuffer byteBuffer = this.n;
        ByteBuffer byteBuffer2 = ((b) obj).n;
        return byteBuffer == null ? byteBuffer2 == null : byteBuffer.equals(byteBuffer2);
    }

    public int hashCode() {
        g.b().c(c.b.a.b.b.b.c(t, this, this));
        ByteBuffer byteBuffer = this.n;
        if (byteBuffer != null) {
            return byteBuffer.hashCode();
        }
        return 0;
    }

    public h v() {
        g.b().c(c.b.a.b.b.b.c(r, this, this));
        return (h) super.s();
    }
}
