package jxl.read.biff;

import jxl.biff.IntegerHelper;
import jxl.biff.RecordData;
import jxl.common.Logger;
/* loaded from: classes.dex */
class WindowProtectedRecord extends RecordData {
    static /* synthetic */ Class class$jxl$read$biff$WindowProtectedRecord;
    private static Logger logger;
    private boolean windowProtected;

    static {
        Class cls = class$jxl$read$biff$WindowProtectedRecord;
        if (cls == null) {
            cls = class$("jxl.read.biff.WindowProtectedRecord");
            class$jxl$read$biff$WindowProtectedRecord = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public WindowProtectedRecord(Record record) {
        super(record);
        byte[] data = record.getData();
        this.windowProtected = IntegerHelper.getInt(data[0], data[1]) == 1;
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    public boolean getWindowProtected() {
        return this.windowProtected;
    }
}
