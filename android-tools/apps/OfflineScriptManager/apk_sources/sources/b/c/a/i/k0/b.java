package b.c.a.i.k0;

import b.c.a.f;
import b.e.a.e;
import java.nio.ByteBuffer;
import java.nio.channels.WritableByteChannel;
/* loaded from: classes.dex */
public final class b extends b.c.a.i.k0.a {
    static final /* synthetic */ boolean A = false;
    private int n;
    private int o;
    private long p;
    private int q;
    private int r;
    private int s;
    private long t;
    private long u;
    private long v;
    private long w;
    private int x;
    private long y;
    private byte[] z;

    /* loaded from: classes.dex */
    class a implements b.c.a.i.b {

        /* renamed from: c  reason: collision with root package name */
        private final /* synthetic */ long f1459c;

        /* renamed from: d  reason: collision with root package name */
        private final /* synthetic */ ByteBuffer f1460d;

        a(long j, ByteBuffer byteBuffer) {
            this.f1459c = j;
            this.f1460d = byteBuffer;
        }

        @Override // b.c.a.i.b
        public long a() {
            return this.f1459c;
        }

        @Override // b.c.a.i.b
        public void b(e eVar, ByteBuffer byteBuffer, long j, b.c.a.b bVar) {
            throw new RuntimeException("NotImplemented");
        }

        @Override // b.c.a.i.b
        public b.c.a.i.e getParent() {
            return b.this;
        }

        @Override // b.c.a.i.b
        public String getType() {
            return "----";
        }

        @Override // b.c.a.i.b
        public void m(b.c.a.i.e eVar) {
            if (!b.A && eVar != b.this) {
                throw new AssertionError("you cannot diswown this special box");
            }
        }

        @Override // b.c.a.i.b
        public void t(WritableByteChannel writableByteChannel) {
            this.f1460d.rewind();
            writableByteChannel.write(this.f1460d);
        }
    }

    public b(String str) {
        super(str);
    }

    public long G() {
        return this.v;
    }

    public long H() {
        return this.u;
    }

    public long I() {
        return this.w;
    }

    public int J() {
        return this.n;
    }

    public int K() {
        return this.r;
    }

    public int L() {
        return this.s;
    }

    public long M() {
        return this.p;
    }

    public int N() {
        return this.o;
    }

    public long O() {
        return this.t;
    }

    public int P() {
        return this.q;
    }

    public byte[] Q() {
        return this.z;
    }

    public void R(long j) {
        this.v = j;
    }

    public void S(long j) {
        this.u = j;
    }

    public void T(long j) {
        this.w = j;
    }

    public void U(int i) {
        this.n = i;
    }

    public void V(int i) {
        this.r = i;
    }

    public void W(int i) {
        this.s = i;
    }

    public void X(long j) {
        this.p = j;
    }

    public void Y(int i) {
        this.o = i;
    }

    public void Z(long j) {
        this.t = j;
    }

    @Override // b.e.a.b, b.c.a.i.b
    public long a() {
        int i = this.q;
        int i2 = 16;
        long B = (i == 1 ? 16 : 0) + 28 + (i == 2 ? 36 : 0) + B();
        if (!this.l && 8 + B < 4294967296L) {
            i2 = 8;
        }
        return B + i2;
    }

    public void a0(int i) {
        this.q = i;
    }

    @Override // b.e.a.b, b.c.a.i.b
    public void b(e eVar, ByteBuffer byteBuffer, long j, b.c.a.b bVar) {
        ByteBuffer allocate = ByteBuffer.allocate(28);
        eVar.y(allocate);
        allocate.position(6);
        this.m = b.c.a.e.i(allocate);
        this.q = b.c.a.e.i(allocate);
        this.x = b.c.a.e.i(allocate);
        this.y = b.c.a.e.k(allocate);
        this.n = b.c.a.e.i(allocate);
        this.o = b.c.a.e.i(allocate);
        this.r = b.c.a.e.i(allocate);
        this.s = b.c.a.e.i(allocate);
        this.p = b.c.a.e.k(allocate);
        if (!this.k.equals("mlpa")) {
            this.p >>>= 16;
        }
        if (this.q == 1) {
            ByteBuffer allocate2 = ByteBuffer.allocate(16);
            eVar.y(allocate2);
            allocate2.rewind();
            this.t = b.c.a.e.k(allocate2);
            this.u = b.c.a.e.k(allocate2);
            this.v = b.c.a.e.k(allocate2);
            this.w = b.c.a.e.k(allocate2);
        }
        if (this.q == 2) {
            ByteBuffer allocate3 = ByteBuffer.allocate(36);
            eVar.y(allocate3);
            allocate3.rewind();
            this.t = b.c.a.e.k(allocate3);
            this.u = b.c.a.e.k(allocate3);
            this.v = b.c.a.e.k(allocate3);
            this.w = b.c.a.e.k(allocate3);
            byte[] bArr = new byte[20];
            this.z = bArr;
            allocate3.get(bArr);
        }
        if (!"owma".equals(this.k)) {
            long j2 = j - 28;
            int i = this.q;
            C(eVar, (j2 - (i != 1 ? 0 : 16)) - (i != 2 ? 0 : 36), bVar);
            return;
        }
        System.err.println("owma");
        long j3 = j - 28;
        int i2 = this.q;
        long j4 = (j3 - (i2 != 1 ? 0 : 16)) - (i2 != 2 ? 0 : 36);
        ByteBuffer allocate4 = ByteBuffer.allocate(b.e.a.j.b.a(j4));
        eVar.y(allocate4);
        v(new a(j4, allocate4));
    }

    public void b0(byte[] bArr) {
        this.z = bArr;
    }

    @Override // b.e.a.b, b.c.a.i.b
    public void t(WritableByteChannel writableByteChannel) {
        writableByteChannel.write(F());
        int i = this.q;
        ByteBuffer allocate = ByteBuffer.allocate((i == 1 ? 16 : 0) + 28 + (i == 2 ? 36 : 0));
        allocate.position(6);
        f.e(allocate, this.m);
        f.e(allocate, this.q);
        f.e(allocate, this.x);
        f.g(allocate, this.y);
        f.e(allocate, this.n);
        f.e(allocate, this.o);
        f.e(allocate, this.r);
        f.e(allocate, this.s);
        f.g(allocate, this.k.equals("mlpa") ? M() : M() << 16);
        if (this.q == 1) {
            f.g(allocate, this.t);
            f.g(allocate, this.u);
            f.g(allocate, this.v);
            f.g(allocate, this.w);
        }
        if (this.q == 2) {
            f.g(allocate, this.t);
            f.g(allocate, this.u);
            f.g(allocate, this.v);
            f.g(allocate, this.w);
            allocate.put(this.z);
        }
        writableByteChannel.write((ByteBuffer) allocate.rewind());
        h(writableByteChannel);
    }

    @Override // b.e.a.d
    public String toString() {
        return "AudioSampleEntry{bytesPerSample=" + this.w + ", bytesPerFrame=" + this.v + ", bytesPerPacket=" + this.u + ", samplesPerPacket=" + this.t + ", packetSize=" + this.s + ", compressionId=" + this.r + ", soundVersion=" + this.q + ", sampleRate=" + this.p + ", sampleSize=" + this.o + ", channelCount=" + this.n + ", boxes=" + e() + '}';
    }
}
