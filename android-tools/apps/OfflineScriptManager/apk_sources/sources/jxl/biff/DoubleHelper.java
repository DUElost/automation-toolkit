package jxl.biff;
/* loaded from: classes.dex */
public class DoubleHelper {
    private DoubleHelper() {
    }

    public static void getIEEEBytes(double d2, byte[] bArr, int i) {
        long doubleToLongBits = Double.doubleToLongBits(d2);
        bArr[i] = (byte) (255 & doubleToLongBits);
        bArr[i + 1] = (byte) ((65280 & doubleToLongBits) >> 8);
        bArr[i + 2] = (byte) ((16711680 & doubleToLongBits) >> 16);
        bArr[i + 3] = (byte) (((-16777216) & doubleToLongBits) >> 24);
        bArr[i + 4] = (byte) ((1095216660480L & doubleToLongBits) >> 32);
        bArr[i + 5] = (byte) ((280375465082880L & doubleToLongBits) >> 40);
        bArr[i + 6] = (byte) ((71776119061217280L & doubleToLongBits) >> 48);
        bArr[i + 7] = (byte) ((doubleToLongBits & (-72057594037927936L)) >> 56);
    }

    public static double getIEEEDouble(byte[] bArr, int i) {
        int i2;
        int i3 = IntegerHelper.getInt(bArr[i], bArr[i + 1], bArr[i + 2], bArr[i + 3]);
        boolean z = (Integer.MIN_VALUE & IntegerHelper.getInt(bArr[i + 4], bArr[i + 5], bArr[i + 6], bArr[i + 7])) != 0;
        long j = (i2 & Integer.MAX_VALUE) * 4294967296L;
        long j2 = i3;
        if (i3 < 0) {
            j2 += 4294967296L;
        }
        double longBitsToDouble = Double.longBitsToDouble(j + j2);
        return z ? -longBitsToDouble : longBitsToDouble;
    }
}
