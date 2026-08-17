package jxl.read.biff;

import jxl.WorkbookSettings;
import jxl.biff.IntegerHelper;
import jxl.biff.RecordData;
import jxl.biff.StringHelper;
import jxl.common.Logger;
/* loaded from: classes.dex */
public class HeaderRecord extends RecordData {
    public static Biff7 biff7;
    static /* synthetic */ Class class$jxl$read$biff$HeaderRecord;
    private static Logger logger;
    private String header;

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class Biff7 {
        private Biff7() {
        }
    }

    static {
        Class cls = class$jxl$read$biff$HeaderRecord;
        if (cls == null) {
            cls = class$("jxl.read.biff.HeaderRecord");
            class$jxl$read$biff$HeaderRecord = cls;
        }
        logger = Logger.getLogger(cls);
        biff7 = new Biff7();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public HeaderRecord(Record record, WorkbookSettings workbookSettings) {
        super(record);
        byte[] data = getRecord().getData();
        if (data.length == 0) {
            return;
        }
        int i = IntegerHelper.getInt(data[0], data[1]);
        this.header = data[2] == 1 ? StringHelper.getUnicodeString(data, i, 3) : StringHelper.getString(data, i, 3, workbookSettings);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public HeaderRecord(Record record, WorkbookSettings workbookSettings, Biff7 biff72) {
        super(record);
        byte[] data = getRecord().getData();
        if (data.length == 0) {
            return;
        }
        this.header = StringHelper.getString(data, data[0], 1, workbookSettings);
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public String getHeader() {
        return this.header;
    }
}
