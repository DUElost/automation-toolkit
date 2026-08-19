package b.e.a.i.d.c;

import java.nio.ByteBuffer;
/* loaded from: classes.dex */
public class d {

    /* renamed from: a  reason: collision with root package name */
    int f1566a;

    /* renamed from: b  reason: collision with root package name */
    int f1567b = 0;

    /* renamed from: c  reason: collision with root package name */
    private ByteBuffer f1568c;

    public d(ByteBuffer byteBuffer) {
        this.f1568c = byteBuffer;
        this.f1566a = byteBuffer.position();
    }

    public void a(int i, int i2) {
        int i3 = this.f1567b;
        int i4 = 8 - (i3 % 8);
        if (i2 <= i4) {
            int i5 = this.f1568c.get(this.f1566a + (i3 / 8));
            if (i5 < 0) {
                i5 += 256;
            }
            int i6 = i5 + (i << (i4 - i2));
            ByteBuffer byteBuffer = this.f1568c;
            int i7 = this.f1566a + (this.f1567b / 8);
            if (i6 > 127) {
                i6 -= 256;
            }
            byteBuffer.put(i7, (byte) i6);
            this.f1567b += i2;
        } else {
            int i8 = i2 - i4;
            a(i >> i8, i4);
            a(i & ((1 << i8) - 1), i8);
        }
        ByteBuffer byteBuffer2 = this.f1568c;
        int i9 = this.f1566a;
        int i10 = this.f1567b;
        byteBuffer2.position(i9 + (i10 / 8) + (i10 % 8 <= 0 ? 0 : 1));
    }

    public void b(boolean z) {
        a(z ? 1 : 0, 1);
    }
}
