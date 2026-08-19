package jxl.write.biff;

import jxl.biff.DoubleHelper;
import jxl.biff.Type;
import jxl.biff.WritableRecordData;
/* loaded from: classes.dex */
abstract class MarginRecord extends WritableRecordData {
    private double margin;

    public MarginRecord(Type type, double d2) {
        super(type);
        this.margin = d2;
    }

    @Override // jxl.biff.WritableRecordData
    public byte[] getData() {
        byte[] bArr = new byte[8];
        DoubleHelper.getIEEEBytes(this.margin, bArr, 0);
        return bArr;
    }
}
