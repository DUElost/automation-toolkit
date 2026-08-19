package jxl.biff.drawing;

import jxl.common.Logger;
/* loaded from: classes.dex */
class EscherAtom extends EscherRecord {
    static /* synthetic */ Class class$jxl$biff$drawing$EscherAtom;
    private static Logger logger;

    static {
        Class cls = class$jxl$biff$drawing$EscherAtom;
        if (cls == null) {
            cls = class$("jxl.biff.drawing.EscherAtom");
            class$jxl$biff$drawing$EscherAtom = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public EscherAtom(EscherRecordData escherRecordData) {
        super(escherRecordData);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public EscherAtom(EscherRecordType escherRecordType) {
        super(escherRecordType);
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.drawing.EscherRecord
    public byte[] getData() {
        Logger logger2 = logger;
        StringBuffer stringBuffer = new StringBuffer();
        stringBuffer.append("escher atom getData called on object of type ");
        stringBuffer.append(getClass().getName());
        stringBuffer.append(" code ");
        stringBuffer.append(Integer.toString(getType().getValue(), 16));
        logger2.warn(stringBuffer.toString());
        return null;
    }
}
