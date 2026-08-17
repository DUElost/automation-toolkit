package jxl.write.biff;

import jxl.biff.Type;
import jxl.biff.WritableRecordData;
import jxl.common.Logger;
/* loaded from: classes.dex */
class ArbitraryRecord extends WritableRecordData {
    static /* synthetic */ Class class$jxl$write$biff$ArbitraryRecord;
    private static Logger logger;
    private byte[] data;

    static {
        Class cls = class$jxl$write$biff$ArbitraryRecord;
        if (cls == null) {
            cls = class$("jxl.write.biff.ArbitraryRecord");
            class$jxl$write$biff$ArbitraryRecord = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public ArbitraryRecord(int i, byte[] bArr) {
        super(Type.createType(i));
        this.data = bArr;
        Logger logger2 = logger;
        StringBuffer stringBuffer = new StringBuffer();
        stringBuffer.append("ArbitraryRecord of type ");
        stringBuffer.append(i);
        stringBuffer.append(" created");
        logger2.warn(stringBuffer.toString());
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
