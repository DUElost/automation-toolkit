package jxl.read.biff;

import jxl.biff.IntegerHelper;
import jxl.biff.RecordData;
import jxl.common.Logger;
/* loaded from: classes.dex */
class CalcModeRecord extends RecordData {
    static /* synthetic */ Class class$jxl$read$biff$CalcModeRecord;
    private static Logger logger;
    private boolean automatic;

    static {
        Class cls = class$jxl$read$biff$CalcModeRecord;
        if (cls == null) {
            cls = class$("jxl.read.biff.CalcModeRecord");
            class$jxl$read$biff$CalcModeRecord = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public CalcModeRecord(Record record) {
        super(record);
        byte[] data = record.getData();
        this.automatic = IntegerHelper.getInt(data[0], data[1]) == 1;
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    public boolean isAutomatic() {
        return this.automatic;
    }
}
