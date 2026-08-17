package jxl.biff;

import jxl.read.biff.Record;
/* loaded from: classes.dex */
public class ContinueRecord extends WritableRecordData {
    private byte[] data;

    public ContinueRecord(Record record) {
        super(record);
        this.data = record.getData();
    }

    public ContinueRecord(byte[] bArr) {
        super(Type.CONTINUE);
        this.data = bArr;
    }

    @Override // jxl.biff.WritableRecordData
    public byte[] getData() {
        return this.data;
    }

    @Override // jxl.biff.RecordData
    public Record getRecord() {
        return super.getRecord();
    }
}
