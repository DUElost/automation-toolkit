package jxl.read.biff;

import jxl.WorkbookSettings;
import jxl.biff.IntegerHelper;
import jxl.biff.RecordData;
import jxl.biff.StringHelper;
/* loaded from: classes.dex */
public class FooterRecord extends RecordData {
    public static Biff7 biff7 = new Biff7();
    private String footer;

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class Biff7 {
        private Biff7() {
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public FooterRecord(Record record, WorkbookSettings workbookSettings) {
        super(record);
        byte[] data = getRecord().getData();
        if (data.length == 0) {
            return;
        }
        int i = IntegerHelper.getInt(data[0], data[1]);
        this.footer = data[2] == 1 ? StringHelper.getUnicodeString(data, i, 3) : StringHelper.getString(data, i, 3, workbookSettings);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public FooterRecord(Record record, WorkbookSettings workbookSettings, Biff7 biff72) {
        super(record);
        byte[] data = getRecord().getData();
        if (data.length == 0) {
            return;
        }
        this.footer = StringHelper.getString(data, data[0], 1, workbookSettings);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public String getFooter() {
        return this.footer;
    }
}
