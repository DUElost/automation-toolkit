package d.s;

import java.nio.ByteBuffer;
/* loaded from: classes.dex */
public class h {

    /* renamed from: a  reason: collision with root package name */
    private static final byte[] f2728a = {0, 68, 0, 84, 83, 82, 72, 0, 75, 76, 70, 65, 0, 63, 62, 69, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 64, 0, 73, 66, 74, 71, 81, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 77, 0, 78, 67, 0, 0, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 79, 0, 80};

    public static byte[] a(String str) {
        if (str.length() % 5 != 0) {
            return null;
        }
        ByteBuffer allocate = ByteBuffer.allocate((str.length() * 4) / 5);
        int length = str.length();
        int i = 0;
        long j = 0;
        int i2 = 0;
        while (i < length) {
            int i3 = i + 1;
            j = (j * 85) + (f2728a[str.charAt(i) - ' '] & 255);
            if (i3 % 5 == 0) {
                int i4 = 16777216;
                while (i4 != 0) {
                    allocate.put(i2, (byte) ((j / i4) % 256));
                    i4 /= 256;
                    i2++;
                }
                j = 0;
            }
            i = i3;
        }
        return allocate.array();
    }
}
