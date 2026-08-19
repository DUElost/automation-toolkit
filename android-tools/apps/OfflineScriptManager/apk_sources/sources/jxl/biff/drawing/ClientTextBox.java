package jxl.biff.drawing;

import jxl.common.Logger;
/* loaded from: classes.dex */
class ClientTextBox extends EscherAtom {
    static /* synthetic */ Class class$jxl$biff$drawing$ClientTextBox;
    private static Logger logger;
    private byte[] data;

    static {
        Class cls = class$jxl$biff$drawing$ClientTextBox;
        if (cls == null) {
            cls = class$("jxl.biff.drawing.ClientTextBox");
            class$jxl$biff$drawing$ClientTextBox = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public ClientTextBox() {
        super(EscherRecordType.CLIENT_TEXT_BOX);
    }

    public ClientTextBox(EscherRecordData escherRecordData) {
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
