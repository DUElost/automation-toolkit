package jxl.read.biff;

import jxl.WorkbookSettings;
import jxl.biff.RecordData;
import jxl.biff.StringHelper;
import jxl.biff.Type;
/* loaded from: classes.dex */
class WriteAccessRecord extends RecordData {
    private String wauser;

    public WriteAccessRecord(Record record, boolean z, WorkbookSettings workbookSettings) {
        super(Type.WRITEACCESS);
        byte[] data = record.getData();
        this.wauser = z ? StringHelper.getUnicodeString(data, 56, 0) : StringHelper.getString(data, data[1], 1, workbookSettings);
    }

    public String getWriteAccess() {
        return this.wauser;
    }
}
