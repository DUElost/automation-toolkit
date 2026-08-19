package jxl.read.biff;

import jxl.biff.IntegerHelper;
import jxl.biff.RecordData;
import jxl.common.Logger;
/* loaded from: classes.dex */
class HideobjRecord extends RecordData {
    static /* synthetic */ Class class$jxl$read$biff$HideobjRecord;
    private static Logger logger;
    private int hidemode;

    static {
        Class cls = class$jxl$read$biff$HideobjRecord;
        if (cls == null) {
            cls = class$("jxl.read.biff.HideobjRecord");
            class$jxl$read$biff$HideobjRecord = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public HideobjRecord(Record record) {
        super(record);
        byte[] data = record.getData();
        this.hidemode = IntegerHelper.getInt(data[0], data[1]);
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    public int getHideMode() {
        return this.hidemode;
    }
}
