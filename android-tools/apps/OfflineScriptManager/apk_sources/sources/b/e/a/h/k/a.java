package b.e.a.h.k;

import b.c.a.i.e;
import b.c.a.i.f0;
import b.c.a.i.q;
import b.c.a.i.v;
import b.c.a.i.x;
import b.e.a.h.f;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.lang.ref.SoftReference;
import java.nio.ByteBuffer;
import java.nio.channels.WritableByteChannel;
import java.util.AbstractList;
import java.util.Arrays;
import java.util.List;
/* loaded from: classes.dex */
public class a extends AbstractList<f> {
    private static final b.e.a.j.f k = b.e.a.j.f.a(a.class);

    /* renamed from: b  reason: collision with root package name */
    e f1544b;

    /* renamed from: c  reason: collision with root package name */
    f0 f1545c;

    /* renamed from: d  reason: collision with root package name */
    SoftReference<ByteBuffer>[] f1546d;
    int[] e;
    long[] f;
    long[] g;
    long[][] h;
    v i;
    int j = 0;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: b.e.a.h.k.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public class C0051a implements f {

        /* renamed from: a  reason: collision with root package name */
        private int f1547a;

        public C0051a(int i) {
            this.f1547a = i;
        }

        @Override // b.e.a.h.f
        public long a() {
            return a.this.i.v(this.f1547a);
        }

        @Override // b.e.a.h.f
        public void b(WritableByteChannel writableByteChannel) {
            writableByteChannel.write(c());
        }

        public synchronized ByteBuffer c() {
            long j;
            ByteBuffer s;
            int c2 = a.this.c(this.f1547a);
            a aVar = a.this;
            SoftReference<ByteBuffer> softReference = aVar.f1546d[c2];
            int i = aVar.e[c2] - 1;
            long j2 = c2;
            long[] jArr = aVar.h[b.e.a.j.b.a(j2)];
            j = jArr[this.f1547a - i];
            if (softReference == null || (s = softReference.get()) == null) {
                try {
                    a aVar2 = a.this;
                    s = aVar2.f1544b.s(aVar2.f[b.e.a.j.b.a(j2)], jArr[jArr.length - 1] + a.this.i.v((i + jArr.length) - 1));
                    a.this.f1546d[c2] = new SoftReference<>(s);
                } catch (IOException e) {
                    StringWriter stringWriter = new StringWriter();
                    e.printStackTrace(new PrintWriter(stringWriter));
                    a.k.c(stringWriter.toString());
                    throw new IndexOutOfBoundsException(e.getMessage());
                }
            }
            return (ByteBuffer) ((ByteBuffer) s.duplicate().position(b.e.a.j.b.a(j))).slice().limit(b.e.a.j.b.a(a.this.i.v(this.f1547a)));
        }

        public String toString() {
            return "Sample(index: " + this.f1547a + " size: " + a.this.i.v(this.f1547a) + ")";
        }
    }

    public a(long j, e eVar) {
        int i;
        this.f1545c = null;
        this.f1546d = null;
        int i2 = 0;
        this.f1544b = eVar;
        for (f0 f0Var : ((q) eVar.q(q.class).get(0)).q(f0.class)) {
            if (f0Var.I().A() == j) {
                this.f1545c = f0Var;
            }
        }
        f0 f0Var2 = this.f1545c;
        if (f0Var2 == null) {
            throw new RuntimeException("This MP4 does not contain track " + j);
        }
        long[] s = f0Var2.H().G().s();
        this.f = s;
        this.g = new long[s.length];
        SoftReference<ByteBuffer>[] softReferenceArr = new SoftReference[s.length];
        this.f1546d = softReferenceArr;
        Arrays.fill(softReferenceArr, new SoftReference(null));
        this.h = new long[this.f.length];
        this.i = this.f1545c.H().J();
        List<x.a> u = this.f1545c.H().K().u();
        x.a[] aVarArr = (x.a[]) u.toArray(new x.a[u.size()]);
        x.a aVar = aVarArr[0];
        long a2 = aVar.a();
        int a3 = b.e.a.j.b.a(aVar.c());
        int size = size();
        int i3 = 0;
        int i4 = 0;
        int i5 = 1;
        int i6 = 1;
        do {
            i3++;
            if (i3 == a2) {
                if (aVarArr.length > i5) {
                    x.a aVar2 = aVarArr[i5];
                    i4 = a3;
                    a3 = b.e.a.j.b.a(aVar2.c());
                    i5++;
                    a2 = aVar2.a();
                } else {
                    i4 = a3;
                    a3 = -1;
                    a2 = Long.MAX_VALUE;
                }
            }
            this.h[i3 - 1] = new long[i4];
            i6 += i4;
        } while (i6 <= size);
        this.e = new int[i3 + 1];
        x.a aVar3 = aVarArr[0];
        long a4 = aVar3.a();
        int a5 = b.e.a.j.b.a(aVar3.c());
        int i7 = 0;
        int i8 = 0;
        int i9 = 1;
        int i10 = 1;
        while (true) {
            i = i7 + 1;
            this.e[i7] = i9;
            int i11 = i9;
            if (i == a4) {
                if (aVarArr.length > i10) {
                    x.a aVar4 = aVarArr[i10];
                    i8 = a5;
                    a5 = b.e.a.j.b.a(aVar4.c());
                    i10++;
                    a4 = aVar4.a();
                } else {
                    i8 = a5;
                    a5 = -1;
                    a4 = Long.MAX_VALUE;
                }
            }
            i9 = i11 + i8;
            if (i9 > size) {
                break;
            }
            i7 = i;
        }
        this.e[i] = Integer.MAX_VALUE;
        long j2 = 0;
        for (int i12 = 1; i12 <= this.i.s(); i12++) {
            while (i12 == this.e[i2]) {
                i2++;
                j2 = 0;
            }
            long[] jArr = this.g;
            int i13 = i2 - 1;
            int i14 = i12 - 1;
            jArr[i13] = jArr[i13] + this.i.v(i14);
            this.h[i13][i12 - this.e[i13]] = j2;
            j2 += this.i.v(i14);
        }
    }

    @Override // java.util.AbstractList, java.util.List
    /* renamed from: b */
    public f get(int i) {
        if (i < this.i.s()) {
            return new C0051a(i);
        }
        throw new IndexOutOfBoundsException();
    }

    synchronized int c(int i) {
        int i2 = i + 1;
        int[] iArr = this.e;
        int i3 = this.j;
        if (i2 >= iArr[i3] && i2 < iArr[i3 + 1]) {
            return i3;
        }
        if (i2 < iArr[i3]) {
            this.j = 0;
            while (true) {
                int[] iArr2 = this.e;
                int i4 = this.j;
                if (iArr2[i4 + 1] > i2) {
                    return i4;
                }
                this.j = i4 + 1;
            }
        } else {
            this.j = i3 + 1;
            while (true) {
                int[] iArr3 = this.e;
                int i5 = this.j;
                if (iArr3[i5 + 1] > i2) {
                    return i5;
                }
                this.j = i5 + 1;
            }
        }
    }

    @Override // java.util.AbstractCollection, java.util.Collection, java.util.List
    public int size() {
        return b.e.a.j.b.a(this.f1545c.H().J().s());
    }
}
