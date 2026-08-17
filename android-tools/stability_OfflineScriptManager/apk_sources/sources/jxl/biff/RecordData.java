package jxl.biff;

import jxl.read.biff.Record;
/* loaded from: classes.dex */
public abstract class RecordData {
    private int code;
    private Record record;

    /* JADX INFO: Access modifiers changed from: protected */
    public RecordData(Type type) {
        this.code = type.value;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public RecordData(Record record) {
        this.record = record;
        this.code = record.getCode();
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final int getCode() {
        return this.code;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public Record getRecord() {
        return this.record;
    }
}
