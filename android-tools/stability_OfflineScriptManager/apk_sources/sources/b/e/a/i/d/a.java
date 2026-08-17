package b.e.a.i.d;

import b.e.a.c;
import b.e.a.g;
import b.e.a.i.d.c.l;
import c.b.a.a.a;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.util.logging.Level;
import java.util.logging.Logger;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class a extends c {
    private static Logger o;
    private static final /* synthetic */ a.InterfaceC0057a p = null;
    private static final /* synthetic */ a.InterfaceC0057a q = null;
    protected b.e.a.i.d.c.b m;
    protected ByteBuffer n;

    static {
        k();
        o = Logger.getLogger(a.class.getName());
    }

    public a(String str) {
        super(str);
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("AbstractDescriptorBox.java", a.class);
        bVar.f("method-execution", bVar.e("1", "getData", "com.googlecode.mp4parser.boxes.mp4.AbstractDescriptorBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.nio.ByteBuffer"), 42);
        bVar.f("method-execution", bVar.e("1", "setData", "com.googlecode.mp4parser.boxes.mp4.AbstractDescriptorBox", "java.nio.ByteBuffer", "data", BuildConfig.FLAVOR, "void"), 46);
        p = bVar.f("method-execution", bVar.e("1", "getDescriptor", "com.googlecode.mp4parser.boxes.mp4.AbstractDescriptorBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "com.googlecode.mp4parser.boxes.mp4.objectdescriptors.BaseDescriptor"), 62);
        q = bVar.f("method-execution", bVar.e("1", "setDescriptor", "com.googlecode.mp4parser.boxes.mp4.AbstractDescriptorBox", "com.googlecode.mp4parser.boxes.mp4.objectdescriptors.BaseDescriptor", "descriptor", BuildConfig.FLAVOR, "void"), 66);
        bVar.f("method-execution", bVar.e("1", "getDescriptorAsString", "com.googlecode.mp4parser.boxes.mp4.AbstractDescriptorBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.lang.String"), 70);
    }

    @Override // b.e.a.a
    public void c(ByteBuffer byteBuffer) {
        o(byteBuffer);
        this.n = byteBuffer.slice();
        byteBuffer.position(byteBuffer.position() + byteBuffer.remaining());
        try {
            this.n.rewind();
            this.m = l.a(-1, this.n.duplicate());
        } catch (IOException | IndexOutOfBoundsException e) {
            o.log(Level.WARNING, "Error parsing ObjectDescriptor", e);
        }
    }

    @Override // b.e.a.a
    protected void d(ByteBuffer byteBuffer) {
        r(byteBuffer);
        this.n.rewind();
        byteBuffer.put(this.n);
    }

    @Override // b.e.a.a
    protected long e() {
        return this.n.limit() + 4;
    }

    public b.e.a.i.d.c.b s() {
        g.b().c(c.b.a.b.b.b.c(p, this, this));
        return this.m;
    }

    public void u(b.e.a.i.d.c.b bVar) {
        g.b().c(c.b.a.b.b.b.d(q, this, this, bVar));
        this.m = bVar;
    }
}
