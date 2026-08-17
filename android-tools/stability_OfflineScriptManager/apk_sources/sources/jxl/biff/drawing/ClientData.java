package jxl.biff.drawing;

import jxl.common.Logger;
/* loaded from: classes.dex */
class ClientData extends EscherAtom {
    static /* synthetic */ Class class$jxl$biff$drawing$ClientData;
    private static Logger logger;
    private byte[] data;

    static {
        Class cls = class$jxl$biff$drawing$ClientData;
        if (cls == null) {
            cls = class$("jxl.biff.drawing.ClientData");
            class$jxl$biff$drawing$ClientData = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public ClientData() {
        super(EscherRecordType.CLIENT_DATA);
    }

    public ClientData(EscherRecordData escherRecordData) {
        super(escherRecordData);
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // jxl.biff.drawing.EscherAtom, jxl.biff.drawing.EscherRecord
    public byte[] getData() {
        byte[] bArr = new byte[0];
        this.data = bArr;
        return setHeaderData(bArr);
    }
}
