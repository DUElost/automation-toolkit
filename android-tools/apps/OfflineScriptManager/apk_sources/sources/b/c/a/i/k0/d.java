package b.c.a.i.k0;

import b.c.a.f;
import b.c.a.h;
import b.c.a.i.e;
import java.nio.ByteBuffer;
import java.nio.channels.WritableByteChannel;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public final class d extends b.c.a.i.k0.a implements e {
    private int n;
    private int o;
    private double p;
    private double q;
    private int r;
    private String s;
    private int t;
    private long[] u;

    /* loaded from: classes.dex */
    class a implements b.e.a.e {

        /* renamed from: b  reason: collision with root package name */
        private final /* synthetic */ long f1461b;

        /* renamed from: c  reason: collision with root package name */
        private final /* synthetic */ b.e.a.e f1462c;

        a(d dVar, long j, b.e.a.e eVar) {
            this.f1461b = j;
            this.f1462c = eVar;
        }

        @Override // b.e.a.e, java.io.Closeable, java.lang.AutoCloseable
        public void close() {
            this.f1462c.close();
        }

        @Override // b.e.a.e
        public ByteBuffer j(long j, long j2) {
            return this.f1462c.j(j, j2);
        }

        @Override // b.e.a.e
        public long l() {
            return this.f1462c.l();
        }

        @Override // b.e.a.e
        public long size() {
            return this.f1461b;
        }

        @Override // b.e.a.e
        public void u(long j) {
            this.f1462c.u(j);
        }

        @Override // b.e.a.e
        public int y(ByteBuffer byteBuffer) {
            if (this.f1461b == this.f1462c.l()) {
                return -1;
            }
            if (byteBuffer.remaining() > this.f1461b - this.f1462c.l()) {
                ByteBuffer allocate = ByteBuffer.allocate(b.e.a.j.b.a(this.f1461b - this.f1462c.l()));
                this.f1462c.y(allocate);
                byteBuffer.put((ByteBuffer) allocate.rewind());
                return allocate.capacity();
            }
            return this.f1462c.y(byteBuffer);
        }
    }

    public d() {
        super("avc1");
        this.p = 72.0d;
        this.q = 72.0d;
        this.r = 1;
        this.s = BuildConfig.FLAVOR;
        this.t = 24;
        this.u = new long[3];
    }

    public String G() {
        return this.s;
    }

    public int H() {
        return this.t;
    }

    public int I() {
        return this.r;
    }

    public int J() {
        return this.o;
    }

    public double K() {
        return this.p;
    }

    public double L() {
        return this.q;
    }

    public int M() {
        return this.n;
    }

    public void N(String str) {
        this.s = str;
    }

    public void O(int i) {
        this.t = i;
    }

    public void P(int i) {
        this.r = i;
    }

    public void Q(int i) {
        this.o = i;
    }

    public void R(double d2) {
        this.p = d2;
    }

    public void S(double d2) {
        this.q = d2;
    }

    public void T(int i) {
        this.n = i;
    }

    @Override // b.e.a.b, b.c.a.i.b
    public long a() {
        long B = B() + 78;
        return B + ((this.l || 8 + B >= 4294967296L) ? 16 : 8);
    }

    @Override // b.e.a.b, b.c.a.i.b
    public void b(b.e.a.e eVar, ByteBuffer byteBuffer, long j, b.c.a.b bVar) {
        long l = eVar.l() + j;
        ByteBuffer allocate = ByteBuffer.allocate(78);
        eVar.y(allocate);
        allocate.position(6);
        this.m = b.c.a.e.i(allocate);
        b.c.a.e.i(allocate);
        b.c.a.e.i(allocate);
        this.u[0] = b.c.a.e.k(allocate);
        this.u[1] = b.c.a.e.k(allocate);
        this.u[2] = b.c.a.e.k(allocate);
        this.n = b.c.a.e.i(allocate);
        this.o = b.c.a.e.i(allocate);
        this.p = b.c.a.e.d(allocate);
        this.q = b.c.a.e.d(allocate);
        b.c.a.e.k(allocate);
        this.r = b.c.a.e.i(allocate);
        int n = b.c.a.e.n(allocate);
        if (n > 31) {
            n = 31;
        }
        byte[] bArr = new byte[n];
        allocate.get(bArr);
        this.s = h.a(bArr);
        if (n < 31) {
            allocate.get(new byte[31 - n]);
        }
        this.t = b.c.a.e.i(allocate);
        b.c.a.e.i(allocate);
        C(new a(this, l, eVar), j - 78, bVar);
    }

    @Override // b.e.a.b, b.c.a.i.b
    public void t(WritableByteChannel writableByteChannel) {
        writableByteChannel.write(F());
        ByteBuffer allocate = ByteBuffer.allocate(78);
        allocate.position(6);
        f.e(allocate, this.m);
        f.e(allocate, 0);
        f.e(allocate, 0);
        f.g(allocate, this.u[0]);
        f.g(allocate, this.u[1]);
        f.g(allocate, this.u[2]);
        f.e(allocate, M());
        f.e(allocate, J());
        f.b(allocate, K());
        f.b(allocate, L());
        f.g(allocate, 0L);
        f.e(allocate, I());
        f.j(allocate, h.c(G()));
        allocate.put(h.b(G()));
        int c2 = h.c(G());
        while (c2 < 31) {
            c2++;
            allocate.put((byte) 0);
        }
        f.e(allocate, H());
        f.e(allocate, 65535);
        writableByteChannel.write((ByteBuffer) allocate.rewind());
        h(writableByteChannel);
    }
}
