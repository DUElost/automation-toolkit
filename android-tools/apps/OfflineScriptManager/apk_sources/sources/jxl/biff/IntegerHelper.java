package jxl.biff;

import jxl.SheetSettings;
/* loaded from: classes.dex */
public final class IntegerHelper {
    private IntegerHelper() {
    }

    public static void getFourBytes(int i, byte[] bArr, int i2) {
        byte[] fourBytes = getFourBytes(i);
        bArr[i2] = fourBytes[0];
        bArr[i2 + 1] = fourBytes[1];
        bArr[i2 + 2] = fourBytes[2];
        bArr[i2 + 3] = fourBytes[3];
    }

    public static byte[] getFourBytes(int i) {
        byte[] bArr = new byte[4];
        getTwoBytes(65535 & i, bArr, 0);
        getTwoBytes((i & (-65536)) >> 16, bArr, 2);
        return bArr;
    }

    public static int getInt(byte b2, byte b3) {
        return (b2 & 255) | ((b3 & 255) << 8);
    }

    public static int getInt(byte b2, byte b3, byte b4, byte b5) {
        return getInt(b2, b3) | (getInt(b4, b5) << 16);
    }

    public static short getShort(byte b2, byte b3) {
        return (short) (((short) (b2 & 255)) | (((short) (b3 & 255)) << 8));
    }

    public static void getTwoBytes(int i, byte[] bArr, int i2) {
        bArr[i2] = (byte) (i & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT);
        bArr[i2 + 1] = (byte) ((i & 65280) >> 8);
    }

    public static byte[] getTwoBytes(int i) {
        return new byte[]{(byte) (i & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT), (byte) ((i & 65280) >> 8)};
    }
}
