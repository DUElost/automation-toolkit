package jxl.read.biff;

import jxl.biff.IntegerHelper;
import jxl.biff.RecordData;
/* loaded from: classes.dex */
class ProtectRecord extends RecordData {
    private boolean prot;

    /* JADX INFO: Access modifiers changed from: package-private */
    public ProtectRecord(Record record) {
        super(record);
        byte[] data = getRecord().getData();
        this.prot = IntegerHelper.getInt(data[0], data[1]) == 1;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean isProtected() {
        return this.prot;
    }
}
