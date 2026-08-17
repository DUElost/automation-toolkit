package jxl.write.biff;

import jxl.biff.Type;
import jxl.biff.WritableRecordData;
/* loaded from: classes.dex */
class BOFRecord extends WritableRecordData {
    private byte[] data;
    public static final WorkbookGlobalsBOF workbookGlobals = new WorkbookGlobalsBOF();
    public static final SheetBOF sheet = new SheetBOF();

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class SheetBOF {
        private SheetBOF() {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class WorkbookGlobalsBOF {
        private WorkbookGlobalsBOF() {
        }
    }

    public BOFRecord(SheetBOF sheetBOF) {
        super(Type.BOF);
        this.data = new byte[]{0, 6, 16, 0, -14, 21, -52, 7, 0, 0, 0, 0, 6, 0, 0, 0};
    }

    public BOFRecord(WorkbookGlobalsBOF workbookGlobalsBOF) {
        super(Type.BOF);
        this.data = new byte[]{0, 6, 5, 0, -14, 21, -52, 7, 0, 0, 0, 0, 6, 0, 0, 0};
    }

    @Override // jxl.biff.WritableRecordData
    public byte[] getData() {
        return this.data;
    }
}
