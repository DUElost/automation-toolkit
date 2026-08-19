package b.e.a.i.d.c;

import java.nio.ByteBuffer;
import jxl.SheetSettings;
/* loaded from: classes.dex */
public class c {

    /* renamed from: a  reason: collision with root package name */
    int f1563a;

    /* renamed from: b  reason: collision with root package name */
    int f1564b;

    /* renamed from: c  reason: collision with root package name */
    private ByteBuffer f1565c;

    public c(ByteBuffer byteBuffer) {
        this.f1565c = byteBuffer;
        this.f1563a = byteBuffer.position();
    }

    public int a(int i) {
        int a2;
        int i2 = this.f1565c.get(this.f1563a + (this.f1564b / 8));
        if (i2 < 0) {
            i2 += 256;
        }
        int i3 = this.f1564b;
        int i4 = 8 - (i3 % 8);
        if (i <= i4) {
            a2 = ((i2 << (i3 % 8)) & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT) >> ((i3 % 8) + (i4 - i));
            this.f1564b = i3 + i;
        } else {
            int i5 = i - i4;
            a2 = (a(i4) << i5) + a(i5);
        }
        this.f1565c.position(this.f1563a + ((int) Math.ceil(this.f1564b / 8.0d)));
        return a2;
    }

    public boolean b() {
        return a(1) == 1;
    }

    public int c() {
        return (this.f1565c.limit() * 8) - this.f1564b;
    }
}
