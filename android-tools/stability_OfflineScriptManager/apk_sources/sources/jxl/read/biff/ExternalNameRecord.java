package jxl.read.biff;

import jxl.WorkbookSettings;
import jxl.biff.IntegerHelper;
import jxl.biff.RecordData;
import jxl.biff.StringHelper;
import jxl.common.Logger;
/* loaded from: classes.dex */
public class ExternalNameRecord extends RecordData {
    static /* synthetic */ Class class$jxl$read$biff$ExternalNameRecord;
    private static Logger logger;
    private boolean addInFunction;
    private String name;

    static {
        Class cls = class$jxl$read$biff$ExternalNameRecord;
        if (cls == null) {
            cls = class$("jxl.read.biff.ExternalNameRecord");
            class$jxl$read$biff$ExternalNameRecord = cls;
        }
        logger = Logger.getLogger(cls);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public ExternalNameRecord(Record record, WorkbookSettings workbookSettings) {
        super(record);
        byte[] data = getRecord().getData();
        if (IntegerHelper.getInt(data[0], data[1]) == 0) {
            this.addInFunction = true;
        }
        if (this.addInFunction) {
            byte b2 = data[6];
            this.name = data[7] != 0 ? StringHelper.getUnicodeString(data, b2, 8) : StringHelper.getString(data, b2, 8, workbookSettings);
        }
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    public String getName() {
        return this.name;
    }

    public boolean isAddInFunction() {
        return this.addInFunction;
    }
}
