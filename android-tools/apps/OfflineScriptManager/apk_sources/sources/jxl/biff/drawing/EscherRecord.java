package jxl.biff.drawing;

import jxl.common.Logger;
/* loaded from: classes.dex */
abstract class EscherRecord {
    protected static final int HEADER_LENGTH = 8;
    static /* synthetic */ Class class$jxl$biff$drawing$EscherRecord;
    private static Logger logger;
    private EscherRecordData data;

    static {
        Class cls = class$jxl$biff$drawing$EscherRecord;
        if (cls == null) {
            cls = class$("jxl.biff.drawing.EscherRecord");
            class$jxl$biff$drawing$EscherRecord = cls;
        }
        logger = Logger.getLogger(cls);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public EscherRecord(EscherRecordData escherRecordData) {
        this.data = escherRecordData;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public EscherRecord(EscherRecordType escherRecordType) {
        this.data = new EscherRecordData(escherRecordType);
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public byte[] getBytes() {
        return this.data.getBytes();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public abstract byte[] getData();

    /* JADX INFO: Access modifiers changed from: protected */
    public EscherRecordData getEscherData() {
        return this.data;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final EscherStream getEscherStream() {
        return this.data.getEscherStream();
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final int getInstance() {
        return this.data.getInstance();
    }

    public int getLength() {
        return this.data.getLength() + 8;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final int getPos() {
        return this.data.getPos();
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public int getStreamLength() {
        return this.data.getStreamLength();
    }

    public EscherRecordType getType() {
        return this.data.getType();
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void setContainer(boolean z) {
        this.data.setContainer(z);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final byte[] setHeaderData(byte[] bArr) {
        return this.data.setHeaderData(bArr);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void setInstance(int i) {
        this.data.setInstance(i);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void setVersion(int i) {
        this.data.setVersion(i);
    }
}
