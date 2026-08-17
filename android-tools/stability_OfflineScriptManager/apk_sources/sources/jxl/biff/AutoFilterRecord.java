package jxl.biff;

import jxl.common.Logger;
import jxl.read.biff.Record;
/* loaded from: classes.dex */
public class AutoFilterRecord extends WritableRecordData {
    static /* synthetic */ Class class$jxl$biff$AutoFilterRecord;
    private static Logger logger;
    private byte[] data;

    static {
        Class cls = class$jxl$biff$AutoFilterRecord;
        if (cls == null) {
            cls = class$("jxl.biff.AutoFilterRecord");
            class$jxl$biff$AutoFilterRecord = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public AutoFilterRecord(Record record) {
        super(record);
        this.data = getRecord().getData();
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    @Override // jxl.biff.WritableRecordData
    public byte[] getData() {
        return this.data;
    }
}
