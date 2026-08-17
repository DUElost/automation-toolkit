package d;

import java.io.ByteArrayOutputStream;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
/* loaded from: classes.dex */
public class e {

    /* renamed from: a  reason: collision with root package name */
    private d.n.e f2540a;

    /* renamed from: b  reason: collision with root package name */
    private int f2541b;

    /* renamed from: c  reason: collision with root package name */
    private b f2542c;

    /* renamed from: d  reason: collision with root package name */
    private int f2543d;
    private byte[] e;
    private final ByteBuffer f;
    private int g;

    /* loaded from: classes.dex */
    public static final class a extends e {
        private final ByteArrayOutputStream h = new ByteArrayOutputStream();

        @Override // d.e
        public int B() {
            return this.h.size();
        }

        public e D() {
            return new e(this, this.h, null);
        }

        @Override // d.e
        protected e r(int i, byte b2) {
            this.h.write(b2);
            return this;
        }

        @Override // d.e
        public e t(ByteBuffer byteBuffer, int i, int i2) {
            if (byteBuffer == null) {
                return this;
            }
            for (int i3 = i; i3 < i + i2; i3++) {
                this.h.write(byteBuffer.get(i3));
            }
            A(i() + i2);
            return this;
        }

        @Override // d.e
        public e v(byte[] bArr, int i, int i2) {
            if (bArr == null) {
                return this;
            }
            this.h.write(bArr, i, i2);
            A(i() + i2);
            return this;
        }

        @Override // d.e
        public void y(int i) {
            super.y(i);
        }
    }

    /* loaded from: classes.dex */
    enum b {
        DATA,
        DELIMITER;

        /* renamed from: values  reason: to resolve conflict with enum method */
        public static b[] valuesCustom() {
            b[] valuesCustom = values();
            int length = valuesCustom.length;
            b[] bVarArr = new b[length];
            System.arraycopy(valuesCustom, 0, bVarArr, 0, length);
            return bVarArr;
        }
    }

    public e() {
        this(0);
    }

    public e(int i) {
        this.g = 0;
        this.f2542c = b.DATA;
        this.f2541b = 0;
        this.f2543d = i;
        ByteBuffer order = ByteBuffer.wrap(new byte[i]).order(ByteOrder.BIG_ENDIAN);
        this.f = order;
        this.e = order.array();
    }

    private e(e eVar, ByteArrayOutputStream byteArrayOutputStream) {
        this(ByteBuffer.wrap(byteArrayOutputStream.toByteArray()));
        this.f2542c = eVar.f2542c;
        this.f2541b = eVar.f2541b;
    }

    /* synthetic */ e(e eVar, ByteArrayOutputStream byteArrayOutputStream, e eVar2) {
        this(eVar, byteArrayOutputStream);
    }

    public e(ByteBuffer byteBuffer) {
        this.g = 0;
        if (byteBuffer == null) {
            throw new IllegalArgumentException("ByteBuffer cannot be null");
        }
        this.f2542c = b.DATA;
        this.f2541b = 0;
        ByteBuffer duplicate = byteBuffer.duplicate();
        this.f = duplicate;
        if (duplicate.hasArray() && duplicate.position() == 0 && duplicate.limit() == duplicate.capacity()) {
            this.e = duplicate.array();
        } else {
            this.e = null;
        }
        this.f2543d = duplicate.remaining();
    }

    public e(byte[] bArr) {
        this.g = 0;
        bArr = bArr == null ? new byte[0] : bArr;
        this.f2542c = b.DATA;
        this.f2541b = 0;
        this.f2543d = bArr.length;
        this.e = bArr;
        this.f = ByteBuffer.wrap(bArr).order(ByteOrder.BIG_ENDIAN);
    }

    protected final void A(int i) {
        this.g = i;
    }

    public int B() {
        return this.f2543d;
    }

    public void C(ByteBuffer byteBuffer, int i, int i2) {
        int position = this.f.position();
        int limit = this.f.limit();
        this.f.limit(i2 + i).position(i);
        byteBuffer.put(this.f);
        this.f.limit(limit).position(position);
    }

    public ByteBuffer a() {
        return this.f.duplicate();
    }

    public boolean b() {
        return true;
    }

    public byte[] c() {
        if (this.e == null) {
            this.e = new byte[this.f.remaining()];
            this.f.duplicate().get(this.e);
        }
        return this.e;
    }

    public int d() {
        return this.f2541b;
    }

    public byte e(int i) {
        return this.f.get(i);
    }

    public int f(int i, byte[] bArr, int i2, int i3) {
        int min = Math.min(i3, this.f2543d - i);
        byte[] bArr2 = this.e;
        if (bArr2 == null) {
            ByteBuffer duplicate = this.f.duplicate();
            duplicate.position(i);
            duplicate.put(bArr, i2, min);
        } else {
            System.arraycopy(bArr2, i, bArr, i2, min);
        }
        return min;
    }

    public long g(int i) {
        return d.s.g.b(this.f, i);
    }

    public d.n.e h() {
        return this.f2540a;
    }

    protected final int i() {
        return this.g;
    }

    public boolean j() {
        return (this.f2541b & 1) > 0;
    }

    public void k() {
        this.f2542c = b.DELIMITER;
        this.f2540a = null;
        this.f2541b = 0;
    }

    public boolean l() {
        return (this.f2541b & 2) == 2;
    }

    public boolean m() {
        return (this.f2541b & 32) == 32;
    }

    public boolean n() {
        return this.f2542c == b.DELIMITER;
    }

    public boolean o() {
        return (this.f2541b & 64) == 64;
    }

    public e p(byte b2) {
        int i = this.g;
        this.g = i + 1;
        return r(i, b2);
    }

    public e q(int i) {
        int i2 = this.g;
        this.g = i2 + 1;
        return r(i2, (byte) i);
    }

    protected e r(int i, byte b2) {
        this.f.put(i, b2);
        return this;
    }

    public e s(ByteBuffer byteBuffer) {
        ByteBuffer duplicate = this.f.duplicate();
        duplicate.position(this.g);
        this.g += Math.min(duplicate.remaining(), byteBuffer.remaining());
        duplicate.put(byteBuffer);
        return this;
    }

    public e t(ByteBuffer byteBuffer, int i, int i2) {
        if (byteBuffer == null) {
            return this;
        }
        int position = byteBuffer.position();
        int limit = byteBuffer.limit();
        byteBuffer.limit(i2 + i).position(i);
        s(byteBuffer);
        byteBuffer.limit(limit).position(position);
        return this;
    }

    public String toString() {
        return String.format("#zmq.Msg{type=%s, size=%s, flags=%s}", this.f2542c, Integer.valueOf(this.f2543d), Integer.valueOf(this.f2541b));
    }

    public e u(byte[] bArr) {
        return v(bArr, 0, bArr.length);
    }

    public e v(byte[] bArr, int i, int i2) {
        if (bArr == null) {
            return this;
        }
        ByteBuffer duplicate = this.f.duplicate();
        duplicate.position(this.g);
        this.g += i2;
        duplicate.put(bArr, i, i2);
        return this;
    }

    public void w(int i) {
        this.f2541b = (~i) & this.f2541b;
    }

    public void x() {
        z(null);
    }

    public void y(int i) {
        this.f2541b = i | this.f2541b;
    }

    public e z(d.n.e eVar) {
        this.f2540a = eVar;
        return this;
    }
}
