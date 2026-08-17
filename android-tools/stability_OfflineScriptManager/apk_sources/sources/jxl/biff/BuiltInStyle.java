package jxl.biff;
/* loaded from: classes.dex */
class BuiltInStyle extends WritableRecordData {
    private int styleNumber;
    private int xfIndex;

    public BuiltInStyle(int i, int i2) {
        super(Type.STYLE);
        this.xfIndex = i;
        this.styleNumber = i2;
    }

    @Override // jxl.biff.WritableRecordData
    public byte[] getData() {
        IntegerHelper.getTwoBytes(this.xfIndex, r0, 0);
        byte[] bArr = {0, (byte) (bArr[1] | 128), (byte) this.styleNumber, -1};
        return bArr;
    }
}
