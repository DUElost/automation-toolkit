package jxl.read.biff;

import jxl.biff.RecordData;
import jxl.common.Logger;
/* loaded from: classes.dex */
class Excel9FileRecord extends RecordData {
    static /* synthetic */ Class class$jxl$read$biff$Excel9FileRecord;
    private static Logger logger;
    private boolean excel9file;

    static {
        Class cls = class$jxl$read$biff$Excel9FileRecord;
        if (cls == null) {
            cls = class$("jxl.read.biff.Excel9FileRecord");
            class$jxl$read$biff$Excel9FileRecord = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public Excel9FileRecord(Record record) {
        super(record);
        this.excel9file = true;
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    public boolean getExcel9File() {
        return this.excel9file;
    }
}
