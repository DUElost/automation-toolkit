package b.e.a;

import c.b.a.a.a;
import java.nio.ByteBuffer;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public abstract class c extends a implements b.c.a.i.b {
    private static final /* synthetic */ a.InterfaceC0057a k = null;
    private static final /* synthetic */ a.InterfaceC0057a l = null;
    private int i;
    private int j;

    static {
        k();
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public c(String str) {
        super(str);
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("AbstractFullBox.java", c.class);
        k = bVar.f("method-execution", bVar.e("1", "setVersion", "com.googlecode.mp4parser.AbstractFullBox", "int", "version", BuildConfig.FLAVOR, "void"), 51);
        l = bVar.f("method-execution", bVar.e("1", "setFlags", "com.googlecode.mp4parser.AbstractFullBox", "int", "flags", BuildConfig.FLAVOR, "void"), 64);
    }

    public int l() {
        if (!this.e) {
            j();
        }
        return this.j;
    }

    public int n() {
        if (!this.e) {
            j();
        }
        return this.i;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final long o(ByteBuffer byteBuffer) {
        this.i = b.c.a.e.n(byteBuffer);
        this.j = b.c.a.e.j(byteBuffer);
        return 4L;
    }

    public void p(int i) {
        g.b().c(c.b.a.b.b.b.d(l, this, this, c.b.a.b.a.a.d(i)));
        this.j = i;
    }

    public void q(int i) {
        g.b().c(c.b.a.b.b.b.d(k, this, this, c.b.a.b.a.a.d(i)));
        this.i = i;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void r(ByteBuffer byteBuffer) {
        b.c.a.f.j(byteBuffer, this.i);
        b.c.a.f.f(byteBuffer, this.j);
    }
}
