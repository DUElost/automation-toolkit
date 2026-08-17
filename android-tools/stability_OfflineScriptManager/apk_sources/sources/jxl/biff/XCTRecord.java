package jxl.biff;

import jxl.read.biff.Record;
/* loaded from: classes.dex */
public class XCTRecord extends WritableRecordData {
    public XCTRecord(Record record) {
        super(record);
    }

    @Override // jxl.biff.WritableRecordData
    public byte[] getData() {
        return getRecord().getData();
    }
}
