package jxl.write.biff;

import jxl.biff.IntegerHelper;
import jxl.biff.Type;
import jxl.biff.WritableRecordData;
/* loaded from: classes.dex */
class GuttersRecord extends WritableRecordData {
    private int colGutter;
    private byte[] data;
    private int maxColumnOutline;
    private int maxRowOutline;
    private int rowGutter;

    public GuttersRecord() {
        super(Type.GUTS);
    }

    @Override // jxl.biff.WritableRecordData
    public byte[] getData() {
        byte[] bArr = new byte[8];
        this.data = bArr;
        IntegerHelper.getTwoBytes(this.rowGutter, bArr, 0);
        IntegerHelper.getTwoBytes(this.colGutter, this.data, 2);
        IntegerHelper.getTwoBytes(this.maxRowOutline, this.data, 4);
        IntegerHelper.getTwoBytes(this.maxColumnOutline, this.data, 6);
        return this.data;
    }

    public int getMaxColumnOutline() {
        return this.maxColumnOutline;
    }

    public int getMaxRowOutline() {
        return this.maxRowOutline;
    }

    public void setMaxColumnOutline(int i) {
        this.maxColumnOutline = i;
        this.colGutter = (i * 14) + 1;
    }

    public void setMaxRowOutline(int i) {
        this.maxRowOutline = i;
        this.rowGutter = (i * 14) + 1;
    }
}
