package jxl.biff;

import jxl.read.biff.Record;
/* loaded from: classes.dex */
public class DataValidityListRecord extends WritableRecordData {
    private byte[] data;
    private DValParser dvalParser;
    private int numSettings;
    private int objectId;

    public DataValidityListRecord(DValParser dValParser) {
        super(Type.DVAL);
        this.dvalParser = dValParser;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public DataValidityListRecord(DataValidityListRecord dataValidityListRecord) {
        super(Type.DVAL);
        this.data = dataValidityListRecord.getData();
    }

    public DataValidityListRecord(Record record) {
        super(record);
        byte[] data = getRecord().getData();
        this.data = data;
        this.objectId = IntegerHelper.getInt(data[10], data[11], data[12], data[13]);
        byte[] bArr = this.data;
        this.numSettings = IntegerHelper.getInt(bArr[14], bArr[15], bArr[16], bArr[17]);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void dvAdded() {
        if (this.dvalParser == null) {
            this.dvalParser = new DValParser(this.data);
        }
        this.dvalParser.dvAdded();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void dvRemoved() {
        if (this.dvalParser == null) {
            this.dvalParser = new DValParser(this.data);
        }
        this.dvalParser.dvRemoved();
    }

    @Override // jxl.biff.WritableRecordData
    public byte[] getData() {
        DValParser dValParser = this.dvalParser;
        return dValParser == null ? this.data : dValParser.getData();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int getNumberOfSettings() {
        return this.numSettings;
    }

    public int getObjectId() {
        DValParser dValParser = this.dvalParser;
        return dValParser == null ? this.objectId : dValParser.getObjectId();
    }

    public boolean hasDVRecords() {
        DValParser dValParser = this.dvalParser;
        return dValParser == null || dValParser.getNumberOfDVRecords() > 0;
    }
}
