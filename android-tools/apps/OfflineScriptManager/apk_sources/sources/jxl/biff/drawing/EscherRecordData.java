package jxl.biff.drawing;

import jxl.biff.IntegerHelper;
import jxl.common.Logger;
/* loaded from: classes.dex */
final class EscherRecordData {
    static /* synthetic */ Class class$jxl$biff$drawing$EscherRecordData;
    private static Logger logger;
    private boolean container;
    private EscherStream escherStream;
    private int instance;
    private int length;
    private int pos;
    private int recordId;
    private int streamLength;
    private EscherRecordType type;
    private int version;

    static {
        Class cls = class$jxl$biff$drawing$EscherRecordData;
        if (cls == null) {
            cls = class$("jxl.biff.drawing.EscherRecordData");
            class$jxl$biff$drawing$EscherRecordData = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public EscherRecordData(EscherRecordType escherRecordType) {
        this.type = escherRecordType;
        this.recordId = escherRecordType.getValue();
    }

    public EscherRecordData(EscherStream escherStream, int i) {
        this.escherStream = escherStream;
        this.pos = i;
        byte[] data = escherStream.getData();
        this.streamLength = data.length;
        int i2 = this.pos;
        int i3 = IntegerHelper.getInt(data[i2], data[i2 + 1]);
        this.instance = (65520 & i3) >> 4;
        this.version = i3 & 15;
        int i4 = this.pos;
        this.recordId = IntegerHelper.getInt(data[i4 + 2], data[i4 + 3]);
        int i5 = this.pos;
        this.length = IntegerHelper.getInt(data[i5 + 4], data[i5 + 5], data[i5 + 6], data[i5 + 7]);
        if (this.version == 15) {
            this.container = true;
        } else {
            this.container = false;
        }
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
        byte[] bArr = new byte[this.length];
        System.arraycopy(this.escherStream.getData(), this.pos + 8, bArr, 0, this.length);
        return bArr;
    }

    EscherStream getDrawingGroup() {
        return this.escherStream;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public EscherStream getEscherStream() {
        return this.escherStream;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int getInstance() {
        return this.instance;
    }

    public int getLength() {
        return this.length;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int getPos() {
        return this.pos;
    }

    public int getRecordId() {
        return this.recordId;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int getStreamLength() {
        return this.streamLength;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public EscherRecordType getType() {
        if (this.type == null) {
            this.type = EscherRecordType.getType(this.recordId);
        }
        return this.type;
    }

    public boolean isContainer() {
        return this.container;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setContainer(boolean z) {
        this.container = z;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public byte[] setHeaderData(byte[] bArr) {
        byte[] bArr2 = new byte[bArr.length + 8];
        System.arraycopy(bArr, 0, bArr2, 8, bArr.length);
        if (this.container) {
            this.version = 15;
        }
        IntegerHelper.getTwoBytes((this.instance << 4) | this.version, bArr2, 0);
        IntegerHelper.getTwoBytes(this.recordId, bArr2, 2);
        IntegerHelper.getFourBytes(bArr.length, bArr2, 4);
        return bArr2;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setInstance(int i) {
        this.instance = i;
    }

    void setLength(int i) {
        this.length = i;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void setVersion(int i) {
        this.version = i;
    }
}
