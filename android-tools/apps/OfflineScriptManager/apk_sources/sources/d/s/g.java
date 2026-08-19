package d.s;

import java.nio.ByteBuffer;
import jxl.SheetSettings;
/* loaded from: classes.dex */
public class g {
    public static int a(ByteBuffer byteBuffer, int i) {
        return (byteBuffer.get(i + 3) & 255) | ((byteBuffer.get(i) & 255) << 24) | ((byteBuffer.get(i + 1) & 255) << 16) | ((byteBuffer.get(i + 2) & 255) << 8);
    }

    public static long b(ByteBuffer byteBuffer, int i) {
        return (byteBuffer.get(i + 7) & 255) | ((byteBuffer.get(i) & 255) << 56) | ((byteBuffer.get(i + 1) & 255) << 48) | ((byteBuffer.get(i + 2) & 255) << 40) | ((byteBuffer.get(i + 3) & 255) << 32) | ((byteBuffer.get(i + 4) & 255) << 24) | ((byteBuffer.get(i + 5) & 255) << 16) | ((byteBuffer.get(i + 6) & 255) << 8);
    }

    public static long c(d.e eVar, int i) {
        return eVar.g(i);
    }

    public static ByteBuffer d(ByteBuffer byteBuffer, int i) {
        byteBuffer.put((byte) ((i >>> 24) & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT));
        byteBuffer.put((byte) ((i >>> 16) & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT));
        byteBuffer.put((byte) ((i >>> 8) & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT));
        byteBuffer.put((byte) (i & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT));
        return byteBuffer;
    }

    public static d.e e(d.e eVar, int i) {
        eVar.p((byte) ((i >>> 24) & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT));
        eVar.p((byte) ((i >>> 16) & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT));
        eVar.p((byte) ((i >>> 8) & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT));
        eVar.p((byte) (i & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT));
        return eVar;
    }

    public static ByteBuffer f(ByteBuffer byteBuffer, long j) {
        byteBuffer.put((byte) ((j >>> 56) & 255));
        byteBuffer.put((byte) ((j >>> 48) & 255));
        byteBuffer.put((byte) ((j >>> 40) & 255));
        byteBuffer.put((byte) ((j >>> 32) & 255));
        byteBuffer.put((byte) ((j >>> 24) & 255));
        byteBuffer.put((byte) ((j >>> 16) & 255));
        byteBuffer.put((byte) ((j >>> 8) & 255));
        byteBuffer.put((byte) (j & 255));
        return byteBuffer;
    }
}
