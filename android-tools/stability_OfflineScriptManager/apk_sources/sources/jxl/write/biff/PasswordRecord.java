package jxl.write.biff;

import jxl.biff.IntegerHelper;
import jxl.biff.Type;
import jxl.biff.WritableRecordData;
/* loaded from: classes.dex */
class PasswordRecord extends WritableRecordData {
    private byte[] data;
    private String password;

    public PasswordRecord(int i) {
        super(Type.PASSWORD);
        byte[] bArr = new byte[2];
        this.data = bArr;
        IntegerHelper.getTwoBytes(i, bArr, 0);
    }

    public PasswordRecord(String str) {
        super(Type.PASSWORD);
        this.password = str;
        if (str == null) {
            byte[] bArr = new byte[2];
            this.data = bArr;
            IntegerHelper.getTwoBytes(0, bArr, 0);
            return;
        }
        byte[] bytes = str.getBytes();
        int i = 0;
        int i2 = 0;
        while (i < bytes.length) {
            byte b2 = bytes[i];
            i++;
            i2 ^= rotLeft15Bit(b2, i);
        }
        byte[] bArr2 = new byte[2];
        this.data = bArr2;
        IntegerHelper.getTwoBytes((bytes.length ^ i2) ^ 52811, bArr2, 0);
    }

    private int rotLeft15Bit(int i, int i2) {
        int i3 = i & 32767;
        while (i2 > 0) {
            int i4 = i3 & 16384;
            i3 = (i3 << 1) & 32767;
            if (i4 != 0) {
                i3++;
            }
            i2--;
        }
        return i3;
    }

    @Override // jxl.biff.WritableRecordData
    public byte[] getData() {
        return this.data;
    }
}
