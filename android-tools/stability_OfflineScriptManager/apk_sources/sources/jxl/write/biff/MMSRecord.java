package jxl.write.biff;

import jxl.biff.Type;
import jxl.biff.WritableRecordData;
/* loaded from: classes.dex */
class MMSRecord extends WritableRecordData {
    private byte[] data;
    private byte numMenuItemsAdded;
    private byte numMenuItemsDeleted;

    public MMSRecord(int i, int i2) {
        super(Type.MMS);
        byte b2 = (byte) i;
        this.numMenuItemsAdded = b2;
        byte b3 = (byte) i2;
        this.numMenuItemsDeleted = b3;
        this.data = r0;
        byte[] bArr = {b2, b3};
    }

    @Override // jxl.biff.WritableRecordData
    public byte[] getData() {
        return this.data;
    }
}
