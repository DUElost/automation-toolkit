package jxl.read.biff;

import jxl.biff.IntegerHelper;
import jxl.biff.RecordData;
import jxl.common.Logger;
/* loaded from: classes.dex */
class SaveRecalcRecord extends RecordData {
    static /* synthetic */ Class class$jxl$read$biff$SaveRecalcRecord;
    private static Logger logger;
    private boolean recalculateOnSave;

    static {
        Class cls = class$jxl$read$biff$SaveRecalcRecord;
        if (cls == null) {
            cls = class$("jxl.read.biff.SaveRecalcRecord");
            class$jxl$read$biff$SaveRecalcRecord = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public SaveRecalcRecord(Record record) {
        super(record);
        byte[] data = record.getData();
        this.recalculateOnSave = IntegerHelper.getInt(data[0], data[1]) == 1;
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    public boolean getRecalculateOnSave() {
        return this.recalculateOnSave;
    }
}
