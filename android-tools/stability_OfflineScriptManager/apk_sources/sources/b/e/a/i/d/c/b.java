package b.e.a.i.d.c;

import java.nio.ByteBuffer;
@g(tags = {0})
/* loaded from: classes.dex */
public abstract class b {

    /* renamed from: a  reason: collision with root package name */
    int f1560a;

    /* renamed from: b  reason: collision with root package name */
    int f1561b;

    /* renamed from: c  reason: collision with root package name */
    int f1562c;

    abstract int a();

    public int b() {
        return a() + c() + 1;
    }

    public int c() {
        int a2 = a();
        int i = 0;
        while (true) {
            if (a2 <= 0 && i >= this.f1562c) {
                return i;
            }
            a2 >>>= 7;
            i++;
        }
    }

    public final void d(int i, ByteBuffer byteBuffer) {
        this.f1560a = i;
        int n = b.c.a.e.n(byteBuffer);
        this.f1561b = n & 127;
        int i2 = 1;
        while ((n >>> 7) == 1) {
            n = b.c.a.e.n(byteBuffer);
            i2++;
            this.f1561b = (this.f1561b << 7) | (n & 127);
        }
        this.f1562c = i2;
        ByteBuffer slice = byteBuffer.slice();
        slice.limit(this.f1561b);
        e(slice);
        byteBuffer.position(byteBuffer.position() + this.f1561b);
    }

    public abstract void e(ByteBuffer byteBuffer);

    public void f(ByteBuffer byteBuffer, int i) {
        int position = byteBuffer.position();
        int i2 = 0;
        while (true) {
            if (i <= 0 && i2 >= this.f1562c) {
                byteBuffer.position(position + c());
                return;
            }
            i2++;
            byteBuffer.put((c() + position) - i2, i > 0 ? (byte) (i & 127) : Byte.MIN_VALUE);
            i >>>= 7;
        }
    }

    public String toString() {
        return "BaseDescriptor{tag=" + this.f1560a + ", sizeOfInstance=" + this.f1561b + '}';
    }
}
