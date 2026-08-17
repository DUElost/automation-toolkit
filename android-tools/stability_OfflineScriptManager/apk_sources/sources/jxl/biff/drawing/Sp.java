package jxl.biff.drawing;

import jxl.biff.IntegerHelper;
import jxl.common.Logger;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class Sp extends EscherAtom {
    static /* synthetic */ Class class$jxl$biff$drawing$Sp;
    private static Logger logger;
    private byte[] data;
    private int persistenceFlags;
    private int shapeId;
    private int shapeType;

    static {
        Class cls = class$jxl$biff$drawing$Sp;
        if (cls == null) {
            cls = class$("jxl.biff.drawing.Sp");
            class$jxl$biff$drawing$Sp = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public Sp(EscherRecordData escherRecordData) {
        super(escherRecordData);
        this.shapeType = getInstance();
        byte[] bytes = getBytes();
        this.shapeId = IntegerHelper.getInt(bytes[0], bytes[1], bytes[2], bytes[3]);
        this.persistenceFlags = IntegerHelper.getInt(bytes[4], bytes[5], bytes[6], bytes[7]);
    }

    public Sp(ShapeType shapeType, int i, int i2) {
        super(EscherRecordType.SP);
        setVersion(2);
        int value = shapeType.getValue();
        this.shapeType = value;
        this.shapeId = i;
        this.persistenceFlags = i2;
        setInstance(value);
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
        byte[] bArr = new byte[8];
        this.data = bArr;
        IntegerHelper.getFourBytes(this.shapeId, bArr, 0);
        IntegerHelper.getFourBytes(this.persistenceFlags, this.data, 4);
        return setHeaderData(this.data);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int getShapeId() {
        return this.shapeId;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int getShapeType() {
        return this.shapeType;
    }
}
