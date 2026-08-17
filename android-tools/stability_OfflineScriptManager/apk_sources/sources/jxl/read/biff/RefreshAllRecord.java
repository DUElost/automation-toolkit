package jxl.read.biff;

import jxl.biff.IntegerHelper;
import jxl.biff.RecordData;
import jxl.common.Logger;
/* loaded from: classes.dex */
class RefreshAllRecord extends RecordData {
    static /* synthetic */ Class class$jxl$read$biff$RefreshAllRecord;
    private static Logger logger;
    private boolean refreshAll;

    static {
        Class cls = class$jxl$read$biff$RefreshAllRecord;
        if (cls == null) {
            cls = class$("jxl.read.biff.RefreshAllRecord");
            class$jxl$read$biff$RefreshAllRecord = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public RefreshAllRecord(Record record) {
        super(record);
        byte[] data = record.getData();
        this.refreshAll = IntegerHelper.getInt(data[0], data[1]) == 1;
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    public boolean getRefreshAll() {
        return this.refreshAll;
    }
}
