package jxl.biff.drawing;

import jxl.biff.Type;
import jxl.biff.WritableRecordData;
import jxl.read.biff.Record;
/* loaded from: classes.dex */
public class MsoDrawingGroupRecord extends WritableRecordData {
    private byte[] data;

    public MsoDrawingGroupRecord(Record record) {
        super(record);
        this.data = record.getData();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public MsoDrawingGroupRecord(byte[] bArr) {
        super(Type.MSODRAWINGGROUP);
        this.data = bArr;
    }

    @Override // jxl.biff.WritableRecordData
    public byte[] getData() {
        return this.data;
    }
}
