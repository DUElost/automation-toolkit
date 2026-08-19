package b.e.a.i;

import b.c.a.e;
import b.c.a.f;
import b.e.a.c;
import b.e.a.g;
import b.g.b.a.a;
import c.b.a.a.a;
import java.nio.BufferUnderflowException;
import java.nio.ByteBuffer;
import java.nio.channels.WritableByteChannel;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public abstract class a extends c {
    private static final /* synthetic */ a.InterfaceC0057a q = null;
    private static final /* synthetic */ a.InterfaceC0057a r = null;
    private static final /* synthetic */ a.InterfaceC0057a s = null;
    private static final /* synthetic */ a.InterfaceC0057a t = null;
    protected int m;
    protected int n;
    protected byte[] o;
    List<b.g.b.a.a> p;

    static {
        k();
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public a(String str) {
        super(str);
        this.m = -1;
        this.n = -1;
        this.o = new byte[]{-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1};
        this.p = Collections.emptyList();
    }

    private static /* synthetic */ void k() {
        c.b.a.b.b.b bVar = new c.b.a.b.b.b("AbstractSampleEncryptionBox.java", a.class);
        q = bVar.f("method-execution", bVar.e("1", "getOffsetToFirstIV", "com.googlecode.mp4parser.boxes.AbstractSampleEncryptionBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "int"), 29);
        bVar.f("method-execution", bVar.e("1", "getEntries", "com.googlecode.mp4parser.boxes.AbstractSampleEncryptionBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.util.List"), 89);
        r = bVar.f("method-execution", bVar.e("1", "setEntries", "com.googlecode.mp4parser.boxes.AbstractSampleEncryptionBox", "java.util.List", "entries", BuildConfig.FLAVOR, "void"), 93);
        s = bVar.f("method-execution", bVar.e("1", "equals", "com.googlecode.mp4parser.boxes.AbstractSampleEncryptionBox", "java.lang.Object", "o", BuildConfig.FLAVOR, "boolean"), 173);
        t = bVar.f("method-execution", bVar.e("1", "hashCode", "com.googlecode.mp4parser.boxes.AbstractSampleEncryptionBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "int"), 200);
        bVar.f("method-execution", bVar.e("1", "getEntrySizes", "com.googlecode.mp4parser.boxes.AbstractSampleEncryptionBox", BuildConfig.FLAVOR, BuildConfig.FLAVOR, BuildConfig.FLAVOR, "java.util.List"), 208);
    }

    private int s() {
        int i = 0;
        for (b.g.b.a.a aVar : this.p) {
            if (aVar.b() > 0) {
                i++;
            }
        }
        return i;
    }

    private List<b.g.b.a.a> x(ByteBuffer byteBuffer, long j, int i) {
        ArrayList arrayList = new ArrayList();
        while (true) {
            long j2 = j - 1;
            if (j <= 0) {
                return arrayList;
            }
            try {
                b.g.b.a.a aVar = new b.g.b.a.a();
                byte[] bArr = new byte[i];
                aVar.f1633a = bArr;
                byteBuffer.get(bArr);
                if ((l() & 2) > 0) {
                    aVar.f1634b = new a.j[e.i(byteBuffer)];
                    int i2 = 0;
                    while (true) {
                        a.j[] jVarArr = aVar.f1634b;
                        if (i2 >= jVarArr.length) {
                            break;
                        }
                        jVarArr[i2] = aVar.a(e.i(byteBuffer), e.k(byteBuffer));
                        i2++;
                    }
                }
                arrayList.add(aVar);
                j = j2;
            } catch (BufferUnderflowException unused) {
                return null;
            }
        }
    }

    @Override // b.e.a.a
    public void c(ByteBuffer byteBuffer) {
        o(byteBuffer);
        if ((l() & 1) > 0) {
            this.m = e.j(byteBuffer);
            this.n = e.n(byteBuffer);
            byte[] bArr = new byte[16];
            this.o = bArr;
            byteBuffer.get(bArr);
        }
        long k = e.k(byteBuffer);
        ByteBuffer duplicate = byteBuffer.duplicate();
        ByteBuffer duplicate2 = byteBuffer.duplicate();
        List<b.g.b.a.a> x = x(duplicate, k, 8);
        this.p = x;
        if (x == null) {
            this.p = x(duplicate2, k, 16);
            byteBuffer.position((byteBuffer.position() + byteBuffer.remaining()) - duplicate2.remaining());
        } else {
            byteBuffer.position((byteBuffer.position() + byteBuffer.remaining()) - duplicate.remaining());
        }
        if (this.p == null) {
            throw new RuntimeException("Cannot parse SampleEncryptionBox");
        }
    }

    @Override // b.e.a.a
    protected void d(ByteBuffer byteBuffer) {
        a.j[] jVarArr;
        r(byteBuffer);
        if (v()) {
            f.f(byteBuffer, this.m);
            f.j(byteBuffer, this.n);
            byteBuffer.put(this.o);
        }
        f.g(byteBuffer, s());
        for (b.g.b.a.a aVar : this.p) {
            if (aVar.b() > 0) {
                byte[] bArr = aVar.f1633a;
                if (bArr.length != 8 && bArr.length != 16) {
                    throw new RuntimeException("IV must be either 8 or 16 bytes");
                }
                byteBuffer.put(bArr);
                if (w()) {
                    f.e(byteBuffer, aVar.f1634b.length);
                    for (a.j jVar : aVar.f1634b) {
                        f.e(byteBuffer, jVar.clear());
                        f.g(byteBuffer, jVar.a());
                    }
                }
            }
        }
    }

    @Override // b.e.a.a
    protected long e() {
        long length = (v() ? 8 + this.o.length : 4L) + 4;
        for (b.g.b.a.a aVar : this.p) {
            length += aVar.b();
        }
        return length;
    }

    public boolean equals(Object obj) {
        g.b().c(c.b.a.b.b.b.d(s, this, this, obj));
        if (this == obj) {
            return true;
        }
        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }
        a aVar = (a) obj;
        if (this.m == aVar.m && this.n == aVar.n) {
            List<b.g.b.a.a> list = this.p;
            if (list == null ? aVar.p == null : list.equals(aVar.p)) {
                return Arrays.equals(this.o, aVar.o);
            }
            return false;
        }
        return false;
    }

    public int hashCode() {
        g.b().c(c.b.a.b.b.b.c(t, this, this));
        int i = ((this.m * 31) + this.n) * 31;
        byte[] bArr = this.o;
        int hashCode = (i + (bArr != null ? Arrays.hashCode(bArr) : 0)) * 31;
        List<b.g.b.a.a> list = this.p;
        return hashCode + (list != null ? list.hashCode() : 0);
    }

    @Override // b.e.a.a, b.c.a.i.b
    public void t(WritableByteChannel writableByteChannel) {
        super.t(writableByteChannel);
    }

    public int u() {
        g.b().c(c.b.a.b.b.b.c(q, this, this));
        return (a() > 4294967296L ? 16 : 8) + (v() ? this.o.length + 4 : 0) + 4;
    }

    protected boolean v() {
        return (l() & 1) > 0;
    }

    public boolean w() {
        return (l() & 2) > 0;
    }

    public void y(List<b.g.b.a.a> list) {
        g.b().c(c.b.a.b.b.b.d(r, this, this, list));
        this.p = list;
    }

    public void z(boolean z) {
        p(z ? l() | 2 : l() & 16777213);
    }
}
