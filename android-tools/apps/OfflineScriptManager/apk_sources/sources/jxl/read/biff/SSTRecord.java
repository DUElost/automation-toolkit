package jxl.read.biff;

import jxl.WorkbookSettings;
import jxl.biff.IntegerHelper;
import jxl.biff.RecordData;
import jxl.biff.StringHelper;
import jxl.common.Assert;
/* loaded from: classes.dex */
class SSTRecord extends RecordData {
    private int[] continuationBreaks;
    private String[] strings;
    private int totalStrings;
    private int uniqueStrings;

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class BooleanHolder {
        public boolean value;

        private BooleanHolder() {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class ByteArrayHolder {
        public byte[] bytes;

        private ByteArrayHolder() {
        }
    }

    public SSTRecord(Record record, Record[] recordArr, WorkbookSettings workbookSettings) {
        super(record);
        int i = 0;
        for (Record record2 : recordArr) {
            i += record2.getLength();
        }
        byte[] bArr = new byte[i + getRecord().getLength()];
        System.arraycopy(getRecord().getData(), 0, bArr, 0, getRecord().getLength());
        int length = getRecord().getLength() + 0;
        this.continuationBreaks = new int[recordArr.length];
        for (int i2 = 0; i2 < recordArr.length; i2++) {
            Record record3 = recordArr[i2];
            System.arraycopy(record3.getData(), 0, bArr, length, record3.getLength());
            this.continuationBreaks[i2] = length;
            length += record3.getLength();
        }
        this.totalStrings = IntegerHelper.getInt(bArr[0], bArr[1], bArr[2], bArr[3]);
        int i3 = IntegerHelper.getInt(bArr[4], bArr[5], bArr[6], bArr[7]);
        this.uniqueStrings = i3;
        this.strings = new String[i3];
        readStrings(bArr, 8, workbookSettings);
    }

    private int getChars(byte[] bArr, ByteArrayHolder byteArrayHolder, int i, BooleanHolder booleanHolder, int i2) {
        int[] iArr;
        if (booleanHolder.value) {
            byteArrayHolder.bytes = new byte[i2];
        } else {
            byteArrayHolder.bytes = new byte[i2 * 2];
        }
        boolean z = false;
        int i3 = 0;
        while (true) {
            iArr = this.continuationBreaks;
            if (i3 >= iArr.length || z) {
                break;
            }
            z = i <= iArr[i3] && byteArrayHolder.bytes.length + i > iArr[i3];
            if (!z) {
                i3++;
            }
        }
        if (z) {
            int i4 = iArr[i3] - i;
            System.arraycopy(bArr, i, byteArrayHolder.bytes, 0, i4);
            return i4 + getContinuedString(bArr, byteArrayHolder, i4, i3, booleanHolder, i2 - (booleanHolder.value ? i4 : i4 / 2));
        }
        byte[] bArr2 = byteArrayHolder.bytes;
        System.arraycopy(bArr, i, bArr2, 0, bArr2.length);
        return byteArrayHolder.bytes.length;
    }

    private int getContinuedString(byte[] bArr, ByteArrayHolder byteArrayHolder, int i, int i2, BooleanHolder booleanHolder, int i3) {
        int min;
        int i4 = i2;
        int i5 = i3;
        int i6 = this.continuationBreaks[i2];
        int i7 = 0;
        int i8 = i;
        while (i5 > 0) {
            Assert.verify(i4 < this.continuationBreaks.length, "continuation break index");
            boolean z = booleanHolder.value;
            if (z && bArr[i6] == 0) {
                int[] iArr = this.continuationBreaks;
                int min2 = i4 == iArr.length - 1 ? i5 : Math.min(i5, (iArr[i4 + 1] - i6) - 1);
                System.arraycopy(bArr, i6 + 1, byteArrayHolder.bytes, i8, min2);
                i8 += min2;
                i7 += min2 + 1;
                i5 -= min2;
                booleanHolder.value = true;
            } else {
                if (!z && bArr[i6] != 0) {
                    int[] iArr2 = this.continuationBreaks;
                    int min3 = i4 == iArr2.length - 1 ? i5 * 2 : Math.min(i5 * 2, (iArr2[i4 + 1] - i6) - 1);
                    System.arraycopy(bArr, i6 + 1, byteArrayHolder.bytes, i8, min3);
                    i8 += min3;
                    i7 += min3 + 1;
                    min = min3 / 2;
                } else if (z || bArr[i6] != 0) {
                    byte[] bArr2 = byteArrayHolder.bytes;
                    int i9 = i8 * 2;
                    int i10 = i5 * 2;
                    byteArrayHolder.bytes = new byte[i9 + i10];
                    for (int i11 = 0; i11 < i8; i11++) {
                        byteArrayHolder.bytes[i11 * 2] = bArr2[i11];
                    }
                    int[] iArr3 = this.continuationBreaks;
                    if (i4 != iArr3.length - 1) {
                        i10 = Math.min(i10, (iArr3[i4 + 1] - i6) - 1);
                    }
                    System.arraycopy(bArr, i6 + 1, byteArrayHolder.bytes, i9, i10);
                    i7 += i10 + 1;
                    i5 -= i10 / 2;
                    booleanHolder.value = false;
                    i8 = i9 + i10;
                } else {
                    int[] iArr4 = this.continuationBreaks;
                    min = i4 == iArr4.length - 1 ? i5 : Math.min(i5, (iArr4[i4 + 1] - i6) - 1);
                    for (int i12 = 0; i12 < min; i12++) {
                        byteArrayHolder.bytes[i8] = bArr[i6 + i12 + 1];
                        i8 += 2;
                    }
                    i7 += min + 1;
                }
                i5 -= min;
                booleanHolder.value = false;
            }
            i4++;
            int[] iArr5 = this.continuationBreaks;
            if (i4 < iArr5.length) {
                i6 = iArr5[i4];
            }
        }
        return i7;
    }

    private void readStrings(byte[] bArr, int i, WorkbookSettings workbookSettings) {
        int i2 = i;
        int i3 = 0;
        int i4 = 0;
        int i5 = 0;
        while (i5 < this.uniqueStrings) {
            int i6 = IntegerHelper.getInt(bArr[i2], bArr[i2 + 1]);
            int i7 = i2 + 2;
            byte b2 = bArr[i7];
            int i8 = i7 + 1;
            boolean z = (b2 & 4) != 0;
            boolean z2 = (b2 & 8) != 0;
            if (z2) {
                i3 = IntegerHelper.getInt(bArr[i8], bArr[i8 + 1]);
                i8 += 2;
            }
            int i9 = i3;
            if (z) {
                i4 = IntegerHelper.getInt(bArr[i8], bArr[i8 + 1], bArr[i8 + 2], bArr[i8 + 3]);
                i8 += 4;
            }
            int i10 = i8;
            int i11 = i4;
            boolean z3 = (b2 & 1) == 0;
            ByteArrayHolder byteArrayHolder = new ByteArrayHolder();
            BooleanHolder booleanHolder = new BooleanHolder();
            booleanHolder.value = z3;
            int chars = i10 + getChars(bArr, byteArrayHolder, i10, booleanHolder, i6);
            this.strings[i5] = booleanHolder.value ? StringHelper.getString(byteArrayHolder.bytes, i6, 0, workbookSettings) : StringHelper.getUnicodeString(byteArrayHolder.bytes, i6, 0);
            if (z2) {
                chars += i9 * 4;
            }
            if (z) {
                chars += i11;
            }
            i2 = chars;
            if (i2 > bArr.length) {
                Assert.verify(false, "pos exceeds record length");
            }
            i5++;
            i3 = i9;
            i4 = i11;
        }
    }

    public String getString(int i) {
        Assert.verify(i < this.uniqueStrings);
        return this.strings[i];
    }
}
