package jxl.read.biff;

import jxl.biff.RecordData;
import jxl.common.Logger;
/* loaded from: classes.dex */
public class ButtonPropertySetRecord extends RecordData {
    static /* synthetic */ Class class$jxl$read$biff$ButtonPropertySetRecord;
    private static Logger logger;

    static {
        Class cls = class$jxl$read$biff$ButtonPropertySetRecord;
        if (cls == null) {
            cls = class$("jxl.read.biff.ButtonPropertySetRecord");
            class$jxl$read$biff$ButtonPropertySetRecord = cls;
        }
        logger = Logger.getLogger(cls);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public ButtonPropertySetRecord(Record record) {
        super(record);
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    public byte[] getData() {
        return getRecord().getData();
    }
}
