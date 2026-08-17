package b.c.a;

import java.nio.ByteBuffer;
import jxl.SheetSettings;
/* loaded from: classes.dex */
public final class f {
    public static void a(ByteBuffer byteBuffer, double d2) {
        int i = (int) (d2 * 1.073741824E9d);
        byteBuffer.put((byte) (((-16777216) & i) >> 24));
        byteBuffer.put((byte) ((16711680 & i) >> 16));
        byteBuffer.put((byte) ((65280 & i) >> 8));
        byteBuffer.put((byte) (i & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT));
    }

    public static void b(ByteBuffer byteBuffer, double d2) {
        int i = (int) (d2 * 65536.0d);
        byteBuffer.put((byte) (((-16777216) & i) >> 24));
        byteBuffer.put((byte) ((16711680 & i) >> 16));
        byteBuffer.put((byte) ((65280 & i) >> 8));
        byteBuffer.put((byte) (i & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT));
    }

    public static void c(ByteBuffer byteBuffer, double d2) {
        short s = (short) (d2 * 256.0d);
        byteBuffer.put((byte) ((65280 & s) >> 8));
        byteBuffer.put((byte) (s & 255));
    }

    public static void d(ByteBuffer byteBuffer, String str) {
        if (str.getBytes().length != 3) {
            throw new IllegalArgumentException("\"" + str + "\" language string isn't exactly 3 characters long!");
        }
        int i = 0;
        for (int i2 = 0; i2 < 3; i2++) {
            i += (str.getBytes()[i2] - 96) << ((2 - i2) * 5);
        }
        e(byteBuffer, i);
    }

    public static void e(ByteBuffer byteBuffer, int i) {
        int i2 = i & 65535;
        j(byteBuffer, i2 >> 8);
        j(byteBuffer, i2 & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT);
    }

    public static void f(ByteBuffer byteBuffer, int i) {
        int i2 = i & 16777215;
        e(byteBuffer, i2 >> 8);
        j(byteBuffer, i2);
    }

    public static void g(ByteBuffer byteBuffer, long j) {
        byteBuffer.putInt((int) j);
    }

    public static void h(ByteBuffer byteBuffer, long j) {
        long j2 = j & 281474976710655L;
        e(byteBuffer, (int) (j2 >> 32));
        g(byteBuffer, j2 & 4294967295L);
    }

    public static void i(ByteBuffer byteBuffer, long j) {
        byteBuffer.putLong(j);
    }

    public static void j(ByteBuffer byteBuffer, int i) {
        byteBuffer.put((byte) (i & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT));
    }

    public static void k(ByteBuffer byteBuffer, String str) {
        byteBuffer.put(h.b(str));
        j(byteBuffer, 0);
    }
}
